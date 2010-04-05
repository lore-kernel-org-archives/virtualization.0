From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 10/10] virtio: console: Add support for nonblocking write()s
Date: Mon,  5 Apr 2010 19:24:14 +0530
Message-ID: <1270475654-399-11-git-send-email-amit.shah@redhat.com>
References: <1270475654-399-1-git-send-email-amit.shah@redhat.com>
	<1270475654-399-2-git-send-email-amit.shah@redhat.com>
	<1270475654-399-3-git-send-email-amit.shah@redhat.com>
	<1270475654-399-4-git-send-email-amit.shah@redhat.com>
	<1270475654-399-5-git-send-email-amit.shah@redhat.com>
	<1270475654-399-6-git-send-email-amit.shah@redhat.com>
	<1270475654-399-7-git-send-email-amit.shah@redhat.com>
	<1270475654-399-8-git-send-email-amit.shah@redhat.com>
	<1270475654-399-9-git-send-email-amit.shah@redhat.com>
	<1270475654-399-10-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1270475654-399-10-git-send-email-amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
Cc: Amit Shah <amit.shah@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

If the host port is not open, a write() should either just return if the
file is opened in non-blocking mode, or block till the host port is
opened.

Also, don't spin till host consumes data for nonblocking ports. For
non-blocking ports, we can do away with the spinning and reclaim the
buffers consumed by the host on the next write call or on the condition
that'll make poll return.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   82 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 680ea25..d70efda 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -183,6 +183,8 @@ struct port {
 	/* The 'id' to identify the port with the Host */
 	u32 id;
 
+	bool outvq_full;
+
 	/* Is the host device open */
 	bool host_connected;
 
@@ -404,7 +406,19 @@ static ssize_t send_control_msg(struct port *port, unsigned int event,
 	return __send_control_msg(port->portdev, port->id, event, value);
 }
 
-static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count)
+static void reclaim_consumed_buffers(struct port *port)
+{
+	void *buf;
+	unsigned int len;
+
+	while ((buf = port->out_vq->vq_ops->get_buf(port->out_vq, &len))) {
+		kfree(buf);
+		port->outvq_full = false;
+	}
+}
+
+static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count,
+			bool nonblock)
 {
 	struct scatterlist sg[1];
 	struct virtqueue *out_vq;
@@ -413,6 +427,8 @@ static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count)
 
 	out_vq = port->out_vq;
 
+	reclaim_consumed_buffers(port);
+
 	sg_init_one(sg, in_buf, in_count);
 	ret = out_vq->vq_ops->add_buf(out_vq, sg, 1, 0, in_buf);
 
@@ -424,6 +440,12 @@ static ssize_t send_buf(struct port *port, void *in_buf, size_t in_count)
 		goto fail;
 	}
 
+	if (ret == 0)
+		port->outvq_full = true;
+
+	if (nonblock)
+		return in_count;
+
 	/*
 	 * Wait till the host acknowledges it pushed out the data we
 	 * sent.  This is done for ports in blocking mode or for data
@@ -491,6 +513,20 @@ static bool will_read_block(struct port *port)
 	return !port_has_data(port) && port->host_connected;
 }
 
+static bool will_write_block(struct port *port)
+{
+	if (!port->host_connected)
+		return true;
+
+	/*
+	 * Check if the Host has consumed any buffers since we last
+	 * sent data (this is only applicable for nonblocking ports).
+	 */
+	reclaim_consumed_buffers(port);
+
+	return port->outvq_full;
+}
+
 static ssize_t port_fops_read(struct file *filp, char __user *ubuf,
 			      size_t count, loff_t *offp)
 {
@@ -537,9 +573,22 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 	struct port *port;
 	char *buf;
 	ssize_t ret;
+	bool nonblock;
 
 	port = filp->private_data;
 
+	nonblock = filp->f_flags & O_NONBLOCK;
+
+	if (will_write_block(port)) {
+		if (nonblock)
+			return -EAGAIN;
+
+		ret = wait_event_interruptible(port->waitqueue,
+					       !will_write_block(port));
+		if (ret < 0)
+			return ret;
+	}
+
 	count = min((size_t)(32 * 1024), count);
 
 	buf = kmalloc(count, GFP_KERNEL);
@@ -552,9 +601,14 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 		goto free_buf;
 	}
 
-	ret = send_buf(port, buf, count);
+	ret = send_buf(port, buf, count, nonblock);
+
+	if (nonblock && ret > 0)
+		goto out;
+
 free_buf:
 	kfree(buf);
+out:
 	return ret;
 }
 
@@ -569,7 +623,7 @@ static unsigned int port_fops_poll(struct file *filp, poll_table *wait)
 	ret = 0;
 	if (port->inbuf)
 		ret |= POLLIN | POLLRDNORM;
-	if (port->host_connected)
+	if (!will_write_block(port))
 		ret |= POLLOUT;
 	if (!port->host_connected)
 		ret |= POLLHUP;
@@ -592,6 +646,7 @@ static int port_fops_release(struct inode *inode, struct file *filp)
 	discard_port_data(port);
 
 	spin_unlock_irq(&port->inbuf_lock);
+	reclaim_consumed_buffers(port);
 
 	return 0;
 }
@@ -621,6 +676,13 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 	port->guest_connected = true;
 	spin_unlock_irq(&port->inbuf_lock);
 
+	/*
+	 * There might be a chance that we missed reclaiming a few
+	 * buffers in the window of the port getting previously closed
+	 * and opening now.
+	 */
+	reclaim_consumed_buffers(port);
+
 	/* Notify host of port being opened */
 	send_control_msg(filp->private_data, VIRTIO_CONSOLE_PORT_OPEN, 1);
 
@@ -661,7 +723,7 @@ static int put_chars(u32 vtermno, const char *buf, int count)
 	if (!port)
 		return -EPIPE;
 
-	return send_buf(port, (void *)buf, count);
+	return send_buf(port, (void *)buf, count, false);
 }
 
 /*
@@ -853,6 +915,8 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf,
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "host_connected: %d\n", port->host_connected);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "outvq_full: %d\n", port->outvq_full);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "is_console: %s\n",
 			       is_console_port(port) ? "yes" : "no");
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
@@ -919,6 +983,8 @@ static int add_port(struct ports_device *portdev, u32 id)
 
 	port->host_connected = port->guest_connected = false;
 
+	port->outvq_full = false;
+
 	port->in_vq = portdev->in_vqs[port->id];
 	port->out_vq = portdev->out_vqs[port->id];
 
@@ -1036,6 +1102,8 @@ static int remove_port(struct port *port)
 	/* Remove unused data this port might have received. */
 	discard_port_data(port);
 
+	reclaim_consumed_buffers(port);
+
 	/* Remove buffers we queued up for the Host to send us data in. */
 	while ((buf = port->in_vq->vq_ops->detach_unused_buf(port->in_vq)))
 		free_buf(buf);
@@ -1107,6 +1175,12 @@ static void handle_control_message(struct ports_device *portdev,
 	case VIRTIO_CONSOLE_PORT_OPEN:
 		port->host_connected = cpkt->value;
 		wake_up_interruptible(&port->waitqueue);
+		/*
+		 * If the host port got closed and the host had any
+		 * unconsumed buffers, we'll be able to reclaim them
+		 * now.
+		 */
+		reclaim_unconsumed_buffers(port);
 		break;
 	case VIRTIO_CONSOLE_PORT_NAME:
 		/*
-- 
1.6.2.5
