From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 28/28] virtio: console: Add debugfs files for each port to
	expose debug info
Date: Sat, 28 Nov 2009 12:20:51 +0530
Message-ID: <1259391051-7752-29-git-send-email-amit.shah@redhat.com>
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
	<1259391051-7752-28-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-28-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c |   78 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 78 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 8ed57c2..1ca9675 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -17,6 +17,7 @@
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 #include <linux/cdev.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/fs.h>
@@ -43,6 +44,9 @@ struct ports_driver_data {
 	/* Used for registering chardevs */
 	struct class *class;
 
+	/* Used for exporting per-port information to debugfs */
+	struct dentry *debugfs_dir;
+
 	/* Number of devices this driver is handling */
 	unsigned int index;
 
@@ -141,6 +145,9 @@ struct port {
 	/* Pointer to the parent virtio_console device */
 	struct ports_device *portdev;
 
+	/* File in the debugfs directory that exposes this port's information */
+	struct dentry *debugfs_file;
+
 	/* Buffer management */
 	struct list_head readbuf_head;
 
@@ -827,6 +834,7 @@ static int remove_port_data(struct port *port)
 		kfree(buf);
 	}
 	spin_unlock_irq(&port->readbuf_list_lock);
+	debugfs_remove(port->debugfs_file);
 
 	kfree(port);
 	return 0;
@@ -1142,9 +1150,62 @@ static struct attribute_group port_attribute_group = {
 	.attrs = port_sysfs_entries,
 };
 
+static int debugfs_open(struct inode *inode, struct file *filp)
+{
+	filp->private_data = inode->i_private;
+	return 0;
+}
+
+static ssize_t debugfs_read(struct file *filp, char __user *ubuf,
+			    size_t count, loff_t *offp)
+{
+	struct port *port;
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
+			       "guest_throttled: %d\n", port->guest_throttled);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "buffer_limit: %u\n", port->buffer_limit);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "nr_buffers: %u\n", port->nr_buffers);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "cache_buffers: %d\n", port->cache_buffers);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "host_connected: %d\n", port->host_connected);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "host_throttled: %d\n", port->host_throttled);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "is_console: %d\n", port->cons.hvc ? 1 : 0);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "console_vtermno: %u\n", port->cons.vtermno);
+
+	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
+	kfree(buf);
+	return ret;
+}
+
+static const struct file_operations port_debugfs_ops = {
+	.owner = THIS_MODULE,
+	.open  = debugfs_open,
+	.read  = debugfs_read,
+};
+
 static int add_port(struct ports_device *portdev, u32 id)
 {
 	struct port *port;
+	char debugfs_name[8];
 	dev_t devt;
 	int err;
 
@@ -1201,6 +1262,18 @@ static int add_port(struct ports_device *portdev, u32 id)
 	 */
 	send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
 
+	if (pdrvdata.debugfs_dir) {
+		/*
+		 * Finally, create the debugfs file that we can use to
+		 * inspect a port's state at any time
+		 */
+		sprintf(debugfs_name, "vport%up%u",
+			port->portdev->drv_index, id);
+		port->debugfs_file = debugfs_create_file(debugfs_name, 0444,
+							 pdrvdata.debugfs_dir,
+							 port,
+							 &port_debugfs_ops);
+	}
 	return 0;
 
 free_device:
@@ -1381,6 +1454,11 @@ static int __init init(void)
 		pr_err("Error %d creating virtio-ports class\n", err);
 		return err;
 	}
+	pdrvdata.debugfs_dir = debugfs_create_dir("virtio-ports", NULL);
+	if (!pdrvdata.debugfs_dir) {
+		pr_warning("Error %ld creating debugfs dir for virtio-ports\n",
+			   PTR_ERR(pdrvdata.debugfs_dir));
+	}
 	INIT_LIST_HEAD(&pdrvdata.consoles);
 
 	return register_virtio_driver(&virtio_console);
-- 
1.6.2.5
