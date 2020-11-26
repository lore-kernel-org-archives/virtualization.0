Return-Path: <SRS0=66oW=FA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A20C63697
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 14:50:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDE120B80
	for <virtualization@archiver.kernel.org>; Thu, 26 Nov 2020 14:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RILh/l38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDE120B80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CD0DD878BF;
	Thu, 26 Nov 2020 14:50:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5o+9gQVuCKFT; Thu, 26 Nov 2020 14:50:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 140BF878B9;
	Thu, 26 Nov 2020 14:50:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D228C163C;
	Thu, 26 Nov 2020 14:50:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 646AEC0052
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 14:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 61271873BB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 14:50:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JPpaA8KZViq7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 14:50:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2BAAA87411
 for <virtualization@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606402210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zg59oa0lzxByupxGN5sc6MS2Iy+1fgXzvJqRFP2cKnU=;
 b=RILh/l38elF4R87asb+4DKcli8kCHmhm4iPYL3tMcjOLbGCYFyvaXoJMdRJATVsjqL9ZR7
 wI4tbvU8RZZRjjHTg+ZIEp5l6Hf+R55O1ItQY6KamNS4+4TLt3kWPKNe50/6n7Rs7YxlmG
 b6GTRFYlFMGet9pt8/6af629LhbaqaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-lklwzCaGPZWeOnp089cYNQ-1; Thu, 26 Nov 2020 09:50:07 -0500
X-MC-Unique: lklwzCaGPZWeOnp089cYNQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D1379A22D;
 Thu, 26 Nov 2020 14:50:06 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-252.ams2.redhat.com
 [10.36.113.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7973B19C66;
 Thu, 26 Nov 2020 14:50:04 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 03/17] vdpa_sim: remove hard-coded virtq count
Date: Thu, 26 Nov 2020 15:49:36 +0100
Message-Id: <20201126144950.92850-4-sgarzare@redhat.com>
In-Reply-To: <20201126144950.92850-1-sgarzare@redhat.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
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
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index c6eaf62df8ec..ad72f7b1a4eb 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -57,7 +57,7 @@ static u64 vdpasim_features = (1ULL << VIRTIO_F_ANY_LAYOUT) |
 /* State of each vdpasim device */
 struct vdpasim {
 	struct vdpa_device vdpa;
-	struct vdpasim_virtqueue vqs[VDPASIM_VQ_NUM];
+	struct vdpasim_virtqueue *vqs;
 	struct work_struct work;
 	/* spinlock to synchronize virtqueue state */
 	spinlock_t lock;
@@ -67,6 +67,7 @@ struct vdpasim {
 	u32 status;
 	u32 generation;
 	u64 features;
+	int nvqs;
 	/* spinlock to synchronize iommu table */
 	spinlock_t iommu_lock;
 };
@@ -131,7 +132,7 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
 {
 	int i;
 
-	for (i = 0; i < VDPASIM_VQ_NUM; i++)
+	for (i = 0; i < vdpasim->nvqs; i++)
 		vdpasim_vq_reset(&vdpasim->vqs[i]);
 
 	spin_lock(&vdpasim->iommu_lock);
@@ -337,7 +338,7 @@ static struct vdpasim *vdpasim_create(void)
 	const struct vdpa_config_ops *ops;
 	struct vdpasim *vdpasim;
 	struct device *dev;
-	int ret = -ENOMEM;
+	int i, ret = -ENOMEM;
 
 	if (batch_mapping)
 		ops = &vdpasim_net_batch_config_ops;
@@ -348,6 +349,7 @@ static struct vdpasim *vdpasim_create(void)
 	if (!vdpasim)
 		goto err_alloc;
 
+	vdpasim->nvqs = VDPASIM_VQ_NUM;
 	INIT_WORK(&vdpasim->work, vdpasim_work);
 	spin_lock_init(&vdpasim->lock);
 	spin_lock_init(&vdpasim->iommu_lock);
@@ -358,6 +360,11 @@ static struct vdpasim *vdpasim_create(void)
 		goto err_iommu;
 	set_dma_ops(dev, &vdpasim_dma_ops);
 
+	vdpasim->vqs = kcalloc(vdpasim->nvqs, sizeof(struct vdpasim_virtqueue),
+			       GFP_KERNEL);
+	if (!vdpasim->vqs)
+		goto err_iommu;
+
 	vdpasim->iommu = vhost_iotlb_alloc(2048, 0);
 	if (!vdpasim->iommu)
 		goto err_iommu;
@@ -376,8 +383,8 @@ static struct vdpasim *vdpasim_create(void)
 		eth_random_addr(vdpasim->config.mac);
 	}
 
-	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
-	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
+	for (i = 0; i < vdpasim->nvqs; i++)
+		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
 
 	vdpasim->vdpa.dma_dev = dev;
 	ret = vdpa_register_device(&vdpasim->vdpa);
@@ -646,6 +653,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	kfree(vdpasim->buffer);
 	if (vdpasim->iommu)
 		vhost_iotlb_free(vdpasim->iommu);
+	kfree(vdpasim->vqs);
 }
 
 static const struct vdpa_config_ops vdpasim_net_config_ops = {
-- 
2.26.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
