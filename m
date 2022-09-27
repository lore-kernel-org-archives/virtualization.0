Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C305DC6FA83
	for <virtualization@archiver.kernel.org>; Tue, 27 Sep 2022 07:48:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 602C861023;
	Tue, 27 Sep 2022 07:48:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 602C861023
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=edYfb85e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nuLWTgh3RuL3; Tue, 27 Sep 2022 07:48:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CDD9460F54;
	Tue, 27 Sep 2022 07:48:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CDD9460F54
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B777DC0032;
	Tue, 27 Sep 2022 07:48:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E634C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 07:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49B6881AD7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 07:48:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49B6881AD7
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=edYfb85e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xp0i6PCFh6mL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 07:48:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1366281980
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1366281980
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Sep 2022 07:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664264922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O+xVSYvrcExNi3b5vWTVxTrujIqDhZXI0mpvkuH7plY=;
 b=edYfb85enD1FH70fj8NW/It7PrUOS2a++zGdsUZCwnID6v0yrKN9tdVl3LQ/NntQCHWyXS
 ZrrrOWbxotGGRj5rvORtJSMwpXdxQObJXNvn4Z6qGKJUTbobbqwyrgKrrycZtgcGBt6RZD
 4g2u2GN14BVpudWmPSLHFnmPSDGJIXk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-cxwJkCMIOE2EZUhENpU4zg-1; Tue, 27 Sep 2022 03:48:37 -0400
X-MC-Unique: cxwJkCMIOE2EZUhENpU4zg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4ED75862FDC;
 Tue, 27 Sep 2022 07:48:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-192.pek2.redhat.com
 [10.72.13.192])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F197140EBF5;
 Tue, 27 Sep 2022 07:48:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH V3 3/3] vp_vdpa: support feature provisioning
Date: Tue, 27 Sep 2022 15:48:10 +0800
Message-Id: <20220927074810.28627-4-jasowang@redhat.com>
In-Reply-To: <20220927074810.28627-1-jasowang@redhat.com>
References: <20220927074810.28627-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

For example:

# vdpa mgmtdev show
pci/0000:02:00.0:
  supported_classes net
  max_supported_vqs 3
  dev_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC GUEST_TSO4
  GUEST_TSO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6 HOST_ECN HOST_UFO
  MRG_RXBUF STATUS CTRL_VQ CTRL_RX CTRL_VLAN CTRL_RX_EXTRA
  GUEST_ANNOUNCE CTRL_MAC_ADDR RING_INDIRECT_DESC RING_EVENT_IDX
  VERSION_1 ACCESS_PLATFORM

1) provision vDPA device with all features that are supported by the virtio-pci

# vdpa dev add name dev1 mgmtdev pci/0000:02:00.0
# vdpa dev config show
dev1: mac 52:54:00:12:34:56 link up link_announce false mtu 65535
  negotiated_features CSUM GUEST_CSUM CTRL_GUEST_OFFLOADS MAC
  GUEST_TSO4 GUEST_TSO6 GUEST_ECN GUEST_UFO HOST_TSO4 HOST_TSO6
  HOST_ECN HOST_UFO MRG_RXBUF STATUS CTRL_VQ CTRL_RX CTRL_VLAN
  GUEST_ANNOUNCE CTRL_MAC_ADDR RING_INDIRECT_DESC RING_EVENT_IDX
  VERSION_1 ACCESS_PLATFORM

2) provision vDPA device with a subset of the features

# vdpa dev add name dev1 mgmtdev pci/0000:02:00.0 device_features 0x300020000
# dev1: mac 52:54:00:12:34:56 link up link_announce false mtu 65535
  negotiated_features CTRL_VQ VERSION_1 ACCESS_PLATFORM

Reviewed-by: Eli Cohen <elic@nvidia.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 04522077735b..d448db0c4de3 100644
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
@@ -491,6 +494,20 @@ static int vp_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name,
 	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
 	vp_vdpa->mdev = mdev;
 
+	device_features = vp_modern_get_features(mdev);
+	if (add_config->mask & BIT_ULL(VDPA_ATTR_DEV_FEATURES)) {
+		if (add_config->device_features & ~device_features) {
+			ret = -EINVAL;
+			dev_err(&pdev->dev, "Try to provision features "
+				"that are not supported by the device: "
+				"device_features 0x%llx provisioned 0x%llx\n",
+				device_features, add_config->device_features);
+			goto err;
+		}
+		device_features = add_config->device_features;
+	}
+	vp_vdpa->device_features = device_features;
+
 	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
 	if (ret) {
 		dev_err(&pdev->dev,
@@ -599,6 +616,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
