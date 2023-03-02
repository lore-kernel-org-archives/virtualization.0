Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358BBC6FA8E
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:59:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7AFE6113B;
	Thu,  2 Mar 2023 11:59:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B7AFE6113B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kkH_B6x5OUdm; Thu,  2 Mar 2023 11:59:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F0E4D61282;
	Thu,  2 Mar 2023 11:59:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F0E4D61282
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74858C0094;
	Thu,  2 Mar 2023 11:59:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C50CC0091
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B83ED40CB2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B83ED40CB2
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MMkwccNl8BNl
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 254EB40C20
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 254EB40C20
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:17 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VcxJKnS_1677758350; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VcxJKnS_1677758350) by smtp.aliyun-inc.com;
 Thu, 02 Mar 2023 19:59:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v1 03/12] virtio_ring: split: introduce
 virtqueue_add_split_premapped()
Date: Thu,  2 Mar 2023 19:58:59 +0800
Message-Id: <20230302115908.1461-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
References: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: b21604ee9ed7
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

virtqueue_add_split() only supports virtual addresses, dma is completed
in virtqueue_add_split().

In some scenarios (such as the AF_XDP scenario), the memory is allocated
and DMA is completed in advance, so it is necessary for us to support
passing the DMA address to virtio core.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 74 +++++++++++++++++++++++++++++++-----
 include/linux/virtio.h       |  5 +++
 2 files changed, 69 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 17520f0d7649..5b186ce73d35 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -70,6 +70,7 @@
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
 	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+	bool dma_map;			/* Addr is mapped by virtio core or not. */
 };
 
 struct vring_desc_state_packed {
@@ -440,7 +441,7 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 }
 
 static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
-					  unsigned int i)
+					  unsigned int i, bool dma_map)
 {
 	struct vring_desc_extra *extra = vq->split.desc_extra;
 	u16 flags;
@@ -457,6 +458,9 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
+		if (!dma_map)
+			goto out;
+
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra[i].addr,
 			       extra[i].len,
@@ -751,6 +755,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      unsigned int in_sgs,
 				      void *data,
 				      void *ctx,
+				      bool dma_map,
 				      gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -767,9 +772,11 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		goto end;
 	}
 
-	err = virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
-	if (err)
-		goto err;
+	if (dma_map) {
+		err = virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+		if (err)
+			goto err;
+	}
 
 	head = vq->free_head;
 	err = virtqueue_add_vring_split(vq, sgs, total_sg, out_sgs, in_sgs, desc);
@@ -779,11 +786,13 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	/* Store token and indirect buffer state. */
 	vq->split.desc_state[head].data = data;
 	vq->split.desc_state[head].indir_desc = desc ? desc : ctx;
+	vq->split.desc_state[head].dma_map = dma_map;
 
 	goto end;
 
 err:
-	virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+	if (dma_map)
+		virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
 
 	kfree(desc);
 
@@ -828,20 +837,23 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 {
 	unsigned int i, j;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
+	bool dma_map;
 
 	/* Clear data ptr. */
 	vq->split.desc_state[head].data = NULL;
 
+	dma_map = vq->split.desc_state[head].dma_map;
+
 	/* Put back on free list: unmap first-level descriptors and find end */
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, i);
+		vring_unmap_one_split(vq, i, dma_map);
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
 
-	vring_unmap_one_split(vq, i);
+	vring_unmap_one_split(vq, i, dma_map);
 	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;
 
@@ -863,8 +875,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 				VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
-		for (j = 0; j < len / sizeof(struct vring_desc); j++)
-			vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+		if (dma_map) {
+			for (j = 0; j < len / sizeof(struct vring_desc); j++)
+				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+		}
 
 		kfree(indir_desc);
 		vq->split.desc_state[head].indir_desc = NULL;
@@ -2204,7 +2218,22 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
 					out_sgs, in_sgs, data, ctx, gfp) :
 				 virtqueue_add_split(_vq, sgs, total_sg,
-					out_sgs, in_sgs, data, ctx, gfp);
+					out_sgs, in_sgs, data, ctx, true, gfp);
+}
+
+static inline int virtqueue_add_premapped(struct virtqueue *_vq,
+					  struct scatterlist *sgs[],
+					  unsigned int total_sg,
+					  unsigned int out_sgs,
+					  unsigned int in_sgs,
+					  void *data,
+					  void *ctx,
+					  gfp_t gfp)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return virtqueue_add_split(_vq, sgs, total_sg, out_sgs, in_sgs, data,
+				   ctx, false, gfp);
 }
 
 /**
@@ -2264,6 +2293,31 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
 
+/**
+ * virtqueue_add_outbuf_premapped - expose output buffers with dma address to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg readable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * It is required that all addrs have completed DMA operations. And use
+ * sg->dma_address, sg->length to pass addr and length.
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
+				   struct scatterlist *sg, unsigned int num,
+				   void *data,
+				   gfp_t gfp)
+{
+	return virtqueue_add_premapped(vq, &sg, num, 1, 0, data, NULL, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_outbuf_premapped);
+
 /**
  * virtqueue_add_inbuf - expose input buffers to other end
  * @vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index dcab9c7e8784..d8b472a7dcae 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -43,6 +43,11 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
 			 void *data,
 			 gfp_t gfp);
 
+int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
+				   struct scatterlist *sg, unsigned int num,
+				   void *data,
+				   gfp_t gfp);
+
 int virtqueue_add_inbuf(struct virtqueue *vq,
 			struct scatterlist sg[], unsigned int num,
 			void *data,
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
