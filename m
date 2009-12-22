From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 24/31] virtio: console: Add file operations to ports for
	open/read/write/poll
Date: Tue, 22 Dec 2009 20:04:34 +0530
Message-ID: <1261492481-19817-25-git-send-email-amit.shah@redhat.com>
References: <1261492481-19817-1-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-2-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-3-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-4-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-5-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-6-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-7-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-8-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-9-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-10-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-11-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-12-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-13-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-14-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-15-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-16-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-17-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-18-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-19-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-20-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-21-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-22-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-23-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-24-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-24-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c  |  151 +++++++++++++++++++++++++++++++++++++++-
 include/linux/virtio_console.h |    7 ++-
 2 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 721ad2f..c949e6c 100644
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
 
@@ -169,8 +173,14 @@ struct port {
 	struct cdev cdev;
 	struct device *dev;
 
+	/* A waitqueue for poll() or blocking read operations */
+	wait_queue_head_t waitqueue;
+
 	/* The 'id' to identify the port with the Host */
 	u32 id;
+
+	/* Is the host device open */
+	bool host_connected;
 };
 
 /* This is the very early arch-specified put chars function. */
@@ -372,6 +382,7 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
 	out_vq = port->out_vq;
 	buf = port->outbuf;
 
+	header.flags = VIRTIO_CONSOLE_HDR_START_DATA;
 	header_len = use_multiport(port->portdev) ? sizeof(header) : 0;
 
 	in_offset = 0; /* offset in the user buffer */
@@ -394,6 +405,9 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
 		}
 		buf->len = header_len + copy_size - ret;
 
+		if (!(in_count - in_offset - (buf->len - header_len)))
+			header.flags |= VIRTIO_CONSOLE_HDR_END_DATA;
+
 		if (header_len)
 			memcpy(buf->buf, &header, header_len);
 
@@ -409,6 +423,9 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
 		in_offset += buf->len - header_len;
 		while (!out_vq->vq_ops->get_buf(out_vq, &tmplen))
 			cpu_relax();
+
+		/* Set the START_DATA flag only for the first buffer. */
+		header.flags &= ~VIRTIO_CONSOLE_HDR_START_DATA;
 	}
 
 	/* We're expected to return the amount of data we wrote */
@@ -464,6 +481,129 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
 	return out_offset;
 }
 
+/* The condition that must be true for polling to end */
+static bool wait_is_over(struct port *port)
+{
+	return port_has_data(port) || !port->host_connected;
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
+	if (!port_has_data(port)) {
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
+	if (!port_has_data(port) && !port->host_connected)
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
+	return send_buf(port, ubuf, count, true);
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
+	if (port->inbuf)
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
+ * close it.  The devices are at
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
@@ -646,6 +786,10 @@ static void handle_control_message(struct ports_device *portdev,
 		port->cons.hvc->irq_requested = 1;
 		resize_console(port);
 		break;
+	case VIRTIO_CONSOLE_PORT_OPEN:
+		port->host_connected = cpkt->value;
+		wake_up_interruptible(&port->waitqueue);
+		break;
 	}
 }
 
@@ -692,6 +836,8 @@ static void in_intr(struct virtqueue *vq)
 		port->inbuf = get_inbuf(port);
 	spin_unlock_irqrestore(&port->inbuf_lock, flags);
 
+	wake_up_interruptible(&port->waitqueue);
+
 	if (is_console_port(port) && hvc_poll(port->cons.hvc))
 		hvc_kick();
 }
@@ -743,10 +889,12 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->inbuf = NULL;
 	port->cons.hvc = NULL;
 
+	port->host_connected = false;
+
 	port->in_vq = portdev->in_vqs[port->id];
 	port->out_vq = portdev->out_vqs[port->id];
 
-	cdev_init(&port->cdev, NULL);
+	cdev_init(&port->cdev, &port_fops);
 
 	devt = MKDEV(portdev->chr_major, id);
 	err = cdev_add(&port->cdev, devt, 1);
@@ -767,6 +915,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 	}
 
 	spin_lock_init(&port->inbuf_lock);
+	init_waitqueue_head(&port->waitqueue);
 
 	/*
 	 * If we're not using multiport support, this has to be a console port
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index b8e5f9f..9952b02 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -39,15 +39,20 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_PORT_READY	0
 #define VIRTIO_CONSOLE_CONSOLE_PORT	1
 #define VIRTIO_CONSOLE_RESIZE		2
+#define VIRTIO_CONSOLE_PORT_OPEN	3
 
 /*
  * This struct is put at the start of each data buffer that gets
  * passed to Host and vice-versa.
  */
 struct virtio_console_header {
-	/* Empty till multiport support is added */
+	u32 flags;		/* Some message between host and guest */
 };
 
+/* Messages between host and guest ('flags' field in the header above) */
+#define VIRTIO_CONSOLE_HDR_START_DATA	(1 << 0)
+#define VIRTIO_CONSOLE_HDR_END_DATA	(1 << 1)
+
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
 #endif /* __KERNEL__ */
-- 
1.6.2.5
