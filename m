Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0A0C433E0
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 14:25:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 987FB64DF5
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 14:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 987FB64DF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 495236F573
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 14:25:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T0VSrpVPCrO2 for <virtualization@archiver.kernel.org>;
	Tue, 16 Feb 2021 14:25:40 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 929236F5A5; Tue, 16 Feb 2021 14:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 49F2A6F530;
	Tue, 16 Feb 2021 14:25:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 232B7C0174;
	Tue, 16 Feb 2021 14:25:26 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9FD7EC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 14:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9AB158672B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 14:25:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p0h+xcDvlHEf
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 14:25:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 2C7C38699F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613485519;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y4K1zlVWzxMz+S3Vb4keQL48Fm8OU1dkH6MRmh2l6xQ=;
 b=JJarYmG1FpYouHYdlcXHPuw2LDt+a0PyUc+WsfjcXKJihEZXN3yGg3RbVPmA3pgdmsOfLZ
 FzjWFaGMMmkZZ7jaUXNcKXs16nVRvzQ5G3AAEeigMzSJ4P9ho+KYFSgEzMAXGSZb1BAkb2
 /n8K3Yrmk0sz2Y0xdn2aKoQ1+moqQ2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-537-U0sUchzHOkqnL12mcgczXA-1; Tue, 16 Feb 2021 09:25:17 -0500
X-MC-Unique: U0sUchzHOkqnL12mcgczXA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F018814261;
 Tue, 16 Feb 2021 14:25:10 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A983A10023AE;
 Tue, 16 Feb 2021 14:25:08 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH for 5.10 v2 1/5] vdpa_sim: remove hard-coded virtq count
Date: Tue, 16 Feb 2021 15:24:35 +0100
Message-Id: <20210216142439.258713-2-sgarzare@redhat.com>
In-Reply-To: <20210216142439.258713-1-sgarzare@redhat.com>
References: <20210216142439.258713-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

commit 423248d60d2b655321fc49eca1545f95a1bc9d6c upstream.

Add a new attribute that will define the number of virt queues to be
created for the vdpasim device.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
[sgarzare: replace kmalloc_array() with kcalloc()]
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://lore.kernel.org/r/20201215144256.155342-4-sgarzare@redhat.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Cc: <stable@vger.kernel.org> # 5.10.x
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 6a90fdb9cbfc..ee8f24a4643b 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -70,7 +70,7 @@ static u64 vdpasim_features = (1ULL << VIRTIO_F_ANY_LAYOUT) |
 /* State of each vdpasim device */
 struct vdpasim {
 	struct vdpa_device vdpa;
-	struct vdpasim_virtqueue vqs[VDPASIM_VQ_NUM];
+	struct vdpasim_virtqueue *vqs;
 	struct work_struct work;
 	/* spinlock to synchronize virtqueue state */
 	spinlock_t lock;
@@ -80,6 +80,7 @@ struct vdpasim {
 	u32 status;
 	u32 generation;
 	u64 features;
+	int nvqs;
 	/* spinlock to synchronize iommu table */
 	spinlock_t iommu_lock;
 };
@@ -144,7 +145,7 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
 {
 	int i;
 
-	for (i = 0; i < VDPASIM_VQ_NUM; i++)
+	for (i = 0; i < vdpasim->nvqs; i++)
 		vdpasim_vq_reset(&vdpasim->vqs[i]);
 
 	spin_lock(&vdpasim->iommu_lock);
@@ -350,7 +351,7 @@ static struct vdpasim *vdpasim_create(void)
 	const struct vdpa_config_ops *ops;
 	struct vdpasim *vdpasim;
 	struct device *dev;
-	int ret = -ENOMEM;
+	int i, ret = -ENOMEM;
 
 	if (batch_mapping)
 		ops = &vdpasim_net_batch_config_ops;
@@ -361,6 +362,7 @@ static struct vdpasim *vdpasim_create(void)
 	if (!vdpasim)
 		goto err_alloc;
 
+	vdpasim->nvqs = VDPASIM_VQ_NUM;
 	INIT_WORK(&vdpasim->work, vdpasim_work);
 	spin_lock_init(&vdpasim->lock);
 	spin_lock_init(&vdpasim->iommu_lock);
@@ -371,6 +373,11 @@ static struct vdpasim *vdpasim_create(void)
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
@@ -389,8 +396,8 @@ static struct vdpasim *vdpasim_create(void)
 		eth_random_addr(vdpasim->config.mac);
 	}
 
-	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
-	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
+	for (i = 0; i < vdpasim->nvqs; i++)
+		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
 
 	vdpasim->vdpa.dma_dev = dev;
 	ret = vdpa_register_device(&vdpasim->vdpa);
@@ -659,6 +666,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	kfree(vdpasim->buffer);
 	if (vdpasim->iommu)
 		vhost_iotlb_free(vdpasim->iommu);
+	kfree(vdpasim->vqs);
 }
 
 static const struct vdpa_config_ops vdpasim_net_config_ops = {
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
