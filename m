From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH 3/5] lguest: separate out virtqueue info from device info.
Date: Thu, 20 Mar 2008 17:36:01 +1100
Message-ID: <200803201736.01883.rusty__30303.2502452426$1205995146$gmane$org@rustcorp.com.au>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<200803201705.44422.rusty@rustcorp.com.au>
	<200803201722.53636.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201722.53636.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, lguest <lguest@ozlabs.org>
List-Id: virtualization@lists.linuxfoundation.org

To deal with other Guest's virtqueue, we need to separate out the
parts of the structure which deal with the actual virtqueue from
configuration information and the device.  Then we can change the
virtqueue descriptor handling functions to take that smaller
structure.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c |  142 ++++++++++++++++++++++--------------------
 1 file changed, 76 insertions(+), 66 deletions(-)

diff -r 49ed4fa72c7c Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c	Mon Mar 17 15:33:54 2008 +1100
+++ b/Documentation/lguest/lguest.c	Mon Mar 17 22:33:20 2008 +1100
@@ -148,6 +148,18 @@ struct device
 };
 
 /* The virtqueue structure describes a queue attached to a device. */
+struct virtqueue_info
+{
+	/* The memory this virtqueue sits in (usually gmem, our Guest). */
+	struct guest_memory *mem;
+
+	/* The actual ring of buffers. */
+	struct vring vring;
+
+	/* Last available index we saw. */
+	u16 last_avail_idx;
+};
+
 struct virtqueue
 {
 	struct virtqueue *next;
@@ -158,11 +170,8 @@ struct virtqueue
 	/* The configuration for this queue. */
 	struct lguest_vqconfig config;
 
-	/* The actual ring of buffers. */
-	struct vring vring;
-
-	/* Last available index we saw. */
-	u16 last_avail_idx;
+	/* Information about the Guest's virtqueue. */
+	struct virtqueue_info vqi;
 
 	/* The routine to call when the Guest pings us. */
 	void (*handle_output)(int fd, struct virtqueue *me);
@@ -656,7 +665,7 @@ static void *_check_pointer(unsigned lon
 		errx(1, "%s:%i: Invalid address %#lx", __FILE__, line, addr);
 	/* We return a pointer for the caller's convenience, now we know it's
 	 * safe to use. */
-	return from_guest_phys(&gmem, addr);
+	return from_guest_phys(mem, addr);
 }
 /* A macro which transparently hands the line number to the real function. */
 #define check_pointer(mem,addr,size) _check_pointer(addr, size, mem, __LINE__)
@@ -664,20 +673,20 @@ static void *_check_pointer(unsigned lon
 /* Each buffer in the virtqueues is actually a chain of descriptors.  This
  * function returns the next descriptor in the chain, or vq->vring.num if we're
  * at the end. */
-static unsigned next_desc(struct virtqueue *vq, unsigned int i)
+static unsigned next_desc(struct virtqueue_info *vqi, unsigned int i)
 {
 	unsigned int next;
 
 	/* If this descriptor says it doesn't chain, we're done. */
-	if (!(vq->vring.desc[i].flags & VRING_DESC_F_NEXT))
-		return vq->vring.num;
+	if (!(vqi->vring.desc[i].flags & VRING_DESC_F_NEXT))
+		return vqi->vring.num;
 
 	/* Check they're not leading us off end of descriptors. */
-	next = vq->vring.desc[i].next;
+	next = vqi->vring.desc[i].next;
 	/* Make sure compiler knows to grab that: we don't want it changing! */
 	wmb();
 
-	if (next >= vq->vring.num)
+	if (next >= vqi->vring.num)
 		errx(1, "Desc next is %u", next);
 
 	return next;
@@ -688,29 +697,29 @@ static unsigned next_desc(struct virtque
  * number of output then some number of input descriptors, it's actually two
  * iovecs, but we pack them into one and note how many of each there were.
  *
- * This function returns the descriptor number found, or vq->vring.num (which
- * is never a valid descriptor number) if none was found. */
-static unsigned get_vq_desc(struct virtqueue *vq,
-			    struct iovec iov[],
-			    unsigned int *out_num, unsigned int *in_num)
+ * This function returns the descriptor number found, or -1 if none was
+ * found. */
+static int get_vq_desc(struct virtqueue_info *vqi,
+		       struct iovec iov[],
+		       unsigned int *out_num, unsigned int *in_num)
 {
 	unsigned int i, head;
 
 	/* Check it isn't doing very strange things with descriptor numbers. */
-	if ((u16)(vq->vring.avail->idx - vq->last_avail_idx) > vq->vring.num)
+	if ((u16)(vqi->vring.avail->idx - vqi->last_avail_idx) > vqi->vring.num)
 		errx(1, "Guest moved used index from %u to %u",
-		     vq->last_avail_idx, vq->vring.avail->idx);
+		     vqi->last_avail_idx, vqi->vring.avail->idx);
 
 	/* If there's nothing new since last we looked, return invalid. */
-	if (vq->vring.avail->idx == vq->last_avail_idx)
-		return vq->vring.num;
+	if (vqi->vring.avail->idx == vqi->last_avail_idx)
+		return -1;
 
 	/* Grab the next descriptor number they're advertising, and increment
 	 * the index we've seen. */
-	head = vq->vring.avail->ring[vq->last_avail_idx++ % vq->vring.num];
+	head = vqi->vring.avail->ring[vqi->last_avail_idx++ % vqi->vring.num];
 
 	/* If their number is silly, that's a fatal mistake. */
-	if (head >= vq->vring.num)
+	if (head >= vqi->vring.num)
 		errx(1, "Guest says index %u is available", head);
 
 	/* When we start there are none of either input nor output. */
@@ -719,12 +728,12 @@ static unsigned get_vq_desc(struct virtq
 	i = head;
 	do {
 		/* Grab the first descriptor, and check it's OK. */
-		iov[*out_num + *in_num].iov_len = vq->vring.desc[i].len;
+		iov[*out_num + *in_num].iov_len = vqi->vring.desc[i].len;
 		iov[*out_num + *in_num].iov_base
-			= check_pointer(&gmem, vq->vring.desc[i].addr,
-					vq->vring.desc[i].len);
+			= check_pointer(vqi->mem, vqi->vring.desc[i].addr,
+					vqi->vring.desc[i].len);
 		/* If this is an input descriptor, increment that count. */
-		if (vq->vring.desc[i].flags & VRING_DESC_F_WRITE)
+		if (vqi->vring.desc[i].flags & VRING_DESC_F_WRITE)
 			(*in_num)++;
 		else {
 			/* If it's an output descriptor, they're all supposed
@@ -735,27 +744,27 @@ static unsigned get_vq_desc(struct virtq
 		}
 
 		/* If we've got too many, that implies a descriptor loop. */
-		if (*out_num + *in_num > vq->vring.num)
+		if (*out_num + *in_num > vqi->vring.num)
 			errx(1, "Looped descriptor");
-	} while ((i = next_desc(vq, i)) != vq->vring.num);
+	} while ((i = next_desc(vqi, i)) != vqi->vring.num);
 
 	return head;
 }
 
 /* After we've used one of their buffers, we tell them about it.  We'll then
  * want to send them an interrupt, using trigger_irq(). */
-static void add_used(struct virtqueue *vq, unsigned int head, int len)
+static void add_used(struct virtqueue_info *vqi, unsigned int head, int len)
 {
 	struct vring_used_elem *used;
 
 	/* The virtqueue contains a ring of used buffers.  Get a pointer to the
 	 * next entry in that used ring. */
-	used = &vq->vring.used->ring[vq->vring.used->idx % vq->vring.num];
+	used = &vqi->vring.used->ring[vqi->vring.used->idx % vqi->vring.num];
 	used->id = head;
 	used->len = len;
 	/* Make sure buffer is written before we update index. */
 	wmb();
-	vq->vring.used->idx++;
+	vqi->vring.used->idx++;
 }
 
 /* This actually sends the interrupt for this virtqueue */
@@ -764,7 +773,7 @@ static void trigger_irq(int fd, struct v
 	unsigned long buf[] = { LHREQ_IRQ, vq->config.irq };
 
 	/* If they don't want an interrupt, don't send one. */
-	if (vq->vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)
+	if (vq->vqi.vring.avail->flags & VRING_AVAIL_F_NO_INTERRUPT)
 		return;
 
 	/* Send the Guest an interrupt tell them we used something up. */
@@ -776,7 +785,7 @@ static void add_used_and_trigger(int fd,
 static void add_used_and_trigger(int fd, struct virtqueue *vq,
 				 unsigned int head, int len)
 {
-	add_used(vq, head, len);
+	add_used(&vq->vqi, head, len);
 	trigger_irq(fd, vq);
 }
 
@@ -803,17 +812,17 @@ struct console_abort
 /* This is the routine which handles console input (ie. stdin). */
 static bool handle_console_input(int fd, struct device *dev)
 {
-	int len;
-	unsigned int head, in_num, out_num;
-	struct iovec iov[dev->vq->vring.num];
+	int len, head;
+	unsigned int in_num, out_num;
+	struct iovec iov[dev->vq->vqi.vring.num];
 	struct console_abort *abort = dev->priv;
 
 	/* First we need a console buffer from the Guests's input virtqueue. */
-	head = get_vq_desc(dev->vq, iov, &out_num, &in_num);
+	head = get_vq_desc(&dev->vq->vqi, iov, &out_num, &in_num);
 
 	/* If they're not ready for input, stop listening to this file
 	 * descriptor.  We'll start again once they add an input buffer. */
-	if (head == dev->vq->vring.num)
+	if (head < 0)
 		return false;
 
 	if (out_num)
@@ -872,12 +881,12 @@ static bool handle_console_input(int fd,
  * and write them to stdout. */
 static void handle_console_output(int fd, struct virtqueue *vq)
 {
-	unsigned int head, out, in;
-	int len;
-	struct iovec iov[vq->vring.num];
+	unsigned int out, in;
+	int head, len;
+	struct iovec iov[vq->vqi.vring.num];
 
 	/* Keep getting output buffers from the Guest until we run out. */
-	while ((head = get_vq_desc(vq, iov, &out, &in)) != vq->vring.num) {
+	while ((head = get_vq_desc(&vq->vqi, iov, &out, &in)) >= 0) {
 		if (in)
 			errx(1, "Input buffers in output queue?");
 		len = writev(STDOUT_FILENO, iov, out);
@@ -1003,17 +1012,17 @@ static void complete_net_setup(struct de
  * and write them to this device's file descriptor (the tap device). */
 static void handle_net_output(int fd, struct virtqueue *vq)
 {
-	unsigned int head, out, in;
-	int len;
+	unsigned int out, in;
+	int head, len;
 	struct net_priv *priv = vq->dev->priv;
-	struct iovec iov[vq->vring.num];
+	struct iovec iov[vq->vqi.vring.num];
 
 	/* We might not know whether this Guest speaks GSO until now. */
 	if (!priv->done_setup)
 		complete_net_setup(vq->dev);
 
 	/* Keep getting output buffers from the Guest until we run out. */
-	while ((head = get_vq_desc(vq, iov, &out, &in)) != vq->vring.num) {
+	while ((head = get_vq_desc(&vq->vqi, iov, &out, &in)) >= 0) {
 		if (in)
 			errx(1, "Input buffers in output queue?");
 
@@ -1035,10 +1044,10 @@ static void handle_net_output(int fd, st
  * Guest. */
 static bool handle_tun_input(int fd, struct device *dev)
 {
-	unsigned int head, in_num, out_num;
-	int len;
+	unsigned int in_num, out_num;
+	int head, len;
 	struct net_priv *priv = dev->priv;
-	struct iovec iov[dev->vq->vring.num];
+	struct iovec iov[dev->vq->vqi.vring.num];
 
 	/* We might not know whether this Guest speaks GSO until now. */
 	if (!priv->done_setup) {
@@ -1049,8 +1058,8 @@ static bool handle_tun_input(int fd, str
 	}
 
 	/* First we need a network buffer from the Guests's recv virtqueue. */
-	head = get_vq_desc(dev->vq, iov, &out_num, &in_num);
-	if (head == dev->vq->vring.num) {
+	head = get_vq_desc(&dev->vq->vqi, iov, &out_num, &in_num);
+	if (head < 0) {
 		/* FIXME: Only do this if DRIVER_ACTIVE. */
 		warn("network: no dma buffer!");
 		/* We'll turn this back on if input buffers are registered. */
@@ -1082,7 +1091,7 @@ static bool handle_tun_input(int fd, str
 
 	verbose("tun input packet len %i [%02x %02x] (%s)\n", len,
 		((u8 *)iov[1].iov_base)[0], ((u8 *)iov[1].iov_base)[1],
-		head != dev->vq->vring.num ? "sent" : "discarded");
+		head >= 0 ? "sent" : "discarded");
 
 	/* All good. */
 	return true;
@@ -1113,9 +1122,9 @@ static void reset_device(struct device *
 
 	/* Zero out the virtqueues. */
 	for (vq = dev->vq; vq; vq = vq->next) {
-		memset(vq->vring.desc, 0,
+		memset(vq->vqi.vring.desc, 0,
 		       vring_size(vq->config.num, getpagesize()));
-		vq->last_avail_idx = 0;
+		vq->vqi.last_avail_idx = 0;
 	}
 }
 
@@ -1262,8 +1271,9 @@ static void add_virtqueue(struct device 
 
 	/* Initialize the virtqueue */
 	vq->next = NULL;
-	vq->last_avail_idx = 0;
 	vq->dev = dev;
+	vq->vqi.last_avail_idx = 0;
+	vq->vqi.mem = &gmem;
 
 	/* Initialize the configuration. */
 	vq->config.num = num_descs;
@@ -1271,7 +1281,7 @@ static void add_virtqueue(struct device 
 	vq->config.pfn = to_guest_phys(&gmem, p) / getpagesize();
 
 	/* Initialize the vring. */
-	vring_init(&vq->vring, num_descs, p, getpagesize());
+	vring_init(&vq->vqi.vring, num_descs, p, getpagesize());
 
 	/* Append virtqueue to this device's descriptor.  We use
 	 * device_config() to get the end of the device's current virtqueues;
@@ -1295,7 +1305,7 @@ static void add_virtqueue(struct device 
 	/* As an optimization, set the advisory "Don't Notify Me" flag if we
 	 * don't have a handler */
 	if (!handle_output)
-		vq->vring.used->flags = VRING_USED_F_NO_NOTIFY;
+		vq->vqi.vring.used->flags = VRING_USED_F_NO_NOTIFY;
 }
 
 /* The first half of the feature bitmask is for us to advertise features.  The
@@ -1508,16 +1518,16 @@ static bool service_io(struct device *de
 static bool service_io(struct device *dev)
 {
 	struct vblk_info *vblk = dev->priv;
-	unsigned int head, out_num, in_num, wlen;
-	int ret;
+	unsigned int out_num, in_num, wlen;
+	int head, ret;
 	struct virtio_blk_inhdr *in;
 	struct virtio_blk_outhdr *out;
-	struct iovec iov[dev->vq->vring.num];
+	struct iovec iov[dev->vq->vqi.vring.num];
 	off64_t off;
 
 	/* See if there's a request waiting.  If not, nothing to do. */
-	head = get_vq_desc(dev->vq, iov, &out_num, &in_num);
-	if (head == dev->vq->vring.num)
+	head = get_vq_desc(&dev->vq->vqi, iov, &out_num, &in_num);
+	if (head < 0)
 		return false;
 
 	/* Every block request should contain at least one output buffer
@@ -1587,7 +1597,7 @@ static bool service_io(struct device *de
 
 	/* We can't trigger an IRQ, because we're not the Launcher.  It does
 	 * that when we tell it we're done. */
-	add_used(dev->vq, head, wlen);
+	add_used(&dev->vq->vqi, head, wlen);
 	return true;
 }
 
@@ -1722,15 +1732,15 @@ static bool handle_rng_input(int fd, str
 {
 	int len;
 	unsigned int head, in_num, out_num;
-	struct iovec iov[dev->vq->vring.num];
+	struct iovec iov[dev->vq->vqi.vring.num];
 
 	printf("Got input on rng fd!\n");
 	/* First we need a buffer from the Guests's virtqueue. */
-	head = get_vq_desc(dev->vq, iov, &out_num, &in_num);
+	head = get_vq_desc(&dev->vq->vqi, iov, &out_num, &in_num);
 
 	/* If they're not ready for input, stop listening to this file
 	 * descriptor.  We'll start again once they add an input buffer. */
-	if (head == dev->vq->vring.num) {
+	if (head < 0) {
 		printf("But no buffer!\n");
 		return false;
 	}
