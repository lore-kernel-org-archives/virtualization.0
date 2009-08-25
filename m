From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH] virtio_console: Add interface for guest and host communication
Date: Tue, 25 Aug 2009 11:47:21 +0530
Message-ID: <1251181044-3696-2-git-send-email-amit.shah__11817.7996519536$1251181319$gmane$org@redhat.com>
References: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1251181044-3696-1-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
Cc: Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Expose multiple char devices ("ports") for simple communication
between the host userspace and guest.

Sample offline usages can be: poking around in a guest to find out
the file systems used, applications installed, etc. Online usages
can be sharing of clipboard data between the guest and the host,
sending information about logged-in users to the host, locking the
screen or session when a vnc session is closed, and so on.

The interface presented to guest userspace is of a simple char
device, so it can be used like this:

    fd = open("/dev/vcon2", O_RDWR);
    ret = read(fd, buf, 100);
    ret = write(fd, string, strlen(string));

Each port is to be assigned a unique function, for example, the
first 4 ports may be reserved for libvirt usage, the next 4 for
generic streaming data and so on. This port-function mapping
isn't finalised yet.

For requirements, use-cases and some history see

    http://www.linux-kvm.org/page/VMchannel_Requirements

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/Kconfig           |    4 +-
 drivers/char/virtio_console.c  |  871 +++++++++++++++++++++++++++++++++++-----
 include/linux/virtio_console.h |   27 ++
 3 files changed, 791 insertions(+), 111 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 6a06913..fe76627 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -678,7 +678,9 @@ config VIRTIO_CONSOLE
 	select HVC_DRIVER
 	help
 	  Virtio console for use with lguest and other hypervisors.
-
+	  Also serves as a general-purpose serial device for data transfer
+	  between the guest and host. Character devices at /dev/vconNN will
+	  be created when corresponding ports are found.
 
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c74dacf..3548bf6 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -13,6 +13,7 @@
  * Host can send more.  Buffering in the Host could alleviate this, but it is a
  * difficult problem in general. :*/
 /* Copyright (C) 2006, 2007 Rusty Russell, IBM Corporation
+ * Copyright (C) 2009, Amit Shah, Red Hat, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -28,100 +29,374 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+
+#include <linux/cdev.h>
+#include <linux/device.h>
 #include <linux/err.h>
+#include <linux/fs.h>
 #include <linux/init.h>
+#include <linux/poll.h>
 #include <linux/virtio.h>
 #include <linux/virtio_console.h>
+#include <linux/workqueue.h>
 #include "hvc_console.h"
 
-/*D:340 These represent our input and output console queues, and the virtio
+/*D:340 FIXME These represent our input and output console queues, and the virtio
  * operations for them. */
-static struct virtqueue *in_vq, *out_vq;
-static struct virtio_device *vdev;
+struct virtio_console_struct {
+	struct work_struct rx_work;
+	struct work_struct tx_work;
+	struct work_struct config_work;
+
+	struct list_head port_head;
+	struct list_head unused_read_head;
+
+	struct virtio_device *vdev;
+	struct class *class;
+	struct virtqueue *in_vq, *out_vq;
+
+	struct virtio_console_config *config;
+};
+
+/* This struct holds individual buffers received for each port */
+struct virtio_console_port_buffer {
+	struct list_head next;
 
-/* This is our input buffer, and how much data is left in it. */
-static unsigned int in_len;
-static char *in, *inbuf;
+	char *buf;
+
+	size_t len; /* length of the buffer */
+	size_t offset; /* offset in the buf from which to consume data */
+};
+
+struct virtio_console_port {
+	/* Next port in the list */
+	struct list_head next;
+
+	/* Buffer management */
+	struct virtio_console_port_buffer read_buf;
+	struct list_head readbuf_head;
+	wait_queue_head_t waitqueue;
+
+	/* Each port associates with a separate char device */
+	struct cdev cdev;
+	struct device *dev;
+
+	bool host_connected;  /* Is the host device open */
+};
+
+static struct virtio_console_struct virtconsole;
+
+static int major = 60; /* from the experimental range */
 
 /* The operations for our console. */
+/* FIXME: this should go into the per-port struct */
 static struct hv_ops virtio_cons;
 
 /* The hvc device */
 static struct hvc_struct *hvc;
 
