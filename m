Return-Path: <SRS0=66oW=FA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD303C64E7B
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 09:26:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DDC21D7F
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 09:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVynExUG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DDC21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 053CD87278;
	Thu, 26 Nov 2020 09:26:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1-tULq0uO4lS; Thu, 26 Nov 2020 09:26:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8006687267;
	Thu, 26 Nov 2020 09:26:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62C59C1D9F;
	Thu, 26 Nov 2020 09:26:41 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E412C0891
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 15B372E1F8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qnVHBb2nZOgU
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 9EA5D20377
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 09:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606382785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KprDWikpDf7X2z+wfoFpTO9xh92KjR3IxLJS8M48I48=;
 b=PVynExUGFMWYrBP3IdUZicJ54lFP378n9MvWBDod0WyvvX60u305Clrp6+zWydCYRp/k8K
 Xe6UEylyGwLfwqNhQhFvznNmAAfR2+fyyc3D7vuRGloyqpKZKr6a5Q6Hw8fe1JqVvrk6xR
 uOG0DOnOKwbbrxrBQebKJ4cg+WjktGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-196-S7Bo7eZ8Nj2_8h70zeUW4A-1; Thu, 26 Nov 2020 04:26:20 -0500
X-MC-Unique: S7Bo7eZ8Nj2_8h70zeUW4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2DCA873155;
 Thu, 26 Nov 2020 09:26:19 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-13-213.pek2.redhat.com [10.72.13.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BD5E619C71;
 Thu, 26 Nov 2020 09:26:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com, jasowang@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 03/14] virtio-pci: split out modern device
Date: Thu, 26 Nov 2020 17:25:53 +0800
Message-Id: <20201126092604.208033-4-jasowang@redhat.com>
In-Reply-To: <20201126092604.208033-1-jasowang@redhat.com>
References: <20201126092604.208033-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: shahafs@mellanox.com
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
 drivers/virtio/virtio_pci_common.h |  33 +++--
 drivers/virtio/virtio_pci_modern.c | 224 ++++++++++++++++++-----------
 2 files changed, 158 insertions(+), 99 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 1d23420f7ed6..d32af8ff56f9 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -39,37 +39,43 @@ struct virtio_pci_vq_info {
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
-	/* The IO mapping for the BARs */
+	/* The IO mapping for the PCI BARs */
 	void __iomem * const *base;
-	/* The IO mapping for the PCI config space (non-legacy mode) */
+
+	/* The IO mapping for the PCI config space */
 	struct virtio_pci_common_cfg __iomem *common;
 	/* Device-specific data (non-legacy mode)  */
 	void __iomem *device;
 	/* Base of vq notifications (non-legacy mode). */
 	void __iomem *notify_base;
+	/* Where to read and clear interrupt */
+	u8 __iomem *isr;
 
 	/* So we can sanity-check accesses. */
 	size_t notify_len;
 	size_t device_len;
 
-	/* Capability for when we need to map notifications per-vq. */
-	int notify_map_cap;
-
 	/* Multiply queue_notify_off by this value. (non-legacy mode). */
 	u32 notify_offset_multiplier;
 
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
@@ -157,6 +163,5 @@ static inline void virtio_pci_legacy_remove(struct virtio_pci_device *vp_dev)
 }
 #endif
 int virtio_pci_modern_probe(struct virtio_pci_device *);
-void virtio_pci_modern_remove(struct virtio_pci_device *);
 
 #endif
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 33cc21b818de..02688c3b3fbd 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -63,13 +63,11 @@ static void vp_iowrite64_twopart(u64 val,
 	vp_iowrite32(val >> 32, hi);
 }
 
-static void __iomem *map_capability(struct virtio_pci_device *vp_dev, int off,
-				    size_t minlen,
-				    u32 align,
-				    u32 size,
-				    size_t *len)
+static void __iomem *map_capability(struct virtio_pci_modern_device *mdev,
+				    int off, size_t minlen, u32 align,
+				    u32 size, size_t *len)
 {
-	struct pci_dev *dev = vp_dev->pci_dev;
+	struct pci_dev *dev = mdev->pci_dev;
 	u8 bar;
 	u32 offset, length;
 
@@ -111,14 +109,13 @@ static void __iomem *map_capability(struct virtio_pci_device *vp_dev, int off,
 		return NULL;
 	}
 
-	return vp_dev->base[bar] + offset;
+	return mdev->base[bar] + offset;
 }
 
-/* virtio config->get_features() implementation */
-static u64 vp_get_features(struct virtio_device *vdev)
+static u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
 {
-	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
 	u64 features;
 
 	vp_iowrite32(0, &cfg->device_feature_select);
@@ -129,6 +126,14 @@ static u64 vp_get_features(struct virtio_device *vdev)
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
@@ -139,11 +144,21 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
 		__virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
 }
 
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
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
 	u64 features = vdev->features;
 
 	/* Give virtio_ring a chance to accept features. */
