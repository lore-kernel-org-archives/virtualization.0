From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 2/2] virtio: Introducing virtio_pci.no_mmio,
	the worst boot option in history.
Date: Wed, 11 Feb 2015 16:55:17 +1030
Message-ID: <1423635917-31282-3-git-send-email-rusty__15118.9327742488$1423636605$gmane$org@rustcorp.com.au>
References: <1423635917-31282-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1423635917-31282-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lkml <linux-kernel@vger.kernel.org>, lguest@lists.ozlabs.org, virtualization@lists.linux-foundation.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Sometimes, devices are just too damn fast.  Wouldn't it be nice if we
could (1) have an option to access them in the most baroque way
possible, and (2) ensure that even the normal case caused extra bloat?

Well, wish no longer: This patch does exactly that!  Since every
complaint virtio 1.0 device has to have a capability to allow backdoor
access into the BARs, we can use that:

	4.1.4.7.1 Device Requirements: PCI configuration access capability

	The device MUST present at least one VIRTIO_PCI_CAP_PCI_CFG
	capability.

	Upon detecting driver write access to pci_cfg_data, the device
	MUST execute a write access at offset cap.offset at BAR
	selected by cap.bar using the first cap.length bytes from
	pci_cfg_data.

	Upon detecting driver read access to pci_cfg_data, the device
	MUST execute a read access of length cap.length at offset
	cap.offset at BAR selected by cap.bar and store the first
	cap.length bytes in pci_cfg_data.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci_common.c |  31 ++++++-
 drivers/virtio/virtio_pci_common.h |  21 +++++
 drivers/virtio/virtio_pci_legacy.c |   1 +
 drivers/virtio/virtio_pci_modern.c | 183 ++++++++++++++++++++++++++++++++++---
 4 files changed, 221 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 4e6132dd0ca3..0030180411cc 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -29,45 +29,68 @@ MODULE_PARM_DESC(force_legacy,
 
 u8 vp_read_isr(const struct virtio_pci_device *dev)
 {
+	if (dev->no_mmio)
+		return dev->no_mmio->read8(dev, dev->isr, 0);
 	return ioread8(dev->isr);
 }
 
 void vp_write_notify(const struct virtqueue *vq, u16 vqindex)
 {
-	iowrite16(vqindex, (void __iomem *)vq->priv);
+	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
+
+	if (vp_dev->no_mmio)
+		vp_dev->no_mmio->write16(vp_dev, (void __iomem *)vq->priv,
+					 0, vqindex);
+	else
+		iowrite16(vqindex, (void __iomem *)vq->priv);
 }
 
 u32 __vp_read_common32(const struct virtio_pci_device *dev, size_t offset)
 {
+	if (dev->no_mmio)
+		return dev->no_mmio->read32(dev, dev->common, offset);
 	return ioread32((void __iomem *)dev->common + offset);
 }
 
 u16 __vp_read_common16(const struct virtio_pci_device *dev, size_t offset)
 {
+	if (dev->no_mmio)
+		return dev->no_mmio->read16(dev, dev->common, offset);
 	return ioread16((void __iomem *)dev->common + offset);
 }
 
 u8 __vp_read_common8(const struct virtio_pci_device *dev, size_t offset)
 {
+	if (dev->no_mmio)
+		return dev->no_mmio->read8(dev, dev->common, offset);
 	return ioread8((void __iomem *)dev->common + offset);
 }
 
 void __vp_write_common32(const struct virtio_pci_device *dev,
 			 size_t offset, u32 val)
 {
-	iowrite32(val, (void __iomem *)dev->common + offset);
+	if (dev->no_mmio)
+		dev->no_mmio->write32(dev, dev->common, offset, val);
+	else
+		iowrite32(val, (void __iomem *)dev->common + offset);
 }
 
 void __vp_write_common16(const struct virtio_pci_device *dev,
 			 size_t offset, u16 val)
 {
-	iowrite16(val, (void __iomem *)dev->common + offset);
+	if (dev->no_mmio)
+		dev->no_mmio->write16(dev, dev->common, offset, val);
+	else
+		iowrite16(val, (void __iomem *)dev->common + offset);
 }
 
 void __vp_write_common8(const struct virtio_pci_device *dev,
 			size_t offset, u8 val)
 {
-	iowrite8(val, (void __iomem *)dev->common + offset);
+	if (dev->no_mmio)
+		dev->no_mmio->write8(dev, dev->common, offset, val);
+	else
+		iowrite8(val, (void __iomem *)dev->common + offset);
 }
 
 /* wait for pending irq handlers */
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 15a20c968ae7..d891e3123cdd 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -53,6 +53,9 @@ struct virtio_pci_device {
 	struct virtio_device vdev;
 	struct pci_dev *pci_dev;
 
+	/* This is only valid for modern devices. */
+	const struct virtio_pci_no_mmio_ops *no_mmio;
+
 	/* In legacy mode, these two point to within ->legacy. */
 	/* Where to read and clear interrupt */
 	u8 __iomem *isr;
@@ -75,6 +78,9 @@ struct virtio_pci_device {
 	/* Multiply queue_notify_off by this value. (non-legacy mode). */
 	u32 notify_offset_multiplier;
 
+	/* PCI config window for BAR access (non-legacy mode). */
+	int window;
+
 	/* Legacy only field */
 	/* the IO mapping for the PCI config space */
 	void __iomem *ioaddr;
@@ -113,6 +119,21 @@ struct virtio_pci_device {
 	u16 (*config_vector)(struct virtio_pci_device *vp_dev, u16 vector);
 };
 
+struct virtio_pci_no_mmio_ops {
+	u8 (*read8)(const struct virtio_pci_device *,
+		    const void __iomem *, size_t);
+	u16 (*read16)(const struct virtio_pci_device *,
+		      const void __iomem *, size_t);
+	u32 (*read32)(const struct virtio_pci_device *,
+		      const void __iomem *, size_t);
+	void (*write8)(const struct virtio_pci_device *,
+		       const void __iomem *, size_t, u8);
+	void (*write16)(const struct virtio_pci_device *,
+			const void __iomem *, size_t, u16);
+	void (*write32)(const struct virtio_pci_device *,
+			const void __iomem *, size_t, u32);
+};
+
 /* Accessor functions. */
 u8 vp_read_isr(const struct virtio_pci_device *dev);
 void vp_write_notify(const struct virtqueue *vq, u16 vqindex);
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 256a5278a515..26aa036fc494 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -226,6 +226,7 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
 		return -ENODEV;
 	}
 
+	vp_dev->no_mmio = NULL;
 	vp_dev->ioaddr = pci_iomap(pci_dev, 0, 0);
 	if (!vp_dev->ioaddr)
 		return -ENOMEM;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index daa990ef3df0..76882b467519 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -20,6 +20,125 @@
 #define VIRTIO_PCI_NO_LEGACY
 #include "virtio_pci_common.h"
 
+static bool no_mmio = false; /* Very, very false.  Never set this! */
+module_param(no_mmio, bool, 0644);
+
+/* We jam bar and offset into the pointer for non-MMIO */
+static u8 bar_off_from_pointer(const void *ptr, u32 *offset)
+{
+	*offset = (unsigned long)ptr >> 3;
+	return ((unsigned long)ptr & 0x7) - 1;
+}
+
+static void *bar_off_to_pointer(u8 bar, u32 offset)
+{
+	void *p;
+	u32 check_offset;
+
+	BUG_ON(bar >= 7);
+	p = (void *)((bar + 1) | (offset << 3));
+	if (bar_off_from_pointer(p, &check_offset) != bar
+	    || check_offset != offset) {
+		printk(KERN_ERR "Cannot pack bar %u offset %u into pointer!\n",
+		       bar, offset);
+		return NULL;
+	}
+	return p;
+}
+
+/* This sets up the PCI config space window ready for an access. */
+static void set_cfg_window(const struct virtio_pci_device *dev,
+			   const void __iomem *ptr, size_t offset, size_t len)
+{
+	u32 bar_offset;
+	u8 bar;
+
+	BUG_ON(!dev->no_mmio);
+
+	bar = bar_off_from_pointer(ptr, &bar_offset);
+
+	pci_write_config_byte(dev->pci_dev,
+			      dev->window + offsetof(struct virtio_pci_cap, bar),
+			      bar);
+	pci_write_config_dword(dev->pci_dev,
+			       dev->window
+			       + offsetof(struct virtio_pci_cap, length),
+			       len);
+	pci_write_config_dword(dev->pci_dev,
+			       dev->window
+			       + offsetof(struct virtio_pci_cap, offset),
+			       bar_offset + offset);
+}
+
+static u32 vp_window_read32(const struct virtio_pci_device *dev,
+			    const void __iomem *ptr,
+			    size_t offset)
+{
+	u32 ret = -1;
+	set_cfg_window(dev, ptr, offset, sizeof(ret));
+	pci_read_config_dword(dev->pci_dev,
+			      dev->window + sizeof(struct virtio_pci_cap), &ret);
+	return ret;
+}
+
+static u16 vp_window_read16(const struct virtio_pci_device *dev,
+			    const void __iomem *ptr,
+			    size_t offset)
+{
+	u16 ret = -1;
+	set_cfg_window(dev, ptr, offset, sizeof(ret));
+	pci_read_config_word(dev->pci_dev,
+			     dev->window + sizeof(struct virtio_pci_cap), &ret);
+	return ret;
+}
+
+static u8 vp_window_read8(const struct virtio_pci_device *dev,
+			  const void __iomem *ptr,
+			  size_t offset)
+{
+	u8 ret = -1;
+	set_cfg_window(dev, ptr, offset, sizeof(ret));
+	pci_read_config_byte(dev->pci_dev,
+			     dev->window + sizeof(struct virtio_pci_cap), &ret);
+	return ret;
+}
+
+static void vp_window_write32(const struct virtio_pci_device *dev,
+			      const void __iomem *ptr, size_t offset, u32 val)
+{
+	set_cfg_window(dev, ptr, offset, sizeof(val));
+	pci_write_config_dword(dev->pci_dev,
+			       dev->window + sizeof(struct virtio_pci_cap),
+			       val);
+}
+
+static void vp_window_write16(const struct virtio_pci_device *dev,
+			      const void __iomem *ptr, size_t offset, u16 val)
+{
+	set_cfg_window(dev, ptr, offset, sizeof(val));
+	pci_write_config_word(dev->pci_dev,
+			      dev->window + sizeof(struct virtio_pci_cap),
+			      val);
+}
+
+static void vp_window_write8(const struct virtio_pci_device *dev,
+			      const void __iomem *ptr, size_t offset, u8 val)
+{
+	set_cfg_window(dev, ptr, offset, sizeof(val));
+	pci_write_config_byte(dev->pci_dev,
+			      dev->window + sizeof(struct virtio_pci_cap),
+			      val);
+}
+
+static const struct virtio_pci_no_mmio_ops vp_window_ops = {
+	.read8 = vp_window_read8,
+	.read16 = vp_window_read16,
+	.read32 = vp_window_read32,
+	.write8 = vp_window_write8,
+	.write16 = vp_window_write16,
+	.write32 = vp_window_write32,
+};
+
 static void __iomem *map_capability(struct pci_dev *dev, int off,
 				    size_t minlen,
 				    u32 align,
@@ -86,6 +205,10 @@ static void __iomem *map_capability(struct pci_dev *dev, int off,
 		return NULL;
 	}
 
+	/* We encode bar and offset into the pointer for the no-mmio case. */
+	if (no_mmio)
+		return bar_off_to_pointer(bar, offset);
+
 	p = pci_iomap_range(dev, bar, offset, length);
 	if (!p)
 		dev_err(&dev->dev,
@@ -146,37 +269,52 @@ static int vp_finalize_features(struct virtio_device *vdev)
 static u32 vp_read_device32(const struct virtio_pci_device *dev,
 			    size_t offset)
 {
+	if (dev->no_mmio)
+		return vp_window_read32(dev, dev->device, offset);
 	return ioread32((void __iomem *)dev->device + offset);
 }
 
 static u16 vp_read_device16(const struct virtio_pci_device *dev,
 			    size_t offset)
 {
+	if (dev->no_mmio)
+		return vp_window_read16(dev, dev->device, offset);
 	return ioread16((void __iomem *)dev->device + offset);
 }
 
 static u8 vp_read_device8(const struct virtio_pci_device *dev,
 			  size_t offset)
 {
+	if (dev->no_mmio)
+		return vp_window_read8(dev, dev->device, offset);
 	return ioread8((void __iomem *)dev->device + offset);
 }
 
 static void vp_write_device32(const struct virtio_pci_device *dev,
 			      size_t offset, u32 val)
 {
-	iowrite32(val, (void __iomem *)dev->device + offset);
+	if (dev->no_mmio)
+		vp_window_write32(dev, dev->device, offset, val);
+	else
+		iowrite32(val, (void __iomem *)dev->device + offset);
 }
 
 static void vp_write_device16(const struct virtio_pci_device *dev,
 			      size_t offset, u16 val)
 {
-	iowrite16(val, (void __iomem *)dev->device + offset);
+	if (dev->no_mmio)
+		vp_window_write16(dev, dev->device, offset, val);
+	else
+		iowrite16(val, (void __iomem *)dev->device + offset);
 }
 
 static void vp_write_device8(const struct virtio_pci_device *dev,
 			      size_t offset, u8 val)
 {
-	iowrite8(val, (void __iomem *)dev->device + offset);
+	if (dev->no_mmio)
+		vp_window_write8(dev, dev->device, offset, val);
+	else
+		iowrite8(val, (void __iomem *)dev->device + offset);
 }
 
 /* virtio config->get() implementation */
@@ -494,6 +632,12 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.set_vq_affinity = vp_set_vq_affinity,
 };
 
+static void vp_iounmap(struct virtio_pci_device *dev, void __iomem *p)
+{
+	if (!dev->no_mmio)
+		pci_iounmap(dev->pci_dev, p);
+}
+
 /**
  * virtio_pci_find_capability - walk capabilities to find device info.
  * @dev: the pci device
@@ -598,7 +742,7 @@ static inline void check_offsets(void)
 int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 {
 	struct pci_dev *pci_dev = vp_dev->pci_dev;
-	int err, common, isr, notify, device;
+	int err, common, isr, notify, device, window;
 	u32 notify_length;
 	u32 notify_offset;
 
@@ -631,6 +775,13 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 		return -ENODEV;
 	}
 
+	if (no_mmio) {
+		vp_dev->no_mmio = &vp_window_ops;
+		dev_warn(&pci_dev->dev,
+			 "virtio_pci: using SLOW non-MMIO access\n");
+ 	} else
+		vp_dev->no_mmio = NULL;
+
 	/* If common is there, these should be too... */
 	isr = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_ISR_CFG,
 					 IORESOURCE_IO | IORESOURCE_MEM);
@@ -643,6 +794,16 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 		return -EINVAL;
 	}
 
+	vp_dev->window = virtio_pci_find_capability(pci_dev,
+						    VIRTIO_PCI_CAP_PCI_CFG,
+						    IORESOURCE_IO |
+						    IORESOURCE_MEM);
+	if (!vp_dev->window) {
+		dev_err(&pci_dev->dev,
+			"virtio_pci: missing pci window capability\n");
+		return -EINVAL;
+	}
+
 	/* Device capability is only mandatory for devices that have
 	 * device-specific configuration.
 	 */
@@ -715,11 +876,11 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 
 err_map_device:
 	if (vp_dev->notify_base)
-		pci_iounmap(pci_dev, vp_dev->notify_base);
+		vp_iounmap(vp_dev, vp_dev->notify_base);
 err_map_notify:
-	pci_iounmap(pci_dev, vp_dev->isr);
+	vp_iounmap(vp_dev, vp_dev->isr);
 err_map_isr:
-	pci_iounmap(pci_dev, vp_dev->common);
+	vp_iounmap(vp_dev, vp_dev->common);
 err_map_common:
 	return err;
 }
@@ -729,9 +890,9 @@ void virtio_pci_modern_remove(struct virtio_pci_device *vp_dev)
 	struct pci_dev *pci_dev = vp_dev->pci_dev;
 
 	if (vp_dev->device)
-		pci_iounmap(pci_dev, vp_dev->device);
+		vp_iounmap(vp_dev, vp_dev->device);
 	if (vp_dev->notify_base)
-		pci_iounmap(pci_dev, vp_dev->notify_base);
-	pci_iounmap(pci_dev, vp_dev->isr);
-	pci_iounmap(pci_dev, vp_dev->common);
+		vp_iounmap(vp_dev, vp_dev->notify_base);
+	vp_iounmap(vp_dev, vp_dev->isr);
+	vp_iounmap(vp_dev, vp_dev->common);
 }
-- 
2.1.0
