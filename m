From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 12/15] virtio_console: Add debugfs files for each port to
	expose debug info
Date: Tue, 10 Nov 2009 15:11:38 +0530
Message-ID: <1257846101-23258-13-git-send-email-amit.shah@redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1257846101-23258-12-git-send-email-amit.shah@redhat.com>
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

This is helpful in examining ports' state.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   64 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 63 insertions(+), 1 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 8c9bac8..f7db92a 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -28,6 +28,7 @@
  */
 
 #include <linux/cdev.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/fs.h>
@@ -70,6 +71,9 @@ struct virtio_console_struct {
 
 	struct class *class;
 
+	/* Used for exporting per-port information to debugfs */
+	struct dentry *debugfs_dir;
+
 	/*
 	 * This is used to keep track of the number of hvc consoles
 	 * spawned.  This number is given as first argument to
@@ -103,6 +107,9 @@ struct virtio_console_port {
 	/* Pointer to the virtio_console device */
 	struct virtio_console_struct *vcon;
 
+	/* File in the debugfs directory that exposes this port's information */
+	struct dentry *debugfs_file;
+
 	/* Buffer management */
 	struct list_head readbuf_head;
 
@@ -935,10 +942,53 @@ static struct attribute_group virtcon_attribute_group = {
 	.attrs = virtcon_sysfs_entries,
 };
 
+static int virtcon_port_debugfs_open(struct inode *inode, struct file *filp)
+{
+	filp->private_data = inode->i_private;
+	return 0;
+}
+
+static ssize_t virtcon_port_debugfs_read(struct file *filp, char __user *ubuf,
+					 size_t count, loff_t *offp)
+{
+	struct virtio_console_port *port;
+	char *buf;
+	ssize_t ret, out_offset, out_count;
+
+	out_count = 1024;
+	buf = kmalloc(out_count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	port = filp->private_data;
+	out_offset = 0;
+	out_offset += snprintf(buf + out_offset, out_count,
+			       "name: %s\n", port->name);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "guest_connected: %d\n", port->guest_connected);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "host_connected: %d\n", port->host_connected);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "is_console: %d\n", port->hvc ? 1 : 0);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "console_vtermno: %u\n", port->vtermno);
+
+	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
+	kfree(buf);
+	return ret;
+}
+
+static const struct file_operations virtcon_port_debugfs = {
+	.owner = THIS_MODULE,
+	.open  = virtcon_port_debugfs_open,
+	.read  = virtcon_port_debugfs_read,
+};
+
 static int virtconsole_add_port(u32 port_nr)
 {
 	struct virtio_console_port *port;
 	struct virtio_console_control cpkt;
+	char debugfs_name[8];
 	dev_t devt;
 	int ret;
 
@@ -983,7 +1033,6 @@ static int virtconsole_add_port(u32 port_nr)
 		if (ret)
 			goto free_cdev;
 	}
-
 	spin_lock_init(&port->readbuf_list_lock);
 	INIT_LIST_HEAD(&port->readbuf_head);
 	init_waitqueue_head(&port->waitqueue);
@@ -995,6 +1044,15 @@ static int virtconsole_add_port(u32 port_nr)
 	send_buf(port, (char *)&cpkt, sizeof(cpkt),
 		 VIRTIO_CONSOLE_ID_CONTROL, false);
 
+	/*
+	 * Finally, create the debugfs file that we can use to inspect
+	 * a port's state at any time
+	 */
+	sprintf(debugfs_name, "vcon%u", port->id);
+	port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
+						 port->vcon->debugfs_dir, port,
+						 &virtcon_port_debugfs);
+
 	return 0;
 free_cdev:
 	cdev_del(&port->cdev);
@@ -1163,6 +1221,10 @@ static int __init init(void)
 		class_destroy(virtconsole.class);
 		return ret;
 	}
+	virtconsole.debugfs_dir = debugfs_create_dir("virtio-console", NULL);
+	if (!virtconsole.debugfs_dir)
+		pr_debug("virtio-console: Couldn't create debugfs dir, ret = %ld\n",
+			 PTR_ERR(virtconsole.debugfs_dir));
 	return 0;
 }
 module_init(init);
-- 
1.6.2.5
