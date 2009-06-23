From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH] virtio_serial: A char device for simple guest <-> host
	communication
Date: Tue, 23 Jun 2009 18:12:32 +0530
Message-ID: <1245760953-32139-2-git-send-email-amit.shah__31929.8170543791$1245761058$gmane$org@redhat.com>
References: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1245760953-32139-1-git-send-email-amit.shah@redhat.com>
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
Cc: Amit Shah <amit.shah@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

We expose multiple char devices ("ports") for simple communication
between the host userspace and guest.

This is mainly intended for obtaining information from the guest.
Sample offline usages can be: poking around in a guest to find out
the file systems used, applications installed, etc. Online usages
can be sharing of clipboard data between the guest and the host,
sending information about logged-in users to the host, locking the
screen or session when a vnc session is closed, and so on.

The interface presented to guest userspace is of a simple char
device, so it can be used like this:

	fd = open("/dev/vmch0", O_RDWR);
	ret = read(fd, buf, 100);
        ret = write(fd, string, strlen(string));
	ret = ioctl(fd, VIRTIO_SERIAL_IOCTL_GET_PORT_NAME, &port_name);

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/Kconfig          |    6 +
 drivers/char/Makefile         |    1 +
 drivers/char/virtio_serial.c  |  571 +++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_serial.h |   42 +++
 4 files changed, 620 insertions(+), 0 deletions(-)
 create mode 100644 drivers/char/virtio_serial.c
 create mode 100644 include/linux/virtio_serial.h

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 30bae6d..84a1718 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -679,6 +679,12 @@ config VIRTIO_CONSOLE
 	help
 	  Virtio console for use with lguest and other hypervisors.
 
+config VIRTIO_SERIAL
+	tristate "Virtio serial"
+	select VIRTIO
+	select VIRTIO_RING
+	help
+	  Virtio serial device driver for simple guest and host communication
 
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index 189efcf..0b6c71e 100644
--- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -54,6 +54,7 @@ obj-$(CONFIG_HVC_XEN)		+= hvc_xen.o
 obj-$(CONFIG_HVC_IUCV)		+= hvc_iucv.o
 obj-$(CONFIG_HVC_UDBG)		+= hvc_udbg.o
 obj-$(CONFIG_VIRTIO_CONSOLE)	+= virtio_console.o
+obj-$(CONFIG_VIRTIO_SERIAL)	+= virtio_serial.o
 obj-$(CONFIG_RAW_DRIVER)	+= raw.o
 obj-$(CONFIG_SGI_SNSC)		+= snsc.o snsc_event.o
 obj-$(CONFIG_MSPEC)		+= mspec.o
