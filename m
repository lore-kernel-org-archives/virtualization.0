From: Christian =?iso-8859-1?q?Borntr=E4ger?= <borntraeger@de.ibm.com>
Subject: [PATCH/RFC] virtio_test: A module for testing virtio via userspace
Date: Fri, 19 Jun 2009 09:27:34 +0200
Message-ID: <200906190927.34831.borntraeger__26789.3119053499$1245396553$gmane$org@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Tim Hofmann <tim.hofmann@de.ibm.com>, Christian Ehrhardt <ehrhardt@de.ibm.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, KVM list <kvm@vger.kernel.org>, Adrian Schneider <adrian.schneider@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Hello Rusty,

this is a result of a two month internship about virtio testing.

From: Adrian Schneider <adrian.schneider@de.ibm.com>
From: Tim Hofmann <tim.hofmann@de.ibm.com>
From: Christian Ehrhardt <ehrhardt@de.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>

This patch introduces a prototype for a virtio_test module. This module can
be bound to any virtio device via sysfs bind/unbind feature, e.g:
$ echo virtio1 > /sys/bus/virtio/drivers/virtio_rng/unbind
$ modprobe virtio_test

On probe this module registers to all virtqueues and creates a character
device for every virtio device. (/dev/viotest<number>).
The character device offers ioctls to allow a userspace application to submit
virtio operations like addbuf, kick and getbuf. It also offers ioctls to get
information about the device and to query the amount of occurred callbacks (or
wait synchronously on callbacks).

The driver currently lacks the following planned features:
o  userspace tooling for fuzzing (a prototype exists)
o  feature bit support
o  support arbitrary pointer mode in add_buf (e.g. test how qemu deals with
   iovecs pointing beyond the guest memory size)
o  priority binding with other virtio drivers (e.g. if virtio_blk and 
   virtio_test are compiled into the kernel, virtio_blk should get all block
   devices by default on hotplug)

I would like to get feedback on 

o  the general idea of a virtio_test module
o  the user interface ioctls
o  further ideas and comments 

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/virtio/Kconfig       |   12 
 drivers/virtio/Makefile      |    2 
 drivers/virtio/virtio_test.c |  710 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/Kbuild         |    1 
 include/linux/virtio_test.h  |  146 ++++++++
 5 files changed, 871 insertions(+)

Index: linux-2.6/drivers/virtio/Kconfig
===================================================================
--- linux-2.6.orig/drivers/virtio/Kconfig
+++ linux-2.6/drivers/virtio/Kconfig
@@ -33,3 +33,15 @@ config VIRTIO_BALLOON
 
 	 If unsure, say M.
 
+config VIRTIO_TEST
+	tristate "Virtio test driver (EXPERIMENTAL)"
+	select VIRTIO
+	select VIRTIO_RING
+	---help---
+	 This driver supports testing arbitrary virtio devices. The drivers
+	 offers IOCTLs to run add_buf/get_buf etc. from userspace. You can
+	 bind/unbind any unused virtio device to this driver via sysfs. Each
+	 bound device will get a /dev/viotest* device node.
+
+	 If unsure, say M.
+
Index: linux-2.6/drivers/virtio/Makefile
===================================================================
--- linux-2.6.orig/drivers/virtio/Makefile
+++ linux-2.6/drivers/virtio/Makefile
@@ -2,3 +2,5 @@ obj-$(CONFIG_VIRTIO) += virtio.o
 obj-$(CONFIG_VIRTIO_RING) += virtio_ring.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
