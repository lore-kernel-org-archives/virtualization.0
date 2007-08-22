From: Rusty Russell <rusty@rustcorp.com.au>
Subject: RE: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Wed, 22 Aug 2007 13:29:25 +1000
Message-ID: <1187753365.6174.26.camel__34823.8308601596$1187753627$gmane$org@localhost.localdomain>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>
	<1187313953.6449.70.camel@localhost.localdomain>
	<1187328402.4363.110.camel@ghaskins-t60p.haskins.net>
	<1187336618.6449.106.camel@localhost.localdomain>
	<1187358614.4363.135.camel@ghaskins-t60p.haskins.net>
	<1187652496.19435.141.camel@localhost.localdomain>
	<64F9B87B6B770947A9F8391472E032160D464FEB@ehost011-8.exch011.intermedia.net>
	<1187683122.19435.171.camel@localhost.localdomain>
	<1187697638.4363.277.camel@ghaskins-t60p.haskins.net>
	<1187704038.19435.194.camel@localhost.localdomain>
	<1187705162.4363.323.camel@ghaskins-t60p.haskins.net>
	<1187714864.4363.358.camel@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187714864.4363.358.camel@ghaskins-t60p.haskins.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <ghaskins@novell.com>
Cc: kvm-devel@lists.sourceforge.net, Dor Laor <dor.laor@qumranet.com>, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-08-21 at 12:47 -0400, Gregory Haskins wrote:
> On Tue, 2007-08-21 at 10:06 -0400, Gregory Haskins wrote:
> > On Tue, 2007-08-21 at 23:47 +1000, Rusty Russell wrote:
> > > 
> > > 	In the guest -> host direction, an interface like virtio is designed
> > > for batching, with the explicit distinction between add_buf & sync.
> > 
> > Right.  IOQ has "iter_push()" and "signal()" as synonymous operations.
> 
> Hi Rusty,
>   This reminded me of an area that I thought might have been missing in
> virtio compared to IOQ.  That is, flexibility in the io-completion via
> the distinction between "signal" and "sync".  sync() implies that its a
> blocking call based on the full drain of the queue, correct?  the
> ioq_signal() operation is purely a "kick".  You can, of course, still
> implement synchronous functions with a higher layer construct such as
> the ioq->wq.

Hi Gregory,

	You raise a good point.  We should rename "sync" to "kick".  Clear
names are very important.

> Is there a way to do something similar in virtio? (and forgive me if
> there is..I still haven't seen the code).  And if not and people like
> that idea, what would be a good way to add it to the interface?

I had two implementations, an efficient descriptor based one and a dumb
dumb dumb 1-char copying-based one.  I let the latter one rot; it was
sufficient for me to convince myself that it was possible to create an
implementation which uses such a transport.

(Nonetheless, it's kinda boring to maintain so it wasn't updated for the
lastest draft of the virtio API).

Here's the lguest "efficient" implementation, which could still use some
love:

===
More efficient lguest implementation of virtio, using descriptors.

This allows zero-copy from guest <-> host.  It uses a page of
descriptors, a page to say what descriptors to use, and a page to say
what's been used: one each set for inbufs and one for outbufs.

TODO:
1) More polishing
2) Get rid of old I/O
3) Inter-guest I/O implementation

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c   |  412 +++++++++++++++++++++++++++++++++
 drivers/lguest/Makefile         |    2 
 drivers/lguest/hypercalls.c     |    4 
 drivers/lguest/lguest_virtio.c  |  476 +++++++++++++++++++++++++++++++++++++++
 include/asm-i386/lguest_hcall.h |    3 
 include/linux/lguest_launcher.h |   26 ++
 6 files changed, 914 insertions(+), 9 deletions(-)

===================================================================
--- a/Documentation/lguest/lguest.c
+++ b/Documentation/lguest/lguest.c
@@ -5,6 +5,8 @@
 #define _LARGEFILE64_SOURCE
 #define _GNU_SOURCE
 #include <stdio.h>
+#include <sched.h>
+#include <assert.h>
 #include <string.h>
 #include <unistd.h>
 #include <err.h>
@@ -43,6 +45,7 @@ typedef uint16_t u16;
 typedef uint16_t u16;
 typedef uint8_t u8;
 #include "../../include/linux/lguest_launcher.h"
+#include "../../include/linux/virtio_blk.h"
 #include "../../include/asm/e820.h"
 /*:*/
 
@@ -55,6 +58,8 @@ typedef uint8_t u8;
 /* We can have up to 256 pages for devices. */
 #define DEVICE_PAGES 256
 
+#define descs_per_page() (getpagesize() / sizeof(struct lguest_desc))
+
 /*L:120 verbose is both a global flag and a macro.  The C preprocessor allows
  * this, and although I wouldn't recommend it, it works quite nicely here. */
 static bool verbose;
@@ -106,6 +111,8 @@ struct device
 	unsigned long watch_key;
 	u32 (*handle_output)(int fd, const struct iovec *iov,
 			     unsigned int num, struct device *me);
+	/* Alternative to handle_output */
+	void (*handle_notify)(int fd, struct device *me);
 
 	/* Device-specific data. */
 	void *priv;
