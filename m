Return-Path: <SRS0=fSyG=FF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE5EC83012
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 10:36:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 931522085B
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 10:36:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931522085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 30E8D88139;
	Tue,  1 Dec 2020 10:36:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DsHyqFTB3m5Q; Tue,  1 Dec 2020 10:36:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 442D3880D0;
	Tue,  1 Dec 2020 10:36:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 25092C1D9F;
	Tue,  1 Dec 2020 10:36:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECF77C0052
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D9FE087517
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:35:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WxizzWMzQKcg
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:35:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C0C448750F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:35:58 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 60283AD4A;
 Tue,  1 Dec 2020 10:35:57 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH v2 11/20] drm/i915/gvt: Remove references to struct
 drm_device.pdev
Date: Tue,  1 Dec 2020 11:35:33 +0100
Message-Id: <20201201103542.2182-12-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201103542.2182-1-tzimmermann@suse.de>
References: <20201201103542.2182-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Jani Nikula <jani.nikula@linux.intel.com>, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, spice-devel@lists.freedesktop.org,
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

Using struct drm_device.pdev is deprecated. Convert i915 to struct
drm_device.dev. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/i915/gvt/cfg_space.c |  5 +++--
 drivers/gpu/drm/i915/gvt/firmware.c  | 10 +++++-----
 drivers/gpu/drm/i915/gvt/gtt.c       | 12 ++++++------
 drivers/gpu/drm/i915/gvt/gvt.c       |  6 +++---
 drivers/gpu/drm/i915/gvt/kvmgt.c     |  4 ++--
 5 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/cfg_space.c b/drivers/gpu/drm/i915/gvt/cfg_space.c
