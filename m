From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 1/1] virtio_serial: A char device for simple guest <-> host
	communication
Date: Mon, 27 Jul 2009 23:34:33 +0530
Message-ID: <1248717876-17630-2-git-send-email-amit.shah__15371.1339379244$1248718032$gmane$org@redhat.com>
References: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1248717876-17630-1-git-send-email-amit.shah@redhat.com>
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

Each port is to be assigned a unique function, for example, the first
4 ports may be reserved for libvirt usage, the next 4 for generic
streaming data and so on. This port-function mapping isn't finalised
yet.

For requirements, use-cases and some history see

    http://www.linux-kvm.org/page/VMchannel_Requirements

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/Kconfig          |    6 +
 drivers/char/Makefile         |    1 +
 drivers/char/virtio_serial.c  |  690 +++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_serial.h |   27 ++
 4 files changed, 724 insertions(+), 0 deletions(-)
 create mode 100644 drivers/char/virtio_serial.c
 create mode 100644 include/linux/virtio_serial.h

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 6a06913..51adb48 100644
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
index 66f779a..5e1915b 100644
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
index 0000000..f42709d
--- /dev/null
+++ b/drivers/char/virtio_serial.c
@@ -0,0 +1,690 @@
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
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/poll.h>
+#include <linux/virtio.h>
+#include <linux/virtio_serial.h>
+#include <linux/workqueue.h>
+
+struct virtio_serial_struct {
+	struct work_struct rx_work;
+	struct work_struct tx_work;
+	struct work_struct queue_work;
+	struct work_struct config_work;
+
+	struct list_head port_head;
+
+	struct virtio_device *vdev;
+	struct class *class;
+	struct virtqueue *in_vq, *out_vq;
+
+	struct virtio_serial_config *config;
+};
+
+/* This struct holds individual buffers received for each port */
+struct virtio_serial_port_buffer {
+	struct list_head list;
+
+	unsigned int len; /* length of the buffer */
+	unsigned int offset; /* offset in the buf from which to consume data */
+
+	char *buf;
+};
+
+/* This struct is put in each buffer that gets passed to userspace and
+ * vice-versa
+ */
+struct virtio_serial_id {
+	u32 id; /* Port number */
+};
+
+struct virtio_serial_port {
+	/* Next port in the list */
+	struct list_head next;
+
+	/* Buffer management */
+	struct virtio_serial_port_buffer read_buf;
+	struct list_head readbuf_head;
+	struct completion have_data;
+
+	/* Each port associates with a separate char device */
+	struct cdev cdev;
+	struct device *dev;
+};
+
+static struct virtio_serial_struct virtserial;
+
+static int major = 60; /* from the experimental range */
+
+static struct virtio_serial_port *get_port_from_id(u32 id)
+{
+	struct virtio_serial_port *port;
+	struct list_head *ptr;
+
+	list_for_each(ptr, &virtserial.port_head) {
+		port = list_entry(ptr, struct virtio_serial_port, next);
+
+		if (MINOR(port->dev->devt) == id)
+			return port;
+	}
+	return NULL;
+}
+
+static int get_id_from_port(struct virtio_serial_port *port)
+{
+	struct virtio_serial_port *match;
+	struct list_head *ptr;
+
+	list_for_each(ptr, &virtserial.port_head) {
+		match = list_entry(ptr, struct virtio_serial_port, next);
+
+		if (match == port)
+			return MINOR(port->dev->devt);
+	}
+	return VIRTIO_SERIAL_BAD_ID;
+}
+
+static struct virtio_serial_port *get_port_from_buf(char *buf)
+{
+	u32 id;
+
+	memcpy(&id, buf, sizeof(id));
+
+	return get_port_from_id(id);
+}
+
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
+	ret = -EINTR;
+	if (list_empty(&port->readbuf_head)) {
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		if (wait_for_completion_interruptible(&port->have_data) < 0)
+			return ret;
+	}
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
+	return ret;
+}
+
+/* For data that exceeds PAGE_SIZE in size we should send it all in
+ * one sg to not unnecessarily split up the data. Also some (all?)
+ * vnc clients don't consume split data.
+ *
+ * If we are to keep PAGE_SIZE sized buffers, we then have to stack
+ * multiple of those in one virtio request. virtio-ring returns to us
+ * just one pointer for all the buffers. So use this struct to
+ * allocate the bufs in so that freeing this up later is easier.
+ */
+struct vbuf {
+	char **bufs;
+	struct scatterlist *sg;
+	unsigned int nent;
+};
+
+static ssize_t virtserial_write(struct file *filp, const char __user *ubuf,
+				size_t count, loff_t *offp)
+{
+	struct virtqueue *out_vq;
+	struct virtio_serial_port *port;
+	struct virtio_serial_id id;
+	struct vbuf *vbuf;
+	size_t offset, size;
+	ssize_t ret;
+	int i, id_len;
+
+	port = filp->private_data;
+	id.id = get_id_from_port(port);
+	out_vq = virtserial.out_vq;
+
+	id_len = sizeof(id);
+
+	ret = -EFBIG;
+	vbuf = kzalloc(sizeof(struct vbuf), GFP_KERNEL);
+	if (!vbuf)
+		return ret;
+
+	/* Max. number of buffers clubbed together in one message */
+	vbuf->nent = (count + id_len + PAGE_SIZE - 1) / PAGE_SIZE;
+
+	vbuf->bufs = kzalloc(vbuf->nent, GFP_KERNEL);
+	if (!vbuf->bufs)
+		goto free_vbuf;
+
+	vbuf->sg = kzalloc(vbuf->nent, GFP_KERNEL);
+	if (!vbuf->sg)
+		goto free_bufs;
+	sg_init_table(vbuf->sg, vbuf->nent);
+
+	i = 0; /* vbuf->bufs[i] */
+	offset = 0; /* offset in the user buffer */
+	while (count - offset) {
+		size = min(count - offset + id_len, PAGE_SIZE);
+		vbuf->bufs[i] = kzalloc(size, GFP_KERNEL);
+		if (!vbuf->bufs[i]) {
+			ret = -EFBIG;
+			goto free_buffers;
+		}
+		if (id_len) {
+			memcpy(vbuf->bufs[i], &id, id_len);
+			size -= id_len;
+		}
+		ret = copy_from_user(vbuf->bufs[i] + id_len, ubuf + offset, size);
+		offset += size - ret;
+
+		sg_set_buf(&vbuf->sg[i], vbuf->bufs[i], size - ret + id_len);
+		id_len = 0; /* Pass the port id only in the first buffer */
+		i++;
+	}
+	if (out_vq->vq_ops->add_buf(out_vq, vbuf->sg, i, 0, vbuf)) {
+		/* XXX: We can't send the buffer. Report failure */
+		ret = 0;
+	}
+	/* Tell Host to go! */
+	out_vq->vq_ops->kick(out_vq);
+
+	/* We're expected to return the amount of data we wrote */
+	return offset;
+free_buffers:
+	while (i--)
+		kfree(vbuf->bufs[i]);
+	kfree(vbuf->sg);
+free_bufs:
+	kfree(vbuf->bufs);
+free_vbuf:
+	kfree(vbuf);
+	return ret;
+}
+
+static long virtserial_ioctl(struct file *filp, unsigned int ioctl,
+			     unsigned long arg)
+{
+	struct virtio_serial_port *port;
+	long ret;
+
+	port = filp->private_data;
+
+	ret = -EINVAL;
+	switch (ioctl) {
+	default:
+		break;
+	}
+	return ret;
+}
+
+static int virtserial_release(struct inode *inode, struct file *filp)
+{
+	filp->private_data = NULL;
+	return 0;
+}
+
+static int virtserial_open(struct inode *inode, struct file *filp)
+{
+	struct cdev *cdev = inode->i_cdev;
+	struct virtio_serial_port *port;
+
+	port = container_of(cdev, struct virtio_serial_port, cdev);
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
+static void virtio_serial_queue_work_handler(struct work_struct *work)
+{
+	struct scatterlist sg[1];
+	struct virtqueue *vq;
+	char *buf;
+
+	vq = virtserial.in_vq;
+	while (1) {
+		buf = kzalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!buf)
+			break;
+
+		sg_init_one(sg, buf, PAGE_SIZE);
+
+		if (vq->vq_ops->add_buf(vq, sg, 0, 1, buf) < 0) {
+			kfree(buf);
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
+		complete(&port->have_data);
+	}
+	/* Allocate buffers for all the ones that got used up */
+	schedule_work(&virtserial.queue_work);
+}
+
+static void virtio_serial_tx_work_handler(struct work_struct *work)
+{
+	struct virtqueue *vq;
+	struct vbuf *vbuf;
+	unsigned int tmplen;
+	int i;
+
+	vq = virtserial.out_vq;
+	while ((vbuf = vq->vq_ops->get_buf(vq, &tmplen))) {
+		for (i = 0; i < vbuf->nent; i++) {
+			kfree(vbuf->bufs[i]);
+		}
+		kfree(vbuf->bufs);
+		kfree(vbuf->sg);
+		kfree(vbuf);
+	}
+}
+
+static void rx_intr(struct virtqueue *vq)
+{
+	schedule_work(&virtserial.rx_work);
+}
+
+static void tx_intr(struct virtqueue *vq)
+{
+	schedule_work(&virtserial.tx_work);
+}
+
+static void config_intr(struct virtio_device *vdev)
+{
+	schedule_work(&virtserial.config_work);
+}
+
+static u32 virtserial_get_hot_add_port(struct virtio_serial_config *config)
+{
+	u32 i;
+	u32 port_nr;
+
+	for (i = 0; i < virtserial.config->max_nr_ports / 32; i++) {
+		port_nr = ffs(config->ports_map[i] ^ virtserial.config->ports_map[i]);
+		if (port_nr)
+			break;
+	}
+	if (unlikely(!port_nr))
+		return VIRTIO_SERIAL_BAD_ID;
+
+	/* We used ffs above */
+	port_nr--;
+
+	/* FIXME: Do this only when add_port is successful */
+	virtserial.config->ports_map[i] |= 1U << port_nr;
+
+	port_nr += i * 32;
+	return port_nr;
+}
+
+static u32 virtserial_find_next_port(u32 *map, int *map_i)
+{
+	u32 port_nr;
+
+	while (1) {
+		port_nr = ffs(*map);
+		if (port_nr)
+			break;
+
+		if (unlikely(*map_i >= virtserial.config->max_nr_ports / 32))
+			return VIRTIO_SERIAL_BAD_ID;
+		++*map_i;
+		*map = virtserial.config->ports_map[*map_i];
+	}
+	/* We used ffs above */
+	port_nr--;
+
+	/* FIXME: Do this only when add_port is successful / reset bit
+	 * in config space if add_port was unsuccessful
+	 */
+	*map &= ~(1U << port_nr);
+
+	port_nr += *map_i * 32;
+	return port_nr;
+}
+
+static int virtserial_add_port(u32 port_nr)
+{
+	struct virtio_serial_port *port;
+	dev_t devt;
+	int ret;
+
+	port = kzalloc(sizeof(struct virtio_serial_port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	devt = MKDEV(major, port_nr);
+	cdev_init(&port->cdev, &virtserial_fops);
+
+	ret = register_chrdev_region(devt, 1, "virtio-serial");
+	if (ret < 0) {
+		pr_err("%s: error registering chrdev region, ret = %d\n",
+		       __func__, ret);
+		goto free_cdev;
+	}
+	ret = cdev_add(&port->cdev, devt, 1);
+	if (ret < 0) {
+		pr_err("%s: error adding cdev, ret = %d\n", __func__, ret);
+		goto free_cdev;
+	}
+	port->dev = device_create(virtserial.class, NULL, devt, NULL,
+				  "vmch%u", port_nr);
+	if (IS_ERR(port->dev)) {
+		ret = PTR_ERR(port->dev);
+		pr_err("%s: Error creating device, ret = %d\n", __func__, ret);
+		goto free_cdev;
+	}
+	INIT_LIST_HEAD(&port->readbuf_head);
+	init_completion(&port->have_data);
+
+	list_add_tail(&port->next, &virtserial.port_head);
+
+	pr_info("virtio-serial port found at id %u\n", port_nr);
+
+	return 0;
+free_cdev:
+	unregister_chrdev(major, "virtio-serial");
+	return ret;
+}
+
+static __u32 get_ports_map_size(__u32 max_ports)
+{
+	return sizeof(__u32) * ((max_ports + 31) / 32);
+}
+
+static void virtio_serial_config_work_handler(struct work_struct *work)
+{
+	struct virtio_serial_config *virtserconf;
+	struct virtio_device *vdev = virtserial.vdev;
+	u32 i, port_nr;
+	int ret;
+
+	virtserconf = kmalloc(sizeof(struct virtio_serial_config) +
+			      get_ports_map_size(virtserial.config->max_nr_ports),
+			      GFP_KERNEL);
+	vdev->config->get(vdev,
+			  offsetof(struct virtio_serial_config, nr_active_ports),
+			  &virtserconf->nr_active_ports,
+			  sizeof(virtserconf->nr_active_ports));
+	vdev->config->get(vdev,
+			  offsetof(struct virtio_serial_config, ports_map),
+			  virtserconf->ports_map,
+			  get_ports_map_size(virtserial.config->max_nr_ports));
+
+	/* Hot-add ports */
+	for (i = virtserial.config->nr_active_ports;
+	     i < virtserconf->nr_active_ports; i++) {
+		port_nr = virtserial_get_hot_add_port(virtserconf);
+		if (port_nr == VIRTIO_SERIAL_BAD_ID)
+			continue;
+		ret = virtserial_add_port(port_nr);
+		if (!ret)
+			virtserial.config->nr_active_ports++;
+	}
+	kfree(virtserconf);
+}
+
+static int virtserial_probe(struct virtio_device *vdev)
+{
+	struct virtqueue *vqs[3];
+	const char *vq_names[] = { "input", "output" };
+	vq_callback_t *vq_callbacks[] = { rx_intr, tx_intr };
+	u32 i, map;
+	int ret, map_i;
+	u32 max_nr_ports;
+
+	vdev->config->get(vdev, offsetof(struct virtio_serial_config,
+					 max_nr_ports),
+			  &max_nr_ports,
+			  sizeof(max_nr_ports));
+	virtserial.config = kmalloc(sizeof(struct virtio_serial_config)
+				    + get_ports_map_size(max_nr_ports),
+				    GFP_KERNEL);
+	virtserial.config->max_nr_ports = max_nr_ports;
+
+	vdev->config->get(vdev, offsetof(struct virtio_serial_config,
+					 nr_active_ports),
+			  &virtserial.config->nr_active_ports,
+			  sizeof(virtserial.config->nr_active_ports));
+	vdev->config->get(vdev,
+			  offsetof(struct virtio_serial_config, ports_map),
+			  virtserial.config->ports_map,
+			  get_ports_map_size(max_nr_ports));
+
+	virtserial.vdev = vdev;
+
+	ret = vdev->config->find_vqs(vdev, 2, vqs, vq_callbacks, vq_names);
+	if (ret)
+		goto fail;
+
+	virtserial.in_vq = vqs[0];
+	virtserial.out_vq = vqs[1];
+
+	INIT_LIST_HEAD(&virtserial.port_head);
+
+	map_i = 0;
+	map = virtserial.config->ports_map[map_i];
+	for (i = 0; i < virtserial.config->nr_active_ports; i++) {
+		__u32 port_nr;
+
+		port_nr = virtserial_find_next_port(&map, &map_i);
+		if (unlikely(port_nr == VIRTIO_SERIAL_BAD_ID))
+			continue;
+
+		virtserial_add_port(port_nr);
+	}
+	INIT_WORK(&virtserial.rx_work, &virtio_serial_rx_work_handler);
+	INIT_WORK(&virtserial.tx_work, &virtio_serial_tx_work_handler);
+	INIT_WORK(&virtserial.queue_work, &virtio_serial_queue_work_handler);
+	INIT_WORK(&virtserial.config_work, &virtio_serial_config_work_handler);
+
+	/* Allocate pages to fill the receive queue */
+	schedule_work(&virtserial.queue_work);
+
+	return 0;
+fail:
+	return ret;
+}
+
+
+static void virtserial_remove_port_data(struct virtio_serial_port *port)
+{
+	struct list_head *ptr, *ptr2;
+
+	device_destroy(virtserial.class, port->dev->devt);
+	unregister_chrdev_region(port->dev->devt, 1);
+	cdev_del(&port->cdev);
+
+	/* Remove the buffers in which we have unconsumed data */
+	list_for_each_safe(ptr, ptr2, &port->readbuf_head) {
+		struct virtio_serial_port_buffer *buf;
+
+		buf = list_entry(ptr, struct virtio_serial_port_buffer, list);
+
+		list_del(&buf->list);
+		kfree(buf->buf);
+		kfree(buf);
+	}
+}
+
+static void virtserial_remove(struct virtio_device *vdev)
+{
+	struct list_head *ptr, *ptr2;
+	char *buf;
+	int len;
+
+	unregister_chrdev(major, "virtio-serial");
+	class_destroy(virtserial.class);
+
+	cancel_work_sync(&virtserial.rx_work);
+
+	/* Free up the unused buffers in the receive queue */
+	while ((buf = virtserial.in_vq->vq_ops->get_buf(virtserial.in_vq, &len)))
+		kfree(buf);
+
+	vdev->config->del_vqs(vdev);
+
+	list_for_each_safe(ptr, ptr2, &virtserial.port_head) {
+		struct virtio_serial_port *port;
+
+		port = list_entry(ptr, struct virtio_serial_port, next);
+
+		list_del(&port->next);
+		virtserial_remove_port_data(port);
+		kfree(port);
+	}
+	kfree(virtserial.config);
+}
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
+	.config_changed = config_intr,
+};
+
+static int __init init(void)
+{
+	int ret;
+
+	virtserial.class = class_create(THIS_MODULE, "virtio-serial");
+	if (IS_ERR(virtserial.class)) {
+		pr_err("Error creating virtio-serial class\n");
+		ret = PTR_ERR(virtserial.class);
+		return ret;
+	}
+	ret = register_virtio_driver(&virtio_serial);
+	if (ret) {
+		class_destroy(virtserial.class);
+		return ret;
+	}
+	return 0;
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
index 0000000..025dcf1
--- /dev/null
+++ b/include/linux/virtio_serial.h
@@ -0,0 +1,27 @@
+#ifndef _LINUX_VIRTIO_SERIAL_H
+#define _LINUX_VIRTIO_SERIAL_H
+#include <linux/types.h>
+#include <linux/virtio_config.h>
+
+/* Guest kernel - Host interface */
+
+/* The ID for virtio serial */
+#define VIRTIO_ID_SERIAL		7
+
+#define VIRTIO_SERIAL_BAD_ID		(~(u32)0)
+
+struct virtio_serial_config {
+	__u32 max_nr_ports;
+	__u32 nr_active_ports;
+	__u32 ports_map[0 /* (max_nr_ports + 31) / 32 */];
+};
+
+#ifdef __KERNEL__
+
+/* Guest kernel - Guest userspace interface */
+
+/* IOCTL-related */
+#define VIRTIO_SERIAL_IO 0xAF
+
+#endif /* __KERNEL__ */
+#endif /* _LINUX_VIRTIO_SERIAL_H */
-- 
1.6.2.5
