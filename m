Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41336C6FA8A
	for <virtualization@archiver.kernel.org>; Thu, 15 Sep 2022 08:51:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2F1D41904;
	Thu, 15 Sep 2022 08:51:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2F1D41904
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jACAGzyI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sj8r_qWY56Uu; Thu, 15 Sep 2022 08:51:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 08BFD401A0;
	Thu, 15 Sep 2022 08:51:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 08BFD401A0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5423C0033;
	Thu, 15 Sep 2022 08:51:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5B369C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 08:51:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 365E361012
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 08:51:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 365E361012
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jACAGzyI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IwFDGEcJvFgj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 08:51:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 521446102A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 521446102A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Sep 2022 08:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663231876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LsSelknX6THRoDMT4JVzqL+8FJL3Dn3j4efuY9sh5qA=;
 b=jACAGzyIr4OtiLgDJiufhmK7y5qqSc4UVcH01G4KSlCEJ0RarYgLbAU7xdmdRboZcIN/Ss
 PUsyn6l006CmhlUh3QiR//V+C0axQ5HryR2HqahYtGI2iaEGomka9JghIGLFTHyPNUr6PV
 HseC2tUMR3vM44BNg/cjtQc58Kh9oXQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-436-Hijl4VYnMV-lBqcVpA2XRg-1; Thu, 15 Sep 2022 04:51:15 -0400
X-MC-Unique: Hijl4VYnMV-lBqcVpA2XRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 823B82932498;
 Thu, 15 Sep 2022 08:51:14 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-201.pek2.redhat.com
 [10.72.12.201])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8258E1759E;
 Thu, 15 Sep 2022 08:51:09 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 3/3] vp_vdpa: support feature provisioning
Date: Thu, 15 Sep 2022 16:50:48 +0800
Message-Id: <20220915085048.12840-4-jasowang@redhat.com>
In-Reply-To: <20220915085048.12840-1-jasowang@redhat.com>
References: <20220915085048.12840-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: lulu@redhat.com, xieyongji@bytedance.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, wuzongyong@linux.alibaba.com, elic@nvidia.com,
 lingshan.zhu@intel.com
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

This patch allows the device features to be provisioned via
netlink. This is done by:

1) validating the provisioned features to be a subset of the parent
   features.
2) clearing the features that is not wanted by the userspace

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 04522077735b..4b28e0c95ba2 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -17,6 +17,7 @@
 #include <linux/virtio_ring.h>
 #include <linux/virtio_pci.h>
 #include <linux/virtio_pci_modern.h>
+#include <uapi/linux/vdpa.h>
 
 #define VP_VDPA_QUEUE_MAX 256
 #define VP_VDPA_DRIVER_NAME "vp_vdpa"
@@ -35,6 +36,7 @@ struct vp_vdpa {
 	struct virtio_pci_modern_device *mdev;
 	struct vp_vring *vring;
 	struct vdpa_callback config_cb;
+	u64 device_features;
 	char msix_name[VP_VDPA_NAME_SIZE];
 	int config_irq;
 	int queues;
@@ -66,9 +68,9 @@ static struct virtio_pci_modern_device *vp_vdpa_to_mdev(struct vp_vdpa *vp_vdpa)
 
 static u64 vp_vdpa_get_device_features(struct vdpa_device *vdpa)
 {
-	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
 
-	return vp_modern_get_features(mdev);
+	return vp_vdpa->device_features;
 }
 
 static int vp_vdpa_set_driver_features(struct vdpa_device *vdpa, u64 features)
@@ -475,6 +477,7 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	struct pci_dev *pdev = mdev->pci_dev;
 	struct device *dev = &pdev->dev;
 	struct vp_vdpa *vp_vdpa = NULL;
+	u64 device_features;
 	int ret, i;
 
 	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
@@ -491,6 +494,14 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
 	vp_vdpa->mdev = mdev;
 
+	device_features = vp_modern_get_features(mdev);
+	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
+		if (add_config->device_features & ~device_features)
+			return -EINVAL;
+		device_features &= add_config->device_features;
+	}
+	vp_vdpa->device_features = device_features;
+
 	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
 	if (ret) {
 		dev_err(&pdev->dev,
@@ -599,6 +610,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mgtdev->id_table = mdev_id;
 	mgtdev->max_supported_vqs = vp_modern_get_num_queues(mdev);
 	mgtdev->supported_features = vp_modern_get_features(mdev);
+	mgtdev->config_attr_mask = (1 << VDPA_ATTR_DEV_FEATURES);
 	pci_set_master(pdev);
 	pci_set_drvdata(pdev, vp_vdpa_mgtdev);
 
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
