Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08104C6379F
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:01:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A573540B9A;
	Thu,  2 Feb 2023 11:01:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A573540B9A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vRdJ7SHp9bVK; Thu,  2 Feb 2023 11:01:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 371FF40C0D;
	Thu,  2 Feb 2023 11:01:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 371FF40C0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73FA8C007B;
	Thu,  2 Feb 2023 11:01:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7068FC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 496B481F4A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 496B481F4A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MvAYdILedPDI
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1767481F21
Received: from out30-100.freemail.mail.aliyun.com
 (out30-100.freemail.mail.aliyun.com [115.124.30.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1767481F21
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:39 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R591e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VaksacV_1675335693; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VaksacV_1675335693) by smtp.aliyun-inc.com;
 Thu, 02 Feb 2023 19:01:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 31/33] virtio_net: xsk: tx: auto wakeup when free old xmit
Date: Thu,  2 Feb 2023 19:00:56 +0800
Message-Id: <20230202110058.130695-32-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d7589ab6ea10
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

If the XSK xmit stops because the TX queue is full, this time is
waiting for the TX interrupt to trigger the follow-up work again.

But for Virtio Net, the recycling old buf is not only completed in tx
napi, but also is called in start_xmit(), rx poll and other places.

So if xsk xmit stop by full tx queue, __free_old_xmit() will try to
wakeup tx napi.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/virtio_net.h |  5 +++--
 drivers/net/virtio/xsk.c        | 30 ++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |  1 +
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index fc7c7a0f3c89..100ce48c6d55 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -176,6 +176,8 @@ struct send_queue {
 		dma_addr_t hdr_dma_address;
 
 		u32 last_cpu;
+
+		bool need_wakeup;
 	} xsk;
 };
 
@@ -296,8 +298,7 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
 		stats->packets++;
 	}
 
-	if (xsknum)
-		xsk_tx_completed(sq->xsk.pool, xsknum);
+	virtnet_xsk_complete(sq, xsknum, in_napi);
 }
 
 int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
index 27b7f0bb2d34..043b0bf2a5d7 100644
--- a/drivers/net/virtio/xsk.c
+++ b/drivers/net/virtio/xsk.c
@@ -116,6 +116,7 @@ bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 	bool busy;
 	int ret;
 
+	sq->xsk.need_wakeup = false;
 	__free_old_xmit(sq, true, &stats);
 
 	if (xsk_uses_need_wakeup(pool))
@@ -138,6 +139,13 @@ bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 		 * triggered by interrupt.
 		 */
 		busy = false;
+
+		/* tx poll may not be triggered by tx interruption because of
+		 * that start_xmit() and rx poll will try free old xmit that
+		 * cause no tx interruption will be generated. So set
+		 * need_wakeup, then tx poll can be triggered by free_old_xmit.
+		 */
+		sq->xsk.need_wakeup = true;
 		break;
 	}
 
@@ -206,6 +214,26 @@ int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
 	return 0;
 }
 
+void virtnet_xsk_complete(struct send_queue *sq, u32 num, bool in_napi)
+{
+	struct xsk_buff_pool *pool;
+
+	rcu_read_lock();
+
+	pool = rcu_dereference(sq->xsk.pool);
+	if (pool) {
+		if (num)
+			xsk_tx_completed(pool, num);
+
+		if (sq->xsk.need_wakeup) {
+			sq->xsk.need_wakeup = false;
+			virtnet_xsk_wakeup_sq(sq, in_napi);
+		}
+	}
+
+	rcu_read_unlock();
+}
+
 static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queue *rq,
 				    struct xsk_buff_pool *pool, struct net_device *dev)
 {
@@ -298,6 +326,8 @@ static int virtnet_xsk_pool_enable(struct net_device *dev,
 	if (err)
 		goto err_rxq;
 
+	sq->xsk.need_wakeup = false;
+
 	/* Here is already protected by rtnl_lock, so rcu_assign_pointer
 	 * is safe.
 	 */
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
index 5eece0de3310..f90c28972d72 100644
--- a/drivers/net/virtio/xsk.h
+++ b/drivers/net/virtio/xsk.h
@@ -19,6 +19,7 @@ static inline u32 ptr_to_xsk(void *ptr)
 	return ((unsigned long)ptr) >> VIRTIO_XSK_FLAG_OFFSET;
 }
 
+void virtnet_xsk_complete(struct send_queue *sq, u32 num, bool in_napi);
 int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
 bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
 		      int budget);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
