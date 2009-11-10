From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 08/15] virtio_console: Add support for multiple ports: console
	as well as generic
Date: Tue, 10 Nov 2009 15:11:34 +0530
Message-ID: <1257846101-23258-9-git-send-email-amit.shah@redhat.com>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-2-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-3-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-4-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-5-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-6-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-7-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-8-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-8-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: Amit Shah <amit.shah@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Add a bit more spice by adding support for multiple console ports.
This introduces a new feature: VIRTIO_CONSOLE_F_MULTIPORT. If a
willing host is found, this support is switched on and a small
'header' is transmitted along with every data packet that's sent
in either direction.

This header stores the port number the data is meant for, along
with a few other fields which will be used for other features
to support generic ports.

The interface is of a simple char device with open, read, write,
poll and close calls, eg:

fd = open("/dev/vcon2", O_RDWR);
ret = read(fd, buf, 100);
ret = write(fd, string, strlen(string));

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |  730 ++++++++++++++++++++++++++++++++++------
 include/linux/virtio_console.h |   44 +++-
 2 files changed, 675 insertions(+), 99 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e97188e..4119c37 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -10,6 +10,7 @@
  :*/
 
 /* Copyright (C) 2006, 2007 Rusty Russell, IBM Corporation
+ * Copyright (C) 2009, Amit Shah, Red Hat, Inc.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -25,12 +26,20 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+
+#include <linux/cdev.h>
+#include <linux/device.h>
 #include <linux/err.h>
+#include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/list.h>
+#include <linux/poll.h>
+#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <linux/virtio.h>
 #include <linux/virtio_console.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
 #include "hvc_console.h"
 
 struct virtio_console_struct {
@@ -41,20 +50,15 @@ struct virtio_console_struct {
 	struct work_struct rx_work;
 	struct work_struct tx_work;
 
-	/* Buffer management */
+	struct list_head port_head;
 	struct list_head unused_read_head;
 	struct list_head unused_write_head;
-	struct list_head readbuf_head;
 
 	/* To protect the list of unused write buffers and the out_vq */
 	spinlock_t write_list_lock;
 
-	/*
-	 * To protect the readbuf_head list. Has to be a spinlock
-	 * because it can be called from interrupt context
-	 * (get_char())
-	 */
-	spinlock_t readbuf_list_lock;
+	/* The current config space is stored here */
+	struct virtio_console_config config;
 
 	/*D:340
 	 * These represent our input and output console queues,
@@ -63,11 +67,22 @@ struct virtio_console_struct {
 	struct virtqueue *in_vq, *out_vq;
 	struct virtio_device *vdev;
 
-	/* The hvc device */
-	struct hvc_struct *hvc;
+	struct class *class;
+
+	/*
+	 * This is used to keep track of the number of hvc consoles
+	 * spawned.  This number is given as first argument to
+	 * hvc_alloc().  To correctly map an initial console spawned
+	 * via hvc_instantiate to the console being hooked up via
+	 * hvc_alloc, we need to pass the same vtermno.
+	 *
+	 * We also just assume the first console being initialised was
+	 * the first one that got used as the initial console.
+	 */
+	unsigned int hvc_vtermno;
 };
 
