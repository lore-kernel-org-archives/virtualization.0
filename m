Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E4C7EE23
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 06:53:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C6D91402F8;
	Fri, 26 May 2023 06:53:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C6D91402F8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JZ5/WAAY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hHyFtCu_GrlD; Fri, 26 May 2023 06:53:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B5B9F40301;
	Fri, 26 May 2023 06:53:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B5B9F40301
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F269AC008E;
	Fri, 26 May 2023 06:53:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4AB52C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CFF4442A7A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CFF4442A7A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JZ5/WAAY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6EmPNVl8dn78
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2402442C81
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2402442C81
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 06:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685083998; x=1716619998;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=LLmB/p5g3iW0+1qZZQUmpDD+FSCoiprMudoANa3RSq0=;
 b=JZ5/WAAY9RJ4fWTxcMusOU3DMEmAwcJHCxig+98yQu4//1U6L7MshDPc
 Gj9KWQSRfEEPVZnMutmsbkRssrDNSCoLsK992eZPb4BUnR5ncq5j6QMcT
 2xYTar+fIJePfHCoaynKTeJmfHK20G4jtZFXNpIpLWgzFVSv8wSEylazh
 NVg2LSKPmCRhwV+7Qh8GI7UtInTmzaXOpAzsC1lAwZDOZ7iC1Z0Lzq8qZ
 Bvr6cYv04SGr2SlFT9rYdk3xFwLOsZxjjnzxrPV2sDz+Wl8IiRL/XXSSV
 2m0NO4Nt3IiMxAxq0T4J3ks4g1oKdmn3PTFSb9yK8onxRUooRhPx4dwBA g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="333763387"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="333763387"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2023 23:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="770241650"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="770241650"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga008.fm.intel.com with ESMTP; 25 May 2023 23:53:16 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V3 3/5] vDPA/ifcvf: retire ifcvf_start_datapath and
 ifcvf_add_status
Date: Fri, 26 May 2023 22:52:52 +0800
Message-Id: <20230526145254.39537-4-lingshan.zhu@intel.com>
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

Rather than former lazy-initialization mechanism,
now the virtqueue operations and driver_features related
ops access the virtio registers directly to take
immediate actions. So ifcvf_start_datapath() should
retire.

ifcvf_add_status() is retierd because we should not change
device status by a vendor driver's decision, this driver should
only set device status which is from virito drivers
upon vdpa_ops.set_status()

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c | 19 -------------------
 drivers/vdpa/ifcvf/ifcvf_base.h |  1 -
 drivers/vdpa/ifcvf/ifcvf_main.c | 23 -----------------------
 3 files changed, 43 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 546e923bcd16..79e313c5e10e 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -178,15 +178,6 @@ void ifcvf_reset(struct ifcvf_hw *hw)
 	ifcvf_get_status(hw);
 }
 
-static void ifcvf_add_status(struct ifcvf_hw *hw, u8 status)
-{
-	if (status != 0)
-		status |= ifcvf_get_status(hw);
-
-	ifcvf_set_status(hw, status);
-	ifcvf_get_status(hw);
-}
-
 u64 ifcvf_get_hw_features(struct ifcvf_hw *hw)
 {
 	struct virtio_pci_common_cfg __iomem *cfg = hw->common_cfg;
@@ -387,16 +378,6 @@ static void ifcvf_hw_disable(struct ifcvf_hw *hw)
 	}
 }
 
-int ifcvf_start_hw(struct ifcvf_hw *hw)
-{
-	ifcvf_add_status(hw, VIRTIO_CONFIG_S_ACKNOWLEDGE);
-	ifcvf_add_status(hw, VIRTIO_CONFIG_S_DRIVER);
-
-	ifcvf_add_status(hw, VIRTIO_CONFIG_S_DRIVER_OK);
-
-	return 0;
-}
-
 void ifcvf_stop_hw(struct ifcvf_hw *hw)
 {
 	ifcvf_hw_disable(hw);
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index cb19196c3ece..d34d3bc0dbf4 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -110,7 +110,6 @@ struct ifcvf_vdpa_mgmt_dev {
 };
 
 int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *dev);
-int ifcvf_start_hw(struct ifcvf_hw *hw);
 void ifcvf_stop_hw(struct ifcvf_hw *hw);
 void ifcvf_notify_queue(struct ifcvf_hw *hw, u16 qid);
 void ifcvf_read_dev_config(struct ifcvf_hw *hw, u64 offset,
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 4588484bd53d..968687159e44 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -346,22 +346,6 @@ static int ifcvf_request_irq(struct ifcvf_hw *vf)
 	return 0;
 }
 
-static int ifcvf_start_datapath(struct ifcvf_adapter *adapter)
-{
-	struct ifcvf_hw *vf = adapter->vf;
-	u8 status;
-	int ret;
-
-	ret = ifcvf_start_hw(vf);
-	if (ret < 0) {
-		status = ifcvf_get_status(vf);
-		status |= VIRTIO_CONFIG_S_FAILED;
-		ifcvf_set_status(vf, status);
-	}
-
-	return ret;
-}
-
 static int ifcvf_stop_datapath(struct ifcvf_adapter *adapter)
 {
 	struct ifcvf_hw *vf = adapter->vf;
@@ -452,13 +436,11 @@ static u8 ifcvf_vdpa_get_status(struct vdpa_device *vdpa_dev)
 
 static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 {
-	struct ifcvf_adapter *adapter;
 	struct ifcvf_hw *vf;
 	u8 status_old;
 	int ret;
 
 	vf  = vdpa_to_vf(vdpa_dev);
-	adapter = vdpa_to_adapter(vdpa_dev);
 	status_old = ifcvf_get_status(vf);
 
 	if (status_old == status)
@@ -473,11 +455,6 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 			ifcvf_set_status(vf, status);
 			return;
 		}
-
-		if (ifcvf_start_datapath(adapter) < 0)
-			IFCVF_ERR(adapter->pdev,
-				  "Failed to set ifcvf vdpa  status %u\n",
-				  status);
 	}
 
 	ifcvf_set_status(vf, status);
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
