Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96AF9C4167B
	for <virtualization@archiver.kernel.org>; Tue,  7 Nov 2023 03:12:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2718D4211E;
	Tue,  7 Nov 2023 03:12:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2718D4211E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x4r0zBVqN1lI; Tue,  7 Nov 2023 03:12:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9FD1C4212C;
	Tue,  7 Nov 2023 03:12:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9FD1C4212C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9453DC0DD9;
	Tue,  7 Nov 2023 03:12:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D5DBC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 74AA361313
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 74AA361313
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MpyyVWxsJr70
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:53 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C14DE6131C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Nov 2023 03:12:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C14DE6131C
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VvsQheF_1699326767; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VvsQheF_1699326767) by smtp.aliyun-inc.com;
 Tue, 07 Nov 2023 11:12:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 17/21] virtio_net: xsk: rx: skip dma unmap when rq
 is bind with AF_XDP
Date: Tue,  7 Nov 2023 11:12:23 +0800
Message-Id: <20231107031227.100015-18-xuanzhuo@linux.alibaba.com>
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

When rq is bound with AF_XDP, the buffer dma is managed
by the AF_XDP APIs. So the buffer got from the virtio core should
skip the dma unmap operation.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c       | 8 +++++---
 drivers/net/virtio/virtio_net.h | 3 +++
 drivers/net/virtio/xsk.c        | 1 +
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 15943a22e17d..a318b2533b94 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -430,7 +430,7 @@ static void *virtnet_rq_get_buf(struct virtnet_rq *rq, u32 *len, void **ctx)
 	void *buf;
 
 	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf && rq->do_dma)
+	if (buf && rq->do_dma_unmap)
 		virtnet_rq_unmap(rq, buf, *len);
 
 	return buf;
@@ -561,8 +561,10 @@ static void virtnet_set_premapped(struct virtnet_info *vi)
 
 		/* disable for big mode */
 		if (vi->mergeable_rx_bufs || !vi->big_packets) {
-			if (!virtqueue_set_dma_premapped(vi->rq[i].vq))
+			if (!virtqueue_set_dma_premapped(vi->rq[i].vq)) {
 				vi->rq[i].do_dma = true;
+				vi->rq[i].do_dma_unmap = true;
+			}
 		}
 	}
 }
@@ -3944,7 +3946,7 @@ void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
 
 	rq = &vi->rq[i];
 
-	if (rq->do_dma)
+	if (rq->do_dma_unmap)
 		virtnet_rq_unmap(rq, buf, 0);
 
 	virtnet_rq_free_buf(vi, rq, buf);
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 1242785e311e..2005d0cd22e2 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -135,6 +135,9 @@ struct virtnet_rq {
 	/* Do dma by self */
 	bool do_dma;
 
+	/* Do dma unmap after getting buf from virtio core. */
+	bool do_dma_unmap;
+
 	struct {
 		struct xsk_buff_pool *pool;
 
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index e737c3353212..b09c473c29fb 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -210,6 +210,7 @@ static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *
 		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
 
 	rq->xsk.pool = pool;
+	rq->do_dma_unmap = !pool;
 
 	virtnet_rx_resume(vi, rq);
 
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
