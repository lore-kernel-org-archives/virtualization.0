Return-Path: <SRS0=jeLh=E6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1D1C56201
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 11:38:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C6AE2076B
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 11:38:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C6AE2076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9F0A021505;
	Tue, 24 Nov 2020 11:38:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5fclIoS0KJtj; Tue, 24 Nov 2020 11:38:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F3EDB2151F;
	Tue, 24 Nov 2020 11:38:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7935C1DA0;
	Tue, 24 Nov 2020 11:38:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72CE1C1DA1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5EAE1866C1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LSFlEVEHUsgs
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 474B585E12
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:32 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E7F8DAC2E;
 Tue, 24 Nov 2020 11:38:29 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH 15/15] drm: Upcast struct drm_device.dev to struct pci_device;
 replace pdev
Date: Tue, 24 Nov 2020 12:38:24 +0100
Message-Id: <20201124113824.19994-16-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124113824.19994-1-tzimmermann@suse.de>
References: <20201124113824.19994-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 spice-devel@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

We have DRM drivers based on USB, SPI and platform devices. All of them
are fine with storing their device reference in struct drm_device.dev.
PCI devices should be no exception. Therefore struct drm_device.pdev is
deprecated.

Instead upcast from struct drm_device.dev with to_pci_dev(). PCI-specific
code can use dev_is_pci() to test for a PCI device. This patch changes
the DRM core code and documentation accordingly. Struct drm_device.pdev
is being moved to legacy status.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_agpsupport.c |  9 ++++++---
 drivers/gpu/drm/drm_bufs.c       |  4 ++--
 drivers/gpu/drm/drm_edid.c       |  7 ++++++-
 drivers/gpu/drm/drm_irq.c        | 12 +++++++-----
 drivers/gpu/drm/drm_pci.c        | 26 +++++++++++++++-----------
 drivers/gpu/drm/drm_vm.c         |  2 +-
 include/drm/drm_device.h         | 12 +++++++++---
 7 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/drm_agpsupport.c b/drivers/gpu/drm/drm_agpsupport.c