-/* This struct holds individual buffers received from the host */
+/* This struct holds individual buffers received for each port */
 struct virtio_console_port_buffer {
 	struct list_head list;
 
@@ -79,76 +94,206 @@ struct virtio_console_port_buffer {
 	size_t offset;
 };
 
+/* This struct holds the per-port data */
+struct virtio_console_port {
+	/* Next port in the list, head is in the virtio_console_struct */
+	struct list_head list;
+
+	/* Pointer to the virtio_console device */
+	struct virtio_console_struct *vcon;
+
+	/* Buffer management */
+	struct list_head readbuf_head;
+
+	/*
+	 * To protect the readbuf_head list. Has to be a spinlock
+	 * because it can be called from interrupt context
+	 * (get_char())
+	 */
+	spinlock_t readbuf_list_lock;
+
+	/* A waitqueue for poll() or blocking read operations */
+	wait_queue_head_t waitqueue;
+
+	/* Each port associates with a separate char device */
+	struct cdev cdev;
+	struct device *dev;
+
+	/* The hvc device, if this port is associated with a console */
+	struct hvc_struct *hvc;
+
+	/* The 'name' of the port that we expose via sysfs properties */
+	char *name;
+
+	/* The 'id' to identify the port with the Host */
+	u32 id;
+
+	/*
+	 * If this port is a console port, this number identifies the
+	 * number that we used to register with hvc in
+	 * hvc_instantiate() and hvc_alloc().
+	 */
+	u32 vtermno;
+
+	/* Is the host device open */
+	bool host_connected;
+};
+
 struct virtio_console_struct virtconsole;
 
-/*D:310
- * The put_chars() callback is pretty straightforward.
- *
- * We turn the characters into a scatter-gather list, add it to the output
- * queue and then kick the Host.
- *
- * If the data to be output spans more than a page, it's split into
- * page-sized buffers and then individual buffers are pushed to the Host.
- */
-static int put_chars(u32 vtermno, const char *in_buf, int in_count)
+static struct virtio_console_port *get_port_from_vtermno(u32 vtermno)
+{
+	struct virtio_console_port *port;
+
+	list_for_each_entry(port, &virtconsole.port_head, list) {
+		if (port->hvc && port->vtermno == vtermno)
+			return port;
+	}
+	return NULL;
+}
+
+static struct virtio_console_port *get_port_from_id(u32 id)
+{
+	struct virtio_console_port *port;
+
+	list_for_each_entry(port, &virtconsole.port_head, list) {
+		if (port->id == id)
+			return port;
+	}
+	return NULL;
+}
+
+static struct virtio_console_port *get_port_from_hvc(struct hvc_struct *hvc)
+{
+	struct virtio_console_port *port;
+
+	list_for_each_entry(port, &virtconsole.port_head, list) {
+		if (port->hvc == hvc)
+			return port;
+	}
+	return NULL;
+}
+
+static int get_id_from_port(struct virtio_console_port *port)
+{
+	return port->id;
+}
+
+static bool is_console_port(struct virtio_console_port *port)
+{
+	if (port->hvc)
+		return true;
+	return false;
+}
+
+static inline bool use_multiport(struct virtio_console_struct *vcon)
+{
+	/*
+	 * This condition can be true when put_chars is called from
+	 * early_init
+	 */
+	if (!vcon->vdev)
+		return 0;
+	return vcon->vdev->features[0] & (1 << VIRTIO_CONSOLE_F_MULTIPORT);
+}
+
+static inline bool is_control(u32 flags)
+{
+	return flags & VIRTIO_CONSOLE_ID_CONTROL;
+}
+
+static ssize_t send_buf(struct virtio_console_port *port,
+			const char *in_buf, size_t in_count,
+			u32 flags, bool from_user)
 {
 	struct virtqueue *out_vq;
 	struct virtio_console_port_buffer *buf, *buf2;
 	struct scatterlist sg[1];
+	struct virtio_console_header header;
 	size_t in_offset, copy_size;
 	ssize_t ret;
+	unsigned int header_len;
 
 	if (!in_count)
 		return 0;
 
-	out_vq = virtconsole.out_vq;
-
+	out_vq = port->vcon->out_vq;
+	/*
+	 * We should not send control messages to a host that won't
+	 * understand them
+	 */
+	if (!use_multiport(port->vcon) && is_control(flags))
+		return 0;
+	header_len = 0;
+	if (use_multiport(port->vcon)) {
+		header.id = get_id_from_port(port);
+		header.flags = flags;
+		header.size = in_count;
+		header_len = sizeof(header);
+	}
 	in_offset = 0; /* offset in the user buffer */
 	while (in_count - in_offset) {
-		copy_size = min(in_count - in_offset, PAGE_SIZE);
+		copy_size = min(in_count - in_offset + header_len, PAGE_SIZE);
 
-		spin_lock(&virtconsole.write_list_lock);
+		spin_lock(&port->vcon->write_list_lock);
 		list_for_each_entry_safe(buf, buf2,
-					 &virtconsole.unused_write_head,
+					 &port->vcon->unused_write_head,
 					 list) {
 			list_del(&buf->list);
 			break;
 		}
-		spin_unlock(&virtconsole.write_list_lock);
+		spin_unlock(&port->vcon->write_list_lock);
 		if (!buf)
 			break;
-		/*
-		 * Since we're not sure when the host will actually
-		 * consume the data and tell us about it, we have
-		 * to copy the data here in case the caller
-		 * frees the in_buf
-		 */
-		memcpy(buf->buf, in_buf + in_offset, copy_size);
-
-		buf->len = copy_size;
+		if (header_len) {
+			memcpy(buf->buf, &header, header_len);
+			copy_size -= header_len;
+		}
+		if (from_user) {
+			ret = copy_from_user(buf->buf + header_len,
+					     in_buf + in_offset, copy_size);
+		} else {
+			/*
+			 * Since we're not sure when the host will actually
+			 * consume the data and tell us about it, we have
+			 * to copy the data here in case the caller
+			 * frees the in_buf
+			 */
+			memcpy(buf->buf + header_len,
+			       in_buf + in_offset, copy_size);
+			ret = 0; /* Emulate copy_from_user behaviour */
+		}
+		buf->len = header_len + copy_size - ret;
 		sg_init_one(sg, buf->buf, buf->len);
 
-		spin_lock(&virtconsole.write_list_lock);
+		spin_lock(&port->vcon->write_list_lock);
 		ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, buf);
-		spin_unlock(&virtconsole.write_list_lock);
+		spin_unlock(&port->vcon->write_list_lock);
 		if (ret < 0) {
 			memset(buf->buf, 0, buf->len);
-			spin_lock(&virtconsole.write_list_lock);
+			spin_lock(&port->vcon->write_list_lock);
 			list_add_tail(&buf->list,
-				      &virtconsole.unused_write_head);
-			spin_unlock(&virtconsole.write_list_lock);
+				      &port->vcon->unused_write_head);
+			spin_unlock(&port->vcon->write_list_lock);
 			break;
 		}
-		in_offset += buf->len;
+		in_offset += buf->len - header_len;
+		/*
+		 * Only send size with the first buffer.  This way
+		 * userspace can find out a continuous stream of data
+		 * belonging to one write request and consume it
+		 * appropriately
+		 */
+		header.size = 0;
 
 		/* No space left in the vq anyway */
 		if (!ret)
 			break;
 	}
 	/* Tell Host to go! */
