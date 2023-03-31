Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47677C77B62
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 12:49:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 657D284611;
	Fri, 31 Mar 2023 12:49:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 657D284611
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T1Wu+VHt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id znNe_lxM87Dl; Fri, 31 Mar 2023 12:49:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC4C98462A;
	Fri, 31 Mar 2023 12:49:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC4C98462A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5A73AC0095;
	Fri, 31 Mar 2023 12:49:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 15769C002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 70F9A40649
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 70F9A40649
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=T1Wu+VHt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uE-QgDuevFC1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B679D408F4
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B679D408F4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680266950; x=1711802950;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=P+zQug8ZsZDAvyBKU0XjWwimkSf4WfxJ+LHlPI5tD/Y=;
 b=T1Wu+VHtjgK9AGMphb+4wF/d4MmBtaVn4WyBXBfgYyhWmvDMCu/bcLZQ
 KDiMSqer0KnBSQRP6UIv1zENBfkloAjpdW5j8IhxTpvHPHemmcpmc+y9X
 dwKtgmY3D6iRAljVFS9Lha7Ei/U0fExORAfhm6oiy/h1TKFvU9cBwcaYF
 HXvkvhuBOzfpBdsjvgNH392Uq51ISCLdHSALjmOsmlZDt3RfTCQD7ifVk
 MGZGJ6HOci9h+TpyEDaxUYt4mBOpPf1qB9G4P6dOofLjyG8McUxr8W9nA
 avp/Q0K8aoInQ87tN9lWEbJ92c1YQud8Mw9wofJl7ZslQFRY2kkJhP+mb A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="404162361"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="404162361"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2023 05:49:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="931155992"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="931155992"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2023 05:49:05 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 4/5] synchronize irqs in the reset routine
Date: Sat,  1 Apr 2023 04:48:53 +0800
Message-Id: <20230331204854.20082-5-lingshan.zhu@intel.com>
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

This commit synchronize irqs of the virtqueues
and config space in the reset routine.
Thus ifcvf_stop_hw() and reset() are refactored as well.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 61 ++++++++++++++++++++++++++-------
 drivers/vdpa/ifcvf/ifcvf_main.c | 45 +++---------------------
 2 files changed, 54 insertions(+), 52 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 79e313c5e10e..49949aec20ef 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -170,12 +170,7 @@ void ifcvf_set_status(struct ifcvf_hw *hw, u8 status)
 
 void ifcvf_reset(struct ifcvf_hw *hw)
 {
-	hw->config_cb.callback = NULL;
-	hw->config_cb.private = NULL;
-
 	ifcvf_set_status(hw, 0);
-	/* flush set_status, make sure VF is stopped, reset */
-	ifcvf_get_status(hw);
 }
 
 u64 ifcvf_get_hw_features(struct ifcvf_hw *hw)
@@ -368,20 +363,62 @@ void ifcvf_set_vq_ready(struct ifcvf_hw *hw, u16 qid, bool ready)
 	vp_iowrite16(ready, &cfg->queue_enable);
 }
 
-static void ifcvf_hw_disable(struct ifcvf_hw *hw)
+static void synchronize_per_vq_irq(struct ifcvf_hw *hw)
 {
-	u32 i;
+	u16 qid;
 
-	ifcvf_set_config_vector(hw, VIRTIO_MSI_NO_VECTOR);
-	for (i = 0; i < hw->nr_vring; i++) {
-		ifcvf_set_vq_vector(hw, i, VIRTIO_MSI_NO_VECTOR);
+	for (qid = 0; qid < hw->nr_vring; qid++) {
+		if (hw->vring[qid].irq != -EINVAL)
+			synchronize_irq(hw->vring[qid].irq);
 	}
 }
 
+static void synchronize_vqs_reused_irq(struct ifcvf_hw *hw)
+{
+	if (hw->vqs_reused_irq != -EINVAL)
+		synchronize_irq(hw->vqs_reused_irq);
+}
+
+static void synchronize_vq_irq(struct ifcvf_hw *hw)
+{
+	u8 status = hw->msix_vector_status;
+
+	if (status == MSIX_VECTOR_PER_VQ_AND_CONFIG)
+		synchronize_per_vq_irq(hw);
+	else
+		synchronize_vqs_reused_irq(hw);
+}
+
+static void synchronize_config_irq(struct ifcvf_hw *hw)
+{
+	if (hw->config_irq != -EINVAL)
+		synchronize_irq(hw->config_irq);
+}
+
+static void ifcvf_reset_vring(struct ifcvf_hw *hw)
+{
+	u16 qid;
+
+	for (qid = 0; qid < hw->nr_vring; qid++) {
+		synchronize_vq_irq(hw);
+		hw->vring[qid].cb.callback = NULL;
+		hw->vring[qid].cb.private = NULL;
+		ifcvf_set_vq_vector(hw, qid, VIRTIO_MSI_NO_VECTOR);
+	}
+}
+
+static void ifcvf_reset_config_handler(struct ifcvf_hw *hw)
+{
+	synchronize_config_irq(hw);
+	hw->config_cb.callback = NULL;
+	hw->config_cb.private = NULL;
+	ifcvf_set_config_vector(hw, VIRTIO_MSI_NO_VECTOR);
+}
+
 void ifcvf_stop_hw(struct ifcvf_hw *hw)
 {
-	ifcvf_hw_disable(hw);
-	ifcvf_reset(hw);
+	ifcvf_reset_vring(hw);
+	ifcvf_reset_config_handler(hw);
 }
 
 void ifcvf_notify_queue(struct ifcvf_hw *hw, u16 qid)
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 968687159e44..15c6157ee841 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -346,33 +346,6 @@ static int ifcvf_request_irq(struct ifcvf_hw *vf)
 	return 0;
 }
 
-static int ifcvf_stop_datapath(struct ifcvf_adapter *adapter)
-{
-	struct ifcvf_hw *vf = adapter->vf;
-	int i;
-
-	for (i = 0; i < vf->nr_vring; i++)
-		vf->vring[i].cb.callback = NULL;
-
-	ifcvf_stop_hw(vf);
-
-	return 0;
-}
-
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
@@ -462,23 +435,15 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 
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
