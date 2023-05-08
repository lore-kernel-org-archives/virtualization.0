Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95D8C77B7F
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 10:05:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5CF5540A1E;
	Mon,  8 May 2023 10:05:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5CF5540A1E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I28PPrjy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IketqEugT3JW; Mon,  8 May 2023 10:05:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 829E4405ED;
	Mon,  8 May 2023 10:05:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 829E4405ED
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50040C0037;
	Mon,  8 May 2023 10:05:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C63DC002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2872841A49
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2872841A49
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=I28PPrjy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 14Xzc8GzI29v
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 084DA41B19
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 084DA41B19
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683540322; x=1715076322;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wr4cWG2E22VrYVyphFWCtTcYry6bWTw+uAZKQEFX7ZQ=;
 b=I28PPrjyqebkFF1znvV6VeIL1yME4V7IIIeulhlL/DfkLcyu2yY4R+Tx
 guXBb6v803APtKVWctBLK2H+d3FQWWuy9E6eH2KRs7HmCPrI37kKH7TI+
 u0ZTE3A6u0bYvV/4dV8Xq0X8cZZd7ocBRa8kSp9W4W7mFG6/zPnl3DjbO
 0nWpRm+YGt2KJ0kszVot6b25fdyoqWFPXdU+zWPEQbK0935rWqQb3lttA
 xuKcRfMoLdKfnTA5PmGRGdcSIbe/LXCrJAYV+peqivEFASdADjIdxZ0W3
 Lo5e7qYqYJjJxiKiB8kquf4YBME79SBs+J4NoMrbqbPBGTl7dkFL1x7kT A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="338828010"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; d="scan'208";a="338828010"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2023 03:05:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="842639035"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; d="scan'208";a="842639035"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga001.fm.intel.com with ESMTP; 08 May 2023 03:05:20 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 2/5] vDPA/ifcvf: get_driver_features from virtio registers
Date: Tue,  9 May 2023 02:05:09 +0800
Message-Id: <20230508180512.17371-3-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230508180512.17371-1-lingshan.zhu@intel.com>
References: <20230508180512.17371-1-lingshan.zhu@intel.com>
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

This commit implements a new function ifcvf_get_driver_feature()
which read driver_features from virtio registers.

To be less ambiguous, ifcvf_set_features() is renamed to
ifcvf_set_driver_features(), and ifcvf_get_features()
is renamed to ifcvf_get_dev_features() which returns
the provisioned vDPA device features.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 38 +++++++++++++++++----------------
 drivers/vdpa/ifcvf/ifcvf_base.h |  5 +++--
 drivers/vdpa/ifcvf/ifcvf_main.c |  9 +++++---
 3 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 6c5650f73007..546e923bcd16 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -204,11 +204,29 @@ u64 ifcvf_get_hw_features(struct ifcvf_hw *hw)
 	return features;
 }
 
-u64 ifcvf_get_features(struct ifcvf_hw *hw)
+/* return provisioned vDPA dev features */
+u64 ifcvf_get_dev_features(struct ifcvf_hw *hw)
 {
 	return hw->dev_features;
 }
 
+u64 ifcvf_get_driver_features(struct ifcvf_hw *hw)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
+	u32 features_lo, features_hi;
+	u64 features;
+
+	vp_iowrite32(0, &cfg->device_feature_select);
+	features_lo = vp_ioread32(&cfg->guest_feature);
+
+	vp_iowrite32(1, &cfg->device_feature_select);
+	features_hi = vp_ioread32(&cfg->guest_feature);
+
+	features = ((u64)features_hi << 32) | features_lo;
+
+	return features;
+}
+
 int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features)
 {
 	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)) && features) {
@@ -275,7 +293,7 @@ void ifcvf_write_dev_config(struct ifcvf_hw *hw, u64 offset,
 		vp_iowrite8(*p++, hw->dev_cfg + offset + i);
 }
 
-static void ifcvf_set_features(struct ifcvf_hw *hw, u64 features)
+void ifcvf_set_driver_features(struct ifcvf_hw *hw, u64 features)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
 
@@ -286,19 +304,6 @@ static void ifcvf_set_features(struct ifcvf_hw *hw, u64 features)
 	vp_iowrite32(features >> 32, &cfg->guest_feature);
 }
 
