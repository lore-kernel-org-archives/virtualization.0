From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Virtio ballooning support for Lguest
Date: Tue, 12 Jan 2010 21:34:35 +1030
Message-ID: <201001122134.35513.rusty@rustcorp.com.au>
References: <93e720dc1001081035t68b4fb8bracea5e5e61443b99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <93e720dc1001081035t68b4fb8bracea5e5e61443b99@mail.gmail.com>
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
Cc: Gaurav Kukreja <mailme.gaurav@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 9 Jan 2010 05:05:06 am Gaurav Kukreja wrote:
> Hi,
> 
> I am doing working on enabling Transcendent Memory(OLS '09) support on
> lguest.
> 
> For the same, I need ballooning support for lguest. Is there an
> implmentation of Virtio Balloon driver, that I can use for my purpose?

Here's a patch I had for testing.  It's not a real implementation, but
it serves as a start point.

This patch probably won't apply now, but you can use the code:

Crappy lguest balloon testing code.
---
 Documentation/lguest/lguest.c |   75 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff -r 62e37935e821 Documentation/lguest/lguest.c
--- a/Documentation/lguest/lguest.c	Sun Jun 15 23:00:15 2008 +1000
+++ b/Documentation/lguest/lguest.c	Sun Jun 15 23:00:54 2008 +1000
@@ -44,6 +44,7 @@
 #include "linux/virtio_console.h"
 #include "linux/virtio_rng.h"
 #include "linux/virtio_ring.h"
+#include "linux/virtio_balloon.h"
 #include "linux/vring.h"
 #include "asm-x86/bootparam.h"
 /*L:110 We can ignore the 39 include files we need for this program, but I do
@@ -2194,6 +2195,75 @@ static void setup_block_file(const char 
 	verbose("device %u: virtblock %llu sectors\n",
 		devices.device_num, le64_to_cpu(conf.capacity));
 }
+/*:*/
+
+static bool handle_balloon_cmd(int fd, struct device *dev)
+{
+	struct virtio_balloon_config conf;
+	int r, diff;
+	char cmd[80];
+
+	r = read(dev->fd, cmd, sizeof(cmd)-1);
+	if (r < 0)
+		err(1, "Reading balloon cmd fd");
+
+	/* Closed?  Stop listening. */
+	if (r == 0)
+		return false;
+
+	cmd[r] = '\0';
+	diff = atol(cmd);
+	if (!diff)
+		errx(1, "Bad balloon target diff '%s'", cmd);
+
+	memcpy(&conf, device_config(dev), sizeof(conf));
+	conf.num_pages += diff;
+	printf("New balloon target: %u\n", conf.num_pages);
+	memcpy(device_config(dev), &conf, sizeof(conf));
+
+	/* Config change, so trigger the irq. */
+	dev->desc->config_change = 1;
+	trigger_irq(fd, dev->vq);
+	return true;
+}
+
+static void handle_virtballoon_output(int fd, struct virtqueue *vq)
+{
+	unsigned int head, out, in, i;
+	struct iovec iov[vq->vqi.vring.num];
+
+	head = get_vq_desc(&vq->vqi, iov, &out, &in);
+	if (head < 0)
+		return;
+
+	if (in)
+		errx(1, "Input buffers in output queue?");
+
+	if (out != 1 || (iov[0].iov_len % 4) != 0)
+		errx(1, "Surprising output num %i, len %u\n",
+		     out, iov[0].iov_len);
+
+	for (i = 0; i < iov[0].iov_len/4; i++)
+		printf("Released page %u\n", ((u32 *)iov[0].iov_base)[i]);
+
+	add_used_and_trigger(fd, vq, head, iov[0].iov_len);
+}
+
+/*L:199 The balloon device: this is a hack for testing. */
+static void setup_balloon_file(const char *filename, unsigned int mempages)
+{
+	int fd;
+	struct device *dev;
+	struct virtio_balloon_config conf = { .num_pages = 0 };
+
+	fd = open_or_die(filename, O_RDWR);
+
+	dev = new_device("balloon", VIRTIO_ID_BALLOON, fd, handle_balloon_cmd);
+
+	/* The device has one virtqueue, where the Guest places page numbers. */
+	add_virtqueue(dev, VIRTQUEUE_NUM, handle_virtballoon_output);
+	set_config(dev, sizeof(conf), &conf);
+}
 
 /* Our random number generator device reads from /dev/random into the Guest's
  * input buffers.  The usual case is that the Guest doesn't want random numbers
@@ -2326,6 +2396,7 @@ static struct option opts[] = {
 	{ "block", 1, NULL, 'b' },
 	{ "rng", 0, NULL, 'r' },
 	{ "initrd", 1, NULL, 'i' },
+	{ "balloon", 1, NULL, 'B' },
 	{ "sharenet", 1, NULL, 's' },
 	{ NULL },
 };
@@ -2334,6 +2405,7 @@ static void usage(void)
 	errx(1, "Usage: lguest [--verbose] "
 	     "[--tunnet=(<ipaddr>:<macaddr>|bridge:<bridgename>:<macaddr>)\n"
 	     "|--sharenet=<controlfile>]\n"
+	     "|--balloon=<filename>]\n"
 	     "|--block=<filename>|--initrd=<filename>]...\n"
 	     "<mem-in-mb> vmlinux [args...]");
 }
@@ -2409,6 +2481,9 @@ int main(int argc, char *argv[])
 			break;
 		case 'i':
 			initrd_name = optarg;
+			break;
+		case 'B':
+			setup_balloon_file(optarg, mem/getpagesize());
 			break;
 		case 's':
 			setup_sharenet(optarg);
