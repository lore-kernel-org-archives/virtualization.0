Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E79C433DB
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:55:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4AA620DD4
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4AA620DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A9A91867FD;
	Mon,  4 Jan 2021 06:55:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x5pkZ0IRL+UP; Mon,  4 Jan 2021 06:55:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id DDBEB86803;
	Mon,  4 Jan 2021 06:55:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C84E1C0893;
	Mon,  4 Jan 2021 06:55:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21B4BC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0FF04864DA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XGVcujn6-QOY
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 54B24867BF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609743317;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sx9CkeT49Y5v/fsgiCMvf06VGl1fCTjvDM6d0ED+Sx0=;
 b=ZRoXGYd3/4H5GEEGlhhVegkDEm9CgKzje2aizpDgs7F/NYgOuADr14e8Qpot9UUd07nY4F
 uDqti76iOsU9nSNa6osOkoTlFnH5zrIWau30c4dzRjG9d1teWZRLjOJS6Yej1CE5+soPr3
 aVKIRAGXqN2d9VK5J2w0TasIXaSsL8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-eFQhOczmMkSnHTTOanYarg-1; Mon, 04 Jan 2021 01:55:15 -0500
X-MC-Unique: eFQhOczmMkSnHTTOanYarg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8CC25180A089;
 Mon,  4 Jan 2021 06:55:14 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-91.pek2.redhat.com [10.72.13.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEED51002388;
 Mon,  4 Jan 2021 06:55:11 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V3 01/19] virtio-pci: do not access iomem via struct
 virtio_pci_device directly
Date: Mon,  4 Jan 2021 14:54:45 +0800
Message-Id: <20210104065503.199631-2-jasowang@redhat.com>
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

Instead of accessing iomem via struct virito_pci_device directly,
tweak to call the io accessors through the iomem structure. This will
ease the splitting of modern virtio device logic.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 76 ++++++++++++++++++------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 3d6ae5a5e252..df1481fd400c 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -141,12 +141,13 @@ static void __iomem *map_capability(struct pci_dev *dev, int off,
 static u64 vp_get_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
 	u64 features;
 
-	vp_iowrite32(0, &vp_dev->common->device_feature_select);
-	features = vp_ioread32(&vp_dev->common->device_feature);
-	vp_iowrite32(1, &vp_dev->common->device_feature_select);
-	features |= ((u64)vp_ioread32(&vp_dev->common->device_feature) << 32);
+	vp_iowrite32(0, &cfg->device_feature_select);
+	features = vp_ioread32(&cfg->device_feature);
+	vp_iowrite32(1, &cfg->device_feature_select);
+	features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
 
 	return features;
 }
@@ -165,6 +166,7 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
 static int vp_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
 	u64 features = vdev->features;
 
 	/* Give virtio_ring a chance to accept features. */
@@ -179,10 +181,10 @@ static int vp_finalize_features(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	vp_iowrite32(0, &vp_dev->common->guest_feature_select);
-	vp_iowrite32((u32)vdev->features, &vp_dev->common->guest_feature);
-	vp_iowrite32(1, &vp_dev->common->guest_feature_select);
-	vp_iowrite32(vdev->features >> 32, &vp_dev->common->guest_feature);
+	vp_iowrite32(0, &cfg->guest_feature_select);
+	vp_iowrite32((u32)vdev->features, &cfg->guest_feature);
+	vp_iowrite32(1, &cfg->guest_feature_select);
+	vp_iowrite32(vdev->features >> 32, &cfg->guest_feature);
 
 	return 0;
 }
@@ -192,6 +194,7 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 		   void *buf, unsigned len)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	void __iomem *device = vp_dev->device;
 	u8 b;
 	__le16 w;
 	__le32 l;
@@ -200,21 +203,21 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 
 	switch (len) {
 	case 1:
-		b = ioread8(vp_dev->device + offset);
+		b = ioread8(device + offset);
 		memcpy(buf, &b, sizeof b);
 		break;
 	case 2:
-		w = cpu_to_le16(ioread16(vp_dev->device + offset));
+		w = cpu_to_le16(ioread16(device + offset));
 		memcpy(buf, &w, sizeof w);
 		break;
 	case 4:
-		l = cpu_to_le32(ioread32(vp_dev->device + offset));
+		l = cpu_to_le32(ioread32(device + offset));
 		memcpy(buf, &l, sizeof l);
 		break;
 	case 8:
-		l = cpu_to_le32(ioread32(vp_dev->device + offset));
+		l = cpu_to_le32(ioread32(device + offset));
 		memcpy(buf, &l, sizeof l);
-		l = cpu_to_le32(ioread32(vp_dev->device + offset + sizeof l));
+		l = cpu_to_le32(ioread32(device + offset + sizeof l));
 		memcpy(buf + sizeof l, &l, sizeof l);
 		break;
 	default:
@@ -228,6 +231,7 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 		   const void *buf, unsigned len)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	void __iomem *device = vp_dev->device;
 	u8 b;
 	__le16 w;
 	__le32 l;
