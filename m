Return-Path: <SRS0=fQeB=ET=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1C4C61DD8
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:48:15 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EADB2222F
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBvWNklA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EADB2222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id DFF03877F1;
	Fri, 13 Nov 2020 13:48:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h+vit0vsBBQE; Fri, 13 Nov 2020 13:48:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2095187764;
	Fri, 13 Nov 2020 13:48:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0AB3AC0891;
	Fri, 13 Nov 2020 13:48:14 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6483DC0800
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 539F687479
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:48:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0I5GdGyr0zVP
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:48:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 628B787474
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605275290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9UzDD4XLBsIex8H3gAmLcepWoyVKDMnza///IOvxEZI=;
 b=fBvWNklA4Qed3xaol4xPB+Wrqpfpb7mBvx69hh21RwzVy5jyVft6m39eAd3Hi4moWiu+Ev
 4fctIi2exyU/HYVlj9LO9gXuqWX7yEsjW23kjsuZHEjUSJkN4Y9oSRvPgnB4FbnmVvj1kr
 0Ux10Q4AlyA0wBJqkDAcnyG1/gnsPNc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-HiiljqWwMnSO1WrRG7vhpA-1; Fri, 13 Nov 2020 08:48:07 -0500
X-MC-Unique: HiiljqWwMnSO1WrRG7vhpA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81C53809DC5;
 Fri, 13 Nov 2020 13:48:06 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com
 [10.36.114.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 947A219C66;
 Fri, 13 Nov 2020 13:48:04 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 06/12] vdpa_sim: add struct vdpasim_device to store device
 properties
Date: Fri, 13 Nov 2020 14:47:06 +0100
Message-Id: <20201113134712.69744-7-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Move device properties used during the entire life cycle in a new
structure to simplify the copy of these fields during the vdpasim
initialization.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     | 17 ++++++++------
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 33 ++++++++++++++--------------
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  8 +++++--
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  9 +++++---
 4 files changed, 38 insertions(+), 29 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 6a1267c40d5e..76e642042eb0 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -40,12 +40,17 @@ struct vdpasim_virtqueue {
 	irqreturn_t (*cb)(void *data);
 };
 
+struct vdpasim_device {
+	u64 supported_features;
+	u32 id;
+	int nvqs;
+};
+
 struct vdpasim_init_attr {
-	u32		device_id;
-	u64		features;
+	struct vdpasim_device device;
+	int batch_mapping;
+
 	work_func_t	work_fn;
-	int		batch_mapping;
-	int		nvqs;
 };
 
 /* State of each vdpasim device */
