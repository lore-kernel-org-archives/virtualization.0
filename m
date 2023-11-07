Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DC1C0032E
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 03:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5636B82C21;
	Tue,  7 Nov 2023 03:12:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5636B82C21
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5-hP907BmLK8; Tue,  7 Nov 2023 03:12:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4520E82C33;
	Tue,  7 Nov 2023 03:12:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4520E82C33
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C9E6C0DD6;
	Tue,  7 Nov 2023 03:12:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2C16EC007F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E303B82B9F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E303B82B9F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2gRHIxGJb8gF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:46 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E8CE82300
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9E8CE82300
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VvsNih7_1699326761; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VvsNih7_1699326761) by smtp.aliyun-inc.com;
 Tue, 07 Nov 2023 11:12:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 11/21] virtio_net: move some api to header
Date: Tue,  7 Nov 2023 11:12:17 +0800
Message-Id: <20231107031227.100015-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
References: <20231107031227.100015-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 59a160d210e8
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

__free_old_xmit
is_xdp_raw_buffer_queue

These two APIs are needed by the xsk part.
So this commit move theses to the header. And add prefix "virtnet_".

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 94 +++------------------------------
 drivers/net/virtio/virtio_net.h | 80 ++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 87 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 02e054fd217c..6c608b3ce27d 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -45,9 +45,6 @@ module_param(napi_tx, bool, 0644);
 #define VIRTIO_XDP_TX		BIT(0)
 #define VIRTIO_XDP_REDIR	BIT(1)
 
-#define VIRTIO_XDP_FLAG	BIT(0)
-#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG)
-
 #define VIRTNET_DRIVER_VERSION "1.0.0"
 
 static const unsigned long guest_offloads[] = {
@@ -150,78 +147,11 @@ struct virtio_net_common_hdr {
 	};
 };
 
-static bool is_xdp_frame(void *ptr)
-{
-	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
-}
-
 static void *xdp_to_ptr(struct xdp_frame *ptr)
 {
 	return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
 }
 
-static struct xdp_frame *ptr_to_xdp(void *ptr)
-{
-	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
-}
-
-static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
-{
-	struct virtnet_sq_dma *next, *head;
-
-	head = (void *)((unsigned long)data & ~VIRTIO_XMIT_DATA_MASK);
-
-	data = head->data;
-
-	while (head) {
-		virtqueue_dma_unmap_single_attrs(sq->vq, head->addr, head->len,
-						 DMA_TO_DEVICE, 0);
-
-		next = head->next;
-
-		head->next = sq->dmainfo.free;
-		sq->dmainfo.free = head;
-
-		head = next;
-	}
-
-	return data;
-}
-
-static void __free_old_xmit(struct virtnet_sq *sq, bool in_napi,
-			    u64 *bytes, u64 *packets)
-{
-	unsigned int len;
-	void *ptr;
-
-	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		if (!is_xdp_frame(ptr)) {
-			struct sk_buff *skb;
-
-			if (sq->do_dma)
-				ptr = virtnet_sq_unmap(sq, ptr);
-
-			skb = ptr;
-
-			pr_debug("Sent skb %p\n", skb);
-
-			*bytes += skb->len;
-			napi_consume_skb(skb, in_napi);
-		} else {
-			struct xdp_frame *frame;
-
-			if (sq->do_dma)
-				ptr = virtnet_sq_unmap(sq, ptr);
-
-			frame = ptr_to_xdp(ptr);
-
-			*bytes += xdp_get_frame_len(frame);
-			xdp_return_frame(frame);
-		}
-		(*packets)++;
-	}
-}
-
 /* Converting between virtqueue no. and kernel tx/rx queue no.
  * 0:rx0 1:tx0 2:rx1 3:tx1 ... 2N:rxN 2N+1:txN 2N+2:cvq
  */
