From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2] virtio-pci: alloc only resources actually used.
Date: Thu, 18 Jun 2015 11:27:34 +0200
Message-ID: <1434619654-10142-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO CORE,
	NET..." <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Move resource allocation from common code to legacy and modern code.
Only request resources actually used, i.e. bar0 in legacy mode and
the regions specified by capabilities in modern mode.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/virtio/virtio_pci_common.c |  7 ----
 drivers/virtio/virtio_pci_common.h |  5 +++
 drivers/virtio/virtio_pci_legacy.c | 13 +++++++-
 drivers/virtio/virtio_pci_modern.c | 66 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index eba1b7a..327a121 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -510,10 +510,6 @@ static int virtio_pci_probe(struct pci_dev *pci_dev,
 	if (rc)
 		goto err_enable_device;
 
-	rc = pci_request_regions(pci_dev, "virtio-pci");
-	if (rc)
-		goto err_request_regions;
-
 	if (force_legacy) {
 		rc = virtio_pci_legacy_probe(vp_dev);
 		/* Also try modern mode if we can't map BAR0 (no IO space). */
@@ -543,8 +539,6 @@ err_register:
 	else
 	     virtio_pci_modern_remove(vp_dev);
 err_probe:
-	pci_release_regions(pci_dev);
-err_request_regions:
 	pci_disable_device(pci_dev);
 err_enable_device:
 	kfree(vp_dev);
@@ -562,7 +556,6 @@ static void virtio_pci_remove(struct pci_dev *pci_dev)
 	else
 		virtio_pci_modern_remove(vp_dev);
 
-	pci_release_regions(pci_dev);
 	pci_disable_device(pci_dev);
 }
 
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 28ee4e5..9e744b8 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -75,6 +75,11 @@ struct virtio_pci_device {
 	/* Multiply queue_notify_off by this value. (non-legacy mode). */
 	u32 notify_offset_multiplier;
 
+	struct resource *res_common;
+	struct resource *res_isr;
+	struct resource *res_device;
+	struct resource *res_notify;
+
 	/* Legacy only field */
 	/* the IO mapping for the PCI config space */
 	void __iomem *ioaddr;
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 256a527..48bc979 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -215,6 +215,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
 {
 	struct pci_dev *pci_dev = vp_dev->pci_dev;
+	int rc;
 
 	/* We only own devices >= 0x1000 and <= 0x103f: leave the rest. */
 	if (pci_dev->device < 0x1000 || pci_dev->device > 0x103f)
@@ -226,9 +227,14 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
 		return -ENODEV;
 	}
 
+	rc = pci_request_region(pci_dev, 0, "virtio-pci-legacy");
+	if (rc)
+		return rc;
+
+	rc = -ENOMEM;
 	vp_dev->ioaddr = pci_iomap(pci_dev, 0, 0);
 	if (!vp_dev->ioaddr)
-		return -ENOMEM;
+		goto err_iomap;
 
 	vp_dev->isr = vp_dev->ioaddr + VIRTIO_PCI_ISR;
 
@@ -246,6 +252,10 @@ int virtio_pci_legacy_probe(struct virtio_pci_device *vp_dev)
 	vp_dev->del_vq = del_vq;
 
 	return 0;
+
+err_iomap:
+	pci_release_region(pci_dev, 0);
+	return rc;
 }
 
 void virtio_pci_legacy_remove(struct virtio_pci_device *vp_dev)
@@ -253,4 +263,5 @@ void virtio_pci_legacy_remove(struct virtio_pci_device *vp_dev)
 	struct pci_dev *pci_dev = vp_dev->pci_dev;
 
 	pci_iounmap(pci_dev, vp_dev->ioaddr);
+	pci_release_region(pci_dev, 0);
 }
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index e88e099..d9976ad 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -64,6 +64,37 @@ static void vp_iowrite64_twopart(u64 val,
 	vp_iowrite32(val >> 32, hi);
 }
 
+static struct resource *request_capability(struct pci_dev *dev, int off,
+					   int limit, const char *name)
+{
+	u8 bar;
+	u32 offset, length;
+
+	pci_read_config_byte(dev, off + offsetof(struct virtio_pci_cap,
+						 bar),
+			     &bar);
+	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, offset),
+			     &offset);
+	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
+			      &length);
+
+	if (offset + length < offset ||
+	    offset + length > pci_resource_len(dev, bar)) {
+		dev_err(&dev->dev,
+			"virtio_pci: virtio capability %u@%u "
+			"out of range on bar %i length %lu\n",
+			length, offset, bar,
+			(unsigned long)pci_resource_len(dev, bar));
+		return NULL;
+	}
+
+	if (limit && length > limit)
+		length = limit;
+
+	return request_mem_region(pci_resource_start(dev, bar) + offset,
+				  length, name);
+}
+
 static void __iomem *map_capability(struct pci_dev *dev, int off,
 				    size_t minlen,
 				    u32 align,
@@ -131,10 +162,12 @@ static void __iomem *map_capability(struct pci_dev *dev, int off,
 	}
 
 	p = pci_iomap_range(dev, bar, offset, length);
-	if (!p)
+	if (!p) {
 		dev_err(&dev->dev,
 			"virtio_pci: unable to map virtio %u@%u on bar %i\n",
 			length, offset, bar);
+		return NULL;
+	}
 	return p;
 }
 
@@ -642,6 +675,22 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	device = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_DEVICE_CFG,
 					    IORESOURCE_IO | IORESOURCE_MEM);
 
+	vp_dev->res_common = request_capability(pci_dev, common, 0,
+						"virtio-pci-common");
+	vp_dev->res_isr = request_capability(pci_dev, isr, 0,
+						"virtio-pci-isr");
+	vp_dev->res_notify = request_capability(pci_dev, notify, 0,
+						"virtio-pci-notify");
+	if (device) {
+		vp_dev->res_device = request_capability(pci_dev, device,
+							PAGE_SIZE,
+							"virtio-pci-device");
+	}
+	err = -EINVAL;
+	if (!vp_dev->res_common || !vp_dev->res_isr || !vp_dev->res_notify ||
+	    (device && !vp_dev->res_device))
+		goto err_reserve;
+
 	err = -EINVAL;
 	vp_dev->common = map_capability(pci_dev, common,
 					sizeof(struct virtio_pci_common_cfg), 4,
@@ -714,6 +763,15 @@ err_map_notify:
 err_map_isr:
 	pci_iounmap(pci_dev, vp_dev->common);
 err_map_common:
+err_reserve:
+	if (vp_dev->res_common)
+		release_resource(vp_dev->res_common);
+	if (vp_dev->res_isr)
+		release_resource(vp_dev->res_isr);
+	if (vp_dev->res_notify)
+		release_resource(vp_dev->res_notify);
+	if (vp_dev->res_device)
+		release_resource(vp_dev->res_device);
 	return err;
 }
 
@@ -727,4 +785,10 @@ void virtio_pci_modern_remove(struct virtio_pci_device *vp_dev)
 		pci_iounmap(pci_dev, vp_dev->notify_base);
 	pci_iounmap(pci_dev, vp_dev->isr);
 	pci_iounmap(pci_dev, vp_dev->common);
+
+	release_resource(vp_dev->res_common);
+	release_resource(vp_dev->res_isr);
+	release_resource(vp_dev->res_notify);
+	if (vp_dev->res_device)
+		release_resource(vp_dev->res_device);
 }
-- 
1.8.3.1
