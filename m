Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1A3C7EE25
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 08:22:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 31DC161578;
	Fri,  9 Jun 2023 08:22:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 31DC161578
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=evOwZmwX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yc8jdexlQ2bK; Fri,  9 Jun 2023 08:22:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8F07961570;
	Fri,  9 Jun 2023 08:22:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8F07961570
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76914C007A;
	Fri,  9 Jun 2023 08:22:26 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60A89C007A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2E49B405F4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2E49B405F4
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=evOwZmwX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8k73gFedsmsy
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 685C040497
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 685C040497
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686298944; x=1717834944;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=eFFrBEQXlhkQzX1F+zd/W/CJ2BvhiaQvGSGppUiIEaI=;
 b=evOwZmwXAaKjbQQ+NtO5BOzJrmP+Jamj6csKe/anR0qw26UXaP0wzFj8
 gQ1Typks79vK9P353IF1bpRNxnwhoM+48/jEx1dg+kXxRkg87R6KGvH1b
 WyFGn+x8BbY9xpsjFCpyWDnd0UXHh/0m2gqymvA5pSTb8KKgwMuCyO13H
 mPWlKZX2RgDpzKGx91XH79O4LP8GFFT8FF3mDm613NIO0S7fRtsnAkvqW
 8+D8wotyknqZYBto8qsS90hD8UDNM0EUuHxkc8nkgLIWMnho6oFDoaxdP
 4GQNTvWWJBhYuJVR+w7dzaVNjmPTICmFvRNxpb82XsxZbim0RrUuiCOu6 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342221810"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="342221810"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2023 01:22:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713423273"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="713423273"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 01:22:21 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 3/3] vDPA/ifcvf: implement new accessors for vq_state
Date: Sat, 10 Jun 2023 00:22:00 +0800
Message-Id: <20230609162200.875433-4-lingshan.zhu@intel.com>
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

This commit implements a better layout of the
live migration bar, therefore the accessors for virtqueue
state have been refactored.

This commit also add a comment to the probing-ids list,
indicating this driver drives F2000X-PL virtio-net

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 20 ++++----------------
 drivers/vdpa/ifcvf/ifcvf_base.h | 22 +++++++++-------------
 drivers/vdpa/ifcvf/ifcvf_main.c |  4 +++-
 3 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 5f83524aa727..e04eeeccce05 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -335,31 +335,19 @@ static int ifcvf_config_features(struct ifcvf_hw *hw)
 
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
+	struct ifcvf_lm_cfg  __iomem *lm_cfg = hw->lm_cfg;
 
-	struct ifcvf_lm_cfg __iomem *ifcvf_lm;
-	void __iomem *avail_idx_addr;
-	u32 q_pair_id;
-
-	ifcvf_lm = (struct ifcvf_lm_cfg __iomem *)hw->lm_cfg;
-	q_pair_id = qid / 2;
-	avail_idx_addr = &ifcvf_lm->vring_lm_cfg[q_pair_id].idx_addr[qid % 2];
-	hw->vring[qid].last_avail_idx = num;
-	vp_iowrite16(num, avail_idx_addr);
+	vp_iowrite16(num, &lm_cfg->vq_state_region + qid * 2);
 
 	return 0;
 }
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index e7803cc4ef39..2c11734a5270 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -30,8 +30,6 @@
 #define IFCVF_QUEUE_ALIGNMENT	PAGE_SIZE
 #define IFCVF_PCI_MAX_RESOURCE	6
 
-#define IFCVF_LM_CFG_SIZE		0x40
-#define IFCVF_LM_RING_STATE_OFFSET	0x20
 #define IFCVF_LM_BAR			4
 
 #define IFCVF_ERR(pdev, fmt, ...)	dev_err(&pdev->dev, fmt, ##__VA_ARGS__)
@@ -59,10 +57,18 @@ struct vring_info {
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
@@ -97,16 +103,6 @@ struct ifcvf_adapter {
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
index d7875b461a5f..f25e413636dc 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -915,7 +915,9 @@ static struct pci_device_id ifcvf_pci_ids[] = {
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
