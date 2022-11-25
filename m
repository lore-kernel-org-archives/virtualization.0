Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE41FC43219
	for <virtualization@archiver.kernel.org>; Fri, 25 Nov 2022 15:06:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8857541D53;
	Fri, 25 Nov 2022 15:06:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8857541D53
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=WuVyL8k+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5I78PELXCvaT; Fri, 25 Nov 2022 15:06:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E3B3941926;
	Fri, 25 Nov 2022 15:06:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E3B3941926
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF5ACC0033;
	Fri, 25 Nov 2022 15:06:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6732AC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40EDC820DD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40EDC820DD
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=WuVyL8k+
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fCL9mLAUDw4A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C80981F0C
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C80981F0C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669388809; x=1700924809;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Xejal7SbyM3CZJX6CDhwfTq2ZC4W7X99THWP2G/YoKU=;
 b=WuVyL8k+/aieG1/YrTeAqhUKpwgKREyB1mxelzm+kgb1Ej8dgIjoMIYj
 2DRMtl0cIlEj8z5w6oh32zZQjp/lPSUtjC23vj6gEMejvfhM2scKK5oH1
 mS3ecX5YNog7EniEhYna/lUnCTKFao+Zm8p19FX7RhOy3ZrRTauHoscvb
 o+V5guML9cguZe9o0NOTF3IOsDi5xe85HNkccWR03iAalL0g/a4wOYV/d
 io/qFvt450b+z114yYsOMebb/J2YlQta2sjw8ueceOZpwpi8AfDHNTntR
 9IFLbEgs/57/H86ZhYsjS9funHg+8Ok/8lVHDWpkcsDo2JqDJxbj/Bmik A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="400787473"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="400787473"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="593240298"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="593240298"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:46 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH V2 10/12] vDPA/ifcvf: allocate the adapter in dev_add()
Date: Fri, 25 Nov 2022 22:57:22 +0800
Message-Id: <20221125145724.1129962-11-lingshan.zhu@intel.com>
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

The adapter is the container of the vdpa_device,
this commits allocate the adapter in dev_add()
rather than in probe(). So that the vdpa_device()
could be re-created when the userspace creates
the vdpa device, and free-ed in dev_del()

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 34 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index b6f5f7a3a767..4450ddb53806 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -746,12 +746,20 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	int ret;
 
 	ifcvf_mgmt_dev = container_of(mdev, struct ifcvf_vdpa_mgmt_dev, mdev);
-	if (!ifcvf_mgmt_dev->adapter)
-		return -EOPNOTSUPP;
+	vf = &ifcvf_mgmt_dev->vf;
+	pdev = vf->pdev;
+	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
+				    &pdev->dev, &ifc_vdpa_ops, 1, 1, NULL, false);
+	if (IS_ERR(adapter)) {
+		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
+		return PTR_ERR(adapter);
+	}
 
-	adapter = ifcvf_mgmt_dev->adapter;
-	vf = adapter->vf;
-	pdev = adapter->pdev;
+	ifcvf_mgmt_dev->adapter = adapter;
+	adapter->pdev = pdev;
+	adapter->vdpa.dma_dev = &pdev->dev;
+	adapter->vdpa.mdev = mdev;
+	adapter->vf = vf;
 	vdpa_dev = &adapter->vdpa;
 
 	if (name)
@@ -769,7 +777,6 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	return 0;
 }
 
-
 static void ifcvf_vdpa_dev_del(struct vdpa_mgmt_dev *mdev, struct vdpa_device *dev)
 {
 	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
@@ -788,7 +795,6 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct ifcvf_vdpa_mgmt_dev *ifcvf_mgmt_dev;
 	struct device *dev = &pdev->dev;
-	struct ifcvf_adapter *adapter;
 	struct ifcvf_hw *vf;
 	u32 dev_type;
 	int ret, i;
@@ -825,24 +831,10 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
-	adapter = vdpa_alloc_device(struct ifcvf_adapter, vdpa,
-				    dev, &ifc_vdpa_ops, 1, 1, NULL, false);
-	if (IS_ERR(adapter)) {
-		IFCVF_ERR(pdev, "Failed to allocate vDPA structure");
-		ret = PTR_ERR(adapter);
-		goto err;
-	}
-
-	adapter->pdev = pdev;
-	adapter->vdpa.dma_dev = &pdev->dev;
-	adapter->vdpa.mdev = &ifcvf_mgmt_dev->mdev;
-	ifcvf_mgmt_dev->adapter = adapter;
-
 	vf = &ifcvf_mgmt_dev->vf;
 	vf->dev_type = get_dev_type(pdev);
 	vf->base = pcim_iomap_table(pdev);
 	vf->pdev = pdev;
-	adapter->vf = vf;
 
 	ret = ifcvf_init_hw(vf, pdev);
 	if (ret) {
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