-/*D:310 The put_chars() callback is pretty straightforward.
+static struct virtio_console_port *get_port_from_id(u32 id)
+{
+	struct virtio_console_port *port;
+
+	list_for_each_entry(port, &virtconsole.port_head, next) {
+		if (MINOR(port->dev->devt) == id)
+			return port;
+	}
+	return NULL;
+}
+
+static int get_id_from_port(struct virtio_console_port *port)
+{
+	return MINOR(port->dev->devt);
+}
+
+static inline bool use_multiport(void)
+{
+	return virtconsole.vdev->features[0] & (1 << VIRTIO_CONSOLE_F_MULTIPORT);
+}
+
+static ssize_t fill_readbuf(struct virtio_console_port *port,
+			    char *out_buf, size_t out_count, bool to_user)
+{
+	struct virtio_console_port_buffer *buf, *buf2;
+	ssize_t out_offset, ret;
+
+	out_offset = 0;
+	list_for_each_entry_safe(buf, buf2, &port->readbuf_head, next) {
+		size_t copy_size;
+
+		copy_size = out_count;
+		if (copy_size > buf->len - buf->offset)
+			copy_size = buf->len - buf->offset;
+
+		if (to_user) {
+			ret = copy_to_user(out_buf + out_offset,
+					   buf->buf + buf->offset,
+					   copy_size);
+			/* FIXME: Deal with ret != 0 */
+		} else {
+			memcpy(out_buf + out_offset,
+			       buf->buf + buf->offset,
+			       copy_size);
+			ret = 0; /* Emulate copy_to_user behaviour */
+		}
+
+		/* Return the number of bytes actually copied */
+		ret = copy_size - ret;
+		buf->offset += ret;
+		out_offset += ret;
+		out_count -= ret;
+
+		if (buf->len - buf->offset == 0) {
+			list_del(&buf->next);
+			kfree(buf->buf);
+			kfree(buf);
+		}
+		if (!out_count)
+			break;
+	}
+	return out_offset;
+}
+
+static ssize_t virtconsole_read(struct file *filp, char __user *ubuf,
+			       size_t count, loff_t *offp)
+{
+	struct virtio_console_port *port;
+	ssize_t ret;
+
+	port = filp->private_data;
+
+	ret = 0;
+	if (list_empty(&port->readbuf_head)) {
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible(port->waitqueue,
+					       !list_empty(&port->readbuf_head));
+	}
+	if (ret < 0)
+		return ret;
+
+	return fill_readbuf(port, ubuf, count, true);
+}
+
+/* For data that exceeds PAGE_SIZE in size we should send it all in
+ * one sg to not unnecessarily split up the data. Also some (all?)
+ * vnc clients don't consume split data.
  *
- * We turn the characters into a scatter-gather list, add it to the output
- * queue and then kick the Host.  Then we sit here waiting for it to finish:
- * inefficient in theory, but in practice implementations will do it
- * immediately (lguest's Launcher does). */
-static int put_chars(u32 vtermno, const char *buf, int count)
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
+static ssize_t send_buf(struct virtio_console_port *port,
+			const char *in_buf, size_t in_count,
+			bool from_user, bool internal)
 {
-	struct scatterlist sg[1];
-	unsigned int len;
-
-	/* This is a convenient routine to initialize a single-elem sg list */
-	sg_init_one(sg, buf, count);
-
-	/* add_buf wants a token to identify this buffer: we hand it any
-	 * non-NULL pointer, since there's only ever one buffer. */
-	if (out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, (void *)1) == 0) {
-		/* Tell Host to go! */
-		out_vq->vq_ops->kick(out_vq);
-		/* Chill out until it's done with the buffer. */
-		while (!out_vq->vq_ops->get_buf(out_vq, &len))
-			cpu_relax();
+	struct virtqueue *out_vq;
+	struct virtio_console_header header;
+	struct vbuf *vbuf;
+	size_t in_offset, copy_size;
+	ssize_t ret;
+	unsigned int i, header_len;
+
+	if (!in_count)
+		return 0;
+
+	out_vq = virtconsole.out_vq;
+
+	/* We can't send internal messages to a host that won't understand it */
+	if (!use_multiport() && internal) {
+		return 0;
+	}
+	header_len = 0;
+	if (use_multiport()) {
+		header.id = get_id_from_port(port);
+		header.internal_message = internal;
+		header_len = sizeof(header);
+	}
+	ret = -ENOMEM;
+	vbuf = kzalloc(sizeof(struct vbuf), GFP_KERNEL);
+	if (!vbuf)
+		return ret;
+
+	/* Max. number of buffers clubbed together in one message */
+	vbuf->nent = (in_count + header_len + PAGE_SIZE - 1) / PAGE_SIZE;
+
+	vbuf->bufs = kzalloc(sizeof(char *) * vbuf->nent, GFP_KERNEL);
+	if (!vbuf->bufs)
+		goto free_vbuf;
+
+	vbuf->sg = kzalloc(sizeof(struct scatterlist) * vbuf->nent, GFP_KERNEL);
+	if (!vbuf->sg)
+		goto free_bufs;
+	sg_init_table(vbuf->sg, vbuf->nent);
+
+	i = 0; /* vbuf->bufs[i] */
+	in_offset = 0; /* offset in the user buffer */
+	while (in_count - in_offset) {
+		copy_size = min(in_count - in_offset + header_len, PAGE_SIZE);
+		vbuf->bufs[i] = kzalloc(copy_size, GFP_KERNEL);
+		if (!vbuf->bufs[i]) {
+			ret = -ENOMEM;
+			if (!i)
+				goto free_sg;
+			goto free_buffers;
+		}
+		if (header_len) {
+			memcpy(vbuf->bufs[i], &header, header_len);
+			copy_size -= header_len;
+		}
+		if (from_user)
+			ret = copy_from_user(vbuf->bufs[i] + header_len,
+					     in_buf + in_offset, copy_size);
+		else {
+			/* Since we're not sure when the host will actually
+			 * consume the data and tell us about it, we have
+			 * to copy the data here in case the caller
+			 * frees the in_buf
+			 */
+			memcpy(vbuf->bufs[i] + header_len,
+			       in_buf + in_offset, copy_size);
+			ret = 0; /* Emulate copy_from_user */
+		}
+		in_offset += copy_size - ret;
+
+		sg_set_buf(&vbuf->sg[i], vbuf->bufs[i],
+			   copy_size - ret + header_len);
+		header_len = 0; /* Pass the header only in the first buffer */
+		i++;
+	}
+	if (out_vq->vq_ops->add_buf(out_vq, vbuf->sg, i, 0, vbuf)) {
+		ret = -EIO;
+		goto free_buffers;
 	}
+	/* Tell Host to go! */
+	out_vq->vq_ops->kick(out_vq);
+
+	/* We're expected to return the amount of data we wrote */
+	return in_offset;
+free_buffers:
+	while (--i >= 0)
+		kfree(vbuf->bufs[i]);
+free_sg:
+	kfree(vbuf->sg);
+free_bufs:
+	kfree(vbuf->bufs);
+free_vbuf:
+	kfree(vbuf);
+	return ret;
+}
+
+static ssize_t virtconsole_write(struct file *filp, const char __user *ubuf,
+				 size_t count, loff_t *offp)
+{
+	struct virtio_console_port *port;
 
-	/* We're expected to return the amount of data we wrote: all of it. */
-	return count;
+	port = filp->private_data;
+
+	return send_buf(port, ubuf, count, 1, 0);
 }
 
