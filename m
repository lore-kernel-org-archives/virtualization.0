From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 27/28] virtio: console: Add ability to hot-unplug ports
Date: Sat, 28 Nov 2009 12:20:50 +0530
Message-ID: <1259391051-7752-28-git-send-email-amit.shah@redhat.com>
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
	<1259391051-7752-25-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-26-git-send-email-amit.shah@redhat.com>
	<1259391051-7752-27-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-27-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c  |   69 +++++++++++++++++++++++++++++++++++++--
 include/linux/virtio_console.h |    1 +
 2 files changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 47d84d7..8ed57c2 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -795,6 +795,43 @@ static void fill_receive_queue(struct ports_device *portdev)
 
 static struct attribute_group port_attribute_group;
 
+/* Remove port-specific data. */
+static int remove_port_data(struct port *port)
+{
+	struct port_buffer *buf, *buf2;
+
+	spin_lock_irq(&port->portdev->ports_list_lock);
+	list_del(&port->list);
+	spin_unlock_irq(&port->portdev->ports_list_lock);
+
+	if (port->guest_connected)
+		send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 0);
+
+	if (is_console_port(port)) {
+		spin_lock_irq(&pdrvdata_lock);
+		list_del(&port->cons.list);
+		spin_unlock_irq(&pdrvdata_lock);
+		hvc_remove(port->cons.hvc);
+	}
+	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
+	device_destroy(pdrvdata.class, port->dev->devt);
+	cdev_del(&port->cdev);
+
+	kfree(port->name);
+
+	/* Remove the buffers in which we have unconsumed data */
+	spin_lock_irq(&port->readbuf_list_lock);
+	list_for_each_entry_safe(buf, buf2, &port->readbuf_head, list) {
+		list_del(&buf->list);
+		kfree(buf->buf);
+		kfree(buf);
+	}
+	spin_unlock_irq(&port->readbuf_list_lock);
+
+	kfree(port);
+	return 0;
+}
+
 /* Any private messages that the Host and Guest want to share */
 static void handle_control_message(struct port *port, struct port_buffer *buf)
 {
@@ -888,6 +925,30 @@ static void handle_control_message(struct port *port, struct port_buffer *buf)
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
+		remove_port_data(port);
+		break;
 	}
 }
 
@@ -1152,10 +1213,6 @@ fail:
 	return err;
 }
 
-static struct file_operations portdev_fops = {
-	.owner = THIS_MODULE,
-};
-
 /*
  * The workhandler for config-space updates
  *
@@ -1200,6 +1257,10 @@ static void config_work_handler(struct work_struct *work)
 	}
 }
 
+static struct file_operations portdev_fops = {
+	.owner = THIS_MODULE,
+};
+
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
diff --git a/include/linux/virtio_console.h b/include/linux/virtio_console.h
index 70924a1..4941c91 100644
--- a/include/linux/virtio_console.h
+++ b/include/linux/virtio_console.h
@@ -41,6 +41,7 @@ struct virtio_console_control {
 #define VIRTIO_CONSOLE_THROTTLE_PORT	5
 #define VIRTIO_CONSOLE_BUFFER_LIMIT	6
 #define VIRTIO_CONSOLE_CACHE_BUFFERS	7
+#define VIRTIO_CONSOLE_PORT_REMOVE	8
 
 /*
  * This struct is put at the start of each buffer that gets passed to
-- 
1.6.2.5
