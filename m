From: Badari Pulavarty <pbadari@us.ibm.com>
Subject: [RFC] vhost-blk implementation (v2)
Date: Tue, 06 Apr 2010 17:36:28 -0700
Message-ID: <1270600588.28348.36.camel__37489.3837295987$1270600796$gmane$org@badari-desktop>
References: <1269306023.7931.72.camel@badari-desktop>
	<4BA891E2.9040500@redhat.com> <20100324200502.GB22272@infradead.org>
	<4BAB7AA8.8030509@shiftmail.org> <20100405195912.GA17589@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20100405195912.GA17589@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

Hi All,

Here is the latest version of vhost-blk implementation.
Major difference from my previous implementation is that, I
now merge all contiguous requests (both read and write), before
submitting them. This significantly improved IO performance.
I am still collecting performance numbers, I will be posting
in next few days.

Comments ?

Todo:
- Address hch's comments on annontations
- Implement per device read/write queues
- Finish up error handling

Thanks,
Badari

---
 drivers/vhost/blk.c |  445 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 445 insertions(+)

Index: net-next/drivers/vhost/blk.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ net-next/drivers/vhost/blk.c	2010-04-06 16:38:03.563847905 -0400
@@ -0,0 +1,445 @@
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
+#define SECTOR_SHIFT 9
+
+struct vhost_blk {
+	struct vhost_dev dev;
+	struct vhost_virtqueue vqs[VHOST_BLK_VQ_MAX];
+	struct vhost_poll poll[VHOST_BLK_VQ_MAX];
+};
+
+struct vhost_blk_io {
+	struct list_head list;
+	struct work_struct work;
+	struct vhost_blk *blk;
+	struct file *file;
+	int head;
+	uint32_t type;
+	uint32_t nvecs;
+	uint64_t sector;
+	uint64_t len;
+	struct iovec iov[0];
+};
+
+static struct workqueue_struct *vblk_workqueue;
+static LIST_HEAD(write_queue);
+static LIST_HEAD(read_queue);
+
+static void handle_io_work(struct work_struct *work)
+{
+	struct vhost_blk_io *vbio, *entry;
+	struct vhost_virtqueue *vq;
+	struct vhost_blk *blk;
+	struct list_head single, *head, *node, *tmp;
+
+	int i, need_free, ret = 0;
+	loff_t pos;
+	uint8_t status = 0;
+
+	vbio = container_of(work, struct vhost_blk_io, work);
+	blk = vbio->blk;
+	vq = &blk->dev.vqs[0];
+	pos = vbio->sector << 8;
+
+	use_mm(blk->dev.mm);
+	if (vbio->type & VIRTIO_BLK_T_FLUSH)  {
+		ret = vfs_fsync(vbio->file, vbio->file->f_path.dentry, 1);
+	} else if (vbio->type & VIRTIO_BLK_T_OUT) {
+		ret = vfs_writev(vbio->file, vbio->iov, vbio->nvecs, &pos);
+	} else {
+		ret = vfs_readv(vbio->file, vbio->iov, vbio->nvecs, &pos);
+	}
+	status = (ret < 0) ? VIRTIO_BLK_S_IOERR : VIRTIO_BLK_S_OK;
+	if (vbio->head != -1) {
+		INIT_LIST_HEAD(&single);
+		list_add(&vbio->list, &single);
+		head = &single;
+		need_free = 0;
+	} else {
+		head = &vbio->list;
+		need_free = 1;
+	}
+	list_for_each_entry(entry, head, list) {
+		copy_to_user(entry->iov[entry->nvecs].iov_base, &status, sizeof status);
+	}
+	mutex_lock(&vq->mutex);
+	list_for_each_safe(node, tmp, head) {
+		entry = list_entry(node, struct vhost_blk_io, list);
+		vhost_add_used_and_signal(&blk->dev, vq, entry->head, ret);
+		list_del(node);
+		kfree(entry);
+	}
+	mutex_unlock(&vq->mutex);
+	unuse_mm(blk->dev.mm);
+	if (need_free)
+		kfree(vbio);
+}
+
+static struct vhost_blk_io *allocate_vbio(int nvecs)
+{
+	struct vhost_blk_io *vbio;
+	int size = sizeof(struct vhost_blk_io) + nvecs * sizeof(struct iovec);
+	vbio = kmalloc(size, GFP_KERNEL);
+	if (vbio) {
+		INIT_WORK(&vbio->work, handle_io_work);
+		INIT_LIST_HEAD(&vbio->list);
+	}
+	return vbio;
+}
+
+static void merge_and_handoff_work(struct list_head *queue)
+{
+	struct vhost_blk_io *vbio, *entry;
+	int nvecs = 0;
+	int entries = 0;
+
+	list_for_each_entry(entry, queue, list) {
+		nvecs += entry->nvecs;
+		entries++;
+	}
+
+	if (entries == 1) {
+		vbio = list_first_entry(queue, struct vhost_blk_io, list);
+		list_del(&vbio->list);
+		queue_work(vblk_workqueue, &vbio->work);
+		return;
+	}
+
+	vbio = allocate_vbio(nvecs);
+	if (!vbio) {
+		/* Unable to allocate memory - submit IOs individually */
+		list_for_each_entry(vbio, queue, list) {
+			queue_work(vblk_workqueue, &vbio->work);
+		}
+		INIT_LIST_HEAD(queue);
+		return;
+	}
+
+	entry = list_first_entry(queue, struct vhost_blk_io, list);
+	vbio->nvecs = nvecs;
+	vbio->blk = entry->blk;
+	vbio->file = entry->file;
+	vbio->type = entry->type;
+	vbio->sector = entry->sector;
+	vbio->head = -1;
+	vbio->len = 0;
+	nvecs = 0;
+
+	list_for_each_entry(entry, queue, list) {
+		memcpy(&vbio->iov[nvecs], entry->iov, entry->nvecs * sizeof(struct iovec));
+		nvecs += entry->nvecs;
+		vbio->len += entry->len;
+	}
+	list_replace_init(queue, &vbio->list);
+	queue_work(vblk_workqueue, &vbio->work);
+}
+
+static void start_io(struct list_head *queue)
+{
+	struct list_head start;
+	struct vhost_blk_io *vbio = NULL, *entry;
+
+	if (list_empty(queue))
+                return;
+
+	list_for_each_entry(entry, queue, list) {
+		if (!vbio) {
+			vbio = entry;
+			continue;
+		}
+		if (vbio->sector + (vbio->len >> SECTOR_SHIFT) == entry->sector) {
+			vbio = entry;
+		} else {
+			INIT_LIST_HEAD(&start);
+			list_cut_position(&start, queue, &vbio->list);
+			merge_and_handoff_work(&start);
+			vbio = entry;
+		}
+	}
+	if (!list_empty(queue))
+		merge_and_handoff_work(queue);
+}
+
+static uint64_t calculate_len(struct iovec *iov, int nvecs)
+{
+	uint64_t len = 0;
+	int i;
+
+	for (i=0; i<nvecs; i++)
+		len += iov[i].iov_len;
+	return len;
+}
+
+static void insert_to_queue(struct vhost_blk_io *vbio,
+			struct list_head *queue)
+{
+	struct vhost_blk_io *entry;
+
+	list_for_each_entry(entry, queue, list) {
+		if (entry->sector > vbio->sector)
+			break;
+	}
+	list_add_tail(&vbio->list, &entry->list);
+}
+
+static int handoff_io(struct vhost_blk *blk, int head,
+			uint32_t type, uint64_t sector,
+			struct iovec *iov, int nvecs)
+{
+	struct vhost_virtqueue *vq = &blk->dev.vqs[0];
+	struct vhost_blk_io *vbio;
+
+	vbio = allocate_vbio(nvecs+1);
+	if (!vbio) {
+		return -ENOMEM;
+	}
+	vbio->blk = blk;
+	vbio->head = head;
+	vbio->file = vq->private_data;
+	vbio->type = type;
+	vbio->sector = sector;
+	vbio->nvecs = nvecs;
+	vbio->len = calculate_len(iov, nvecs);
+	memcpy(vbio->iov, iov, (nvecs + 1) * sizeof(struct iovec));
+
+	if (vbio->type & VIRTIO_BLK_T_FLUSH) {
+#if 0
+		/* Sync called - do I need to submit IOs in the queue ? */
+		start_io(&read_queue);
+		start_io(&write_queue);
+#endif
+		queue_work(vblk_workqueue, &vbio->work);
+	} else if (vbio->type & VIRTIO_BLK_T_OUT) {
+		insert_to_queue(vbio, &write_queue);
+	} else {
+		insert_to_queue(vbio, &read_queue);
+	}
+	return 0;
+}
+
+
+static void handle_blk(struct vhost_blk *blk)
+{
+	struct vhost_virtqueue *vq = &blk->dev.vqs[0];
+	unsigned head, out, in;
+	struct virtio_blk_outhdr hdr;
+	int nvecs;
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
+			start_io(&read_queue);
+			start_io(&write_queue);
+			break;
+		}
+
+		BUG_ON(vq->iov[0].iov_len != 16);
+
+		if (copy_from_user(&hdr, vq->iov[0].iov_base, sizeof hdr)) {
+			vhost_discard_vq_desc(vq);
+			continue;
+		}
+
+		nvecs = out - 1;
+		if (hdr.type == VIRTIO_BLK_T_IN)
+			nvecs = in - 1;
+
+		BUG_ON(vq->iov[nvecs+1].iov_len != 1);
+		if (handoff_io(blk, head, hdr.type, hdr.sector, &vq->iov[1], nvecs) < 0) {
+			vhost_discard_vq_desc(vq);
+			continue;
+		}
+	}
+	mutex_unlock(&vq->mutex);
+	unuse_mm(blk->dev.mm);
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
+	if (index >= VHOST_BLK_VQ_MAX)
+		return -ENOBUFS;
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
+		r = copy_from_user(&backend, argp, sizeof backend);
+		if (r <	0)
+			return r;
+		return vhost_blk_set_backend(n, backend.index, backend.fd);
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
+static int vhost_blk_init(void)
+{
+	int r = vhost_init();
+	if (r)
+		goto err_init;
+
+	vblk_workqueue = create_workqueue("vblk");
+	if (!vblk_workqueue) {
+		r = -ENOMEM;
+		goto err_vblk;
+	}
+
+	r = misc_register(&vhost_blk_misc);
+	if (r)
+		goto err_reg;
+	return 0;
+err_reg:
+	destroy_workqueue(vblk_workqueue);
+err_vblk:
+	vhost_cleanup();
+err_init:
+	return r;
+
+}
+module_init(vhost_blk_init);
+
+static void vhost_blk_exit(void)
+{
+	misc_deregister(&vhost_blk_misc);
+	destroy_workqueue(vblk_workqueue);
+	vhost_cleanup();
+}
+module_exit(vhost_blk_exit);
+
+MODULE_VERSION("0.0.2");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Host kernel accelerator for virtio blk");
