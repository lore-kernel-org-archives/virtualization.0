Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B19C43217
	for <virtualization@archiver.kernel.org>; Fri, 25 Nov 2022 15:06:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 481D24049D;
	Fri, 25 Nov 2022 15:06:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 481D24049D
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=COJt46Ya
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WSjb67u4_JRP; Fri, 25 Nov 2022 15:06:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C8F2E4048E;
	Fri, 25 Nov 2022 15:06:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8F2E4048E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9FDDC0033;
	Fri, 25 Nov 2022 15:06:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EEE7C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CF1BF81ED0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF1BF81ED0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=COJt46Ya
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mqKv7prKLHXK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3E35181F0B
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E35181F0B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669388785; x=1700924785;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Uv8WuEazzgbSx4/bAjBoWshididqsR5SPzHsqjDyIts=;
 b=COJt46Yaq/Zp47Pnois1o6iv2jTrOxIQ2XoQjsrEpSxzIM4aC4G2ZAhc
 OXy4B/hUUvFdWgwKsW5tiiTVKvAEh8Tvu2MqFJx5/sWR9RMtCBOquTPlC
 xl7GbV37kci3VPN2bjyqvFx+ENfJL+j+CvJB76GsZr2zzcP2621mkBFp0
 YW5iANo0VIO1Xzp6CpP1r1wxmcZJnCVCRCqTCuHx0d/Jc7bqmlsSpaxtG
 1fQVfznhhKqt+aWxe2Il+Xkk5XMcT+4mYIqfHwzM8vsVodJMri+XjsYGc
 af9t9RhuAcALhwtc+d7d2lCNaboF7q3wicqzA0Jgo13d1IXIix1uYDQZE g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="400787318"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="400787318"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="593240204"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="593240204"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:22 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH V2 01/12] vDPA/ifcvf: decouple hw features manipulators from
 the adapter
Date: Fri, 25 Nov 2022 22:57:13 +0800
Message-Id: <20221125145724.1129962-2-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221125145724.1129962-1-lingshan.zhu@intel.com>
References: <20221125145724.1129962-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Cc: kvm@vger.kernel.org, piotr.uminski@intel.com, stable@vger.kernel.org,
 hang.yuan@intel.com, virtualization@lists.linux-foundation.org
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

This commit gets rid of ifcvf_adapter in hw features related
functions in ifcvf_base. Then these functions are more rubust
and de-coupling from the ifcvf_adapter layer. So these
functions could be invoded once the device is probed, even
before the adapter is allocaed.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 9 ++-------
 drivers/vdpa/ifcvf/ifcvf_base.h | 1 +
 drivers/vdpa/ifcvf/ifcvf_main.c | 1 +
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 3e4486bfa0b7..7a7e6ba66f88 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -220,10 +220,8 @@ u64 ifcvf_get_features(struct ifcvf_hw *hw)
 
 int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features)
 {
-	struct ifcvf_adapter *ifcvf = vf_to_adapter(hw);
-
 	if (!(features & BIT_ULL(VIRTIO_F_ACCESS_PLATFORM)) && features) {
-		IFCVF_ERR(ifcvf->pdev, "VIRTIO_F_ACCESS_PLATFORM is not negotiated\n");
+		IFCVF_ERR(hw->pdev, "VIRTIO_F_ACCESS_PLATFORM is not negotiated\n");
 		return -EINVAL;
 	}
 
@@ -301,14 +299,11 @@ static void ifcvf_set_features(struct ifcvf_hw *hw, u64 features)
 
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
index f5563f665cc6..e1fe947d61b7 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -89,6 +89,7 @@ struct ifcvf_hw {
 	u16 nr_vring;
 	/* VIRTIO_PCI_CAP_DEVICE_CFG size */
 	u32 cap_dev_config_size;
+	struct pci_dev *pdev;
 };
 
 struct ifcvf_adapter {
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index f9c0044c6442..28c82d796c90 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -842,6 +842,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	vf = &adapter->vf;
 	vf->dev_type = get_dev_type(pdev);
 	vf->base = pcim_iomap_table(pdev);
+	vf->pdev = pdev;
 
 	adapter->pdev = pdev;
 	adapter->vdpa.dma_dev = &pdev->dev;
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
