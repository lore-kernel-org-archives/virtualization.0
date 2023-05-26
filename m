Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D1FC77B7C
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 06:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8475542C81;
	Fri, 26 May 2023 06:53:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8475542C81
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QvlZbgHq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yUsMKcWIUPPR; Fri, 26 May 2023 06:53:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CD64142C84;
	Fri, 26 May 2023 06:53:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CD64142C84
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AD69C0036;
	Fri, 26 May 2023 06:53:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6EBBC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A511C42A7A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A511C42A7A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JhB0dh5U-NOv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E0A424016B
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E0A424016B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685083994; x=1716619994;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=9F9LmGPO5FSGmoArvKq7z8U/4KUADaDzCeDaG4k0GYo=;
 b=QvlZbgHq68SObZZhwTBdb3/9XwJ8fe/JTn/ofsrSeRzpolMj/Ie2Esyx
 YrxjUwG/SuF66an9h5uuRHEZDW7Bce3+mabYVSTaLSk9izP1/xrbUQoYH
 tSs1PYfcR5lIVduXionhComBi5XDsJIR+I1+3nYTr8U864OJB2iGcmTA5
 mQO7OgLZLgqMmczOJ6T0/vh7aHha3KGc9AgP0WLZTEAnobudU9BKScar4
 qgLQdUSgh2V9WKLxi9uqO0iZOelc9Wh3lkvLvcTIzAe7FTeEhgZdLCww+
 ebdbZgFKGffnr4unSpFVPk1MGx6Wf+Qc769w4/VBSy8k1dwvYoI732m4G g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="333763361"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="333763361"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 23:53:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="770241641"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="770241641"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga008.fm.intel.com with ESMTP; 25 May 2023 23:53:13 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V3 1/5] vDPA/ifcvf: virt queue ops take immediate actions
Date: Fri, 26 May 2023 22:52:50 +0800
Message-Id: <20230526145254.39537-2-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230526145254.39537-1-lingshan.zhu@intel.com>
References: <20230526145254.39537-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org
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

In this commit, virtqueue operations including:
set_vq_num(), set_vq_address(), set_vq_ready()
and get_vq_ready() access PCI registers directly
to take immediate actions.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 58 ++++++++++++++++++++-------------
 drivers/vdpa/ifcvf/ifcvf_base.h | 10 +++---
 drivers/vdpa/ifcvf/ifcvf_main.c | 16 +++------
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 5563b3a773c7..6c5650f73007 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -329,31 +329,49 @@ int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
 	return 0;
 }
 
-static int ifcvf_hw_enable(struct ifcvf_hw *hw)
+void ifcvf_set_vq_num(struct ifcvf_hw *hw, u16 qid, u32 num)
 {
-	struct virtio_pci_common_cfg __iomem *cfg;
-	u32 i;
+	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
 
-	cfg = hw->common_cfg;
-	for (i = 0; i < hw->nr_vring; i++) {
-		if (!hw->vring[i].ready)
-			break;
+	vp_iowrite16(qid, &cfg->queue_select);
+	vp_iowrite16(num, &cfg->queue_size);
+}
 
-		vp_iowrite16(i, &cfg->queue_select);
-		vp_iowrite64_twopart(hw->vring[i].desc, &cfg->queue_desc_lo,
-				     &cfg->queue_desc_hi);
-		vp_iowrite64_twopart(hw->vring[i].avail, &cfg->queue_avail_lo,
-				      &cfg->queue_avail_hi);
-		vp_iowrite64_twopart(hw->vring[i].used, &cfg->queue_used_lo,
-				     &cfg->queue_used_hi);
-		vp_iowrite16(hw->vring[i].size, &cfg->queue_size);
-		ifcvf_set_vq_state(hw, i, hw->vring[i].last_avail_idx);
-		vp_iowrite16(1, &cfg->queue_enable);
-	}
+int ifcvf_set_vq_address(struct ifcvf_hw *hw, u16 qid, u64 desc_area,
+			 u64 driver_area, u64 device_area)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
+
+	vp_iowrite16(qid, &cfg->queue_select);
+	vp_iowrite64_twopart(desc_area, &cfg->queue_desc_lo,
+			     &cfg->queue_desc_hi);
+	vp_iowrite64_twopart(driver_area, &cfg->queue_avail_lo,
+			     &cfg->queue_avail_hi);
+	vp_iowrite64_twopart(device_area, &cfg->queue_used_lo,
+			     &cfg->queue_used_hi);
 
 	return 0;
 }
 
