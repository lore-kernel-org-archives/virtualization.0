From: Dor Laor <dor.laor@gmail.com>
Subject: [kvm-devel] [Virtio-for-kvm] [PATCH 12/13] [Mostly resend] virtio
 additions
Date: Fri, 21 Dec 2007 17:27:04 +0200
Message-ID: <476BDB48.80700__39765.554216183$1198250963$gmane$org@qumranet.com>
Reply-To: dor.laor@qumranet.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization <virtualization@lists.linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>Anthony Liguori <a>
List-Id: virtualization@lists.linuxfoundation.org

 From 20a01e0c24f47e9805a88bebc9310163f99b5e99 Mon Sep 17 00:00:00 2001
From: Dor Laor <dor.laor@qumranet.com>
Date: Sun, 16 Dec 2007 23:35:35 +0200
Subject: [PATCH] Handle module unload Add the device release function.

Signed-off-by: Dor Laor <dor.laor@qumranet.com>
---
 drivers/virtio/virtio.c     |    7 +++++++
 drivers/virtio/virtio_pci.c |    7 +++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 303cb6f..212f4e3 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -123,6 +123,11 @@ void unregister_virtio_driver(struct virtio_driver 
*driver)
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_driver);
 
+static void virtio_device_release(struct device *_d)
+{
+    pr_debug("%s\n" , __FUNCTION__);
+}
+
 int register_virtio_device(struct virtio_device *dev)
 {
     int err;
@@ -133,6 +138,8 @@ int register_virtio_device(struct virtio_device *dev)
     /* Acknowledge that we've seen the device. */
     add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 
+
+    dev->dev.release = virtio_device_release;
     /* device_register() causes the bus infrastructure to look for a
      * matching driver. */
     err = device_register(&dev->dev);
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 7118215..60f2b1f 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -72,12 +72,18 @@ static struct pci_device_id virtio_pci_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, virtio_pci_id_table);
 
+static void virtio_pci_root_release(struct device *d)
+{
+    pr_debug("%s\n", __FUNCTION__);
+}
+
 /* A PCI device has it's own struct device and so does a virtio device so
  * we create a place for the virtio devices to show up in sysfs.  I 
think it
  * would make more sense for virtio to not insist on having it's own 
device. */
 static struct device virtio_pci_root = {
     .parent        = NULL,
     .bus_id        = "virtio-pci",
+    .release    = virtio_pci_root_release,
 };
 
 /* Unique numbering for devices under the kvm root */
@@ -358,6 +364,7 @@ static void __devexit virtio_pci_remove(struct 
pci_dev *pci_dev)
     pci_iounmap(pci_dev, vp_dev->ioaddr);
     pci_release_regions(pci_dev);
     pci_disable_device(pci_dev);
+    unregister_virtio_device(&vp_dev->vdev);
     kfree(vp_dev);
 }
 
-- 
1.5.3.3
