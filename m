From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 22/31] virtio: console: Associate each port with a char device
Date: Fri, 29 Jan 2010 19:12:41 +0530
Message-ID: <1264772563-25517-5-git-send-email-amit.shah@redhat.com>
References: <1264772563-25517-1-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-2-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-3-git-send-email-amit.shah@redhat.com>
	<1264772563-25517-4-git-send-email-amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1264772563-25517-4-git-send-email-amit.shah@redhat.com>
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

The char device will be used as an interface by applications on the
guest to communicate with apps on the host.

The devices created are placed in /dev/vportNpn where N is the
virtio-console device number and n is the port number for that device.

One dynamic major device number is allocated for each device and minor
numbers are allocated for the ports contained within that device.

The file operation for the char devs will be added in the following
commits.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/Kconfig          |    8 ++++
 drivers/char/virtio_console.c |   77 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index 31be3ac..bcedee1 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -666,6 +666,14 @@ config VIRTIO_CONSOLE
 	help
 	  Virtio console for use with lguest and other hypervisors.
 
+	  Also serves as a general-purpose serial device for data
+	  transfer between the guest and host.  Character devices at
+	  /dev/vportNpn will be created when corresponding ports are
+	  found, where N is the device number and n is the port number
+	  within that device.  If specified by the host, a sysfs
+	  attribute called 'name' will be populated with a name for
+	  the port which can be used by udev scripts to create a
+	  symlink to the device.
 
 config HVCS
 	tristate "IBM Hypervisor Virtual Console Server support"
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 5f61021..6aa400e 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -16,6 +16,8 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
+#include <linux/cdev.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/list.h>
@@ -34,6 +36,12 @@
  * across multiple devices and multiple ports per device.
  */
 struct ports_driver_data {
+	/* Used for registering chardevs */
+	struct class *class;
+
+	/* Number of devices this driver is handling */
+	unsigned int index;
+
 	/*
 	 * This is used to keep track of the number of hvc consoles
 	 * spawned by this driver.  This number is given as the first
@@ -119,6 +127,12 @@ struct ports_device {
 
 	/* The control messages to the Host are sent via this buffer */
 	struct port_buffer *outbuf;
+
+	/* Used for numbering devices for sysfs and debugfs */
+	unsigned int drv_index;
+
+	/* Major number for this device.  Ports will be created as minors. */
+	int chr_major;
 };
 
 /* This struct holds the per-port data */
@@ -148,6 +162,10 @@ struct port {
 	 */
 	struct console cons;
 
+	/* Each port associates with a separate char device */
+	struct cdev cdev;
+	struct device *dev;
+
 	/* The 'id' to identify the port with the Host */
 	u32 id;
 };
@@ -398,7 +416,7 @@ static ssize_t fill_readbuf(struct port *port, char *out_buf, size_t out_count,
 		port->inbuf = NULL;
 
 		if (add_inbuf(port->in_vq, buf) < 0)
-			dev_warn(&port->portdev->vdev->dev, "failed add_buf\n");
+			dev_warn(port->dev, "failed add_buf\n");
 
 		spin_unlock_irqrestore(&port->inbuf_lock, flags);
 	}
@@ -671,6 +689,7 @@ static int add_port(struct ports_device *portdev, u32 id)
 {
 	struct port *port;
 	struct port_buffer *inbuf;
+	dev_t devt;
 	int err;
 
 	port = kmalloc(sizeof(*port), GFP_KERNEL);
@@ -688,12 +707,32 @@ static int add_port(struct ports_device *portdev, u32 id)
 	port->in_vq = portdev->in_vqs[port->id];
 	port->out_vq = portdev->out_vqs[port->id];
 
+	cdev_init(&port->cdev, NULL);
+
+	devt = MKDEV(portdev->chr_major, id);
+	err = cdev_add(&port->cdev, devt, 1);
+	if (err < 0) {
+		dev_err(&port->portdev->vdev->dev,
+			"Error %d adding cdev for port %u\n", err, id);
+		goto free_port;
+	}
+	port->dev = device_create(pdrvdata.class, &port->portdev->vdev->dev,
+				  devt, port, "vport%up%u",
+				  port->portdev->drv_index, id);
+	if (IS_ERR(port->dev)) {
+		err = PTR_ERR(port->dev);
+		dev_err(&port->portdev->vdev->dev,
+			"Error %d creating device for port %u\n",
+			err, id);
+		goto free_cdev;
+	}
+
 	spin_lock_init(&port->inbuf_lock);
 
 	inbuf = alloc_buf(PAGE_SIZE);
 	if (!inbuf) {
 		err = -ENOMEM;
-		goto free_port;
+		goto free_device;
 	}
 
 	/* Register the input buffer the first time. */
@@ -723,6 +762,10 @@ static int add_port(struct ports_device *portdev, u32 id)
 
 free_inbuf:
 	free_buf(inbuf);
+free_device:
+	device_destroy(pdrvdata.class, port->dev->devt);
+free_cdev:
+	cdev_del(&port->cdev);
 free_port:
 	kfree(port);
 fail:
@@ -835,6 +878,10 @@ fail:
 	return err;
 }
 
+static const struct file_operations portdev_fops = {
+	.owner = THIS_MODULE,
+};
+
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
@@ -860,6 +907,20 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	portdev->vdev = vdev;
 	vdev->priv = portdev;
 
+	spin_lock_irq(&pdrvdata_lock);
+	portdev->drv_index = pdrvdata.index++;
+	spin_unlock_irq(&pdrvdata_lock);
+
+	portdev->chr_major = register_chrdev(0, "virtio-portsdev",
+					     &portdev_fops);
+	if (portdev->chr_major < 0) {
+		dev_err(&vdev->dev,
+			"Error %d registering chrdev for device %u\n",
+			portdev->chr_major, portdev->drv_index);
+		err = portdev->chr_major;
+		goto free;
+	}
+
 	multiport = false;
 	portdev->config.nr_ports = 1;
 	portdev->config.max_nr_ports = 1;
@@ -892,7 +953,7 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	err = init_vqs(portdev);
 	if (err < 0) {
 		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
-		goto free;
+		goto free_chrdev;
 	}
 
 	spin_lock_init(&portdev->ports_lock);
@@ -922,6 +983,8 @@ free_vqs:
 	vdev->config->del_vqs(vdev);
 	kfree(portdev->in_vqs);
 	kfree(portdev->out_vqs);
+free_chrdev:
+	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 free:
 	kfree(portdev);
 fail:
@@ -950,6 +1013,14 @@ static struct virtio_driver virtio_console = {
 
 static int __init init(void)
 {
+	int err;
+
+	pdrvdata.class = class_create(THIS_MODULE, "virtio-ports");
+	if (IS_ERR(pdrvdata.class)) {
+		err = PTR_ERR(pdrvdata.class);
+		pr_err("Error %d creating virtio-ports class\n", err);
+		return err;
+	}
 	INIT_LIST_HEAD(&pdrvdata.consoles);
 
 	return register_virtio_driver(&virtio_console);
-- 
1.6.2.5
