Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F09C7EE23
	for <virtualization@archiver.kernel.org>; Mon, 12 Jun 2023 07:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3A859403E5;
	Mon, 12 Jun 2023 07:14:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A859403E5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U/3vz+gM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o8JjGl8p40Sx; Mon, 12 Jun 2023 07:14:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CB1EA40C09;
	Mon, 12 Jun 2023 07:14:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CB1EA40C09
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A74B9C0037;
	Mon, 12 Jun 2023 07:14:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4967CC0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 245C6403E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 245C6403E5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HOXWOHnM_8yV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C99B40B90
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C99B40B90
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Jun 2023 07:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686554083; x=1718090083;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0HaH4bOEdRxW+dzktsK55swes/TT2BvHolbpC/Fwt5s=;
 b=U/3vz+gMTi6gVEMsDOlZ24Uhi7hD7CWDIjCVtqoghijbkB+es1Y+5N74
 3VWmyV/uSmjxtI/lN+P0IKC8iOAhHK7vXLYse849H75stUBJyX4fVFKYg
 M4ZImdySFPzmG3AAAUPb26QDtBkEb0KY51o2ZZVaSD49ebwAsslk6i1ak
 huJkfti+v6wIFspo+QQfq82ZXsfDcZnkpmXEs0yhXOH9SJjYQFlMRa73+
 0tRY7h6bTYXECWNRXI4JOmdJyaLUlJU87hTY4SZjCgbX1BTLXhixrm04b
 QS+UcK8IQlTug7Yh2/z4E3nF5yfkApqhDGr+OPke4V8hEQesiTTVOys5O g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="444339933"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="444339933"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2023 00:14:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10738"; a="661470840"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; d="scan'208";a="661470840"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by orsmga003.jf.intel.com with ESMTP; 12 Jun 2023 00:14:41 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V2 1/3] vDPA/ifcvf: dynamic allocate vq data stores
Date: Mon, 12 Jun 2023 23:14:18 +0800
Message-Id: <20230612151420.1019504-2-lingshan.zhu@intel.com>
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

This commit dynamically allocates the data
stores for the virtqueues based on
virtio_pci_common_cfg.num_queues.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 3 +++
 drivers/vdpa/ifcvf/ifcvf_base.h | 2 +-
 drivers/vdpa/ifcvf/ifcvf_main.c | 2 ++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 1b5da11f5403..f86495ace825 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -134,6 +134,9 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *pdev)
 	}
 
 	hw->nr_vring = vp_ioread16(&hw->common_cfg->num_queues);
+	hw->vring = kzalloc(sizeof(struct vring_info) * hw->nr_vring, GFP_KERNEL);
+	if (!hw->vring)
+		return -ENOMEM;
 
 	for (i = 0; i < hw->nr_vring; i++) {
 		vp_iowrite16(i, &hw->common_cfg->queue_select);
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index 3110ffc50caf..fa797184056b 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -74,7 +74,7 @@ struct ifcvf_hw {
 	u64 dev_features;
 	struct virtio_pci_common_cfg __iomem *common_cfg;
 	void __iomem *dev_cfg;
-	struct vring_info vring[IFCVF_MAX_QUEUES];
+	struct vring_info *vring;
 	void __iomem * const *base;
 	char config_msix_name[256];
 	struct vdpa_callback config_cb;
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 6e47ac2c669a..2af0de771b49 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -830,6 +830,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 err:
+	kfree(ifcvf_mgmt_dev->vf.vring);
 	kfree(ifcvf_mgmt_dev);
 	return ret;
 }
@@ -840,6 +841,7 @@ static void ifcvf_remove(struct pci_dev *pdev)
 
 	ifcvf_mgmt_dev = pci_get_drvdata(pdev);
 	vdpa_mgmtdev_unregister(&ifcvf_mgmt_dev->mdev);
+	kfree(ifcvf_mgmt_dev->vf.vring);
 	kfree(ifcvf_mgmt_dev);
 }
 
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
