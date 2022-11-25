Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545E3C4332F
	for <virtualization@archiver.kernel.org>; Fri, 25 Nov 2022 15:06:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0748D40597;
	Fri, 25 Nov 2022 15:06:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0748D40597
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=oF9LM0vG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eTh_FIv-mXA1; Fri, 25 Nov 2022 15:06:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 97C804048E;
	Fri, 25 Nov 2022 15:06:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 97C804048E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8105BC0033;
	Fri, 25 Nov 2022 15:06:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFE1AC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 99AEC8218E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 99AEC8218E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=oF9LM0vG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ks9vPQ_74NBF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A049C82162
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A049C82162
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669388806; x=1700924806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tGKyZdK+/g+LspCoOlXFm4pHY90Rxp2oIWc2gtPMg2Y=;
 b=oF9LM0vGuP9PO2VmagPkN1tlczoCnxSLPoFd2L8KwZtKF+M4mu5Xwxkb
 n5xIWxRlwljyAsephcmPsvEFuCJBbyy64n+I6NF+BJI+w8vP9pUtDwVr+
 PYPooyD7qW6WA+/3sVs0zQqxuOySzrO48JKnVD7OlFnKYR9PS1me4li71
 KUtQpkAYbg1aJMnuo7TwU3snN4synFzVvCxtH8+6kbClVGwXYWOzFUTcx
 72kCNOzjkEHNqSNSbHg+xQW7817rjQmFJy3l8xHuvUJHf2MQ9KR1FKzqd
 liLv4CL43ct1AmYFBfrXynCCBLQmbuEyQf71LMHsv9fG+hdi7p5leg/kw g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="400787454"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="400787454"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:46 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="593240292"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="593240292"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:43 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH V2 09/12] vDPA/ifcvf: manage ifcvf_hw in the mgmt_dev
Date: Fri, 25 Nov 2022 22:57:21 +0800
Message-Id: <20221125145724.1129962-10-lingshan.zhu@intel.com>
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

This commit allocates the hw structure in the
management device structure. So the hardware
can be initialized once the management device
is allocated in probe.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/vdpa/ifcvf/ifcvf_base.h | 5 +++--
 drivers/vdpa/ifcvf/ifcvf_main.c | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index e1fe947d61b7..25bd4e927b27 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -39,7 +39,7 @@
 #define IFCVF_INFO(pdev, fmt, ...)	dev_info(&pdev->dev, fmt, ##__VA_ARGS__)
 
 #define ifcvf_private_to_vf(adapter) \
-	(&((struct ifcvf_adapter *)adapter)->vf)
+	(((struct ifcvf_adapter *)adapter)->vf)
 
 /* all vqs and config interrupt has its own vector */
 #define MSIX_VECTOR_PER_VQ_AND_CONFIG		1
@@ -95,7 +95,7 @@ struct ifcvf_hw {
 struct ifcvf_adapter {
 	struct vdpa_device vdpa;
 	struct pci_dev *pdev;
-	struct ifcvf_hw vf;
+	struct ifcvf_hw *vf;
 };
 
 struct ifcvf_vring_lm_cfg {
@@ -110,6 +110,7 @@ struct ifcvf_lm_cfg {
 
 struct ifcvf_vdpa_mgmt_dev {
 	struct vdpa_mgmt_dev mdev;
+	struct ifcvf_hw vf;
 	struct ifcvf_adapter *adapter;
 	struct pci_dev *pdev;
 };
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index cb3df395d3fb..b6f5f7a3a767 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -402,7 +402,7 @@ static struct ifcvf_hw *vdpa_to_vf(struct vdpa_device *vdpa_dev)
 {
 	struct ifcvf_adapter *adapter = vdpa_to_adapter(vdpa_dev);
 
-	return &adapter->vf;
+	return adapter->vf;
 }
 
 static u64 ifcvf_vdpa_get_device_features(struct vdpa_device *vdpa_dev)
@@ -750,7 +750,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 		return -EOPNOTSUPP;
 
 	adapter = ifcvf_mgmt_dev->adapter;
-	vf = &adapter->vf;
+	vf = adapter->vf;
 	pdev = adapter->pdev;
 	vdpa_dev = &adapter->vdpa;
 
@@ -838,10 +838,11 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	adapter->vdpa.mdev = &ifcvf_mgmt_dev->mdev;
 	ifcvf_mgmt_dev->adapter = adapter;
 
-	vf = &adapter->vf;
+	vf = &ifcvf_mgmt_dev->vf;
 	vf->dev_type = get_dev_type(pdev);
 	vf->base = pcim_iomap_table(pdev);
 	vf->pdev = pdev;
+	adapter->vf = vf;
 
 	ret = ifcvf_init_hw(vf, pdev);
 	if (ret) {
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