@@ -237,21 +241,21 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 	switch (len) {
 	case 1:
 		memcpy(&b, buf, sizeof b);
-		iowrite8(b, vp_dev->device + offset);
+		iowrite8(b, device + offset);
 		break;
 	case 2:
 		memcpy(&w, buf, sizeof w);
-		iowrite16(le16_to_cpu(w), vp_dev->device + offset);
+		iowrite16(le16_to_cpu(w), device + offset);
 		break;
 	case 4:
 		memcpy(&l, buf, sizeof l);
-		iowrite32(le32_to_cpu(l), vp_dev->device + offset);
+		iowrite32(le32_to_cpu(l), device + offset);
 		break;
 	case 8:
 		memcpy(&l, buf, sizeof l);
-		iowrite32(le32_to_cpu(l), vp_dev->device + offset);
+		iowrite32(le32_to_cpu(l), device + offset);
 		memcpy(&l, buf + sizeof l, sizeof l);
-		iowrite32(le32_to_cpu(l), vp_dev->device + offset + sizeof l);
+		iowrite32(le32_to_cpu(l), device + offset + sizeof l);
 		break;
 	default:
 		BUG();
@@ -261,35 +265,43 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 static u32 vp_generation(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	return vp_ioread8(&vp_dev->common->config_generation);
+	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+
+	return vp_ioread8(&cfg->config_generation);
 }
 
 /* config->{get,set}_status() implementations */
 static u8 vp_get_status(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	return vp_ioread8(&vp_dev->common->device_status);
+	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+
+	return vp_ioread8(&cfg->device_status);
 }
 
 static void vp_set_status(struct virtio_device *vdev, u8 status)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+
 	/* We should never be setting status to 0. */
 	BUG_ON(status == 0);
-	vp_iowrite8(status, &vp_dev->common->device_status);
+	vp_iowrite8(status, &cfg->device_status);
 }
 
 static void vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+
 	/* 0 status means a reset. */
-	vp_iowrite8(0, &vp_dev->common->device_status);
+	vp_iowrite8(0, &cfg->device_status);
 	/* After writing 0 to device_status, the driver MUST wait for a read of
 	 * device_status to return 0 before reinitializing the device.
 	 * This will flush out the status write, and flush in device writes,
 	 * including MSI-X interrupts, if any.
 	 */
-	while (vp_ioread8(&vp_dev->common->device_status))
+	while (vp_ioread8(&cfg->device_status))
 		msleep(1);
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
@@ -297,11 +309,13 @@ static void vp_reset(struct virtio_device *vdev)
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
 {
+	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+
 	/* Setup the vector used for configuration events */
-	vp_iowrite16(vector, &vp_dev->common->msix_config);
+	vp_iowrite16(vector, &cfg->msix_config);
 	/* Verify we had enough resources to assign the vector */
 	/* Will also flush the write out to device */
-	return vp_ioread16(&vp_dev->common->msix_config);
+	return vp_ioread16(&cfg->msix_config);
 }
 
 static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
@@ -407,6 +421,7 @@ static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			      struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
 	struct virtqueue *vq;
 	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, ctx, desc);
 
@@ -417,8 +432,8 @@ static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	 * this, there's no way to go back except reset.
 	 */
 	list_for_each_entry(vq, &vdev->vqs, list) {
-		vp_iowrite16(vq->index, &vp_dev->common->queue_select);
-		vp_iowrite16(1, &vp_dev->common->queue_enable);
+		vp_iowrite16(vq->index, &cfg->queue_select);
+		vp_iowrite16(1, &cfg->queue_enable);
 	}
 
 	return 0;
@@ -428,14 +443,15 @@ static void del_vq(struct virtio_pci_vq_info *info)
 {
 	struct virtqueue *vq = info->vq;
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
+	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
 
-	vp_iowrite16(vq->index, &vp_dev->common->queue_select);
+	vp_iowrite16(vq->index, &cfg->queue_select);
 
 	if (vp_dev->msix_enabled) {
 		vp_iowrite16(VIRTIO_MSI_NO_VECTOR,
-			     &vp_dev->common->queue_msix_vector);
+			     &cfg->queue_msix_vector);
 		/* Flush the write out to device */
-		vp_ioread16(&vp_dev->common->queue_msix_vector);
+		vp_ioread16(&cfg->queue_msix_vector);
 	}
 
 	if (!vp_dev->notify_base)
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
