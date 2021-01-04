Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A71C433E6
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:55:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C580C21D79
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 06:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C580C21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 688F4867FC;
	Mon,  4 Jan 2021 06:55:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SbkMPWR6SlCv; Mon,  4 Jan 2021 06:55:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 38D1D8682A;
	Mon,  4 Jan 2021 06:55:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14DFCC0893;
	Mon,  4 Jan 2021 06:55:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E78BC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 07529203CD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3dIfb3sk9PIG
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 0D96C203DC
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 06:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609743321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSqnQEvgpDZWygVLctoXoNlN1ACEW6PG1r54dTzzI7c=;
 b=SHqT4FFHvgHdGN07/QG2Yyd1SER1qjlCjhSlSeRxlUY0ArrX2PPiSA76Z2kVJ/xSER247h
 FUjhvmvXoYv2MjQftA6ZIf42PKTjEOtcVwEuJmxeptfDY+5+AjsW4I9vSsJi4zZkyvcGua
 60G9Ryq/l1YJ9gfYAEfnkPwoY4lQ63g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-WTCTrW6nPpSJEh2esP6huw-1; Mon, 04 Jan 2021 01:55:19 -0500
X-MC-Unique: WTCTrW6nPpSJEh2esP6huw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 046E615721;
 Mon,  4 Jan 2021 06:55:18 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-91.pek2.redhat.com [10.72.13.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 178B210016FA;
 Mon,  4 Jan 2021 06:55:14 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH V3 02/19] virtio-pci: split out modern device
Date: Mon,  4 Jan 2021 14:54:46 +0800
Message-Id: <20210104065503.199631-3-jasowang@redhat.com>
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

This patch splits out the virtio-pci modern device only attributes
into another structure. While at it, a dedicated probe method for
modern only attributes is introduced. This may help for split the
logic into a dedicated module.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.h |  25 +++--
 drivers/virtio/virtio_pci_modern.c | 159 ++++++++++++++++-------------
 2 files changed, 105 insertions(+), 79 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index b2f0eb4067cb..f35ff5b6b467 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -39,22 +39,16 @@ struct virtio_pci_vq_info {
 	unsigned msix_vector;
 };
 
