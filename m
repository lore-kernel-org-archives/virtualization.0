From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC 6/11] virtio_pci: move old defines to legacy,
	introduce new structure.
Date: Thu, 08 Dec 2011 21:05:54 +1030
Message-ID: <8739cvgxkl.fsf@rustcorp.com.au>
References: <87pqfzgy6p.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87pqfzgy6p.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization <virtualization@lists.linux-foundation.org>
Cc: Sasha Levin <levinsasha928@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

We don't *remove* the old ones, unless VIRTIO_PCI_NO_LEGACY is defined,
but they get a friendly #warning about the change.

Note that config option is not promted; we always enable it for now.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/Kconfig             |   12 +++++++
 drivers/virtio/Makefile            |    2 -
 drivers/virtio/virtio_pci_legacy.c |   16 ++++-----
 include/linux/virtio_pci.h         |   63 ++++++++++++++++++++++++-------------
 4 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -25,6 +25,18 @@ config VIRTIO_PCI
 
 	  If unsure, say M.
 
+config VIRTIO_PCI_LEGACY
+	bool
+	default y
+	depends on VIRTIO_PCI
+	---help---
+	  The old BAR0 virtio pci layout was deprecated early 2012.
+
+	  So look out into your driveway.  Do you have a flying car?  If
+	  so, you can happily disable this option and virtio will not
+	  break.  Otherwise, leave it set.  Unless you're testing what
+	  life will be like in The Future.
+
 config VIRTIO_BALLOON
 	tristate "Virtio balloon driver (EXPERIMENTAL)"
 	select VIRTIO
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_VIRTIO) += virtio.o
 obj-$(CONFIG_VIRTIO_RING) += virtio_ring.o
 obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
-obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
+obj-$(CONFIG_VIRTIO_PCI_LEGACY) += virtio_pci_legacy.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio_balloon.o
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci_legacy.c
rename from drivers/virtio/virtio_pci.c
rename to drivers/virtio/virtio_pci_legacy.c
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -1,5 +1,5 @@
 /*
- * Virtio PCI driver
+ * Virtio PCI driver (legacy mode)
  *
  * This module allows virtio devices to be used over a virtual PCI device.
  * This can be used with QEMU based VMMs like KVM or Xen.
@@ -27,7 +27,7 @@
 #include <linux/spinlock.h>
 
 MODULE_AUTHOR("Anthony Liguori <aliguori@us.ibm.com>");
-MODULE_DESCRIPTION("virtio-pci");
+MODULE_DESCRIPTION("virtio-pci-legacy");
 MODULE_LICENSE("GPL");
 MODULE_VERSION("1");
 
@@ -629,7 +629,7 @@ static int __devinit virtio_pci_probe(st
 		return -ENODEV;
 
 	if (pci_dev->revision != VIRTIO_PCI_ABI_VERSION) {
-		printk(KERN_ERR "virtio_pci: expected ABI version %d, got %d\n",
+		printk(KERN_ERR "virtio_pci_legacy: expected ABI version %d, got %d\n",
 		       VIRTIO_PCI_ABI_VERSION, pci_dev->revision);
 		return -ENODEV;
 	}
@@ -654,7 +654,7 @@ static int __devinit virtio_pci_probe(st
 	if (err)
 		goto out;
 
-	err = pci_request_regions(pci_dev, "virtio-pci");
+	err = pci_request_regions(pci_dev, "virtio-pci-legacy");
 	if (err)
 		goto out_enable_device;
 
@@ -721,8 +721,8 @@ static int virtio_pci_resume(struct pci_
 }
 #endif
 
-static struct pci_driver virtio_pci_driver = {
-	.name		= "virtio-pci",
+static struct pci_driver virtio_pci_driver_legacy = {
+	.name		= "virtio-pci-legacy",
 	.id_table	= virtio_pci_id_table,
 	.probe		= virtio_pci_probe,
 	.remove		= __devexit_p(virtio_pci_remove),
@@ -734,14 +734,14 @@ static struct pci_driver virtio_pci_driv
 
 static int __init virtio_pci_init(void)
 {
-	return pci_register_driver(&virtio_pci_driver);
+	return pci_register_driver(&virtio_pci_driver_legacy);
 }
 
 module_init(virtio_pci_init);
 
 static void __exit virtio_pci_exit(void)
 {
-	pci_unregister_driver(&virtio_pci_driver);
+	pci_unregister_driver(&virtio_pci_driver_legacy);
 }
 
 module_exit(virtio_pci_exit);
diff --git a/include/linux/virtio_pci.h b/include/linux/virtio_pci.h
--- a/include/linux/virtio_pci.h
+++ b/include/linux/virtio_pci.h
@@ -42,56 +42,75 @@
 #include <linux/virtio_config.h>
 
 /* A 32-bit r/o bitmask of the features supported by the host */
-#define VIRTIO_PCI_HOST_FEATURES	0
+#define VIRTIO_PCI_LEGACY_HOST_FEATURES		0
 
 /* A 32-bit r/w bitmask of features activated by the guest */
-#define VIRTIO_PCI_GUEST_FEATURES	4
+#define VIRTIO_PCI_LEGACY_GUEST_FEATURES	4
 
 /* A 32-bit r/w PFN for the currently selected queue */
