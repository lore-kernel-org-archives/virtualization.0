Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B432C6379F
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:01:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BE00540C05;
	Thu,  2 Feb 2023 11:01:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BE00540C05
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NLmQczyLblc4; Thu,  2 Feb 2023 11:01:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 270A040C71;
	Thu,  2 Feb 2023 11:01:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 270A040C71
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E13B1C0081;
	Thu,  2 Feb 2023 11:01:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62401C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3D60E41949
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D60E41949
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N_FXz-SRA-9p
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 79F85418BE
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 79F85418BE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:26 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VakkM6e_1675335681; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VakkM6e_1675335681) by smtp.aliyun-inc.com;
 Thu, 02 Feb 2023 19:01:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 20/33] virtio_net: xsk: introduce virtnet_rq_bind_xsk_pool()
Date: Thu,  2 Feb 2023 19:00:45 +0800
Message-Id: <20230202110058.130695-21-xuanzhuo@linux.alibaba.com>
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

This function is used to bind or unbind xsk pool to virtnet rq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/Makefile     |  2 +-
 drivers/net/virtio/main.c       |  8 ++---
 drivers/net/virtio/virtio_net.h | 16 ++++++++++
 drivers/net/virtio/xsk.c        | 56 +++++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/virtio/xsk.c

diff --git a/drivers/net/virtio/Makefile b/drivers/net/virtio/Makefile
index 15ed7c97fd4f..8c2a884d2dba 100644
--- a/drivers/net/virtio/Makefile
+++ b/drivers/net/virtio/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 
-virtio_net-y := main.o
+virtio_net-y := main.o xsk.o
diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 049a3bb9d88d..0ee23468b795 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -110,7 +110,6 @@ struct padded_vnet_hdr {
 	char padding[12];
 };
 
-static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 
 static void *xdp_to_ptr(struct xdp_frame *ptr)
@@ -1351,8 +1350,7 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
  * before we're receiving packets, or from refill_work which is
  * careful to disable receiving (using napi_disable).
  */
-static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
-			  gfp_t gfp)
+bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq, gfp_t gfp)
 {
 	int err;
 	bool oom;
@@ -1388,7 +1386,7 @@ static void skb_recv_done(struct virtqueue *rvq)
 	virtqueue_napi_schedule(&rq->napi, rvq);
 }
 
-static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
+void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 {
 	napi_enable(napi);
 
@@ -3284,7 +3282,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 		xdp_return_frame(ptr_to_xdp(buf));
 }
 
-static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
+void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
 	int i = vq2rxq(vq);
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index b46f083a630a..4a7633714802 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -168,6 +168,12 @@ struct send_queue {
 
 	/* Record whether sq is in reset state. */
 	bool reset;
+
+	struct {
+		struct xsk_buff_pool __rcu *pool;
+
+		dma_addr_t hdr_dma_address;
+	} xsk;
 };
 
 /* Internal representation of a receive virtqueue */
@@ -200,6 +206,13 @@ struct receive_queue {
 	char name[16];
 
 	struct xdp_rxq_info xdp_rxq;
+
+	struct {
+		struct xsk_buff_pool __rcu *pool;
+
+		/* xdp rxq used by xsk */
+		struct xdp_rxq_info xdp_rxq;
+	} xsk;
 };
 
 static inline bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
@@ -274,4 +287,7 @@ int virtnet_xdp_handler(struct bpf_prog *xdp_prog, struct xdp_buff *xdp,
 			unsigned int *xdp_xmit,
 			struct virtnet_rq_stats *stats);
 int virtnet_tx_reset(struct virtnet_info *vi, struct send_queue *sq);
+bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq, gfp_t gfp);
+void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi);
+void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
 #endif
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
new file mode 100644
index 000000000000..e01ff2abea11
--- /dev/null
+++ b/drivers/net/virtio/xsk.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * virtio-net xsk
+ */
+
+#include "virtio_net.h"
+
+static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct receive_queue *rq,
+				    struct xsk_buff_pool *pool, struct net_device *dev)
+{
+	bool running = netif_running(vi->dev);
+	int err, qindex;
+
+	qindex = rq - vi->rq;
+
+	if (pool) {
+		err = xdp_rxq_info_reg(&rq->xsk.xdp_rxq, dev, qindex, rq->napi.napi_id);
+		if (err < 0)
+			return err;
+
+		err = xdp_rxq_info_reg_mem_model(&rq->xsk.xdp_rxq,
+						 MEM_TYPE_XSK_BUFF_POOL, NULL);
+		if (err < 0) {
+			xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
+			return err;
+		}
+
+		xsk_pool_set_rxq_info(pool, &rq->xsk.xdp_rxq);
+	} else {
+		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
+	}
+
+	if (running)
+		napi_disable(&rq->napi);
+
+	err = virtqueue_reset(rq->vq, virtnet_rq_free_unused_buf);
+	if (err)
+		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
+
+	if (pool) {
+		if (err)
+			xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
+		else
+			rcu_assign_pointer(rq->xsk.pool, pool);
+	} else {
+		rcu_assign_pointer(rq->xsk.pool, NULL);
+	}
+
+	if (!try_fill_recv(vi, rq, GFP_KERNEL))
+		schedule_delayed_work(&vi->refill, 0);
+
+	if (running)
+		virtnet_napi_enable(rq->vq, &rq->napi);
+
+	return err;
+}
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
