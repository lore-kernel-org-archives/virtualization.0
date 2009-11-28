From: Amit Shah <amit.shah@redhat.com>
Subject: [PATCH 18/28] virtio: console: Associate each port with a char device
Date: Sat, 28 Nov 2009 12:20:41 +0530
Message-ID: <1259391051-7752-19-git-send-email-amit.shah@redhat.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1259391051-7752-18-git-send-email-amit.shah@redhat.com>
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

The file operation for the char devs will be added in the following
commits.

Signed-off-by: Amit Shah <amit.shah@redhat.com>
---
 drivers/char/virtio_console.c |   76 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index a26781b..56b7cfa 100644
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
@@ -100,6 +108,12 @@ struct ports_device {
 
 	/* The current config space is stored here */
 	struct virtio_console_config config;
+
+	/* Used for numbering devices for sysfs and debugfs */
+	unsigned int drv_index;
+
+	/* Major number for this device. Ports will be created as minors. */
+	int chr_major;
 };
 
 /* This struct holds individual buffers received for each port */
@@ -132,6 +146,10 @@ struct port {
 	 */
 	spinlock_t readbuf_list_lock;
 
+	/* Each port associates with a separate char device */
+	struct cdev cdev;
+	struct device *dev;
+
 	/*
 	 * The entries in this struct will be valid if this port is
 	 * hooked up to an hvc console
@@ -703,6 +721,7 @@ static void tx_intr(struct virtqueue *vq)
 static int __devinit add_port(struct ports_device *portdev, u32 id)
 {
 	struct port *port;
+	dev_t devt;
 	int err;
 
 	err = -ENOMEM;
@@ -713,6 +732,25 @@ static int __devinit add_port(struct ports_device *portdev, u32 id)
 	port->portdev = portdev;
 	port->id = id;
 
+	cdev_init(&port->cdev, NULL);
+
+	devt = MKDEV(portdev->chr_major, id);
+	err = cdev_add(&port->cdev, devt, 1);
+	if (err < 0) {
+		dev_err(&port->portdev->vdev->dev,
+			"error %d adding cdev for port %u\n", err, id);
+		goto free_port;
+	}
+	port->dev = device_create(pdrvdata.class, &port->portdev->vdev->dev,
+				  devt, port, "vport%up%u",
+				  port->portdev->drv_index, id);
+	if (IS_ERR(port->dev)) {
+		err = PTR_ERR(port->dev);
+		dev_err(&port->portdev->vdev->dev,
+			"error %d creating device for port %u\n",
+			err, id);
+		goto free_cdev;
+	}
 	spin_lock_init(&port->readbuf_list_lock);
 	INIT_LIST_HEAD(&port->readbuf_head);
 
@@ -722,7 +760,7 @@ static int __devinit add_port(struct ports_device *portdev, u32 id)
 	if (!use_multiport(port->portdev)) {
 		err = init_port_console(port);
 		if (err)
-			goto free;
+			goto free_device;
 	}
 	spin_lock_irq(&portdev->ports_list_lock);
 	list_add_tail(&port->list, &port->portdev->ports_head);
@@ -737,12 +775,21 @@ static int __devinit add_port(struct ports_device *portdev, u32 id)
 	send_control_msg(port, VIRTIO_CONSOLE_PORT_READY, 1);
 
 	return 0;
-free:
+
+free_device:
+	device_destroy(pdrvdata.class, port->dev->devt);
+free_cdev:
+	cdev_del(&port->cdev);
+free_port:
 	kfree(port);
 fail:
 	return err;
 }
 
+static struct file_operations portdev_fops = {
+	.owner = THIS_MODULE,
+};
+
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
@@ -770,6 +817,18 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
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
+			"error %d registering chrdev for device %u\n",
+			portdev->chr_major, portdev->drv_index);
+		goto free;
+	}
 	multiport = false;
 	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT)) {
 		multiport = true;
@@ -785,7 +844,7 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	/* Find the queues. */
 	err = vdev->config->find_vqs(vdev, 2, vqs, callbacks, names);
 	if (err)
-		goto free;
+		goto free_chrdev;
 
 	portdev->in_vq = vqs[0];
 	portdev->out_vq = vqs[1];
@@ -812,6 +871,8 @@ static int __devinit virtcons_probe(struct virtio_device *vdev)
 	early_put_chars = NULL;
 	return 0;
 
+free_chrdev:
+	unregister_chrdev(portdev->chr_major, "virtio-portsdev");
 free:
 	kfree(portdev);
 fail:
@@ -840,7 +901,16 @@ static struct virtio_driver virtio_console = {
 
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
+
 	return register_virtio_driver(&virtio_console);
 }
 module_init(init);
-- 
1.6.2.5
