Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D0EC43219
	for <virtualization@archiver.kernel.org>; Mon,  7 Nov 2022 09:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6450815AB;
	Mon,  7 Nov 2022 09:42:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6450815AB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DyWTlvex
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UxtI4lUky9iI; Mon,  7 Nov 2022 09:42:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 35DD781496;
	Mon,  7 Nov 2022 09:42:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 35DD781496
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 121EBC0032;
	Mon,  7 Nov 2022 09:42:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D16CC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6194B40391
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:42:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6194B40391
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DyWTlvex
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Llp5EEU7rIzZ
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:42:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A49D0403CA
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A49D0403CA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Nov 2022 09:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667814140; x=1699350140;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=H9gKd8KiwI+8Z8/tPxWpO+a0VKVq7oUxBrMwJjaDjY8=;
 b=DyWTlvexdy/7m7nxGiS7t3/CIR6wUfvfOJf2TTO8G9uhq9yc59b5cC5n
 BvfklDJ6VY+H4oL5wYNxYd/urNp/24eEupOATfX306HRUq0YkbLx0ywYZ
 XzzO3X6MWt+3G7BoRyh3FU8viuLn8eXvXTsiVPk/2ILauTVZ0X7RKh+0B
 weuVNsn3hKTQBSWMBvkihVf+cDRE/LUJCwn8phK0lhLNXt7ma5Y18+Ps6
 YjY5dCNqft6Lm3Y717q72/P0t3Ayf7tJK21ew0Tgz9hc+OLtLGPAC/Z/W
 JbryLYKpsvT0RficzyJsxMUFY+nSbKKyd04jUNa1rrMV4uhziqaISJKCB Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="396668850"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; d="scan'208";a="396668850"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2022 01:42:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10523"; a="704810803"
X-IronPort-AV: E=Sophos;i="5.96,143,1665471600"; d="scan'208";a="704810803"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2022 01:42:18 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH 1/4] vDPA/ifcvf: ifcvf base layer interfaces work on struct
 ifcvf_hw
Date: Mon,  7 Nov 2022 17:33:42 +0800
Message-Id: <20221107093345.121648-2-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221107093345.121648-1-lingshan.zhu@intel.com>
References: <20221107093345.121648-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Cc: piotr.uminski@intel.com, hang.yuan@intel.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

To be more rubust and low coupling in ifcvf base layer,
this commit gets rid of struct ifcvf_adapter in ifcvf_base
which is introduced in ifcvf_main.

Now ifcvf base layer interfaces work on ifcvf_hw only, so that
the base interfaces can be safely invoked since probe.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 30 +++++++-----------------------
 drivers/vdpa/ifcvf/ifcvf_base.h |  2 ++
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 3e4486bfa0b7..3ec5ca3aefe1 100644
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
@@ -220,10 +211,8 @@ u64 ifcvf_get_features(struct ifcvf_hw *hw)
 
 int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features)
 {
-	struct ifcvf_adapter *ifcvf = vf_to_adapter(hw);
-
 	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)) && features) {
-		IFCVF_ERR(ifcvf->pdev, "VIRTIO_F_ACCESS_PLATFORM is not negotiated\n");
+		IFCVF_ERR(hw->pdev, "VIRTIO_F_ACCESS_PLATFORM is not negotiated\n");
 		return -EINVAL;
 	}
 
@@ -232,13 +221,11 @@ int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features)
 
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
@@ -253,7 +240,7 @@ u32 ifcvf_get_config_size(struct ifcvf_hw *hw)
 		break;
 	default:
 		config_size = 0;
-		IFCVF_ERR(adapter->pdev, "VIRTIO ID %u not supported\n", hw->dev_type);
+		IFCVF_ERR(hw->pdev, "VIRTIO ID %u not supported\n", hw->dev_type);
 	}
 
 	return config_size;
@@ -301,14 +288,11 @@ static void ifcvf_set_features(struct ifcvf_hw *hw, u64 features)
 
 static int ifcvf_config_features(struct ifcvf_hw *hw)
 {
-	struct ifcvf_adapter *ifcvf;
-
-	ifcvf = vf_to_adapter(hw);
 	ifcvf_set_features(hw, hw->req_features);
 	ifcvf_add_status(hw, VIRTIO_CONFIG_S_FEATURES_OK);
 
 	if (!(ifcvf_get_status(hw) & VIRTIO_CONFIG_S_FEATURES_OK)) {
-		IFCVF_ERR(ifcvf->pdev, "Failed to set FEATURES_OK status\n");
+		IFCVF_ERR(hw->pdev, "Failed to set FEATURES_OK status\n");
 		return -EIO;
 	}
 
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index f5563f665cc6..63ce1f7f6841 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -89,6 +89,7 @@ struct ifcvf_hw {
 	u16 nr_vring;
 	/* VIRTIO_PCI_CAP_DEVICE_CFG size */
 	u32 cap_dev_config_size;
+	struct pci_dev *pdev;
 };
 
 struct ifcvf_adapter {
@@ -110,6 +111,7 @@ struct ifcvf_lm_cfg {
 struct ifcvf_vdpa_mgmt_dev {
 	struct vdpa_mgmt_dev mdev;
 	struct ifcvf_adapter *adapter;
+	struct ifcvf_hw vf;
 	struct pci_dev *pdev;
 };
 
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
