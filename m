Return-Path: <SRS0=jeLh=E6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FB4C6379D
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 11:38:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0E782075A
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 11:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0E782075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9A89685DF6;
	Tue, 24 Nov 2020 11:38:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 66bH4k_k6T19; Tue, 24 Nov 2020 11:38:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 3B1B485F15;
	Tue, 24 Nov 2020 11:38:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24408C163C;
	Tue, 24 Nov 2020 11:38:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89ED9C0052
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 82C1A2150A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E-wUZjiJixZM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 7437B21080
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:31 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id BC685AE39;
 Tue, 24 Nov 2020 11:38:29 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH 14/15] drm/vmwgfx: Remove references to struct drm_device.pdev
Date: Tue, 24 Nov 2020 12:38:23 +0100
Message-Id: <20201124113824.19994-15-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124113824.19994-1-tzimmermann@suse.de>
References: <20201124113824.19994-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Roland Scheidegger <sroland@vmware.com>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, spice-devel@lists.freedesktop.org,
 intel-gvt-dev@lists.freedesktop.org
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

Using struct drm_device.pdev is deprecated. Convert vmwgfx to struct
drm_device.dev. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Roland Scheidegger <sroland@vmware.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c |  8 ++++----
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c    | 27 +++++++++++++-------------
 drivers/gpu/drm/vmwgfx/vmwgfx_fb.c     |  2 +-
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
index 9a9fe10d829b..83a8d34704ea 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_cmdbuf.c
@@ -1230,7 +1230,7 @@ int vmw_cmdbuf_set_pool_size(struct vmw_cmdbuf_man *man,
 
 	/* First, try to allocate a huge chunk of DMA memory */
 	size = PAGE_ALIGN(size);
-	man->map = dma_alloc_coherent(&dev_priv->dev->pdev->dev, size,
+	man->map = dma_alloc_coherent(dev_priv->dev->dev, size,
 				      &man->handle, GFP_KERNEL);
 	if (man->map) {
 		man->using_mob = false;
@@ -1313,7 +1313,7 @@ struct vmw_cmdbuf_man *vmw_cmdbuf_man_create(struct vmw_private *dev_priv)
 	man->num_contexts = (dev_priv->capabilities & SVGA_CAP_HP_CMD_QUEUE) ?
 		2 : 1;
 	man->headers = dma_pool_create("vmwgfx cmdbuf",
-				       &dev_priv->dev->pdev->dev,
+				       dev_priv->dev->dev,
 				       sizeof(SVGACBHeader),
 				       64, PAGE_SIZE);
 	if (!man->headers) {
@@ -1322,7 +1322,7 @@ struct vmw_cmdbuf_man *vmw_cmdbuf_man_create(struct vmw_private *dev_priv)
 	}
 
 	man->dheaders = dma_pool_create("vmwgfx inline cmdbuf",
-					&dev_priv->dev->pdev->dev,
+					dev_priv->dev->dev,
 					sizeof(struct vmw_cmdbuf_dheader),
 					64, PAGE_SIZE);
 	if (!man->dheaders) {
@@ -1387,7 +1387,7 @@ void vmw_cmdbuf_remove_pool(struct vmw_cmdbuf_man *man)
 		ttm_bo_put(man->cmd_space);
 		man->cmd_space = NULL;
 	} else {
-		dma_free_coherent(&man->dev_priv->dev->pdev->dev,
+		dma_free_coherent(man->dev_priv->dev->dev,
 				  man->size, man->map, man->handle);
 	}
 }
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 216daf93022c..e63e08f5b14f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -652,6 +652,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 	enum vmw_res_type i;
 	bool refuse_dma = false;
 	char host_log[100] = {0};
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	dev_priv = kzalloc(sizeof(*dev_priv), GFP_KERNEL);
 	if (unlikely(!dev_priv)) {
@@ -659,7 +660,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 		return -ENOMEM;
 	}
 
-	pci_set_master(dev->pdev);
+	pci_set_master(pdev);
 
 	dev_priv->dev = dev;
 	dev_priv->vmw_chipset = chipset;
@@ -688,9 +689,9 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 
 	dev_priv->used_memory_size = 0;
 
-	dev_priv->io_start = pci_resource_start(dev->pdev, 0);
-	dev_priv->vram_start = pci_resource_start(dev->pdev, 1);
-	dev_priv->mmio_start = pci_resource_start(dev->pdev, 2);
+	dev_priv->io_start = pci_resource_start(pdev, 0);
+	dev_priv->vram_start = pci_resource_start(pdev, 1);
+	dev_priv->mmio_start = pci_resource_start(pdev, 2);
 
 	dev_priv->assume_16bpp = !!vmw_assume_16bpp;
 
@@ -840,7 +841,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 
 	dev->dev_private = dev_priv;
 
-	ret = pci_request_regions(dev->pdev, "vmwgfx probe");
+	ret = pci_request_regions(pdev, "vmwgfx probe");
 	dev_priv->stealth = (ret != 0);
 	if (dev_priv->stealth) {
 		/**
@@ -849,7 +850,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 
 		DRM_INFO("It appears like vesafb is loaded. "
 			 "Ignore above error if any.\n");
-		ret = pci_request_region(dev->pdev, 2, "vmwgfx stealth probe");
+		ret = pci_request_region(pdev, 2, "vmwgfx stealth probe");
 		if (unlikely(ret != 0)) {
 			DRM_ERROR("Failed reserving the SVGA MMIO resource.\n");
 			goto out_no_device;
@@ -857,7 +858,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 	}
 
 	if (dev_priv->capabilities & SVGA_CAP_IRQMASK) {
-		ret = vmw_irq_install(dev, dev->pdev->irq);
+		ret = vmw_irq_install(dev, pdev->irq);
 		if (ret != 0) {
 			DRM_ERROR("Failed installing irq: %d\n", ret);
 			goto out_no_irq;
@@ -1003,9 +1004,9 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 		vmw_irq_uninstall(dev_priv->dev);
 out_no_irq:
 	if (dev_priv->stealth)
-		pci_release_region(dev->pdev, 2);
+		pci_release_region(pdev, 2);
 	else
-		pci_release_regions(dev->pdev);
+		pci_release_regions(pdev);
 out_no_device:
 	ttm_object_device_release(&dev_priv->tdev);
 out_err4:
@@ -1023,6 +1024,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 static void vmw_driver_unload(struct drm_device *dev)
 {
 	struct vmw_private *dev_priv = vmw_priv(dev);
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	enum vmw_res_type i;
 
 	unregister_pm_notifier(&dev_priv->pm_nb);
@@ -1054,9 +1056,9 @@ static void vmw_driver_unload(struct drm_device *dev)
 	if (dev_priv->capabilities & SVGA_CAP_IRQMASK)
 		vmw_irq_uninstall(dev_priv->dev);
 	if (dev_priv->stealth)
-		pci_release_region(dev->pdev, 2);
+		pci_release_region(pdev, 2);
 	else
-		pci_release_regions(dev->pdev);
+		pci_release_regions(pdev);
 
 	ttm_object_device_release(&dev_priv->tdev);
 	memunmap(dev_priv->mmio_virt);
@@ -1409,7 +1411,7 @@ static int vmw_pm_freeze(struct device *kdev)
 
 	vmw_fence_fifo_down(dev_priv->fman);
 	__vmw_svga_disable(dev_priv);
-	
+
 	vmw_release_device_late(dev_priv);
 	return 0;
 }
@@ -1520,7 +1522,6 @@ static int vmw_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_pci_disable_device;
 	}
 
-	dev->pdev = pdev;
 	pci_set_drvdata(pdev, dev);
 
 	ret = vmw_driver_load(dev, ent->driver_data);
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
index 4d60201037d1..a244b6c3e5a1 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
@@ -638,7 +638,7 @@ static const struct fb_ops vmw_fb_ops = {
 
 int vmw_fb_init(struct vmw_private *vmw_priv)
 {
-	struct device *device = &vmw_priv->dev->pdev->dev;
+	struct device *device = vmw_priv->dev->dev;
 	struct vmw_fb_par *par;
 	struct fb_info *info;
 	unsigned fb_width, fb_height;
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
