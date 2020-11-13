Return-Path: <SRS0=fQeB=ET=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09165C388F7
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:47:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A46E922201
	for <virtualization@archiver.kernel.org>; Fri, 13 Nov 2020 13:47:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGLJIwX+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A46E922201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 473068753A;
	Fri, 13 Nov 2020 13:47:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PMn760zpKRdt; Fri, 13 Nov 2020 13:47:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8741787561;
	Fri, 13 Nov 2020 13:47:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BC04C1833;
	Fri, 13 Nov 2020 13:47:38 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C10B0C0800
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id AC60D204AE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VbR4hXkHyNYG
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 47CE220439
 for <virtualization@lists.linux-foundation.org>;
 Fri, 13 Nov 2020 13:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605275255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C02DN+VYQBIDbgbX1fSKB30Ha70tnEbGhq+AXtbjxUo=;
 b=cGLJIwX+Zr4tdkZflL1xyGj0nYnECUrqQ/YIf5TqAavIm+CDf6tJeHMmuv0C2updqV80pu
 2iPYktSIsQmthIji3APIFMyOdSU1Qv7Gx2HeIruJGZpzE6G+HZay45jL3Ii7YpG18T2ZpU
 kruJ75pM90+nelIH23MXh5023r7xcnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-gCT3uwq2M4K2fwTHMCBcfQ-1; Fri, 13 Nov 2020 08:47:32 -0500
X-MC-Unique: gCT3uwq2M4K2fwTHMCBcfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80D0C1868418;
 Fri, 13 Nov 2020 13:47:31 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com
 [10.36.114.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 430311E8;
 Fri, 13 Nov 2020 13:47:26 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH RFC 03/12] vdpa_sim: remove hard-coded virtq count
Date: Fri, 13 Nov 2020 14:47:03 +0100
Message-Id: <20201113134712.69744-4-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

From: Max Gurtovoy <mgurtovoy@nvidia.com>

Add a new attribute that will define the number of virt queues to be
created for the vdpasim device.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
[sgarzare: replace kmalloc_array() with kcalloc()]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1:
- use kcalloc() instead of kmalloc_array() since some function expects
  variables initialized to zero
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  5 +++--
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 14 +++++++++++---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 +++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 33613c49888c..6a1267c40d5e 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -20,7 +20,6 @@
 #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
 #define VDPASIM_QUEUE_MAX 256
 #define VDPASIM_VENDOR_ID 0
-#define VDPASIM_VQ_NUM 0x2
 
 #define VDPASIM_FEATURES	((1ULL << VIRTIO_F_ANY_LAYOUT) | \
 				 (1ULL << VIRTIO_F_VERSION_1)  | \
@@ -46,12 +45,13 @@ struct vdpasim_init_attr {
 	u64		features;
 	work_func_t	work_fn;
 	int		batch_mapping;
+	int		nvqs;
 };
 
 /* State of each vdpasim device */
 struct vdpasim {
 	struct vdpa_device vdpa;
-	struct vdpasim_virtqueue vqs[VDPASIM_VQ_NUM];
+	struct vdpasim_virtqueue *vqs;
 	struct work_struct work;
 	/* spinlock to synchronize virtqueue state */
 	spinlock_t lock;
@@ -64,6 +64,7 @@ struct vdpasim {
 	u32 generation;
 	u64 features;
 	u64 supported_features;
+	int nvqs;
 	/* spinlock to synchronize iommu table */
 	spinlock_t iommu_lock;
 };
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 04f9dc9ce8c8..2b4fea354413 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -54,7 +54,7 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
 {
 	int i;
 
-	for (i = 0; i < VDPASIM_VQ_NUM; i++)
+	for (i = 0; i < vdpasim->nvqs; i++)
 		vdpasim_vq_reset(vdpasim, &vdpasim->vqs[i]);
 
 	spin_lock(&vdpasim->iommu_lock);
@@ -199,7 +199,8 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 	else
 		ops = &vdpasim_config_ops;
 
-	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
+	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
+				    attr->nvqs);
 	if (!vdpasim)
 		goto err_alloc;
 
@@ -211,8 +212,14 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 	if (!vdpasim->config)
 		goto err_iommu;
 
+	vdpasim->vqs = kcalloc(attr->nvqs, sizeof(struct vdpasim_virtqueue),
+			       GFP_KERNEL);
+	if (!vdpasim->vqs)
+		goto err_iommu;
+
 	vdpasim->device_id = device_id;
 	vdpasim->supported_features = attr->features;
+	vdpasim->nvqs = attr->nvqs;
 	INIT_WORK(&vdpasim->work, attr->work_fn);
 	spin_lock_init(&vdpasim->lock);
 	spin_lock_init(&vdpasim->iommu_lock);
@@ -231,7 +238,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 	if (!vdpasim->buffer)
 		goto err_iommu;
 
-	for (i = 0; i < VDPASIM_VQ_NUM; i++)
+	for (i = 0; i < vdpasim->nvqs; i++)
 		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
 
 	vdpasim->vdpa.dma_dev = dev;
@@ -511,6 +518,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	kfree(vdpasim->buffer);
 	if (vdpasim->iommu)
 		vhost_iotlb_free(vdpasim->iommu);
+	kfree(vdpasim->vqs);
 	kfree(vdpasim->config);
 }
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index c68d5488ab54..e1e57c52b108 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -14,6 +14,8 @@
 
 #define VDPASIM_NET_FEATURES	(1ULL << VIRTIO_NET_F_MAC)
 
+#define VDPASIM_NET_VQ_NUM 2
+
 static int batch_mapping = 1;
 module_param(batch_mapping, int, 0444);
 MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 - Enable; 0 - Disable");
@@ -105,6 +107,7 @@ static int __init vdpasim_net_init(void)
 
 	attr.device_id = VIRTIO_ID_NET;
 	attr.features = VDPASIM_FEATURES | VDPASIM_NET_FEATURES;
+	attr.nvqs = VDPASIM_NET_VQ_NUM;
 	attr.work_fn = vdpasim_net_work;
 	attr.batch_mapping = batch_mapping;
 	vdpasim_net_dev = vdpasim_create(&attr);
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