-	spin_lock(&virtconsole.write_list_lock);
+	spin_lock(&port->vcon->write_list_lock);
 	out_vq->vq_ops->kick(out_vq);
-	spin_unlock(&virtconsole.write_list_lock);
+	spin_unlock(&port->vcon->write_list_lock);
 
 	/* We're expected to return the amount of data we wrote */
 	return in_offset;
@@ -158,7 +303,8 @@ static int put_chars(u32 vtermno, const char *in_buf, int in_count)
  * Give out the data that's requested from the buffers that we have
  * queued up.
  */
-static ssize_t fill_readbuf(char *out_buf, size_t out_count)
+static ssize_t fill_readbuf(struct virtio_console_port *port,
+			    char *out_buf, size_t out_count, bool to_user)
 {
 	struct virtio_console_port_buffer *buf, *buf2;
 	ssize_t out_offset, ret;
@@ -168,26 +314,38 @@ static ssize_t fill_readbuf(char *out_buf, size_t out_count)
 	 * Not taking the port->readbuf_list_lock here relying on the
 	 * fact that buffers are taken out from the list only in this
 	 * function so buf2 should be available all the time.
+	 *
+	 * Also, copy_to_user() might sleep.
 	 */
-	list_for_each_entry_safe(buf, buf2, &virtconsole.readbuf_head, list) {
+	list_for_each_entry_safe(buf, buf2, &port->readbuf_head, list) {
 		size_t copy_size;
 
 		copy_size = out_count;
 		if (copy_size > buf->len - buf->offset)
 			copy_size = buf->len - buf->offset;
 
-		memcpy(out_buf + out_offset, buf->buf + buf->offset, copy_size);
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
 
 		/* Return the number of bytes actually copied */
-		ret = copy_size;
+		ret = copy_size - ret;
 		buf->offset += ret;
 		out_offset += ret;
 		out_count -= ret;
 
 		if (buf->len - buf->offset == 0) {
-			spin_lock(&virtconsole.readbuf_list_lock);
+			spin_lock(&port->readbuf_list_lock);
 			list_del(&buf->list);
-			spin_unlock(&virtconsole.readbuf_list_lock);
+			spin_unlock(&port->readbuf_list_lock);
 			kfree(buf->buf);
 			kfree(buf);
 		}
@@ -197,6 +355,156 @@ static ssize_t fill_readbuf(char *out_buf, size_t out_count)
 	return out_offset;
 }
 
+/* The condition that must be true for polling to end */
+static bool wait_is_over(struct virtio_console_port *port)
+{
+	return !list_empty(&port->readbuf_head) || !port->host_connected;
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
+	if (list_empty(&port->readbuf_head)) {
+		/*
+		 * If nothing's connected on the host just return 0 in
+		 * case of list_empty; this tells the userspace app
+		 * that there's no connection
+		 */
+		if (!port->host_connected)
+			return 0;
+		if (filp->f_flags & O_NONBLOCK)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible(port->waitqueue,
+					       wait_is_over(port));
+		if (ret < 0)
+			return ret;
+	}
+	/*
+	 * We could've received a disconnection message while we were
+	 * waiting for more data.
+	 *
+	 * This check is not clubbed in the if() statement above as we
+	 * might receive some data as well as the host could get
+	 * disconnected after we got woken up from our wait. So we
+	 * really want to give off whatever data we have and only then
+	 * check for host_connected
+	 */
+	if (list_empty(&port->readbuf_head) && !port->host_connected)
+		return 0;
+
+	return fill_readbuf(port, ubuf, count, true);
+}
+
+static ssize_t virtconsole_write(struct file *filp, const char __user *ubuf,
+				 size_t count, loff_t *offp)
+{
+	struct virtio_console_port *port;
+
+	port = filp->private_data;
+
+	return send_buf(port, ubuf, count, 0, true);
+}
+
+static unsigned int virtconsole_poll(struct file *filp, poll_table *wait)
+{
+	struct virtio_console_port *port;
+	unsigned int ret;
+
+	port = filp->private_data;
+	poll_wait(filp, &port->waitqueue, wait);
+
+	ret = 0;
+	if (!list_empty(&port->readbuf_head))
+		ret |= POLLIN | POLLRDNORM;
+	if (port->host_connected)
+		ret |= POLLOUT;
+	if (!port->host_connected)
+		ret |= POLLHUP;
+
+	return ret;
+}
+
+static int virtconsole_release(struct inode *inode, struct file *filp)
+{
+	struct virtio_console_port *port;
+	struct virtio_console_control cpkt;
+
+	port = filp->private_data;
+
+	/* Notify host of port being closed */
+	cpkt.event = VIRTIO_CONSOLE_PORT_OPEN;
+	cpkt.value = 0;
+	send_buf(filp->private_data, (char *)&cpkt, sizeof(cpkt),
+		 VIRTIO_CONSOLE_ID_CONTROL, false);
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
+	/*
+	 * Don't allow opening of console port devices -- that's done
+	 * via /dev/hvc
+	 */
+	if (port->hvc)
+		return -ENXIO;
+
+	/* Notify host of port being opened */
+	cpkt.event = VIRTIO_CONSOLE_PORT_OPEN;
+	cpkt.value = 1;
+	send_buf(filp->private_data, (char *)&cpkt, sizeof(cpkt),
+		 VIRTIO_CONSOLE_ID_CONTROL, false);
+
+	return 0;
+}
+
+/*
+ * The file operations that we support: programs in the guest can open
+ * a console device, read from it, write to it, poll for data and
+ * close it. The devices are at /dev/vconNN
+ */
+static const struct file_operations virtconsole_fops = {
+	.owner = THIS_MODULE,
+	.open  = virtconsole_open,
+	.read  = virtconsole_read,
+	.write = virtconsole_write,
+	.poll  = virtconsole_poll,
+	.release = virtconsole_release,
+};
+
+/*D:310
+ * The put_chars() callback is pretty straightforward.
+ *
+ * We turn the characters into a scatter-gather list, add it to the output
+ * queue and then kick the Host.
+ *
+ * If the data to be output spans more than a page, it's split into
+ * page-sized buffers and then individual buffers are pushed to the Host.
+ */
+static int put_chars(u32 vtermno, const char *buf, int count)
+{
+	struct virtio_console_port *port;
+
+	port = get_port_from_vtermno(vtermno);
+	if (!port)
+		return 0;
+
+	return send_buf(port, buf, count, 0, false);
+}
+
 /*D:350
  * get_chars() is the callback from the hvc_console infrastructure when
  * an interrupt is received.
@@ -206,13 +514,19 @@ static ssize_t fill_readbuf(char *out_buf, size_t out_count)
  */
 static int get_chars(u32 vtermno, char *buf, int count)
 {
+	struct virtio_console_port *port;
+
 	/* If we don't have an input queue yet, we can't get input. */
 	BUG_ON(!virtconsole.in_vq);
 
-	if (list_empty(&virtconsole.readbuf_head))
+	port = get_port_from_vtermno(vtermno);
+	if (!port)
 		return 0;
 
-	return fill_readbuf(buf, count);
+	if (list_empty(&port->readbuf_head))
+		return 0;
+
+	return fill_readbuf(port, buf, count, false);
 }
 /*:*/
 
@@ -220,29 +534,36 @@ static int get_chars(u32 vtermno, char *buf, int count)
  * virtio console configuration. This supports:
  * - console resize
  */
-static void virtcons_apply_config(struct virtio_device *dev)
+static void virtcons_apply_config(struct virtio_console_port *port)
 {
+	struct virtio_device *vdev;
 	struct winsize ws;
 
-	if (virtio_has_feature(dev, VIRTIO_CONSOLE_F_SIZE)) {
-		dev->config->get(dev,
-				 offsetof(struct virtio_console_config, cols),
-				 &ws.ws_col, sizeof(u16));
-		dev->config->get(dev,
-				 offsetof(struct virtio_console_config, rows),
-				 &ws.ws_row, sizeof(u16));
-		hvc_resize(virtconsole.hvc, ws);
+	vdev = port->vcon->vdev;
+	if (virtio_has_feature(port->vcon->vdev, VIRTIO_CONSOLE_F_SIZE)) {
+		vdev->config->get(vdev,
+				  offsetof(struct virtio_console_config, cols),
+				  &ws.ws_col, sizeof(u16));
+		vdev->config->get(vdev,
+				  offsetof(struct virtio_console_config, rows),
+				  &ws.ws_row, sizeof(u16));
+		hvc_resize(port->hvc, ws);
 	}
 }
 
 /*
- * we support only one console, the hvc struct is a global var
  * We set the configuration at this point, since we now have a tty
  */
 static int notifier_add_vio(struct hvc_struct *hp, int data)
 {
+	struct virtio_console_port *port;
+
+	port = get_port_from_hvc(hp);
+	if (!port)
+		return -EINVAL;
+
 	hp->irq_requested = 1;
-	virtcons_apply_config(virtconsole.vdev);
+	virtcons_apply_config(port);
 
 	return 0;
 }
@@ -276,6 +597,91 @@ int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int))
 	return hvc_instantiate(0, 0, &virtio_cons);
 }
 