-/* Our device structure */
-struct virtio_pci_device {
-	struct virtio_device vdev;
+struct virtio_pci_modern_device {
 	struct pci_dev *pci_dev;
 
-	/* In legacy mode, these two point to within ->legacy. */
-	/* Where to read and clear interrupt */
-	u8 __iomem *isr;
-
-	/* Modern only fields */
-	/* The IO mapping for the PCI config space (non-legacy mode) */
 	struct virtio_pci_common_cfg __iomem *common;
 	/* Device-specific data (non-legacy mode)  */
 	void __iomem *device;
 	/* Base of vq notifications (non-legacy mode). */
 	void __iomem *notify_base;
+	/* Where to read and clear interrupt */
+	u8 __iomem *isr;
 
 	/* So we can sanity-check accesses. */
 	size_t notify_len;
@@ -68,6 +62,19 @@ struct virtio_pci_device {
 
 	int modern_bars;
 
+	struct virtio_device_id id;
+};
+
+/* Our device structure */
+struct virtio_pci_device {
+	struct virtio_device vdev;
+	struct pci_dev *pci_dev;
+	struct virtio_pci_modern_device mdev;
+
+	/* In legacy mode, these two point to within ->legacy. */
+	/* Where to read and clear interrupt */
+	u8 __iomem *isr;
+
 	/* Legacy only field */
 	/* the IO mapping for the PCI config space */
 	void __iomem *ioaddr;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index df1481fd400c..524490a94ca4 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -141,7 +141,8 @@ static void __iomem *map_capability(struct pci_dev *dev, int off,
 static u64 vp_get_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 	u64 features;
 
 	vp_iowrite32(0, &cfg->device_feature_select);
@@ -166,7 +167,8 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
 static int vp_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 	u64 features = vdev->features;
 
 	/* Give virtio_ring a chance to accept features. */
@@ -194,12 +196,13 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 		   void *buf, unsigned len)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	void __iomem *device = vp_dev->device;
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	void __iomem *device = mdev->device;
 	u8 b;
 	__le16 w;
 	__le32 l;
 
-	BUG_ON(offset + len > vp_dev->device_len);
+	BUG_ON(offset + len > mdev->device_len);
 
 	switch (len) {
 	case 1:
@@ -231,12 +234,13 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 		   const void *buf, unsigned len)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	void __iomem *device = vp_dev->device;
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	void __iomem *device = mdev->device;
 	u8 b;
 	__le16 w;
 	__le32 l;
 
-	BUG_ON(offset + len > vp_dev->device_len);
+	BUG_ON(offset + len > mdev->device_len);
 
 	switch (len) {
 	case 1:
@@ -265,7 +269,8 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 static u32 vp_generation(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
 	return vp_ioread8(&cfg->config_generation);
 }
@@ -274,7 +279,8 @@ static u32 vp_generation(struct virtio_device *vdev)
 static u8 vp_get_status(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
 	return vp_ioread8(&cfg->device_status);
 }
@@ -282,7 +288,8 @@ static u8 vp_get_status(struct virtio_device *vdev)
 static void vp_set_status(struct virtio_device *vdev, u8 status)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
 	/* We should never be setting status to 0. */
 	BUG_ON(status == 0);
@@ -292,7 +299,8 @@ static void vp_set_status(struct virtio_device *vdev, u8 status)
 static void vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
 	/* 0 status means a reset. */
 	vp_iowrite8(0, &cfg->device_status);
@@ -309,7 +317,8 @@ static void vp_reset(struct virtio_device *vdev)
 
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
 {
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
 	/* Setup the vector used for configuration events */
 	vp_iowrite16(vector, &cfg->msix_config);
@@ -326,7 +335,9 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  bool ctx,
 				  u16 msix_vec)
 {
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 	struct virtqueue *vq;
 	u16 num, off;
 	int err;
@@ -369,25 +380,25 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	vp_iowrite64_twopart(virtqueue_get_used_addr(vq),
 			     &cfg->queue_used_lo, &cfg->queue_used_hi);
 
-	if (vp_dev->notify_base) {
+	if (mdev->notify_base) {
 		/* offset should not wrap */
-		if ((u64)off * vp_dev->notify_offset_multiplier + 2
-		    > vp_dev->notify_len) {
-			dev_warn(&vp_dev->pci_dev->dev,
+		if ((u64)off * mdev->notify_offset_multiplier + 2
+		    > mdev->notify_len) {
+			dev_warn(&mdev->pci_dev->dev,
 				 "bad notification offset %u (x %u) "
 				 "for queue %u > %zd",
-				 off, vp_dev->notify_offset_multiplier,
-				 index, vp_dev->notify_len);
+				 off, mdev->notify_offset_multiplier,
+				 index, mdev->notify_len);
 			err = -EINVAL;
 			goto err_map_notify;
 		}
-		vq->priv = (void __force *)vp_dev->notify_base +
-			off * vp_dev->notify_offset_multiplier;
+		vq->priv = (void __force *)mdev->notify_base +
+			off * mdev->notify_offset_multiplier;
 	} else {
-		vq->priv = (void __force *)map_capability(vp_dev->pci_dev,
-					  vp_dev->notify_map_cap, 2, 2,
-					  off * vp_dev->notify_offset_multiplier, 2,
-					  NULL);
+		vq->priv = (void __force *)map_capability(mdev->pci_dev,
+							  mdev->notify_map_cap, 2, 2,
+							  off * mdev->notify_offset_multiplier, 2,
+							  NULL);
 	}
 
 	if (!vq->priv) {
@@ -407,8 +418,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	return vq;
 
 err_assign_vector:
-	if (!vp_dev->notify_base)
-		pci_iounmap(vp_dev->pci_dev, (void __iomem __force *)vq->priv);
+	if (!mdev->notify_base)
+		pci_iounmap(mdev->pci_dev, (void __iomem __force *)vq->priv);
 err_map_notify:
 	vring_del_virtqueue(vq);
 	return ERR_PTR(err);
@@ -421,7 +432,7 @@ static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			      struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->mdev.common;
 	struct virtqueue *vq;
 	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, ctx, desc);
 
@@ -443,7 +454,9 @@ static void del_vq(struct virtio_pci_vq_info *info)
 {
 	struct virtqueue *vq = info->vq;
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
 
 	vp_iowrite16(vq->index, &cfg->queue_select);
 
@@ -454,8 +467,8 @@ static void del_vq(struct virtio_pci_vq_info *info)
 		vp_ioread16(&cfg->queue_msix_vector);
 	}
 
-	if (!vp_dev->notify_base)
-		pci_iounmap(vp_dev->pci_dev, (void __force __iomem *)vq->priv);
+	if (!mdev->notify_base)
+		pci_iounmap(mdev->pci_dev, (void __force __iomem *)vq->priv);
 
 	vring_del_virtqueue(vq);
 }
@@ -693,6 +706,7 @@ static inline void check_offsets(void)
 /* the PCI probing function */
 int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 {
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 	struct pci_dev *pci_dev = vp_dev->pci_dev;
 	int err, common, isr, notify, device;
 	u32 notify_length;
@@ -700,6 +714,8 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 
 	check_offsets();
 
+	mdev->pci_dev = pci_dev;
+
 	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
 	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
 		return -ENODEV;
@@ -708,17 +724,17 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 		/* Transitional devices: use the PCI subsystem device id as
 		 * virtio device id, same as legacy driver always did.
 		 */
-		vp_dev->vdev.id.device = pci_dev->subsystem_device;
+		mdev->id.device = pci_dev->subsystem_device;
 	} else {
 		/* Modern devices: simply use PCI device id, but start from 0x1040. */
-		vp_dev->vdev.id.device = pci_dev->device - 0x1040;
+		mdev->id.device = pci_dev->device - 0x1040;
 	}
-	vp_dev->vdev.id.vendor = pci_dev->subsystem_vendor;
+	mdev->id.vendor = pci_dev->subsystem_vendor;
 
 	/* check for a common config: if not, use legacy mode (bar 0). */
 	common = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_COMMON_CFG,
 					    IORESOURCE_IO | IORESOURCE_MEM,
-					    &vp_dev->modern_bars);
+					    &mdev->modern_bars);
 	if (!common) {
 		dev_info(&pci_dev->dev,
 			 "virtio_pci: leaving for legacy driver\n");
@@ -728,10 +744,10 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	/* If common is there, these should be too... */
 	isr = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_ISR_CFG,
 					 IORESOURCE_IO | IORESOURCE_MEM,
-					 &vp_dev->modern_bars);
+					 &mdev->modern_bars);
 	notify = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_NOTIFY_CFG,
 					    IORESOURCE_IO | IORESOURCE_MEM,
-					    &vp_dev->modern_bars);
+					    &mdev->modern_bars);
 	if (!isr || !notify) {
 		dev_err(&pci_dev->dev,
 			"virtio_pci: missing capabilities %i/%i/%i\n",
@@ -751,31 +767,31 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	 */
 	device = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_DEVICE_CFG,
 					    IORESOURCE_IO | IORESOURCE_MEM,
-					    &vp_dev->modern_bars);
+					    &mdev->modern_bars);
 
-	err = pci_request_selected_regions(pci_dev, vp_dev->modern_bars,
+	err = pci_request_selected_regions(pci_dev, mdev->modern_bars,
 					   "virtio-pci-modern");
 	if (err)
 		return err;
 
 	err = -EINVAL;
-	vp_dev->common = map_capability(pci_dev, common,
-					sizeof(struct virtio_pci_common_cfg), 4,
-					0, sizeof(struct virtio_pci_common_cfg),
-					NULL);
-	if (!vp_dev->common)
+	mdev->common = map_capability(pci_dev, common,
+				      sizeof(struct virtio_pci_common_cfg), 4,
+				      0, sizeof(struct virtio_pci_common_cfg),
+				      NULL);
+	if (!mdev->common)
 		goto err_map_common;
-	vp_dev->isr = map_capability(pci_dev, isr, sizeof(u8), 1,
-				     0, 1,
-				     NULL);
-	if (!vp_dev->isr)
+	mdev->isr = map_capability(pci_dev, isr, sizeof(u8), 1,
+				   0, 1,
+				   NULL);
+	if (!mdev->isr)
 		goto err_map_isr;
 
 	/* Read notify_off_multiplier from config space. */
 	pci_read_config_dword(pci_dev,
 			      notify + offsetof(struct virtio_pci_notify_cap,
 						notify_off_multiplier),
-			      &vp_dev->notify_offset_multiplier);
+			      &mdev->notify_offset_multiplier);
 	/* Read notify length and offset from config space. */
 	pci_read_config_dword(pci_dev,
 			      notify + offsetof(struct virtio_pci_notify_cap,
@@ -792,23 +808,23 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	 * Otherwise, map each VQ individually later.
 	 */
 	if ((u64)notify_length + (notify_offset % PAGE_SIZE) <= PAGE_SIZE) {
-		vp_dev->notify_base = map_capability(pci_dev, notify, 2, 2,
-						     0, notify_length,
-						     &vp_dev->notify_len);
-		if (!vp_dev->notify_base)
+		mdev->notify_base = map_capability(pci_dev, notify, 2, 2,
+						   0, notify_length,
+						   &mdev->notify_len);
+		if (!mdev->notify_base)
 			goto err_map_notify;
 	} else {
-		vp_dev->notify_map_cap = notify;
+		mdev->notify_map_cap = notify;
 	}
 
 	/* Again, we don't know how much we should map, but PAGE_SIZE
 	 * is more than enough for all existing devices.
 	 */
 	if (device) {
-		vp_dev->device = map_capability(pci_dev, device, 0, 4,
-						0, PAGE_SIZE,
-						&vp_dev->device_len);
-		if (!vp_dev->device)
+		mdev->device = map_capability(pci_dev, device, 0, 4,
+					      0, PAGE_SIZE,
+					      &mdev->device_len);
+		if (!mdev->device)
 			goto err_map_device;
 
 		vp_dev->vdev.config = &virtio_pci_config_ops;
@@ -819,29 +835,32 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	vp_dev->config_vector = vp_config_vector;
 	vp_dev->setup_vq = setup_vq;
 	vp_dev->del_vq = del_vq;
+	vp_dev->isr = mdev->isr;
+	vp_dev->vdev.id = mdev->id;
 
 	return 0;
 
 err_map_device:
-	if (vp_dev->notify_base)
-		pci_iounmap(pci_dev, vp_dev->notify_base);
+	if (mdev->notify_base)
+		pci_iounmap(pci_dev, mdev->notify_base);
 err_map_notify:
-	pci_iounmap(pci_dev, vp_dev->isr);
+	pci_iounmap(pci_dev, mdev->isr);
 err_map_isr:
-	pci_iounmap(pci_dev, vp_dev->common);
+	pci_iounmap(pci_dev, mdev->common);
 err_map_common:
 	return err;
 }
 
 void virtio_pci_modern_remove(struct virtio_pci_device *vp_dev)
 {
-	struct pci_dev *pci_dev = vp_dev->pci_dev;
-
-	if (vp_dev->device)
-		pci_iounmap(pci_dev, vp_dev->device);
-	if (vp_dev->notify_base)
-		pci_iounmap(pci_dev, vp_dev->notify_base);
-	pci_iounmap(pci_dev, vp_dev->isr);
-	pci_iounmap(pci_dev, vp_dev->common);
-	pci_release_selected_regions(pci_dev, vp_dev->modern_bars);
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct pci_dev *pci_dev = mdev->pci_dev;
+
+	if (mdev->device)
+		pci_iounmap(pci_dev, mdev->device);
+	if (mdev->notify_base)
+		pci_iounmap(pci_dev, mdev->notify_base);
+	pci_iounmap(pci_dev, mdev->isr);
+	pci_iounmap(pci_dev, mdev->common);
+	pci_release_selected_regions(pci_dev, mdev->modern_bars);
 }
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
