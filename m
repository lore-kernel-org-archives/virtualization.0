From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC PATCH 5/5] lguest: Inter-guest networking
Date: Thu, 20 Mar 2008 17:45:15 +1100
Message-ID: <200803201745.16307.rusty__20206.7031678327$1205995694$gmane$org@rustcorp.com.au>
References: <200803201659.14344.rusty@rustcorp.com.au>
	<200803201736.01883.rusty@rustcorp.com.au>
	<200803201740.28991.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200803201740.28991.rusty@rustcorp.com.au>
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

We open two FIFOs, mmap the other Guests' memory, and copy between
their send queue and our Guest's receive queue.  A one-char byte is
used to notify the other Guest about virtqueue activity.

Note the FIXMEs, and the fact that we don't suppress notifications
even when we could (based on the flags in the other Guest's
virtqueue).

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/lguest/lguest.c |  257 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 235 insertions(+), 22 deletions(-)

diff -r d803a2208052 Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c	Mon Mar 17 22:33:22 2008 +1100
+++ b/Documentation/lguest/lguest.c	Mon Mar 17 22:35:59 2008 +1100
@@ -276,6 +276,12 @@ static void unlink_memfile(void)
 	unlink(memfile_path);
 }
 
+/* Name the memfiles by the process ID of this launcher. */
+static void guest_memfile(char *buffer, pid_t pid)
+{
+	snprintf(buffer, PATH_MAX, "%s/.lguest/%u", getenv("HOME") ?: "", pid);
+}
+
 /* map_zeroed_pages() takes a number of pages, and creates a mapping file where
  * this Guest's memory lives. */
 static void *map_zeroed_pages(unsigned int num)
@@ -289,9 +295,7 @@ static void *map_zeroed_pages(unsigned i
 	if (mkdir(memfile_path, S_IRWXU) != 0 && errno != EEXIST)
 		err(1, "Creating directory %s", memfile_path);
 
-	/* Name the memfiles by the process ID of this launcher. */
-	snprintf(memfile_path, PATH_MAX, "%s/.lguest/%u",
-		 getenv("HOME") ?: "", getpid());
+	guest_memfile(memfile_path, getpid());
 	fd = open(memfile_path, O_RDWR | O_CREAT | O_TRUNC, S_IRWXU);
 	if (fd < 0)
 		err(1, "Creating memory backing file %s", memfile_path);
@@ -1426,22 +1430,6 @@ static void setup_console(void)
 }
 /*:*/
 