-/* Create a scatter-gather list representing our input buffer and put it in the
- * queue. */
-static void add_inbuf(void)
+static unsigned int virtconsole_poll(struct file *filp, poll_table *wait)
 {
-	struct scatterlist sg[1];
-	sg_init_one(sg, inbuf, PAGE_SIZE);
+	struct virtio_console_port *port;
+	unsigned int ret;
+
+	port = filp->private_data;
+	poll_wait(filp, &port->waitqueue, wait);
 
-	/* We should always be able to add one buffer to an empty queue. */
-	if (in_vq->vq_ops->add_buf(in_vq, sg, 0, 1, inbuf) != 0)
-		BUG();
-	in_vq->vq_ops->kick(in_vq);
+	ret = 0;
+	if (!list_empty(&port->readbuf_head))
+		ret |= POLLIN | POLLRDNORM;
+
+	return ret;
 }
 
-/*D:350 get_chars() is the callback from the hvc_console infrastructure when
- * an interrupt is received.
+static int virtconsole_release(struct inode *inode, struct file *filp)
+{
+	struct virtio_console_control cpkt;
+
+	/* Notify host of port being closed */
+	cpkt.event = VIRTIO_CONSOLE_PORT_OPEN;
+	cpkt.value = 0;
+	send_buf(filp->private_data, (char *)&cpkt, sizeof(cpkt), false, true);
+
+	return 0;
+}
+
+static int virtconsole_open(struct inode *inode, struct file *filp)
+{
+	struct cdev *cdev = inode->i_cdev;
+	struct virtio_console_port *port;
+	struct virtio_console_control cpkt;
+
+	port = container_of(cdev, struct virtio_console_port, cdev);
+	filp->private_data = port;
+
+	/* Notify host of port being opened */
+	cpkt.event = VIRTIO_CONSOLE_PORT_OPEN;
+	cpkt.value = 1;
+	send_buf(filp->private_data, (char *)&cpkt, sizeof(cpkt), false, true);
+
+	return 0;
+}
+
+static const struct file_operations virtconsole_fops = {
+	.owner = THIS_MODULE,
+	.open  = virtconsole_open,
+	.read  = virtconsole_read,
+	.write = virtconsole_write,
+	.poll  = virtconsole_poll,
+	.release = virtconsole_release,
+};
+
+/*D:310 The cons_put_chars() callback is pretty straightforward.
+ *
+ * We turn the characters into a scatter-gather list, add it to the output
+ * queue and then kick the Host.  Then we sit here waiting for it to finish:
+ * inefficient in theory, but in practice implementations will do it
+ * immediately (lguest's Launcher does). */
+static int cons_put_chars(u32 vtermno, const char *buf, int count)
+{
+	struct virtio_console_port *port;
+
+	port = get_port_from_id(vtermno);
+	if (!port)
+		return 0;
+
+	return send_buf(port, buf, count, false, false);
+}
+
+/*D:350 cons_get_chars() is the callback from the hvc_console
+ * infrastructure when an interrupt is received.
  *
  * Most of the code deals with the fact that the hvc_console() infrastructure
  * only asks us for 16 bytes at a time.  We keep in_offset and in_used fields
  * for partially-filled buffers. */
