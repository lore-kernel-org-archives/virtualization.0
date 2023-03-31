Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D47C6FD18
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 12:49:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6A20C84624;
	Fri, 31 Mar 2023 12:49:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6A20C84624
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=S/2/nzmx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8r97uvhC2maD; Fri, 31 Mar 2023 12:49:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CFC83845AB;
	Fri, 31 Mar 2023 12:49:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CFC83845AB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3091C0036;
	Fri, 31 Mar 2023 12:49:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE1A4C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B918C420B5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B918C420B5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=S/2/nzmx
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fuEj1jqtJ3j4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D8C4D4018E
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D8C4D4018E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680266949; x=1711802949;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IULcEKal/ql65X7XInvcLRHLZ/mdmPsXOUB7sQQkjb0=;
 b=S/2/nzmxFOI3PnPFPUW7Hczct7+bJbhWlJoIsNSwWRKRC2Gb0oqxWT7U
 tg+zrf8KHqf4tg2ji5e/LrlL6+GOPAsdHPZfCvFEWUh1Ssdlo3xQgf6dt
 fSbWZLTZHZkmn0gbiXj8meXMQS79ys8ZWg2wc85AkQyoATvSO8X75PtKp
 O+MM/oJ7oM/4flQcS0+H7iKmw5LNptSHGS8oe+E9dTfvShm8s0xBpmLwa
 9wailojZr7l0inxltFqZvh1+6CLSAwXlrTjB7nzCvxCQOvSYYU9se9aGK
 3cv5bslcjqwDSt5AShnc0P2g6BD/lDCL5UYsBGSwEse6dt5t0xMJBemRr A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="404162350"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="404162350"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2023 05:49:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="931155959"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="931155959"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2023 05:49:00 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 1/5] virt queue ops take immediate actions
Date: Sat,  1 Apr 2023 04:48:50 +0800
Message-Id: <20230331204854.20082-2-lingshan.zhu@intel.com>
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

In this commit, virtqueue operations including:
set_vq_num(), set_vq_address(), set_vq_ready()
and get_vq_ready() access PCI registers directly
to take immediate actions.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
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
