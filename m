Return-Path: <SRS0=bReq=JU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FC0C43461
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 08:11:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F3B61409
	for <virtualization@archiver.kernel.org>; Fri, 23 Apr 2021 08:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F3B61409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ADB3C414D1;
	Fri, 23 Apr 2021 08:11:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JVXICpfJftQm; Fri, 23 Apr 2021 08:11:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id D38974146B;
	Fri, 23 Apr 2021 08:11:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A0D63C000F;
	Fri, 23 Apr 2021 08:11:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23622C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:11:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 059488439E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:11:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9s_S1ojuj3Rt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:11:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0263183CB9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 08:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619165475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PAsMdBaHH54UtnD5ZOdRbSiDTadfouyxNC4i/WeqrP4=;
 b=Qdiak8S0FW1yqIAUCUdAOtkT+7kXCWIefDyNw7FhbmJkNcVF2LZM2xzaa+4q0OAEiNQB/U
 kTjBAGMryKFenVdDqgxfbaiczCeRozJCpqPckDStufjBAlh6XaJlEVJB8F7jkpGICtSU1U
 u588P8Iuzag4uVwH0Id9QCB2Vj5+2k4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-6hXCVJciM6CtDwSDeTSOvA-1; Fri, 23 Apr 2021 04:11:13 -0400
X-MC-Unique: 6hXCVJciM6CtDwSDeTSOvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19BF184BA42;
 Fri, 23 Apr 2021 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-225.pek2.redhat.com
 [10.72.13.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1BEB25C5B5;
 Fri, 23 Apr 2021 08:11:04 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [RFC PATCH V2 7/7] virtio-ring: store DMA metadata in desc_extra for
 split virtqueue
Date: Fri, 23 Apr 2021 16:09:42 +0800
Message-Id: <20210423080942.2997-8-jasowang@redhat.com>
In-Reply-To: <20210423080942.2997-1-jasowang@redhat.com>
References: <20210423080942.2997-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de, kvm@vger.kernel.org,
 konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 xieyongji@bytedance.com, stefanha@redhat.com
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

For split virtqueue, we used to depend on the address, length and
flags stored in the descriptor ring for DMA unmapping. This is unsafe
for the case since the device can manipulate the behavior of virtio
driver, IOMMU drivers and swiotlb.

For safety, maintain the DMA address, DMA length, descriptor flags and
next filed of the non indirect descriptors in vring_desc_state_extra
when DMA API is used for virtio as we did for packed virtqueue and use
those metadata for performing DMA operations. Indirect descriptors
should be safe since they are using streaming mappings.

With this the descriptor ring is write only form the view of the
driver.

This slight increase the footprint of the drive but it's not noticed
through pktgen (64B) test and netperf test in the case of virtio-net.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 112 +++++++++++++++++++++++++++--------
 1 file changed, 87 insertions(+), 25 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 9800f1c9ce4c..5f0076eeb39c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -130,6 +130,7 @@ struct vring_virtqueue {
 
 			/* Per-descriptor state. */
 			struct vring_desc_state_split *desc_state;
+			struct vring_desc_extra *desc_extra;
 
 			/* DMA address and size information */
 			dma_addr_t queue_dma_addr;
@@ -364,8 +365,8 @@ static int vring_mapping_error(const struct vring_virtqueue *vq,
  * Split ring specific functions - *_split().
  */
 
-static void vring_unmap_one_split(const struct vring_virtqueue *vq,
-				  struct vring_desc *desc)
+static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
+					   struct vring_desc *desc)
 {
 	u16 flags;
 
@@ -389,6 +390,35 @@ static void vring_unmap_one_split(const struct vring_virtqueue *vq,
 	}
 }
 
+static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
+					  unsigned int i)
+{
+	struct vring_desc_extra *extra = vq->split.desc_extra;
+	u16 flags;
+
+	if (!vq->use_dma_api)
+		goto out;
+
+	flags = extra[i].flags;
+
+	if (flags & VRING_DESC_F_INDIRECT) {
+		dma_unmap_single(vring_dma_dev(vq),
+				 extra[i].addr,
+				 extra[i].len,
+				 (flags & VRING_DESC_F_WRITE) ?
+				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	} else {
+		dma_unmap_page(vring_dma_dev(vq),
+			       extra[i].addr,
+			       extra[i].len,
+			       (flags & VRING_DESC_F_WRITE) ?
+			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+	}
+
+out:
+	return extra[i].next;
+}
+
 static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
 					       unsigned int total_sg,
 					       gfp_t gfp)
@@ -417,13 +447,28 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 						    unsigned int i,
 						    dma_addr_t addr,
 						    unsigned int len,
-						    u16 flags)
+						    u16 flags,
+						    bool indirect)
 {
+	struct vring_virtqueue *vring = to_vvq(vq);
+	struct vring_desc_extra *extra = vring->split.desc_extra;
+	u16 next;
+
 	desc[i].flags = cpu_to_virtio16(vq->vdev, flags);
 	desc[i].addr = cpu_to_virtio64(vq->vdev, addr);
 	desc[i].len = cpu_to_virtio32(vq->vdev, len);
 
-	return virtio16_to_cpu(vq->vdev, desc[i].next);
+	if (!indirect) {
+		next = extra[i].next;
+		desc[i].next = cpu_to_virtio16(vq->vdev, next);
+
+		extra[i].addr = addr;
+		extra[i].len = len;
+		extra[i].flags = flags;
+	} else
+		next = virtio16_to_cpu(vq->vdev, desc[i].next);
+
+	return next;
 }
 
 static inline int virtqueue_add_split(struct virtqueue *_vq,
@@ -499,8 +544,12 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 				goto unmap_release;
 
 			prev = i;
+			/* Note that we trust indirect descriptor
+			 * table since it use stream DMA mapping.
+			 */
 			i = virtqueue_add_desc_split(_vq, desc, i, addr, sg->length,
-						     VRING_DESC_F_NEXT);
+						     VRING_DESC_F_NEXT,
+						     indirect);
 		}
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
@@ -510,14 +559,21 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 				goto unmap_release;
 
 			prev = i;