@@ -956,17 +963,21 @@ static void handle_output(int fd, unsign
 	struct iovec iov[LGUEST_MAX_DMA_SECTIONS];
 	unsigned num = 0;
 
-	/* Convert the "struct lguest_dma" they're sending to a "struct
-	 * iovec". */
-	lenp = dma2iov(dma, iov, &num);
-
 	/* Check each device: if they expect output to this key, tell them to
 	 * handle it. */
 	for (i = devices->dev; i; i = i->next) {
-		if (i->handle_output && key == i->watch_key) {
-			/* We write the result straight into the used_len field
-			 * for them. */
+		if (key != i->watch_key)
+			continue;
+
+		if (i->handle_output) {
+			/* Convert the "struct lguest_dma" they're sending to a
+			 * "struct iovec". */
+			lenp = dma2iov(dma, iov, &num);
 			*lenp = i->handle_output(fd, iov, num, i);
+			return;
+		} else if (i->handle_notify) {
+			/* virtio-style notify. */
+			i->handle_notify(fd, i);
 			return;
 		}
 	}
@@ -1079,6 +1090,7 @@ static struct device *new_device(struct 
 	dev->handle_input = handle_input;
 	dev->watch_key = to_guest_phys(dev->mem) + watch_off;
 	dev->handle_output = handle_output;
+	dev->handle_notify = NULL;
 	return dev;
 }
 
@@ -1354,7 +1366,383 @@ static void setup_tun_net(const char *ar
 	if (br_name)
 		verbose("attached to bridge: %s\n", br_name);
 }
-/* That's the end of device setup. */
+/* That's the end of device setup. :*/
+
+struct virtqueue_info
+{
+	/* Their page of descriptors. */
+	struct lguest_desc *desc;
+	/* How they tell us what buffers are available. */
+	unsigned int *avail_idx;
+	unsigned int *available;
+	/* How we tell them what we've used. */
+	unsigned int *used_idx;
+	struct lguest_used *used;
+
+	/* Last available index we saw. */
+	unsigned int last_avail_idx;
+};
+
+static unsigned int irq_of(struct device *dev)
+{
+	/* Interrupt is index of device + 1 */
+	return ((unsigned long)dev->desc % getpagesize())
+		/ sizeof(struct lguest_device_desc) + 1;
+}
+
+/* Descriptors consist of output then input descs. */
+static void gather_desc(struct lguest_desc *desc,
+			unsigned int i,
+			struct iovec iov[],
+			unsigned int *out_num, unsigned int *in_num)
+{
+	*out_num = *in_num = 0;
+
+	for (;;) {
+		iov[*out_num + *in_num].iov_len = desc[i].len;
+		iov[*out_num + *in_num].iov_base
+			= check_pointer(desc[i].pfn * getpagesize()
+					+ desc[i].offset,
+					desc[i].len);
+		if (desc[i].flags & LGUEST_DESC_F_WRITE)
+			(*in_num)++;
+		else {
+			if (*in_num)
+				errx(1, "Descriptor has out after in");
+			(*out_num)++;
+		}
+		if (!(desc[i].flags & LGUEST_DESC_F_NEXT))
+			break;
+		if (*out_num + *in_num == descs_per_page())
+			errx(1, "Looped descriptor");
+		i = desc[i].next;
+		if (i >= descs_per_page())
+			errx(1, "Desc next is %u", i);
+		if (desc[i].flags & LGUEST_DESC_F_HEAD)
+			errx(1, "Descriptor has middle head at %i", i);
+	}
+}
+
+/* We've used a buffer, tell them about it. */
+static void add_used(struct virtqueue_info *vqi, unsigned int id, int len)
+{
+	struct lguest_used *used;
+
+	used = &vqi->used[(*vqi->used_idx)++ % descs_per_page()];
+	used->id = id;
+	used->len = len;
+}
+
+/* See if they have a buffer for us. */
+static unsigned int get_available(struct virtqueue_info *vqi)
+{
+	unsigned int num;
+
+	if (*vqi->avail_idx - vqi->last_avail_idx > descs_per_page())
+		errx(1, "Guest moved used index from %u to %u",
+		     vqi->last_avail_idx, *vqi->avail_idx);
+
+	if (*vqi->avail_idx == vqi->last_avail_idx)
+		return descs_per_page();
+
+	num = vqi->available[vqi->last_avail_idx++ % descs_per_page()];
+	if (num >= descs_per_page())
+		errx(1, "Guest says index %u is available", num);
+	return num;
+}
+
+static void setup_virtqueue_info(struct virtqueue_info *vqi, void *mem)
+{
+	/* Descriptor page, available page, other side's used page */
+	vqi->desc = mem;
+	vqi->avail_idx = mem + getpagesize();
+	vqi->available = (void *)(vqi->avail_idx + 1);
+	vqi->used_idx = mem + getpagesize()*2;
+	vqi->used = (void *)(vqi->used_idx + 1);
+	vqi->last_avail_idx = 0;
+}
+
+struct virtnet_info
+{
+	struct virtqueue_info in, out;
+};
+
+static bool handle_virtnet_input(int fd, struct device *dev)
+{
+	int len;
+	unsigned out_num, in_num, desc;
+	struct virtnet_info *vni = dev->priv;
+	struct iovec iov[descs_per_page()];
+
+	/* Find any input descriptor head. */
+	desc = get_available(&vni->in);
+	if (desc == descs_per_page()) {
+		if (dev->desc->status & LGUEST_DEVICE_S_DRIVER_OK)
+			warnx("network: no dma buffer!");
+		discard_iovec(iov, &in_num);
+	} else {
+		gather_desc(vni->in.desc, desc, iov, &out_num, &in_num);
+		if (out_num != 0)
+			errx(1, "network: output in receive queue?");
+	}
+
+	len = readv(dev->fd, iov, in_num);
+	if (len <= 0)
+		err(1, "reading network");
+
+	if (desc != descs_per_page()) {
+		add_used(&vni->in, desc, len);
+		trigger_irq(fd, irq_of(dev));
+	}
+	verbose("virt input packet len %i [%02x %02x] (%s)\n", len,
+		((u8 *)iov[0].iov_base)[0], ((u8 *)iov[0].iov_base)[1],
+		desc == descs_per_page() ? "discarded" : "sent");
+	return true;
+}
+
+static void handle_virtnet_notify(int fd, struct device *dev)
+{
+	unsigned desc, out_num, in_num;
+	int len;
+	struct virtnet_info *vni = dev->priv;
+	struct iovec iov[descs_per_page()];
+
+	/* Send all output descriptors. */
+	while ((desc = get_available(&vni->out)) < descs_per_page()) {
+		gather_desc(vni->out.desc, desc, iov, &out_num, &in_num);
+		if (in_num != 0)
+			errx(1, "network: recv descs in output queue?");
+		len = writev(dev->fd, iov, out_num);
+		add_used(&vni->out, desc, 0);
+	}
+	trigger_irq(fd, irq_of(dev));
+}
+
+static void setup_virtnet(const char *arg, struct device_list *devices)
+{
+	struct device *dev;
+	struct virtnet_info *vni;
+	struct ifreq ifr;
+	int netfd, ipfd;
+	unsigned char mac[6];
+	u32 ip;
+
+	netfd = open_or_die("/dev/net/tun", O_RDWR);
+	memset(&ifr, 0, sizeof(ifr));
+	ifr.ifr_flags = IFF_TAP | IFF_NO_PI;
+	strcpy(ifr.ifr_name, "tap%d");
+	if (ioctl(netfd, TUNSETIFF, &ifr) != 0)
+		err(1, "configuring /dev/net/tun");
+	ioctl(netfd, TUNSETNOCSUM, 1);
+
+	/* Three pages for in, three for out. */
+	dev = new_device(devices, LGUEST_DEVICE_T_VIRTNET, 6,
+			 LGUEST_DEVICE_F_RANDOMNESS, netfd,
+			 handle_virtnet_input, 0, NULL);
+	dev->handle_notify = handle_virtnet_notify;
+	dev->priv = vni = malloc(sizeof(*vni));
+
+	setup_virtqueue_info(&vni->in, dev->mem);
+	setup_virtqueue_info(&vni->out, dev->mem + 3 * getpagesize());
+
+	ipfd = socket(PF_INET, SOCK_DGRAM, IPPROTO_IP);
+	if (ipfd < 0)
+		err(1, "opening IP socket");
+
+	ip = str2ip(arg);
+
+	configure_device(ipfd, ifr.ifr_name, ip, mac);
+
+	close(ipfd);
+
+	verbose("device %p: virt net %u.%u.%u.%u\n",
+		(void *)(dev->desc->pfn * getpagesize()),
+		(u8)(ip>>24), (u8)(ip>>16), (u8)(ip>>8), (u8)ip);
+}
+
+static unsigned long iovec_len(const struct iovec iov[], unsigned int num)
+{
+	unsigned int i;
+	unsigned long len = 0;
+
+	for (i = 0; i < num; i++) {
+		if (len + iov[i].iov_len < len)
+			errx(1, "iovec length wrap");
+		len += iov[i].iov_len;
+	}
+	return len;
+}
+
+struct vblk_info
+{
+	struct virtqueue_info vqi;
+	const char *blkname;
+	off64_t len;
+	u16 last_tag;
+	unsigned int in_progress;
+	int finished_fd;
+	int workpipe[2];
+};
+
+static void do_vblk_seek(int blkfd, off64_t maxlen, u64 sector, unsigned len)
+{
+	if (sector * 512 > maxlen || sector * 512 + len > maxlen)
+		errx(1, "Bad length %u at offset %llu", len, sector * 512);
+
+	if (lseek64(blkfd, sector * 512, SEEK_SET) != sector * 512)
+		err(1, "Bad seek to sector %llu", sector);
+}
+
+static unsigned service_io(struct vblk_info *vblk, int blkfd, unsigned desc)
+{
+	unsigned int wlen, out_num, in_num;
+	int len, ret;
+	struct virtio_blk_inhdr *in;
+	struct virtio_blk_outhdr *out;
+	struct iovec iov[descs_per_page()];
+
+	gather_desc(vblk->vqi.desc, desc, iov, &out_num, &in_num);
+	if (out_num == 0 || in_num == 0)
+		errx(1, "Bad virtblk cmd %u out=%u in=%u",
+		     desc, out_num, in_num);
+
+	if (iov[0].iov_len != sizeof(*out))
+		errx(1, "Bad virtblk cmd len %i", iov[0].iov_len);
+	out = iov[0].iov_base;
+
+	if (iov[out_num+in_num-1].iov_len != sizeof(*in))
+		errx(1, "Bad virtblk input len %i for %u",
+		     iov[out_num+in_num-1].iov_len, desc);
+	in = iov[out_num+in_num-1].iov_base;
+
+	if (out->type & VIRTIO_BLK_T_SCSI_CMD) {
+		fprintf(stderr, "Scsi commands unsupported\n");
+		in->status = VIRTIO_BLK_S_UNSUPP;
+		wlen = sizeof(in);
+	} else if (out->type & VIRTIO_BLK_T_OUT) {
+		/* Write */
+		len = iovec_len(iov+1, out_num-1);
+		do_vblk_seek(blkfd, vblk->len, out->sector, len);
+
+		verbose("WRITE %u to sector %llu\n", len, out->sector);
+		ret = writev(blkfd, iov+1, out_num-1);
+		in->status = (ret==len ? VIRTIO_BLK_S_OK : VIRTIO_BLK_S_IOERR);
+		wlen = sizeof(in);
+	} else {
+		/* Read */
+		len = iovec_len(iov+1, in_num-1);
+		do_vblk_seek(blkfd, vblk->len, out->sector, len);
+
+		verbose("READ %u to sector %llu\n", len, out->sector);
+		ret = readv(blkfd, iov+1, in_num-1);
+		in->status = (ret==len ? VIRTIO_BLK_S_OK : VIRTIO_BLK_S_IOERR);
+		wlen = sizeof(in) + len;
+	}
+
+	return wlen;
+}
+
+static struct virtio_blk_outhdr *get_outhdr(struct lguest_desc *desc,
+					    unsigned int i)
+{
+	return check_pointer(desc[i].pfn * getpagesize() + desc[i].offset,
+			     sizeof(struct virtio_blk_outhdr));
+}
+
+static bool handle_io_finish(int fd, struct device *dev)
+{
+	unsigned int nums[2];
+	struct vblk_info *vblk = dev->priv;
+
+	/* Find out what finished. */
+	if (read(dev->fd, nums, sizeof(nums)) != sizeof(nums))
+		err(1, "Short read from threads");
+
+	add_used(&vblk->vqi, nums[0], nums[1]);
+	trigger_irq(fd, irq_of(dev));
+	vblk->in_progress--;
+	return true;
+}
+
+static void handle_virtblk_notify(int fd, struct device *dev)
+{
+	unsigned desc;
+	struct vblk_info *vblk = dev->priv;
+
+	/* Send all output descriptors to threads to service. */
+	while ((desc = get_available(&vblk->vqi)) < descs_per_page()) {
+		struct virtio_blk_outhdr *outhdr;
+
+		outhdr = get_outhdr(vblk->vqi.desc, desc);
+		if (outhdr->type & VIRTIO_BLK_T_BARRIER) {
+			/* This sucks, goes sync to flush. */
+			while (vblk->in_progress)
+				handle_io_finish(fd, dev);
+			fdatasync(fd);
+		}
+		write(vblk->workpipe[1], &desc, sizeof(desc));
+		vblk->in_progress++;
+	}
+}
+
+static int io_thread(void *_dev)
+{
+	struct device *dev = _dev;
+	struct vblk_info *vblk = dev->priv;
+	unsigned num[2];
+	int fd;
+
+	fd = open_or_die(vblk->blkname, O_RDWR|O_LARGEFILE|O_DIRECT);
+
+	/* Close other side of workpipe so we get 0 read when main dies. */
+	close(vblk->workpipe[1]);
+	close(dev->fd);
+	close(STDIN_FILENO);
+	while (read(vblk->workpipe[0], &num[0], sizeof(num[0]))
+	       == sizeof(num[0])) {
+		num[1] = service_io(vblk, fd, num[0]);
+		if (write(vblk->finished_fd, num, sizeof(num)) != sizeof(num))
+			err(1, "Bad finish write");
+	}
+	return 0;
+}
+
+static void setup_virtblk(const char *filename, struct device_list *devices)
+{
+	int fd, p[2];
+	struct device *dev;
+	struct vblk_info *vblk;
+	unsigned int i;
+
+	fd = open_or_die(filename, O_RDWR|O_LARGEFILE);
+	pipe(p);
+	dev = new_device(devices, LGUEST_DEVICE_T_VIRTBLK, 6,
+			 LGUEST_DEVICE_F_RANDOMNESS,
+			 p[0], handle_io_finish, 0, NULL);
+	dev->handle_notify = handle_virtblk_notify;
+	vblk = dev->priv = malloc(sizeof(*vblk));
+
+	setup_virtqueue_info(&vblk->vqi, dev->mem);
+
+	vblk->blkname = filename;
+	vblk->len = lseek64(fd, 0, SEEK_END);
+	close(fd);
+	vblk->finished_fd = p[1];
+	vblk->last_tag = 0;
+	vblk->in_progress = 0;
+	pipe(vblk->workpipe);
+
+	for (i = 0; i < 4; i++) {
+		void *stack = malloc(32768);
+		if (clone(io_thread, stack + 32768, CLONE_VM, dev) == -1)
+			err(1, "Creating clone");
+	}
+
+	*(unsigned long *)dev->mem = vblk->len/512;
+	verbose("device %p: virtblock %lu sectors\n",
+		(void *)(dev->desc->pfn * getpagesize()),
+		*(unsigned long *)dev->mem);
+}
 
 /*L:220 Finally we reach the core of the Launcher, which runs the Guest, serves
  * its input and output, and finally, lays it to rest. */
@@ -1406,6 +1794,8 @@ static struct option opts[] = {
 	{ "sharenet", 1, NULL, 's' },
 	{ "tunnet", 1, NULL, 't' },
 	{ "block", 1, NULL, 'b' },
+	{ "virtnet", 1, NULL, 'V' },
+	{ "virtblock", 1, NULL, 'B' },
 	{ "initrd", 1, NULL, 'i' },
 	{ NULL },
 };
@@ -1477,6 +1867,12 @@ int main(int argc, char *argv[])
 		case 'b':
 			setup_block_file(optarg, &device_list);
 			break;
+		case 'V':
+			setup_virtnet(optarg, &device_list);
+			break;
+		case 'B':
+			setup_virtblk(optarg, &device_list);
+			break;
 		case 'i':
 			initrd_name = optarg;
 			break;
===================================================================
--- a/drivers/lguest/Makefile
+++ b/drivers/lguest/Makefile
@@ -1,5 +1,5 @@
 # Guest requires the arch-specific paravirt code, the bus driver and dma code.
-obj-$(CONFIG_LGUEST_GUEST) += lguest_bus.o lguest_dma.o
+obj-$(CONFIG_LGUEST_GUEST) += lguest_bus.o lguest_dma.o lguest_virtio.o
 
 # Host requires the other files, which can be a module.
 obj-$(CONFIG_LGUEST)	+= lg.o
===================================================================
--- a/drivers/lguest/hypercalls.c
+++ b/drivers/lguest/hypercalls.c
@@ -112,6 +112,10 @@ static void do_hcall(struct lguest *lg, 
 	case LHCALL_HALT:
 		/* Similarly, this sets the halted flag for run_guest(). */
 		lg->halted = 1;
+		break;
+	case LHCALL_NOTIFY:
+		lg->pending_key = regs->edx << PAGE_SHIFT;
+		lg->dma_is_pending = 1;
 		break;
 	default:
 		kill_guest(lg, "Bad hypercall %li\n", regs->eax);
===================================================================
--- /dev/null
+++ b/drivers/lguest/lguest_virtio.c
@@ -0,0 +1,476 @@
+/* Descriptor-based virtio backend using lguest. */
+
+/* FIXME: Put "running" in shared page so other side really doesn't
+ * send us interrupts.  Then we would never need to "fail" restart.
+ * If there are more buffers when we set "running", simply ping other
+ * side.  It would interrupt us back again.
+ */
+#define DEBUG
+#include <linux/lguest.h>
+#include <linux/lguest_bus.h>
+#include <linux/virtio.h>
+#include <linux/interrupt.h>
+#include <asm/io.h>
+
+#define NUM_DESCS (PAGE_SIZE / sizeof(struct lguest_desc))
+
+#ifdef DEBUG
+/* For development, we want to crash whenever the other side is bad. */
+#define BAD_SIDE(lvq, fmt...)			\
+	do { dev_err(&lvq->lg->dev, fmt); BUG(); } while(0)
+#define START_USE(lvq) \
+	do { if ((lvq)->in_use) panic("in_use = %i\n", (lvq)->in_use); (lvq)->in_use = __LINE__; mb(); } while(0)
+#define END_USE(lvq) \
+	do { BUG_ON(!(lvq)->in_use); (lvq)->in_use = 0; mb(); } while(0)
+#else
+#define BAD_SIDE(lvq, fmt...)			\
+	do { dev_err(&lvq->lg->dev, fmt); (lvq)->broken = true; } while(0)
+#define START_USE(lvq)
+#define END_USE(lvq)
+#endif
+
+struct desc_pages
+{
+	/* Page of descriptors. */
+	struct lguest_desc desc[NUM_DESCS];
+
+	/* Next page: how we tell other side what buffers are available. */
+	unsigned int avail_idx;
+	unsigned int available[NUM_DESCS];
+	char pad[PAGE_SIZE - (NUM_DESCS+1) * sizeof(unsigned int)];
+
+	/* Third page: how other side tells us what's used. */
+	unsigned int used_idx;
+	struct lguest_used used[NUM_DESCS];
+};
+
+struct lguest_virtqueue
+{
+	struct virtqueue vq;
+
+	/* Actual memory layout for this queue */
+	struct desc_pages *d;
+
+	struct lguest_device *lg;
+
+	/* Other side has made a mess, don't try any more. */
+	bool broken;
+
+	/* Number of free buffers */
+	unsigned int num_free;
+	/* Head of free buffer list. */
+	unsigned int free_head;
+	/* Number we've added since last sync. */
+	unsigned int num_added;
+
+	/* Last used index we've seen. */
+	unsigned int last_used_idx;
+
+	/* Unless they told us to stop */
+	bool running;
+
+#ifdef DEBUG
+	/* They're supposed to lock for us. */
+	unsigned int in_use;
+#endif
+
+	/* Tokens for callbacks. */
+	void *data[NUM_DESCS];
+};
+
+static inline struct lguest_virtqueue *vq_to_lvq(struct virtqueue *vq)
+{
+	return container_of(vq, struct lguest_virtqueue, vq);
+}
+
+static int lguest_add_buf(struct virtqueue *vq,
+			  struct scatterlist sg[],
+			  unsigned int out_num,
+			  unsigned int in_num,
+			  void *data)
+{
+	struct lguest_virtqueue *lvq = vq_to_lvq(vq);
+	unsigned int i, head, uninitialized_var(prev);
+
+	BUG_ON(data == NULL);
+	BUG_ON(out_num + in_num > NUM_DESCS);
+	BUG_ON(out_num + in_num == 0);
+
+	START_USE(lvq);
+
+	if (lvq->num_free < out_num + in_num) {
+		pr_debug("Can't add buf len %i - avail = %i\n",
+			 out_num + in_num, lvq->num_free);
+		END_USE(lvq);
+		return -ENOSPC;
+	}
+
+	/* We're about to use some buffers from the free list. */
+	lvq->num_free -= out_num + in_num;
+
+	head = lvq->free_head;
+	for (i = lvq->free_head; out_num; i=lvq->d->desc[i].next, out_num--) {
+		lvq->d->desc[i].flags = LGUEST_DESC_F_NEXT;
+		lvq->d->desc[i].pfn = page_to_pfn(sg[0].page);
+		lvq->d->desc[i].offset = sg[0].offset;
+		lvq->d->desc[i].len = sg[0].length;
+		prev = i;
+		sg++;
+	}
+	for (; in_num; i = lvq->d->desc[i].next, in_num--) {
+		lvq->d->desc[i].flags = LGUEST_DESC_F_NEXT|LGUEST_DESC_F_WRITE;
+		lvq->d->desc[i].pfn = page_to_pfn(sg[0].page);
+		lvq->d->desc[i].offset = sg[0].offset;
+		lvq->d->desc[i].len = sg[0].length;
+		prev = i;
+		sg++;
+	}
+	/* Last one doesn't continue. */
+	lvq->d->desc[prev].flags &= ~LGUEST_DESC_F_NEXT;
+
+	/* Update free pointer */
+	lvq->free_head = i;
+
+	lvq->data[head] = data;
+
+	/* Make head is only set after descriptor has been written. */
+	wmb();
+	lvq->d->desc[head].flags |= LGUEST_DESC_F_HEAD;
+
+	/* Advertise it in available array. */
+	lvq->d->available[(lvq->d->avail_idx + lvq->num_added++) % NUM_DESCS]
+		= head;
+
+	pr_debug("Added buffer head %i to %p\n", head, lvq);
+	END_USE(lvq);
+	return 0;
+}
+
+static void lguest_sync(struct virtqueue *vq)
+{
+	struct lguest_virtqueue *lvq = vq_to_lvq(vq);
+
+	START_USE(lvq);
+	/* LGUEST_DESC_F_HEAD needs to be set before we say they're avail. */
+	wmb();
+
+	lvq->d->avail_idx += lvq->num_added;
+	lvq->num_added = 0;
+
+	/* Prod other side to tell it about changes. */
+	hcall(LHCALL_NOTIFY, lguest_devices[lvq->lg->index].pfn, 0, 0);
+	END_USE(lvq);
+}
+
+static void __detach_buf(struct lguest_virtqueue *lvq, unsigned int head)
+{
+	unsigned int i;
+
+	lvq->d->desc[head].flags &= ~LGUEST_DESC_F_HEAD;
+	/* Make sure other side has seen that it's detached. */
+	wmb();
+	/* Put back on free list: find end */
+	i = head;
+	while (lvq->d->desc[i].flags&LGUEST_DESC_F_NEXT) {
+		i = lvq->d->desc[i].next;
+		lvq->num_free++;
+	}
+
+	lvq->d->desc[i].next = lvq->free_head;
+	lvq->free_head = head;
+	/* Plus final descriptor */
+	lvq->num_free++;
+}
+
+static int lguest_detach_buf(struct virtqueue *vq, void *data)
+{
+	struct lguest_virtqueue *lvq = vq_to_lvq(vq);
+	unsigned int i;
+
+	for (i = 0; i < NUM_DESCS; i++) {
+		if (lvq->data[i] == data
+		    && (lvq->d->desc[i].flags & LGUEST_DESC_F_HEAD)) {
+			__detach_buf(lvq, i);
+			return 0;
+		}
+	}
+	return -ENOENT;
+}
+
+static bool more_used(const struct lguest_virtqueue *lvq)
+{
+	return lvq->last_used_idx != lvq->d->used_idx;
+}
+
+static void *lguest_get_buf(struct virtqueue *vq, unsigned int *len)
+{
+	struct lguest_virtqueue *lvq = vq_to_lvq(vq);
+	unsigned int i;
+
+	START_USE(lvq);
+
+	if (!more_used(lvq)) {
+		END_USE(lvq);
+		return NULL;
+	}
+
+	/* Don't let them make us do infinite work. */
+	if (unlikely(lvq->d->used_idx > lvq->last_used_idx + NUM_DESCS)) {
+		BAD_SIDE(lvq, "Too many descriptors");
+		return NULL;
+	}
+
+	i = lvq->d->used[lvq->last_used_idx%NUM_DESCS].id;
+	*len = lvq->d->used[lvq->last_used_idx%NUM_DESCS].len;
+
+	if (unlikely(i >= NUM_DESCS)) {
+		BAD_SIDE(lvq, "id %u out of range\n", i);
+		return NULL;
+	}
+	if (unlikely(!(lvq->d->desc[i].flags & LGUEST_DESC_F_HEAD))) {
+		BAD_SIDE(lvq, "id %u is not a head!\n", i);
+		return NULL;
+	}
+
+	__detach_buf(lvq, i);
+	lvq->last_used_idx++;
+	BUG_ON(!lvq->data[i]);
+	END_USE(lvq);
+	return lvq->data[i];
+}
+
+static bool lguest_restart(struct virtqueue *vq)
+{
+	struct lguest_virtqueue *lvq = vq_to_lvq(vq);
+
+	START_USE(lvq);
+	BUG_ON(lvq->running);
+
+	if (likely(!more_used(lvq)) || unlikely(lvq->broken))
+		lvq->running = true;
+
+	END_USE(lvq);
+	return lvq->running;
+}
+
+static irqreturn_t lguest_virtqueue_interrupt(int irq, void *_lvq)
+{
+	struct lguest_virtqueue *lvq = _lvq;
+
+	pr_debug("virtqueue interrupt for %p\n", lvq);
+
+	if (unlikely(lvq->broken))
+		return IRQ_HANDLED;
+
+	if (lvq->running && more_used(lvq)) {
+		pr_debug("virtqueue callback for %p (%p)\n", lvq, lvq->vq.cb);
+		lvq->running = lvq->vq.cb(&lvq->vq);
+	} else
+		pr_debug("virtqueue %p no more used\n", lvq);
+
+	return IRQ_HANDLED;
+}
+
+struct lguest_virtqueue_pair
+{
+	struct lguest_virtqueue *in, *out;
+};
+
+static irqreturn_t lguest_virtqueue_pair_interrupt(int irq, void *_lvqp)
+{
+	struct lguest_virtqueue_pair *lvqp = _lvqp;
+
+	lguest_virtqueue_interrupt(irq, lvqp->in);
+	lguest_virtqueue_interrupt(irq, lvqp->out);
+
+	return IRQ_HANDLED;
+}
+
+static struct virtqueue_ops lguest_virtqueue_ops = {
+	.add_buf = lguest_add_buf,
+	.get_buf = lguest_get_buf,
+	.sync = lguest_sync,
+	.detach_buf = lguest_detach_buf,
+	.restart = lguest_restart,
+};
+
+static struct lguest_virtqueue *lg_new_virtqueue(struct lguest_device *lgdev,
+						 unsigned long pfn)
+{
+	struct lguest_virtqueue *lvq;
+	unsigned int i;
+
+	lvq = kmalloc(sizeof(*lvq), GFP_KERNEL);
+	if (!lvq)
+		return NULL;
+
+	/* Queue takes three pages */
+	lvq->d = lguest_map(pfn << PAGE_SHIFT, 3);
+	if (!lvq->d)
+		goto free_lvq;
+
+	lvq->lg = lgdev;
+	lvq->broken = false;
+	lvq->last_used_idx = 0;
+	lvq->num_added = 0;
+	lvq->running = true;
+#ifdef DEBUG
+	lvq->in_use = false;
+#endif
+
+	/* Put everything in free lists. */
+	lvq->num_free = NUM_DESCS;
+	lvq->free_head = 0;
+	for (i = 0; i < NUM_DESCS-1; i++)
+		lvq->d->desc[i].next = i+1;
+
+	lvq->vq.ops = &lguest_virtqueue_ops;
+	return lvq;
+
+free_lvq:
+	kfree(lvq);
+	return NULL;
+}
+
+static void lg_destroy_virtqueue(struct lguest_virtqueue *lvq)
+{
+	lguest_unmap(lvq->d);
+	kfree(lvq);
+}
+
+/* Example network driver code. */
+#include <linux/virtio_net.h>
+#include <linux/etherdevice.h>
+
+static int lguest_virtnet_probe(struct lguest_device *lgdev)
+{
+	struct net_device *dev;
+	u8 mac[ETH_ALEN];
+	int err, irqf;
+	struct lguest_virtqueue_pair *pair;
+
+	pair = kmalloc(sizeof(*pair), GFP_KERNEL);
+	if (!pair) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
+	pair->in = lg_new_virtqueue(lgdev, lguest_devices[lgdev->index].pfn);
+	if (!pair->in) {
+		err = -ENOMEM;
+		goto free_pair;
+	}
+	pair->out = lg_new_virtqueue(lgdev,lguest_devices[lgdev->index].pfn+3);
+	if (!pair->out) {
+		err = -ENOMEM;
+		goto free_pair_in;
+	}
+
+	random_ether_addr(mac);
+	dev = virtnet_probe(&pair->in->vq, &pair->out->vq, &lgdev->dev, mac);
+	if (IS_ERR(dev)) {
+		err = PTR_ERR(dev);
+		goto free_pair_out;
+	}
+
+	if (lguest_devices[lgdev->index].features&LGUEST_DEVICE_F_RANDOMNESS)
+		irqf = IRQF_SAMPLE_RANDOM;
+	else
+		irqf = 0;
+
+	err = request_irq(lgdev_irq(lgdev),
+			  lguest_virtqueue_pair_interrupt, irqf, dev->name,
+			  pair);
+
+	if (err)
+		goto unprobe;
+
+	lgdev->private = pair;
+	return 0;
+
+unprobe:
+	virtnet_remove(dev);
+free_pair_out:
+	lg_destroy_virtqueue(pair->out);
+free_pair_in:
+	lg_destroy_virtqueue(pair->in);
+free_pair:
+	kfree(pair);
+fail:
+	return err;
+}
+
+static struct lguest_driver lguest_virtnet_drv = {
+	.name = "lguestvirtnet",
+	.owner = THIS_MODULE,
+	.device_type = LGUEST_DEVICE_T_VIRTNET,
+	.probe = lguest_virtnet_probe,
+};
+
+static __init int lguest_virtnet_init(void)
+{
+	return register_lguest_driver(&lguest_virtnet_drv);
+}
+device_initcall(lguest_virtnet_init);
+
+/* Example block driver code. */
+#include <linux/virtio_blk.h>
+#include <linux/genhd.h>
+#include <linux/blkdev.h>
+static int lguest_virtblk_probe(struct lguest_device *lgdev)
+{
+	struct lguest_virtqueue *lvq;
+	struct gendisk *disk;
+	unsigned long sectors;
+	int err, irqf;
+
+	lvq = lg_new_virtqueue(lgdev, lguest_devices[lgdev->index].pfn);
+	if (!lvq)
+		return -ENOMEM;
+
+	/* Page is initially used to pass capacity. */
+	sectors = *(unsigned long *)lvq->d;
+	*(unsigned long *)lvq->d = 0;
+
+	lgdev->private = disk = virtblk_probe(&lvq->vq);
+	if (IS_ERR(disk)) {
+		err = PTR_ERR(disk);
+		goto destroy;
+	}
+	set_capacity(disk, sectors);
+	blk_queue_max_hw_segments(disk->queue, NUM_DESCS-1);
+
+	if (lguest_devices[lgdev->index].features&LGUEST_DEVICE_F_RANDOMNESS)
+		irqf = IRQF_SAMPLE_RANDOM;
+	else
+		irqf = 0;
+
+	err = request_irq(lgdev_irq(lgdev), lguest_virtqueue_interrupt, irqf,
+			  disk->disk_name, lvq);
+	if (err)
+		goto unprobe;
+
+	add_disk(disk);
+	return 0;
+
+unprobe:
+	virtblk_remove(disk);
+destroy:
+	lg_destroy_virtqueue(lvq);
+	return err;
+}
+
+static struct lguest_driver lguest_virtblk_drv = {
+	.name = "lguestvirtblk",
+	.owner = THIS_MODULE,
+	.device_type = LGUEST_DEVICE_T_VIRTBLK,
+	.probe = lguest_virtblk_probe,
+};
+
+static __init int lguest_virtblk_init(void)
+{
+	return register_lguest_driver(&lguest_virtblk_drv);
+}
+device_initcall(lguest_virtblk_init);
+
+MODULE_LICENSE("GPL");
===================================================================
--- a/include/asm-i386/lguest_hcall.h
+++ b/include/asm-i386/lguest_hcall.h
@@ -18,6 +18,9 @@
 #define LHCALL_SET_PTE		14
 #define LHCALL_SET_PMD		15
 #define LHCALL_LOAD_TLS		16
+
+/* Experimental hcalls for new I/O */
+#define LHCALL_NOTIFY	100 /* pfn */
 
 /*G:031 First, how does our Guest contact the Host to ask for privileged
  * operations?  There are two ways: the direct way is to make a "hypercall",
===================================================================
--- a/include/linux/lguest_launcher.h
+++ b/include/linux/lguest_launcher.h
@@ -90,6 +90,8 @@ struct lguest_device_desc {
 #define LGUEST_DEVICE_T_CONSOLE	1
 #define LGUEST_DEVICE_T_NET	2
 #define LGUEST_DEVICE_T_BLOCK	3
+#define LGUEST_DEVICE_T_VIRTNET	8
+#define LGUEST_DEVICE_T_VIRTBLK	9
 
 	/* The specific features of this device: these depends on device type
 	 * except for LGUEST_DEVICE_F_RANDOMNESS. */
@@ -124,4 +126,28 @@ enum lguest_req
 	LHREQ_IRQ, /* + irq */
 	LHREQ_BREAK, /* + on/off flag (on blocks until someone does off) */
 };
+
+/* This marks a buffer as being the start (and active) */
+#define LGUEST_DESC_F_HEAD	1
+/* This marks a buffer as continuing via the next field. */
+#define LGUEST_DESC_F_NEXT	2
+/* This marks a buffer as write-only (otherwise read-only). */
+#define LGUEST_DESC_F_WRITE	4
+
+/* Virtio descriptors */
+struct lguest_desc
+{
+	unsigned long pfn;
+	unsigned long len;
+	u16 offset;
+	u16 flags;
+	/* We chain unused descriptors via this, too */
+	u32 next;
+};
+
+struct lguest_used
+{
+	unsigned int id;
+	unsigned int len;
+};
 #endif /* _ASM_LGUEST_USER */
