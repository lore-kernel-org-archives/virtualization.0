Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6E7C433E0
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:55:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185EE2151B
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185EE2151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7111920529;
	Mon,  4 Jan 2021 06:55:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WLwXaHJi6LC6; Mon,  4 Jan 2021 06:55:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2C9982011B;
	Mon,  4 Jan 2021 06:55:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1273AC0893;
	Mon,  4 Jan 2021 06:55:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AAB2C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8886486F3F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wYjBiCDCy3aN
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6B8C186FA5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609743349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=beqiSug2CHYTN1W6nggpEpwUBNclSVEckxreRjbzJ6U=;
 b=LAQfESD5ZqceJzcuoC/L+89Y8yA/XVDcexD9gWhlX/jF2J8R3ycUD2umNFi+YqRNl3+XTU
 TU0ujHzUouelGjnBEABPRIGOCIeXPxRqdutjDvi6Y4FtVHPYQLZRUigdQxkYxruL4ciWrN
 WW/FQ+7cMewrMUzWzy+lwMcRvtB1sOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-BaJ9tILFPvyJtYXPx6B2PA-1; Mon, 04 Jan 2021 01:55:45 -0500
X-MC-Unique: BaJ9tILFPvyJtYXPx6B2PA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C35859;
 Mon,  4 Jan 2021 06:55:44 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-91.pek2.redhat.com [10.72.13.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CED121002388;
 Mon,  4 Jan 2021 06:55:41 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V3 09/19] virtio-pci-modern: introduce
 vp_modern_set_queue_vector()
Date: Mon,  4 Jan 2021 14:54:53 +0800
Message-Id: <20210104065503.199631-10-jasowang@redhat.com>
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

This patch introduces a helper to set virtqueue MSI vector.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 35 ++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index a128e5814045..05cd409c0731 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -191,6 +191,25 @@ static void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
 	vp_iowrite32(features >> 32, &cfg->guest_feature);
 }
 
+/*
+ * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: queue index
+ * @vector: the config vector
+ *
+ * Returns the config vector read from the device
+ */
+static u16 vp_modern_queue_vector(struct virtio_pci_modern_device *mdev,
+				  u16 index, u16 vector)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	vp_iowrite16(index, &cfg->queue_select);
+	vp_iowrite16(vector, &cfg->queue_msix_vector);
+	/* Flush the write out to device */
+	return vp_ioread16(&cfg->queue_msix_vector);
+}
+
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
@@ -474,8 +493,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	}
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
-		vp_iowrite16(msix_vec, &cfg->queue_msix_vector);
-		msix_vec = vp_ioread16(&cfg->queue_msix_vector);
+		msix_vec = vp_modern_queue_vector(mdev, index, msix_vec);
 		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
 			goto err_assign_vector;
@@ -522,17 +540,10 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	struct virtqueue *vq = info->vq;
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
-
 
-	vp_iowrite16(vq->index, &cfg->queue_select);
-
-	if (vp_dev->msix_enabled) {
-		vp_iowrite16(VIRTIO_MSI_NO_VECTOR,
-			     &cfg->queue_msix_vector);
-		/* Flush the write out to device */
-		vp_ioread16(&cfg->queue_msix_vector);
-	}
+	if (vp_dev->msix_enabled)
+		vp_modern_queue_vector(mdev, vq->index,
+				       VIRTIO_MSI_NO_VECTOR);
 
 	if (!mdev->notify_base)
 		pci_iounmap(mdev->pci_dev, (void __force __iomem *)vq->priv);
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
