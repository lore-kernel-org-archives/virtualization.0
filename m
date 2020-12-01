Return-Path: <SRS0=fSyG=FF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A726C83013
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 10:36:31 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 023F220644
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 10:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023F220644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AE7E6880BC;
	Tue,  1 Dec 2020 10:36:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k0iyQHRep+uV; Tue,  1 Dec 2020 10:36:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 66EC88809C;
	Tue,  1 Dec 2020 10:36:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5523DC163C;
	Tue,  1 Dec 2020 10:36:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56D4AC163C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 40891880A8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Hz6RpZzaDuLR
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:36:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1ED2A8809F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:36:03 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B583BAD3F;
 Tue,  1 Dec 2020 10:36:01 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH v2 17/20] drm/vboxvideo: Remove references to struct
 drm_device.pdev
Date: Tue,  1 Dec 2020 11:35:39 +0100
Message-Id: <20201201103542.2182-18-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201103542.2182-1-tzimmermann@suse.de>
References: <20201201103542.2182-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Sam Ravnborg <sam@ravnborg.org>, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, Hans de Goede <hdegoede@redhat.com>,
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

Using struct drm_device.pdev is deprecated. Convert vboxvideo to struct
drm_device.dev. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/vboxvideo/vbox_drv.c  | 11 ++++++-----
 drivers/gpu/drm/vboxvideo/vbox_irq.c  |  4 +++-
 drivers/gpu/drm/vboxvideo/vbox_main.c |  8 ++++++--
 drivers/gpu/drm/vboxvideo/vbox_ttm.c  |  7 ++++---
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxvideo/vbox_drv.c
index f3eac72cb46e..e534896b6cfd 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
@@ -51,7 +51,6 @@ static int vbox_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (IS_ERR(vbox))
 		return PTR_ERR(vbox);
 
-	vbox->ddev.pdev = pdev;
 	pci_set_drvdata(pdev, vbox);
 	mutex_init(&vbox->hw_mutex);
 
@@ -109,15 +108,16 @@ static void vbox_pci_remove(struct pci_dev *pdev)
 static int vbox_pm_suspend(struct device *dev)
 {
 	struct vbox_private *vbox = dev_get_drvdata(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 	int error;
 
 	error = drm_mode_config_helper_suspend(&vbox->ddev);
 	if (error)
 		return error;
 
-	pci_save_state(vbox->ddev.pdev);
-	pci_disable_device(vbox->ddev.pdev);
-	pci_set_power_state(vbox->ddev.pdev, PCI_D3hot);
+	pci_save_state(pdev);
+	pci_disable_device(pdev);
+	pci_set_power_state(pdev, PCI_D3hot);
 
 	return 0;
 }
@@ -125,8 +125,9 @@ static int vbox_pm_suspend(struct device *dev)
 static int vbox_pm_resume(struct device *dev)
 {
 	struct vbox_private *vbox = dev_get_drvdata(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (pci_enable_device(vbox->ddev.pdev))
+	if (pci_enable_device(pdev))
 		return -EIO;
 
 	return drm_mode_config_helper_resume(&vbox->ddev);
diff --git a/drivers/gpu/drm/vboxvideo/vbox_irq.c b/drivers/gpu/drm/vboxvideo/vbox_irq.c
index 631657fa554f..b3ded68603ba 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_irq.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_irq.c
@@ -170,10 +170,12 @@ static void vbox_hotplug_worker(struct work_struct *work)
 
 int vbox_irq_init(struct vbox_private *vbox)
 {
+	struct pci_dev *pdev = to_pci_dev(vbox->ddev.dev);
+
 	INIT_WORK(&vbox->hotplug_work, vbox_hotplug_worker);
 	vbox_update_mode_hints(vbox);
 
-	return drm_irq_install(&vbox->ddev, vbox->ddev.pdev->irq);
+	return drm_irq_install(&vbox->ddev, pdev->irq);
 }
 
 void vbox_irq_fini(struct vbox_private *vbox)
diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
index d68d9bad7674..f28779715ccd 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_main.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
@@ -8,7 +8,9 @@
  *          Hans de Goede <hdegoede@redhat.com>
  */
 
+#include <linux/pci.h>
 #include <linux/vbox_err.h>
+
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_damage_helper.h>
@@ -30,6 +32,7 @@ void vbox_report_caps(struct vbox_private *vbox)
 
 static int vbox_accel_init(struct vbox_private *vbox)
 {
+	struct pci_dev *pdev = to_pci_dev(vbox->ddev.dev);
 	struct vbva_buffer *vbva;
 	unsigned int i;
 
@@ -41,7 +44,7 @@ static int vbox_accel_init(struct vbox_private *vbox)
 	/* Take a command buffer for each screen from the end of usable VRAM. */
 	vbox->available_vram_size -= vbox->num_crtcs * VBVA_MIN_BUFFER_SIZE;
 
-	vbox->vbva_buffers = pci_iomap_range(vbox->ddev.pdev, 0,
+	vbox->vbva_buffers = pci_iomap_range(pdev, 0,
 					     vbox->available_vram_size,
 					     vbox->num_crtcs *
 					     VBVA_MIN_BUFFER_SIZE);
@@ -106,6 +109,7 @@ bool vbox_check_supported(u16 id)
 
 int vbox_hw_init(struct vbox_private *vbox)
 {
+	struct pci_dev *pdev = to_pci_dev(vbox->ddev.dev);
 	int ret = -ENOMEM;
 
 	vbox->full_vram_size = inl(VBE_DISPI_IOPORT_DATA);
@@ -115,7 +119,7 @@ int vbox_hw_init(struct vbox_private *vbox)
 
 	/* Map guest-heap at end of vram */
 	vbox->guest_heap =
-	    pci_iomap_range(vbox->ddev.pdev, 0, GUEST_HEAP_OFFSET(vbox),
+	    pci_iomap_range(pdev, 0, GUEST_HEAP_OFFSET(vbox),
 			    GUEST_HEAP_SIZE);
 	if (!vbox->guest_heap)
 		return -ENOMEM;
diff --git a/drivers/gpu/drm/vboxvideo/vbox_ttm.c b/drivers/gpu/drm/vboxvideo/vbox_ttm.c
index f5a06675da43..0066a3c1dfc9 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_ttm.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_ttm.c
@@ -15,8 +15,9 @@ int vbox_mm_init(struct vbox_private *vbox)
 	struct drm_vram_mm *vmm;
 	int ret;
 	struct drm_device *dev = &vbox->ddev;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
-	vmm = drm_vram_helper_alloc_mm(dev, pci_resource_start(dev->pdev, 0),
+	vmm = drm_vram_helper_alloc_mm(dev, pci_resource_start(pdev, 0),
 				       vbox->available_vram_size);
 	if (IS_ERR(vmm)) {
 		ret = PTR_ERR(vmm);
@@ -24,8 +25,8 @@ int vbox_mm_init(struct vbox_private *vbox)
 		return ret;
 	}
 
-	vbox->fb_mtrr = arch_phys_wc_add(pci_resource_start(dev->pdev, 0),
-					 pci_resource_len(dev->pdev, 0));
+	vbox->fb_mtrr = arch_phys_wc_add(pci_resource_start(pdev, 0),
+					 pci_resource_len(pdev, 0));
 	return 0;
 }
 
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
