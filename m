From: rusty@rustcorp.com.au
Subject: [patch 41/43] lguest: Update example launcher for virtio
Date: Wed, 26 Sep 2007 16:36:59 +1000
Message-ID: <20070926063652.556745339@rustcorp.com.au>
References: <20070926063618.956228976@rustcorp.com.au>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=new-io-lguest-new-launcher.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lguest@ozlabs.org
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Implements virtio-based console, network and block servers.  The block
server uses a thread so it's async, which is an improvement over the
old synchronous implementation (but a little more complex).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c | 1201 ++++++++++++++++++++++++-----------------
 1 file changed, 711 insertions(+), 490 deletions(-)

diff -r a7242b81747f Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c	Wed Sep 26 14:48:31 2007 +1000
+++ b/Documentation/lguest/lguest.c	Wed Sep 26 15:24:32 2007 +1000
@@ -32,7 +32,9 @@
 #include <termios.h>
 #include <getopt.h>
 #include <zlib.h>
-/*L:110 We can ignore the 28 include files we need for this program, but I do
+#include <assert.h>
+#include <sched.h>
+/*L:110 We can ignore the 30 include files we need for this program, but I do
  * want to draw attention to the use of kernel-style types.
  *
  * As Linus said, "C is a Spartan language, and so should your naming be."  I
@@ -44,6 +46,12 @@ typedef uint16_t u16;
 typedef uint16_t u16;
 typedef uint8_t u8;
 #include "linux/lguest_launcher.h"
+#include "linux/pci_ids.h"
+#include "linux/virtio_config.h"
+#include "linux/virtio_net.h"
+#include "linux/virtio_blk.h"
+#include "linux/virtio_console.h"
+#include "linux/virtio_ring.h"
 #include "asm/e820.h"
 /*:*/
 
@@ -55,6 +63,8 @@ typedef uint8_t u8;
 #endif
 /* We can have up to 256 pages for devices. */
 #define DEVICE_PAGES 256
+/* This fits nicely in a single 4096-byte page. */
+#define VIRTQUEUE_NUM 127
 
 /*L:120 verbose is both a global flag and a macro.  The C preprocessor allows
  * this, and although I wouldn't recommend it, it works quite nicely here. */
@@ -78,8 +88,17 @@ struct device_list
 	fd_set infds;
 	int max_infd;
 
+	/* Counter to assign interrupt numbers. */
+	unsigned int next_irq;
+
+	/* Counter to print out convenient device numbers. */
+	unsigned int device_num;
+
 	/* The descriptor page for the devices. */
-	struct lguest_device_desc *descs;
+	u8 *descpage;
+
+	/* The tail of the last descriptor. */
+	unsigned int desc_used;
 
 	/* A single linked list of devices. */
 	struct device *dev;
@@ -87,30 +106,87 @@ struct device_list
 	struct device **lastdev;
 };
 
+/* The list of Guest devices, based on command line arguments. */
+static struct device_list devices;
+
 /* The device structure describes a single device. */
 struct device
 {
 	/* The linked-list pointer. */
 	struct device *next;
-	/* The descriptor for this device, as mapped into the Guest. */
+
+	/* The this device's descriptor, as mapped into the Guest. */
 	struct lguest_device_desc *desc;
-	/* The memory page(s) of this device, if any.  Also mapped in Guest. */
-	void *mem;
+
+	/* The name of this device, for --verbose. */
+	const char *name;
 
 	/* If handle_input is set, it wants to be called when this file
 	 * descriptor is ready. */
 	int fd;
 	bool (*handle_input)(int fd, struct device *me);
 
-	/* If handle_output is set, it wants to be called when the Guest sends
-	 * DMA to this key. */
-	unsigned long watch_key;
-	u32 (*handle_output)(int fd, const struct iovec *iov,
-			     unsigned int num, struct device *me);
+	/* Any queues attached to this device */
+	struct virtqueue *vq;
 
 	/* Device-specific data. */
 	void *priv;
 };