+int init_port_console(struct virtio_console_port *port)
+{
+	int ret = 0;
+
+	/*
+	 * The Host's telling us this port is a console port.  Hook it
+	 * up with an hvc console.
+	 *
+	 * To set up and manage our virtual console, we call
+	 * hvc_alloc().
+	 *
+	 * The first argument of hvc_alloc() is the virtual console
+	 * number.  The second argument is the parameter for the
+	 * notification mechanism (like irq number).  We currently
+	 * leave this as zero, virtqueues have implicit notifications.
+	 *
+	 * The third argument is a "struct hv_ops" containing the
+	 * put_chars() get_chars(), notifier_add() and notifier_del()
+	 * pointers.  The final argument is the output buffer size: we
+	 * can do any size, so we put PAGE_SIZE here.
+	 */
+	port->hvc = hvc_alloc(port->vcon->hvc_vtermno, 0, &virtio_cons,
+			      PAGE_SIZE);
+	if (IS_ERR(port->hvc)) {
+		ret = PTR_ERR(port->hvc);
+		pr_err("%s: Could not alloc hvc for virtio console port, ret = %d\n",
+		       __func__, ret);
+		port->hvc = NULL;
+	} else {
+		port->vtermno = port->vcon->hvc_vtermno++;
+	}
+	return ret;
+}
+
+/* Any private messages that the Host and Guest want to share */
+static void handle_control_message(struct virtio_console_port *port,
+				   struct virtio_console_port_buffer *buf)
+{
+	struct virtio_console_control *cpkt;
+	size_t name_size;
+
+	cpkt = (struct virtio_console_control *)(buf->buf + buf->offset);
+
+	switch (cpkt->event) {
+	case VIRTIO_CONSOLE_PORT_OPEN:
+		port->host_connected = cpkt->value;
+		break;
+	case VIRTIO_CONSOLE_PORT_NAME:
+		/*
+		 * Skip the size of the header and the cpkt to get the size
+		 * of the name that was sent
+		 */
+		name_size = buf->len - buf->offset - sizeof(*cpkt) + 1;
+
+		port->name = kmalloc(name_size, GFP_KERNEL);
+		if (!port->name) {
+			pr_err("%s: not enough space to store port name\n",
+			       __func__);
+			break;
+		}
+		strncpy(port->name, buf->buf + buf->offset + sizeof(*cpkt),
+			name_size - 1);
+		port->name[name_size - 1] = 0;
+		break;
+	case VIRTIO_CONSOLE_CONSOLE_PORT:
+		if (!cpkt->value)
+			break;
+		if (is_console_port(port))
+			break;
+
+		init_port_console(port);
+		/*
+		 * Could remove the port here in case init fails - but
+		 * have to notify the host first
+		 */
+		break;
+	case VIRTIO_CONSOLE_RESIZE:
+		if (!is_console_port(port))
+			break;
+		port->hvc->irq_requested = 1;
+		virtcons_apply_config(port);
+		break;
+	}
+}
+
 static struct virtio_console_port_buffer *get_buf(size_t buf_size)
 {
 	struct virtio_console_port_buffer *buf;
@@ -343,30 +749,76 @@ static void alloc_write_bufs(struct virtio_console_struct *vcon)
 	}
 }
 