-#define VIRTIO_PCI_QUEUE_PFN		8
+#define VIRTIO_PCI_LEGACY_QUEUE_PFN		8
 
 /* A 16-bit r/o queue size for the currently selected queue */
-#define VIRTIO_PCI_QUEUE_NUM		12
+#define VIRTIO_PCI_LEGACY_QUEUE_NUM		12
 
 /* A 16-bit r/w queue selector */
-#define VIRTIO_PCI_QUEUE_SEL		14
+#define VIRTIO_PCI_LEGACY_QUEUE_SEL		14
 
 /* A 16-bit r/w queue notifier */
-#define VIRTIO_PCI_QUEUE_NOTIFY		16
+#define VIRTIO_PCI_LEGACY_QUEUE_NOTIFY		16
 
 /* An 8-bit device status register.  */
-#define VIRTIO_PCI_STATUS		18
+#define VIRTIO_PCI_LEGACY_STATUS		18
 
 /* An 8-bit r/o interrupt status register.  Reading the value will return the
  * current contents of the ISR and will also clear it.  This is effectively
  * a read-and-acknowledge. */
-#define VIRTIO_PCI_ISR			19
-
-/* The bit of the ISR which indicates a device configuration change. */
-#define VIRTIO_PCI_ISR_CONFIG		0x2
+#define VIRTIO_PCI_LEGACY_ISR			19
 
 /* MSI-X registers: only enabled if MSI-X is enabled. */
 /* A 16-bit vector for configuration changes. */
-#define VIRTIO_MSI_CONFIG_VECTOR        20
+#define VIRTIO_MSI_LEGACY_CONFIG_VECTOR        20
 /* A 16-bit vector for selected queue notifications. */
-#define VIRTIO_MSI_QUEUE_VECTOR         22
-/* Vector value used to disable MSI for queue */
-#define VIRTIO_MSI_NO_VECTOR            0xffff
+#define VIRTIO_MSI_LEGACY_QUEUE_VECTOR         22
 
 /* The remaining space is defined by each driver as the per-driver
  * configuration space */
-#define VIRTIO_PCI_CONFIG(dev)		((dev)->msix_enabled ? 24 : 20)
+#define VIRTIO_PCI_LEGACY_CONFIG(dev)		((dev)->msix_enabled ? 24 : 20)
+
+/* How many bits to shift physical queue address written to QUEUE_PFN.
+ * 12 is historical, and due to x86 page size. */
+#define VIRTIO_PCI_LEGACY_QUEUE_ADDR_SHIFT	12
+
+/* The alignment to use between consumer and producer parts of vring.
+ * x86 pagesize again. */
+#define VIRTIO_PCI_LEGACY_VRING_ALIGN		4096
+
+#ifndef VIRTIO_PCI_NO_LEGACY
+/* Don't break compile of old userspace code.  These will go away. */
+#warning "Please support virtio_pci non-legacy mode!"
+#define VIRTIO_PCI_HOST_FEATURES VIRTIO_PCI_LEGACY_HOST_FEATURES
+#define VIRTIO_PCI_GUEST_FEATURES VIRTIO_PCI_LEGACY_GUEST_FEATURES
+#define VIRTIO_PCI_QUEUE_PFN VIRTIO_PCI_LEGACY_QUEUE_PFN
+#define VIRTIO_PCI_QUEUE_NUM VIRTIO_PCI_LEGACY_QUEUE_NUM
+#define VIRTIO_PCI_QUEUE_SEL VIRTIO_PCI_LEGACY_QUEUE_SEL
+#define VIRTIO_PCI_QUEUE_NOTIFY VIRTIO_PCI_LEGACY_QUEUE_NOTIFY
+#define VIRTIO_PCI_STATUS VIRTIO_PCI_LEGACY_STATUS
+#define VIRTIO_PCI_ISR VIRTIO_PCI_LEGACY_ISR
+#define VIRTIO_MSI_CONFIG_VECTOR VIRTIO_MSI_LEGACY_CONFIG_VECTOR
+#define VIRTIO_MSI_QUEUE_VECTOR VIRTIO_MSI_LEGACY_QUEUE_VECTOR
+#define VIRTIO_PCI_CONFIG(dev) VIRTIO_PCI_LEGACY_CONFIG(dev)
+#define VIRTIO_PCI_QUEUE_ADDR_SHIFT VIRTIO_PCI_LEGACY_QUEUE_ADDR_SHIFT
+#define VIRTIO_PCI_VRING_ALIGN VIRTIO_PCI_LEGACY_VRING_ALIGN
+#endif /* ...!KERNEL */
 
 /* Virtio ABI version, this must match exactly */
 #define VIRTIO_PCI_ABI_VERSION		0
 
-/* How many bits to shift physical queue address written to QUEUE_PFN.
- * 12 is historical, and due to x86 page size. */
-#define VIRTIO_PCI_QUEUE_ADDR_SHIFT	12
+/* Vector value used to disable MSI for queue */
+#define VIRTIO_MSI_NO_VECTOR            0xffff
 
-/* The alignment to use between consumer and producer parts of vring.
- * x86 pagesize again. */
-#define VIRTIO_PCI_VRING_ALIGN		4096
+/* The bit of the ISR which indicates a device configuration change. */
+#define VIRTIO_PCI_ISR_CONFIG		0x2
 
 /* IDs for different capabilities.  Must all exist. */
 /* FIXME: Do we win from separating ISR, NOTIFY and COMMON? */
