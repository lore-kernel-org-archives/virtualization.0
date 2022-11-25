Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E95C4167B
	for <virtualization@archiver.kernel.org>; Fri, 25 Nov 2022 15:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2111981EEE;
	Fri, 25 Nov 2022 15:06:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2111981EEE
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lo7GVBto
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cLD6XPqQ87LN; Fri, 25 Nov 2022 15:06:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B34C682159;
	Fri, 25 Nov 2022 15:06:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B34C682159
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 90CF2C0033;
	Fri, 25 Nov 2022 15:06:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DCDFC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0737C8218E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0737C8218E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id E69B_ymrIEiT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4C6968216B
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C6968216B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669388796; x=1700924796;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lNFpEw8fOUanfxMRuET0eEJRiZaA7AVu47NX0D5CI2k=;
 b=lo7GVBtoCOCw8Am0s8dbsV7U0YfGoGF5beXTIrLPOXWYngtvubKi5X40
 KHU5zBNNP5AHpMRQI2NdcbROT+haWFfHA33faur7tEqZyU0WAq+nbSGVY
 n7fip5SA1IryLEtQGX/HjPYtTStJrPAJ1Xnl0Oqpb/Xr8Cx1unE9exrw6
 l0BCNSmXznMgi/TiPy2i7PhPr+DL8HxB1PfXNqaZe7CmetCKV7QWdHJuQ
 kmVVJoRPGh4xE6m9Rfrj27XxQ6YuaohZF32EBK8c9nCWxFw3shy2bTZIz
 jiMZ29hf/AwdpMV7zvQDc/70s7Um0wjNRef+zLLGnIanUjFpBjfvKkhIW w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="400787377"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="400787377"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:36 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="593240258"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="593240258"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:32 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH V2 05/12] vDPA/ifcvf: decouple config IRQ releaser from the
 adapter
Date: Fri, 25 Nov 2022 22:57:17 +0800
Message-Id: <20221125145724.1129962-6-lingshan.zhu@intel.com>
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

This commit decouples config IRQ releaser from the adapter,
so that it could be invoked once probe or in err handlers.
ifcvf_free_irq() works on ifcvf_hw in this commit

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: stable@vger.kernel.org
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 7dac0285b71d..c635f78f5c4c 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -101,10 +101,9 @@ static void ifcvf_free_vq_irq(struct ifcvf_hw *vf)
 		ifcvf_free_vqs_reused_irq(vf);
 }
 
-static void ifcvf_free_config_irq(struct ifcvf_adapter *adapter)
+static void ifcvf_free_config_irq(struct ifcvf_hw *vf)
 {
-	struct pci_dev *pdev = adapter->pdev;
-	struct ifcvf_hw *vf = &adapter->vf;
+	struct pci_dev *pdev = vf->pdev;
 
 	if (vf->config_irq == -EINVAL)
 		return;
@@ -119,13 +118,12 @@ static void ifcvf_free_config_irq(struct ifcvf_adapter *adapter)
 	}
 }
 
-static void ifcvf_free_irq(struct ifcvf_adapter *adapter)
+static void ifcvf_free_irq(struct ifcvf_hw *vf)
 {
-	struct pci_dev *pdev = adapter->pdev;
-	struct ifcvf_hw *vf = &adapter->vf;
+	struct pci_dev *pdev = vf->pdev;
 
 	ifcvf_free_vq_irq(vf);
-	ifcvf_free_config_irq(adapter);
+	ifcvf_free_config_irq(vf);
 	ifcvf_free_irq_vectors(pdev);
 }
 
@@ -187,7 +185,7 @@ static int ifcvf_request_per_vq_irq(struct ifcvf_adapter *adapter)
 
 	return 0;
 err:
-	ifcvf_free_irq(adapter);
+	ifcvf_free_irq(vf);
 
 	return -EFAULT;
 }
@@ -221,7 +219,7 @@ static int ifcvf_request_vqs_reused_irq(struct ifcvf_adapter *adapter)
 
 	return 0;
 err:
-	ifcvf_free_irq(adapter);
+	ifcvf_free_irq(vf);
 
 	return -EFAULT;
 }
@@ -262,7 +260,7 @@ static int ifcvf_request_dev_irq(struct ifcvf_adapter *adapter)
 
 	return 0;
 err:
-	ifcvf_free_irq(adapter);
+	ifcvf_free_irq(vf);
 
 	return -EFAULT;
 
@@ -317,7 +315,7 @@ static int ifcvf_request_config_irq(struct ifcvf_adapter *adapter)
 
 	return 0;
 err:
-	ifcvf_free_irq(adapter);
+	ifcvf_free_irq(vf);
 
 	return -EFAULT;
 }
@@ -508,7 +506,7 @@ static int ifcvf_vdpa_reset(struct vdpa_device *vdpa_dev)
 
 	if (status_old & VIRTIO_CONFIG_S_DRIVER_OK) {
 		ifcvf_stop_datapath(adapter);
-		ifcvf_free_irq(adapter);
+		ifcvf_free_irq(vf);
 	}
 
 	ifcvf_reset_vring(adapter);
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