+/*
+ * The workhandler for any buffers that appear on our input queue.
+ * Pick the buffer; if it's some internal control communication meant
+ * for the us, just process it.  Otherwise queue it up for the read()
+ * or get_chars() routines to pick the data up later.
+ */
 static void virtio_console_rx_work_handler(struct work_struct *work)
 {
 	struct virtio_console_struct *vcon;
+	struct virtio_console_port *port;
 	struct virtio_console_port_buffer *buf;
+	struct virtio_console_header header;
 	struct virtqueue *vq;
-	unsigned int tmplen;
+	unsigned int tmplen, header_len;
 
 	vcon = container_of(work, struct virtio_console_struct, rx_work);
+	header_len = use_multiport(vcon) ? sizeof(header) : 0;
 
+	port = NULL;
 	vq = vcon->in_vq;
 	while ((buf = vq->vq_ops->get_buf(vq, &tmplen))) {
 		/* The buffer is no longer unused */
 		list_del(&buf->list);
 
+		if (use_multiport(vcon)) {
+			memcpy(&header, buf->buf, header_len);
+			port = get_port_from_id(header.id);
+		} else {
+			port = get_port_from_id(0);
+		}
+		if (!port) {
+			/* No valid header at start of buffer. Drop it. */
+			pr_debug("%s: invalid index in buffer, %c %d\n",
+				 __func__, buf->buf[0], buf->buf[0]);
+			/*
+			 * OPT: This buffer can be added to the unused
+			 * list to avoid free / alloc
+			 */
+			kfree(buf->buf);
+			kfree(buf);
+			break;
+		}
 		buf->len = tmplen;
-		buf->offset = 0;
+		buf->offset = header_len;
+		if (use_multiport(vcon) && is_control(header.flags)) {
+			handle_control_message(port, buf);
+			/*
+			 * OPT: This buffer can be added to the unused
+			 * list to avoid free/alloc
+			 */
+			kfree(buf->buf);
+			kfree(buf);
+		} else {
+			/*
+			 * We might have missed a connection
+			 * notification, e.g. before the queues were
+			 * initialised.
+			 */
+			port->host_connected = true;
+
+			spin_lock(&port->readbuf_list_lock);
+			list_add_tail(&buf->list, &port->readbuf_head);
+			spin_unlock(&port->readbuf_list_lock);
+		}
+		wake_up_interruptible(&port->waitqueue);
 
-		spin_lock(&virtconsole.readbuf_list_lock);
-		list_add_tail(&buf->list, &virtconsole.readbuf_head);
-		spin_unlock(&virtconsole.readbuf_list_lock);
+		if (is_console_port(port) && !list_empty(&port->readbuf_head))
+			if (hvc_poll(port->hvc))
+				hvc_kick();
 	}
-	if (hvc_poll(virtconsole.hvc))
-		hvc_kick();
-
 	/* Allocate buffers for all the ones that got used up */
 	fill_receive_queue(&virtconsole);
 }