-static int ifcvf_config_features(struct ifcvf_hw *hw)
-{
-	ifcvf_set_features(hw, hw->req_features);
-	ifcvf_add_status(hw, VIRTIO_CONFIG_S_FEATURES_OK);
-
-	if (!(ifcvf_get_status(hw) & VIRTIO_CONFIG_S_FEATURES_OK)) {
-		IFCVF_ERR(hw->pdev, "Failed to set FEATURES_OK status\n");
-		return -EIO;
-	}
-
-	return 0;
-}
-
 u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
 {
 	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
@@ -387,9 +392,6 @@ int ifcvf_start_hw(struct ifcvf_hw *hw)
 	ifcvf_add_status(hw, VIRTIO_CONFIG_S_ACKNOWLEDGE);
 	ifcvf_add_status(hw, VIRTIO_CONFIG_S_DRIVER);
 
-	if (ifcvf_config_features(hw) < 0)
-		return -EINVAL;
-
 	ifcvf_add_status(hw, VIRTIO_CONFIG_S_DRIVER_OK);
 
 	return 0;
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index d545a9411143..cb19196c3ece 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -69,7 +69,6 @@ struct ifcvf_hw {
 	phys_addr_t notify_base_pa;
 	u32 notify_off_multiplier;
 	u32 dev_type;
-	u64 req_features;
 	u64 hw_features;
 	/* provisioned device features */
 	u64 dev_features;
@@ -122,7 +121,7 @@ u8 ifcvf_get_status(struct ifcvf_hw *hw);
 void ifcvf_set_status(struct ifcvf_hw *hw, u8 status);
 void io_write64_twopart(u64 val, u32 *lo, u32 *hi);
 void ifcvf_reset(struct ifcvf_hw *hw);
-u64 ifcvf_get_features(struct ifcvf_hw *hw);
+u64 ifcvf_get_dev_features(struct ifcvf_hw *hw);
 u64 ifcvf_get_hw_features(struct ifcvf_hw *hw);
 int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features);
 u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid);
@@ -137,4 +136,6 @@ int ifcvf_set_vq_address(struct ifcvf_hw *hw, u16 qid, u64 desc_area,
 			 u64 driver_area, u64 device_area);
 bool ifcvf_get_vq_ready(struct ifcvf_hw *hw, u16 qid);
 void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready);
+void ifcvf_set_driver_features(struct ifcvf_hw *hw, u64 features);
+u64 ifcvf_get_driver_features(struct ifcvf_hw *hw);
 #endif /* _IFCVF_H_ */
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 1357c67014ab..4588484bd53d 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -410,7 +410,7 @@ static u64 ifcvf_vdpa_get_device_features(struct vdpa_device *vdpa_dev)
 	u64 features;
 
 	if (type == VIRTIO_ID_NET || type == VIRTIO_ID_BLOCK)
-		features = ifcvf_get_features(vf);
+		features = ifcvf_get_dev_features(vf);
 	else {
 		features = 0;
 		IFCVF_ERR(pdev, "VIRTIO ID %u not supported\n", vf->dev_type);
@@ -428,7 +428,7 @@ static int ifcvf_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 feat
 	if (ret)
 		return ret;
 
-	vf->req_features = features;
+	ifcvf_set_driver_features(vf, features);
 
 	return 0;
 }
@@ -436,8 +436,11 @@ static int ifcvf_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 feat
 static u64 ifcvf_vdpa_get_driver_features(struct vdpa_device *vdpa_dev)
 {
 	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
+	u64 features;
+
+	features = ifcvf_get_driver_features(vf);
 
-	return vf->req_features;
+	return features;
 }
 
 static u8 ifcvf_vdpa_get_status(struct vdpa_device *vdpa_dev)
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