+obj-$(CONFIG_VIRTIO_TEST) += virtio_test.o
+
Index: linux-2.6/drivers/virtio/virtio_test.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/virtio/virtio_test.c
@@ -0,0 +1,710 @@
+/*
+ *  Test driver for the virtio bus
+ *
+ *    Copyright IBM Corp. 2009
+ *    Author(s): Adrian Schneider <adrian.schneider@de.ibm.com>
+ *               Tim Hofmann <tim.hofmann@de.ibm.com>
+ *               Christian Ehrhardt <ehrhardt@de.ibm.com>
+ *               Christian Borntraeger <borntraeger@de.ibm.com>
+ */
+
+
+#define KMSG_COMPONENT "virtio_test"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/list.h>
+#include <linux/sched.h>
+#include <linux/uaccess.h>
+#include <linux/virtio.h>
+#include <linux/virtio_test.h>
+#include <linux/virtio_ring.h>
+
+static u32 viotest_major = VIOTEST_MAJOR;
+static struct class *viotest_class;
+static LIST_HEAD(viotest_list);
+static spinlock_t viotest_list_lock = SPIN_LOCK_UNLOCKED;
+
+static void free_kvec(struct kvec *kiov, u32 index)
+{
+	u32 i;
+
+	for (i = 0; i < index; i++)
+		kfree(kiov[i].iov_base);
+
+	kfree(kiov);
+}
+
+/*
+ * This function copies a userspace iovec * array into a kernel kvec * array
+ */
+static int copy_iovec_from_user(struct kvec **kiov, struct iovec __user *uiov,
+				u32 uiov_num)
+{
+	u32 i;
+	u64 kiov_sz;
+	struct iovec uservec;
+
+	kiov_sz = sizeof(struct kvec) * uiov_num;
+	*kiov = kmalloc(kiov_sz, GFP_KERNEL);
+	if (!(*kiov))
+		return -ENOMEM;
+
+	for (i = 0; i < uiov_num; i++) {
+		if (copy_from_user(&uservec, &uiov[i], sizeof(struct iovec))) {
+			free_kvec(*kiov, i);
+			return -EFAULT;
+		}
+		(*kiov)[i].iov_base = kmalloc(uservec.iov_len, GFP_KERNEL);
+		if (!(*kiov)[i].iov_base) {
+			free_kvec(*kiov, i);
+			return -ENOMEM;
+		}
+
+		if (copy_from_user((*kiov)[i].iov_base, uservec.iov_base, uservec.iov_len)) {
+			free_kvec(*kiov, i);
+			return -EFAULT;
+		}
+		(*kiov)[i].iov_len = uservec.iov_len;
+	}
+
+	return 0;
+}
+
+static int copy_kvec_to_user(struct iovec __user *uiov, struct kvec *kiov,
+			     u32 kiov_num)
+{
+	u32 i;
+	u64 uiov_sz;
+	struct iovec *iov;
+
+	uiov_sz = sizeof(struct iovec) * kiov_num;
+	iov = kmalloc(uiov_sz, GFP_KERNEL);
+	if (!iov)
+		return -ENOMEM;
+
+	if (copy_from_user(iov, uiov, uiov_sz))
+		goto out;
+
+	for (i = 0; i < kiov_num; i++)
+		if (copy_to_user(iov[i].iov_base, kiov[i].iov_base,
+				 iov[i].iov_len))
+			goto out;
+
+	return 0;
+
+out:
+	kfree(iov);
+	return -EFAULT;
+}
+
+static int init_sg(struct sg_table *sg, struct kvec *kiov, u32 kiov_sz)
+{
+	int err;
+	u32 i;
+	struct scatterlist *sgl;
+
+	err = sg_alloc_table(sg, kiov_sz, GFP_KERNEL);
+	if (err)
+		return err;
+
+	sg_init_table(sg->sgl, kiov_sz);
+
+	for_each_sg(sg->sgl, sgl, kiov_sz, i)
+	    sg_set_buf(sgl, kiov[i].iov_base, kiov[i].iov_len);
+
+	return 0;
+}
+
+static int sync_addbuf_from_user(struct viotest_kaddbuf *kaddbuf,
+				 struct viotest_uaddbuf *uaddbuf)
+{
+	int err;
+
+	kaddbuf->flags = uaddbuf->flags;
+	kaddbuf->vq_index = uaddbuf->vq_index;
+	kaddbuf->out = uaddbuf->out;
+	kaddbuf->in = uaddbuf->in;
+	kaddbuf->utoken = uaddbuf->token;
+	kaddbuf->udata = uaddbuf->data;
+
+	err = copy_iovec_from_user(&kaddbuf->kdata, kaddbuf->udata,
+				   kaddbuf->in + kaddbuf->out);
+
+	if (err)
+		return err;
+
+	err = init_sg(&kaddbuf->sg, kaddbuf->kdata, kaddbuf->in + kaddbuf->out);
+	if (err) {
+		free_kvec(kaddbuf->kdata, kaddbuf->in + kaddbuf->out);
+		return err;
+	}
+
+	return 0;
+}
+
+static struct viotest_vq *get_virtqueue(struct viotest_dev *vtest, u32 vq_index)
+{
+	struct viotest_vq *vtvq;
+
+	list_for_each_entry(vtvq, &vtest->vq_list, list)
+	    if (vtvq->index == vq_index)
+		return vtvq;
+
+	return ERR_PTR(-ENOENT);
+}
+
+static int do_add_buf(struct viotest_dev *vtest,
+		      struct viotest_kaddbuf *kaddbuf)
+{
+	int err;
+	struct viotest_vq *vtvq;
+
+	vtvq = get_virtqueue(vtest, kaddbuf->vq_index);
+	if (IS_ERR(vtvq))
+		return PTR_ERR(vtvq);
+
+	spin_lock(&vtvq->vq_lock);
+	list_add_tail(&kaddbuf->list, &vtvq->kaddbuf_list);
+	spin_unlock(&vtvq->vq_lock);
+
+	err = vtvq->vq->vq_ops->add_buf(vtvq->vq, kaddbuf->sg.sgl, kaddbuf->out,
+					kaddbuf->in, kaddbuf);
+	return err;
+}
+
+static int do_kick(struct viotest_dev *vtest, u32 __user *arg)
+{
+	struct viotest_vq *vtvq;
+	u32 vq_index;
+
+	if (copy_from_user(&vq_index, arg, sizeof(vq_index)))
+		return -EFAULT;
+
+	vtvq = get_virtqueue(vtest, vq_index);
+	if (IS_ERR(vtvq))
+		return PTR_ERR(vtvq);
+
+	vtvq->vq->vq_ops->kick(vtvq->vq);
+
+	return 0;
+}
+
+static void free_kaddbuf_element(struct viotest_kaddbuf *kaddbuf)
+{
+	free_kvec(kaddbuf->kdata, kaddbuf->in + kaddbuf->out);
+	sg_free_table(&kaddbuf->sg);
+	list_del(&kaddbuf->list);
+	kfree(kaddbuf);
+}
+
+static int do_get_buf(struct viotest_dev *vtest, struct viotest_getbuf __user *arg)
+{
+	int err;
+	struct viotest_vq *vtvq;
+	struct viotest_kaddbuf *kaddbuf;
+	struct viotest_getbuf getbuf;
+	unsigned int len;
+
+
+	if (copy_from_user(&getbuf, (struct viotest_getbuf __user *)arg, sizeof(struct viotest_getbuf)))
+		return -EFAULT;
+
+	vtvq = get_virtqueue(vtest, getbuf.vq_index);
+	if (IS_ERR(vtvq))
+		return PTR_ERR(vtvq);
+
+	spin_lock(&vtvq->vq_lock);
+	if (list_empty(&vtvq->kaddbuf_list)) {
+		spin_unlock(&vtvq->vq_lock);
+		return -EIO;
+	}
+	kaddbuf = list_first_entry(&vtvq->kaddbuf_list, struct viotest_kaddbuf,
+				   list);
+	spin_unlock(&vtvq->vq_lock);
+
+	if (!vtvq->vq->vq_ops->get_buf(vtvq->vq, &len))
+		return -EIO;
+
+
+	err = copy_kvec_to_user(kaddbuf->udata, kaddbuf->kdata,
+				kaddbuf->in + kaddbuf->out);
+	if (err)
+		return err;
+
+	if (copy_to_user(&(((struct viotest_getbuf __user *)arg)->token), &kaddbuf->utoken, sizeof(void *)))
+		return -EFAULT;
+
+	free_kaddbuf_element(kaddbuf);
+
+	return 0;
+}
+
+static int get_viodev_info(struct viotest_dev *vtest, struct viotest_info __user *arg)
+{
+	struct viotest_vq *vtvq;
+	struct viotest_info *info;
+
+	info = kzalloc(sizeof(struct viotest_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->device_id = vtest->vdev_id.device;
+	info->vendor_id = vtest->vdev_id.vendor;
+	list_for_each_entry(vtvq, &vtest->vq_list, list)
+	    info->num_vqs++;
+	if (copy_to_user(arg, info, sizeof(*info))) {
+		kfree(info);
+		return -EFAULT;
+	}
+	return 0;
+}
+
+static int get_callbacks(struct viotest_dev *vtest, struct viotest_cbinfo __user *arg)
+{
+	int ret;
+	struct viotest_vq *vtvq;
+	struct viotest_cbinfo cbi;
+
+	if (copy_from_user(&cbi, arg, sizeof(cbi)))
+		return -EFAULT;
+
+	/* WAIT and not CLEAR is inoperable because WAIT implies
+	 * a clear */
+	if (cbi.flags == GET_CALLBACK_WAIT)
+		return -EINVAL;
+
+	vtvq = get_virtqueue(vtest, cbi.vq_index);
+	if (IS_ERR(vtvq))
+		return -EINVAL;
+
+	if (cbi.flags & GET_CALLBACK_WAIT) {
+		if (wait_event_interruptible(vtvq->waithead,
+				vtvq->callback.received != vtvq->callback.reported))
+			return -ERESTARTSYS;
+
+		if (vtest->flags & CLEANUP_PENDING)
+			return -EBUSY;
+	}
+
+	spin_lock(&vtvq->vq_lock);
+
+	ret = vtvq->callback.received - vtvq->callback.reported;
+
+	if (cbi.flags & GET_CALLBACK_CLEAR)
+		vtvq->callback.reported = vtvq->callback.received;
+
+	spin_unlock(&vtvq->vq_lock);
+
+	if (copy_to_user(&arg->result, &ret, sizeof(ret)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int add_buf(struct viotest_dev *vtest, struct viotest_uaddbuf __user *arg)
+{
+	struct viotest_uaddbuf *uaddbuf;
+	struct viotest_kaddbuf *kaddbuf;
+	int err;
+
+		uaddbuf = kmalloc(sizeof(struct viotest_uaddbuf), GFP_KERNEL);
+		if (!uaddbuf)
+			return -ENOMEM;
+
+		if (copy_from_user
+		    (uaddbuf, (struct viotest_uaddbuf __user *)arg,
+		     sizeof(struct viotest_uaddbuf))) {
+			err = -EFAULT;
+			goto out_uaddbuf;
+		}
+
+		if (uaddbuf->flags & ADDBUF_REAL_POINTER) {
+			if (!capable(CAP_SYS_ADMIN))
+				return -EPERM;
+			/* FIXME: implement */
+			return -EOPNOTSUPP;
+		}
+
+		kaddbuf = kzalloc(sizeof(struct viotest_kaddbuf), GFP_KERNEL);
+		if (!kaddbuf) {
+			err = -ENOMEM;
+			goto out_uaddbuf;
+		}
+
+		err = sync_addbuf_from_user(kaddbuf, uaddbuf);
+		if (err)
+			goto out_kaddbuf;
+
+		err = do_add_buf(vtest, kaddbuf);
+		if (err)
+			goto out_sg;
+out_uaddbuf:
+		kfree(uaddbuf);
+		return err;
+
+out_sg:
+		sg_free_table(&kaddbuf->sg);
+		free_kvec(kaddbuf->kdata, kaddbuf->in + kaddbuf->out);
+out_kaddbuf:
+		kfree(kaddbuf);
+		goto out_uaddbuf;
+}
+
+static int viotest_ioctl(struct inode *inode, struct file *filp,
+			 unsigned int cmd, unsigned long arg)
+{
+	struct viotest_dev *vtest;
+	int ret;
+
+	vtest = filp->private_data;
+
+	/* if CLEANUP_PENDING block all ioctls on this device */
+	if (vtest->flags & CLEANUP_PENDING)
+		return -EBUSY;
+
+	/* increment the ref-count for each ioctl per device */
+	atomic_inc(&vtest->ref);
+
+	switch (cmd) {
+	case VIOTEST_IOCINFO:
+		ret = get_viodev_info(vtest, (struct viotest_info __user *) arg);
+		break;
+	case VIOTEST_IOCADDBUF:
+		ret = add_buf(vtest, (struct viotest_uaddbuf __user *) arg);
+		break;
+	case VIOTEST_IOCKICK:
+		ret = do_kick(vtest, (u32 __user *) arg);
+		break;
+	case VIOTEST_IOCGETBUF:
+		ret = do_get_buf(vtest, (struct viotest_getbuf __user *) arg);
+		break;
+	case VIOTEST_IOCGETCBS:
+		ret = get_callbacks(vtest, (struct viotest_cbinfo __user *) arg);
+		break;
+	default:
+		ret = -ENOTTY;
+		break;
+	}
+
+	atomic_dec(&vtest->ref);
+	return ret;
+}
+
+static void donebuf(struct virtqueue *vq)
+{
+	struct viotest_dev *vtest;
+	struct viotest_vq *vtvq;
+
+	vtest = vq->vdev->priv;
+
+	list_for_each_entry(vtvq, &vtest->vq_list, list)
+	    if ((vtvq->vq == vq) && !(vtest->flags & CLEANUP_PENDING)) {
+		vtvq->callback.received++;
+		wake_up_interruptible(&vtvq->waithead);
+
+		break;
+	}
+
+	return;
+}
+
+static int recv_virtqueue_list(struct viotest_dev *vtest)
+{
+	struct viotest_vq *vtvq;
+
+	/* Sigh. Since MSI-X support there is no common way to query to amount
+	 * of virtqueues. Lets start with max 4 virtqueues */
+	struct virtqueue *vqs[4];
+	vq_callback_t *callbacks[] = { donebuf, donebuf, donebuf, donebuf};
+	const char *names[] = { "test0", "test1", "test2", "test3" };
+	int num, i;
+	int ret;
+
+	INIT_LIST_HEAD(&vtest->vq_list);
+
+	for (num = 4; num >= 0; num--) {
+		if (num == 0)
+			return ret;
+		ret = vtest->vdev->config->find_vqs(vtest->vdev, num, vqs,
+							callbacks, names);
+		if (!ret)
+			break;
+		if (ret != -ENOENT)
+			return ret;
+	}
+
+	for (i = 0; i < num; i++) {
+		vtvq = kmalloc(sizeof(*vtvq), GFP_KERNEL);
+		if (!vtvq) {
+			vtest->vdev->config->del_vqs(vtest->vdev);
+			return -ENOMEM;
+		}
+
+		INIT_LIST_HEAD(&vtvq->kaddbuf_list);
+		vtvq->vq = vqs[i];
+		spin_lock_init(&vtvq->vq_lock);
+		init_waitqueue_head(&vtvq->waithead);
+		vtvq->index = i;
+		vtvq->callback.received  = 0;
+		vtvq->callback.reported  = 0;
+
+		list_add_tail(&vtvq->list, &vtest->vq_list);
+	}
+
+	return 0;
+}
+
+static void free_kaddbuf_list(struct list_head *kaddbuf_list)
+{
+	struct viotest_kaddbuf *kaddbuf;
+	struct list_head *pos, *q;
+
+	list_for_each_safe(pos, q, kaddbuf_list) {
+		kaddbuf = list_entry(pos, struct viotest_kaddbuf, list);
+		free_kvec(kaddbuf->kdata, kaddbuf->in + kaddbuf->out);
+		sg_free_table(&kaddbuf->sg);
+		list_del(pos);
+		kfree(kaddbuf);
+	}
+}
+
+static void free_virtqueue_list(struct virtio_device *vdev,
+				struct list_head *vq_list)
+{
+	struct viotest_vq *vtvq;
+	struct list_head *pos, *q;
+
+	list_for_each_safe(pos, q, vq_list) {
+		vtvq = list_entry(pos, struct viotest_vq, list);
+		free_kaddbuf_list(&vtvq->kaddbuf_list);
+		list_del(pos);
+		kfree(vtvq);
+	}
+	vdev->config->del_vqs(vdev);
+}
+
+static int create_devno(dev_t *devno)
+{
+	struct device *dev;
+	char dev_name[DEV_NAME_MAX];
+
+	snprintf(dev_name, DEV_NAME_MAX, "%s%u", "viotest", MINOR(*devno));
+	dev = device_create(viotest_class, NULL, *devno, NULL, dev_name);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	return 0;
+}
+
+static void reset_device(struct viotest_dev *vtest)
+{
+	struct viotest_vq *vtvq;
+
+	BUG_ON(!(vtest->flags & CLEANUP_PENDING));
+
+	list_for_each_entry(vtvq, &vtest->vq_list, list) {
+		/*set exit condition (diff = -1) */
+		spin_lock(&vtvq->vq_lock);
+		vtvq->callback.received = 1;
+		vtvq->callback.reported = 1;
+		spin_unlock(&vtvq->vq_lock);
+		wake_up_interruptible(&vtvq->waithead);
+
+		while (atomic_read(&vtest->ref))
+			schedule();
+	}
+
+	free_virtqueue_list(vtest->vdev, &vtest->vq_list);
+	vtest->vdev->config->reset(vtest->vdev);
+}
+
+static int initialize_device(struct viotest_dev *vtest)
+{
+	int err = 0;
+
+	atomic_set(&vtest->ref, 0);
+
+	err = recv_virtqueue_list(vtest);
+
+	return err;
+}
+
+
+static int viotest_probe(struct virtio_device *vdev)
+{
+	int err = 0;
+	struct viotest_dev *vtest = NULL;
+
+	vtest = kzalloc(sizeof(struct viotest_dev), GFP_KERNEL);
+	if (!vtest) {
+		err = -ENOMEM;
+		goto out3;
+	}
+
+	vtest->vdev_id = vdev->id;
+	vtest->vdev = vdev;
+	vtest->dev = MKDEV(viotest_major, vdev->index);
+
+	err = initialize_device(vtest);
+	if (err) {
+		goto out2;
+	}
+
+	spin_lock(&viotest_list_lock);
+	list_add_tail(&vtest->list, &viotest_list);
+	spin_unlock(&viotest_list_lock);
+
+	vdev->priv = vtest;
+
+	err = create_devno(&vtest->dev);
+	if (err)
+		goto out;
+
+	goto out3;
+
+out:
+	free_virtqueue_list(vdev, &vtest->vq_list);
+out2:
+	kfree(vtest);
+out3:
+	return err;
+}
+
+static void viotest_remove(struct virtio_device *vdev)
+{
+	struct viotest_dev *vtest;
+
+	vtest = vdev->priv;
+
+	/* CLEANUP_PENDING flag blocks all incomming syscalls for
+	 * device vdev. Necessary because some of the following
+	 * functions might wait */
+	vtest->flags |= CLEANUP_PENDING;
+
+	reset_device(vtest);
+
+	device_destroy(viotest_class, vtest->dev);
+
+	spin_lock(&viotest_list_lock);
+	list_del_init(&vtest->list);
+	spin_unlock(&viotest_list_lock);
+
+	kfree(vtest);
+
+}
+
+static int viotest_open(struct inode *inode, struct file *file)
+{
+	struct viotest_dev *vtest;
+	bool found=false;
+
+	spin_lock(&viotest_list_lock);
+
+	list_for_each_entry(vtest, &viotest_list, list)
+		if (iminor(inode) == MINOR(vtest->dev)){
+			found=true;
+			break;
+		}
+
+	BUG_ON(!found);
+
+	spin_unlock(&viotest_list_lock);
+
+	file->private_data = vtest;
+
+	return nonseekable_open(inode, file);
+}
+
+static int viotest_release(struct inode *inode, struct file *file)
+{
+	struct viotest_dev *vtest;
+	int err = 0;
+
+	vtest = file->private_data;
+
+	/* Lets bring back the virtio device into a sane state */
+	vtest->flags |= CLEANUP_PENDING;
+
+	reset_device(vtest);
+	vtest->vdev->config->set_status(vtest->vdev, VIRTIO_CONFIG_S_DRIVER |
+					VIRTIO_CONFIG_S_DRIVER_OK |
+					VIRTIO_CONFIG_S_ACKNOWLEDGE);
+
+	err = initialize_device(vtest);
+
+	vtest->flags = 0;
+
+	return err;
+}
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_DEV_ANY_ID, VIRTIO_DEV_ANY_ID },
+	{0},
+};
+
+static struct virtio_driver virtio_test = {
+	.driver.name = KBUILD_MODNAME,
+	.driver.owner = THIS_MODULE,
+	.id_table = id_table,
+	.probe = viotest_probe,
+	.remove = __devexit_p(viotest_remove),
+};
+
+static const struct file_operations viotest_fops = {
+	.owner = THIS_MODULE,
+	.open = viotest_open,
+	.release = viotest_release,
+	.ioctl = viotest_ioctl,
+};
+
+static int __init init(void)
+{
+	int err = 0;
+
+	if (!viotest_major)
+		viotest_major = register_chrdev(viotest_major, "virtio_test",
+						&viotest_fops);
+	else
+		err = register_chrdev(viotest_major, "virtio_test",
+				      &viotest_fops);
+	if (err || !viotest_major)
+		goto out;
+
+	viotest_class = class_create(THIS_MODULE, "viotest");
+	if (IS_ERR(viotest_class)) {
+		err = PTR_ERR(viotest_class);
+		goto failed_viotest;
+	}
+
+	err = register_virtio_driver(&virtio_test);
+	if (err) {
+		class_destroy(viotest_class);
+		goto failed_viotest;
+	}
+
+	return 0;
+
+failed_viotest:
+	unregister_chrdev(viotest_major, "virtio_test");
+out:
+	return err ? err : viotest_major;
+}
+
+static void __exit fini(void)
+{
+	unregister_virtio_driver(&virtio_test);
+	class_destroy(viotest_class);
+	unregister_chrdev(viotest_major, "virtio_test");
+}
+
+module_init(init);
+module_exit(fini);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tim Hofmann <tim.hofmann@de.ibm.com>");
+MODULE_AUTHOR("Adrian Schneider <adrian.schneider@de.ibm.com>");
+MODULE_AUTHOR("Christian Ehrhardt <ehrhardt@de.ibm.com>");
+MODULE_AUTHOR("Christian Borntraeger <borntraeger@de.ibm.com>");
+MODULE_DESCRIPTION("Test driver for virtio drivers/devices");
Index: linux-2.6/include/linux/Kbuild
===================================================================
--- linux-2.6.orig/include/linux/Kbuild
+++ linux-2.6/include/linux/Kbuild
@@ -365,6 +365,7 @@ unifdef-y += virtio_console.h
 unifdef-y += virtio_pci.h
 unifdef-y += virtio_ring.h
 unifdef-y += virtio_rng.h
+unifdef-y += virtio_test.h
 unifdef-y += vt.h
 unifdef-y += wait.h
 unifdef-y += wanrouter.h
Index: linux-2.6/include/linux/virtio_test.h
===================================================================
--- /dev/null
+++ linux-2.6/include/linux/virtio_test.h
@@ -0,0 +1,146 @@
+#ifndef _LINUX_VIRTIO_TEST_H
+#define _LINUX_VIRTIO_TEST_H
+
+#include <linux/uio.h>
+
+#define MAX_SG_ELEMENTS 8 /* for testing purpose */
+
+/**
+ * struct viotest_info - data structure for the VIOTEST_IOCINFO ioctl
+ * @num_vqs: The amount of available virtqueues
+ * @device_id: the device id on the virtio bus
+ * @vendor_id: the vendor id on the virtio bus
+ *
+ * This structure defines is used by the VIOTEST_IOCINFO ioctl. This structure
+ * describes the virtio device that is represented by a viotest device.
+ */
+struct viotest_info {
+	__u32 num_vqs;
+	__u32 device_id;
+	__u32 vendor_id;
+};
+
+/**
+ * struct viotest_uaddbuf - data structure for the VIOTEST_IOCADDBUF ioctl
+ * @flags:	Flags for the addbuf command
+ * @vq_index:	input parameter, specifying the virtqueue number
+ * @out:	input parameter, specifying the number of outgoing elements
+ * @in:		input parameter, specifying the number of incoming elements
+ * @token:	input parameter, specifying a token which is returned on getbuf
+ * @data:	input parameter, specifying userspace data pointers
+ *
+ * The VIOTEST_IOCADDBUF ioctl uses this data structure to tell the kernel
+ * which parameters should be used for the add_buf call. The normal kernel
+ * operation is to create bounce buffers in the kernel and do the add_buf on
+ * behalf of the userspace.
+ *
+ * The ADDBUF_REAL_POINTER flag (root-only) can be used to specify arbitrary
+ * pointers for the I/O operation.
+ */
+struct viotest_uaddbuf {
+#define ADDBUF_REAL_POINTER 1 << 0
+	__u32 flags;
+	__u32 vq_index;
+	__u32 out, in;
+	void *token;
+	struct iovec __user *data;
+};
+
+/**
+ * struct viotest_getbuf - data structure for the VIOTEST_IOCGETBUF ioctl
+ * @vq_index:	input parameter, specifying the virtqueue number
+ * @token:	output parameter, returning the token of the corresponding addbuf
+ */
+struct viotest_getbuf {
+	__u32 vq_index;
+	void *token;
+};
+
+/**
+ * struct viotest_cbinfo - data structure for the VIOTEST_IOCGETCBS ioctl
+ * @flags:	input parameter, specifying the flags for the ioctl
+ * @vq_index:	input parameter, specifying the virtqueue number
+ * @result:	output parameter, specifying the amount of callbacks since the
+ *		last GET_CALLBACK_CLEAR operation.
+ *
+ * The VIOTEST_IOCCBS can be used to query the amount of occured callbacks on
+ * a virtqueue, or to wait asynchronously for a callback to happen.
+ * Two flags can be used: GET_CALLBACK_WAIT and GET_CALLBACK_CLEAR.
+ *
+ * GET_CALLBACK_WAIT specifies to synchronously wait for a callback. If the
+ * callback counter is greater than 0, GET_CALLBACK_WAIT will return
+ * immediately. GET_CALLBACK_WAIT requires GET_CALLBACK_CLEAR.
+ *
+ * GET_CALLBACK_CLEAR specifies to reset the callback counter before returning
+ * to userspace.
+ */
+struct viotest_cbinfo {
+#define GET_CALLBACK_WAIT	1 << 0
+#define GET_CALLBACK_CLEAR	1 << 1
+	__u32 flags;
+	__u32 vq_index;
+	int result;
+};
+
+
+
+/* Use 'G' as magic number */
+#define VIOTEST_MAGIC  'G'
+
+#define VIOTEST_IOCINFO _IOR(VIOTEST_MAGIC, 1, struct viotest_info)
+#define VIOTEST_IOCADDBUF _IOW(VIOTEST_MAGIC, 2, struct viotest_uaddbuf)
+#define VIOTEST_IOCKICK _IOW(VIOTEST_MAGIC, 3, __u32)
+#define VIOTEST_IOCGETBUF _IOWR(VIOTEST_MAGIC, 4, struct viotest_getbuf)
+#define VIOTEST_IOCGETCBS _IOWR(VIOTEST_MAGIC, 5, struct viotest_cbinfo)
+
+#ifdef __KERNEL__
+#include <linux/kdev_t.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/virtio_config.h>
+#include <asm/atomic.h>
+
+#define VIOTEST_MAJOR 0
+#define DEV_NAME_MAX 32
+
+#define CLEANUP_PENDING		1 << 0
+
+struct viotest_callback {
+	__u32 received;	/*count of recieved callbacks*/
+	__u32 reported;	/*count of callbacks reported to userspace*/
+};
+
+struct viotest_kaddbuf {
+	__u32 flags;
+	__u32 vq_index;
+	__u32 out, in;
+	void *utoken;
+	struct iovec __user *udata;
+	struct kvec *kdata;
+	struct sg_table sg;
+	struct list_head list;
+};
+
+struct viotest_vq {
+	struct list_head list;
+	struct list_head kaddbuf_list;
+	struct virtqueue *vq;
+	struct viotest_callback callback;
+	spinlock_t vq_lock;
+	wait_queue_head_t waithead;
+	u32 index;
+};
+
+struct viotest_dev {
+	struct list_head list;
+	struct list_head vq_list;
+	struct virtio_device_id vdev_id;
+	struct virtio_device *vdev;
+	atomic_t ref;
+	dev_t dev;
+	__u32 flags;
+};
+
+#endif /* __KERNEL__ */
+
+#endif /* _LINUX_VIRTIO_TEST_H */