-static int get_chars(u32 vtermno, char *buf, int count)
+static int cons_get_chars(u32 vtermno, char *buf, int count)
 {
-	/* If we don't have an input queue yet, we can't get input. */
-	BUG_ON(!in_vq);
+	struct virtio_console_port *port;
 
-	/* No buffer?  Try to get one. */
-	if (!in_len) {
-		in = in_vq->vq_ops->get_buf(in_vq, &in_len);
-		if (!in)
-			return 0;
-	}
+	/* If we don't have an input queue yet, we can't get input. */
+	BUG_ON(!virtconsole.in_vq);
 
-	/* You want more than we have to give?  Well, try wanting less! */
-	if (in_len < count)
-		count = in_len;
+	port = get_port_from_id(vtermno);
+	if (!port)
+		return 0;
 
-	/* Copy across to their buffer and increment offset. */
-	memcpy(buf, in, count);
-	in += count;
-	in_len -= count;
+	if (list_empty(&port->readbuf_head))
+		return 0;
 
-	/* Finished?  Re-register buffer so Host will use it again. */
-	if (in_len == 0)
-		add_inbuf();
+	return fill_readbuf(port, buf, count, false);
 
-	return count;
 }
 /*:*/
 
@@ -160,23 +435,317 @@ static void virtcons_apply_config(struct virtio_device *dev)
  * we support only one console, the hvc struct is a global var
  * We set the configuration at this point, since we now have a tty
  */
-static int notifier_add_vio(struct hvc_struct *hp, int data)
+static int cons_notifier_add_vio(struct hvc_struct *hp, int data)
 {
 	hp->irq_requested = 1;
-	virtcons_apply_config(vdev);
+	virtcons_apply_config(virtconsole.vdev);
 
 	return 0;
 }
 
-static void notifier_del_vio(struct hvc_struct *hp, int data)
+static void cons_notifier_del_vio(struct hvc_struct *hp, int data)
 {
 	hp->irq_requested = 0;
 }
 