+
+/* The virtqueue structure describes a queue attached to a device. */
+struct virtqueue
+{
+	struct virtqueue *next;
+
+	/* Which device owns me. */
+	struct device *dev;
+
+	/* The configuration for this queue. */
+	struct lguest_vqconfig config;
+
+	/* The actual ring of buffers. */
+	struct vring vring;
+
+	/* Last available index we saw. */
+	u16 last_avail_idx;
+
+	/* The routine to call when the Guest pings us. */
+	void (*handle_output)(int fd, struct virtqueue *me);
+};
+
+/* Since guest is UP and we don't run at the same time, we don't need barriers.
+ * But I include them in the code in case others copy it. */
+#define wmb()
+
+/* Convert an iovec element to the given type.
+ *
+ * This is a fairly ugly trick: we need to know the size of the type and
+ * alignment requirement to check the pointer is kosher.  It's also nice to
+ * have the name of the type in case we report failure.
+ *
+ * Typing those three things all the time is cumbersome and error prone, so we
+ * have a macro which sets them all up and passes to the real function. */
+#define convert(iov, type) \
+	((type *)_convert((iov), sizeof(type), __alignof__(type), #type))
+
+static void *_convert(struct iovec *iov, size_t size, size_t align,
+		      const char *name)
+{
+	if (iov->iov_len != size)
+		errx(1, "Bad iovec size %zu for %s", iov->iov_len, name);
+	if ((unsigned long)iov->iov_base % align != 0)
+		errx(1, "Bad alignment %p for %s", iov->iov_base, name);
+	return iov->iov_base;
+}
+
+/* The virtio configuration space is defined to be little-endian.  x86 is
+ * little-endian too, but it's nice to be explicit so we have these helpers. */
+#define cpu_to_le16(v16) (v16)
+#define cpu_to_le32(v32) (v32)
+#define cpu_to_le64(v64) (v64)
+#define le16_to_cpu(v16) (v16)
+#define le32_to_cpu(v32) (v32)
+#define le64_to_cpu(v32) (v64)
 
 /*L:100 The Launcher code itself takes us out into userspace, that scary place
  * where pointers run wild and free!  Unfortunately, like most userspace
@@ -486,11 +562,11 @@ static int tell_kernel(unsigned long pgd
 }
 /*:*/
 
-static void set_fd(int fd, struct device_list *devices)
-{
-	FD_SET(fd, &devices->infds);
-	if (fd > devices->max_infd)
-		devices->max_infd = fd;
+static void add_device_fd(int fd)
+{
+	FD_SET(fd, &devices.infds);
+	if (fd > devices.max_infd)
+		devices.max_infd = fd;
 }
 
 /*L:200
@@ -508,18 +584,18 @@ static void set_fd(int fd, struct device
  *
  * This, of course, is merely a different *kind* of icky.
  */
-static void wake_parent(int pipefd, int lguest_fd, struct device_list *devices)
+static void wake_parent(int pipefd, int lguest_fd)
 {
 	/* Add the pipe from the Launcher to the fdset in the device_list, so
 	 * we watch it, too. */
-	set_fd(pipefd, devices);
+	add_device_fd(pipefd);
 
 	for (;;) {
-		fd_set rfds = devices->infds;
+		fd_set rfds = devices.infds;
 		unsigned long args[] = { LHREQ_BREAK, 1 };
 
 		/* Wait until input is ready from one of the devices. */
-		select(devices->max_infd+1, &rfds, NULL, NULL, NULL);
+		select(devices.max_infd+1, &rfds, NULL, NULL, NULL);
 		/* Is it a message from the Launcher? */
 		if (FD_ISSET(pipefd, &rfds)) {
 			int ignorefd;
@@ -530,14 +606,14 @@ static void wake_parent(int pipefd, int 
 			/* Otherwise it's telling us there's a problem with one
 			 * of the devices, and we should ignore that file
 			 * descriptor from now on. */
-			FD_CLR(ignorefd, &devices->infds);
+			FD_CLR(ignorefd, &devices.infds);
 		} else /* Send LHREQ_BREAK command. */
 			write(lguest_fd, args, sizeof(args));
 	}
 }
 
 /* This routine just sets up a pipe to the Waker process. */
-static int setup_waker(int lguest_fd, struct device_list *device_list)
+static int setup_waker(int lguest_fd)
 {
 	int pipefd[2], child;
 
@@ -551,7 +627,7 @@ static int setup_waker(int lguest_fd, st
 	if (child == 0) {
 		/* Close the "writing" end of our copy of the pipe */
 		close(pipefd[1]);
-		wake_parent(pipefd[0], lguest_fd, device_list);
+		wake_parent(pipefd[0], lguest_fd);
 	}
 	/* Close the reading end of our copy of the pipe. */
 	close(pipefd[0]);
@@ -574,71 +650,13 @@ static void *_check_pointer(unsigned lon
 	/* We have to separately check addr and addr+size, because size could
 	 * be huge and addr + size might wrap around. */
 	if (addr >= guest_limit || addr + size >= guest_limit)
-		errx(1, "%s:%i: Invalid address %li", __FILE__, line, addr);
+		errx(1, "%s:%i: Invalid address %#lx", __FILE__, line, addr);
 	/* We return a pointer for the caller's convenience, now we know it's
 	 * safe to use. */
 	return from_guest_phys(addr);
 }
 /* A macro which transparently hands the line number to the real function. */
 #define check_pointer(addr,size) _check_pointer(addr, size, __LINE__)
-
-/* The Guest has given us the address of a "struct lguest_dma".  We check it's
- * OK and convert it to an iovec (which is a simple array of ptr/size
- * pairs). */
-static u32 *dma2iov(unsigned long dma, struct iovec iov[], unsigned *num)
-{
-	unsigned int i;
-	struct lguest_dma *udma;
-
-	/* First we make sure that the array memory itself is valid. */
-	udma = check_pointer(dma, sizeof(*udma));
-	/* Now we check each element */
-	for (i = 0; i < LGUEST_MAX_DMA_SECTIONS; i++) {
-		/* A zero length ends the array. */
-		if (!udma->len[i])
-			break;
-
-		iov[i].iov_base = check_pointer(udma->addr[i], udma->len[i]);
-		iov[i].iov_len = udma->len[i];
-	}
-	*num = i;
-
-	/* We return the pointer to where the caller should write the amount of
-	 * the buffer used. */
-	return &udma->used_len;
-}
-
-/* This routine gets a DMA buffer from the Guest for a given key, and converts
- * it to an iovec array.  It returns the interrupt the Guest wants when we're
- * finished, and a pointer to the "used_len" field to fill in. */
-static u32 *get_dma_buffer(int fd, void *key,
-			   struct iovec iov[], unsigned int *num, u32 *irq)
-{
-	unsigned long buf[] = { LHREQ_GETDMA, to_guest_phys(key) };
-	unsigned long udma;
-	u32 *res;
-
-	/* Ask the kernel for a DMA buffer corresponding to this key. */
-	udma = write(fd, buf, sizeof(buf));
-	/* They haven't registered any, or they're all used? */
-	if (udma == (unsigned long)-1)
-		return NULL;
-
-	/* Convert it into our iovec array */
-	res = dma2iov(udma, iov, num);
-	/* The kernel stashes irq in ->used_len to get it out to us. */
-	*irq = *res;
-	/* Return a pointer to ((struct lguest_dma *)udma)->used_len. */
-	return res;
-}
-
-/* This is a convenient routine to send the Guest an interrupt. */
-static void trigger_irq(int fd, u32 irq)
-{
-	unsigned long buf[] = { LHREQ_IRQ, irq };
-	if (write(fd, buf, sizeof(buf)) != 0)
-		err(1, "Triggering irq %i", irq);
-}
 
 /* This simply sets up an iovec array where we can put data to be discarded.
  * This happens when the Guest doesn't want or can't handle the input: we have
@@ -652,6 +670,121 @@ static void discard_iovec(struct iovec *
 	iov->iov_len = sizeof(discard_buf);
 }
 
+/* This function returns the next descriptor in the chain, or vq->vring.num. */
+static unsigned next_desc(struct virtqueue *vq, unsigned int i)
+{
+	unsigned int next;
+
+	/* If this descriptor says it doesn't chain, we're done. */
+	if (!(vq->vring.desc[i].flags & VRING_DESC_F_NEXT))
+		return vq->vring.num;
+
+	/* Check they're not leading us off end of descriptors. */
+	next = vq->vring.desc[i].next;
+	/* Make sure compiler knows to grab that: we don't want it changing! */
+	wmb();
+
+	if (next >= vq->vring.num)
+		errx(1, "Desc next is %u", next);
+
+	return next;
+}
+
+/* This looks in the virtqueue and for the first available buffer, and converts
+ * it to an iovec for convenient access.  Since descriptors consist of some
+ * number of output then some number of input descriptors, it's actually two
+ * iovecs, but we pack them into one and note how many of each there were.
+ *
+ * This function returns the descriptor number found, or vq->vring.num (which
+ * is never a valid descriptor number) if none was found. */
+static unsigned get_vq_desc(struct virtqueue *vq,
+			    struct iovec iov[],
+			    unsigned int *out_num, unsigned int *in_num)
+{
+	unsigned int i, head;
+
+	/* Check it isn't doing very strange things with descriptor numbers. */
+	if ((u16)(vq->vring.avail->idx - vq->last_avail_idx) > vq->vring.num)
+		errx(1, "Guest moved used index from %u to %u",
+		     vq->last_avail_idx, vq->vring.avail->idx);
+
+	/* If there's nothing new since last we looked, return invalid. */
+	if (vq->vring.avail->idx == vq->last_avail_idx)
+		return vq->vring.num;
+
+	/* Grab the next descriptor number they're advertising, and increment
+	 * the index we've seen. */
+	head = vq->vring.avail->ring[vq->last_avail_idx++ % vq->vring.num];
+
+	/* If their number is silly, that's a fatal mistake. */
+	if (head >= vq->vring.num)
+		errx(1, "Guest says index %u is available", head);
+
+	/* When we start there are none of either input nor output. */
+	*out_num = *in_num = 0;
+
+	i = head;
+	do {
+		/* Grab the first descriptor, and check it's OK. */
+		iov[*out_num + *in_num].iov_len = vq->vring.desc[i].len;
+		iov[*out_num + *in_num].iov_base
+			= check_pointer(vq->vring.desc[i].addr,
+					vq->vring.desc[i].len);
+		/* If this is an input descriptor, increment that count. */
+		if (vq->vring.desc[i].flags & VRING_DESC_F_WRITE)
+			(*in_num)++;
+		else {
+			/* If it's an output descriptor, they're all supposed
+			 * to come before any input descriptors. */
+			if (*in_num)
+				errx(1, "Descriptor has out after in");
+			(*out_num)++;
+		}
+
+		/* If we've got too many, that implies a descriptor loop. */
+		if (*out_num + *in_num > vq->vring.num)
+			errx(1, "Looped descriptor");
+	} while ((i = next_desc(vq, i)) != vq->vring.num);
+
+	return head;
+}
+
+/* Once we've used one of their buffers, we tell them about it.  We'll then
+ * want to send them an interrupt, using trigger_irq(). */
+static void add_used(struct virtqueue *vq, unsigned int head, int len)
+{
+	struct vring_used_elem *used;
+
+	/* Get a pointer to the next entry in the used ring. */
+	used = &vq->vring.used->ring[vq->vring.used->idx % vq->vring.num];
+	used->id = head;
+	used->len = len;
+	/* Make sure buffer is written before we update index. */
+	wmb();
+	vq->vring.used->idx++;
+}
+
+/* This actually sends the interrupt for this virtqueue */
+static void trigger_irq(int fd, struct virtqueue *vq)
+{
+	unsigned long buf[] = { LHREQ_IRQ, vq->config.irq };
+
+	if (vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)
+		return;
+
+	/* Send the Guest an interrupt tell them we used something up. */
+	if (write(fd, buf, sizeof(buf)) != 0)
+		err(1, "Triggering irq %i", vq->config.irq);
+}
+
+/* And here's the combo meal deal.  Supersize me! */
+static void add_used_and_trigger(int fd, struct virtqueue *vq,
+				 unsigned int head, int len)
+{
+	add_used(vq, head, len);
+	trigger_irq(fd, vq);
+}
+
 /* Here is the input terminal setting we save, and the routine to restore them
  * on exit so the user can see what they type next. */
 static struct termios orig_term;
@@ -672,38 +805,37 @@ struct console_abort
 /* This is the routine which handles console input (ie. stdin). */
 static bool handle_console_input(int fd, struct device *dev)
 {
-	u32 irq = 0, *lenp;
 	int len;
-	unsigned int num;
-	struct iovec iov[LGUEST_MAX_DMA_SECTIONS];
+	unsigned int head, in_num, out_num;
+	struct iovec iov[dev->vq->vring.num];
 	struct console_abort *abort = dev->priv;
 
-	/* First we get the console buffer from the Guest.  The key is dev->mem
-	 * which was set to 0 in setup_console(). */
-	lenp = get_dma_buffer(fd, dev->mem, iov, &num, &irq);
-	if (!lenp) {
-		/* If it's not ready for input, warn and set up to discard. */
-		warn("console: no dma buffer!");
-		discard_iovec(iov, &num);
-	}
+	/* First we need a console buffer from the Guests's input virtqueue. */
+	head = get_vq_desc(dev->vq, iov, &out_num, &in_num);
+	if (head == dev->vq->vring.num) {
+		/* If they're not ready for input, we warn and set up to
+		 * discard. */
+		warnx("console: no dma buffer!");
+		discard_iovec(iov, &in_num);
+	} else if (out_num)
+		errx(1, "Output buffers in console in queue?");
 
 	/* This is why we convert to iovecs: the readv() call uses them, and so
 	 * it reads straight into the Guest's buffer. */
-	len = readv(dev->fd, iov, num);
+	len = readv(dev->fd, iov, in_num);
 	if (len <= 0) {
 		/* This implies that the console is closed, is /dev/null, or
-		 * something went terribly wrong.  We still go through the rest
-		 * of the logic, though, especially the exit handling below. */
+		 * something went terribly wrong. */
 		warnx("Failed to get console input, ignoring console.");
-		len = 0;
-	}
-
-	/* If we read the data into the Guest, fill in the length and send the
-	 * interrupt. */
-	if (lenp) {
-		*lenp = len;
-		trigger_irq(fd, irq);
-	}
+		/* Put the input terminal back and return failure (meaning,
+		 * don't call us again). */
+		restore_term();
+		return false;
+	}
+
+	/* If we actually read the data into the Guest, tell them about it. */
+	if (head != dev->vq->vring.num)
+		add_used_and_trigger(fd, dev->vq, head, len);
 
 	/* Three ^C within one second?  Exit.
 	 *
@@ -732,202 +864,137 @@ static bool handle_console_input(int fd,
 		/* Any other key resets the abort counter. */
 		abort->count = 0;
 
-	/* Now, if we didn't read anything, put the input terminal back and
-	 * return failure (meaning, don't call us again). */
-	if (!len) {
-		restore_term();
-		return false;
-	}
 	/* Everything went OK! */
 	return true;
 }
 
-/* Handling console output is much simpler than input. */
-static u32 handle_console_output(int fd, const struct iovec *iov,
-				 unsigned num, struct device*dev)
-{
-	/* Whatever the Guest sends, write it to standard output.  Return the
-	 * number of bytes written. */
-	return writev(STDOUT_FILENO, iov, num);
-}
-
-/* Guest->Host network output is also pretty easy. */
-static u32 handle_tun_output(int fd, const struct iovec *iov,
-			     unsigned num, struct device *dev)
-{
-	/* We put a flag in the "priv" pointer of the network device, and set
-	 * it as soon as we see output.  We'll see why in handle_tun_input() */
-	*(bool *)dev->priv = true;
-	/* Whatever packet the Guest sent us, write it out to the tun
-	 * device. */
-	return writev(dev->fd, iov, num);
-}
-
-/* This matches the peer_key() in lguest_net.c.  The key for any given slot
- * is the address of the network device's page plus 4 * the slot number. */
-static unsigned long peer_offset(unsigned int peernum)
-{
-	return 4 * peernum;
-}
-
-/* This is where we handle a packet coming in from the tun device */
+/* Handling output for console is simple: we just get all the output buffers
+ * and write them to stdout. */
+static void handle_console_output(int fd, struct virtqueue *vq)
+{
+	unsigned int head, out, in;
+	int len;
+	struct iovec iov[vq->vring.num];
+
+	/* Keep getting output buffers from the Guest until we run out. */
+	while ((head = get_vq_desc(vq, iov, &out, &in)) != vq->vring.num) {
+		if (in)
+			errx(1, "Input buffers in output queue?");
+		len = writev(STDOUT_FILENO, iov, out);
+		add_used_and_trigger(fd, vq, head, len);
+	}
+}
+
+/* Handling output for network is also simple: we get all the output buffers
+ * and write them (ignoring the first element) to this device's file descriptor
+ * (stdout). */
+static void handle_net_output(int fd, struct virtqueue *vq)
+{
+	unsigned int head, out, in;
+	int len;
+	struct iovec iov[vq->vring.num];
+
+	/* Keep getting output buffers from the Guest until we run out. */
+	while ((head = get_vq_desc(vq, iov, &out, &in)) != vq->vring.num) {
+		if (in)
+			errx(1, "Input buffers in output queue?");
+		/* Check header, but otherwise ignore it (we said we supported
+		 * no features). */
+		(void)convert(&iov[0], struct virtio_net_hdr);
+		len = writev(vq->dev->fd, iov+1, out-1);
+		add_used_and_trigger(fd, vq, head, len);
+	}
+}
+
+/* This is where we handle a packet coming in from the tun device to our
+ * Guest. */
 static bool handle_tun_input(int fd, struct device *dev)
 {
-	u32 irq = 0, *lenp;
+	unsigned int head, in_num, out_num;
 	int len;
-	unsigned num;
-	struct iovec iov[LGUEST_MAX_DMA_SECTIONS];
-
-	/* First we get a buffer the Guest has bound to its key. */
-	lenp = get_dma_buffer(fd, dev->mem+peer_offset(NET_PEERNUM), iov, &num,
-			      &irq);
-	if (!lenp) {
+	struct iovec iov[dev->vq->vring.num];
+	struct virtio_net_hdr *hdr;
+
+	/* First we need a network buffer from the Guests's recv virtqueue. */
+	head = get_vq_desc(dev->vq, iov, &out_num, &in_num);
+	if (head == dev->vq->vring.num) {
 		/* Now, it's expected that if we try to send a packet too
-		 * early, the Guest won't be ready yet.  This is why we set a
-		 * flag when the Guest sends its first packet.  If it's sent a
-		 * packet we assume it should be ready to receive them.
-		 *
-		 * Actually, this is what the status bits in the descriptor are
-		 * for: we should *use* them.  FIXME! */
-		if (*(bool *)dev->priv)
+		 * early, the Guest won't be ready yet.  Wait until the device
+		 * status says it's ready. */
+		/* FIXME: Actually want DRIVER_ACTIVE here. */
+		if (dev->desc->status & VIRTIO_CONFIG_S_DRIVER_OK)
 			warn("network: no dma buffer!");
-		discard_iovec(iov, &num);
-	}
+		discard_iovec(iov, &in_num);
+	} else if (out_num)
+		errx(1, "Output buffers in network recv queue?");
+
+	/* First element is the header: we set it to 0 (no features). */
+	hdr = convert(&iov[0], struct virtio_net_hdr);
+	hdr->flags = 0;
+	hdr->gso_type = VIRTIO_NET_HDR_GSO_NONE;
 
 	/* Read the packet from the device directly into the Guest's buffer. */
-	len = readv(dev->fd, iov, num);
+	len = readv(dev->fd, iov+1, in_num-1);
 	if (len <= 0)
 		err(1, "reading network");
 
-	/* Write the used_len, and trigger the interrupt for the Guest */
-	if (lenp) {
-		*lenp = len;
-		trigger_irq(fd, irq);
-	}
+	/* If we actually read the data into the Guest, tell them about it. */
+	if (head != dev->vq->vring.num)
+		add_used_and_trigger(fd, dev->vq, head, sizeof(*hdr) + len);
+
 	verbose("tun input packet len %i [%02x %02x] (%s)\n", len,
-		((u8 *)iov[0].iov_base)[0], ((u8 *)iov[0].iov_base)[1],
-		lenp ? "sent" : "discarded");
+		((u8 *)iov[1].iov_base)[0], ((u8 *)iov[1].iov_base)[1],
+		head != dev->vq->vring.num ? "sent" : "discarded");
+
 	/* All good. */
 	return true;
 }
 
-/* The last device handling routine is block output: the Guest has sent a DMA
- * to the block device.  It will have placed the command it wants in the
- * "struct lguest_block_page". */
-static u32 handle_block_output(int fd, const struct iovec *iov,
-			       unsigned num, struct device *dev)
-{
-	struct lguest_block_page *p = dev->mem;
-	u32 irq, *lenp;
-	unsigned int len, reply_num;
-	struct iovec reply[LGUEST_MAX_DMA_SECTIONS];
-	off64_t device_len, off = (off64_t)p->sector * 512;
-
-	/* First we extract the device length from the dev->priv pointer. */
-	device_len = *(off64_t *)dev->priv;
-
-	/* We first check that the read or write is within the length of the
-	 * block file. */
-	if (off >= device_len)
-		errx(1, "Bad offset %llu vs %llu", off, device_len);
-	/* Move to the right location in the block file.  This shouldn't fail,
-	 * but best to check. */
-	if (lseek64(dev->fd, off, SEEK_SET) != off)
-		err(1, "Bad seek to sector %i", p->sector);
-
-	verbose("Block: %s at offset %llu\n", p->type ? "WRITE" : "READ", off);
-
-	/* They were supposed to bind a reply buffer at key equal to the start
-	 * of the block device memory.  We need this to tell them when the
-	 * request is finished. */
-	lenp = get_dma_buffer(fd, dev->mem, reply, &reply_num, &irq);
-	if (!lenp)
-		err(1, "Block request didn't give us a dma buffer");
-
-	if (p->type) {
-		/* A write request.  The DMA they sent contained the data, so
-		 * write it out. */
-		len = writev(dev->fd, iov, num);
-		/* Grr... Now we know how long the "struct lguest_dma" they
-		 * sent was, we make sure they didn't try to write over the end
-		 * of the block file (possibly extending it). */
-		if (off + len > device_len) {
-			/* Trim it back to the correct length */
-			ftruncate64(dev->fd, device_len);
-			/* Die, bad Guest, die. */
-			errx(1, "Write past end %llu+%u", off, len);
+/* This is the generic routine we call when the Guest uses LHCALL_NOTIFY. */
+static void handle_output(int fd, unsigned long addr)
+{
+	struct device *i;
+	struct virtqueue *vq;
+
+	/* Check each virtqueue. */
+	for (i = devices.dev; i; i = i->next) {
+		for (vq = i->vq; vq; vq = vq->next) {
+			if (vq->config.pfn == addr/getpagesize()
+			    && vq->handle_output) {
+				verbose("Output to %s\n", vq->dev->name);
+				vq->handle_output(fd, vq);
+				return;
+			}
 		}
-		/* The reply length is 0: we just send back an empty DMA to
-		 * interrupt them and tell them the write is finished. */
-		*lenp = 0;
-	} else {
-		/* A read request.  They sent an empty DMA to start the
-		 * request, and we put the read contents into the reply
-		 * buffer. */
-		len = readv(dev->fd, reply, reply_num);
-		*lenp = len;
-	}
-
-	/* The result is 1 (done), 2 if there was an error (short read or
-	 * write). */
-	p->result = 1 + (p->bytes != len);
-	/* Now tell them we've used their reply buffer. */
-	trigger_irq(fd, irq);
-
-	/* We're supposed to return the number of bytes of the output buffer we
-	 * used.  But the block device uses the "result" field instead, so we
-	 * don't bother. */
-	return 0;
-}
-
-/* This is the generic routine we call when the Guest sends some DMA out. */
-static void handle_output(int fd, unsigned long dma, unsigned long key,
-			  struct device_list *devices)
-{
-	struct device *i;
-	u32 *lenp;
-	struct iovec iov[LGUEST_MAX_DMA_SECTIONS];
-	unsigned num = 0;
-
-	/* Convert the "struct lguest_dma" they're sending to a "struct
-	 * iovec". */
-	lenp = dma2iov(dma, iov, &num);
-
-	/* Check each device: if they expect output to this key, tell them to
-	 * handle it. */
-	for (i = devices->dev; i; i = i->next) {
-		if (i->handle_output && key == i->watch_key) {
-			/* We write the result straight into the used_len field
-			 * for them. */
-			*lenp = i->handle_output(fd, iov, num, i);
-			return;
-		}
-	}
-
-	/* This can happen: the kernel sends any SEND_DMA which doesn't match
-	 * another Guest to us.  It could be that another Guest just left a
-	 * network, for example.  But it's unusual. */
-	warnx("Pending dma %p, key %p", (void *)dma, (void *)key);
+	}
+
+	/* Early console write is done using notify on a nul-terminated string
+	 * in Guest memory. */
+	if (addr >= guest_limit)
+		errx(1, "Bad NOTIFY %#lx", addr);
+
+	write(STDOUT_FILENO, from_guest_phys(addr),
+	      strnlen(from_guest_phys(addr), guest_limit - addr));
 }
 
 /* This is called when the waker wakes us up: check for incoming file
  * descriptors. */
-static void handle_input(int fd, struct device_list *devices)
+static void handle_input(int fd)
 {
 	/* select() wants a zeroed timeval to mean "don't wait". */
 	struct timeval poll = { .tv_sec = 0, .tv_usec = 0 };
 
 	for (;;) {
 		struct device *i;
-		fd_set fds = devices->infds;
+		fd_set fds = devices.infds;
 
 		/* If nothing is ready, we're done. */
-		if (select(devices->max_infd+1, &fds, NULL, NULL, &poll) == 0)
+		if (select(devices.max_infd+1, &fds, NULL, NULL, &poll) == 0)
 			break;
 
 		/* Otherwise, call the device(s) which have readable
 		 * file descriptors and a method of handling them.  */
-		for (i = devices->dev; i; i = i->next) {
+		for (i = devices.dev; i; i = i->next) {
 			if (i->handle_input && FD_ISSET(i->fd, &fds)) {
 				/* If handle_input() returns false, it means we
 				 * should no longer service it.
@@ -936,7 +1003,7 @@ static void handle_input(int fd, struct 
 					/* Clear it from the set of input file
 					 * descriptors kept at the head of the
 					 * device list. */
-					FD_CLR(i->fd, &devices->infds);
+					FD_CLR(i->fd, &devices.infds);
 					/* Tell waker to ignore it too... */
 					write(waker_fd, &i->fd, sizeof(i->fd));
 				}
@@ -953,43 +1020,93 @@ static void handle_input(int fd, struct 
  * routines to allocate them.
  *
  * This routine allocates a new "struct lguest_device_desc" from descriptor
- * table in the devices array just above the Guest's normal memory. */
-static struct lguest_device_desc *
-new_dev_desc(struct lguest_device_desc *descs,
-	     u16 type, u16 features, u16 num_pages)
-{
-	unsigned int i;
-
-	for (i = 0; i < LGUEST_MAX_DEVICES; i++) {
-		if (!descs[i].type) {
-			descs[i].type = type;
-			descs[i].features = features;
-			descs[i].num_pages = num_pages;
-			/* If they said the device needs memory, we allocate
-			 * that now. */
-			if (num_pages) {
-				unsigned long pa;
-				pa = to_guest_phys(get_pages(num_pages));
-				descs[i].pfn = pa / getpagesize();
-			}
-			return &descs[i];
-		}
-	}
-	errx(1, "too many devices");
-}
-
-/* This monster routine does all the creation and setup of a new device,
- * including caling new_dev_desc() to allocate the descriptor and device
- * memory. */
-static struct device *new_device(struct device_list *devices,
-				 u16 type, u16 num_pages, u16 features,
-				 int fd,
-				 bool (*handle_input)(int, struct device *),
-				 unsigned long watch_off,
-				 u32 (*handle_output)(int,
-						      const struct iovec *,
-						      unsigned,
-						      struct device *))
+ * table just above the Guest's normal memory.  It returns a pointer to that
+ * descriptor. */
+static struct lguest_device_desc *new_dev_desc(u16 type)
+{
+	struct lguest_device_desc *d;
+
+	/* We only have one page for all the descriptors. */
+	if (devices.desc_used + sizeof(*d) > getpagesize())
+		errx(1, "Too many devices");
+
+	/* We don't need to set config_len or status: page is 0 already. */
+	d = (void *)devices.descpage + devices.desc_used;
+	d->type = type;
+	devices.desc_used += sizeof(*d);
+
+	return d;
+}
+
+/* Each device descriptor is followed by some configuration information.
+ * The first byte is a "status" byte for the Guest to report what's happening.
+ * After that are fields: u8 type, u8 len, [... len bytes...].
+ *
+ * This routine adds a new field to an existing device's descriptor.  It only
+ * works for the last device, but that's OK because that's how we use it. */
+static void add_desc_field(struct device *dev, u8 type, u8 len, const void *c)
+{
+	/* This is the last descriptor, right? */
+	assert(devices.descpage + devices.desc_used
+	       == (u8 *)(dev->desc + 1) + dev->desc->config_len);
+
+	/* We only have one page of device descriptions. */
+	if (devices.desc_used + 2 + len > getpagesize())
+		errx(1, "Too many devices");
+
+	/* Copy in the new config header: type then length. */
+	devices.descpage[devices.desc_used++] = type;
+	devices.descpage[devices.desc_used++] = len;
+	memcpy(devices.descpage + devices.desc_used, c, len);
+	devices.desc_used += len;
+
+	/* Update the device descriptor length: two byte head then data. */
+	dev->desc->config_len += 2 + len;
+}
+
+/* This routine adds a virtqueue to a device.  We specify how many descriptors
+ * the virtqueue is to have. */
+static void add_virtqueue(struct device *dev, unsigned int num_descs,
+			  void (*handle_output)(int fd, struct virtqueue *me))
+{
+	unsigned int pages;
+	struct virtqueue **i, *vq = malloc(sizeof(*vq));
+	void *p;
+
+	/* First we need some pages for this virtqueue. */
+	pages = (vring_size(num_descs) + getpagesize() - 1) / getpagesize();
+	p = get_pages(pages);
+
+	/* Initialize the configuration. */
+	vq->config.num = num_descs;
+	vq->config.irq = devices.next_irq++;
+	vq->config.pfn = to_guest_phys(p) / getpagesize();
+
+	/* Initialize the vring. */
+	vring_init(&vq->vring, num_descs, p);
+
+	/* Add the configuration information to this device's descriptor. */
+	add_desc_field(dev, VIRTIO_CONFIG_F_VIRTQUEUE,
+		       sizeof(vq->config), &vq->config);
+
+	/* Add to tail of list, so dev->vq is first vq, dev->vq->next is
+	 * second.  */
+	for (i = &dev->vq; *i; i = &(*i)->next);
+	*i = vq;
+
+	/* Link virtqueue back to device. */
+	vq->dev = dev;
+
+	/* Set up handler. */
+	vq->handle_output = handle_output;
+	if (!handle_output)
+		vq->vring.used->flags = VRING_USED_F_NO_NOTIFY;
+}
+
+/* This routine does all the creation and setup of a new device, including
+ * caling new_dev_desc() to allocate the descriptor and device memory. */
+static struct device *new_device(const char *name, u16 type, int fd,
+				 bool (*handle_input)(int, struct device *))
 {
 	struct device *dev = malloc(sizeof(*dev));
 
@@ -997,27 +1114,25 @@ static struct device *new_device(struct 
 	 * easier, but the user expects the devices to be arranged on the bus
 	 * in command-line order.  The first network device on the command line
 	 * is eth0, the first block device /dev/lgba, etc. */
-	*devices->lastdev = dev;
+	*devices.lastdev = dev;
 	dev->next = NULL;
-	devices->lastdev = &dev->next;
+	devices.lastdev = &dev->next;
 
 	/* Now we populate the fields one at a time. */
 	dev->fd = fd;
 	/* If we have an input handler for this file descriptor, then we add it
 	 * to the device_list's fdset and maxfd. */
 	if (handle_input)
-		set_fd(dev->fd, devices);
-	dev->desc = new_dev_desc(devices->descs, type, features, num_pages);
-	dev->mem = from_guest_phys(dev->desc->pfn * getpagesize());
+		add_device_fd(dev->fd);
+	dev->desc = new_dev_desc(type);
 	dev->handle_input = handle_input;
-	dev->watch_key = to_guest_phys(dev->mem) + watch_off;
-	dev->handle_output = handle_output;
+	dev->name = name;
 	return dev;
 }
 
 /* Our first setup routine is the console.  It's a fairly simple device, but
  * UNIX tty handling makes it uglier than it could be. */
-static void setup_console(struct device_list *devices)
+static void setup_console(void)
 {
 	struct device *dev;
 
@@ -1033,127 +1148,38 @@ static void setup_console(struct device_
 		atexit(restore_term);
 	}
 
-	/* We don't currently require any memory for the console, so we ask for
-	 * 0 pages. */
-	dev = new_device(devices, LGUEST_DEVICE_T_CONSOLE, 0, 0,
-			 STDIN_FILENO, handle_console_input,
-			 LGUEST_CONSOLE_DMA_KEY, handle_console_output);
+	dev = new_device("console", VIRTIO_ID_CONSOLE,
+			 STDIN_FILENO, handle_console_input);
 	/* We store the console state in dev->priv, and initialize it. */
 	dev->priv = malloc(sizeof(struct console_abort));
 	((struct console_abort *)dev->priv)->count = 0;
-	verbose("device %p: console\n",
-		(void *)(dev->desc->pfn * getpagesize()));
-}
-
-/* Setting up a block file is also fairly straightforward. */
-static void setup_block_file(const char *filename, struct device_list *devices)
-{
-	int fd;
-	struct device *dev;
-	off64_t *device_len;
-	struct lguest_block_page *p;
-
-	/* We open with O_LARGEFILE because otherwise we get stuck at 2G.  We
-	 * open with O_DIRECT because otherwise our benchmarks go much too
-	 * fast. */
-	fd = open_or_die(filename, O_RDWR|O_LARGEFILE|O_DIRECT);
-
-	/* We want one page, and have no input handler (the block file never
-	 * has anything interesting to say to us).  Our timing will be quite
-	 * random, so it should be a reasonable randomness source. */
-	dev = new_device(devices, LGUEST_DEVICE_T_BLOCK, 1,
-			 LGUEST_DEVICE_F_RANDOMNESS,
-			 fd, NULL, 0, handle_block_output);
-
-	/* We store the device size in the private area */
-	device_len = dev->priv = malloc(sizeof(*device_len));
-	/* This is the safe way of establishing the size of our device: it
-	 * might be a normal file or an actual block device like /dev/hdb. */
-	*device_len = lseek64(fd, 0, SEEK_END);
-
-	/* The device memory is a "struct lguest_block_page".  It's zeroed
-	 * already, we just need to put in the device size.  Block devices
-	 * think in sectors (ie. 512 byte chunks), so we translate here. */
-	p = dev->mem;
-	p->num_sectors = *device_len/512;
-	verbose("device %p: block %i sectors\n",
-		(void *)(dev->desc->pfn * getpagesize()), p->num_sectors);
-}
-
-/*
- * Network Devices.
- *
- * Setting up network devices is quite a pain, because we have three types.
- * First, we have the inter-Guest network.  This is a file which is mapped into
- * the address space of the Guests who are on the network.  Because it is a
- * shared mapping, the same page underlies all the devices, and they can send
- * DMA to each other.
- *
- * Remember from our network driver, the Guest is told what slot in the page it
- * is to use.  We use exclusive fnctl locks to reserve a slot.  If another
- * Guest is using a slot, the lock will fail and we try another.  Because fnctl
- * locks are cleaned up automatically when we die, this cleverly means that our
- * reservation on the slot will vanish if we crash. */
-static unsigned int find_slot(int netfd, const char *filename)
-{
-	struct flock fl;
-
-	fl.l_type = F_WRLCK;
-	fl.l_whence = SEEK_SET;
-	fl.l_len = 1;
-	/* Try a 1 byte lock in each possible position number */
-	for (fl.l_start = 0;
-	     fl.l_start < getpagesize()/sizeof(struct lguest_net);
-	     fl.l_start++) {
-		/* If we succeed, return the slot number. */
-		if (fcntl(netfd, F_SETLK, &fl) == 0)
-			return fl.l_start;
-	}
-	errx(1, "No free slots in network file %s", filename);
-}
-
-/* This function sets up the network file */
-static void setup_net_file(const char *filename,
-			   struct device_list *devices)
-{
-	int netfd;
-	struct device *dev;
-
-	/* We don't use open_or_die() here: for friendliness we create the file
-	 * if it doesn't already exist. */
-	netfd = open(filename, O_RDWR, 0);
-	if (netfd < 0) {
-		if (errno == ENOENT) {
-			netfd = open(filename, O_RDWR|O_CREAT, 0600);
-			if (netfd >= 0) {
-				/* If we succeeded, initialize the file with a
-				 * blank page. */
-				char page[getpagesize()];
-				memset(page, 0, sizeof(page));
-				write(netfd, page, sizeof(page));
-			}
-		}
-		if (netfd < 0)
-			err(1, "cannot open net file '%s'", filename);
-	}
-
-	/* We need 1 page, and the features indicate the slot to use and that
-	 * no checksum is needed.  We never touch this device again; it's
-	 * between the Guests on the network, so we don't register input or
-	 * output handlers. */
-	dev = new_device(devices, LGUEST_DEVICE_T_NET, 1,
-			 find_slot(netfd, filename)|LGUEST_NET_F_NOCSUM,
-			 -1, NULL, 0, NULL);
-
-	/* Map the shared file. */
-	if (mmap(dev->mem, getpagesize(), PROT_READ|PROT_WRITE,
-			 MAP_FIXED|MAP_SHARED, netfd, 0) != dev->mem)
-			err(1, "could not mmap '%s'", filename);
-	verbose("device %p: shared net %s, peer %i\n",
-		(void *)(dev->desc->pfn * getpagesize()), filename,
-		dev->desc->features & ~LGUEST_NET_F_NOCSUM);
+
+	/* The console needs two virtqueues: the input then the output.  We
+	 * don't care when they refill the input queue, since we don't hold
+	 * data waiting for them.  That's why the input queue's callback is
+	 * NULL.  */
+	add_virtqueue(dev, VIRTQUEUE_NUM, NULL);
+	add_virtqueue(dev, VIRTQUEUE_NUM, handle_console_output);
+
+	verbose("device %u: console\n", devices.device_num++);
 }
 /*:*/
+
+/*M:010 Inter-guest networking is an interesting area.  Simplest is to have a
+ * --sharenet=<name> option which opens or creates a named pipe.  This can be
+ * used to send packets to another guest in a 1:1 manner.
+ *
+ * More sopisticated is to use one of the tools developed for project like UML
+ * to do networking.
+ *
+ * Faster is to do virtio bonding in kernel.  Doing this 1:1 would be
+ * completely generic ("here's my vring, attach to your vring") and would work
+ * for any traffic.  Of course, namespace and permissions issues need to be
+ * dealt with.  A more sophisticated "multi-channel" virtio_net.c could hide
+ * multiple inter-guest channels behind one interface, although it would
+ * require some manner of hotplugging new virtio channels.
+ *
+ * Finally, we could implement a virtio network switch in the kernel. :*/
 
 static u32 str2ip(const char *ipaddr)
 {
@@ -1188,7 +1214,7 @@ static void add_to_bridge(int fd, const 
 
 /* This sets up the Host end of the network device with an IP address, brings
  * it up so packets will flow, the copies the MAC address into the hwaddr
- * pointer (in practice, the Host's slot in the network device's memory). */
+ * pointer. */
 static void configure_device(int fd, const char *devname, u32 ipaddr,
 			     unsigned char hwaddr[6])
 {
@@ -1214,18 +1240,18 @@ static void configure_device(int fd, con
 	memcpy(hwaddr, ifr.ifr_hwaddr.sa_data, 6);
 }
 
-/*L:195 The other kind of network is a Host<->Guest network.  This can either
- * use briding or routing, but the principle is the same: it uses the "tun"
- * device to inject packets into the Host as if they came in from a normal
- * network card.  We just shunt packets between the Guest and the tun
- * device. */
-static void setup_tun_net(const char *arg, struct device_list *devices)
+/*L:195 Our network is a Host<->Guest network.  This can either use bridging or
+ * routing, but the principle is the same: it uses the "tun" device to inject
+ * packets into the Host as if they came in from a normal network card.  We
+ * just shunt packets between the Guest and the tun device. */
+static void setup_tun_net(const char *arg)
 {
 	struct device *dev;
 	struct ifreq ifr;
 	int netfd, ipfd;
 	u32 ip;
 	const char *br_name = NULL;
+	u8 hwaddr[6];
 
 	/* We open the /dev/net/tun device and tell it we want a tap device.  A
 	 * tap device is like a tun device, only somehow different.  To tell
@@ -1241,21 +1267,12 @@ static void setup_tun_net(const char *ar
 	 * device: trust us! */
 	ioctl(netfd, TUNSETNOCSUM, 1);
 
-	/* We create the net device with 1 page, using the features field of
-	 * the descriptor to tell the Guest it is in slot 1 (NET_PEERNUM), and
-	 * that the device has fairly random timing.  We do *not* specify
-	 * LGUEST_NET_F_NOCSUM: these packets can reach the real world.
-	 *
-	 * We will put our MAC address is slot 0 for the Guest to see, so
-	 * it will send packets to us using the key "peer_offset(0)": */
-	dev = new_device(devices, LGUEST_DEVICE_T_NET, 1,
-			 NET_PEERNUM|LGUEST_DEVICE_F_RANDOMNESS, netfd,
-			 handle_tun_input, peer_offset(0), handle_tun_output);
-
-	/* We keep a flag which says whether we've seen packets come out from
-	 * this network device. */
-	dev->priv = malloc(sizeof(bool));
-	*(bool *)dev->priv = false;
+	/* First we create a new network device. */
+	dev = new_device("net", VIRTIO_ID_NET, netfd, handle_tun_input);
+
+	/* Network devices need a receive and a send queue. */
+	add_virtqueue(dev, VIRTQUEUE_NUM, NULL);
+	add_virtqueue(dev, VIRTQUEUE_NUM, handle_net_output);
 
 	/* We need a socket to perform the magic network ioctls to bring up the
 	 * tap interface, connect to the bridge etc.  Any socket will do! */
@@ -1271,44 +1288,251 @@ static void setup_tun_net(const char *ar
 	} else /* It is an IP address to set up the device with */
 		ip = str2ip(arg);
 
-	/* We are peer 0, ie. first slot, so we hand dev->mem to this routine
-	 * to write the MAC address at the start of the device memory.  */
-	configure_device(ipfd, ifr.ifr_name, ip, dev->mem);
-
-	/* Set "promisc" bit: we want every single packet if we're going to
-	 * bridge to other machines (and otherwise it doesn't matter). */
-	*((u8 *)dev->mem) |= 0x1;
-
+	/* Set up the tun device, and get the mac address for the interface. */
+	configure_device(ipfd, ifr.ifr_name, ip, hwaddr);
+
+	/* Tell Guest what MAC address to use. */
+	add_desc_field(dev, VIRTIO_CONFIG_NET_MAC_F, sizeof(hwaddr), hwaddr);
+
+	/* We don't seed the socket any more; setup is done. */
 	close(ipfd);
 
-	verbose("device %p: tun net %u.%u.%u.%u\n",
-		(void *)(dev->desc->pfn * getpagesize()),
-		(u8)(ip>>24), (u8)(ip>>16), (u8)(ip>>8), (u8)ip);
+	verbose("device %u: tun net %u.%u.%u.%u\n",
+		devices.device_num++,
+		(u8)(ip>>24),(u8)(ip>>16),(u8)(ip>>8),(u8)ip);
 	if (br_name)
 		verbose("attached to bridge: %s\n", br_name);
 }
+
+
+/*
+ * Block device.
+ *
+ * Serving a block device is really easy: the Guest asks for a block number and
+ * we read or write that position in the file.
+ *
+ * Unfortunately, this is amazingly slow: the Guest waits until the read is
+ * finished before running anything else, even if it could be doing useful
+ * work.  We could use async I/O, except it's reputed to suck so hard that
+ * characters actually go missing from your code when you try to use it.
+ *
+ * So we farm the I/O out to thread, and communicate with it via a pipe. */
+
+/* This hangs off device->priv, with the data. */
+struct vblk_info
+{
+	/* The size of the file. */
+	off64_t len;
+
+	/* The file descriptor for the file. */
+	int fd;
+
+	/* IO thread listens on this file descriptor [0]. */
+	int workpipe[2];
+
+	/* IO thread writes to this file descriptor to mark it done, then
+	 * Launcher triggers interrupt to Guest. */
+	int done_fd;
+};
+
+/* This is the core of the I/O thread.  It returns true if it did something. */
+static bool service_io(struct device *dev)
+{
+	struct vblk_info *vblk = dev->priv;
+	unsigned int head, out_num, in_num, wlen;
+	int ret;
+	struct virtio_blk_inhdr *in;
+	struct virtio_blk_outhdr *out;
+	struct iovec iov[dev->vq->vring.num];
+	off64_t off;
+
+	head = get_vq_desc(dev->vq, iov, &out_num, &in_num);
+	if (head == dev->vq->vring.num)
+		return false;
+
+	if (out_num == 0 || in_num == 0)
+		errx(1, "Bad virtblk cmd %u out=%u in=%u",
+		     head, out_num, in_num);
+
+	out = convert(&iov[0], struct virtio_blk_outhdr);
+	in = convert(&iov[out_num+in_num-1], struct virtio_blk_inhdr);
+	off = out->sector * 512;
+
+	/* This is how we implement barriers.  Pretty poor, no? */
+	if (out->type & VIRTIO_BLK_T_BARRIER)
+		fdatasync(vblk->fd);
+
+	if (out->type & VIRTIO_BLK_T_SCSI_CMD) {
+		fprintf(stderr, "Scsi commands unsupported\n");
+		in->status = VIRTIO_BLK_S_UNSUPP;
+		wlen = sizeof(in);
+	} else if (out->type & VIRTIO_BLK_T_OUT) {
+		/* Write */
+
+		/* Move to the right location in the block file.  This can fail
+		 * if they try to write past end. */
+		if (lseek64(vblk->fd, off, SEEK_SET) != off)
+			err(1, "Bad seek to sector %llu", out->sector);
+
+		ret = writev(vblk->fd, iov+1, out_num-1);
+		verbose("WRITE to sector %llu: %i\n", out->sector, ret);
+
+		/* Grr... Now we know how long the descriptor they sent was, we
+		 * make sure they didn't try to write over the end of the block
+		 * file (possibly extending it). */
+		if (ret > 0 && off + ret > vblk->len) {
+			/* Trim it back to the correct length */
+			ftruncate64(vblk->fd, vblk->len);
+			/* Die, bad Guest, die. */
+			errx(1, "Write past end %llu+%u", off, ret);
+		}
+		wlen = sizeof(in);
+		in->status = (ret >= 0 ? VIRTIO_BLK_S_OK : VIRTIO_BLK_S_IOERR);
+	} else {
+		/* Read */
+
+		/* Move to the right location in the block file.  This can fail
+		 * if they try to read past end. */
+		if (lseek64(vblk->fd, off, SEEK_SET) != off)
+			err(1, "Bad seek to sector %llu", out->sector);
+
+		ret = readv(vblk->fd, iov+1, in_num-1);
+		verbose("READ from sector %llu: %i\n", out->sector, ret);
+		if (ret >= 0) {
+			wlen = sizeof(in) + ret;
+			in->status = VIRTIO_BLK_S_OK;
+		} else {
+			wlen = sizeof(in);
+			in->status = VIRTIO_BLK_S_IOERR;
+		}
+	}
+
+	/* We can't trigger an IRQ, because we're not the Launcher.  It does
+	 * that when we tell it we're done. */
+	add_used(dev->vq, head, wlen);
+	return true;
+}
+
+/* This is the thread which actually services the I/O. */
+static int io_thread(void *_dev)
+{
+	struct device *dev = _dev;
+	struct vblk_info *vblk = dev->priv;
+	char c;
+
+	/* Close other side of workpipe so we get 0 read when main dies. */
+	close(vblk->workpipe[1]);
+	/* Close the other side of the done_fd pipe. */
+	close(dev->fd);
+
+	/* When this read fails, it means Launcher died, so we follow. */
+	while (read(vblk->workpipe[0], &c, 1) == 1) {
+		/* We acknowledge each request immediately, to reduce latency,
+		 * rather than waiting until we've done them all.  I haven't
+		 * measured to see if it makes any difference. */
+		while (service_io(dev))
+			write(vblk->done_fd, &c, 1);
+	}
+	return 0;
+}
+
+/* When the thread says some I/O is done, we interrupt the Guest. */
+static bool handle_io_finish(int fd, struct device *dev)
+{
+	char c;
+
+	/* If child died, presumably it printed message. */
+	if (read(dev->fd, &c, 1) != 1)
+		exit(1);
+
+	/* It did some work, so trigger the irq. */
+	trigger_irq(fd, dev->vq);
+	return true;
+}
+
+/* When the Guest submits some I/O, we wake the I/O thread. */
+static void handle_virtblk_output(int fd, struct virtqueue *vq)
+{
+	struct vblk_info *vblk = vq->dev->priv;
+	char c = 0;
+
+	/* Wake up I/O thread and tell it to go to work! */
+	if (write(vblk->workpipe[1], &c, 1) != 1)
+		/* Presumably it indicated why it died. */
+		exit(1);
+}
+
+/* This creates a virtual block device. */
+static void setup_block_file(const char *filename)
+{
+	int p[2];
+	struct device *dev;
+	struct vblk_info *vblk;
+	void *stack;
+	u64 cap;
+	unsigned int val;
+
+	/* This is the pipe the I/O thread will use to tell us I/O is done. */
+	pipe(p);
+
+	/* The device responds to return from I/O thread. */
+	dev = new_device("block", VIRTIO_ID_BLOCK, p[0], handle_io_finish);
+
+	/* The device has a virtqueue. */
+	add_virtqueue(dev, VIRTQUEUE_NUM, handle_virtblk_output);
+
+	/* Allocate the room for our own bookkeeping */
+	vblk = dev->priv = malloc(sizeof(*vblk));
+
+	/* First we open the file and store the length. */
+	vblk->fd = open_or_die(filename, O_RDWR|O_LARGEFILE);
+	vblk->len = lseek64(vblk->fd, 0, SEEK_END);
+
+	/* Tell Guest how many sectors this device has. */
+	cap = cpu_to_le64(vblk->len / 512);
+	add_desc_field(dev, VIRTIO_CONFIG_BLK_F_CAPACITY, sizeof(cap), &cap);
+
+	/* Tell Guest not to put in too many descriptors at once: two are used
+	 * for the in and out elements. */
+	val = cpu_to_le32(VIRTQUEUE_NUM - 2);
+	add_desc_field(dev, VIRTIO_CONFIG_BLK_F_SEG_MAX, sizeof(val), &val);
+
+	/* The I/O thread writes to this end of the pipe when done. */
+	vblk->done_fd = p[1];
+
+	/* This is how we tell the I/O thread about more work. */
+	pipe(vblk->workpipe);
+
+	/* Create stack for thread and run it */
+	stack = malloc(32768);
+	if (clone(io_thread, stack + 32768, CLONE_VM, dev) == -1)
+		err(1, "Creating clone");
+
+	/* We don't need to keep the I/O thread's end of the pipes open. */
+	close(vblk->done_fd);
+	close(vblk->workpipe[0]);
+
+	verbose("device %u: virtblock %llu sectors\n",
+		devices.device_num, cap);
+}
 /* That's the end of device setup. */
 
 /*L:220 Finally we reach the core of the Launcher, which runs the Guest, serves
  * its input and output, and finally, lays it to rest. */
-static void __attribute__((noreturn))
-run_guest(int lguest_fd, struct device_list *device_list)
+static void __attribute__((noreturn)) run_guest(int lguest_fd)
 {
 	for (;;) {
 		unsigned long args[] = { LHREQ_BREAK, 0 };
-		unsigned long arr[2];
+		unsigned long notify_addr;
 		int readval;
 
 		/* We read from the /dev/lguest device to run the Guest. */
-		readval = read(lguest_fd, arr, sizeof(arr));
-
-		/* The read can only really return sizeof(arr) (the Guest did a
-		 * SEND_DMA to us), or an error. */
-
-		/* For a successful read, arr[0] is the address of the "struct
-		 * lguest_dma", and arr[1] is the key the Guest sent to. */
-		if (readval == sizeof(arr)) {
-			handle_output(lguest_fd, arr[0], arr[1], device_list);
+		readval = read(lguest_fd, &notify_addr, sizeof(notify_addr));
+
+		/* One unsigned long means the Guest did HCALL_NOTIFY */
+		if (readval == sizeof(notify_addr)) {
+			verbose("Notify on address %#lx\n", notify_addr);
+			handle_output(lguest_fd, notify_addr);
 			continue;
 		/* ENOENT means the Guest died.  Reading tells us why. */
 		} else if (errno == ENOENT) {
@@ -1322,7 +1546,7 @@ run_guest(int lguest_fd, struct device_l
 
 		/* Service input, then unset the BREAK which releases
 		 * the Waker. */
-		handle_input(lguest_fd, device_list);
+		handle_input(lguest_fd);
 		if (write(lguest_fd, args, sizeof(args)) < 0)
 			err(1, "Resetting break");
 	}
@@ -1336,7 +1560,6 @@ run_guest(int lguest_fd, struct device_l
 
 static struct option opts[] = {
 	{ "verbose", 0, NULL, 'v' },
-	{ "sharenet", 1, NULL, 's' },
 	{ "tunnet", 1, NULL, 't' },
 	{ "block", 1, NULL, 'b' },
 	{ "initrd", 1, NULL, 'i' },
@@ -1345,7 +1568,7 @@ static void usage(void)
 static void usage(void)
 {
 	errx(1, "Usage: lguest [--verbose] "
-	     "[--sharenet=<filename>|--tunnet=(<ipaddr>|bridge:<bridgename>)\n"
+	     "[--tunnet=(<ipaddr>|bridge:<bridgename>)\n"
 	     "|--block=<filename>|--initrd=<filename>]...\n"
 	     "<mem-in-mb> vmlinux [args...]");
 }
@@ -1358,8 +1581,6 @@ int main(int argc, char *argv[])
 	unsigned long mem = 0, pgdir, start, initrd_size = 0;
 	/* A temporary and the /dev/lguest file descriptor. */
 	int i, c, lguest_fd;
-	/* The list of Guest devices, based on command line arguments. */
-	struct device_list device_list;
 	/* The boot information for the Guest. */
 	void *boot;
 	/* If they specify an initrd file to load. */
@@ -1369,11 +1590,12 @@ int main(int argc, char *argv[])
 	 * device receive input from a file descriptor, we keep an fdset
 	 * (infds) and the maximum fd number (max_infd) with the head of the
 	 * list.  We also keep a pointer to the last device, for easy appending
-	 * to the list. */
-	device_list.max_infd = -1;
-	device_list.dev = NULL;
-	device_list.lastdev = &device_list.dev;
-	FD_ZERO(&device_list.infds);
+	 * to the list.  Finally, we keep the next interrupt number to hand out
+	 * (1: remember that 0 is used by the timer). */
+	FD_ZERO(&devices.infds);
+	devices.max_infd = -1;
+	devices.lastdev = &devices.dev;
+	devices.next_irq = 1;
 
 	/* We need to know how much memory so we can set up the device
 	 * descriptor and memory pages for the devices as we parse the command
@@ -1390,7 +1612,7 @@ int main(int argc, char *argv[])
 						      + DEVICE_PAGES);
 			guest_limit = mem;
 			guest_max = mem + DEVICE_PAGES*getpagesize();
-			device_list.descs = get_pages(1);
+			devices.descpage = get_pages(1);
 			break;
 		}
 	}
@@ -1401,14 +1623,11 @@ int main(int argc, char *argv[])
 		case 'v':
 			verbose = true;
 			break;
-		case 's':
-			setup_net_file(optarg, &device_list);
-			break;
 		case 't':
-			setup_tun_net(optarg, &device_list);
+			setup_tun_net(optarg);
 			break;
 		case 'b':
-			setup_block_file(optarg, &device_list);
+			setup_block_file(optarg);
 			break;
 		case 'i':
 			initrd_name = optarg;
@@ -1426,7 +1645,7 @@ int main(int argc, char *argv[])
 	verbose("Guest base is at %p\n", guest_base);
 
 	/* We always have a console device */
-	setup_console(&device_list);
+	setup_console();
 
 	/* Now we load the kernel */
 	start = load_kernel(open_or_die(argv[optind+1], O_RDONLY));
@@ -1468,10 +1687,10 @@ int main(int argc, char *argv[])
 	/* We fork off a child process, which wakes the Launcher whenever one
 	 * of the input file descriptors needs attention.  Otherwise we would
 	 * run the Guest until it tries to output something. */
-	waker_fd = setup_waker(lguest_fd, &device_list);
+	waker_fd = setup_waker(lguest_fd);
 
 	/* Finally, run the Guest.  This doesn't return. */
-	run_guest(lguest_fd, &device_list);
+	run_guest(lguest_fd);
 }
 /*:*/
 

--
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
