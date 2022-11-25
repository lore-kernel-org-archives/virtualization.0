Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E625CC43219
	for <virtualization@archiver.kernel.org>; Fri, 25 Nov 2022 15:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 83B3460BB0;
	Fri, 25 Nov 2022 15:06:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83B3460BB0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=R2Fg1ekp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G3rvuLDsyN96; Fri, 25 Nov 2022 15:06:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1A64A60B0F;
	Fri, 25 Nov 2022 15:06:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A64A60B0F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9524C0033;
	Fri, 25 Nov 2022 15:06:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC405C007D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FBC181EEE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FBC181EEE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=R2Fg1ekp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R-nwfrbk82ye
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D583481ED0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D583481ED0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669388787; x=1700924787;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=NGYzFwtP4Q2IeOFdkbC+DFqWio0Q5Y8YrDc4RNGvhPo=;
 b=R2Fg1ekp1gLrKbdOEoL8T8mCt+DamUfu5GhrSmgQS1P+bnt2LmRs9uCr
 qKr6o7rc2KFqwi4cVADTfgbWd992MJiJosdalxdUVNBPLkUmRQvkHarQn
 LRrp/bnmweK0RikwX3ppSlB0CgfYuQlKi8OWuhqajVdzJxTlPZ6p05arW
 AZhBVRA0yPirOLYpo4zA1QSBq7gN5ee+wZX7UWckQXPCgct23sSgNUmIg
 Aqk2g4j9qPBm25Hj2GFY4JDxw/FGTXAeH11lO34egwFD8b6+H2OhUDRmL
 xcfr2VVg1A0QHvGBzaTg2qyS0PCxrzcQHNKimxsnaCJ+YdqWhIc65JgWT w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="400787329"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="400787329"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="593240215"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="593240215"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:25 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH V2 02/12] vDPA/ifcvf: decouple config space ops from the
 adapter
Date: Fri, 25 Nov 2022 22:57:14 +0800
Message-Id: <20221125145724.1129962-3-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221125145724.1129962-1-lingshan.zhu@intel.com>
References: <20221125145724.1129962-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, piotr.uminski@intel.com, stable@vger.kernel.org,
 hang.yuan@intel.com, virtualization@lists.linux-foundation.org
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

This commit decopules the config space ops from the
adapter layer, so these functions can be invoked
once the device is probed.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 7a7e6ba66f88..3ec5ca3aefe1 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -10,11 +10,6 @@
 
 #include "ifcvf_base.h"
 
-struct ifcvf_adapter *vf_to_adapter(struct ifcvf_hw *hw)
-{
-	return container_of(hw, struct ifcvf_adapter, vf);
-}
-
 u16 ifcvf_set_vq_vector(struct ifcvf_hw *hw, u16 qid, int vector)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
@@ -37,8 +32,6 @@ u16 ifcvf_set_config_vector(struct ifcvf_hw *hw, int vector)
 static void __iomem *get_cap_addr(struct ifcvf_hw *hw,
 				  struct virtio_pci_cap *cap)
 {
-	struct ifcvf_adapter *ifcvf;
-	struct pci_dev *pdev;
 	u32 length, offset;
 	u8 bar;
 
@@ -46,17 +39,14 @@ static void __iomem *get_cap_addr(struct ifcvf_hw *hw,
 	offset = le32_to_cpu(cap->offset);
 	bar = cap->bar;
 
-	ifcvf= vf_to_adapter(hw);
-	pdev = ifcvf->pdev;
-
 	if (bar >= IFCVF_PCI_MAX_RESOURCE) {
-		IFCVF_DBG(pdev,
+		IFCVF_DBG(hw->pdev,
 			  "Invalid bar number %u to get capabilities\n", bar);
 		return NULL;
 	}
 
-	if (offset + length > pci_resource_len(pdev, bar)) {
-		IFCVF_DBG(pdev,
+	if (offset + length > pci_resource_len(hw->pdev, bar)) {
+		IFCVF_DBG(hw->pdev,
 			  "offset(%u) + len(%u) overflows bar%u's capability\n",
 			  offset, length, bar);
 		return NULL;
@@ -92,6 +82,7 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *pdev)
 		IFCVF_ERR(pdev, "Failed to read PCI capability list\n");
 		return -EIO;
 	}
+	hw->pdev = pdev;
 
 	while (pos) {
 		ret = ifcvf_read_config_range(pdev, (u32 *)&cap,
@@ -230,13 +221,11 @@ int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features)
 
 u32 ifcvf_get_config_size(struct ifcvf_hw *hw)
 {
-	struct ifcvf_adapter *adapter;
 	u32 net_config_size = sizeof(struct virtio_net_config);
 	u32 blk_config_size = sizeof(struct virtio_blk_config);
 	u32 cap_size = hw->cap_dev_config_size;
 	u32 config_size;
 
-	adapter = vf_to_adapter(hw);
 	/* If the onboard device config space size is greater than
 	 * the size of struct virtio_net/blk_config, only the spec
 	 * implementing contents size is returned, this is very
@@ -251,7 +240,7 @@ u32 ifcvf_get_config_size(struct ifcvf_hw *hw)
 		break;
 	default:
 		config_size = 0;
-		IFCVF_ERR(adapter->pdev, "VIRTIO ID %u not supported\n", hw->dev_type);
+		IFCVF_ERR(hw->pdev, "VIRTIO ID %u not supported\n", hw->dev_type);
 	}
 
 	return config_size;
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
