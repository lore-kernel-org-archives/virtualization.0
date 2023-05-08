Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2E2C77B7F
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 10:05:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B99D281F85;
	Mon,  8 May 2023 10:05:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B99D281F85
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gxaab2cZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vnNrvzp0IJl5; Mon,  8 May 2023 10:05:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1636981F9B;
	Mon,  8 May 2023 10:05:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1636981F9B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0A29C0037;
	Mon,  8 May 2023 10:05:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53393C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1F9FE41A49
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1F9FE41A49
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=gxaab2cZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zds7PDSIK8m8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0E04B41B41
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0E04B41B41
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 10:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1683540327; x=1715076327;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=utHqJS5dxuFHcDMP6aL+rqN5OzX5AK+Pk8AgAxmto20=;
 b=gxaab2cZoSQWvh6XGDcA6VckiW1JKnrUbLKDeR1GDJNGw2oaJYSXudFS
 l2GkaY15lUuDub73QxQz0Qo2PBG2R3dzayZohooBJ/bp2KUYIzlyaPR3/
 htiODSFZZgS912csPPAB4yIvrI9VjyGxpNDjZ8I82/sjJTOmALzUsEwg8
 diIz2z/v/wqDRZaOs5Rhf9DyqtALxLd/biAEw/ySBumlAraBEIN/l8mIk
 tY+NmiQVcrOa6F/oKwHNuPGp+SYXFtAXYnwoFaanRs8xgaTFqQq9fSjCk
 55YmiPcGzqDIHbd8elhU/xnXeV0Y8V9x/eAMySUJXoQs7rl5rKxoH1pDx A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="338828027"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; d="scan'208";a="338828027"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2023 03:05:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10703"; a="842639084"
X-IronPort-AV: E=Sophos;i="5.99,258,1677571200"; d="scan'208";a="842639084"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga001.fm.intel.com with ESMTP; 08 May 2023 03:05:25 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 4/5] vDPA/ifcvf: synchronize irqs in the reset routine
Date: Tue,  9 May 2023 02:05:11 +0800
Message-Id: <20230508180512.17371-5-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230508180512.17371-1-lingshan.zhu@intel.com>
References: <20230508180512.17371-1-lingshan.zhu@intel.com>
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
Thus ifcvf_stop_hw() and reset() are refactored as well.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 41 +++++++++++++++++++++--------
 drivers/vdpa/ifcvf/ifcvf_base.h |  1 +
 drivers/vdpa/ifcvf/ifcvf_main.c | 46 +++++----------------------------
 3 files changed, 38 insertions(+), 50 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 79e313c5e10e..1f39290baa38 100644
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
 
 void ifcvf_stop_hw(struct ifcvf_hw *hw)
 {
-	ifcvf_hw_disable(hw);
-	ifcvf_reset(hw);
+	ifcvf_synchronize_irq(hw);
+	ifcvf_reset_vring(hw);
+	ifcvf_reset_config_handler(hw);
 }
 
 void ifcvf_notify_queue(struct ifcvf_hw *hw, u16 qid)
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index d34d3bc0dbf4..7430f80779be 100644
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
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 968687159e44..3401b9901dd2 100644
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
+	ifcvf_stop_hw(vf);
 
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
