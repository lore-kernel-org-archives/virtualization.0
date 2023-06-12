Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4273C7EE2E
	for <virtualization@archiver.kernel.org>; Mon, 12 Jun 2023 07:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BBEA60E7A;
	Mon, 12 Jun 2023 07:14:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7BBEA60E7A
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RGzMII0w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5dRUfafwUvcM; Mon, 12 Jun 2023 07:14:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EFF7C60BD4;
	Mon, 12 Jun 2023 07:14:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFF7C60BD4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27EC4C008E;
	Mon, 12 Jun 2023 07:14:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E407C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C42F9403E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C42F9403E5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=RGzMII0w
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GNwkgQa6gBkK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 072C040BF0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 072C040BF0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686554087; x=1718090087;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HkhkU5qWmc5hxeNwjPVYIKhJiOMnH39/5aSyu6D62m4=;
 b=RGzMII0wG0gR1blYNWi75mY1uxGTTBfh3HB1re4s9xo/gtqBhFJ7LpM0
 BPmVMCeYnR5siCbT/xNQ1/LeT89VIuTN470Kl/Nye8Ms7nKhpJLuY/ka2
 L+WEG3QTRt8cQ1H3ePX7G0LAS63BnDml79t3AHU/Uy73LB5d89AwJZhOt
 0ka/V633mNTq60CohCkknLeXhAJJtffzwId4+XAsP6T3dyGH2Dg68/c2x
 uUpeBmGaSyhMyhNkUuzC+GGJx+ECxL/bssgU+HYN5o8jyjAAV+HUCfpM7
 Tz1gfwiuXdzzytbIygXz08zVpzh7+VPemVkjje3oNF99CvH0WSuV+wDLL Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="444339938"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="444339938"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2023 00:14:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="661470848"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="661470848"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 00:14:45 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 3/3] vDPA/ifcvf: implement new accessors for vq_state
Date: Mon, 12 Jun 2023 23:14:20 +0800
Message-Id: <20230612151420.1019504-4-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230612151420.1019504-1-lingshan.zhu@intel.com>
References: <20230612151420.1019504-1-lingshan.zhu@intel.com>
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

This commit implements a better layout of the
live migration bar, therefore the accessors for virtqueue
state have been refactored.

This commit also add a comment to the probing-ids list,
indicating this driver drives F2000X-PL virtio-net

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 21 +++++----------------
 drivers/vdpa/ifcvf/ifcvf_base.h | 25 +++++++++----------------
 drivers/vdpa/ifcvf/ifcvf_main.c |  4 +++-
 3 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index f4d7d96c4c86..060f837a4f9f 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -328,30 +328,19 @@ void ifcvf_set_driver_features(struct ifcvf_hw *hw, u64 features)
 
 u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
 {
-	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
-	void __iomem *avail_idx_addr;
+	struct ifcvf_lm_cfg  __iomem *lm_cfg = hw->lm_cfg;
 	u16 last_avail_idx;
-	u32 q_pair_id;
 
-	ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
-	q_pair_id = qid / 2;
-	avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
-	last_avail_idx = vp_ioread16(avail_idx_addr);
+	last_avail_idx = vp_ioread16(&lm_cfg->vq_state_region + qid * 2);
 
 	return last_avail_idx;
 }
 
 int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
 {
-	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
-	void __iomem *avail_idx_addr;
-	u32 q_pair_id;
-
-	ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
-	q_pair_id = qid / 2;
-	avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
-	hw->vring[qid].last_avail_idx = num;
-	vp_iowrite16(num, avail_idx_addr);
+	struct ifcvf_lm_cfg  __iomem *lm_cfg = hw->lm_cfg;
+
+	vp_iowrite16(num, &lm_cfg->vq_state_region + qid * 2);
 
 	return 0;
 }
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index 30935a95b672..b57849c643f6 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -24,14 +24,9 @@
 #define N3000_DEVICE_ID		0x1041
 #define N3000_SUBSYS_DEVICE_ID	0x001A
 
-/* Max 8 data queue pairs(16 queues) and one control vq for now. */
-#define IFCVF_MAX_QUEUES	17
-
 #define IFCVF_QUEUE_ALIGNMENT	PAGE_SIZE
 #define IFCVF_PCI_MAX_RESOURCE	6
 
-#define IFCVF_LM_CFG_SIZE		0x40
-#define IFCVF_LM_RING_STATE_OFFSET	0x20
 #define IFCVF_LM_BAR			4
 
 #define IFCVF_ERR(pdev, fmt, ...)	dev_err(&pdev->dev, fmt, ##__VA_ARGS__)
@@ -54,10 +49,18 @@ struct vring_info {
 	char msix_name[256];
 };
 
+struct ifcvf_lm_cfg {
+	__le64 control;
+	__le64 status;
+	__le64 lm_mem_log_start_addr;
+	__le64 lm_mem_log_end_addr;
+	__le16 vq_state_region;
+};
+
 struct ifcvf_hw {
 	u8 __iomem *isr;
 	/* Live migration */
-	u8 __iomem *lm_cfg;
+	struct ifcvf_lm_cfg  __iomem *lm_cfg;
 	/* Notification bar number */
 	u8 notify_bar;
 	u8 msix_vector_status;
@@ -92,16 +95,6 @@ struct ifcvf_adapter {
 	struct ifcvf_hw *vf;
 };
 
-struct ifcvf_vring_lm_cfg {
-	u32 idx_addr[2];
-	u8 reserved[IFCVF_LM_CFG_SIZE - 8];
-};
-
-struct ifcvf_lm_cfg {
-	u8 reserved[IFCVF_LM_RING_STATE_OFFSET];
-	struct ifcvf_vring_lm_cfg vring_lm_cfg[IFCVF_MAX_QUEUES];
-};
-
 struct ifcvf_vdpa_mgmt_dev {
 	struct vdpa_mgmt_dev mdev;
 	struct ifcvf_hw vf;
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index c3ece395caf7..e98fa8100f3c 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -853,7 +853,9 @@ static struct pci_device_id ifcvf_pci_ids[] = {
 			 N3000_DEVICE_ID,
 			 PCI_VENDOR_ID_INTEL,
 			 N3000_SUBSYS_DEVICE_ID) },
-	/* C5000X-PL network device */
+	/* C5000X-PL network device
+	 * F2000X-PL network device
+	 */
 	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_REDHAT_QUMRANET,
 			 VIRTIO_TRANS_ID_NET,
 			 PCI_VENDOR_ID_INTEL,
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
