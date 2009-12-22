From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 30/31] virtio: console: Add ability to hot-unplug ports
Date: Tue, 22 Dec 2009 20:04:40 +0530
Message-ID: <1261492481-19817-31-git-send-email-amit.shah@redhat.com>
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
	<1261492481-19817-29-git-send-email-amit.shah@redhat.com>
	<1261492481-19817-30-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-30-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c  |   63 ++++++++++++++++++++++++++++++++++++++-
 include/linux/virtio_console.h |    1 +
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index d964121..48ef259 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -833,6 +833,34 @@ static struct attribute_group port_attribute_group = {
 	.attrs = port_sysfs_entries,
 };
 
+/* Remove port-specific data. */
+static int remove_port_data(struct port *port)
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
+	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
+	device_destroy(pdrvdata.class, port->dev->devt);
+	cdev_del(&port->cdev);
+
+	flush_port_data(port);
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
@@ -919,6 +947,32 @@ static void handle_control_message(struct ports_device *portdev,
 	case VIRTIO_CONSOLE_CACHE_BUFFERS:
 		port->cache_buffers = cpkt->value;
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
+		remove_port_data(port);
+		break;
 	}
 }
 
@@ -1140,12 +1194,17 @@ static void config_work_handler(struct work_struct *work)
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
index 41ef890..cf52b9b 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -43,6 +43,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_PORT_NAME	4
 #define VIRTIO_CONSOLE_THROTTLE_PORT	5
 #define VIRTIO_CONSOLE_CACHE_BUFFERS	6
+#define VIRTIO_CONSOLE_PORT_REMOVE	7
 
 /*
  * This struct is put at the start of each data buffer that gets
-- 
1.6.2.5
