Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3856BC7EE23
	for <virtualization@archiver.kernel.org>; Mon, 12 Jun 2023 07:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ADEB3820DD;
	Mon, 12 Jun 2023 07:14:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ADEB3820DD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DNITR/vS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8DJKYDnBoSC4; Mon, 12 Jun 2023 07:14:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 108FA820B7;
	Mon, 12 Jun 2023 07:14:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 108FA820B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE42DC0037;
	Mon, 12 Jun 2023 07:14:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05E44C0090
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D53B240C12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D53B240C12
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=DNITR/vS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EuEzLl-uV7CS
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4B0C940BF0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4B0C940BF0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686554085; x=1718090085;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DSo9cYRxylhf48KNMz/DgxDalkcS8fMtVxW5KYdihIE=;
 b=DNITR/vSGixyWi6xZ94rss2sooQe2PZ3tKkGzfNf4733gAstxpD8smMr
 DlMxpDEjyKl+wJBM8kiSR9dP+WWHrN4Pi/sJ1mhufJdxI2vSlYEWf10GW
 koh8XPqQ+oD12LRmZ5jwNwxPimEuAbpp/0KGU2MuEk8gbFDGXMkEroWNP
 j/mOzJOhQNpGZvT8NpC3SERSLq7Smxs4N+43TE+FGrjF89YM/WdOoF97W
 2fbG9U3LHUJproYypvc1bTJSVCaJhfANhKt+C/BWQD8qe7BRA+B8SigZl
 zKAwoh58QynO/ZkcZSNMfWn/uGtQulS9WoovdVv3FfSACtS1fxmLvE+cu Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="444339935"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="444339935"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2023 00:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="661470845"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="661470845"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 00:14:43 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 2/3] vDPA/ifcvf: detect and report max allowed vq size
Date: Mon, 12 Jun 2023 23:14:19 +0800
Message-Id: <20230612151420.1019504-3-lingshan.zhu@intel.com>
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

Rather than a hardcode, this commit detects
and reports the max value of allowed size
of the virtqueues

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 31 +++++++++++++++++++++++++++++++
 drivers/vdpa/ifcvf/ifcvf_base.h |  2 +-
 drivers/vdpa/ifcvf/ifcvf_main.c |  4 +++-
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index f86495ace825..f4d7d96c4c86 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -69,6 +69,37 @@ static int ifcvf_read_config_range(struct pci_dev *dev,
 	return 0;
 }
 
+static u16 ifcvf_get_vq_size(struct ifcvf_hw *hw, u16 qid)
+{
+	u16 queue_size;
+
+	vp_iowrite16(qid, &hw->common_cfg->queue_select);
+	queue_size = vp_ioread16(&hw->common_cfg->queue_size);
+
+	return queue_size;
+}
+
+/* This function returns the max allowed safe size for
+ * all virtqueues. It is the minimal size that can be
+ * suppprted by all virtqueues.
+ */
+u16 ifcvf_get_max_vq_size(struct ifcvf_hw *hw)
+{
+	u16 queue_size, max_size, qid;
+
+	max_size = ifcvf_get_vq_size(hw, 0);
+	for (qid = 1; qid < hw->nr_vring; qid++) {
+		queue_size = ifcvf_get_vq_size(hw, qid);
+		/* 0 means the queue is unavailable */
+		if (!queue_size)
+			continue;
+
+		max_size = min(queue_size, max_size);
+	}
+
+	return max_size;
+}
+
 int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *pdev)
 {
 	struct virtio_pci_cap cap;
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index fa797184056b..30935a95b672 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -28,7 +28,6 @@
 #define IFCVF_MAX_QUEUES	17
 
 #define IFCVF_QUEUE_ALIGNMENT	PAGE_SIZE
-#define IFCVF_QUEUE_MAX		32768
 #define IFCVF_PCI_MAX_RESOURCE	6
 
 #define IFCVF_LM_CFG_SIZE		0x40
@@ -138,4 +137,5 @@ bool ifcvf_get_vq_ready(struct ifcvf_hw *hw, u16 qid);
 void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready);
 void ifcvf_set_driver_features(struct ifcvf_hw *hw, u64 features);
 u64 ifcvf_get_driver_features(struct ifcvf_hw *hw);
+u16 ifcvf_get_max_vq_size(struct ifcvf_hw *hw);
 #endif /* _IFCVF_H_ */
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 2af0de771b49..c3ece395caf7 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -451,7 +451,9 @@ static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev)
 
 static u16 ifcvf_vdpa_get_vq_num_max(struct vdpa_device *vdpa_dev)
 {
-	return IFCVF_QUEUE_MAX;
+	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
+
+	return ifcvf_get_max_vq_size(vf);
 }
 
 static int ifcvf_vdpa_get_vq_state(struct vdpa_device *vdpa_dev, u16 qid,
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
