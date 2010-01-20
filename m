From: Amit Shah <amit.shah@redhat.com>
Subject: Remove host throttling
Date: Wed, 20 Jan 2010 14:21:02 +0530
Message-ID: <1263977465-13983-1-git-send-email-amit.shah@redhat.com>
References: <201001201850.56114.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <201001201850.56114.rusty@rustcorp.com.au>
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
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org


Hey Rusty,

These are the patches to be replaced -- patches 19, 30, 31 from the
previous series. Patch 26 from the earlier series is to be dropped.

The diff to the previous version is:


diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index e936026..4218cb9 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -195,9 +195,6 @@ struct port {
 
 	/* We should allow only one process to open a port */
 	bool guest_connected;
-
-	/* Does the Host not want to accept more data currently?  */
-	bool host_throttled;
 };
 
 /* This is the very early arch-specified put chars function. */
@@ -414,17 +411,6 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
 	out_vq = port->out_vq;
 	buf = port->outbuf;
 
-	if (buf->len) {
-		/*
-		 * Nonzero buf->len means we had queued a buffer
-		 * earlier to the Host to be consumed.  Get the buffer
-		 * back for this write request; wait while the Host
-		 * consumes it.
-		 */
-		while (!out_vq->vq_ops->get_buf(out_vq, &tmplen))
-			cpu_relax();
-	}
-
 	if (in_count > buf->size)
 		in_count = buf->size;
 
@@ -448,9 +434,21 @@ static ssize_t send_buf(struct port *port, const char *in_buf, size_t in_count,
 	/* Tell Host to go! */
 	out_vq->vq_ops->kick(out_vq);
 
-	if (ret < 0)
+	if (ret < 0) {
 		buf->len = 0;
+		goto fail;
+	}
 
+	/*
+	 * Wait till the host acknowledges it pushed out the data we
+	 * sent. Also ensure we return to userspace the number of
+	 * bytes that were successfully consumed by the host.
+	 */
+	while (!out_vq->vq_ops->get_buf(out_vq, &tmplen))
+		cpu_relax();
+
+	buf->len = tmplen;
+fail:
 	/* We're expected to return the amount of data we wrote */
 	return buf->len;
 }
@@ -553,9 +551,6 @@ static ssize_t port_fops_write(struct file *filp, const char __user *ubuf,
 
 	port = filp->private_data;
 
-	if (port->host_throttled)
-		return -ENOSPC;
-
 	return send_buf(port, ubuf, count, true);
 }
 
@@ -570,7 +565,7 @@ static unsigned int port_fops_poll(struct file *filp, poll_table *wait)
 	ret = 0;
 	if (port->inbuf)
 		ret |= POLLIN | POLLRDNORM;
-	if (port->host_connected && !port->host_throttled)
+	if (port->host_connected)
 		ret |= POLLOUT;
 	if (!port->host_connected)
 		ret |= POLLHUP;
@@ -839,8 +834,6 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf,
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "host_connected: %d\n", port->host_connected);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "host_throttled: %d\n", port->host_throttled);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "is_console: %s\n",
 			       is_console_port(port) ? "yes" : "no");
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
@@ -961,18 +954,6 @@ static void handle_control_message(struct ports_device *portdev,
 				err);
 
 		break;
-	case VIRTIO_CONSOLE_THROTTLE_PORT:
-		/*
-		 * Hosts can govern some policy to disallow rogue
-		 * guest processes writing indefinitely to ports
-		 * leading to OOM situations.  If we receive this
-		 * message here, it means the Host side of the port
-		 * either reached its max. limit to cache data or
-		 * signal to us that the host is ready to accept more
-		 * data.
-		 */
-		port->host_throttled = cpkt->value;
-		break;
 	case VIRTIO_CONSOLE_PORT_REMOVE:
 		/*
 		 * Hot unplug the port.  We don't decrement nr_ports
@@ -1130,7 +1111,6 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->cons.hvc = NULL;
 
 	port->host_connected = port->guest_connected = false;
-	port->host_throttled = false;
 
 	port->in_vq = portdev->in_vqs[port->id];
 	port->out_vq = portdev->out_vqs[port->id];
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 96c5832..dd08675 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -41,8 +41,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_RESIZE		2
 #define VIRTIO_CONSOLE_PORT_OPEN	3
 #define VIRTIO_CONSOLE_PORT_NAME	4
-#define VIRTIO_CONSOLE_THROTTLE_PORT	5
-#define VIRTIO_CONSOLE_PORT_REMOVE	6
+#define VIRTIO_CONSOLE_PORT_REMOVE	5
 
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
