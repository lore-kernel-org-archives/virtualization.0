From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 3/5] /dev/vring limit and base ioctls
Date: Fri, 18 Apr 2008 14:41:10 +1000
Message-ID: <200804181441.10499.rusty__45434.4492093243$1208493925$gmane$org@rustcorp.com.au>
References: <200804181433.48488.rusty@rustcorp.com.au>
	<200804181435.21214.rusty@rustcorp.com.au>
	<200804181439.49051.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200804181439.49051.rusty@rustcorp.com.au>
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
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Max Krasnyansky <maxk@qualcomm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

It turns out the lguest (and possibly kvm) want the addresses in the
ring buffer to only cover a certain part of memory, and be offset.

It makes sense that this be an ioctl.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 Documentation/ioctl-number.txt |    3 +--
 drivers/char/vring.c           |   37 +++++++++++++++++++++++++++++++++++--
 include/linux/vring.h          |    9 +++++++++
 3 files changed, 45 insertions(+), 4 deletions(-)

diff -r caeeb48d478a Documentation/ioctl-number.txt
--- a/Documentation/ioctl-number.txt	Fri Apr 18 13:35:17 2008 +1000
+++ b/Documentation/ioctl-number.txt	Fri Apr 18 13:36:21 2008 +1000
@@ -181,8 +181,7 @@ 0xA3	90-9F	linux/dtlk.h
 0xA3	90-9F	linux/dtlk.h
 0xAB	00-1F	linux/nbd.h
 0xAC	00-1F	linux/raw.h
-0xAD	00	Netfilter device	in development:
-					<mailto:rusty@rustcorp.com.au>	
+0xAD	00-01	linux/vring.h
 0xB0	all	RATIO devices		in development:
 					<mailto:vgo@ratio.de>
 0xB1	00-1F	PPPoX			<mailto:mostrows@styx.uwaterloo.ca>
diff -r caeeb48d478a drivers/char/vring.c
--- a/drivers/char/vring.c	Fri Apr 18 13:35:17 2008 +1000
+++ b/drivers/char/vring.c	Fri Apr 18 13:36:21 2008 +1000
@@ -32,6 +32,8 @@ struct vring_info {
 	struct vring ring;
 	u16 mask;
 	u16 last_used;
+
+	unsigned long base, limit;
 
 	const struct vring_ops *ops;
 	void *ops_data;
@@ -163,6 +165,26 @@ static int vring_open(struct inode *in, 
 
 	init_waitqueue_head(&vr->poll_wait);
 	mutex_init(&vr->lock);
+	vr->limit = -1UL;
+	vr->base = 0;
+	return 0;
+}
+
+static int vring_ioctl(struct inode *in, struct file *filp,
+		       unsigned int cmd, unsigned long arg)
+{
+	struct vring_info *vr = filp->private_data;
+
+	switch (cmd) {
+	case VRINGSETBASE:
+		vr->base = arg;
+		break;
+	case VRINGSETLIMIT:
+		vr->limit = arg;
+		break;
+	default:
+		return -ENOTTY;
+	}
 	return 0;
 }
 
@@ -173,6 +195,7 @@ static const struct file_operations vrin
 	.read		= vring_read,
 	.write		= vring_write,
 	.poll		= vring_poll,
+	.ioctl		= vring_ioctl,
 };
 
 /**
@@ -220,6 +243,8 @@ int vring_get_buffer(struct vring_info *
 
 	i = head;
 	do {
+		void __user *base;
+
 		if (unlikely(i >= vr->ring.num)) {
 			pr_debug("vring: bad index: %u\n", i);
 			return -EINVAL;
@@ -227,6 +252,14 @@ int vring_get_buffer(struct vring_info *
 
 		if (copy_from_user(&d, &vr->ring.desc[i], sizeof(d)) != 0)
 			return -EFAULT;
+
+		if (d.addr + d.len > vr->limit || (d.addr + d.len < d.addr)) {
+			pr_debug("vring: bad addr/len: %u@%p\n",
+				 d.len, (void *)(unsigned long)d.addr);
+			return -EINVAL;
+		}
+
+		base = (void __user *)(unsigned long)d.addr + vr->base;
 
 		if (d.flags & VRING_DESC_F_WRITE) {
 			/* Check for length and iovec overflows */
@@ -239,7 +272,7 @@ int vring_get_buffer(struct vring_info *
 				return -E2BIG;
 			in_iov[in].iov_len = d.len;
 			*in_len += d.len;
-			in_iov[in].iov_base = (void __user *)(long)d.addr;
+			in_iov[in].iov_base = base;
 			in++;
 		} else {
 			if (!num_out) {
@@ -251,7 +284,7 @@ int vring_get_buffer(struct vring_info *
 				return -E2BIG;
 			out_iov[out].iov_len = d.len;
 			*out_len += d.len;
-			out_iov[out].iov_base = (void __user *)(long)d.addr;
+			out_iov[out].iov_base = base;
 			out++;
 		}
 
diff -r caeeb48d478a include/linux/vring.h
--- a/include/linux/vring.h	Fri Apr 18 13:35:17 2008 +1000
+++ b/include/linux/vring.h	Fri Apr 18 13:36:21 2008 +1000
@@ -18,6 +18,13 @@
  */
 #ifndef _LINUX_VRING_H
 #define _LINUX_VRING_H
+#include <linux/types.h>
+
+/* Ioctl defines. */
+#define VRINGSETBASE	_IO(0xAD, 0)
+#define VRINGSETLIMIT	_IO(0xAD, 1)
+
+#ifdef __KERNEL__
 
 /**
  * vring_ops - operations for a vring fd.
@@ -55,4 +62,6 @@ void vring_used_buffer(struct vring_info
 void vring_used_buffer(struct vring_info *vr, int id, u32 len);
 
 void vring_wake(struct vring_info *vr);
+#endif /* __KERNEL__ */
+
 #endif /* _LINUX_VRING_H */
