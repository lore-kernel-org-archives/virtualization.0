Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDCFCD6E54
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 09:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E30C1611F5;
	Wed, 11 Oct 2023 09:27:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E30C1611F5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AquoaQ0Izc8U; Wed, 11 Oct 2023 09:27:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AEE07611E5;
	Wed, 11 Oct 2023 09:27:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEE07611E5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD3EBC0DD6;
	Wed, 11 Oct 2023 09:27:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 379FBC0039
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 14173611ED
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 14173611ED
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ubf3Ky_wWfuP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:52 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6850C611CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6850C611CF
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R651e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VtwMruG_1697016466; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VtwMruG_1697016466) by smtp.aliyun-inc.com;
 Wed, 11 Oct 2023 17:27:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost 16/22] virtio_net: xsk: tx: virtnet_free_old_xmit()
 distinguishes xsk buffer
Date: Wed, 11 Oct 2023 17:27:22 +0800
Message-Id: <20231011092728.105904-17-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
References: <20231011092728.105904-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 7e791d85ef9e
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
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
buffer) by the last two types bits.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtio_net.h | 16 ++++++++++++++--
 drivers/net/virtio/xsk.h        |  5 +++++
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 3e114360cc8a..54f954ea62fb 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -243,6 +243,11 @@ struct virtnet_info {
 
 #include "xsk.h"
 
+static inline bool virtnet_is_skb_ptr(void *ptr)
+{
+	return !((unsigned long)ptr & VIRTIO_XMIT_DATA_MASK);
+}
+
 static inline bool virtnet_is_xdp_frame(void *ptr)
 {
 	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
@@ -278,11 +283,12 @@ static inline void *virtnet_sq_unmap(struct virtnet_sq *sq, void *data)
 static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 					 struct virtnet_sq_stats *stats)
 {
+	unsigned int xsknum = 0;
 	unsigned int len;
 	void *ptr;
 
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		if (!virtnet_is_xdp_frame(ptr)) {
+		if (virtnet_is_skb_ptr(ptr)) {
 			struct sk_buff *skb;
 
 			if (sq->do_dma)
@@ -294,7 +300,7 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 
 			stats->bytes += skb->len;
 			napi_consume_skb(skb, in_napi);
-		} else {
+		} else if (virtnet_is_xdp_frame(ptr)) {
 			struct xdp_frame *frame;
 
 			if (sq->do_dma)
@@ -304,9 +310,15 @@ static inline void virtnet_free_old_xmit(struct virtnet_sq *sq, bool in_napi,
 
 			stats->bytes += xdp_get_frame_len(frame);
 			xdp_return_frame(frame);
+		} else {
+			stats->bytes += virtnet_ptr_to_xsk(ptr);
+			++xsknum;
 		}
 		stats->packets++;
 	}
+
+	if (xsknum)
+		xsk_tx_completed(sq->xsk.pool, xsknum);
 }
 
 static inline void virtnet_vq_napi_schedule(struct napi_struct *napi,
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