-/*M:010 Inter-guest networking is an interesting area.  Simplest is to have a
- * --sharenet=<name> option which opens or creates a named pipe.  This can be
- * used to send packets to another guest in a 1:1 manner.
- *
- * More sopisticated is to use one of the tools developed for project like UML
- * to do networking.
- *
- * Faster is to do virtio bonding in kernel.  Doing this 1:1 would be
- * completely generic ("here's my vring, attach to your vring") and would work
- * for any traffic.  Of course, namespace and permissions issues need to be
- * dealt with.  A more sophisticated "multi-channel" virtio_net.c could hide
- * multiple inter-guest channels behind one interface, although it would
- * require some manner of hotplugging new virtio channels.
- *
- * Finally, we could implement a virtio network switch in the kernel. :*/
-
 static void random_ether_addr(u8 *mac)
 {
 	int randfd = open_or_die("/dev/urandom", O_RDONLY);
@@ -1503,10 +1491,230 @@ static void setup_tun_net(const char *ar
 	if (priv->bridge_name)
 		verbose("attached to bridge: %s\n", priv->bridge_name);
 }
+/*:*/
 
-/* Our block (disk) device should be really simple: the Guest asks for a block
- * number and we read or write that position in the file.  Unfortunately, that
- * was amazingly slow: the Guest waits until the read is finished before
+struct sharenet_priv
+{
+	/* The fifo to write to tell the other Launcher. */
+	int writefd;
+
+	/* The other Guest's send virtqueue. */
+	struct virtqueue_info vq_out;
+
+	/* The information the other Guest gave us. */
+	struct sharenet_other {
+		unsigned int pid;
+		u16 vq_out_num;
+		unsigned long vq_out_addr;
+		struct guest_memory mem;
+	} other;
+};
+
+/* Alters contents of src[] and dst[].  Returns true if all of src copied. */
+static bool iovec_copy(struct iovec *dst, unsigned int dst_num,
+		       struct iovec *src, unsigned int src_num,
+		       unsigned int *totlen)
+{
+	*totlen = 0;
+	while (src_num) {
+		unsigned int len = src->iov_len < dst->iov_len
+			? src->iov_len : dst->iov_len;
+		memcpy(dst->iov_base, src->iov_base, len);
+		*totlen += len;
+
+		src->iov_base += len;
+		src->iov_len -= len;
+		if (!src->iov_len) {
+			src++;
+			src_num--;
+		}
+
+		dst->iov_base += len;
+		dst->iov_len -= len;
+		if (!dst->iov_len) {
+			dst++;
+			dst_num--;
+			/* If we're out of dst room, it's only ok if we're out
+			 * of src too */
+			if (dst_num == 0)
+				return src_num == 0;
+		}
+	}
+	return true;
+}
+
+static bool inter_iov_copy(struct iovec fiov[],
+			   unsigned int fout_num, unsigned int fin_num,
+			   struct iovec iov[],
+			   unsigned int out_num, unsigned int in_num,
+			   unsigned int *len)
+{
+	unsigned int partlen;
+
+	/* Transfer our output to their input (not used by net code). */
+	if (!iovec_copy(fiov + fout_num, fin_num, iov, out_num, &partlen))
+		return false;
+	*len = partlen;
+	if (!iovec_copy(iov + out_num, in_num, fiov, fout_num, &partlen))
+		return false;
+	*len += partlen;
+	return true;
+}
+
+static bool handle_sharenet_input(int fd, struct device *dev)
+{
+	struct sharenet_priv *p = dev->priv;
+	struct virtqueue *vq = dev->vq;
+	struct iovec fiov[p->vq_out.vring.num], iov[vq->vqi.vring.num];
+	unsigned int fin_num, fout_num, in_num, out_num;
+	int fhead, head;
+	char c;
+	bool progress = false, filled = false;
+
+	if (read(dev->fd, &c, 1) != 1) {
+		warn("sharenet: failed to read from other Guest");
+		return false;
+	}
+
+	/* Look in other Guests' (ie. foreign) virtqueue. */
+	/* FIXME: Don't allow arbitrary bidir copies? */
+	while ((fhead = get_vq_desc(&p->vq_out, fiov, &fout_num, &fin_num))>=0){
+		unsigned int len;
+		/* Copy it into our receive queue. */
+		head = get_vq_desc(&vq->vqi, iov, &out_num, &in_num);
+		if (out_num)
+			errx(1, "Output buffers in network recv queue?");
+		if (head < 0) {
+			/* We don't have room to take it, put it back. */
+			p->vq_out.last_avail_idx--;
+			filled = true;
+			break;
+		}
+
+		if (!inter_iov_copy(fiov, fout_num, fin_num,
+				    iov, out_num, in_num, &len)) {
+			warnx("Inter-guest network copy failed: too long?");
+			p->vq_out.broken = true;
+			return false;
+		}
+
+		/* We used one buffer of ours, and one of theirs. */
+		add_used(&vq->vqi, head, len);
+		add_used(&p->vq_out, fhead, len);
+		progress = true;
+	}
+
+	if (progress) {
+		trigger_irq(fd, vq);
+		/* FIXME: Only tell it if they want notify. */
+		write(fd, &c, 1);
+	}
+
+	/* If we filled up, return false: enable_fd will re-enable us. */
+	return !filled;
+}
+
+static void handle_sharenet_output(int fd, struct virtqueue *vq)
+{
+	struct sharenet_priv *p = vq->dev->priv;
+	char c = 0;
+
+	/* Tell other Guest we've got something for it. */
+	write(p->writefd, &c, 1);
+}
+
+static void setup_sharenet(const char *arg)
+{
+	struct device *dev;
+	struct sharenet_priv *p = malloc(sizeof(*p));
+	int fd, readfd;
+	char other_memfile[PATH_MAX];
+	struct sharenet_other us;
+	char *other;
+
+	/* Other fifo is the same, with _ appended. */
+	other = malloc(strlen(arg) + 2);
+	sprintf(other, "%s_", arg);
+
+	/* OK, if we're the first, we get to create it. */
+	if (mkfifo(arg, S_IRUSR|S_IWUSR) == 0) {
+		/* We open our own FIFO, then their FIFO */
+		readfd = open_or_die(arg, O_RDONLY);
+		/* Once we're connected, delete arg. */
+		unlink(arg);
+		p->writefd = open_or_die(other, O_WRONLY);
+		unlink(other);
+	} else {
+		/* The other side got there first. */
+		if (errno != EEXIST)
+			err(1, "Creating sharenet fifo %s", arg);
+
+		/* OK, make the fifo for the other side to open. */
+		if (mkfifo(other, S_IRUSR|S_IWUSR) != 0)
+			err(1, "Creating second sharenet fifo %s", other);
+
+		/* Now, open their FIFO, then open ours.  We unlink even though
+		 * we didn't create it: redundancy is useful. */
+		p->writefd = open_or_die(arg, O_WRONLY);
+		unlink(arg);
+		readfd = open_or_die(other, O_RDONLY);
+		unlink(other);
+	}
+
+	/* Now set up the device. */
+	dev = new_device("sharenet", VIRTIO_ID_NET, readfd,
+			 handle_sharenet_input);
+	dev->priv = p;
+
+	/* Network devices need a receive and a send queue. */
+	add_virtqueue(dev, VIRTQUEUE_NUM, enable_fd);
+	add_virtqueue(dev, VIRTQUEUE_NUM, handle_sharenet_output);
+
+	/* Tell the other end about ourselves. */
+	us.pid = getpid();
+	us.vq_out_addr = to_guest_phys(&gmem, dev->vq->next->vqi.vring.desc);
+	us.vq_out_num = dev->vq->next->vqi.vring.num;
+	us.mem = gmem;
+	if (write(p->writefd, &us, sizeof(us)) != sizeof(us))
+		err(1, "Writing to second sharenet fifo");
+
+	/* And, your hobbies are? */
+	if (read(readfd, &p->other, sizeof(p->other)) != sizeof(p->other))
+		err(1, "Reading info from sharenet fifo");
+
+	/* Map their memory file. */
+	guest_memfile(other_memfile, p->other.pid);
+	fd = open_or_die(other_memfile, O_RDWR);
+	p->other.mem.base = mmap(NULL, p->other.mem.limit,
+				 PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+	if (p->other.mem.base == MAP_FAILED)
+		err(1, "Failed to mmap other Guest's memory for sharenet");
+	close(fd);
+
+	/* Check for silly virtqueue stats. */
+	if (p->other.vq_out_addr >= p->other.mem.limit
+	    ||p->other.vq_out_addr+vring_size(p->other.vq_out_num,getpagesize())
+	    >= p->other.mem.limit)
+		err(1, "sharenet: other Guest gave %lu/%u for vq",
+		    p->other.vq_out_addr, p->other.vq_out_num);
+
+	p->vq_out.mem = &p->other.mem;
+	p->vq_out.last_avail_idx = 0;
+	p->vq_out.broken = false;
+	vring_init(&p->vq_out.vring, p->other.vq_out_num,
+		   from_guest_phys(&p->other.mem, p->other.vq_out_addr),
+		   getpagesize());
+
+	/* FIXME: make fifo non-blocking, so other guest can't freeze
+	 * us on write. */
+	/* FIXME: kill SIGPIPE, so other guest can't kill us on write. */
+	verbose("device %u: sharenet (%u at %p)\n", devices.device_num++,
+		p->other.pid, p->other.mem.base);
+}
+
+/*L:196 Our block (disk) device should be really simple: the Guest asks for a
+ * block number and we read or write that position in the file.  Unfortunately,
+ * that was amazingly slow: the Guest waits until the read is finished before
  * running anything else, even if it could have been doing useful work.
  *
  * We could use async I/O, except it's reputed to suck so hard that characters
@@ -1851,6 +2058,7 @@ static struct option opts[] = {
 static struct option opts[] = {
 	{ "verbose", 0, NULL, 'v' },
 	{ "tunnet", 1, NULL, 't' },
+	{ "sharenet", 1, NULL, 's' },
 	{ "block", 1, NULL, 'b' },
 	{ "rng", 0, NULL, 'r' },
 	{ "initrd", 1, NULL, 'i' },
@@ -1860,6 +2068,7 @@ static void usage(void)
 {
 	errx(1, "Usage: lguest [--verbose] "
 	     "[--tunnet=(<ipaddr>|bridge:<bridgename>)\n"
+	     "[--sharenet=<controlfile>]\n"
 	     "|--block=<filename>|--initrd=<filename>]...\n"
 	     "<mem-in-mb> vmlinux [args...]");
 }
@@ -1932,6 +2141,9 @@ int main(int argc, char *argv[])
 			break;
 		case 'i':
 			initrd_name = optarg;
+			break;
+		case 's':
+			setup_sharenet(optarg);
 			break;
 		default:
 			warnx("Unknown argument %s", argv[optind]);
