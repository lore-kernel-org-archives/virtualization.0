Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E4BC7EE25
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 08:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9F41740497;
	Fri,  9 Jun 2023 08:22:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F41740497
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HFA17wOZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IgYCzBZwDOI5; Fri,  9 Jun 2023 08:22:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3947540222;
	Fri,  9 Jun 2023 08:22:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3947540222
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1132EC007A;
	Fri,  9 Jun 2023 08:22:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91496C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8BFAD4015E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BFAD4015E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HzwKLF-CUm07
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF9C240222
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF9C240222
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686298939; x=1717834939;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VoXiGotKbDqJuFJce0suePS73LchiWEZLTZAy8M9z2I=;
 b=HFA17wOZqxXe9q+TFsgKLJ9k1sT3TixJgC66HhNsliGdKvlMFTsQ/IEk
 VOa2RfLw3mL8Rz9K07YrNTFsEmbh7Nb9DwIM8HEujhxVdSz5O3bDH6hd0
 D++TBMuYfxGa9Aq4ASYvWI5+Bjd8IY0RueKeY7mdd5g9VeHwjM+ZoBMgo
 qRftXLMT3oI9m1u47xl/n3/zyNZrnwBMl3MSRypHP1RK02BNCpqae0Oz2
 DBN1bIHOdnSLDSrPgiLT1DussYZsnRsDKnxXdQczR9H6N3S4iO/bqIOh9
 D848wK9+4W6ErakFGTIyDHwz7uWuovx4XG4/4KV2S6wiBWH1m8nnT311T Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342221805"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="342221805"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2023 01:22:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713423260"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="713423260"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 01:22:18 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 1/3] vDPA/ifcvf: dynamic allocate vq data stores
Date: Sat, 10 Jun 2023 00:21:58 +0800
Message-Id: <20230609162200.875433-2-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230609162200.875433-1-lingshan.zhu@intel.com>
References: <20230609162200.875433-1-lingshan.zhu@intel.com>
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

This commit dynamically allocates the data
stores for the virtqueues based on
virtio_pci_common_cfg.num_queues.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 4 ++++
 drivers/vdpa/ifcvf/ifcvf_base.h | 2 +-
 drivers/vdpa/ifcvf/ifcvf_main.c | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 5563b3a773c7..3c40caf4aa0b 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -134,6 +134,9 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *pdev)
 	}
 
 	hw->nr_vring = vp_ioread16(&hw->common_cfg->num_queues);
+	hw->vring = kzalloc(sizeof(struct vring_info) * hw->nr_vring, GFP_KERNEL);
+	if (!hw->vring)
+		return -ENOMEM;
 
 	for (i = 0; i < hw->nr_vring; i++) {
 		vp_iowrite16(i, &hw->common_cfg->queue_select);
@@ -316,6 +319,7 @@ u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
 
 int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
 {
+
 	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
 	void __iomem *avail_idx_addr;
 	u32 q_pair_id;
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index c20d1c40214e..745282239d6d 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -80,7 +80,7 @@ struct ifcvf_hw {
 	u64 dev_features;
 	struct virtio_pci_common_cfg __iomem *common_cfg;
 	void __iomem *dev_cfg;
-	struct vring_info vring[IFCVF_MAX_QUEUES];
+	struct vring_info *vring;
 	void __iomem * const *base;
 	char config_msix_name[256];
 	struct vdpa_callback config_cb;
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 7f78c47e40d6..c97dde02bbb6 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -892,6 +892,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err:
+	kfree(ifcvf_mgmt_dev->vf.vring);
 	kfree(ifcvf_mgmt_dev);
 	return ret;
 }
@@ -902,6 +903,7 @@ static void ifcvf_remove(struct pci_dev *pdev)
 
 	ifcvf_mgmt_dev = pci_get_drvdata(pdev);
 	vdpa_mgmtdev_unregister(&ifcvf_mgmt_dev->mdev);
+	kfree(ifcvf_mgmt_dev->vf.vring);
 	kfree(ifcvf_mgmt_dev);
 }
 
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
