From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 20/28] virtio: console: Add file operations to ports for
	open/read/write/poll
Date: Sat, 28 Nov 2009 12:20:43 +0530
Message-ID: <1259391051-7752-21-git-send-email-amit.shah@redhat.com>
References: <1259391051-7752-1-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-2-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-3-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-4-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-5-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-6-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-7-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-8-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-9-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-10-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-11-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-12-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-13-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-14-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-15-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-16-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-17-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-18-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-19-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-20-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-20-git-send-email-amit.shah@redhat.com>
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

Allow guest userspace applications to open, read from, write to, poll
the ports via the char dev interface.

When a port gets opened, a notification is sent to the host via a
control message indicating a connection has been established. Similarly,
on closing of the port, a notification is sent indicating disconnection.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |  165 ++++++++++++++++++++++++++++++++++++++--
 include/linux/virtio_console.h |    3 +
 2 files changed, 161 insertions(+), 7 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 4d55f0f..66875d6 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -19,11 +19,15 @@
 #include <linux/cdev.h>
 #include <linux/device.h>
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
 #include <linux/workqueue.h>
 #include "hvc_console.h"
 
@@ -146,6 +150,9 @@ struct port {
 	 */
 	spinlock_t readbuf_list_lock;
 
+	/* A waitqueue for poll() or blocking read operations */
+	wait_queue_head_t waitqueue;
+
 	/* Each port associates with a separate char device */
 	struct cdev cdev;
 	struct device *dev;
@@ -158,6 +165,9 @@ struct port {
 
 	/* The 'id' to identify the port with the Host */
 	u32 id;
+
+	/* Is the host device open */
+	bool host_connected;
 };
 
 /* This is the very early arch-specified put chars function. */
@@ -245,7 +255,7 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
 		return 0;
 
 	header.id = port->id;
-	header.flags = flags;
+	header.flags = flags | VIRTIO_CONSOLE_HDR_START_DATA;
 	header_len = use_multiport(port->portdev) ? sizeof(header) : 0;
 
 	in_offset = 0; /* offset in the user buffer */
@@ -261,10 +271,7 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
 		list_del(&buf->list);
 		spin_unlock_irqrestore(&port->portdev->write_list_lock, irqf);
 
-		if (header_len) {
-			memcpy(buf->buf, &header, header_len);
-			copy_size -= header_len;
-		}
+		copy_size -= header_len;
 		if (from_user) {
 			ret = copy_from_user(buf->buf + header_len,
 					     in_buf + in_offset, copy_size);
@@ -280,8 +287,13 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
 			ret = 0; /* Emulate copy_from_user behaviour */
 		}
 		buf->len = header_len + copy_size - ret;
-		sg_init_one(sg, buf->buf, buf->len);
+		if (!(in_count - in_offset - (buf->len - header_len)))
+			header.flags |= VIRTIO_CONSOLE_HDR_END_DATA;
 
+		if (header_len)
+			memcpy(buf->buf, &header, header_len);
+
+		sg_init_one(sg, buf->buf, buf->len);
 		spin_lock_irqsave(&port->portdev->write_list_lock, irqf);
 		ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, buf);
 		if (ret < 0) {
@@ -292,6 +304,9 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
 		}
 		in_offset += buf->len - header_len;
 
+		/* Set the START_DATA flag only for the first buffer. */
+		header.flags &= ~VIRTIO_CONSOLE_HDR_START_DATA;
+
 		/* No space left in the vq anyway */
 		if (!ret)
 			break;
@@ -372,6 +387,129 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
 	return out_offset;
 }
 
