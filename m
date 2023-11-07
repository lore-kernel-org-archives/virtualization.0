Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B13C4708E
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 03:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 704A76132B;
	Tue,  7 Nov 2023 03:12:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 704A76132B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cynwnS6WtOxW; Tue,  7 Nov 2023 03:12:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4405E6131E;
	Tue,  7 Nov 2023 03:12:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4405E6131E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7F5B3C0DD9;
	Tue,  7 Nov 2023 03:12:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CE8BC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 788B6607CA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 788B6607CA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uBwZZYEu80es
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:50 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 543C961316
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 543C961316
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VvsPa.7_1699326764; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VvsPa.7_1699326764) by smtp.aliyun-inc.com;
 Tue, 07 Nov 2023 11:12:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 14/21] virtio_net: xsk: tx:
 virtnet_free_old_xmit() distinguishes xsk buffer
Date: Tue,  7 Nov 2023 11:12:20 +0800
Message-Id: <20231107031227.100015-15-xuanzhuo@linux.alibaba.com>
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

virtnet_free_old_xmit distinguishes three type ptr(skb, xdp frame, xsk
buffer) by the last bits of the pointer.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtio_net.h | 18 ++++++++++++++++--
 drivers/net/virtio/xsk.h        |  5 +++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index a431a2c1ee47..a13d6d301fdb 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -225,6 +225,11 @@ struct virtnet_info {
 	struct failover *failover;
 };
 
+static inline bool virtnet_is_skb_ptr(void *ptr)
+{
+	return !((unsigned long)ptr & VIRTIO_XMIT_DATA_MASK);
+}
+
 static inline bool virtnet_is_xdp_frame(void *ptr)
 {
 	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
@@ -235,6 +240,8 @@ static inline struct xdp_frame *virtnet_ptr_to_xdp(void *ptr)
 	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
 }
 
+static inline u32 virtnet_ptr_to_xsk(void *ptr);
+
 static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
 {
 	struct virtnet_sq_dma *next, *head;
@@ -261,11 +268,12 @@ static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
 static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 					 u64 *bytes, u64 *packets)
 {
+	unsigned int xsknum = 0;
 	unsigned int len;
 	void *ptr;
 
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		if (!virtnet_is_xdp_frame(ptr)) {
+		if (virtnet_is_skb_ptr(ptr)) {
 			struct sk_buff *skb;
 
 			if (sq->do_dma)
@@ -277,7 +285,7 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 
 			*bytes += skb->len;
 			napi_consume_skb(skb, in_napi);
-		} else {
+		} else if (virtnet_is_xdp_frame(ptr)) {
 			struct xdp_frame *frame;
 
 			if (sq->do_dma)
@@ -287,9 +295,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 
 			*bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
+		} else {
+			*bytes += virtnet_ptr_to_xsk(ptr);
+			++xsknum;
 		}
 		(*packets)++;
 	}
+
+	if (xsknum)
+		xsk_tx_completed(sq->xsk.pool, xsknum);
 }
 
 static inline bool virtnet_is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index 1bd19dcda649..7ebc9bda7aee 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -14,6 +14,11 @@ static inline void *virtnet_xsk_to_ptr(u32 len)
 	return (void *)(p | VIRTIO_XSK_FLAG);
 }
 
+static inline u32 virtnet_ptr_to_xsk(void *ptr)
+{
+	return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
+}
+
 int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
 bool virtnet_xsk_xmit(struct virtnet_sq *sq, struct xsk_buff_pool *pool,
 		      int budget);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
