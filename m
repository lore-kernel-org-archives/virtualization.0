From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 23/31] virtio: console: Associate each port with a char device
Date: Tue, 22 Dec 2009 20:04:33 +0530
Message-ID: <1261492481-19817-24-git-send-email-amit.shah@redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1261492481-19817-23-git-send-email-amit.shah@redhat.com>
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
 drivers/char/virtio_console.c |   78 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 3 deletions(-)

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
index 2f5ef29..721ad2f 100644
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
@@ -151,6 +165,10 @@ struct port {
 	 */
 	struct console cons;
 
+	/* Each port associates with a separate char device */
+	struct cdev cdev;
+	struct device *dev;
+
 	/* The 'id' to identify the port with the Host */
 	u32 id;
 };
@@ -710,6 +728,7 @@ static void fill_queue(struct virtqueue *vq, spinlock_t *lock)
 static int add_port(struct ports_device *portdev, u32 id)
 {
 	struct port *port;
+	dev_t devt;
 	int err;
 
 	port = kmalloc(sizeof(*port), GFP_KERNEL);
@@ -727,6 +746,26 @@ static int add_port(struct ports_device *portdev, u32 id)
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
 
 	/*
@@ -735,14 +774,14 @@ static int add_port(struct ports_device *portdev, u32 id)
 	if (!use_multiport(port->portdev)) {
 		err = init_port_console(port);
 		if (err)
-			goto free_port;
+			goto free_device;
 	}
 
 	fill_queue(port->in_vq, &port->inbuf_lock);
 	port->outbuf = alloc_buf(PAGE_SIZE);
 	if (!port->outbuf) {
 		err = -ENOMEM;
-		goto free_port;
+		goto free_device;
 	}
 	spin_lock_irq(&portdev->ports_lock);
 	list_add_tail(&port->list, &port->portdev->ports);
@@ -757,6 +796,10 @@ static int add_port(struct ports_device *portdev, u32 id)
 
 	return 0;
 
+free_device:
+	device_destroy(pdrvdata.class, port->dev->devt);
+free_cdev:
+	cdev_del(&port->cdev);
 free_port:
 	kfree(port);
 fail:
@@ -869,6 +912,10 @@ fail:
 	return err;
 }
 
+static const struct file_operations portdev_fops = {
+	.owner = THIS_MODULE,
+};
+
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
@@ -894,6 +941,20 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
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
 	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
 		multiport = true;
@@ -927,7 +988,7 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	err = init_vqs(portdev);
 	if (err < 0) {
 		dev_err(&vdev->dev, "Error %d initializing vqs\n", err);
-		goto free;
+		goto free_chrdev;
 	}
 
 	spin_lock_init(&portdev->ports_lock);
@@ -957,6 +1018,8 @@ free_vqs:
 	vdev->config->del_vqs(vdev);
 	kfree(portdev->in_vqs);
 	kfree(portdev->out_vqs);
+free_chrdev:
+	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 free:
 	kfree(portdev);
 fail:
@@ -985,6 +1048,15 @@ static struct virtio_driver virtio_console = {
 
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
+
 	INIT_LIST_HEAD(&pdrvdata.consoles);
 	return register_virtio_driver(&virtio_console);
 }
-- 
1.6.2.5
