Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0DECC76196
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 12:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7004F420B4;
	Fri, 31 Mar 2023 12:49:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7004F420B4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cln/tB2z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YSh3hI_-sODX; Fri, 31 Mar 2023 12:49:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AC9634018E;
	Fri, 31 Mar 2023 12:49:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC9634018E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBB46C007C;
	Fri, 31 Mar 2023 12:49:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6C159C0036
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C0354018E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3C0354018E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wN0Y0xXKOyp5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7659240649
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7659240649
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680266950; x=1711802950;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wr4cWG2E22VrYVyphFWCtTcYry6bWTw+uAZKQEFX7ZQ=;
 b=cln/tB2zAs0zfK+2dM9ANApuVuOsV6XsZVsL2wxd8ZRz8I/OzGuI7Eqg
 w64U28NGDmdNE1QU9vb1gTYB5i/nTQm7pkQiB+d84T/3/EWRN3Frcjpvt
 tg9sLRT6nM+ONnVGHGLigPSM2S3shv047i7RjCm5or7jraJx90nPKo2d3
 khlj3bnuKqIafRGQa7O0QLpMfNVJdRf3AYu/UyTua4oR0lZgIqF7u7lI7
 2LAtnYXv3UjtrDUtkcIdLK/g5q/5/ZhpNhsRa7NyyduczS8FnJs9i2nfR
 7TTLFkBBzn3fk7uogK8ROEwR75hKqc5qLdR7c3OCEt7m0OUKOsgJnl0PT Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="404162354"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="404162354"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2023 05:49:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="931155967"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="931155967"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2023 05:49:01 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 2/5] get_driver_features from virito registers
Date: Sat,  1 Apr 2023 04:48:51 +0800
Message-Id: <20230331204854.20082-3-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230331204854.20082-1-lingshan.zhu@intel.com>
References: <20230331204854.20082-1-lingshan.zhu@intel.com>
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
