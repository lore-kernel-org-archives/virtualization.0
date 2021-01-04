Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414ECC433E6
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:55:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCDDF2151B
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCDDF2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8ED74200ED;
	Mon,  4 Jan 2021 06:55:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id phTqRirBCZXB; Mon,  4 Jan 2021 06:55:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BEB2C2011B;
	Mon,  4 Jan 2021 06:55:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A51AEC0893;
	Mon,  4 Jan 2021 06:55:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A9FAC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 6D3A785E51
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OogDcW_BYvOk
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id C315585DF4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609743340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q5MCDvT08fgLwp/aut+xPMU+fLypodHK/gTdgTX0+hc=;
 b=MNwTgvn6e2D4HyUXQJQTmyQU7KLEALnXvuNeIT4g7VoVME0Lkwk1/+xXEb8kxz5ptNPYA/
 ANstNxyAyYmhb4gxBrMS5zhJuXrza0PqLnaMVeExthSaIJUIr1mzL6qa4Ke2WmtOrbeMuM
 +f5HGsJ3xYdIl+GCeANeEWDWBEc17Tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-B6ARsdfRNrKeUAZGDWXNmg-1; Mon, 04 Jan 2021 01:55:39 -0500
X-MC-Unique: B6ARsdfRNrKeUAZGDWXNmg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE47F180A087;
 Mon,  4 Jan 2021 06:55:37 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-91.pek2.redhat.com [10.72.13.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E1661002388;
 Mon,  4 Jan 2021 06:55:34 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V3 07/19] virtio-pci-modern: introduce helpers for setting and
 getting features
Date: Mon,  4 Jan 2021 14:54:51 +0800
Message-Id: <20210104065503.199631-8-jasowang@redhat.com>
In-Reply-To: <20210104065503.199631-1-jasowang@redhat.com>
References: <20210104065503.199631-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: shahafs@mellanox.com, rdunlap@infradead.org, lulu@redhat.com
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

This patch introduces helpers for setting and getting features.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 43 +++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index ccde0a41209a..cb14fc334a9c 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -137,12 +137,16 @@ static void __iomem *map_capability(struct pci_dev *dev, int off,
 	return p;
 }
 
-/* virtio config->get_features() implementation */
-static u64 vp_get_features(struct virtio_device *vdev)
+/*
+ * vp_modern_get_features - get features from device
+ * @mdev: the modern virtio-pci device
+ *
+ * Returns the features read from the device
+ */
+static u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
 	u64 features;
 
 	vp_iowrite32(0, &cfg->device_feature_select);
@@ -153,6 +157,14 @@ static u64 vp_get_features(struct virtio_device *vdev)
 	return features;
 }
 
+/* virtio config->get_features() implementation */
+static u64 vp_get_features(struct virtio_device *vdev)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	return vp_modern_get_features(&vp_dev->mdev);
+}
+
 static void vp_transport_features(struct virtio_device *vdev, u64 features)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -163,12 +175,26 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
 		__virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
 }
 
+/*
+ * vp_modern_set_features - set features to device
+ * @mdev: the modern virtio-pci device
+ * @features: the features set to device
+ */
+static void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
+				   u64 features)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	vp_iowrite32(0, &cfg->guest_feature_select);
+	vp_iowrite32((u32)features, &cfg->guest_feature);
+	vp_iowrite32(1, &cfg->guest_feature_select);
+	vp_iowrite32(features >> 32, &cfg->guest_feature);
+}
+
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 	u64 features = vdev->features;
 
 	/* Give virtio_ring a chance to accept features. */
@@ -183,10 +209,7 @@ static int vp_finalize_features(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	vp_iowrite32(0, &cfg->guest_feature_select);
-	vp_iowrite32((u32)vdev->features, &cfg->guest_feature);
-	vp_iowrite32(1, &cfg->guest_feature_select);
-	vp_iowrite32(vdev->features >> 32, &cfg->guest_feature);
+	vp_modern_set_features(&vp_dev->mdev, vdev->features);
 
 	return 0;
 }
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