index 4c7ad46fdd21..a4040fe4f4ba 100644
--- a/drivers/gpu/drm/drm_agpsupport.c
+++ b/drivers/gpu/drm/drm_agpsupport.c
@@ -103,11 +103,13 @@ int drm_agp_info_ioctl(struct drm_device *dev, void *data,
  */
 int drm_agp_acquire(struct drm_device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
 	if (!dev->agp)
 		return -ENODEV;
 	if (dev->agp->acquired)
 		return -EBUSY;
-	dev->agp->bridge = agp_backend_acquire(dev->pdev);
+	dev->agp->bridge = agp_backend_acquire(pdev);
 	if (!dev->agp->bridge)
 		return -ENODEV;
 	dev->agp->acquired = 1;
@@ -402,14 +404,15 @@ int drm_agp_free_ioctl(struct drm_device *dev, void *data,
  */
 struct drm_agp_head *drm_agp_init(struct drm_device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	struct drm_agp_head *head = NULL;
 
 	head = kzalloc(sizeof(*head), GFP_KERNEL);
 	if (!head)
 		return NULL;
-	head->bridge = agp_find_bridge(dev->pdev);
+	head->bridge = agp_find_bridge(pdev);
 	if (!head->bridge) {
-		head->bridge = agp_backend_acquire(dev->pdev);
+		head->bridge = agp_backend_acquire(pdev);
 		if (!head->bridge) {
 			kfree(head);
 			return NULL;
diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index 7a01d0918861..1da8b360b60a 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -325,7 +325,7 @@ static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
 		 * As we're limiting the address to 2^32-1 (or less),
 		 * casting it down to 32 bits is no problem, but we
 		 * need to point to a 64bit variable first. */
-		map->handle = dma_alloc_coherent(&dev->pdev->dev,
+		map->handle = dma_alloc_coherent(dev->dev,
 						 map->size,
 						 &map->offset,
 						 GFP_KERNEL);
@@ -555,7 +555,7 @@ int drm_legacy_rmmap_locked(struct drm_device *dev, struct drm_local_map *map)
 	case _DRM_SCATTER_GATHER:
 		break;
 	case _DRM_CONSISTENT:
-		dma_free_coherent(&dev->pdev->dev,
+		dma_free_coherent(dev->dev,
 				  map->size,
 				  map->handle,
 				  map->offset);
diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 74f5a3197214..555a04ce2179 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -32,6 +32,7 @@
 #include <linux/i2c.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/vga_switcheroo.h>
 
@@ -2075,9 +2076,13 @@ EXPORT_SYMBOL(drm_get_edid);
 struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
 				     struct i2c_adapter *adapter)
 {
-	struct pci_dev *pdev = connector->dev->pdev;
+	struct drm_device *dev = connector->dev;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	struct edid *edid;
 
+	if (drm_WARN_ON_ONCE(dev, !dev_is_pci(dev->dev)))
+		return NULL;
+
 	vga_switcheroo_lock_ddc(pdev);
 	edid = drm_get_edid(connector, adapter);
 	vga_switcheroo_unlock_ddc(pdev);
diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
index 09d6e9e2e075..22986a9a593b 100644
--- a/drivers/gpu/drm/drm_irq.c
+++ b/drivers/gpu/drm/drm_irq.c
@@ -122,7 +122,7 @@ int drm_irq_install(struct drm_device *dev, int irq)
 		dev->driver->irq_preinstall(dev);
 
 	/* PCI devices require shared interrupts. */
-	if (dev->pdev)
+	if (dev_is_pci(dev->dev))
 		sh_flags = IRQF_SHARED;
 
 	ret = request_irq(irq, dev->driver->irq_handler,
@@ -140,7 +140,7 @@ int drm_irq_install(struct drm_device *dev, int irq)
 	if (ret < 0) {
 		dev->irq_enabled = false;
 		if (drm_core_check_feature(dev, DRIVER_LEGACY))
-			vga_client_register(dev->pdev, NULL, NULL, NULL);
+			vga_client_register(to_pci_dev(dev->dev), NULL, NULL, NULL);
 		free_irq(irq, dev);
 	} else {
 		dev->irq = irq;
@@ -203,7 +203,7 @@ int drm_irq_uninstall(struct drm_device *dev)
 	DRM_DEBUG("irq=%d\n", dev->irq);
 
 	if (drm_core_check_feature(dev, DRIVER_LEGACY))
-		vga_client_register(dev->pdev, NULL, NULL, NULL);
+		vga_client_register(to_pci_dev(dev->dev), NULL, NULL, NULL);
 
 	if (dev->driver->irq_uninstall)
 		dev->driver->irq_uninstall(dev);
@@ -220,6 +220,7 @@ int drm_legacy_irq_control(struct drm_device *dev, void *data,
 {
 	struct drm_control *ctl = data;
 	int ret = 0, irq;
+	struct pci_dev *pdev;
 
 	/* if we haven't irq we fallback for compatibility reasons -
 	 * this used to be a separate function in drm_dma.h
@@ -230,12 +231,13 @@ int drm_legacy_irq_control(struct drm_device *dev, void *data,
 	if (!drm_core_check_feature(dev, DRIVER_LEGACY))
 		return 0;
 	/* UMS was only ever supported on pci devices. */
-	if (WARN_ON(!dev->pdev))
+	if (WARN_ON(!dev_is_pci(dev->dev)))
 		return -EINVAL;
 
 	switch (ctl->func) {
 	case DRM_INST_HANDLER:
-		irq = dev->pdev->irq;
+		pdev = to_pci_dev(dev->dev);
+		irq = pdev->irq;
 
 		if (dev->if_version < DRM_IF_VERSION(1, 2) &&
 		    ctl->irq != irq)
diff --git a/drivers/gpu/drm/drm_pci.c b/drivers/gpu/drm/drm_pci.c
index 6dba4b8ce4fe..c7868418e36d 100644
--- a/drivers/gpu/drm/drm_pci.c
+++ b/drivers/gpu/drm/drm_pci.c
@@ -65,7 +65,7 @@ drm_dma_handle_t *drm_pci_alloc(struct drm_device * dev, size_t size, size_t ali
 		return NULL;
 
 	dmah->size = size;
-	dmah->vaddr = dma_alloc_coherent(&dev->pdev->dev, size,
+	dmah->vaddr = dma_alloc_coherent(dev->dev, size,
 					 &dmah->busaddr,
 					 GFP_KERNEL);
 
@@ -88,7 +88,7 @@ EXPORT_SYMBOL(drm_pci_alloc);
  */
 void drm_pci_free(struct drm_device * dev, drm_dma_handle_t * dmah)
 {
-	dma_free_coherent(&dev->pdev->dev, dmah->size, dmah->vaddr,
+	dma_free_coherent(dev->dev, dmah->size, dmah->vaddr,
 			  dmah->busaddr);
 	kfree(dmah);
 }
@@ -107,16 +107,18 @@ static int drm_get_pci_domain(struct drm_device *dev)
 		return 0;
 #endif /* __alpha__ */
 
-	return pci_domain_nr(dev->pdev->bus);
+	return pci_domain_nr(to_pci_dev(dev->dev)->bus);
 }
 
 int drm_pci_set_busid(struct drm_device *dev, struct drm_master *master)
 {
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
 	master->unique = kasprintf(GFP_KERNEL, "pci:%04x:%02x:%02x.%d",
 					drm_get_pci_domain(dev),
-					dev->pdev->bus->number,
-					PCI_SLOT(dev->pdev->devfn),
-					PCI_FUNC(dev->pdev->devfn));
+					pdev->bus->number,
+					PCI_SLOT(pdev->devfn),
+					PCI_FUNC(pdev->devfn));
 	if (!master->unique)
 		return -ENOMEM;
 
@@ -126,12 +128,14 @@ int drm_pci_set_busid(struct drm_device *dev, struct drm_master *master)
 
 static int drm_pci_irq_by_busid(struct drm_device *dev, struct drm_irq_busid *p)
 {
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
 	if ((p->busnum >> 8) != drm_get_pci_domain(dev) ||
-	    (p->busnum & 0xff) != dev->pdev->bus->number ||
-	    p->devnum != PCI_SLOT(dev->pdev->devfn) || p->funcnum != PCI_FUNC(dev->pdev->devfn))
+	    (p->busnum & 0xff) != pdev->bus->number ||
+	    p->devnum != PCI_SLOT(pdev->devfn) || p->funcnum != PCI_FUNC(pdev->devfn))
 		return -EINVAL;
 
-	p->irq = dev->pdev->irq;
+	p->irq = pdev->irq;
 
 	DRM_DEBUG("%d:%d:%d => IRQ %d\n", p->busnum, p->devnum, p->funcnum,
 		  p->irq);
@@ -159,7 +163,7 @@ int drm_legacy_irq_by_busid(struct drm_device *dev, void *data,
 		return -EOPNOTSUPP;
 
 	/* UMS was only ever support on PCI devices. */
-	if (WARN_ON(!dev->pdev))
+	if (WARN_ON(!dev_is_pci(dev->dev)))
 		return -EINVAL;
 
 	if (!drm_core_check_feature(dev, DRIVER_HAVE_IRQ))
@@ -183,7 +187,7 @@ void drm_pci_agp_destroy(struct drm_device *dev)
 static void drm_pci_agp_init(struct drm_device *dev)
 {
 	if (drm_core_check_feature(dev, DRIVER_USE_AGP)) {
-		if (pci_find_capability(dev->pdev, PCI_CAP_ID_AGP))
+		if (pci_find_capability(to_pci_dev(dev->dev), PCI_CAP_ID_AGP))
 			dev->agp = drm_agp_init(dev);
 		if (dev->agp) {
 			dev->agp->agp_mtrr = arch_phys_wc_add(
diff --git a/drivers/gpu/drm/drm_vm.c b/drivers/gpu/drm/drm_vm.c
index 6d5a03b32238..9b3b989d7cad 100644
--- a/drivers/gpu/drm/drm_vm.c
+++ b/drivers/gpu/drm/drm_vm.c
@@ -278,7 +278,7 @@ static void drm_vm_shm_close(struct vm_area_struct *vma)
 			case _DRM_SCATTER_GATHER:
 				break;
 			case _DRM_CONSISTENT:
-				dma_free_coherent(&dev->pdev->dev,
+				dma_free_coherent(dev->dev,
 						  map->size,
 						  map->handle,
 						  map->offset);
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 283a93ce4617..9d9db178119a 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -290,9 +290,6 @@ struct drm_device {
 	/** @agp: AGP data */
 	struct drm_agp_head *agp;
 
-	/** @pdev: PCI device structure */
-	struct pci_dev *pdev;
-
 #ifdef __alpha__
 	/** @hose: PCI hose, only used on ALPHA platforms. */
 	struct pci_controller *hose;
@@ -336,6 +333,15 @@ struct drm_device {
 	/* Everything below here is for legacy driver, never use! */
 	/* private: */
 #if IS_ENABLED(CONFIG_DRM_LEGACY)
+	/**
+	 * @pdev: PCI device structure
+	 *
+	 * This is deprecated. to get the PCI device, upcast from @dev
+	 * with to_pci_dev(). To test if the hardware is a PCI device,
+	 * use dev_is_pci() with @dev.
+	 */
+	struct pci_dev *pdev;
+
 	/* Context handle management - linked list of context handles */
 	struct list_head ctxlist;
 
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
