From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 24/28] virtio: console: Add option to remove cached buffers on
	port close
Date: Sat, 28 Nov 2009 12:20:47 +0530
Message-ID: <1259391051-7752-25-git-send-email-amit.shah@redhat.com>
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
	<1259391051-7752-21-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-22-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-23-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-24-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-24-git-send-email-amit.shah@redhat.com>
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

If caching of buffers upon closing a port is not desired,
delete all the buffers queued up for the port upon port
close.

This only applies to generic ports; console ports aren't
opened / closed by the chardev interface.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |   37 ++++++++++++++++++++++++++++++++++++-
 include/linux/virtio_console.h |    1 +
 2 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index fe8f14f..8fac9eb 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -195,6 +195,9 @@ struct port {
 
 	/* Have we sent out a throttle request to the Host? */
 	bool guest_throttled;
+
+	/* Does the port want to cache data when disconnected? */
+	bool cache_buffers;
 };
 
 /* This is the very early arch-specified put chars function. */
@@ -506,8 +509,25 @@ static int port_fops_release(struct inode *inode, struct file *filp)
 	/* Notify host of port being closed */
 	send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 0);
 
+	spin_lock_irq(&port->readbuf_list_lock);
 	port->guest_connected = false;
 
+	/*
+	 * If the port doesn't want to cache buffers while closed,
+	 * flush the unread buffers queue
+	 */
+	if (!port->cache_buffers) {
+		struct port_buffer *buf, *buf2;
+
+		list_for_each_entry_safe(buf, buf2, &port->readbuf_head, list) {
+			list_del(&buf->list);
+			kfree(buf->buf);
+			kfree(buf);
+			port->nr_buffers--;
+		}
+	}
+	spin_unlock_irq(&port->readbuf_list_lock);
+
 	return 0;
 }
 
@@ -869,6 +889,9 @@ static void handle_control_message(struct port *port, struct port_buffer *buf)
 		 */
 		port->buffer_limit = (u32)cpkt->value * 1024 / 4;
 		break;
+	case VIRTIO_CONSOLE_CACHE_BUFFERS:
+		port->cache_buffers = cpkt->value;
+		break;
 	}
 }
 
@@ -938,7 +961,19 @@ static void rx_work_handler(struct work_struct *work)
 		 * e.g. before the queues were initialised.
 		 */
 		port->host_connected = true;
-
+		/*
+		 * Don't queue up buffers if caching is disabled and
+		 * port is closed. This condition can be reached when
+		 * a console port is not yet connected (no tty is
+		 * spawned) and the host sends out data to console
+		 * ports. For generic serial ports, the host won't
+		 * send data till the guest is connected.
+		 */
+		if (!port->guest_connected && !port->cache_buffers) {
+			kfree(buf->buf);
+			kfree(buf);
+			continue;
+		}
 		if (port->guest_throttled) {
 			kfree(buf->buf);
 			kfree(buf);
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 2aa2b42..70924a1 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -40,6 +40,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_PORT_NAME	4
 #define VIRTIO_CONSOLE_THROTTLE_PORT	5
 #define VIRTIO_CONSOLE_BUFFER_LIMIT	6
+#define VIRTIO_CONSOLE_CACHE_BUFFERS	7
 
 /*
  * This struct is put at the start of each buffer that gets passed to
-- 
1.6.2.5
