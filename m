From: Badari Pulavarty <pbadari@us.ibm.com>
Subject: [RFC] vhost-blk implementation
Date: Mon, 22 Mar 2010 17:34:04 -0700
Message-ID: <1269304444.7931.68.camel@badari-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

Inspired by vhost-net implementation, I did initial prototype 
of vhost-blk to see if it provides any benefits over QEMU virtio-blk.
I haven't handled all the error cases, fixed naming conventions etc.,
but the implementation is stable to play with. I tried not to deviate
from vhost-net implementation where possible.

NOTE:  Only change I had to make to vhost core code is to 
increase VHOST_NET_MAX_SG to 130 (128+2) in vhost.h 

Performance:
=============

I have done simple tests to see how it performs. I got very
encouraging results on sequential read tests. But on sequential
write tests, I see degrade over virtio-blk. I can't figure out and
explain why. Can some one shed light on whats happening here ?

Read Results:
=============
Test does read of 84GB file from the host (through virtio). I unmount
and mount the filesystem on the host to make sure there is nothing
in the page cache..


with vhost-blk:
----------------

# time dd if=/dev/vda of=/dev/null bs=128k iflag=direct
640000+0 records in
640000+0 records out
83886080000 bytes (84 GB) copied, 126.135 seconds, 665 MB/s

real    2m6.137s
user    0m0.281s
sys     0m14.725s

without vhost-blk: (virtio)
---------------------------

# time dd if=/dev/vda of=/dev/null bs=128k iflag=direct
640000+0 records in
640000+0 records out
83886080000 bytes (84 GB) copied, 275.466 seconds, 305 MB/s

real    4m35.468s
user    0m0.373s
sys     0m48.074s



Write Results:
==============

I see degraded IO performance when doing sequential IO write
tests with vhost-blk compared to virtio-blk.

# time dd of=/dev/vda if=/dev/zero bs=2M oflag=direct

I get ~110MB/sec with virtio-blk, but I get only ~60MB/sec with
vhost-blk. Wondering why ?

Comments/flames ? 

Thanks,
Badari


vhost-blk is in-kernel accelerator for virtio-blk. 
At this time, this is a prototype based on virtio-net.
Lots of error handling and clean up needs to be done.
Read performance is pretty good over QEMU virtio-blk, but
write performance is not anywhere close to QEMU virtio-blk.
Why ?

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
---
 drivers/vhost/blk.c |  242 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 242 insertions(+)

