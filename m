Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F929C43217
	for <virtualization@archiver.kernel.org>; Fri, 25 Nov 2022 15:06:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 184EF41D44;
	Fri, 25 Nov 2022 15:06:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 184EF41D44
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=TZRl33tR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m82_ErXgeCZA; Fri, 25 Nov 2022 15:06:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 43CC9419B2;
	Fri, 25 Nov 2022 15:06:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 43CC9419B2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1FA63C0033;
	Fri, 25 Nov 2022 15:06:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DB42C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD76D82123
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DD76D82123
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=TZRl33tR
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KZeevf2MyxQ5
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42F24820E7
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 42F24820E7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669388791; x=1700924791;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GfW1grE+W1yxIIEcRuvloaY402+gBkQ0YBkYnxhRSLg=;
 b=TZRl33tRs23Rka8qmDc7Seo5H8eqx1fOJSQAm/TXPf0RJv9nFm8LLWj7
 zVoej7gk2k2cAjkhszC8CnQKRxEFybRutWBt+QrT9k2z1xjy9x4Pnj5ow
 s7XZ6LMgEsPD28YhzZiUaCjRP8FSjAbBicRvLZR3YZibN35ZvRkwdV5nP
 5boaFT0Gl8X7TJruYvws2pNGH3WmUe024iootU9ry9S/gm6H84Fi49BWQ
 uou9hj6zmD8j+j1V67ScnGR436IG2BdSqkZFKzs9+ClZSZAggvK99/I02
 0a3oO/79qnu2GgfwM72hy0fe5+ecNRZdcxgnGzVLTkvW746vKzPNOXRi1 g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="400787339"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="400787339"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="593240230"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="593240230"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:27 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH V2 03/12] vDPA/ifcvf: alloc the mgmt_dev before the adapter
Date: Fri, 25 Nov 2022 22:57:15 +0800
Message-Id: <20221125145724.1129962-4-lingshan.zhu@intel.com>
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

This commit reverses the order of allocating the
management device and the adapter. So that it would
be possible to move the allocation of the adapter
to dev_add().

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 28c82d796c90..306a57c05509 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -831,22 +831,30 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	pci_set_master(pdev);
+	ifcvf_mgmt_dev = kzalloc(sizeof(struct ifcvf_vdpa_mgmt_dev), GFP_KERNEL);
+	if (!ifcvf_mgmt_dev) {
+		IFCVF_ERR(pdev, "Failed to alloc memory for the vDPA management device\n");
+		return -ENOMEM;
+	}
 
 	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
 				    dev, &ifc_vdpa_ops, 1, 1, NULL, false);
 	if (IS_ERR(adapter)) {
 		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
-		return PTR_ERR(adapter);
+		ret = PTR_ERR(adapter);
+		goto err;
 	}
 
+	adapter->pdev = pdev;
+	adapter->vdpa.dma_dev = &pdev->dev;
+	adapter->vdpa.mdev = &ifcvf_mgmt_dev->mdev;
+	ifcvf_mgmt_dev->adapter = adapter;
+
 	vf = &adapter->vf;
 	vf->dev_type = get_dev_type(pdev);
 	vf->base = pcim_iomap_table(pdev);
 	vf->pdev = pdev;
 
-	adapter->pdev = pdev;
-	adapter->vdpa.dma_dev = &pdev->dev;
-
 	ret = ifcvf_init_hw(vf, pdev);
 	if (ret) {
 		IFCVF_ERR(pdev, "Failed to init IFCVF hw\n");
@@ -859,16 +867,6 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	vf->hw_features = ifcvf_get_hw_features(vf);
 	vf->config_size = ifcvf_get_config_size(vf);
 
-	ifcvf_mgmt_dev = kzalloc(sizeof(struct ifcvf_vdpa_mgmt_dev), GFP_KERNEL);
-	if (!ifcvf_mgmt_dev) {
-		IFCVF_ERR(pdev, "Failed to alloc memory for the vDPA management device\n");
-		return -ENOMEM;
-	}
-
-	ifcvf_mgmt_dev->mdev.ops = &ifcvf_vdpa_mgmt_dev_ops;
-	ifcvf_mgmt_dev->mdev.device = dev;
-	ifcvf_mgmt_dev->adapter = adapter;
-
 	dev_type = get_dev_type(pdev);
 	switch (dev_type) {
 	case VIRTIO_ID_NET:
@@ -883,12 +881,11 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err;
 	}
 
+	ifcvf_mgmt_dev->mdev.ops = &ifcvf_vdpa_mgmt_dev_ops;
+	ifcvf_mgmt_dev->mdev.device = dev;
 	ifcvf_mgmt_dev->mdev.max_supported_vqs = vf->nr_vring;
 	ifcvf_mgmt_dev->mdev.supported_features = vf->hw_features;
 
-	adapter->vdpa.mdev = &ifcvf_mgmt_dev->mdev;
-
-
 	ret = vdpa_mgmtdev_register(&ifcvf_mgmt_dev->mdev);
 	if (ret) {
 		IFCVF_ERR(pdev,
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