@@ -417,23 +869,95 @@ static void tx_intr(struct virtqueue *vq)
 
 static void config_intr(struct virtio_device *vdev)
 {
-	/* Handle console size changes */
-	virtcons_apply_config(vdev);
+	/*
+	 * We'll use this way of resizing only for legacy support. For
+	 * newer userspace (VIRTIO_CONSOLE_F_MULTPORT+), use control
+	 * messages to indicate console size changes so that it can be
+	 * done per-port
+	 */
+	virtcons_apply_config(get_port_from_id(0));
+}
+
+static int virtconsole_add_port(u32 port_nr)
+{
+	struct virtio_console_port *port;
+	struct virtio_console_control cpkt;
+	dev_t devt;
+	int ret;
+
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
+
+	port->vcon = &virtconsole;
+	port->id = port_nr;
+
+	cdev_init(&port->cdev, &virtconsole_fops);
+
+	ret = alloc_chrdev_region(&devt, 0, 1, "virtio-console");
+	if (ret < 0) {
+		pr_err("%s: error allocing chrdev region, ret = %d\n",
+		       __func__, ret);
+		goto free_port;
+	}
+	ret = cdev_add(&port->cdev, devt, 1);
+	if (ret < 0) {
+		pr_err("%s: error adding cdev, ret = %d\n", __func__, ret);
+		goto free_chrdev;
+	}
+	port->dev = device_create(port->vcon->class, NULL, devt, NULL,
+				  "vcon%u", port_nr);
+	if (IS_ERR(port->dev)) {
+		ret = PTR_ERR(port->dev);
+		pr_err("%s: error creating device, ret = %d\n", __func__, ret);
+		goto free_cdev;
+	}
+	/*
+	 * If we're not using multiport support, this has to be a console port
+	 */
+	if (!use_multiport(&virtconsole)) {
+		ret = init_port_console(port);
+		if (ret)
+			goto free_cdev;
+	}
+
+	spin_lock_init(&port->readbuf_list_lock);
+	INIT_LIST_HEAD(&port->readbuf_head);
+	init_waitqueue_head(&port->waitqueue);
+
+	list_add_tail(&port->list, &port->vcon->port_head);
+
+	/* Ask for the port's name from Host. */
+	cpkt.event = VIRTIO_CONSOLE_PORT_NAME;
+	send_buf(port, (char *)&cpkt, sizeof(cpkt),
+		 VIRTIO_CONSOLE_ID_CONTROL, false);
+
+	return 0;
+free_cdev:
+	cdev_del(&port->cdev);
+free_chrdev:
+	unregister_chrdev_region(devt, 1);
+free_port:
+	kfree(port);
+	return ret;
 }
 
