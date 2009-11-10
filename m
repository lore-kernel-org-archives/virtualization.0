From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 15/15] virtio_console: Add ability to hot-unplug ports
Date: Tue, 10 Nov 2009 15:11:41 +0530
Message-ID: <1257846101-23258-16-git-send-email-amit.shah@redhat.com>
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
	<1257846101-23258-15-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-15-git-send-email-amit.shah@redhat.com>
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

Remove port data; deregister from the hvc core if it's a console port.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c  |   64 ++++++++++++++++++++++++++++++++++++++++
 include/linux/virtio_console.h |    2 +
 2 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 90bb221..9035f80 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -719,6 +719,42 @@ int init_port_console(struct virtio_console_port *port)
 	return ret;
 }
 
+static struct attribute_group virtcon_attribute_group;
+
+/* Remove port-specific data. */
+static int virtcons_remove_port_data(struct virtio_console_port *port)
+{
+	struct virtio_console_port_buffer *buf, *buf2;
+	struct virtio_console_control cpkt;
+
+	if (port->guest_connected) {
+		cpkt.event = VIRTIO_CONSOLE_PORT_OPEN;
+		cpkt.value = 0;
+		send_buf(port, (char *)&cpkt, sizeof(cpkt),
+			 VIRTIO_CONSOLE_ID_CONTROL, false);
+	}
+	if (is_console_port(port))
+		hvc_remove(port->hvc);
+
+	sysfs_remove_group(&port->dev->kobj, &virtcon_attribute_group);
+	device_destroy(virtconsole.class, port->dev->devt);
+	unregister_chrdev_region(port->dev->devt, 1);
+	cdev_del(&port->cdev);
+
+	kfree(port->name);
+
+	/* Remove the buffers in which we have unconsumed data */
+	spin_lock(&port->readbuf_list_lock);
+	list_for_each_entry_safe(buf, buf2, &port->readbuf_head, list) {
+		list_del(&buf->list);
+		kfree(buf->buf);
+		kfree(buf);
+	}
+	spin_unlock(&port->readbuf_list_lock);
+	debugfs_remove(port->debugfs_file);
+	return 0;
+}
+
 /* Any private messages that the Host and Guest want to share */
 static void handle_control_message(struct virtio_console_port *port,
 				   struct virtio_console_port_buffer *buf)
@@ -799,6 +835,30 @@ static void handle_control_message(struct virtio_console_port *port,
 	case VIRTIO_CONSOLE_CACHE_BUFFERS:
 		port->cache_buffers = cpkt->value;
 		break;
+	case VIRTIO_CONSOLE_PORT_REMOVE:
+		/*
+		 * Hot unplug the port. We don't decrement nr_ports
+		 * since we don't want to deal with extra complexities
+		 * of using the lowest-available port id: We can just
+		 * pick up the nr_ports number as the id and not have
+		 * userspace send it to us. This helps us in two ways:
+		 *
+		 * - We don't need to have a 'port_id' field in the
+		 *   config space when a port is hot-added. This is a
+		 *   good thing as we might queue up multiple hotplug
+		 *   requests issued in our workqueue.
+		 *
+		 * - Another way to deal with this would have been to
+		 *   use a bitmap of the active ports and select the
+		 *   lowest non-active port from that map. That bloats
+		 *   the already tight config space and we would end
+		 *   up artificially limiting the max. number of ports
+		 *   to sizeof(bitmap). Right now we can support 2^32
+		 *   ports (as the port id is stored in a u32 type).
+		 *
+		 */
+		virtcons_remove_port_data(port);
+		break;
 	}
 }
 
@@ -1280,6 +1340,9 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_CACHING))
 		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_CACHING;
 
+	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_UNPLUG))
+		vdev->features[0] |= 1 << VIRTIO_CONSOLE_F_UNPLUG;
+
 	vdev->config->finalize_features(vdev);
 	/* Find the queues. */
 	/* FIXME: This is why we want to wean off hvc: we do nothing
@@ -1333,6 +1396,7 @@ static unsigned int features[] = {
 	VIRTIO_CONSOLE_F_MULTIPORT,
 	VIRTIO_CONSOLE_F_THROTTLE,
 	VIRTIO_CONSOLE_F_CACHING,
+	VIRTIO_CONSOLE_F_UNPLUG,
 };
 
 static struct virtio_driver virtio_console = {
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index ce5eef2..703696a 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -15,6 +15,7 @@
 #define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
 #define VIRTIO_CONSOLE_F_THROTTLE  2	/* Do we throttle data to prevent OOM */
 #define VIRTIO_CONSOLE_F_CACHING   3	/* Do we cache data after port close? */
+#define VIRTIO_CONSOLE_F_UNPLUG	4	/* Can we hot-unplug ports? */
 
 struct virtio_console_config {
 	/* colums of the screens */
@@ -42,6 +43,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_THROTTLE_PORT	4
 #define VIRTIO_CONSOLE_BUFFER_LIMIT	5
 #define VIRTIO_CONSOLE_CACHE_BUFFERS	6
+#define VIRTIO_CONSOLE_PORT_REMOVE	7
 
 /*
  * This struct is put in each buffer that gets passed to userspace and
-- 
1.6.2.5