@@ -158,10 +173,7 @@ static int vp_finalize_features(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
-	vp_iowrite32(0, &cfg->guest_feature_select);
-	vp_iowrite32((u32)vdev->features, &cfg->guest_feature);
-	vp_iowrite32(1, &cfg->guest_feature_select);
-	vp_iowrite32(vdev->features >> 32, &cfg->guest_feature);
+	vp_modern_set_features(&vp_dev->mdev, vdev->features);
 
 	return 0;
 }
@@ -171,12 +183,13 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
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
@@ -208,12 +221,13 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
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
@@ -239,54 +253,71 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 	}
 }
 
+static u32 vp_modern_generation(struct virtio_pci_modern_device *mdev)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	return vp_ioread8(&cfg->config_generation);
+}
+
 static u32 vp_generation(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
 
-	return vp_ioread8(&cfg->config_generation);
+	return vp_modern_generation(&vp_dev->mdev);
 }
 
 /* config->{get,set}_status() implementations */
+static u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	return vp_ioread8(&cfg->device_status);
+}
+
 static u8 vp_get_status(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
 
-	return vp_ioread8(&cfg->device_status);
+	return vp_modern_get_status(&vp_dev->mdev);
+}
+
+static void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
+				 u8 status)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	vp_iowrite8(status, &cfg->device_status);
 }
 
 static void vp_set_status(struct virtio_device *vdev, u8 status)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
 
-	/* We should never be setting status to 0. */
-	BUG_ON(status == 0);
-	vp_iowrite8(status, &cfg->device_status);
+	vp_modern_set_status(&vp_dev->mdev, status);
 }
 
 static void vp_reset(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
 
 	/* 0 status means a reset. */
-	vp_iowrite8(0, &cfg->device_status);
+	vp_modern_set_status(&vp_dev->mdev, 0);
 	/* After writing 0 to device_status, the driver MUST wait for a read of
 	 * device_status to return 0 before reinitializing the device.
 	 * This will flush out the status write, and flush in device writes,
 	 * including MSI-X interrupts, if any.
 	 */
-	while (vp_ioread8(&cfg->device_status))
+	while (vp_modern_get_status(&vp_dev->mdev))
 		msleep(1);
 	/* Flush pending VQ/configuration callbacks. */
 	vp_synchronize_vectors(vdev);
 }
 
-static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
+static u16 vp_modern_config_vector(struct virtio_pci_modern_device *mdev,
+				   u16 vector)
 {
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 
 	/* Setup the vector used for configuration events */
 	vp_iowrite16(vector, &cfg->msix_config);
@@ -295,6 +326,11 @@ static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
 	return vp_ioread16(&cfg->msix_config);
 }
 
+static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
+{
+	return vp_modern_config_vector(&vp_dev->mdev, vector);
+}
+
 static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  struct virtio_pci_vq_info *info,
 				  unsigned index,
@@ -303,7 +339,9 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
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
@@ -347,19 +385,18 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 			     &cfg->queue_used_lo, &cfg->queue_used_hi);
 
 	/* offset should not wrap */
-	if ((u64)off * vp_dev->notify_offset_multiplier + 2
-		> vp_dev->notify_len) {
+	if ((u64)off * mdev->notify_offset_multiplier + 2
+		> mdev->notify_len) {
 		dev_warn(&vp_dev->pci_dev->dev,
 			 "bad notification offset %u (x %u) "
 			 "for queue %u > %zd",
-			 off, vp_dev->notify_offset_multiplier,
-			 index, vp_dev->notify_len);
+			 off, mdev->notify_offset_multiplier,
+			 index, mdev->notify_len);
 		err = -EINVAL;
 		goto err_map_notify;
 	}
-
-	vq->priv = (void __force *)vp_dev->notify_base +
-		off * vp_dev->notify_offset_multiplier;
+	vq->priv = (void __force *)mdev->notify_base +
+		off * mdev->notify_offset_multiplier;
 
 	if (!vq->priv) {
 		err = -ENOMEM;
@@ -389,7 +426,7 @@ static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			      struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->mdev.common;
 	struct virtqueue *vq;
 	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, ctx, desc);
 
@@ -411,7 +448,7 @@ static void del_vq(struct virtio_pci_vq_info *info)
 {
 	struct virtqueue *vq = info->vq;
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->common;
+	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->mdev.common;
 
 	vp_iowrite16(vq->index, &cfg->queue_select);
 
@@ -655,20 +692,13 @@ static inline void check_offsets(void)
 		     offsetof(struct virtio_pci_common_cfg, queue_used_hi));
 }
 
