Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028FF2D62C
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 131E58216F
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 11:31:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 131E58216F
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xq_n2rVHEOn0
	for <virtualization@lists.linux-foundation.org>;
	Tue, 14 Nov 2023 11:31:14 +0000 (UTC)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C12A382188
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 11:31:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C12A382188
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VwPQ83f_1699961468;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VwPQ83f_1699961468)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 19:31:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC 4/4] virtio_net: sq support premapped mode
Date: Tue, 14 Nov 2023 19:31:04 +0800
Message-Id: <20231114113104.33994-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com>
References: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 52aa29c00172
Content-Transfer-Encoding: 8bit

If the xsk is enabling, the xsk tx will share the send queue.
But the xsk requires that the send queue use the premapped mode.
So the send queue must support premapped mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 114 ++++++++++++++++++++++++++++----
 drivers/net/virtio/virtio_net.h |   2 +
 2 files changed, 102 insertions(+), 14 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 57cbd449637a..0766fed28afe 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -167,13 +167,46 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
 	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
 }
 
+static void virtnet_sq_unmap(struct virtnet_sq *sq)
+{
+	struct scatterlist *sg;
+
+	for (sg = sq->sg; ; sg = sg_next(sg)) {
+		virtqueue_dma_unmap_single_attrs(sq->vq,
+						 sg->dma_address,
+						 sg->length,
+						 DMA_TO_DEVICE, 0);
+
+		if (sg_is_last(sg)) {
+			/* clear the end mark setted by virtio core. */
+			sg_unmark_end(sg);
+			break;
+		}
+	}
+
+	/* mark the last one of sq->sg[] as the end for reuse by
+	 * virtqueue_get_buf_ctx_dma().
+	 */
+	sg_mark_end(&sq->sg[ARRAY_SIZE(sq->sg) - 1]);
+}
+
 static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 			    u64 *bytes, u64 *packets)
 {
+	struct scatterlist *sg = NULL;
 	unsigned int len;
 	void *ptr;
 
-	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
+	/* clear the sg table */
+	if (sq->do_dma) {
+		sg_init_table(sq->sg, ARRAY_SIZE(sq->sg));
+		sg = sq->sg;
+	}
+
+	while ((ptr = virtqueue_get_buf_ctx_dma(sq->vq, &len, sg, NULL)) != NULL) {
+		if (sq->do_dma)
+			virtnet_sq_unmap(sq);
+
 		if (!is_xdp_frame(ptr)) {
 			struct sk_buff *skb = ptr;
 
@@ -567,22 +600,61 @@ static void *virtnet_rq_alloc(struct virtnet_rq *rq, u32 size, gfp_t gfp)
 	return buf;
 }
 
-static void virtnet_rq_set_premapped(struct virtnet_info *vi)
+static void virtnet_set_premapped(struct virtnet_info *vi)
 {
 	int i;
 
-	/* disable for big mode */
-	if (!vi->mergeable_rx_bufs && vi->big_packets)
-		return;
-
 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
-			continue;
+		if (!virtqueue_set_dma_premapped(vi->sq[i].vq))
+			vi->sq[i].do_dma = true;
 
-		vi->rq[i].do_dma = true;
+		/* disable for big mode */
+		if (vi->mergeable_rx_bufs || !vi->big_packets) {
+			if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
+				vi->rq[i].do_dma = true;
+		}
 	}
 }
 
+static int virtnet_sq_map_sg(struct virtnet_sq *sq)
+{
+	struct scatterlist *sg;
+
+	for (sg = sq->sg; sg; sg = sg_next(sg)) {
+		sg->dma_address = virtqueue_dma_map_single_attrs(sq->vq, sg_virt(sg),
+								 sg->length,
+								 DMA_TO_DEVICE, 0);
+		if (virtqueue_dma_mapping_error(sq->vq, sg->dma_address))
+			goto err;
+	}
+
+	return 0;
+
+err:
+	if (sg != sq->sg) {
+		sg_mark_end(sg - 1);
+		virtnet_sq_unmap(sq);
+	}
+	return -ENOMEM;
+}
+
+static int virtnet_add_outbuf(struct virtnet_sq *sq, u32 num, void *data)
+{
+	int ret;
+
+	if (sq->do_dma) {
+		ret = virtnet_sq_map_sg(sq);
+		if (ret)
+			return -ENOMEM;
+	}
+
+	ret = virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMIC);
+	if (ret && sq->do_dma)
+		virtnet_sq_unmap(sq);
+
+	return ret;
+}
+
 static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
 {
 	u64 bytes, packets = 0;
@@ -686,8 +758,7 @@ static int __virtnet_xdp_xmit_one(struct virtnet_info *vi,
 			    skb_frag_size(frag), skb_frag_off(frag));
 	}
 
-	err = virtqueue_add_outbuf(sq->vq, sq->sg, nr_frags + 1,
-				   xdp_to_ptr(xdpf), GFP_ATOMIC);
+	err = virtnet_add_outbuf(sq, nr_frags + 1, xdp_to_ptr(xdpf));
 	if (unlikely(err))
 		return -ENOSPC; /* Caller handle free/refcnt */
 
@@ -2126,7 +2197,7 @@ static int xmit_skb(struct virtnet_sq *sq, struct sk_buff *skb)
 			return num_sg;
 		num_sg++;
 	}
-	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
+	return virtnet_add_outbuf(sq, num_sg, skb);
 }
 
 static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
@@ -3852,10 +3923,25 @@ static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
 
 static void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
 {
+	struct virtnet_info *vi = vq->vdev->priv;
+	struct scatterlist *sg = NULL;
+	struct virtnet_sq *sq;
+	int i = vq2txq(vq);
 	void *buf;
 
-	while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+	sq = &vi->sq[i];
+
+	if (sq->do_dma) {
+		sg_init_table(sq->sg, ARRAY_SIZE(sq->sg));
+		sg = sq->sg;
+	}
+
+	while ((buf = virtqueue_detach_unused_buf_premapped(vq, sg)) != NULL) {
+		if (sq->do_dma)
+			virtnet_sq_unmap(sq);
+
 		virtnet_sq_free_unused_buf(vq, buf);
+	}
 }
 
 static void virtnet_rq_free_unused_bufs(struct virtqueue *vq)
@@ -4052,7 +4138,7 @@ static int init_vqs(struct virtnet_info *vi)
 	if (ret)
 		goto err_free;
 
-	virtnet_rq_set_premapped(vi);
+	virtnet_set_premapped(vi);
 
 	cpus_read_lock();
 	virtnet_set_affinity(vi);
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index ebf9f344648a..870855a829a0 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -67,6 +67,8 @@ struct virtnet_sq {
 
 	/* Record whether sq is in reset state. */
 	bool reset;
+
+	bool do_dma;
 };
 
 /* Internal representation of a receive virtqueue */
-- 
2.32.0.3.g01195cf9f