+bool ifcvf_get_vq_ready(struct ifcvf_hw *hw, u16 qid)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
+	u16 queue_enable;
+
+	vp_iowrite16(qid, &cfg->queue_select);
+	queue_enable = vp_ioread16(&cfg->queue_enable);
+
+	return (bool)queue_enable;
+}
+
+void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
+
+	vp_iowrite16(qid, &cfg->queue_select);
+	vp_iowrite16(ready, &cfg->queue_enable);
+}
+
 static void ifcvf_hw_disable(struct ifcvf_hw *hw)
 {
 	u32 i;
@@ -366,16 +384,12 @@ static void ifcvf_hw_disable(struct ifcvf_hw *hw)
 
 int ifcvf_start_hw(struct ifcvf_hw *hw)
 {
-	ifcvf_reset(hw);
 	ifcvf_add_status(hw, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 	ifcvf_add_status(hw, VIRTIO_CONFIG_S_DRIVER);
 
 	if (ifcvf_config_features(hw) < 0)
 		return -EINVAL;
 
-	if (ifcvf_hw_enable(hw) < 0)
-		return -EINVAL;
-
 	ifcvf_add_status(hw, VIRTIO_CONFIG_S_DRIVER_OK);
 
 	return 0;
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index c20d1c40214e..d545a9411143 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -47,12 +47,7 @@
 #define MSIX_VECTOR_DEV_SHARED			3
 
 struct vring_info {
-	u64 desc;
-	u64 avail;
-	u64 used;
-	u16 size;
 	u16 last_avail_idx;
-	bool ready;
 	void __iomem *notify_addr;
 	phys_addr_t notify_pa;
 	u32 irq;
@@ -137,4 +132,9 @@ int ifcvf_probed_virtio_net(struct ifcvf_hw *hw);
 u32 ifcvf_get_config_size(struct ifcvf_hw *hw);
 u16 ifcvf_set_vq_vector(struct ifcvf_hw *hw, u16 qid, int vector);
 u16 ifcvf_set_config_vector(struct ifcvf_hw *hw, int vector);
+void ifcvf_set_vq_num(struct ifcvf_hw *hw, u16 qid, u32 num);
+int ifcvf_set_vq_address(struct ifcvf_hw *hw, u16 qid, u64 desc_area,
+			 u64 driver_area, u64 device_area);
+bool ifcvf_get_vq_ready(struct ifcvf_hw *hw, u16 qid);
+void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready);
 #endif /* _IFCVF_H_ */
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 7f78c47e40d6..1357c67014ab 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -382,10 +382,6 @@ static void ifcvf_reset_vring(struct ifcvf_adapter *adapter)
 
 	for (i = 0; i < vf->nr_vring; i++) {
 		vf->vring[i].last_avail_idx = 0;
-		vf->vring[i].desc = 0;
-		vf->vring[i].avail = 0;
-		vf->vring[i].used = 0;
-		vf->vring[i].ready = 0;
 		vf->vring[i].cb.callback = NULL;
 		vf->vring[i].cb.private = NULL;
 	}
@@ -542,14 +538,14 @@ static void ifcvf_vdpa_set_vq_ready(struct vdpa_device *vdpa_dev,
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	vf->vring[qid].ready = ready;
+	ifcvf_set_vq_ready(vf, qid, ready);
 }
 
 static bool ifcvf_vdpa_get_vq_ready(struct vdpa_device *vdpa_dev, u16 qid)
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	return vf->vring[qid].ready;
+	return ifcvf_get_vq_ready(vf, qid);
 }
 
 static void ifcvf_vdpa_set_vq_num(struct vdpa_device *vdpa_dev, u16 qid,
@@ -557,7 +553,7 @@ static void ifcvf_vdpa_set_vq_num(struct vdpa_device *vdpa_dev, u16 qid,
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	vf->vring[qid].size = num;
+	ifcvf_set_vq_num(vf, qid, num);
 }
 
 static int ifcvf_vdpa_set_vq_address(struct vdpa_device *vdpa_dev, u16 qid,
@@ -566,11 +562,7 @@ static int ifcvf_vdpa_set_vq_address(struct vdpa_device *vdpa_dev, u16 qid,
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
 
-	vf->vring[qid].desc = desc_area;
-	vf->vring[qid].avail = driver_area;
-	vf->vring[qid].used = device_area;
-
-	return 0;
+	return ifcvf_set_vq_address(vf, qid, desc_area, driver_area, device_area);
 }
 
 static void ifcvf_vdpa_kick_vq(struct vdpa_device *vdpa_dev, u16 qid)
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
