Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7194EC77B7C
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 06:53:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2772042C86;
	Fri, 26 May 2023 06:53:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2772042C86
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KcHGMKRa
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t2YIQrTzigSX; Fri, 26 May 2023 06:53:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8A4F842C91;
	Fri, 26 May 2023 06:53:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8A4F842C91
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3EC5BC0091;
	Fri, 26 May 2023 06:53:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9D5DC0036
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 743A542C8A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 743A542C8A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p9RqAzIREf5s
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A318D42C86
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A318D42C86
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685083999; x=1716619999;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SRtcwwgocl64ubVSQzuLuDRC4NnkcQteZTyY6FhTFzI=;
 b=KcHGMKRa954uNZmnhAVh1AAKXXZwwHpkj9N1KtktmRtUDUzdzZSKA/Qz
 HDMVy7eH/qxE1Z9p7UxdW1Cb9AZgjkZmjo4tJnpAwtRtailw67nlLXH6H
 TDT4LafOnQuKVdlR+rxAj8WLwcb2wTldmYQ99afSMFu7u//iaePN1LyJ1
 UW9Ztwhobgb76sZY8GrFW8KqM+LcwkiDanB97xIVoWPsXYOqb0u7U1+4b
 4B3hEVHI1tebXw6bqao3ovS68vuMjrzm1bkrBwN98tKdQ1fCQPMPwWYVT
 OMuqiuCqU/eZBKO1DKRPzzMJdvzwUHXYfYc9gm6D8Jznqza/PFyrRF1VA g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="333763397"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="333763397"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 23:53:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="770241654"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="770241654"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga008.fm.intel.com with ESMTP; 25 May 2023 23:53:18 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V3 4/5] vDPA/ifcvf: synchronize irqs in the reset routine
Date: Fri, 26 May 2023 22:52:53 +0800
Message-Id: <20230526145254.39537-5-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230526145254.39537-1-lingshan.zhu@intel.com>
References: <20230526145254.39537-1-lingshan.zhu@intel.com>
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

This commit synchronize irqs of the virtqueues
and config space in the reset routine.
Thus ifcvf_stop() and reset() are refactored as well.
This commit renames ifcvf_stop_hw() to ifcvf_stop()

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 43 +++++++++++++++++++++---------
 drivers/vdpa/ifcvf/ifcvf_base.h |  3 ++-
 drivers/vdpa/ifcvf/ifcvf_main.c | 46 +++++----------------------------
 3 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 79e313c5e10e..1b5da11f5403 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -170,12 +170,9 @@ void ifcvf_set_status(struct ifcvf_hw *hw, u8 status)
 
 void ifcvf_reset(struct ifcvf_hw *hw)
 {
-	hw->config_cb.callback = NULL;
-	hw->config_cb.private = NULL;
-
 	ifcvf_set_status(hw, 0);
-	/* flush set_status, make sure VF is stopped, reset */
-	ifcvf_get_status(hw);
+	while (ifcvf_get_status(hw))
+		msleep(1);
 }
 
 u64 ifcvf_get_hw_features(struct ifcvf_hw *hw)
@@ -368,20 +365,42 @@ void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready)
 	vp_iowrite16(ready, &cfg->queue_enable);
 }
 
-static void ifcvf_hw_disable(struct ifcvf_hw *hw)
+static void ifcvf_reset_vring(struct ifcvf_hw *hw)
 {
-	u32 i;
+	u16 qid;
+
+	for (qid = 0; qid < hw->nr_vring; qid++) {
+		hw->vring[qid].cb.callback = NULL;
+		hw->vring[qid].cb.private = NULL;
+		ifcvf_set_vq_vector(hw, qid, VIRTIO_MSI_NO_VECTOR);
+	}
+}
 
