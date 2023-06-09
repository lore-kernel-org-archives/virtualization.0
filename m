Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074B0C7EE2E
	for <virtualization@archiver.kernel.org>; Fri,  9 Jun 2023 08:22:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 65FA783D0F;
	Fri,  9 Jun 2023 08:22:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65FA783D0F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MY+uUDqX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5hL67t6UDUk2; Fri,  9 Jun 2023 08:22:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EBEDB84192;
	Fri,  9 Jun 2023 08:22:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBEDB84192
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43DDAC008E;
	Fri,  9 Jun 2023 08:22:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57BF7C0029
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D85D402DC
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1D85D402DC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=MY+uUDqX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yoe4anMN6o6v
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5EF1340222
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5EF1340222
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Jun 2023 08:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686298941; x=1717834941;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Z65vK23yGZVTlJXZSGYvQGQKn9Kz5FXPozRaDlFuMDA=;
 b=MY+uUDqXWmcbvxkORwdGmsqbkEfnFVBZK+msSnA1HKWJ0mrIYA7TqCPu
 9n5hk6xM3a9xKdMOcYXPFcHAu/vs5PPKftJW3ja0iBQMKmScL6dHtRvhD
 38SV+0oCxGGeqeLg+mTAWQzNnil7MlUYZA3ZgeFqs0I/anDubSIhZ4xhm
 C0+a/pbhbfhWgGwxRbSvjKDZ0iez2eAwEfRV32XaWPVh9Nu/ux+JIbUc7
 2Mg/Fh2kOYAUWtz+1bpm0bdSHONTh5N5JzpU8U3DLJypXEc587kK3sVLd
 DV391mEL/jQIvltGzQ/u/+qwl2od926fgV8jTRUXEt3FmboBpxd6fPzDE w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342221807"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="342221807"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2023 01:22:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="713423266"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="713423266"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2023 01:22:19 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 2/3] vDPA/ifcvf: detect and report max allowed vq size
Date: Sat, 10 Jun 2023 00:21:59 +0800
Message-Id: <20230609162200.875433-3-lingshan.zhu@intel.com>
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
index 3c40caf4aa0b..5f83524aa727 100644
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
+		/* 0 means the queue is unavailable*/
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
index 745282239d6d..e7803cc4ef39 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -28,7 +28,6 @@
 #define IFCVF_MAX_QUEUES	17
 
 #define IFCVF_QUEUE_ALIGNMENT	PAGE_SIZE
-#define IFCVF_QUEUE_MAX		32768
 #define IFCVF_PCI_MAX_RESOURCE	6
 
 #define IFCVF_LM_CFG_SIZE		0x40
@@ -137,4 +136,5 @@ int ifcvf_probed_virtio_net(struct ifcvf_hw *hw);
 u32 ifcvf_get_config_size(struct ifcvf_hw *hw);
 u16 ifcvf_set_vq_vector(struct ifcvf_hw *hw, u16 qid, int vector);
 u16 ifcvf_set_config_vector(struct ifcvf_hw *hw, int vector);
+u16 ifcvf_get_max_vq_size(struct ifcvf_hw *hw);
 #endif /* _IFCVF_H_ */
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index c97dde02bbb6..d7875b461a5f 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -509,7 +509,9 @@ static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev)
 
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