-/*D:370 Once we're further in boot, we get probed like any other virtio device.
+/*D:370
+ * Once we're further in boot, we get probed like any other virtio device.
  * At this stage we set up the output virtqueue.
  *
- * To set up and manage our virtual console, we call hvc_alloc().  Since we
- * never remove the console device we never need this pointer again.
- *
- * Finally we put our input buffer in the input queue, ready to receive. */
+ * If the host also supports multiple console ports, we check the
+ * config space to see how many ports the host has spawned. We
+ * initialize each port found.
+ */
 static int __devinit virtcons_probe(struct virtio_device *vdev)
 {
 	vq_callback_t *callbacks[] = { rx_intr, tx_intr };
 	const char *names[] = { "input", "output" };
 	struct virtqueue *vqs[2];
+	u32 i;
 	int err;
+	bool multiport;
 
 	if (virtconsole.vdev) {
 		pr_err("Multiple virtio-console devices not supported yet\n");
@@ -441,6 +965,17 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	}
 	virtconsole.vdev = vdev;
 
+	multiport = false;
+	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
+		multiport = true;
+		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_MULTIPORT;
+		vdev->config->finalize_features(vdev);
+
+		vdev->config->get(vdev, offsetof(struct virtio_console_config,
+						 nr_ports),
+				  &virtconsole.config.nr_ports,
+				  sizeof(virtconsole.config.nr_ports));
+	}
 	/* Find the queues. */
 	/* FIXME: This is why we want to wean off hvc: we do nothing
 	 * when input comes in. */
