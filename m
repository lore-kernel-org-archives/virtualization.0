From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] virtio-pci: alloc only resources actually used.
Date: Wed, 24 Jun 2015 07:54:15 +0200
Message-ID: <1435125255-2601-1-git-send-email-kraxel@redhat.com>
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
the bar(s) specified by capabilities in modern mode.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/virtio/virtio_pci_common.c |  7 -------
 drivers/virtio/virtio_pci_common.h |  2 ++
 drivers/virtio/virtio_pci_legacy.c | 13 ++++++++++++-
 drivers/virtio/virtio_pci_modern.c | 24 ++++++++++++++++++------
 4 files changed, 32 insertions(+), 14 deletions(-)

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
index 28ee4e5..b976d96 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -75,6 +75,8 @@ struct virtio_pci_device {
 	/* Multiply queue_notify_off by this value. (non-legacy mode). */
 	u32 notify_offset_multiplier;
 
+	int modern_bars;
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
index e88e099..8e5cf19 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -499,7 +499,7 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
  * Returns offset of the capability, or 0.
  */
 static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
-					     u32 ioresource_types)
+					     u32 ioresource_types, int *bars)
 {
 	int pos;
 
@@ -520,8 +520,10 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
 
 		if (type == cfg_type) {
 			if (pci_resource_len(dev, bar) &&
-			    pci_resource_flags(dev, bar) & ioresource_types)
+			    pci_resource_flags(dev, bar) & ioresource_types) {
+				*bars |= (1 << bar);
 				return pos;
+			}
 		}
 	}
 	return 0;
@@ -617,7 +619,8 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 
 	/* check for a common config: if not, use legacy mode (bar 0). */
 	common = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_COMMON_CFG,
-					    IORESOURCE_IO | IORESOURCE_MEM);
+					    IORESOURCE_IO | IORESOURCE_MEM,
+					    &vp_dev->modern_bars);
 	if (!common) {
 		dev_info(&pci_dev->dev,
 			 "virtio_pci: leaving for legacy driver\n");
@@ -626,9 +629,11 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 
 	/* If common is there, these should be too... */
 	isr = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_ISR_CFG,
-					 IORESOURCE_IO | IORESOURCE_MEM);
+					 IORESOURCE_IO | IORESOURCE_MEM,
+					 &vp_dev->modern_bars);
 	notify = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_NOTIFY_CFG,
-					    IORESOURCE_IO | IORESOURCE_MEM);
+					    IORESOURCE_IO | IORESOURCE_MEM,
+					    &vp_dev->modern_bars);
 	if (!isr || !notify) {
 		dev_err(&pci_dev->dev,
 			"virtio_pci: missing capabilities %i/%i/%i\n",
@@ -640,7 +645,13 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	 * device-specific configuration.
 	 */
 	device = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_DEVICE_CFG,
-					    IORESOURCE_IO | IORESOURCE_MEM);
+					    IORESOURCE_IO | IORESOURCE_MEM,
+					    &vp_dev->modern_bars);
+
+	err = pci_request_selected_regions(pci_dev, vp_dev->modern_bars,
+					   "virtio-pci-modern");
+	if (err)
+		return err;
 
 	err = -EINVAL;
 	vp_dev->common = map_capability(pci_dev, common,
@@ -727,4 +738,5 @@ void virtio_pci_modern_remove(struct virtio_pci_device *vp_dev)
 		pci_iounmap(pci_dev, vp_dev->notify_base);
 	pci_iounmap(pci_dev, vp_dev->isr);
 	pci_iounmap(pci_dev, vp_dev->common);
+	pci_release_selected_regions(pci_dev, vp_dev->modern_bars);
 }
-- 
1.8.3.1
