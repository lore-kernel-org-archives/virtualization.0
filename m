From: arnd@arndb.de
Subject: [RFC 4/4] Example virtio host implementation, using chardev
Date: Fri, 06 Jul 2007 14:42:04 +0200
Message-ID: <20070706125717.892848691@arndb.de>
References: <20070706124200.988637662@arndb.de>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=virtioserver.diff
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Since I still haven't set up lguest and don't have a kvm
capable machine, I decided to write my own host implementation,
based on Rusty's read/write based lguest host from virtio
draft III.

Now this does _not_ use any hypervisor at all, but instead
runs expects a user application to do the actual device
emulation, communicating through a character device.

There are a number of problems with this that are not solved
yet, so please regard this code as demonstration only and
don't try to run it.

Locking is one problem, since the code I based this on
expected to be able to hold a spinlock for the duration of
the hcall. This is not possible during copy_{to,from}_user,
so bad things can happen if a driver detaches a buffer
while it's being accessed from user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Index: linux-2.6/drivers/char/virtiosrv.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/char/virtiosrv.c
@@ -0,0 +1,573 @@
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/ioctl.h>
+#include <linux/highmem.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/scatterlist.h>
+#include <linux/spinlock.h>
+#include <linux/virtio.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+
+#define VIRTIOSRV_MAX_SGLEN 18
+#define VIRTIOSRV_MAX_INBUFS 16
+
+struct buf_head
+{
+	unsigned long len;
+};
+
+struct virtiosrv_inbuf
+{
+	unsigned int num;
+	unsigned int used;
+	bool finished;
+	struct scatterlist sg[VIRTIOSRV_MAX_SGLEN];
+	void *data;
+};
+
+struct virtiosrv_device {
+	struct virtio_device vdev;
+
+	/* Outgoing */
+	bool out_running;
+	unsigned out_junk;
+	unsigned sg_elem, sg_num, sg_off, sg_done;
+	void *out_data;
+
+	/* This is the first entry of the scatter list. */
+	struct buf_head out_head;
+	struct scatterlist sg[1+VIRTIOSRV_MAX_SGLEN];
+
+	/* Incoming */
+	bool in_running;
+	unsigned discard;
+	unsigned in_sg;
+	unsigned in_done;
+	struct virtiosrv_inbuf *curr_in;
+	struct buf_head in_head;
+		struct virtiosrv_inbuf in[VIRTIOSRV_MAX_INBUFS];
+
+	wait_queue_head_t in_wq;
+	wait_queue_head_t out_wq;
+
+	spinlock_t lock;
+	struct virtiosrv_config_data {
+		char device_type[16];
+		char device_id[16];
+	} *data;
+};
+
+static inline struct virtiosrv_device *to_virtiosrv_dev(struct virtio_device *vdev)
+{
+	return container_of(vdev, struct virtiosrv_device, vdev);
+}
+
+static void *virtiosrv_get_outbuf(struct virtio_device *vdev, unsigned int *len)
+{
+	struct virtiosrv_device *sdev = to_virtiosrv_dev(vdev);
+	void *ret;
+
+	spin_lock(&sdev->lock);
+	if (sdev->sg_elem == sdev->sg_num) {
+		ret = sdev->out_data;
+		sdev->sg_num = 0;
+	} else
+		ret = NULL;
+	spin_unlock(&sdev->lock);
+
+	return ret;
+}
+
+static void *virtiosrv_get_inbuf(struct virtio_device *vdev, unsigned int *len)
+{
+	struct virtiosrv_device *sdev = to_virtiosrv_dev(vdev);
+	unsigned int i;
+	void *ret = NULL;
+
+	spin_lock(&sdev->lock);
+	for (i = 0; i < ARRAY_SIZE(sdev->in); i++) {
+		if (sdev->in[i].finished) {
+			ret = sdev->in[i].data;
+			*len = sdev->in[i].used;
+			sdev->in[i].num = 0;
+			sdev->in[i].finished = false;
+			break;
+		}
+	}
+	spin_unlock(&sdev->lock);
+	return ret;
+}
+
+static struct virtiosrv_inbuf *find_inbuf(struct virtiosrv_device *sdev)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(sdev->in); i++)
+		if (sdev->in[i].num)
+			return &sdev->in[i];
+
+	return NULL;
+}
+
+static unsigned long sg_len(const struct scatterlist sg[],
+			    unsigned int num)
+{
+	unsigned long len, i;
+
+	for (i = len = 0; i < num; i++)
+		len += sg[i].length;
+	return len;
+}
+
+static unsigned long virtiosrv_add_outbuf(struct virtio_device *vdev,
+				       const struct scatterlist sg[],
+				       unsigned int num,
+				       void *data)
+{
+	struct virtiosrv_device *sdev = to_virtiosrv_dev(vdev);
+
+	BUG_ON(num > VIRTIOSRV_MAX_SGLEN);
+	BUG_ON(num == 0);
+
+	spin_lock(&sdev->lock);
+	/* We force them into single-file */
+	if (sdev->sg_num) {
+		spin_unlock(&sdev->lock);
+		return -ENOSPC;
+	}
+
+	sdev->sg_elem = sdev->sg_off = sdev->sg_done = 0;
+	sdev->sg_num = 1 + num;
+	sdev->out_head.len = sg_len(sg, num);
+	sdev->out_data = data;
+	memcpy(sdev->sg + 1, sg, num * sizeof(*sg));
+
+	/* First descriptor points at metadata */
+	sdev->sg[0].page = pfn_to_page(virt_to_phys(&sdev->out_head)/PAGE_SIZE);
+	sdev->sg[0].offset = offset_in_page(&sdev->out_head);
+	sdev->sg[0].length = sizeof(sdev->out_head);
+	spin_unlock(&sdev->lock);
+
+	/* With only one, id is always 0 */
+	return 0;
+}
+
+static unsigned long virtiosrv_add_inbuf(struct virtio_device *vdev,
+				      struct scatterlist sg[],
+				      unsigned int num,
+				      void *data)
+
+{
+	struct virtiosrv_device *sdev = to_virtiosrv_dev(vdev);
+	unsigned int i;
+
+	BUG_ON(num > VIRTIOSRV_MAX_SGLEN);
+	BUG_ON(num == 0);
+
+	spin_lock(&sdev->lock);
+	/* Find empty inbuf. */
+	for (i = 0; sdev->in[i].num != 0; i++) {
+		if (i == ARRAY_SIZE(sdev->in) - 1) {
+			spin_unlock(&sdev->lock);
+			return -ENOSPC;
+		}
+	}
+
+	sdev->in[i].num = num;
+	sdev->in[i].finished = false;
+	sdev->in[i].data = data;
+	memcpy(sdev->in[i].sg, sg, num * sizeof(*sg));
+	spin_unlock(&sdev->lock);
+
+	return i;
+}
+
+static void virtiosrv_sync(struct virtio_device *vdev, enum virtio_dir inout)
+{
+	struct virtiosrv_device *sdev = to_virtiosrv_dev(vdev);
+
+	if (sdev->out_running)
+		wake_up_all(&sdev->out_wq);
+	if (sdev->in_running)
+		wake_up_all(&sdev->in_wq);
+}
+
+static void virtiosrv_detach_outbuf(struct virtio_device *vdev, unsigned long id)
+{
+	struct virtiosrv_device *sdev = to_virtiosrv_dev(vdev);
+
+	spin_lock(&sdev->lock);
+	BUG_ON(id != 0);
+	BUG_ON(sdev->sg_num == 0);
+
+	/* Already started sending?  Fill with junk. */
+	if (sdev->sg_done > 0)
+		sdev->out_junk = sdev->out_head.len - sdev->sg_done;
+	else
+		sdev->sg_num = 0;
+	spin_unlock(&sdev->lock);
+}
+
+static void virtiosrv_detach_inbuf(struct virtio_device *vdev, unsigned long id)
+{
+	struct virtiosrv_device *sdev = to_virtiosrv_dev(vdev);
+
+	spin_lock(&sdev->lock);
+	BUG_ON(id >= VIRTIOSRV_MAX_INBUFS);
+	BUG_ON(!sdev->in[id].num);
+
+	/* Detach while being used?  Discard the rest. */
+	if (sdev->curr_in == &sdev->in[id]) {
+		sdev->discard = sdev->in_head.len - sdev->in_done;
+		sdev->curr_in = NULL;
+	}
+	sdev->in[id].num = 0;
+	spin_unlock(&sdev->lock);
+}
+
+static bool virtiosrv_restart_in(struct virtio_device *vdev)
+{
+	struct virtiosrv_device *sdev = to_virtiosrv_dev(vdev);
+
+	spin_lock(&sdev->lock);
+	BUG_ON(sdev->in_running);
+	sdev->in_running = true;
+	spin_unlock(&sdev->lock);
+
+	wake_up_all(&sdev->in_wq);
+	return true;
+}
+
+static bool virtiosrv_restart_out(struct virtio_device *vdev)
+{
+	struct virtiosrv_device *sdev = to_virtiosrv_dev(vdev);
+
+	spin_lock(&sdev->lock);
+	BUG_ON(sdev->out_running);
+	sdev->out_running = true;
+	spin_unlock(&sdev->lock);
+
+	wake_up_all(&sdev->out_wq);
+	return true;
+}
+
+static struct virtio_ops virtiosrv_ops = {
+	.add_outbuf = virtiosrv_add_outbuf,
+	.add_inbuf = virtiosrv_add_inbuf,
+	.sync = virtiosrv_sync,
+	.get_outbuf = virtiosrv_get_outbuf,
+	.get_inbuf = virtiosrv_get_inbuf,
+	.detach_outbuf = virtiosrv_detach_outbuf,
+	.detach_inbuf = virtiosrv_detach_inbuf,
+	.restart_in = virtiosrv_restart_in,
+	.restart_out = virtiosrv_restart_out,
+};
+
+static struct device virtiosrv_device = {
+	.bus_id = "virtio",
+};
+
+static int virtiosrv_register_device(struct virtiosrv_device *sdev, struct file *file)
+{
+	/*
+	 * make sure only one thread gets to do the setup, the mutex
+	 * protects both the write to the file->private_data pointer
+	 * and the idr.
+	 */
+	static DEFINE_MUTEX(setup_mutex);
+	int ret;
+
+	mutex_lock(&setup_mutex);
+	ret = -EBUSY;
+	if (file->private_data)
+		goto out;
+
+	ret = virtio_device_register(&sdev->vdev);
+	if (ret)
+		goto out;
+	file->private_data = sdev;
+out:
+	mutex_unlock(&setup_mutex);
+	return ret;
+}
+
+static int virtiosrv_setup(struct file *file, const void __user *buf, size_t len)
+{
+	struct virtiosrv_device *sdev;
+	struct virtio_device *vdev;
+	int ret;
+
+	/* allocate device */
+	if (len != sizeof (vdev->config))
+		return -EINVAL;
+	ret = -ENOMEM;
+	sdev = kzalloc(sizeof (*sdev), GFP_KERNEL);
+	if (!sdev)
+		goto out;
+	vdev = &sdev->vdev;
+
+	/* set up device data */
+	ret = -EFAULT;
+	if (copy_from_user(&vdev->config, buf, len))
+		goto out;
+	vdev->id.device_type = sdev->data->device_type;
+	vdev->ops = &virtiosrv_ops;
+	vdev->dev.parent = &virtiosrv_device;
+	sdev->data = (void*)&vdev->config.host;
+	snprintf(vdev->dev.bus_id, BUS_ID_SIZE, "virtio:%s", sdev->data->device_id);
+	init_waitqueue_head(&sdev->in_wq);
+	init_waitqueue_head(&sdev->out_wq);
+	spin_lock_init(&sdev->lock);
+
+	ret = virtiosrv_register_device(sdev, file);
+	if (ret)
+		goto out;
+	return len;
+
+out:
+	/* something went wrong, clean up */
+	kfree(sdev);
+	return ret;
+}
+
+static int virtiosrv_close(struct inode *inode, struct file *file)
+{
+	struct virtiosrv_device *sdev = file->private_data;
+
+	if (sdev)
+		return 0;
+
+	file->private_data = NULL;
+	virtio_device_unregister(&sdev->vdev);
+	kfree(sdev);
+	return 0;
+}
+
+/**
+ * virtiosrv_read - read one data element into the virtio device
+ *
+ * TODO: locking against virtio_ops
+ */
+static ssize_t virtiosrv_read(struct file *file, char __user *buf,
+				size_t len, loff_t *off)
+{
+	struct virtiosrv_device *sdev = file->private_data;
+	struct virtio_driver *vdrv = to_virtio_drv(sdev->vdev.dev.driver);
+	struct scatterlist *sg;
+	void *page;
+	int err;
+
+	if (!sdev)
+		return -ENODEV;
+
+	/* no data available at device, user needs to wait */
+	if ((file->f_flags & O_NONBLOCK) && (sdev->sg_elem >= sdev->sg_num))
+		return -EAGAIN;
+	err = wait_event_interruptible(sdev->out_wq,
+					sdev->sg_elem >= sdev->sg_num);
+	if (err)
+		return -ERESTARTSYS;
+
+	/*
+	 * user requested too small buffer, don't lose length
+	 * information
+	 */
+	sg = &sdev->sg[sdev->sg_elem];
+	if (sg->length > len)
+		return -ENOSPC;
+
+	/*
+	 * If buffer was detached while we're reading, send
+	 * junk after header
+	 */
+	if (sdev->sg_elem > 0 && sdev->out_junk) {
+		if (sdev->out_junk > len)
+			return -ENOSPC;
+
+		while (sdev->out_junk) {
+			err = put_user(42, buf);
+			if (err)
+				return -EFAULT;
+			buf++;
+			sdev->out_junk--;
+		}
+		sdev->sg_num = 0;
+		return sdev->out_junk;
+	}
+
+	/* copy one sg element to user space */
+	page = kmap(sg->page);
+	err = copy_to_user(buf, page + sg->offset, sg->length);
+	kunmap(page);
+	if (err)
+		return -EFAULT;
+
+	sdev->sg_done += sg->length;
+	sdev->sg_elem++;
+
+	if (sdev->sg_elem == sdev->sg_num)
+		sdev->out_running = vdrv->out(&sdev->vdev);
+
+	return sg->length;
+}
+
+/**
+ * virtiosrv_write - write data from the virtio device
+ *
+ * TODO: locking against virtio_ops
+ */
+static ssize_t virtiosrv_write(struct file *file, const char __user *buf,
+				size_t len, loff_t *off)
+{
+	struct virtiosrv_device *sdev = file->private_data;
+	ssize_t ret;
+	if (!sdev)
+		return virtiosrv_setup(file, buf, len);
+
+	while (unlikely(sdev->discard)) {
+		size_t discard = min_t(size_t, sdev->discard, len);
+		sdev->discard -= discard;
+		return discard;
+	}
+
+	ret = 0;
+	if (!sdev->curr_in) {
+		/* Haven't got the whole head yet?  Try reading more. */
+		if (sdev->in_done < sizeof(sdev->in_head)) {
+			size_t head_len;
+			head_len = sizeof (sdev->in_head) - sdev->in_done;
+			head_len = min(len, head_len);
+
+			ret = copy_from_user(&sdev->in_head + sdev->in_done,
+						buf, head_len);
+			if (ret)
+				return -EFAULT;
+			sdev->in_done += head_len;
+			len -= head_len;
+			if (sdev->in_done < sizeof(sdev->in_head))
+				return head_len;
+			buf += head_len;
+			ret = head_len;
+		}
+
+		/* try to find a free inbuf, wait if necessary */
+		sdev->curr_in = find_inbuf(sdev);
+		if (!sdev->curr_in) {
+			int err;
+			if (file->f_flags & O_NONBLOCK)
+				return -EAGAIN;
+
+			err = wait_event_interruptible(sdev->in_wq,
+				(sdev->curr_in = find_inbuf(sdev)) != NULL);
+			if (err)
+				return -ERESTARTSYS;
+		}
+
+		sdev->in_sg = 0;
+		sdev->in_done = 0;
+	}
+
+	/* Continue reading this buffer.  If it fills, we discard the rest. */
+	do {
+		struct scatterlist *sg;
+		void *page;
+		unsigned read;
+
+		sg = &sdev->curr_in->sg[sdev->in_sg];
+
+		read = min_t(size_t, sg->length, len);
+		if (sdev->in_head.len - sdev->in_done < read)
+			read = sdev->in_head.len - sdev->in_done;
+
+		page = kmap(sg->page);
+		ret = copy_from_user(page + sg->offset, buf, read);
+		kunmap(page);
+		if (ret)
+			return -EFAULT;
+
+		sg->offset += read;
+		sg->length -= read;
+		sdev->in_done += read;
+		buf += read;
+		ret += read;
+		len -= read;
+
+		if (sdev->in_done == sdev->in_head.len)
+			break;
+
+		if (sg->length != 0)
+			return ret;
+
+		sdev->in_sg++;
+	} while (sdev->in_sg < sdev->curr_in->num);
+
+	/* We finished the buffer: may need to discard some more data. */
+	if (sdev->in_done < sdev->in_head.len)
+		sdev->discard = sdev->in_head.len - sdev->in_done;
+
+	sdev->curr_in->finished = true;
+	sdev->curr_in->used = sdev->in_done;
+	sdev->curr_in = NULL;
+	sdev->in_done = 0;
+	return ret;
+}
+
+static unsigned int virtiosrv_poll(struct file *file,
+			struct poll_table_struct *wait)
+{
+	struct virtiosrv_device *sdev = file->private_data;
+	int mask = 0;
+
+	if (!sdev)
+		return 0;
+
+	poll_wait(file, &sdev->in_wq, wait);
+	poll_wait(file, &sdev->out_wq, wait);
+	if (sdev->sg_elem < sdev->sg_num)
+		mask |= POLLIN | POLLRDNORM;
+	if (find_inbuf(sdev))
+		mask |= POLLOUT | POLLWRNORM;
+
+	return mask;
+}
+
+static struct file_operations virtiosrv_fops = {
+	.owner = THIS_MODULE,
+	.open = nonseekable_open,
+	.release = virtiosrv_close,
+	.read = virtiosrv_read,
+	.write = virtiosrv_write,
+	.poll = virtiosrv_poll,
+};
+
+static struct miscdevice virtiosrv = {
+	.name = "virtiosrv",
+	.fops = &virtiosrv_fops,
+};
+
+static int __init virtiosrv_init(void)
+{
+	int ret;
+	ret = device_register(&virtiosrv_device);
+	if (ret)
+		return ret;
+
+	ret = misc_register(&virtiosrv);
+	if (ret)
+		device_unregister(&virtiosrv_device);
+
+	return ret;
+}
+module_init(virtiosrv_init);
+
+static void __exit virtiosrv_exit(void)
+{
+	misc_deregister(&virtiosrv);
+	device_unregister(&virtiosrv_device);
+}
+module_exit(virtiosrv_exit);
Index: linux-2.6/drivers/char/Makefile
===================================================================
--- linux-2.6.orig/drivers/char/Makefile
+++ linux-2.6/drivers/char/Makefile
@@ -103,6 +103,7 @@ obj-$(CONFIG_IPMI_HANDLER)	+= ipmi/
 
 obj-$(CONFIG_HANGCHECK_TIMER)	+= hangcheck-timer.o
 obj-$(CONFIG_TCG_TPM)		+= tpm/
+obj-$(CONFIG_VIRTIO_SERVER)	+= virtiosrv.o
 
 # Files generated that shall be removed upon make clean
 clean-files := consolemap_deftbl.c defkeymap.c

--