index ad86c5eb5bba..b490e3db2e38 100644
--- a/drivers/gpu/drm/i915/gvt/cfg_space.c
+++ b/drivers/gpu/drm/i915/gvt/cfg_space.c
@@ -374,6 +374,7 @@ void intel_vgpu_init_cfg_space(struct intel_vgpu *vgpu,
 			       bool primary)
 {
 	struct intel_gvt *gvt = vgpu->gvt;
+	struct pci_dev *pdev = to_pci_dev(gvt->gt->i915->drm.dev);
 	const struct intel_gvt_device_info *info = &gvt->device_info;
 	u16 *gmch_ctl;
 	u8 next;
@@ -407,9 +408,9 @@ void intel_vgpu_init_cfg_space(struct intel_vgpu *vgpu,
 	memset(vgpu_cfg_space(vgpu) + INTEL_GVT_PCI_OPREGION, 0, 4);
 
 	vgpu->cfg_space.bar[INTEL_GVT_PCI_BAR_GTTMMIO].size =
-		pci_resource_len(gvt->gt->i915->drm.pdev, 0);
+		pci_resource_len(pdev, 0);
 	vgpu->cfg_space.bar[INTEL_GVT_PCI_BAR_APERTURE].size =
-		pci_resource_len(gvt->gt->i915->drm.pdev, 2);
+		pci_resource_len(pdev, 2);
 
 	memset(vgpu_cfg_space(vgpu) + PCI_ROM_ADDRESS, 0, 4);
 
diff --git a/drivers/gpu/drm/i915/gvt/firmware.c b/drivers/gpu/drm/i915/gvt/firmware.c
index 990a181094e3..1a8274a3f4b1 100644
--- a/drivers/gpu/drm/i915/gvt/firmware.c
+++ b/drivers/gpu/drm/i915/gvt/firmware.c
@@ -76,7 +76,7 @@ static int mmio_snapshot_handler(struct intel_gvt *gvt, u32 offset, void *data)
 static int expose_firmware_sysfs(struct intel_gvt *gvt)
 {
 	struct intel_gvt_device_info *info = &gvt->device_info;
-	struct pci_dev *pdev = gvt->gt->i915->drm.pdev;
+	struct pci_dev *pdev = to_pci_dev(gvt->gt->i915->drm.dev);
 	struct gvt_firmware_header *h;
 	void *firmware;
 	void *p;
@@ -127,7 +127,7 @@ static int expose_firmware_sysfs(struct intel_gvt *gvt)
 
 static void clean_firmware_sysfs(struct intel_gvt *gvt)
 {
-	struct pci_dev *pdev = gvt->gt->i915->drm.pdev;
+	struct pci_dev *pdev = to_pci_dev(gvt->gt->i915->drm.dev);
 
 	device_remove_bin_file(&pdev->dev, &firmware_attr);
 	vfree(firmware_attr.private);
@@ -151,7 +151,7 @@ static int verify_firmware(struct intel_gvt *gvt,
 			   const struct firmware *fw)
 {
 	struct intel_gvt_device_info *info = &gvt->device_info;
-	struct pci_dev *pdev = gvt->gt->i915->drm.pdev;
+	struct pci_dev *pdev = to_pci_dev(gvt->gt->i915->drm.dev);
 	struct gvt_firmware_header *h;
 	unsigned long id, crc32_start;
 	const void *mem;
@@ -205,7 +205,7 @@ static int verify_firmware(struct intel_gvt *gvt,
 int intel_gvt_load_firmware(struct intel_gvt *gvt)
 {
 	struct intel_gvt_device_info *info = &gvt->device_info;
-	struct pci_dev *pdev = gvt->gt->i915->drm.pdev;
+	struct pci_dev *pdev = to_pci_dev(gvt->gt->i915->drm.dev);
 	struct intel_gvt_firmware *firmware = &gvt->firmware;
 	struct gvt_firmware_header *h;
 	const struct firmware *fw;
@@ -240,7 +240,7 @@ int intel_gvt_load_firmware(struct intel_gvt *gvt)
 
 	gvt_dbg_core("request hw state firmware %s...\n", path);
 
-	ret = request_firmware(&fw, path, &gvt->gt->i915->drm.pdev->dev);
+	ret = request_firmware(&fw, path, gvt->gt->i915->drm.dev);
 	kfree(path);
 
 	if (ret)
diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 897c007ea96a..6d12a5a401f6 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -746,7 +746,7 @@ static int detach_oos_page(struct intel_vgpu *vgpu,
 
 static void ppgtt_free_spt(struct intel_vgpu_ppgtt_spt *spt)
 {
-	struct device *kdev = &spt->vgpu->gvt->gt->i915->drm.pdev->dev;
+	struct device *kdev = spt->vgpu->gvt->gt->i915->drm.dev;
 
 	trace_spt_free(spt->vgpu->id, spt, spt->guest_page.type);
 
@@ -831,7 +831,7 @@ static int reclaim_one_ppgtt_mm(struct intel_gvt *gvt);
 static struct intel_vgpu_ppgtt_spt *ppgtt_alloc_spt(
 		struct intel_vgpu *vgpu, enum intel_gvt_gtt_type type)
 {
-	struct device *kdev = &vgpu->gvt->gt->i915->drm.pdev->dev;
+	struct device *kdev = vgpu->gvt->gt->i915->drm.dev;
 	struct intel_vgpu_ppgtt_spt *spt = NULL;
 	dma_addr_t daddr;
 	int ret;
@@ -2402,7 +2402,7 @@ static int alloc_scratch_pages(struct intel_vgpu *vgpu,
 				vgpu->gvt->device_info.gtt_entry_size_shift;
 	void *scratch_pt;
 	int i;
-	struct device *dev = &vgpu->gvt->gt->i915->drm.pdev->dev;
+	struct device *dev = vgpu->gvt->gt->i915->drm.dev;
 	dma_addr_t daddr;
 
 	if (drm_WARN_ON(&i915->drm,
@@ -2460,7 +2460,7 @@ static int alloc_scratch_pages(struct intel_vgpu *vgpu,
 static int release_scratch_page_tree(struct intel_vgpu *vgpu)
 {
 	int i;
-	struct device *dev = &vgpu->gvt->gt->i915->drm.pdev->dev;
+	struct device *dev = vgpu->gvt->gt->i915->drm.dev;
 	dma_addr_t daddr;
 
 	for (i = GTT_TYPE_PPGTT_PTE_PT; i < GTT_TYPE_MAX; i++) {
@@ -2732,7 +2732,7 @@ int intel_gvt_init_gtt(struct intel_gvt *gvt)
 {
 	int ret;
 	void *page;
-	struct device *dev = &gvt->gt->i915->drm.pdev->dev;
+	struct device *dev = gvt->gt->i915->drm.dev;
 	dma_addr_t daddr;
 
 	gvt_dbg_core("init gtt\n");
@@ -2781,7 +2781,7 @@ int intel_gvt_init_gtt(struct intel_gvt *gvt)
  */
 void intel_gvt_clean_gtt(struct intel_gvt *gvt)
 {
-	struct device *dev = &gvt->gt->i915->drm.pdev->dev;
+	struct device *dev = gvt->gt->i915->drm.dev;
 	dma_addr_t daddr = (dma_addr_t)(gvt->gtt.scratch_mfn <<
 					I915_GTT_PAGE_SHIFT);
 
diff --git a/drivers/gpu/drm/i915/gvt/gvt.c b/drivers/gpu/drm/i915/gvt/gvt.c
index d1d8ee4a5f16..aa7fc0dd1db5 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.c
+++ b/drivers/gpu/drm/i915/gvt/gvt.c
@@ -50,7 +50,7 @@ static struct intel_vgpu_type *intel_gvt_find_vgpu_type(struct intel_gvt *gvt,
 		const char *name)
 {
 	const char *driver_name =
-		dev_driver_string(&gvt->gt->i915->drm.pdev->dev);
+		dev_driver_string(gvt->gt->i915->drm.dev);
 	int i;
 
 	name += strlen(driver_name) + 1;
@@ -189,7 +189,7 @@ static const struct intel_gvt_ops intel_gvt_ops = {
 static void init_device_info(struct intel_gvt *gvt)
 {
 	struct intel_gvt_device_info *info = &gvt->device_info;
-	struct pci_dev *pdev = gvt->gt->i915->drm.pdev;
+	struct pci_dev *pdev = to_pci_dev(gvt->gt->i915->drm.dev);
 
 	info->max_support_vgpus = 8;
 	info->cfg_space_size = PCI_CFG_SPACE_EXP_SIZE;
@@ -376,7 +376,7 @@ int intel_gvt_init_device(struct drm_i915_private *i915)
 	intel_gvt_debugfs_init(gvt);
 
 	gvt_dbg_core("gvt device initialization is done\n");
-	intel_gvt_host.dev = &i915->drm.pdev->dev;
+	intel_gvt_host.dev = i915->drm.dev;
 	intel_gvt_host.initialized = true;
 	return 0;
 
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index 60f1a386dd06..551f00024e99 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -221,7 +221,7 @@ static int gvt_pin_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 static int gvt_dma_map_page(struct intel_vgpu *vgpu, unsigned long gfn,
 		dma_addr_t *dma_addr, unsigned long size)
 {
-	struct device *dev = &vgpu->gvt->gt->i915->drm.pdev->dev;
+	struct device *dev = vgpu->gvt->gt->i915->drm.dev;
 	struct page *page = NULL;
 	int ret;
 
@@ -244,7 +244,7 @@ static int gvt_dma_map_page(struct intel_vgpu *vgpu, unsigned long gfn,
 static void gvt_dma_unmap_page(struct intel_vgpu *vgpu, unsigned long gfn,
 		dma_addr_t dma_addr, unsigned long size)
 {
-	struct device *dev = &vgpu->gvt->gt->i915->drm.pdev->dev;
+	struct device *dev = vgpu->gvt->gt->i915->drm.dev;
 
 	dma_unmap_page(dev, dma_addr, size, PCI_DMA_BIDIRECTIONAL);
 	gvt_unpin_guest_page(vgpu, gfn, size);
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
