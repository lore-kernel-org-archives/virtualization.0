From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 28/31] virtio: console: Add option to remove cached buffers on
	port close
Date: Tue, 22 Dec 2009 20:04:38 +0530
Message-ID: <1261492481-19817-29-git-send-email-amit.shah@redhat.com>
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
	<1261492481-19817-25-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-26-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-27-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-28-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-28-git-send-email-amit.shah@redhat.com>
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

If caching of buffers upon closing a port is not desired, delete all the
buffers queued up for the port upon port close.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |   56 ++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_console.h |    1 +
 2 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 2409330..4c9ec04 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -190,6 +190,9 @@ struct port {
 
 	/* Does the Host not want to accept more data currently?  */
 	bool host_throttled;
+
+	/* Does the port want to cache data when disconnected? */
+	bool cache_buffers;
 };
 
 /* This is the very early arch-specified put chars function. */
@@ -326,6 +329,34 @@ static int add_inbuf(struct virtqueue *vq, struct port_buffer *buf)
 	return ret;
 }
 
+/* Discard any unread data this port has. Callers lockers. */
+static void flush_port_data(struct port *port)
+{
+	struct port_buffer *buf;
+	struct virtqueue *vq;
+	unsigned int len;
+	int ret;
+
+	vq = port->in_vq;
+	if (port->inbuf)
+		buf = port->inbuf;
+	else
+		buf = vq->vq_ops->get_buf(vq, &len);
+
+	ret = 0;
+	while (buf) {
+		if (add_inbuf(vq, buf) < 0) {
+			ret++;
+			free_buf(buf);
+		}
+		buf = vq->vq_ops->get_buf(vq, &len);
+	}
+	port->inbuf = NULL;
+	if (ret)
+		dev_warn(port->dev, "Errors adding %d buffers back to vq\n",
+			 ret);
+}
+
 static bool port_has_data(struct port *port)
 {
 	unsigned long flags;
@@ -577,8 +608,18 @@ static int port_fops_release(struct inode *inode, struct file *filp)
 	/* Notify host of port being closed */
 	send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 0);
 
+	spin_lock_irq(&port->inbuf_lock);
 	port->guest_connected = false;
 
+	/*
+	 * If the port doesn't want to cache buffers while closed,
+	 * flush the unread buffers queue
+	 */
+	if (!port->cache_buffers)
+		flush_port_data(port);
+
+	spin_unlock_irq(&port->inbuf_lock);
+
 	return 0;
 }
 
@@ -879,6 +920,9 @@ static void handle_control_message(struct ports_device *portdev,
 		 */
 		port->host_throttled = cpkt->value;
 		break;
+	case VIRTIO_CONSOLE_CACHE_BUFFERS:
+		port->cache_buffers = cpkt->value;
+		break;
 	}
 }
 
@@ -923,6 +967,17 @@ static void in_intr(struct virtqueue *vq)
 	spin_lock_irqsave(&port->inbuf_lock, flags);
 	if (!port->inbuf)
 		port->inbuf = get_inbuf(port);
+
+	/*
+	 * Don't queue up buffers if caching is disabled and port is
+	 * closed.  This condition can be reached when a console port
+	 * is not yet connected (no tty is spawned) and the host sends
+	 * out data to console ports.  For generic serial ports, the
+	 * host won't send data till the guest is connected.
+	 */
+	if (!port->guest_connected && !port->cache_buffers)
+		flush_port_data(port);
+
 	spin_unlock_irqrestore(&port->inbuf_lock, flags);
 
 	wake_up_interruptible(&port->waitqueue);
@@ -981,6 +1036,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 
 	port->host_connected = port->guest_connected = false;
 	port->host_throttled = false;
+	port->cache_buffers = false;
 
 	port->in_vq = portdev->in_vqs[port->id];
 	port->out_vq = portdev->out_vqs[port->id];
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 4bd57c8..41ef890 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -42,6 +42,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_PORT_OPEN	3
 #define VIRTIO_CONSOLE_PORT_NAME	4
 #define VIRTIO_CONSOLE_THROTTLE_PORT	5
+#define VIRTIO_CONSOLE_CACHE_BUFFERS	6
 
 /*
  * This struct is put at the start of each data buffer that gets
-- 
1.6.2.5
