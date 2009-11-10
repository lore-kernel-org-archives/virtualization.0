From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 13/15] virtio_console: Add throttling support to prevent
	flooding ports
Date: Tue, 10 Nov 2009 15:11:39 +0530
Message-ID: <1257846101-23258-14-git-send-email-amit.shah@redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-13-git-send-email-amit.shah@redhat.com>
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

Rogue processes on guests or hosts could pump in data
and cause an OOM condition. Add support for throttling
so that a limit to the number of outstanding buffers
can be specified.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |  102 +++++++++++++++++++++++++++++++++++++++-
 include/linux/virtio_console.h |    3 +
 2 files changed, 104 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index f7db92a..c45b987 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -143,11 +143,32 @@ struct virtio_console_port {
 	 */
 	u32 vtermno;
 
+	/*
+	 * The Host can set some limit to the number of outstanding
+	 * buffers we can have in the readbuf_head list before we
+	 * should ask the Host to stop any more data from coming
+	 * in. This is to not allow a rogue process on the Host to OOM
+	 * the entire guest.
+	 */
+	u32 buffer_limit;
+
+	/*
+	 * The actual number of buffers we have pending in the
+	 * readbuf_head list
+	 */
+	u32 nr_buffers;
+
 	/* Is the host device open */
 	bool host_connected;
 
 	/* We should allow only one process to open a port */
 	bool guest_connected;
+
+	/* Does the Host not want to accept more data currently?  */
+	bool host_throttled;
+
+	/* Have we sent out a throttle request to the Host? */
+	bool guest_throttled;
 };
 
 struct virtio_console_struct virtconsole;
@@ -367,6 +388,7 @@ static ssize_t fill_readbuf(struct virtio_console_port *port,
 		if (buf->len - buf->offset == 0) {
 			spin_lock(&port->readbuf_list_lock);
 			list_del(&buf->list);
+			port->nr_buffers--;
 			spin_unlock(&port->readbuf_list_lock);
 			kfree(buf->buf);
 			kfree(buf);
@@ -374,6 +396,15 @@ static ssize_t fill_readbuf(struct virtio_console_port *port,
 		if (!out_count)
 			break;
 	}
+	if (port->guest_throttled && port->nr_buffers < port->buffer_limit) {
+		struct virtio_console_control cpkt;
+
+		cpkt.event = VIRTIO_CONSOLE_THROTTLE_PORT;
+		cpkt.value = false;
+		send_buf(port, (char *)&cpkt, sizeof(cpkt),
+			 VIRTIO_CONSOLE_ID_CONTROL, false);
+		port->guest_throttled = false;
+	}
 	return out_offset;
 }
 
@@ -430,6 +461,9 @@ static ssize_t virtconsole_write(struct file *filp, const char __user *ubuf,
 
 	port = filp->private_data;
 
+	if (port->host_throttled)
+		return -ENOSPC;
+
 	return send_buf(port, ubuf, count, 0, true);
 }
 
@@ -444,7 +478,7 @@ static unsigned int virtconsole_poll(struct file *filp, poll_table *wait)
 	ret = 0;
 	if (!list_empty(&port->readbuf_head))
 		ret |= POLLIN | POLLRDNORM;
-	if (port->host_connected)
+	if (port->host_connected && !port->host_throttled)
 		ret |= POLLOUT;
 	if (!port->host_connected)
 		ret |= POLLHUP;
@@ -715,6 +749,35 @@ static void handle_control_message(struct virtio_console_port *port,
 		port->hvc->irq_requested = 1;
 		virtcons_apply_config(port);
 		break;
+	case VIRTIO_CONSOLE_THROTTLE_PORT:
+		/*
+		 * Hosts can govern some policy to disallow rogue
+		 * processes write indefinitely to ports leading to
+		 * OOM situations.  If we receive this message here,
+		 * it means the Host side of the port either reached
+		 * its max. limit to cache data or signal to us that
+		 * the host is ready to accept more data.
+		 */
+		port->host_throttled = cpkt->value;
+		break;
+	case VIRTIO_CONSOLE_BUFFER_LIMIT:
+		/*
+		 * We can ask the Host to stop sending data to us in
+		 * case some rogue process on the Host injects data to
+		 * OOM the entire guest (as unread buffers keep piling
+		 * up in the kernel space). The Host, via this
+		 * message, can tell us the number of Mbytes to
+		 * buffer.
+		 *
+		 * The calculation is easy: we use 4K-sized pages in
+		 * our readbuf_head list. So on each buffer added to
+		 * the list, increment count by 1 (and decrement by 1
+		 * when one gets removed). So we just store the
+		 * (number-in-MB * 1024) / 4 to calculate the number of
+		 * buffers we can have in the list.
+		 */
+		port->buffer_limit = (u32)cpkt->value * 1024 / 4;
+		break;
 	}
 }
 