@@ -53,18 +58,16 @@ struct vdpasim {
 	struct vdpa_device vdpa;
 	struct vdpasim_virtqueue *vqs;
 	struct work_struct work;
+	struct vdpasim_device device;
 	/* spinlock to synchronize virtqueue state */
 	spinlock_t lock;
 	/* virtio config according to device type */
 	void *config;
 	struct vhost_iotlb *iommu;
 	void *buffer;
-	u32 device_id;
 	u32 status;
 	u32 generation;
 	u64 features;
-	u64 supported_features;
-	int nvqs;
 	/* spinlock to synchronize iommu table */
 	spinlock_t iommu_lock;
 };
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 9c9717441bbe..d053bd14b3f8 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -28,7 +28,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 {
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 
-	vringh_init_iotlb(&vq->vring, vdpasim->supported_features,
+	vringh_init_iotlb(&vq->vring, vdpasim->device.supported_features,
 			  VDPASIM_QUEUE_MAX, false,
 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
 			  (struct vring_avail *)
@@ -46,7 +46,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
 	vq->device_addr = 0;
 	vq->cb = NULL;
 	vq->private = NULL;
-	vringh_init_iotlb(&vq->vring, vdpasim->supported_features,
+	vringh_init_iotlb(&vq->vring, vdpasim->device.supported_features,
 			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
 }
 
@@ -54,7 +54,7 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
 {
 	int i;
 
-	for (i = 0; i < vdpasim->nvqs; i++)
+	for (i = 0; i < vdpasim->device.nvqs; i++)
 		vdpasim_vq_reset(vdpasim, &vdpasim->vqs[i]);
 
 	spin_lock(&vdpasim->iommu_lock);
@@ -189,7 +189,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 	struct device *dev;
 	int i, size, ret = -ENOMEM;
 
-	device_id = attr->device_id;
+	device_id = attr->device.id;
 	/* Currently, we only accept the network and block devices. */
 	if (device_id != VIRTIO_ID_NET && device_id != VIRTIO_ID_BLOCK)
 		return ERR_PTR(-EOPNOTSUPP);
@@ -200,10 +200,12 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 		ops = &vdpasim_config_ops;
 
 	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
-				    attr->nvqs);
+				    attr->device.nvqs);
 	if (!vdpasim)
 		goto err_alloc;
 
+	vdpasim->device = attr->device;
+
 	if (device_id == VIRTIO_ID_NET)
 		size = sizeof(struct virtio_net_config);
 	else
@@ -212,14 +214,11 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 	if (!vdpasim->config)
 		goto err_iommu;
 
-	vdpasim->vqs = kcalloc(attr->nvqs, sizeof(struct vdpasim_virtqueue),
-			       GFP_KERNEL);
+	vdpasim->vqs = kcalloc(vdpasim->device.nvqs,
+			       sizeof(struct vdpasim_virtqueue), GFP_KERNEL);
 	if (!vdpasim->vqs)
 		goto err_iommu;
 
-	vdpasim->device_id = device_id;
-	vdpasim->supported_features = attr->features;
-	vdpasim->nvqs = attr->nvqs;
 	INIT_WORK(&vdpasim->work, attr->work_fn);
 	spin_lock_init(&vdpasim->lock);
 	spin_lock_init(&vdpasim->iommu_lock);
@@ -238,7 +237,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 	if (!vdpasim->buffer)
 		goto err_iommu;
 
-	for (i = 0; i < vdpasim->nvqs; i++)
+	for (i = 0; i < vdpasim->device.nvqs; i++)
 		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
 
 	vdpasim->vdpa.dma_dev = dev;
@@ -347,7 +346,7 @@ static u64 vdpasim_get_features(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	return vdpasim->supported_features;
+	return vdpasim->device.supported_features;
 }
 
 static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
@@ -358,14 +357,14 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
 		return -EINVAL;
 
-	vdpasim->features = features & vdpasim->supported_features;
+	vdpasim->features = features & vdpasim->device.supported_features;
 
 	/* We generally only know whether guest is using the legacy interface
 	 * here, so generally that's the earliest we can set config fields.
 	 * Note: We actually require VIRTIO_F_ACCESS_PLATFORM above which
 	 * implies VIRTIO_F_VERSION_1, but let's not try to be clever here.
 	 */
-	if (vdpasim->device_id == VIRTIO_ID_NET) {
+	if (vdpasim->device.id == VIRTIO_ID_NET) {
 		struct virtio_net_config *config =
 			(struct virtio_net_config *)vdpasim->config;
 
@@ -391,7 +390,7 @@ static u32 vdpasim_get_device_id(struct vdpa_device *vdpa)
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	return vdpasim->device_id;
+	return vdpasim->device.id;
 }
 
 static u32 vdpasim_get_vendor_id(struct vdpa_device *vdpa)
@@ -427,10 +426,10 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
 {
 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
 
-	if (vdpasim->device_id == VIRTIO_ID_BLOCK &&
+	if (vdpasim->device.id == VIRTIO_ID_BLOCK &&
 	    (offset + len < sizeof(struct virtio_blk_config)))
 		memcpy(buf, vdpasim->config + offset, len);
-	else if (vdpasim->device_id == VIRTIO_ID_NET &&
+	else if (vdpasim->device.id == VIRTIO_ID_NET &&
 		 (offset + len < sizeof(struct virtio_net_config)))
 		memcpy(buf, vdpasim->config + offset, len);
 }
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 386dbb2f7138..363273d72e26 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -78,9 +78,13 @@ static int __init vdpasim_blk_init(void)
 	struct virtio_blk_config *config;
 	int ret;
 
-	attr.device_id = VIRTIO_ID_BLOCK;
-	attr.features = VDPASIM_FEATURES | VDPASIM_BLK_FEATURES;
+	attr.device.id = VIRTIO_ID_BLOCK;
+	attr.device.supported_features = VDPASIM_FEATURES |
+					 VDPASIM_BLK_FEATURES;
+	attr.device.nvqs = VDPASIM_BLK_VQ_NUM;
+
 	attr.work_fn = vdpasim_blk_work;
+
 	vdpasim_blk_dev = vdpasim_create(&attr);
 	if (IS_ERR(vdpasim_blk_dev)) {
 		ret = PTR_ERR(vdpasim_blk_dev);
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index e1e57c52b108..88c9569f6bd3 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -105,11 +105,14 @@ static int __init vdpasim_net_init(void)
 	struct virtio_net_config *config;
 	int ret;
 
-	attr.device_id = VIRTIO_ID_NET;
-	attr.features = VDPASIM_FEATURES | VDPASIM_NET_FEATURES;
-	attr.nvqs = VDPASIM_NET_VQ_NUM;
+	attr.device.id = VIRTIO_ID_NET;
+	attr.device.supported_features = VDPASIM_FEATURES |
+					 VDPASIM_NET_FEATURES;
+	attr.device.nvqs = VDPASIM_NET_VQ_NUM;
+
 	attr.work_fn = vdpasim_net_work;
 	attr.batch_mapping = batch_mapping;
+
 	vdpasim_net_dev = vdpasim_create(&attr);
 	if (IS_ERR(vdpasim_net_dev)) {
 		ret = PTR_ERR(vdpasim_net_dev);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