diff --git a/drivers/char/virtio_serial.c b/drivers/char/virtio_serial.c
new file mode 100644
index 0000000..6c5ad5d
--- /dev/null
+++ b/drivers/char/virtio_serial.c
@@ -0,0 +1,571 @@
+/*
+ * VirtIO Serial driver
+ *
+ * This is paravirtualised serial guest<->host communication channel
+ * for relaying short messages and events in either direction.
+ *
+ * One PCI device can have multiple serial ports so that different
+ * applications can communicate without polluting the PCI device space
+ * in the guest.
+ *
+ * Copyright (C) 2009, Red Hat, Inc.
+ *
+ * Author(s): Amit Shah <amit.shah@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/cdev.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/virtio.h>
+#include <linux/virtio_serial.h>
+#include <linux/workqueue.h>
+
+struct virtio_serial_struct {
+	struct virtio_device *vdev;
+	struct virtqueue *ctrl_vq;
+	struct virtqueue *in_vq, *out_vq;
+	struct virtio_serial_port *ports;
+	u32 nr_ports;
+	struct work_struct rx_work;
+	struct work_struct queue_work;
+};
+
+struct virtio_serial_port_buffer {
+	unsigned int len;
+	unsigned int offset;
+	char *buf;
+
+	struct list_head list;
+};
+
+struct virtio_serial_id {
+	u32 id; /* Port number */
+};
+
+struct virtio_serial_port {
+	struct virtio_serial_struct *virtserial;
+
+	/* The name given to this channel, if any. NOT zero-terminated */
+	char *name;
+
+	/* Each port associates with a separate char device */
+	dev_t dev;
+	struct cdev cdev;
+
+	/* Buffer management */
+	struct virtio_serial_port_buffer read_buf;
+	struct list_head readbuf_head;
+};
+
+static struct virtio_serial_struct virtserial;
+
+/* This should become per-port data */
+static DECLARE_COMPLETION(have_data);
+
+static int major = 60; /* from the experimental range */
+
+static struct virtio_serial_port *get_port_from_id(u32 id)
+{
+	if (id > virtserial.nr_ports)
+		return NULL;
+
+	return &virtserial.ports[id];
+}
+
+static int get_id_from_port(struct virtio_serial_port *port)
+{
+	u32 i;
+
+	for (i = 0; i < virtserial.nr_ports; i++) {
+		if (port == &virtserial.ports[i])
+			return i;
+	}
+	return VIRTIO_SERIAL_BAD_ID;
+}
+
+static struct virtio_serial_port *get_port_from_buf(char *buf)
+{
+	u32 id;
+
+	memcpy(&id, buf, sizeof(id));
+	if (id > virtserial.nr_ports)
+		return NULL;
+
+	return &virtserial.ports[id];
+}
+
+static void virtio_serial_queue_work_handler(struct work_struct *work)
+{
+	struct scatterlist sg[1];
+	struct page *page;
+	struct virtqueue *vq;
+	int ret;
+
+	vq = virtserial.in_vq;
+	while (1) {
+		page = kzalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!page)
+			break;
+
+		sg_init_one(sg, page, PAGE_SIZE);
+
+		ret = vq->vq_ops->add_buf(vq, sg, 0, 1, page);
+		if (ret < 0) {
+			kfree(page);
+			break;
+		}
+	}
+	vq->vq_ops->kick(vq);
+}
+
+static void virtio_serial_rx_work_handler(struct work_struct *work)
+{
+	struct virtio_serial_port *port = NULL;
+	struct virtio_serial_port_buffer *buf;
+	struct virtqueue *vq;
+	char *tmpbuf;
+	unsigned int tmplen;
+
+	vq = virtserial.in_vq;
+	while ((tmpbuf = vq->vq_ops->get_buf(vq, &tmplen))) {
+		port = get_port_from_buf(tmpbuf);
+		if (!port) {
+			/* No valid index at start of
+			 * buffer. Drop it.
+			 */
+			pr_debug("%s: invalid index in buffer, %c %d\n",
+				 __func__, tmpbuf[0], tmpbuf[0]);
+			break;
+		}
+		buf = kzalloc(sizeof(struct virtio_serial_port_buffer),
+			      GFP_KERNEL);
+		if (!buf)
+			break;
+
+		buf->buf = tmpbuf;
+		buf->len = tmplen;
+		buf->offset = sizeof(struct virtio_serial_id);
+		list_add_tail(&buf->list, &port->readbuf_head);
+
+		complete(&have_data);
+	}
+	/* Allocate buffers for all the ones that got used up */
+	schedule_work(&virtserial.queue_work);
+}
+
+static void receive_data(struct virtqueue *vq)
+{
+	schedule_work(&virtserial.rx_work);
+}
+
+static int receive_control_response(struct virtqueue *vq)
+{
+	int ret;
+	char *data;
+	unsigned int len;
+	struct virtio_serial_port *port;
+	struct virtio_serial_control ser_control;
+
+	/* We can get spurious callbacks, e.g. shared IRQs + virtio_pci. */
+	data = vq->vq_ops->get_buf(vq, &len);
+	if (!data)
+		return 0;
+
+	/* Not enough data for the ioctl:
+	 * key + id + data
+	 */
+	/* XXX: return something else? */
+	if (len < sizeof(ser_control) + 1)
+		return -EIO;
+
+	memcpy(&ser_control, data, sizeof(ser_control));
+	len -= sizeof(ser_control);
+
+	ret = -EINVAL;
+	switch (ser_control.key) {
+	case VIRTIO_SERIAL_GET_PORT_NAME:
+		port = get_port_from_id(ser_control.port_nr);
+		if (!port) {
+			ret = -EINVAL;
+			break;
+		}
+
+		if (len > VIRTIO_SERIAL_NAME_MAX_LEN)
+			len = VIRTIO_SERIAL_NAME_MAX_LEN;
+
+		/* If the port is getting renamed */
+		kfree(port->name);
+
+		port->name = kzalloc(len, GFP_KERNEL);
+		if (!port->name) {
+			ret = -ENOMEM;
+			break;
+		}
+		memcpy(port->name, data + sizeof(ser_control), len);
+		ret = len;
+		break;
+	}
+	return ret;
+}
+
+static int request_control_info(struct virtio_serial_control *ser_control)
+{
+	int ret;
+	char *vbuf, *obuf;
+	struct scatterlist sg[2];
+
+	vbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!vbuf)
+		return -ENOMEM;
+	obuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!obuf)
+		return -ENOMEM;
+
+	memcpy(vbuf, ser_control, sizeof(ser_control));
+
+	sg_init_table(sg, 2);
+	sg_set_buf(&sg[0], vbuf, PAGE_SIZE);
+	sg_set_buf(&sg[1], obuf, PAGE_SIZE);
+
+	if (virtserial.ctrl_vq->vq_ops->add_buf(virtserial.ctrl_vq, sg, 1, 1,
+						obuf) == 0) {
+		/* Tell Host to go! */
+		virtserial.ctrl_vq->vq_ops->kick(virtserial.ctrl_vq);
+
+		/* Chill out until it's done with the buffer. */
+		while (!(ret = receive_control_response(virtserial.ctrl_vq)))
+			cpu_relax();
+	}
+	kfree(vbuf);
+	kfree(obuf);
+
+	return ret;
+}
+
+static ssize_t virtserial_read(struct file *filp, char __user *ubuf,
+			       size_t count, loff_t *offp)
+{
+	struct list_head *ptr, *ptr2;
+	struct virtio_serial_port *port;
+	struct virtio_serial_port_buffer *buf;
+	ssize_t ret;
+
+	port = filp->private_data;
+
+	if (list_empty(&port->readbuf_head))
+		return 0;
+
+	list_for_each_safe(ptr, ptr2, &port->readbuf_head) {
+		buf = list_entry(ptr, struct virtio_serial_port_buffer, list);
+
+		/* FIXME: other buffers further in this list might
+		 * have data too
+		 */
+		if (count > buf->len - buf->offset)
+			count = buf->len - buf->offset;
+
+		ret = copy_to_user(ubuf, buf->buf + buf->offset, count);
+
+		/* Return the number of bytes actually copied */
+		ret = count - ret;
+
+		buf->offset += ret;
+
+		if (buf->len - buf->offset == 0) {
+			list_del(&buf->list);
+			kfree(buf->buf);
+			kfree(buf);
+		}
+		/* FIXME: if there's more data requested and more data
+		 * available, return it.
+		 */
+		break;
+	}
+
+	return ret;
+}
+
+static ssize_t virtserial_write(struct file *filp, const char __user *ubuf,
+				size_t count, loff_t *offp)
+{
+	ssize_t ret;
+	char *vbuf;
+	unsigned int len, size;
+	struct virtqueue *out_vq;
+	struct scatterlist sg[1];
+	struct virtio_serial_port *port;
+	struct virtio_serial_id id;
+
+	port = filp->private_data;
+
+	id.id = get_id_from_port(port);
+
+	size = min(count + sizeof(id), PAGE_SIZE);
+	vbuf = kmalloc(size, GFP_KERNEL);
+	if (!vbuf)
+		return -EFBIG;
+
+	memcpy(vbuf, &id, sizeof(id));
+	size -= sizeof(id);
+
+	ret = copy_from_user(vbuf + sizeof(id), ubuf, size);
+
+	/* Return the number of bytes actually written */
+	ret = size - ret;
+
+	out_vq = virtserial.out_vq;
+
+	sg_init_one(sg, vbuf, ret + sizeof(id));
+
+	/* add_buf wants a token to identify this buffer: we hand it any
+	 * non-NULL pointer, since there's only ever one buffer.
+	 */
+	if (out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, (void *)1) == 0) {
+		/* Tell Host to go! */
+		out_vq->vq_ops->kick(out_vq);
+		/* Chill out until it's done with the buffer. */
+		while (!out_vq->vq_ops->get_buf(out_vq, &len))
+			cpu_relax();
+	}
+	kfree(vbuf);
+
+	/* FIXME: Write out the complete data in more buffers,
+	 * don't just bail out after one
+	 */
+
+	/* We're expected to return the amount of data we wrote */
+	return ret;
+}
+
+static long virtserial_ioctl(struct file *filp, unsigned int ioctl,
+			     unsigned long arg)
+{
+	long ret;
+	struct virtio_serial_control ser_control;
+	struct virtio_serial_port *port;
+	struct virtio_serial_port_name *port_name;
+
+	port = filp->private_data;
+	ser_control.port_nr = get_id_from_port(port);
+
+	ret = -EINVAL;
+	switch (ioctl) {
+	case VIRTIO_SERIAL_IOCTL_GET_PORT_NAME:
+
+		port_name = (struct virtio_serial_port_name *)arg;
+
+		if (!port->name) {
+			if (ser_control.port_nr == VIRTIO_SERIAL_BAD_ID) {
+				ret = -EINVAL;
+				break;
+			}
+			ser_control.key = VIRTIO_SERIAL_GET_PORT_NAME;
+			ret = request_control_info(&ser_control);
+			if (ret < 0) {
+				/* Of IOCTL error return codes, only
+				 * this one comes close to what has
+				 * happened: either out of memory or
+				 * the virtio-serial backend didn't
+				 * have the associated name for the
+				 * port
+				 */
+				ret = -EINVAL;
+				break;
+			}
+		}
+		ret = copy_to_user(port_name->name,
+				   port->name, VIRTIO_SERIAL_NAME_MAX_LEN);
+		if (ret < 0) {
+			ret = -EINVAL;
+			break;
+		}
+		if (ret > 0) {
+			/* Do something? There still is data to be
+			 * copied to userspace
+			 */
+			ret = 0;
+		}
+		break;
+	}
+	return ret;
+}
+
+static int virtserial_release(struct inode *inode, struct file *filp)
+{
+	pr_notice("%s\n", __func__);
+	return 0;
+}
+
+static int virtserial_open(struct inode *inode, struct file *filp)
+{
+	struct cdev *cdev = inode->i_cdev;
+	struct virtio_serial_port *port;
+
+	port = container_of(cdev, struct virtio_serial_port,
+			    cdev);
+
+	filp->private_data = port;
+	return 0;
+}
+
+static unsigned int virtserial_poll(struct file *filp, poll_table *wait)
+{
+	pr_notice("%s\n", __func__);
+	return 0;
+}
+
+static const struct file_operations virtserial_fops = {
+	.owner = THIS_MODULE,
+	.open  = virtserial_open,
+	.read  = virtserial_read,
+	.write = virtserial_write,
+	.compat_ioctl = virtserial_ioctl,
+	.unlocked_ioctl = virtserial_ioctl,
+	.poll  = virtserial_poll,
+	.release = virtserial_release,
+};
+
+static int virtserial_probe(struct virtio_device *vdev)
+{
+	int i, ret;
+	const char *vq_names[] = { "control", "input", "output" };
+	vq_callback_t *vq_callbacks[] = { NULL, receive_data, NULL };
+	struct virtqueue *vqs[3];
+	struct virtio_serial_port *port;
+	struct virtio_serial_config virtsercfg;
+
+	vdev->config->get(vdev, offsetof(struct virtio_serial_config, nr_ports),
+			  &virtsercfg.nr_ports, sizeof(virtsercfg.nr_ports));
+
+	virtserial.vdev = vdev;
+	virtserial.nr_ports = virtsercfg.nr_ports;
+	virtserial.ports = kzalloc(sizeof(struct virtio_serial_port)
+				   * virtserial.nr_ports, GFP_KERNEL);
+	if (!virtserial.ports) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+	ret = vdev->config->find_vqs(vdev, 3, vqs, vq_callbacks, vq_names);
+	if (ret)
+		goto free_vqs;
+
+	virtserial.ctrl_vq = vqs[0];
+	virtserial.in_vq = vqs[1];
+	virtserial.out_vq = vqs[2];
+
+	for (i = 0; i < virtserial.nr_ports; i++) {
+		port = &virtserial.ports[i];
+
+		INIT_LIST_HEAD(&port->readbuf_head);
+
+		cdev_init(&port->cdev, &virtserial_fops);
+		port->dev = MKDEV(major, i);
+
+		/* XXX Do this for each port or do it once? */
+		ret = register_chrdev_region(port->dev, 1, "virtio-serial");
+		if (ret < 0) {
+			pr_err("%s: can't register chrdev region\n",
+			       __func__);
+			goto free_cdev;
+		}
+		ret = cdev_add(&port->cdev, port->dev, 1);
+		if (ret < 0) {
+			pr_err("%s: can't add cdev\n", __func__);
+			goto free_cdev;
+		}
+	}
+	INIT_WORK(&virtserial.rx_work, &virtio_serial_rx_work_handler);
+	INIT_WORK(&virtserial.queue_work, &virtio_serial_queue_work_handler);
+
+	/* Allocate pages to fill the receive queue */
+	schedule_work(&virtserial.queue_work);
+
+	return 0;
+
+free_cdev:
+	unregister_chrdev(major, "virtio-serial");
+free_vqs:
+	vdev->config->del_vqs(vdev);
+fail:
+	return ret;
+}
+
+
+static void virtserial_remove(struct virtio_device *vdev)
+{
+	int len;
+	u32 i;
+	char *buf;
+
+	cancel_work_sync(&virtserial.rx_work);
+	while ((buf = virtserial.in_vq->vq_ops->get_buf(virtserial.in_vq, &len)))
+		kfree(buf);
+
+	vdev->config->del_vqs(vdev);
+
+	unregister_chrdev(major, "virtio-serial");
+	for (i = 0; i < virtserial.nr_ports; i++) {
+		struct virtio_serial_port *port;
+
+		port = &virtserial.ports[i];
+		kfree(port->name);
+	}
+}
+
+static void virtserial_apply_config(struct virtio_device *vdev)
+{
+	struct virtio_serial_config virtserconf;
+
+	vdev->config->get(vdev, offsetof(struct virtio_serial_config, nr_ports),
+			  &virtserconf.nr_ports, sizeof(virtserconf.nr_ports));
+	/* FIXME: hot-add or remove ports */
+}
+
+
+static struct virtio_device_id id_table[] = {
+	{ VIRTIO_ID_SERIAL, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+
+static struct virtio_driver virtio_serial = {
+  //	.feature_table = features,
+  //	.feature_table_size = ARRAY_SIZE(features),
+	.driver.name =	KBUILD_MODNAME,
+	.driver.owner =	THIS_MODULE,
+	.id_table =	id_table,
+	.probe =	virtserial_probe,
+	.remove =	virtserial_remove,
+	.config_changed = virtserial_apply_config,
+};
+
+static int __init init(void)
+{
+	return register_virtio_driver(&virtio_serial);
+}
+
+static void __exit fini(void)
+{
+	unregister_virtio_driver(&virtio_serial);
+}
+module_init(init);
+module_exit(fini);
+
+MODULE_DEVICE_TABLE(virtio, id_table);
+MODULE_DESCRIPTION("Virtio serial driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio_serial.h b/include/linux/virtio_serial.h
new file mode 100644
index 0000000..3f33ade
--- /dev/null
+++ b/include/linux/virtio_serial.h
@@ -0,0 +1,42 @@
+#ifndef _LINUX_VIRTIO_SERIAL_H
+#define _LINUX_VIRTIO_SERIAL_H
+#include <linux/types.h>
+#include <linux/virtio_config.h>
+
+/* Guest kernel - Host interface */
+
+/* The ID for virtio serial */
+#define VIRTIO_ID_SERIAL		7
+#define VIRTIO_SERIAL_BAD_ID		(~(u32)0)
+
+struct virtio_serial_config {
+	__u32 nr_ports;
+	__u16 status;
+} __attribute__((packed));
+
+struct virtio_serial_control
+{
+    __u32 port_nr;
+    __u32 key;
+};
+
+/* Some defines for the control channel key */
+#define VIRTIO_SERIAL_GET_PORT_NAME	1
+
+#ifdef __KERNEL__
+
+/* Guest kernel - Guest userspace interface */
+
+/* IOCTL-related */
+#define VIRTIO_SERIAL_IO 0xAF
+
+#define VIRTIO_SERIAL_NAME_MAX_LEN	30
+struct virtio_serial_port_name {
+	char name[VIRTIO_SERIAL_NAME_MAX_LEN];
+};
+
+#define VIRTIO_SERIAL_IOCTL_GET_PORT_NAME	_IOWR(VIRTIO_SERIAL_IO, 0x00, \
+			    struct virtio_serial_port_name)
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_VIRTIO_SERIAL_H */
-- 
1.6.2.2
