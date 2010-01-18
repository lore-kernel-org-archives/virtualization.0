From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 30/32] virtio: console: Add ability to hot-unplug ports
Date: Mon, 18 Jan 2010 19:15:24 +0530
Message-ID: <1263822326-24208-31-git-send-email-amit.shah@redhat.com>
References: <1263822326-24208-1-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-2-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-3-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-4-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-5-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-6-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-7-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-8-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-9-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-10-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-11-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-12-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-13-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-14-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-15-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-16-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-17-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-18-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-19-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-20-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-21-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-22-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-23-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-24-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-25-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-26-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-27-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-28-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-29-git-send-email-amit.shah@redhat.com>
	<1263822326-24208-30-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263822326-24208-30-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c  |   66 ++++++++++++++++++++++++++++++++++++++-
 include/linux/virtio_console.h |    1 +
 2 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 36cd7d4..4a4eaba 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -803,6 +803,37 @@ static struct attribute_group port_attribute_group = {
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
+	free_buf(port->outbuf);
+	kfree(port->name);
+
+	kfree(port);
+	return 0;
+}
+
 /* Any private messages that the Host and Guest want to share */
 static void handle_control_message(struct ports_device *portdev,
 				   struct port_buffer *buf)
@@ -886,6 +917,32 @@ static void handle_control_message(struct ports_device *portdev,
 		 */
 		port->host_throttled = cpkt->value;
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
 
@@ -1118,12 +1175,17 @@ static void config_work_handler(struct work_struct *work)
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
index c096eb2..96c5832 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -42,6 +42,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_PORT_OPEN	3
 #define VIRTIO_CONSOLE_PORT_NAME	4
 #define VIRTIO_CONSOLE_THROTTLE_PORT	5
+#define VIRTIO_CONSOLE_PORT_REMOVE	6
 
 #ifdef __KERNEL__
 int __init virtio_cons_early_init(int (*put_chars)(u32, const char *, int));
-- 
1.6.2.5