+static void ifcvf_reset_config_handler(struct ifcvf_hw *hw)
+{
+	hw->config_cb.callback = NULL;
+	hw->config_cb.private = NULL;
 	ifcvf_set_config_vector(hw, VIRTIO_MSI_NO_VECTOR);
-	for (i = 0; i < hw->nr_vring; i++) {
-		ifcvf_set_vq_vector(hw, i, VIRTIO_MSI_NO_VECTOR);
+}
+
+static void ifcvf_synchronize_irq(struct ifcvf_hw *hw)
+{
+	u32 nvectors = hw->num_msix_vectors;
+	struct pci_dev *pdev = hw->pdev;
+	int i, irq;
+
+	for (i = 0; i < nvectors; i++) {
+		irq = pci_irq_vector(pdev, i);
+		if (irq >= 0)
+			synchronize_irq(irq);
 	}
 }
 
-void ifcvf_stop_hw(struct ifcvf_hw *hw)
+void ifcvf_stop(struct ifcvf_hw *hw)
 {
-	ifcvf_hw_disable(hw);
-	ifcvf_reset(hw);
+	ifcvf_synchronize_irq(hw);
+	ifcvf_reset_vring(hw);
+	ifcvf_reset_config_handler(hw);
 }
 
 void ifcvf_notify_queue(struct ifcvf_hw *hw, u16 qid)
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index d34d3bc0dbf4..3110ffc50caf 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -82,6 +82,7 @@ struct ifcvf_hw {
 	int vqs_reused_irq;
 	u16 nr_vring;
 	/* VIRTIO_PCI_CAP_DEVICE_CFG size */
+	u32 num_msix_vectors;
 	u32 cap_dev_config_size;
 	struct pci_dev *pdev;
 };
@@ -110,7 +111,7 @@ struct ifcvf_vdpa_mgmt_dev {
 };
 
 int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *dev);
-void ifcvf_stop_hw(struct ifcvf_hw *hw);
+void ifcvf_stop(struct ifcvf_hw *hw);
 void ifcvf_notify_queue(struct ifcvf_hw *hw, u16 qid);
 void ifcvf_read_dev_config(struct ifcvf_hw *hw, u64 offset,
 			   void *dst, int length);
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 968687159e44..5b7156209602 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -125,6 +125,7 @@ static void ifcvf_free_irq(struct ifcvf_hw *vf)
 	ifcvf_free_vq_irq(vf);
 	ifcvf_free_config_irq(vf);
 	ifcvf_free_irq_vectors(pdev);
+	vf->num_msix_vectors = 0;
 }
 
 /* ifcvf MSIX vectors allocator, this helper tries to allocate
@@ -343,36 +344,11 @@ static int ifcvf_request_irq(struct ifcvf_hw *vf)
 	if (ret)
 		return ret;
 
-	return 0;
-}
-
-static int ifcvf_stop_datapath(struct ifcvf_adapter *adapter)
-{
-	struct ifcvf_hw *vf = adapter->vf;
-	int i;
-
-	for (i = 0; i < vf->nr_vring; i++)
-		vf->vring[i].cb.callback = NULL;
-
-	ifcvf_stop_hw(vf);
+	vf->num_msix_vectors = nvectors;
 
 	return 0;
 }
 
-static void ifcvf_reset_vring(struct ifcvf_adapter *adapter)
-{
-	struct ifcvf_hw *vf = adapter->vf;
-	int i;
-
-	for (i = 0; i < vf->nr_vring; i++) {
-		vf->vring[i].last_avail_idx = 0;
-		vf->vring[i].cb.callback = NULL;
-		vf->vring[i].cb.private = NULL;
-	}
-
-	ifcvf_reset(vf);
-}
-
 static struct ifcvf_adapter *vdpa_to_adapter(struct vdpa_device *vdpa_dev)
 {
 	return container_of(vdpa_dev, struct ifcvf_adapter, vdpa);
@@ -462,23 +438,15 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 
 static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev)
 {
-	struct ifcvf_adapter *adapter;
-	struct ifcvf_hw *vf;
-	u8 status_old;
-
-	vf  = vdpa_to_vf(vdpa_dev);
-	adapter = vdpa_to_adapter(vdpa_dev);
-	status_old = ifcvf_get_status(vf);
+	struct ifcvf_hw *vf = vdpa_to_vf(vdpa_dev);
+	u8 status = ifcvf_get_status(vf);
 
-	if (status_old == 0)
-		return 0;
+	ifcvf_stop(vf);
 
-	if (status_old & VIRTIO_CONFIG_S_DRIVER_OK) {
-		ifcvf_stop_datapath(adapter);
+	if (status & VIRTIO_CONFIG_S_DRIVER_OK)
 		ifcvf_free_irq(vf);
-	}
 
-	ifcvf_reset_vring(adapter);
+	ifcvf_reset(vf);
 
 	return 0;
 }
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