@@ -700,7 +630,7 @@ static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
 {
 	u64 bytes, packets = 0;
 
-	__free_old_xmit(sq, in_napi, &bytes, &packets);
+	virtnet_free_old_xmit(sq, in_napi, &bytes, &packets);
 
 	/* Avoid overhead when no packets have been processed
 	 * happens when called speculatively from start_xmit.
@@ -714,16 +644,6 @@ static void free_old_xmit(struct virtnet_sq *sq, bool in_napi)
 	u64_stats_update_end(&sq->stats.syncp);
 }
 
-static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
-{
-	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
-		return false;
-	else if (q < vi->curr_queue_pairs)
-		return true;
-	else
-		return false;
-}
-
 static void check_sq_full_and_disable(struct virtnet_info *vi,
 				      struct net_device *dev,
 				      struct virtnet_sq *sq)
@@ -872,7 +792,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 
 	/* Free up any pending old buffers before queueing new ones. */
-	__free_old_xmit(sq, false, &bytes, &packets);
+	virtnet_free_old_xmit(sq, false, &bytes, &packets);
 
 	for (i = 0; i < n; i++) {
 		struct xdp_frame *xdpf = frames[i];
@@ -883,7 +803,7 @@ static int virtnet_xdp_xmit(struct net_device *dev,
 	}
 	ret = nxmit;
 
-	if (!is_xdp_raw_buffer_queue(vi, sq - vi->sq))
+	if (!virtnet_is_xdp_raw_buffer_queue(vi, sq - vi->sq))
 		check_sq_full_and_disable(vi, dev, sq);
 
 	if (flags & XDP_XMIT_FLUSH) {
@@ -2033,7 +1953,7 @@ static void virtnet_poll_cleantx(struct virtnet_rq *rq)
 	struct virtnet_sq *sq = &vi->sq[index];
 	struct netdev_queue *txq = netdev_get_tx_queue(vi->dev, index);
 
-	if (!sq->napi.weight || is_xdp_raw_buffer_queue(vi, index))
+	if (!sq->napi.weight || virtnet_is_xdp_raw_buffer_queue(vi, index))
 		return;
 
 	if (__netif_tx_trylock(txq)) {
@@ -2157,7 +2077,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
 	int opaque;
 	bool done;
 
-	if (unlikely(is_xdp_raw_buffer_queue(vi, index))) {
+	if (unlikely(virtnet_is_xdp_raw_buffer_queue(vi, index))) {
 		/* We don't need to enable cb for XDP */
 		napi_complete_done(napi, 0);
 		return 0;
@@ -3997,7 +3917,7 @@ void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 
 	sq = &vi->sq[i];
 
-	if (!is_xdp_frame(buf)) {
+	if (!virtnet_is_xdp_frame(buf)) {
 		if (sq->do_dma)
 			buf = virtnet_sq_unmap(sq, buf);
 
@@ -4006,7 +3926,7 @@ void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 		if (sq->do_dma)
 			buf = virtnet_sq_unmap(sq, buf);
 
-		xdp_return_frame(ptr_to_xdp(buf));
+		xdp_return_frame(virtnet_ptr_to_xdp(buf));
 	}
 }
 
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 98ba23cfdb20..442af4673bf8 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -8,6 +8,9 @@
 #include <linux/virtio_net.h>
 #include <net/xdp_sock_drv.h>
 
+#define VIRTIO_XDP_FLAG	BIT(0)
+#define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG)
+
 /* RX packet size EWMA. The average packet size is used to determine the packet
  * buffer size when refilling RX rings. As the entire RX ring may be refilled
  * at once, the weight is chosen so that the EWMA will be insensitive to short-
@@ -221,6 +224,83 @@ struct virtnet_info {
 	struct failover *failover;
 };
 
+static inline bool virtnet_is_xdp_frame(void *ptr)
+{
+	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
+}
+
+static inline struct xdp_frame *virtnet_ptr_to_xdp(void *ptr)
+{
+	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
+}
+
+static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
+{
+	struct virtnet_sq_dma *next, *head;
+
+	head = (void *)((unsigned long)data & ~VIRTIO_XMIT_DATA_MASK);
+
+	data = head->data;
+
+	while (head) {
+		virtqueue_dma_unmap_single_attrs(sq->vq, head->addr, head->len,
+						 DMA_TO_DEVICE, 0);
+
+		next = head->next;
+
+		head->next = sq->dmainfo.free;
+		sq->dmainfo.free = head;
+
+		head = next;
+	}
+
+	return data;
+}
+
+static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
+					 u64 *bytes, u64 *packets)
+{
+	unsigned int len;
+	void *ptr;
+
+	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
+		if (!virtnet_is_xdp_frame(ptr)) {
+			struct sk_buff *skb;
+
+			if (sq->do_dma)
+				ptr = virtnet_sq_unmap(sq, ptr);
+
+			skb = ptr;
+
+			pr_debug("Sent skb %p\n", skb);
+
+			*bytes += skb->len;
+			napi_consume_skb(skb, in_napi);
+		} else {
+			struct xdp_frame *frame;
+
+			if (sq->do_dma)
+				ptr = virtnet_sq_unmap(sq, ptr);
+
+			frame = virtnet_ptr_to_xdp(ptr);
+
+			*bytes += xdp_get_frame_len(frame);
+			xdp_return_frame(frame);
+		}
+		(*packets)++;
+	}
+}
+
+static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
+{
+	if (q < (vi->curr_queue_pairs - vi->xdp_queue_pairs))
+		return false;
+	else if (q < vi->curr_queue_pairs)
+		return true;
+	else
+		return false;
+}
+
 void virtnet_rx_pause(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_rx_resume(struct virtnet_info *vi, struct virtnet_rq *rq);
 void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
