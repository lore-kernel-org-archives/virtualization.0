From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 30/31] virtio: console: Add debugfs files for each port to
	expose debug info
Date: Wed, 20 Jan 2010 14:21:05 +0530
Message-ID: <1263977465-13983-4-git-send-email-amit.shah@redhat.com>
References: <201001201850.56114.rusty@rustcorp.com.au>
	<1263977465-13983-1-git-send-email-amit.shah@redhat.com>
	<1263977465-13983-2-git-send-email-amit.shah@redhat.com>
	<1263977465-13983-3-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1263977465-13983-3-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c |   71 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1b5fa5c..f337f9f 100644
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
 
@@ -164,6 +168,9 @@ struct port {
 	/* The IO vqs for this port */
 	struct virtqueue *in_vq, *out_vq;
 
+	/* File in the debugfs directory that exposes this port's information */
+	struct dentry *debugfs_file;
+
 	/*
 	 * The entries in this struct will be valid if this port is
 	 * hooked up to an hvc console
@@ -798,6 +805,49 @@ static struct attribute_group port_attribute_group = {
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
+			       "name: %s\n", port->name ? port->name : "");
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "guest_connected: %d\n", port->guest_connected);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "host_connected: %d\n", port->host_connected);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "is_console: %s\n",
+			       is_console_port(port) ? "yes" : "no");
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
 /* Remove all port-specific data. */
 static int remove_port(struct port *port)
 {
@@ -825,6 +875,8 @@ static int remove_port(struct port *port)
 	free_buf(port->outbuf);
 	kfree(port->name);
 
+	debugfs_remove(port->debugfs_file);
+
 	kfree(port);
 	return 0;
 }
@@ -1037,6 +1089,7 @@ static void fill_queue(struct virtqueue *vq, spinlock_t *lock)
 
 static int add_port(struct ports_device *portdev, u32 id)
 {
+	char debugfs_name[16];
 	struct port *port;
 	struct port_buffer *inbuf;
 	dev_t devt;
@@ -1117,6 +1170,18 @@ static int add_port(struct ports_device *portdev, u32 id)
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
 
 free_outbuf:
@@ -1439,6 +1504,12 @@ static int __init init(void)
 		pr_err("Error %d creating virtio-ports class\n", err);
 		return err;
 	}
+
+	pdrvdata.debugfs_dir = debugfs_create_dir("virtio-ports", NULL);
+	if (!pdrvdata.debugfs_dir) {
+		pr_warning("Error %ld creating debugfs dir for virtio-ports\n",
+			   PTR_ERR(pdrvdata.debugfs_dir));
+	}
 	INIT_LIST_HEAD(&pdrvdata.consoles);
 
 	return register_virtio_driver(&virtio_console);
-- 
1.6.2.5