-static void hvc_handle_input(struct virtqueue *vq)
+static void fill_queue(struct virtqueue *vq, size_t buf_size,
+		       struct list_head *unused_head)
 {
-	if (hvc_poll(hvc))
+	struct scatterlist sg[1];
+	struct virtio_console_port_buffer *buf;
+
+	while (1) {
+		/* We have to keep track of the unused buffers
+		 * so that they can be freed when the module
+		 * is being removed
+		 */
+		buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+		if (!buf)
+			break;
+		buf->buf = kzalloc(buf_size, GFP_KERNEL);
+		if (!buf->buf) {
+			kfree(buf);
+			break;
+		}
+		sg_init_one(sg, buf->buf, buf_size);
+
+		if (vq->vq_ops->add_buf(vq, sg, 0, 1, buf->buf) < 0) {
+			kfree(buf->buf);
+			kfree(buf);
+			break;
+		}
+		list_add_tail(&buf->next, unused_head);
+	}
+	vq->vq_ops->kick(vq);
+}
+
+static void fill_receive_queue(void)
+{
+	fill_queue(virtconsole.in_vq, PAGE_SIZE, &virtconsole.unused_read_head);
+}
+
+static void handle_control_message(struct virtio_console_port *port,
+				   struct virtio_console_control *cpkt)
+{
+	switch (cpkt->event) {
+	case VIRTIO_CONSOLE_PORT_OPEN:
+		port->host_connected = cpkt->value;
+		break;
+	}
+}
+
+static void virtio_console_rx_work_handler(struct work_struct *work)
+{
+	struct virtio_console_port *port = NULL;
+	struct virtio_console_port_buffer *buf;
+	struct virtio_console_header header;
+	struct virtqueue *vq;
+	char *tmpbuf;
+	unsigned int tmplen, header_len;
+
+	header_len = use_multiport() ? sizeof(header) : 0;
+
+	vq = virtconsole.in_vq;
+	while ((tmpbuf = vq->vq_ops->get_buf(vq, &tmplen))) {
+		list_for_each_entry(buf, &virtconsole.unused_read_head, next) {
+			if (tmpbuf == buf->buf)
+				break;
+		}
+		BUG_ON(!buf);
+		/* The buffer is no longer unused */
+		list_del(&buf->next);
+
+		if (use_multiport()) {
+			memcpy(&header, buf->buf, header_len);
+			port = get_port_from_id(header.id);
+		} else
+			port = get_port_from_id(VIRTIO_CONSOLE_CONSOLE_PORT);
+		if (!port) {
+			/* No valid index at start of
+			 * buffer. Drop it.
+			 */
+			pr_debug("%s: invalid index in buffer, %c %d\n",
+				 __func__, buf->buf[0], buf->buf[0]);
+			kfree(buf->buf);
+			kfree(buf);
+			break;
+		}
+		if (use_multiport() && header.internal_message) {
+			handle_control_message(port,
+					       (struct virtio_console_control *)
+					       (tmpbuf + header_len));
+
+			/* FIXME: This buffer can be added to the
+			 * unused list to avoid free/alloc
+			 */
+			kfree(buf->buf);
+			kfree(buf);
+		} else {
+			buf->len = tmplen;
+			buf->offset = header_len;
+			list_add_tail(&buf->next, &port->readbuf_head);
+		}
+		wake_up_interruptible(&port->waitqueue);
+	}
+
+	if (get_id_from_port(port) == VIRTIO_CONSOLE_CONSOLE_PORT && hvc_poll(hvc))
 		hvc_kick();
+
+	/* Allocate buffers for all the ones that got used up */
+	fill_receive_queue();
+}
+
+static void virtio_console_tx_work_handler(struct work_struct *work)
+{
+	struct virtqueue *vq;
+	struct vbuf *vbuf;
+	unsigned int tmplen;
+	unsigned int i;
+
+	vq = virtconsole.out_vq;
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
+	schedule_work(&virtconsole.rx_work);
+}
+
+static void tx_intr(struct virtqueue *vq)
+{
+	schedule_work(&virtconsole.tx_work);
+}
+
+static void config_intr(struct virtio_device *vdev)
+{
+	/* Handle port hot-add */
+	schedule_work(&virtconsole.config_work);
+
+	/* Handle console size changes */
+	virtcons_apply_config(vdev);
+}
+
+static u32 virtconsole_get_hot_add_port(struct virtio_console_config *config)
+{
+	u32 i;
+	u32 port_nr;
+
+	for (i = 0; i < virtconsole.config->max_nr_ports / 32; i++) {
+		port_nr = ffs(config->ports_map[i] ^ virtconsole.config->ports_map[i]);
+		if (port_nr)
+			break;
+	}
+	if (unlikely(!port_nr))
+		return VIRTIO_CONSOLE_BAD_ID;
+
+	/* We used ffs above */
+	port_nr--;
+
+	/* FIXME: Do this only when add_port is successful */
+	virtconsole.config->ports_map[i] |= 1U << port_nr;
+
+	port_nr += i * 32;
+	return port_nr;
+}
+
+static u32 virtconsole_find_next_port(u32 *map, int *map_i)
+{
+	u32 port_nr;
+
+	while (1) {
+		port_nr = ffs(*map);
+		if (port_nr)
+			break;
+
+		if (unlikely(*map_i >= virtconsole.config->max_nr_ports / 32))
+			return VIRTIO_CONSOLE_BAD_ID;
+		++*map_i;
+		*map = virtconsole.config->ports_map[*map_i];
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
+static int virtconsole_add_port(u32 port_nr)
+{
+	struct virtio_console_port *port;
+	dev_t devt;
+	int ret;
+
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	devt = MKDEV(major, port_nr);
+	cdev_init(&port->cdev, &virtconsole_fops);
+
+	ret = register_chrdev_region(devt, 1, "virtio-console");
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
+	port->dev = device_create(virtconsole.class, NULL, devt, NULL,
+				  "vcon%u", port_nr);
+	if (IS_ERR(port->dev)) {
+		ret = PTR_ERR(port->dev);
+		pr_err("%s: Error creating device, ret = %d\n", __func__, ret);
+		goto free_cdev;
+	}
+	INIT_LIST_HEAD(&port->readbuf_head);
+	init_waitqueue_head(&port->waitqueue);
+
+	list_add_tail(&port->next, &virtconsole.port_head);
+
+	if (port_nr == VIRTIO_CONSOLE_CONSOLE_PORT) {
+		/* Start using the new console output. */
+		virtio_cons.get_chars = cons_get_chars;
+		virtio_cons.put_chars = cons_put_chars;
+		virtio_cons.notifier_add = cons_notifier_add_vio;
+		virtio_cons.notifier_del = cons_notifier_del_vio;
+		virtio_cons.notifier_hangup = cons_notifier_del_vio;
+
+		/* The first argument of hvc_alloc() is the virtual
+		 * console number, so we use zero.  The second
+		 * argument is the parameter for the notification
+		 * mechanism (like irq number). We currently leave
+		 * this as zero, virtqueues have implicit
+		 * notifications.
+		 *
+		 * The third argument is a "struct hv_ops" containing
+		 * the put_chars() get_chars(), notifier_add() and
+		 * notifier_del() pointers.  The final argument is the
+		 * output buffer size: we can do any size, so we put
+		 * PAGE_SIZE here. */
+		hvc = hvc_alloc(0, 0, &virtio_cons, PAGE_SIZE);
+		if (IS_ERR(hvc)) {
+			ret = PTR_ERR(hvc);
+			goto free_cdev;
+		}
+	}
+	pr_info("virtio-console port found at id %u\n", port_nr);
+
+	return 0;
+free_cdev:
+	unregister_chrdev(major, "virtio-console");
+	return ret;
+}
+
+static u32 get_ports_map_size(u32 max_ports)
+{
+	return sizeof(u32) * ((max_ports + 31) / 32);
+}
+
+static void virtio_console_config_work_handler(struct work_struct *work)
+{
+	struct virtio_console_config *virtconconf;
+	struct virtio_device *vdev = virtconsole.vdev;
+	u32 i, port_nr;
+	int ret;
+
+	virtconconf = kzalloc(sizeof(*virtconconf) +
+			      get_ports_map_size(virtconsole.config->max_nr_ports),
+			      GFP_KERNEL);
+	vdev->config->get(vdev,
+			  offsetof(struct virtio_console_config, nr_active_ports),
+			  &virtconconf->nr_active_ports,
+			  sizeof(virtconconf->nr_active_ports));
+	vdev->config->get(vdev,
+			  offsetof(struct virtio_console_config, ports_map),
+			  virtconconf->ports_map,
+			  get_ports_map_size(virtconsole.config->max_nr_ports));
+
+	/* Hot-add ports */
+	for (i = virtconsole.config->nr_active_ports;
+	     i < virtconconf->nr_active_ports; i++) {
+		port_nr = virtconsole_get_hot_add_port(virtconconf);
+		if (port_nr == VIRTIO_CONSOLE_BAD_ID)
+			continue;
+		ret = virtconsole_add_port(port_nr);
+		if (!ret)
+			virtconsole.config->nr_active_ports++;
+	}
+	kfree(virtconconf);
 }
 
 /*D:370 Once we're further in boot, we get probed like any other virtio device.
@@ -186,64 +755,132 @@ static void hvc_handle_input(struct virtqueue *vq)
  * never remove the console device we never need this pointer again.
  *
  * Finally we put our input buffer in the input queue, ready to receive. */
-static int __devinit virtcons_probe(struct virtio_device *dev)
+static int __devinit virtcons_probe(struct virtio_device *vdev)
 {
-	vq_callback_t *callbacks[] = { hvc_handle_input, NULL};
+	vq_callback_t *callbacks[] = { rx_intr, tx_intr };
 	const char *names[] = { "input", "output" };
 	struct virtqueue *vqs[2];
-	int err;
-
-	vdev = dev;
-
-	/* This is the scratch page we use to receive console input */
-	inbuf = kmalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!inbuf) {
-		err = -ENOMEM;
-		goto fail;
+	u32 i, map;
+	int ret, map_i;
+	u32 max_nr_ports;
+	bool multiport;
+
+	virtconsole.vdev = vdev;
+
+	multiport = false;
+	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
+		multiport = true;
+		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_MULTIPORT;
+		vdev->config->finalize_features(vdev);
+
+		vdev->config->get(vdev,
+				  offsetof(struct virtio_console_config,
+					   max_nr_ports),
+				  &max_nr_ports,
+				  sizeof(max_nr_ports));
+		virtconsole.config = kzalloc(sizeof(struct virtio_console_config)
+					     + get_ports_map_size(max_nr_ports),
+					     GFP_KERNEL);
+		if (!virtconsole.config)
+			return -ENOMEM;
+		virtconsole.config->max_nr_ports = max_nr_ports;
+
+		vdev->config->get(vdev, offsetof(struct virtio_console_config,
+						 nr_active_ports),
+				  &virtconsole.config->nr_active_ports,
+				  sizeof(virtconsole.config->nr_active_ports));
+		vdev->config->get(vdev,
+				  offsetof(struct virtio_console_config,
+					   ports_map),
+				  virtconsole.config->ports_map,
+				  get_ports_map_size(max_nr_ports));
 	}
 
 	/* Find the queues. */
 	/* FIXME: This is why we want to wean off hvc: we do nothing
 	 * when input comes in. */
-	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
-	if (err)
-		goto free;
+	ret = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
+	if (ret)
+		goto fail;
 
-	in_vq = vqs[0];
-	out_vq = vqs[1];
+	virtconsole.in_vq = vqs[0];
+	virtconsole.out_vq = vqs[1];
 
-	/* Start using the new console output. */
-	virtio_cons.get_chars = get_chars;
-	virtio_cons.put_chars = put_chars;
-	virtio_cons.notifier_add = notifier_add_vio;
-	virtio_cons.notifier_del = notifier_del_vio;
-	virtio_cons.notifier_hangup = notifier_del_vio;
-
-	/* The first argument of hvc_alloc() is the virtual console number, so
-	 * we use zero.  The second argument is the parameter for the
-	 * notification mechanism (like irq number). We currently leave this
-	 * as zero, virtqueues have implicit notifications.
-	 *
-	 * The third argument is a "struct hv_ops" containing the put_chars()
-	 * get_chars(), notifier_add() and notifier_del() pointers.
-	 * The final argument is the output buffer size: we can do any size,
-	 * so we put PAGE_SIZE here. */
-	hvc = hvc_alloc(0, 0, &virtio_cons, PAGE_SIZE);
-	if (IS_ERR(hvc)) {
-		err = PTR_ERR(hvc);
-		goto free_vqs;
-	}
+	INIT_LIST_HEAD(&virtconsole.port_head);
+	INIT_LIST_HEAD(&virtconsole.unused_read_head);
+
+	if (multiport) {
+		map_i = 0;
+		map = virtconsole.config->ports_map[map_i];
+		for (i = 0; i < virtconsole.config->nr_active_ports; i++) {
+			u32 port_nr;
+
+			port_nr = virtconsole_find_next_port(&map, &map_i);
+			if (unlikely(port_nr == VIRTIO_CONSOLE_BAD_ID))
+				continue;
+			virtconsole_add_port(port_nr);
+		}
+	} else
+		virtconsole_add_port(VIRTIO_CONSOLE_CONSOLE_PORT);
+
+	INIT_WORK(&virtconsole.rx_work, &virtio_console_rx_work_handler);
+	INIT_WORK(&virtconsole.tx_work, &virtio_console_tx_work_handler);
+	INIT_WORK(&virtconsole.config_work, &virtio_console_config_work_handler);
 
-	/* Register the input buffer the first time. */
-	add_inbuf();
+	fill_receive_queue();
 	return 0;
 
-free_vqs:
-	vdev->config->del_vqs(vdev);
-free:
-	kfree(inbuf);
 fail:
-	return err;
+	return ret;
+}
+
+static void virtconsole_remove_port_data(struct virtio_console_port *port)
+{
+	struct virtio_console_port_buffer *buf, *buf2;
+
+	device_destroy(virtconsole.class, port->dev->devt);
+	unregister_chrdev_region(port->dev->devt, 1);
+	cdev_del(&port->cdev);
+
+	/* Remove the buffers in which we have unconsumed data */
+	list_for_each_entry_safe(buf, buf2, &port->readbuf_head, next) {
+		list_del(&buf->next);
+		kfree(buf->buf);
+		kfree(buf);
+	}
+}
+
+static void virtconsole_remove(struct virtio_device *vdev)
+{
+	struct virtio_console_port *port, *port2;
+	struct virtio_console_port_buffer *buf, *buf2;
+	char *tmpbuf;
+	int len;
+
+	unregister_chrdev(major, "virtio-console");
+	class_destroy(virtconsole.class);
+
+	cancel_work_sync(&virtconsole.rx_work);
+
+	/* Free up the buffers in the 'received' queue */
+	while ((tmpbuf = virtconsole.in_vq->vq_ops->get_buf(virtconsole.in_vq,
+							    &len)))
+		kfree(tmpbuf);
+
+	vdev->config->del_vqs(vdev);
+
+	/* Free up the buffers that were unused */
+	list_for_each_entry_safe(buf, buf2, &virtconsole.unused_read_head, next) {
+		list_del(&buf->next);
+		kfree(buf->buf);
+		kfree(buf);
+	}
+	list_for_each_entry_safe(port, port2, &virtconsole.port_head, next) {
+		list_del(&port->next);
+		virtconsole_remove_port_data(port);
+		kfree(port);
+	}
+	kfree(virtconsole.config);
 }
 
 static struct virtio_device_id id_table[] = {
@@ -253,6 +890,7 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTIO_CONSOLE_F_SIZE,
+	VIRTIO_CONSOLE_F_MULTIPORT,
 };
 
 static struct virtio_driver virtio_console = {
@@ -262,12 +900,25 @@ static struct virtio_driver virtio_console = {
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
 	.probe =	virtcons_probe,
-	.config_changed = virtcons_apply_config,
+	.config_changed = config_intr,
 };
 
 static int __init init(void)
 {
-	return register_virtio_driver(&virtio_console);
+	int ret;
+
+	virtconsole.class = class_create(THIS_MODULE, "virtio-console");
+	if (IS_ERR(virtconsole.class)) {
+		pr_err("Error creating virtio-console class\n");
+		ret = PTR_ERR(virtconsole.class);
+		return ret;
+	}
+	ret = register_virtio_driver(&virtio_console);
+	if (ret) {
+		class_destroy(virtconsole.class);
+		return ret;
+	}
+	return 0;
 }
 module_init(init);
 
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index dc16111..2197e37 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -10,14 +10,41 @@
 
 /* Feature bits */
 #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
+#define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
+
+#define VIRTIO_CONSOLE_BAD_ID	(~(u32)0) /* Invalid port number */
+
+/* Port at which the virtio console is spawned */
+#define VIRTIO_CONSOLE_CONSOLE_PORT	0
 
 struct virtio_console_config {
 	/* colums of the screens */
 	__u16 cols;
 	/* rows of the screens */
 	__u16 rows;
+	/* max. number of ports supported for each PCI device */
+	__u32 max_nr_ports;
+	/* number of ports in use */
+	__u32 nr_active_ports;
+	/* locations of the ports in use */
+	__u32 ports_map[0 /* (max_nr_ports + 31) / 32 */];
+} __attribute__((packed));
+
+struct virtio_console_control {
+	__u16 event;
+	__u16 value;
+};
+
+/* This struct is put in each buffer that gets passed to userspace and
+ * vice-versa
+ */
+struct virtio_console_header {
+	u32  id; /* Port number */
+	bool internal_message; /* Some message between host and guest */
 } __attribute__((packed));
 
+/* Some events for internal messages */
+#define VIRTIO_CONSOLE_PORT_OPEN	0
 
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
-- 
1.6.2.5