@@ -845,9 +908,31 @@ static void virtio_console_rx_work_handler(struct work_struct *work)
 			 */
 			port->host_connected = true;
 
+			if (port->guest_throttled) {
+				kfree(buf->buf);
+				kfree(buf);
+				continue;
+			}
 			spin_lock(&port->readbuf_list_lock);
 			list_add_tail(&buf->list, &port->readbuf_head);
+			port->nr_buffers++;
 			spin_unlock(&port->readbuf_list_lock);
+			/*
+			 * If we reached the throttle level, send out
+			 * a message to the host to ask it to stop
+			 * sending us any more data.
+			 */
+			if (virtio_has_feature(port->vcon->vdev,
+					       VIRTIO_CONSOLE_F_THROTTLE)
+			    && (port->nr_buffers >= port->buffer_limit)) {
+				struct virtio_console_control cpkt;
+
+				port->guest_throttled = true;
+				cpkt.event = VIRTIO_CONSOLE_THROTTLE_PORT;
+				cpkt.value = true;
+				send_buf(port, (char *)&cpkt, sizeof(cpkt),
+					 VIRTIO_CONSOLE_ID_CONTROL, false);
+			}
 		}
 		wake_up_interruptible(&port->waitqueue);
 
@@ -967,8 +1052,16 @@ static ssize_t virtcon_port_debugfs_read(struct file *filp, char __user *ubuf,
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "guest_connected: %d\n", port->guest_connected);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "guest_throttled: %d\n", port->guest_throttled);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "buffer_limit: %u\n", port->buffer_limit);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "nr_buffers: %u\n", port->nr_buffers);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "host_connected: %d\n", port->host_connected);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "host_throttled: %d\n", port->host_throttled);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "is_console: %d\n", port->hvc ? 1 : 0);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "console_vtermno: %u\n", port->vtermno);
@@ -999,6 +1092,8 @@ static int virtconsole_add_port(u32 port_nr)
 	port->vcon = &virtconsole;
 	port->id = port_nr;
 
+	port->buffer_limit = ~(u32)0;
+
 	cdev_init(&port->cdev, &virtconsole_fops);
 
 	ret = alloc_chrdev_region(&devt, 0, 1, "virtio-console");
@@ -1144,6 +1239,10 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 				  &virtconsole.config.nr_ports,
 				  sizeof(virtconsole.config.nr_ports));
 	}
+	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_THROTTLE)) {
+		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_THROTTLE;
+		vdev->config->finalize_features(vdev);
+	}
 	/* Find the queues. */
 	/* FIXME: This is why we want to wean off hvc: we do nothing
 	 * when input comes in. */
@@ -1194,6 +1293,7 @@ static struct virtio_device_id id_table[] = {
 static unsigned int features[] = {
 	VIRTIO_CONSOLE_F_SIZE,
 	VIRTIO_CONSOLE_F_MULTIPORT,
+	VIRTIO_CONSOLE_F_THROTTLE,
 };
 
 static struct virtio_driver virtio_console = {
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index b93dba4..5336a75 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -13,6 +13,7 @@
 /* Feature bits */
 #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
 #define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
+#define VIRTIO_CONSOLE_F_THROTTLE  2	/* Do we throttle data to prevent OOM */
 
 struct virtio_console_config {
 	/* colums of the screens */
@@ -37,6 +38,8 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_PORT_NAME	1
 #define VIRTIO_CONSOLE_CONSOLE_PORT	2
 #define VIRTIO_CONSOLE_RESIZE		3
+#define VIRTIO_CONSOLE_THROTTLE_PORT	4
+#define VIRTIO_CONSOLE_BUFFER_LIMIT	5
 
 /*
  * This struct is put in each buffer that gets passed to userspace and
-- 
1.6.2.5