+/* The condition that must be true for polling to end */
+static bool wait_is_over(struct port *port)
+{
+	return !list_empty(&port->readbuf_head) || !port->host_connected;
+}
+
+static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
+			      size_t count, loff_t *offp)
+{
+	struct port *port;
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
+	 * disconnected after we got woken up from our wait.  So we
+	 * really want to give off whatever data we have and only then
+	 * check for host_connected.
+	 */
+	if (list_empty(&port->readbuf_head) && !port->host_connected)
+		return 0;
+
+	return fill_readbuf(port, ubuf, count, true);
+}
+
+static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
+			       size_t count, loff_t *offp)
+{
+	struct port *port;
+
+	port = filp->private_data;
+
+	return send_buf(port, ubuf, count, 0, true);
+}
+
+static unsigned int port_fops_poll(struct file *filp, poll_table *wait)
+{
+	struct port *port;
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
+static int port_fops_release(struct inode *inode, struct file *filp)
+{
+	struct port *port;
+
+	port = filp->private_data;
+
+	/* Notify host of port being closed */
+	send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 0);
+
+	return 0;
+}
+
+static int port_fops_open(struct inode *inode, struct file *filp)
+{
+	struct cdev *cdev = inode->i_cdev;
+	struct port *port;
+
+	port = container_of(cdev, struct port, cdev);
+	filp->private_data = port;
+
+	/*
+	 * Don't allow opening of console port devices -- that's done
+	 * via /dev/hvc
+	 */
+	if (is_console_port(port))
+		return -ENXIO;
+
+	/* Notify host of port being opened */
+	send_control_msg(filp->private_data, VIRTIO_CONSOLE_PORT_OPEN, 1);
+
+	return 0;
+}
+
+/*
+ * The file operations that we support: programs in the guest can open
+ * a console device, read from it, write to it, poll for data and
+ * close it. The devices are at
+ *   /dev/vport<device number>p<port number>
+ */
+static const struct file_operations port_fops = {
+	.owner = THIS_MODULE,
+	.open  = port_fops_open,
+	.read  = port_fops_read,
+	.write = port_fops_write,
+	.poll  = port_fops_poll,
+	.release = port_fops_release,
+};
+
 /*
  * The put_chars() callback is pretty straightforward.
  *
@@ -618,6 +756,10 @@ static void handle_control_message(struct port *port, struct port_buffer *buf)
 		port->cons.hvc->irq_requested = 1;
 		resize_console(port);
 		break;
+	case VIRTIO_CONSOLE_PORT_OPEN:
+		port->host_connected = cpkt->value;
+		wake_up_interruptible(&port->waitqueue);
+		break;
 	}
 }
 
@@ -682,10 +824,18 @@ static void rx_work_handler(struct work_struct *work)
 			kfree(buf);
 			continue;
 		}
+		/*
+		 * We might have missed a connection notification,
+		 * e.g. before the queues were initialised.
+		 */
+		port->host_connected = true;
+
 		spin_lock_irq(&port->readbuf_list_lock);
 		list_add_tail(&buf->list, &port->readbuf_head);
 		spin_unlock_irq(&port->readbuf_list_lock);
 
+		wake_up_interruptible(&port->waitqueue);
+
 		if (is_console_port(port))
 			console_activity |= hvc_poll(port->cons.hvc);
 	}
@@ -751,7 +901,7 @@ static int __devinit add_port(struct ports_device *portdev, u32 id)
 	port->portdev = portdev;
 	port->id = id;
 
-	cdev_init(&port->cdev, NULL);
+	cdev_init(&port->cdev, &port_fops);
 
 	devt = MKDEV(portdev->chr_major, id);
 	err = cdev_add(&port->cdev, devt, 1);
@@ -772,6 +922,7 @@ static int __devinit add_port(struct ports_device *portdev, u32 id)
 	}
 	spin_lock_init(&port->readbuf_list_lock);
 	INIT_LIST_HEAD(&port->readbuf_head);
+	init_waitqueue_head(&port->waitqueue);
 
 	/*
 	 * If we're not using multiport support, this has to be a console port
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index ad9557d..14af53d 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -36,6 +36,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_PORT_READY	0
 #define VIRTIO_CONSOLE_CONSOLE_PORT	1
 #define VIRTIO_CONSOLE_RESIZE		2
+#define VIRTIO_CONSOLE_PORT_OPEN	3
 
 /*
  * This struct is put at the start of each buffer that gets passed to
@@ -50,6 +51,8 @@ struct virtio_console_header {
 
 /* Messages between host and guest ('flags' field in the header above) */
 #define VIRTIO_CONSOLE_HDR_CONTROL	(1 << 0)
+#define VIRTIO_CONSOLE_HDR_START_DATA	(1 << 1)
+#define VIRTIO_CONSOLE_HDR_END_DATA	(1 << 2)
 
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
-- 
1.6.2.5