@@ -459,10 +994,9 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	 */
 	virtio_cons.put_chars = put_chars;
 
-	spin_lock_init(&virtconsole.readbuf_list_lock);
 	spin_lock_init(&virtconsole.write_list_lock);
 
-	INIT_LIST_HEAD(&virtconsole.readbuf_head);
+	INIT_LIST_HEAD(&virtconsole.port_head);
 	INIT_LIST_HEAD(&virtconsole.unused_read_head);
 	INIT_LIST_HEAD(&virtconsole.unused_write_head);
 
@@ -472,25 +1006,13 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	fill_receive_queue(&virtconsole);
 	alloc_write_bufs(&virtconsole);
 
-	/* The first argument of hvc_alloc() is the virtual console number, so
-	 * we use zero.  The second argument is the parameter for the
-	 * notification mechanism (like irq number). We currently leave this
-	 * as zero, virtqueues have implicit notifications.
-	 *
-	 * The third argument is a "struct hv_ops" containing the put_chars()
-	 * get_chars(), notifier_add() and notifier_del() pointers.
-	 * The final argument is the output buffer size: we can do any size,
-	 * so we put PAGE_SIZE here. */
-	virtconsole.hvc = hvc_alloc(0, 0, &virtio_cons, PAGE_SIZE);
-	if (IS_ERR(virtconsole.hvc)) {
-		err = PTR_ERR(virtconsole.hvc);
-		goto free_vqs;
-	}
+	virtconsole_add_port(0);
+	if (multiport)
+		for (i = 1; i < virtconsole.config.nr_ports; i++)
+			virtconsole_add_port(i);
 
 	return 0;
 
-free_vqs:
-	vdev->config->del_vqs(vdev);
 fail:
 	return err;
 }
@@ -502,6 +1024,7 @@ static struct virtio_device_id id_table[] = {
 
 static unsigned int features[] = {
 	VIRTIO_CONSOLE_F_SIZE,
+	VIRTIO_CONSOLE_F_MULTIPORT,
 };
 
 static struct virtio_driver virtio_console = {
@@ -516,7 +1039,20 @@ static struct virtio_driver virtio_console = {
 
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
index fe88517..b93dba4 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -3,19 +3,59 @@
 #include <linux/types.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
-/* This header, excluding the #ifdef __KERNEL__ part, is BSD licensed so
- * anyone can use the definitions to implement compatible drivers/servers. */
+/*
+ * This header, excluding the #ifdef __KERNEL__ part, is BSD licensed so
+ * anyone can use the definitions to implement compatible drivers/servers.
+ *
+ * Copyright (C) Red Hat, Inc., 2009
+ */
 
 /* Feature bits */
 #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
+#define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
 
 struct virtio_console_config {
 	/* colums of the screens */
 	__u16 cols;
 	/* rows of the screens */
 	__u16 rows;
+	/* number of ports added so far */
+	__u32 nr_ports;
 } __attribute__((packed));
 
+/*
+ * A message that's passed between the Host and the Guest for a
+ * particular port.
+ */
+struct virtio_console_control {
+	__u16 event;
+	__u16 value;
+};
+
+/* Some events for control messages */
+#define VIRTIO_CONSOLE_PORT_OPEN	0
+#define VIRTIO_CONSOLE_PORT_NAME	1
+#define VIRTIO_CONSOLE_CONSOLE_PORT	2
+#define VIRTIO_CONSOLE_RESIZE		3
+
+/*
+ * This struct is put in each buffer that gets passed to userspace and
+ * vice-versa
+ */
+struct virtio_console_header {
+	/* Port number */
+	u32 id;
+	/* Some message between host and guest */
+	u32 flags;
+	/*
+	 * Complete size of the write request - only sent with the
+	 * first buffer for each write request
+	 */
+	u32 size;
+} __attribute__((packed));
+
+/* Messages between host and guest ('flags' field in the header above) */
+#define VIRTIO_CONSOLE_ID_CONTROL	(1 << 0)
 
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
-- 
1.6.2.5