+			/* Note that we trust indirect descriptor
+			 * table since it use stream DMA mapping.
+			 */
 			i = virtqueue_add_desc_split(_vq, desc, i, addr,
 						     sg->length,
 						     VRING_DESC_F_NEXT |
-						     VRING_DESC_F_WRITE);
+						     VRING_DESC_F_WRITE,
+						     indirect);
 		}
 	}
 	/* Last one doesn't continue. */
 	desc[prev].flags &= cpu_to_virtio16(_vq->vdev, ~VRING_DESC_F_NEXT);
+	if (!indirect && vq->use_dma_api)
+		vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags =
+			~VRING_DESC_F_NEXT;
 
 	if (indirect) {
 		/* Now that the indirect table is filled in, map it. */
@@ -530,7 +586,8 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
 					 head, addr,
 					 total_sg * sizeof(struct vring_desc),
-			                 VRING_DESC_F_INDIRECT);
+					 VRING_DESC_F_INDIRECT,
+					 false);
 	}
 
 	/* We're using some buffers from the free list. */
@@ -538,8 +595,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	/* Update free pointer */
 	if (indirect)
-		vq->free_head = virtio16_to_cpu(_vq->vdev,
-					vq->split.vring.desc[head].next);
+		vq->free_head = vq->split.desc_extra[head].next;
 	else
 		vq->free_head = i;
 
@@ -584,8 +640,11 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-		vring_unmap_one_split(vq, &desc[i]);
-		i = virtio16_to_cpu(_vq->vdev, desc[i].next);
+		if (indirect) {
+			vring_unmap_one_split_indirect(vq, &desc[i]);
+			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
+		} else
+			i = vring_unmap_one_split(vq, i);
 	}
 
 	if (indirect)
@@ -639,14 +698,13 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, &vq->split.vring.desc[i]);
-		i = virtio16_to_cpu(vq->vq.vdev, vq->split.vring.desc[i].next);
+		vring_unmap_one_split(vq, i);
+		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
 
-	vring_unmap_one_split(vq, &vq->split.vring.desc[i]);
-	vq->split.vring.desc[i].next = cpu_to_virtio16(vq->vq.vdev,
-						vq->free_head);
+	vring_unmap_one_split(vq, i);
+	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;
 
 	/* Plus final descriptor */
@@ -661,15 +719,14 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 		if (!indir_desc)
 			return;
 
-		len = virtio32_to_cpu(vq->vq.vdev,
-				vq->split.vring.desc[head].len);
+		len = vq->split.desc_extra[head].len;
 
-		BUG_ON(!(vq->split.vring.desc[head].flags &
-			 cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_INDIRECT)));
+		BUG_ON(!(vq->split.desc_extra[head].flags &
+				VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
 		for (j = 0; j < len / sizeof(struct vring_desc); j++)
-			vring_unmap_one_split(vq, &indir_desc[j]);
+			vring_unmap_one_split_indirect(vq, &indir_desc[j]);
 
 		kfree(indir_desc);
 		vq->split.desc_state[head].indir_desc = NULL;
@@ -2085,7 +2142,6 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					void (*callback)(struct virtqueue *),
 					const char *name)
 {
-	unsigned int i;
 	struct vring_virtqueue *vq;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
@@ -2140,16 +2196,20 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	if (!vq->split.desc_state)
 		goto err_state;
 
+	vq->split.desc_extra = vring_alloc_desc_extra(vq, vring.num);
+	if (!vq->split.desc_extra)
+		goto err_extra;
+
 	/* Put everything in free lists. */
 	vq->free_head = 0;
-	for (i = 0; i < vring.num-1; i++)
-		vq->split.vring.desc[i].next = cpu_to_virtio16(vdev, i + 1);
 	memset(vq->split.desc_state, 0, vring.num *
 			sizeof(struct vring_desc_state_split));
 
 	list_add_tail(&vq->vq.list, &vdev->vqs);
 	return &vq->vq;
 
+err_extra:
+	kfree(vq->split.desc_state);
 err_state:
 	kfree(vq);
 	return NULL;
@@ -2233,8 +2293,10 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 					 vq->split.queue_dma_addr);
 		}
 	}
-	if (!vq->packed_ring)
+	if (!vq->packed_ring) {
 		kfree(vq->split.desc_state);
+		kfree(vq->split.desc_extra);
+	}
 	list_del(&_vq->list);
 	kfree(vq);
 }
-- 
2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
