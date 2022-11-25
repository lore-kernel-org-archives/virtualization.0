Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0B7C43217
	for <virtualization@archiver.kernel.org>; Fri, 25 Nov 2022 15:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C1F65404B1;
	Fri, 25 Nov 2022 15:06:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1F65404B1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EasGPO6d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UUtx2daKtsYL; Fri, 25 Nov 2022 15:06:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 47ABF405A0;
	Fri, 25 Nov 2022 15:06:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 47ABF405A0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 230EDC0033;
	Fri, 25 Nov 2022 15:06:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B134CC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CEE882162
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CEE882162
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=EasGPO6d
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U0cfBA7ROG_Z
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E38CD820DD
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E38CD820DD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Nov 2022 15:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669388813; x=1700924813;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=L7+kRJxim+tXndxTiW57BfxqYjmCXRG7PwELl1gNbb4=;
 b=EasGPO6d2HAfz6unQnTEMOuQ6qNlRfcOx0to08VRtYY4K7yR4sIWRb61
 D4DC6tmgVskN+PzpqFzLgQ7CUh2JClsIiZ480FMUF8qASu+fYDoSMR5AO
 PH26AfO+jh3RiQp4oYSr+HRGTSt8EWtcmYNYQdWDcj+RFVAEE0YVp3+4z
 k5yoGGz2i9xWoAgrQi1RKnvQsvpTDuN3CXX4+PvkLiMQ4yWnZSMdgT/T8
 yfHFkg9ZOpBqXFONPr1J2aNfLh/5ac3hW4ThNBQsSY2tKtvuteT1pGEH7
 9qiLsc3jjl4A4CltefMd/x0eFNyi2ugfVD5t8ks77XWs5MWKqTAxoeqZW Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="400787489"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="400787489"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="593240306"
X-IronPort-AV: E=Sophos;i="5.96,193,1665471600"; d="scan'208";a="593240306"
Received: from unknown (HELO localhost.localdomain.bj.intel.com)
 ([10.240.193.73])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 07:06:51 -0800
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH V2 12/12] vDPA/ifcvf: implement features provisioning
Date: Fri, 25 Nov 2022 22:57:24 +0800
Message-Id: <20221125145724.1129962-13-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221125145724.1129962-1-lingshan.zhu@intel.com>
References: <20221125145724.1129962-1-lingshan.zhu@intel.com>
MIME-Version: 1.0
Cc: piotr.uminski@intel.com, hang.yuan@intel.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

This commit implements features provisioning for ifcvf, that means:
1)checkk whether the provisioned features are supported by
the management device
2)vDPA device only presents selected feature bits

Examples:
a)The management device supported features:
$ vdpa mgmtdev show pci/0000:01:00.5
pci/0000:01:00.5:
  supported_classes net
  max_supported_vqs 9
  dev_features MTU MAC MRG_RXBUF CTRL_VQ MQ ANY_LAYOUT VERSION_1 ACCESS_PLATFORM

b)Provision a vDPA device with all supported features:
$ vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.5
$ vdpa/vdpa dev config show vdpa0
vdpa0: mac 00:e8:ca:11:be:05 link up link_announce false max_vq_pairs 4 mtu 1500
  negotiated_features MRG_RXBUF CTRL_VQ MQ VERSION_1 ACCESS_PLATFORM

c)Provision a vDPA device with a subset of the supported features:
$ vdpa dev add name vdpa0 mgmtdev pci/0000:01:00.5 device_features 0x300020020
$ vdpa dev config show vdpa0
mac 00:e8:ca:11:be:05 link up link_announce false
  negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.c |  2 +-
 drivers/vdpa/ifcvf/ifcvf_base.h |  3 +++
 drivers/vdpa/ifcvf/ifcvf_main.c | 13 +++++++++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
index 3ec5ca3aefe1..5563b3a773c7 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.c
+++ b/drivers/vdpa/ifcvf/ifcvf_base.c
@@ -206,7 +206,7 @@ u64 ifcvf_get_hw_features(struct ifcvf_hw *hw)
 
 u64 ifcvf_get_features(struct ifcvf_hw *hw)
 {
-	return hw->hw_features;
+	return hw->dev_features;
 }
 
 int ifcvf_verify_min_features(struct ifcvf_hw *hw, u64 features)
diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index d41e255c581b..c20d1c40214e 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -19,6 +19,7 @@
 #include <uapi/linux/virtio_blk.h>
 #include <uapi/linux/virtio_config.h>
 #include <uapi/linux/virtio_pci.h>
+#include <uapi/linux/vdpa.h>
 
 #define N3000_DEVICE_ID		0x1041
 #define N3000_SUBSYS_DEVICE_ID	0x001A
@@ -75,6 +76,8 @@ struct ifcvf_hw {
 	u32 dev_type;
 	u64 req_features;
 	u64 hw_features;
+	/* provisioned device features */
+	u64 dev_features;
 	struct virtio_pci_common_cfg __iomem *common_cfg;
 	void __iomem *dev_cfg;
 	struct vring_info vring[IFCVF_MAX_QUEUES];
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 5fb3580594d5..cc826bfd3866 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -743,6 +743,7 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	struct vdpa_device *vdpa_dev;
 	struct pci_dev *pdev;
 	struct ifcvf_hw *vf;
+	u64 device_features;
 	int ret;
 
 	ifcvf_mgmt_dev = container_of(mdev, struct ifcvf_vdpa_mgmt_dev, mdev);
@@ -762,6 +763,17 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	adapter->vf = vf;
 	vdpa_dev = &adapter->vdpa;
 
+	device_features = vf->hw_features;
+	if (config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
+		if (config->device_features & ~device_features) {
+			IFCVF_ERR(pdev, "The provisioned features 0x%llx are not supported by this device with features 0x%llx\n",
+				  config->device_features, device_features);
+			return -EINVAL;
+		}
+		device_features &= config->device_features;
+	}
+	vf->dev_features = device_features;
+
 	if (name)
 		ret = dev_set_name(&vdpa_dev->dev, "%s", name);
 	else
@@ -866,6 +878,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ifcvf_mgmt_dev->mdev.device = dev;
 	ifcvf_mgmt_dev->mdev.max_supported_vqs = vf->nr_vring;
 	ifcvf_mgmt_dev->mdev.supported_features = vf->hw_features;
+	ifcvf_mgmt_dev->mdev.config_attr_mask = (1 << VDPA_ATTR_DEV_FEATURES);
 
 	ret = vdpa_mgmtdev_register(&ifcvf_mgmt_dev->mdev);
 	if (ret) {
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