-/* the PCI probing function */
-int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
+static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 {
-	struct pci_dev *pci_dev = vp_dev->pci_dev;
+	struct pci_dev *pci_dev = mdev->pci_dev;
 	int err, common, isr, notify, device;
 	u32 notify_length;
 	u32 notify_offset;
 
-	check_offsets();
-
-	err = pcim_enable_device(pci_dev);
-	if (err)
-		return err;
-
 	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
 	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
 		return -ENODEV;
@@ -677,17 +707,21 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
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
+
+	err = pcim_enable_device(pci_dev);
+	if (err)
+		return err;
 
 	/* check for a common config: if not, use legacy mode (bar 0). */
 	common = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_COMMON_CFG,
 					    IORESOURCE_IO | IORESOURCE_MEM,
-					    &vp_dev->modern_bars);
+					    &mdev->modern_bars);
 	if (!common) {
 		dev_info(&pci_dev->dev,
 			 "virtio_pci: leaving for legacy driver\n");
@@ -697,10 +731,10 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
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
@@ -720,32 +754,31 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 	 */
 	device = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_DEVICE_CFG,
 					    IORESOURCE_IO | IORESOURCE_MEM,
-					    &vp_dev->modern_bars);
+					    &mdev->modern_bars);
 
-	err = pcim_iomap_regions(pci_dev, vp_dev->modern_bars,
+	err = pcim_iomap_regions(pci_dev, mdev->modern_bars,
 				 "virtio-pci-modern");
 	if (err)
 		return err;
 
-	vp_dev->base = pcim_iomap_table(pci_dev);
+	mdev->base = pcim_iomap_table(pci_dev);
 
 	err = -EINVAL;
-	vp_dev->common = map_capability(vp_dev, common,
-					sizeof(struct virtio_pci_common_cfg), 4,
-					sizeof(struct virtio_pci_common_cfg),
-					NULL);
-	if (!vp_dev->common)
+	mdev->common = map_capability(mdev, common,
+				      sizeof(struct virtio_pci_common_cfg), 4,
+				      sizeof(struct virtio_pci_common_cfg),
+				      NULL);
+	if (!mdev->common)
 		goto err;
-	vp_dev->isr = map_capability(vp_dev, isr, sizeof(u8), 1,
-				     1, NULL);
-	if (!vp_dev->isr)
+	mdev->isr = map_capability(mdev, isr, sizeof(u8), 1, 1, NULL);
+	if (!mdev->isr)
 		goto err;
 
 	/* Read notify_off_multiplier from config space. */
 	pci_read_config_dword(pci_dev,
 			      notify + offsetof(struct virtio_pci_notify_cap,
 						notify_off_multiplier),
-			      &vp_dev->notify_offset_multiplier);
+			      &mdev->notify_offset_multiplier);
 	/* Read notify length and offset from config space. */
 	pci_read_config_dword(pci_dev,
 			      notify + offsetof(struct virtio_pci_notify_cap,
@@ -757,34 +790,55 @@ int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 						cap.offset),
 			      &notify_offset);
 
-	vp_dev->notify_base = map_capability(vp_dev, notify, 2, 2,
-					     notify_length,
-					     &vp_dev->notify_len);
-	if (!vp_dev->notify_base)
+	mdev->notify_base = map_capability(mdev, notify, 2, 2,
+					   notify_length,
+					   &mdev->notify_len);
+	if (!mdev->notify_base)
 		goto err;
 
-	/* Again, we don't know how much we should map, but PAGE_SIZE
+	/* We don't know how much we should map, but PAGE_SIZE
 	 * is more than enough for all existing devices.
 	 */
 	if (device) {
-		vp_dev->device = map_capability(vp_dev, device, 0, 4,
-						PAGE_SIZE,
-						&vp_dev->device_len);
-		if (!vp_dev->device)
+		mdev->device = map_capability(mdev, device, 0, 4,
+					      PAGE_SIZE,
+					      &mdev->device_len);
+		if (!mdev->device)
 			goto err;
+	}
 
+	return 0;
+
+err:
+	return err;
+}
+
+/* the PCI probing function */
+int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
+{
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
+	struct pci_dev *pci_dev = vp_dev->pci_dev;
+	int err;
+
+	check_offsets();
+
+	mdev->pci_dev = pci_dev;
+
+	err = vp_modern_probe(mdev);
+	if (err)
+		return err;
+
+	vp_dev->vdev.id = mdev->id;
+	vp_dev->isr = mdev->isr;
+
+	if (mdev->device)
 		vp_dev->vdev.config = &virtio_pci_config_ops;
-	} else {
+	else
 		vp_dev->vdev.config = &virtio_pci_config_nodev_ops;
-	}
 
 	vp_dev->config_vector = vp_config_vector;
 	vp_dev->setup_vq = setup_vq;
 	vp_dev->del_vq = del_vq;
 
 	return 0;
-
-err:
-	return err;
 }
-
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
