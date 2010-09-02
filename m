From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 13/14] virtio: console: Add reference counting for port struct
Date: Thu,  2 Sep 2010 18:38:29 +0530
Message-ID: <12635d929246d77f0b221bff39ec1b0b3c04756a.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
In-Reply-To: <cover.1283430900.git.amit.shah@redhat.com>
References: <cover.1283430900.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Amit Shah <amit.shah@redhat.com>, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

When a port got hot-unplugged, when a port was open, any file operation
after the unplugging resulted in a crash. This is fixed by ref-counting
the port structure, and releasing it only when the file is closed.

This splits the unplug operation in two parts: first marks the port
as unavailable, removes all the buffers in the vqs and removes the port
from the per-device list of ports. The second stage, invoked when all
references drop to zero, releases the chardev and frees all other memory.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   80 ++++++++++++++++++++++++++++++++--------
 1 files changed, 64 insertions(+), 16 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 0c4dc26..1e00221 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -187,6 +187,9 @@ struct port {
 	struct cdev *cdev;
 	struct device *dev;
 
+	/* Reference-counting to handle port hot-unplugs and file operations */
+	struct kref kref;
+
 	/* A waitqueue for poll() or blocking read operations */
 	wait_queue_head_t waitqueue;
 
@@ -710,6 +713,8 @@ static unsigned int port_fops_poll(struct file *filp, poll_table *wait)
 	return ret;
 }
 
+static void remove_port(struct kref *kref);
+
 static int port_fops_release(struct inode *inode, struct file *filp)
 {
 	struct port *port;
@@ -730,6 +735,16 @@ static int port_fops_release(struct inode *inode, struct file *filp)
 	reclaim_consumed_buffers(port);
 	spin_unlock_irq(&port->outvq_lock);
 
+	/*
+	 * Locks aren't necessary here as a port can't be opened after
+	 * unplug, and if a port isn't unplugged, a kref would already
+	 * exist for the port.  Plus, taking ports_lock here would
+	 * create a dependency on other locks taken by functions
+	 * inside remove_port if we're the last holder of the port,
+	 * creating many problems.
+	 */
+	kref_put(&port->kref, remove_port);
+
 	return 0;
 }
 
@@ -742,6 +757,11 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 	port = find_port_by_devt(cdev->dev);
 	filp->private_data = port;
 
+	/* Prevent against a port getting hot-unplugged at the same time */
+	spin_lock_irq(&port->portdev->ports_lock);
+	kref_get(&port->kref);
+	spin_unlock_irq(&port->portdev->ports_lock);
+
 	/*
 	 * Don't allow opening of console port devices -- that's done
 	 * via /dev/hvc
@@ -776,6 +796,7 @@ static int port_fops_open(struct inode *inode, struct file *filp)
 
 	return 0;
 out:
+	kref_put(&port->kref, remove_port);
 	return ret;
 }
 
@@ -1064,6 +1085,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 		err = -ENOMEM;
 		goto fail;
 	}
+	kref_init(&port->kref);
 
 	port->portdev = portdev;
 	port->id = id;
@@ -1168,22 +1190,43 @@ fail:
 	return err;
 }
 
-/* Remove all port-specific data. */
-static void remove_port(struct port *port)
+/* No users remain, remove all port-specific data. */
+static void remove_port(struct kref *kref)
+{
+	struct port *port;
+
+	port = container_of(kref, struct port, kref);
+
+	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
+	device_destroy(pdrvdata.class, port->dev->devt);
+	cdev_del(port->cdev);
+
+	kfree(port->name);
+
+	debugfs_remove(port->debugfs_file);
+
+	kfree(port);
+}
+
+/*
+ * Port got unplugged.  Remove port from portdev's list and drop the
+ * kref reference.  If no userspace has this port opened, it will
+ * result in immediate removal the port.
+ */
+static void unplug_port(struct port *port)
 {
 	struct port_buffer *buf;
 
+	spin_lock_irq(&port->portdev->ports_lock);
+	list_del(&port->list);
+	spin_unlock_irq(&port->portdev->ports_lock);
+
 	if (port->guest_connected) {
 		port->guest_connected = false;
 		port->host_connected = false;
 		wake_up_interruptible(&port->waitqueue);
-		send_control_msg(port, VIRTIO_CONSOLE_PORT_OPEN, 0);
 	}
 
-	spin_lock_irq(&port->portdev->ports_lock);
-	list_del(&port->list);
-	spin_unlock_irq(&port->portdev->ports_lock);
-
 	if (is_console_port(port)) {
 		spin_lock_irq(&pdrvdata_lock);
 		list_del(&port->cons.list);
@@ -1201,9 +1244,6 @@ static void remove_port(struct port *port)
 		hvc_remove(port->cons.hvc);
 #endif
 	}
-	sysfs_remove_group(&port->dev->kobj, &port_attribute_group);
-	device_destroy(pdrvdata.class, port->dev->devt);
-	cdev_del(port->cdev);
 
 	/* Remove unused data this port might have received. */
 	discard_port_data(port);
@@ -1214,11 +1254,19 @@ static void remove_port(struct port *port)
 	while ((buf = virtqueue_detach_unused_buf(port->in_vq)))
 		free_buf(buf);
 
-	kfree(port->name);
-
-	debugfs_remove(port->debugfs_file);
+	/*
+	 * We should just assume the device itself has gone off --
+	 * else a close on an open port later will try to send out a
+	 * control message.
+	 */
+	port->portdev = NULL;
 
-	kfree(port);
+	/*
+	 * Locks around here are not necessary - a port can't be
+	 * opened after we removed the port struct from ports_list
+	 * above.
+	 */
+	kref_put(&port->kref, remove_port);
 }
 
 /* Any private messages that the Host and Guest want to share */
@@ -1257,7 +1305,7 @@ static void handle_control_message(struct ports_device *portdev,
 		add_port(portdev, cpkt->id);
 		break;
 	case VIRTIO_CONSOLE_PORT_REMOVE:
-		remove_port(port);
+		unplug_port(port);
 		break;
 	case VIRTIO_CONSOLE_CONSOLE_PORT:
 		if (!cpkt->value)
@@ -1671,7 +1719,7 @@ static void virtcons_remove(struct virtio_device *vdev)
 	cancel_work_sync(&portdev->control_work);
 
 	list_for_each_entry_safe(port, port2, &portdev->ports, list)
-		remove_port(port);
+		unplug_port(port);
 
 	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 
-- 
1.7.2.2
