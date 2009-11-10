From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 14/15] virtio_console: Add option to remove cached buffers on
	port close
Date: Tue, 10 Nov 2009 15:11:40 +0530
Message-ID: <1257846101-23258-15-git-send-email-amit.shah@redhat.com>
References: <1257846101-23258-1-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-2-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-3-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-4-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-5-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-6-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-7-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-8-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-9-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-10-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-11-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-12-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-13-git-send-email-amit.shah@redhat.com>
	<1257846101-23258-14-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-14-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c  |   49 +++++++++++++++++++++++++++++++++++----
 include/linux/virtio_console.h |    2 +
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index c45b987..90bb221 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -169,6 +169,9 @@ struct virtio_console_port {
 
 	/* Have we sent out a throttle request to the Host? */
 	bool guest_throttled;
+
+	/* Does the port want to cache data when disconnected? */
+	bool cache_buffers;
 };
 
 struct virtio_console_struct virtconsole;
@@ -501,6 +504,21 @@ static int virtconsole_release(struct inode *inode, struct file *filp)
 
 	spin_lock(&port->readbuf_list_lock);
 	port->guest_connected = false;
+
+	/*
+	 * If the port doesn't want to cache buffers while closed,
+	 * flush the unread buffers queue
+	 */
+	if (!port->cache_buffers) {
+		struct virtio_console_port_buffer *buf, *buf2;
+
+		list_for_each_entry_safe(buf, buf2, &port->readbuf_head, list) {
+			list_del(&buf->list);
+			kfree(buf->buf);
+			kfree(buf);
+			port->nr_buffers--;
+		}
+	}
 	spin_unlock(&port->readbuf_list_lock);
 
 	return 0;
@@ -778,6 +796,9 @@ static void handle_control_message(struct virtio_console_port *port,
 		 */
 		port->buffer_limit = (u32)cpkt->value * 1024 / 4;
 		break;
+	case VIRTIO_CONSOLE_CACHE_BUFFERS:
+		port->cache_buffers = cpkt->value;
+		break;
 	}
 }
 
@@ -907,7 +928,20 @@ static void virtio_console_rx_work_handler(struct work_struct *work)
 			 * initialised.
 			 */
 			port->host_connected = true;
-
+			/*
+			 * Don't queue up buffers if caching is
+			 * disabled and port is closed. This condition
+			 * can be reached when a console port is not
+			 * yet connected (no tty is spawned) and the
+			 * host sends out data to console ports. For
+			 * generic serial ports, the host won't send
+			 * data till the guest is connected.
+			 */
+			if (!port->guest_connected && !port->cache_buffers) {
+				kfree(buf->buf);
+				kfree(buf);
+				continue;
+			}
 			if (port->guest_throttled) {
 				kfree(buf->buf);
 				kfree(buf);
@@ -1058,6 +1092,8 @@ static ssize_t virtcon_port_debugfs_read(struct file *filp, char __user *ubuf,
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "nr_buffers: %u\n", port->nr_buffers);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "cache_buffers: %d\n", port->cache_buffers);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "host_connected: %d\n", port->host_connected);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "host_throttled: %d\n", port->host_throttled);
@@ -1232,17 +1268,19 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
 		multiport = true;
 		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_MULTIPORT;
-		vdev->config->finalize_features(vdev);
 
 		vdev->config->get(vdev, offsetof(struct virtio_console_config,
 						 nr_ports),
 				  &virtconsole.config.nr_ports,
 				  sizeof(virtconsole.config.nr_ports));
 	}
-	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_THROTTLE)) {
+	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_THROTTLE))
 		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_THROTTLE;
-		vdev->config->finalize_features(vdev);
-	}
+
+	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_CACHING))
+		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_CACHING;
+
+	vdev->config->finalize_features(vdev);
 	/* Find the queues. */
 	/* FIXME: This is why we want to wean off hvc: we do nothing
 	 * when input comes in. */
@@ -1294,6 +1332,7 @@ static unsigned int features[] = {
 	VIRTIO_CONSOLE_F_SIZE,
 	VIRTIO_CONSOLE_F_MULTIPORT,
 	VIRTIO_CONSOLE_F_THROTTLE,
+	VIRTIO_CONSOLE_F_CACHING,
 };
 
 static struct virtio_driver virtio_console = {
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 5336a75..ce5eef2 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -14,6 +14,7 @@
 #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
 #define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
 #define VIRTIO_CONSOLE_F_THROTTLE  2	/* Do we throttle data to prevent OOM */
+#define VIRTIO_CONSOLE_F_CACHING   3	/* Do we cache data after port close? */
 
 struct virtio_console_config {
 	/* colums of the screens */
@@ -40,6 +41,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_RESIZE		3
 #define VIRTIO_CONSOLE_THROTTLE_PORT	4
 #define VIRTIO_CONSOLE_BUFFER_LIMIT	5
+#define VIRTIO_CONSOLE_CACHE_BUFFERS	6
 
 /*
  * This struct is put in each buffer that gets passed to userspace and
-- 
1.6.2.5
