Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62518C761AF
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 12:49:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE9338461A;
	Fri, 31 Mar 2023 12:49:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE9338461A
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SlUioIjl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sk2ukKFNfyO7; Fri, 31 Mar 2023 12:49:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3982084620;
	Fri, 31 Mar 2023 12:49:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3982084620
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 270AFC0091;
	Fri, 31 Mar 2023 12:49:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C93FFC0037
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9424D422BE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9424D422BE
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=SlUioIjl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id weIvRXiG5ymC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 868A04224C
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 868A04224C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1680266950; x=1711802950;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4jvnGgf0RzM+GD9bQ5V4sg2+ILnCHztyWpSlsEYrAhI=;
 b=SlUioIjlM0nXZ6ulC/sytpDFASlIVDRTknP7CCqoZWPm7H9qH25Q2S7p
 IJlnO5nSiyWk8AWUW3BMO3zlJanaAcJ9Zs6jCtD6o+2V7y6rpXi6fE/vX
 a8jg2s7yIT7cQ+M99eVieXzIqQ8kMz51EHP3etQXTNZz5CMTj5OxNCior
 F4YE48yd9r0poxHs5AVEvyjiJSr2oX3AU1KV9KsbbZpsymmHdzZ7dlgvP
 G02NZkd0CmNTKGGipG8TG2mvH1jzh4So+SFAG4BIVCfS7/XewOZ//kmLX
 pCkDAeQk/Gax7CYX71qReeDFEC3H4RYW54G4sU4481bmbeNDDdKIuYcdz Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="404162357"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="404162357"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2023 05:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="931155981"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; d="scan'208";a="931155981"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga006.fm.intel.com with ESMTP; 31 Mar 2023 05:49:03 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 3/5] retire ifcvf_start_datapath and ifcvf_add_status
Date: Sat,  1 Apr 2023 04:48:52 +0800
Message-Id: <20230331204854.20082-4-lingshan.zhu@intel.com>
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
