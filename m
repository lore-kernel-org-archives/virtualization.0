From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 29/31] virtio: console: Add ability to hot-unplug ports
Date: Fri, 29 Jan 2010 19:12:43 +0530
Message-ID: <1264772563-25517-7-git-send-email-amit.shah@redhat.com>
References: <1264772563-25517-1-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-2-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-3-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-4-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-5-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-6-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1264772563-25517-6-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c  |   65 ++++++++++++++++++++++++++++++++++++++-
 include/linux/virtio_console.h |    1 +
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 6d783b7..8241bb7 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -790,6 +790,36 @@ static struct attribute_group port_attribute_group = {
 	.attrs = port_sysfs_entries,
 };
 
+/* Remove all port-specific data. */
+static int remove_port(struct port *port)
+{
+	spin_lock_irq(&port->portdev->ports_lock);
+	list_del(&port->list);
+	spin_unlock_irq(&port->portdev->ports_lock);
+
+	if (is_console_port(port)) {
+		spin_lock_irq(&pdrvdata_lock);
+		list_del(&port->cons.list);
+		spin_unlock_irq(&pdrvdata_lock);
+		hvc_remove(port->cons.hvc);
+	}
+	if (port->guest_connected)
+		send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 0);
+
+	while (port->in_vq->vq_ops->detach_unused_buf(port->in_vq))
+		;
+
+	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
+	device_destroy(pdrvdata.class, port->dev->devt);
+	cdev_del(&port->cdev);
+
+	discard_port_data(port);
+	kfree(port->name);
+
+	kfree(port);
+	return 0;
+}
+
 /* Any private messages that the Host and Guest want to share */
 static void handle_control_message(struct ports_device *portdev,
 				   struct port_buffer *buf)
@@ -861,6 +891,32 @@ static void handle_control_message(struct ports_device *portdev,
 				err);
 
 		break;
+	case VIRTIO_CONSOLE_PORT_REMOVE:
+		/*
+		 * Hot unplug the port.  We don't decrement nr_ports
+		 * since we don't want to deal with extra complexities
+		 * of using the lowest-available port id: We can just
+		 * pick up the nr_ports number as the id and not have
+		 * userspace send it to us.  This helps us in two
+		 * ways:
+		 *
+		 * - We don't need to have a 'port_id' field in the
+		 *   config space when a port is hot-added.  This is a
+		 *   good thing as we might queue up multiple hotplug
+		 *   requests issued in our workqueue.
+		 *
+		 * - Another way to deal with this would have been to
+		 *   use a bitmap of the active ports and select the
+		 *   lowest non-active port from that map.  That
+		 *   bloats the already tight config space and we
+		 *   would end up artificially limiting the
+		 *   max. number of ports to sizeof(bitmap).  Right
+		 *   now we can support 2^32 ports (as the port id is
+		 *   stored in a u32 type).
+		 *
+		 */
+		remove_port(port);
+		break;
 	}
 }
 
@@ -1085,12 +1141,17 @@ static void config_work_handler(struct work_struct *work)
 		/*
 		 * Port 0 got hot-added.  Since we already did all the
 		 * other initialisation for it, just tell the Host
-		 * that the port is ready.
+		 * that the port is ready if we find the port.  In
+		 * case the port was hot-removed earlier, we call
+		 * add_port to add the port.
 		 */
 		struct port *port;
 
 		port = find_port_by_id(portdev, 0);
-		send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
+		if (!port)
+			add_port(portdev, 0);
+		else
+			send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
 		return;
 	}
 	if (virtconconf.nr_ports > portdev->config.max_nr_ports) {
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 13e56c8..dd08675 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -41,6 +41,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_RESIZE		2
 #define VIRTIO_CONSOLE_PORT_OPEN	3
 #define VIRTIO_CONSOLE_PORT_NAME	4
+#define VIRTIO_CONSOLE_PORT_REMOVE	5
 
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
-- 
1.6.2.5