Index: net-next/drivers/vhost/blk.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ net-next/drivers/vhost/blk.c	2010-03-22 18:07:18.156584400 -0400
@@ -0,0 +1,242 @@
+ /*
+  * virtio-block server in host kernel.
+  * Inspired by vhost-net and shamlessly ripped code from it :)
+  */
+
+#include <linux/compat.h>
+#include <linux/eventfd.h>
+#include <linux/vhost.h>
+#include <linux/virtio_net.h>
+#include <linux/virtio_blk.h>
+#include <linux/mmu_context.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include <linux/rcupdate.h>
+#include <linux/file.h>
+
+#include "vhost.h"
+
+#define VHOST_BLK_VQ_MAX 1
+
+struct vhost_blk {
+	struct vhost_dev dev;
+	struct vhost_virtqueue vqs[VHOST_BLK_VQ_MAX];
+	struct vhost_poll poll[VHOST_BLK_VQ_MAX];
+};
+
+static int do_handle_io(struct file *file, uint32_t type, uint64_t sector,
+			struct iovec *iov, int in)
+{
+	loff_t pos = sector << 8;
+	int ret = 0;
+
+	if (type & VIRTIO_BLK_T_FLUSH)  {
+		ret = vfs_fsync(file, file->f_path.dentry, 1);
+	} else if (type & VIRTIO_BLK_T_OUT) {
+		ret = vfs_writev(file, iov, in, &pos);
+	} else {
+		ret = vfs_readv(file, iov, in, &pos);
+	}
+	return ret;
+}
+
+static void handle_blk(struct vhost_blk *blk)
+{
+	struct vhost_virtqueue *vq = &blk->dev.vqs[0];
+	unsigned head, out, in;
+	struct virtio_blk_outhdr hdr;
+	int r, nvecs;
+	uint8_t status = 0;
+
+	use_mm(blk->dev.mm);
+	mutex_lock(&vq->mutex);
+
+	vhost_disable_notify(vq);
+
+	for (;;) {
+		head = vhost_get_vq_desc(&blk->dev, vq, vq->iov,
+					 ARRAY_SIZE(vq->iov),
+					 &out, &in, NULL, NULL);
+		if (head == vq->num) {
+			if (unlikely(vhost_enable_notify(vq))) {
+				vhost_disable_notify(vq);
+				continue;
+			}
+			break;
+		}
+
+		BUG_ON(vq->iov[0].iov_len != 16);
+
+		r = copy_from_user(&hdr, vq->iov[0].iov_base, sizeof hdr);
+		if (r < 0) {
+			printk("copy from user failed\n");
+			vhost_discard_vq_desc(vq);
+			break;
+		}
+
+		nvecs = out - 1;
+		if (hdr.type == VIRTIO_BLK_T_IN)
+			nvecs = in - 1;
+
+		r = do_handle_io(vq->private_data, hdr.type, hdr.sector, &vq->iov[1], nvecs);
+		status = (r < 0) ? VIRTIO_BLK_S_IOERR : VIRTIO_BLK_S_OK;
+
+		nvecs++;
+		BUG_ON(vq->iov[nvecs].iov_len != 1);
+
+		if (copy_to_user(vq->iov[nvecs].iov_base, &status, sizeof status) < 0) {
+			printk("copy to user failed\n");
+			vhost_discard_vq_desc(vq);
+			break;
+		}
+		vhost_add_used_and_signal(&blk->dev, vq, head, r);
+	}
+        mutex_unlock(&vq->mutex);
+        unuse_mm(blk->dev.mm);
+}
+
+static void vhost_blk_flush(struct vhost_blk *n)
+{
+	vhost_poll_flush(n->poll);
+	vhost_poll_flush(&n->dev.vqs[0].poll);
+}
+
+static void handle_blk_kick(struct work_struct *work)
+{
+	struct vhost_virtqueue *vq;
+	struct vhost_blk *blk;
+	vq = container_of(work, struct vhost_virtqueue, poll.work);
+	blk = container_of(vq->dev, struct vhost_blk, dev);
+	handle_blk(blk);
+}
+
+static void handle_rq_blk(struct work_struct *work)
+{
+	struct vhost_blk *blk;
+	blk = container_of(work, struct vhost_blk, poll[0].work);
+	handle_blk(blk);
+}
+
+static int vhost_blk_open(struct inode *inode, struct file *f)
+{
+	struct vhost_blk *n = kmalloc(sizeof *n, GFP_KERNEL);
+	int r;
+	if (!n)
+		return -ENOMEM;
+	n->vqs[0].handle_kick = handle_blk_kick;
+	r = vhost_dev_init(&n->dev, n->vqs, VHOST_BLK_VQ_MAX);
+	if (r < 0) {
+		kfree(n);
+		return r;
+	}
+
+	vhost_poll_init(n->poll, handle_rq_blk, POLLOUT|POLLIN);
+	f->private_data = n;
+	return 0;
+}
+
+static int vhost_blk_release(struct inode *inode, struct file *f)
+{
+	struct vhost_blk *n = f->private_data;
+
+	fput(n->vqs->private_data);
+	kfree(n);
+	return 0;
+}
+
+static long vhost_blk_set_backend(struct vhost_blk *n, unsigned index, int fd)
+{
+	struct file *file;
+	struct vhost_virtqueue *vq;
+
+	file = fget(fd);
+	if (!file)
+		return -EBADF;
+
+	vq = n->vqs + index;
+	mutex_lock(&vq->mutex);
+	rcu_assign_pointer(vq->private_data, file);
+	mutex_unlock(&vq->mutex);
+	return 0;
+}
+
+
+static long vhost_blk_ioctl(struct file *f, unsigned int ioctl,
+                            unsigned long arg)
+{
+	struct vhost_blk *n = f->private_data;
+	void __user *argp = (void __user *)arg;
+	struct vhost_vring_file backend;
+	int r;
+
+	switch (ioctl) {
+        case VHOST_NET_SET_BACKEND:
+                r = copy_from_user(&backend, argp, sizeof backend);
+                if (r < 0)
+                        return r;
+                return vhost_blk_set_backend(n, backend.index, backend.fd);
+	default:
+		mutex_lock(&n->dev.mutex);
+		r = vhost_dev_ioctl(&n->dev, ioctl, arg);
+		vhost_blk_flush(n);
+		mutex_unlock(&n->dev.mutex);
+		return r;
+	}
+}
+
+const static struct file_operations vhost_blk_fops = {
+	.owner          = THIS_MODULE,
+	.release        = vhost_blk_release,
+	.open           = vhost_blk_open,
+	.unlocked_ioctl = vhost_blk_ioctl,
+};
+
+static struct miscdevice vhost_blk_misc = {
+	234,
+	"vhost-blk",
+	&vhost_blk_fops,
+};
+
+int vhost_blk_init(void)
+{
+	int r = vhost_init();
+	if (r)
+		goto err_init;
+	r = misc_register(&vhost_blk_misc);
+	if (r)
+		goto err_reg;
+	return 0;
+err_reg:
+	vhost_cleanup();
+err_init:
+	return r;
+
+}
+module_init(vhost_blk_init);
+
+void vhost_blk_exit(void)
+{
+	misc_deregister(&vhost_blk_misc);
+	vhost_cleanup();
+}
+module_exit(vhost_blk_exit);
+
+MODULE_VERSION("0.0.1");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Host kernel accelerator for virtio blk");
