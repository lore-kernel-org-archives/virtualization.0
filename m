Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5085CD6E53
	for <virtualization@archiver.kernel.org>; Wed, 11 Oct 2023 09:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C74882479;
	Wed, 11 Oct 2023 09:27:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7C74882479
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i4OCaB-BpyKR; Wed, 11 Oct 2023 09:27:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 236A682457;
	Wed, 11 Oct 2023 09:27:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 236A682457
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8C9EC0DD3;
	Wed, 11 Oct 2023 09:27:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14284C0088
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF2A482446
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF2A482446
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VOqqu5Md3CI0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:48 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3D19C823E2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Oct 2023 09:27:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D19C823E2
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R491e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VtwJVey_1697016462; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VtwJVey_1697016462) by smtp.aliyun-inc.com;
 Wed, 11 Oct 2023 17:27:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost 12/22] virtio_net: xsk: bind/unbind xsk
Date: Wed, 11 Oct 2023 17:27:18 +0800
Message-Id: <20231011092728.105904-13-xuanzhuo@linux.alibaba.com>
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

This patch implement the logic of bind/unbind xsk pool to sq and rq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/Makefile     |   2 +-
 drivers/net/virtio/main.c       |  10 +-
 drivers/net/virtio/virtio_net.h |  18 ++++
 drivers/net/virtio/xsk.c        | 186 ++++++++++++++++++++++++++++++++
 drivers/net/virtio/xsk.h        |   7 ++
 5 files changed, 216 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/virtio/xsk.c
 create mode 100644 drivers/net/virtio/xsk.h

diff --git a/drivers/net/virtio/Makefile b/drivers/net/virtio/Makefile
index 15ed7c97fd4f..8c2a884d2dba 100644
--- a/drivers/net/virtio/Makefile
+++ b/drivers/net/virtio/Makefile
@@ -5,4 +5,4 @@
 
 obj-$(CONFIG_VIRTIO_NET) += virtio_net.o
 
-virtio_net-y := main.o
+virtio_net-y := main.o xsk.o
diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index ad47ab2d74a2..a4e63c55ba1f 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -8,7 +8,6 @@
 #include <linux/etherdevice.h>
 #include <linux/module.h>
 #include <linux/virtio.h>
-#include <linux/virtio_net.h>
 #include <linux/bpf.h>
 #include <linux/bpf_trace.h>
 #include <linux/scatterlist.h>
@@ -139,9 +138,6 @@ struct virtio_net_common_hdr {
 	};
 };
 
-static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
-static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
-
 static void *xdp_to_ptr(struct xdp_frame *ptr)
 {
 	return (void *)((unsigned long)ptr | VIRTIO_XDP_FLAG);
@@ -3676,6 +3672,8 @@ static int virtnet_xdp(struct net_device *dev, struct netdev_bpf *xdp)
 	switch (xdp->command) {
 	case XDP_SETUP_PROG:
 		return virtnet_xdp_set(dev, xdp->prog, xdp->extack);
+	case XDP_SETUP_XSK_POOL:
+		return virtnet_xsk_pool_setup(dev, xdp);
 	default:
 		return -EINVAL;
 	}
@@ -3861,7 +3859,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
 		}
 }
 
-static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
+void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
 	if (!virtnet_is_xdp_frame(buf))
 		dev_kfree_skb(buf);
@@ -3869,7 +3867,7 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 		xdp_return_frame(virtnet_ptr_to_xdp(buf));
 }
 
-static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
+void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
 {
 	struct virtnet_info *vi = vq->vdev->priv;
 	int i = vq2rxq(vq);
diff --git a/drivers/net/virtio/virtio_net.h b/drivers/net/virtio/virtio_net.h
index 9cb9b16bb0d3..0603033b76a0 100644
--- a/drivers/net/virtio/virtio_net.h
+++ b/drivers/net/virtio/virtio_net.h
@@ -5,6 +5,8 @@
 
 #include <linux/ethtool.h>
 #include <linux/average.h>
+#include <linux/virtio_net.h>
+#include <net/xdp_sock_drv.h>
 
 #define VIRTIO_XDP_FLAG	BIT(0)
 #define VIRTIO_XMIT_DATA_MASK (VIRTIO_XDP_FLAG)
@@ -94,6 +96,11 @@ struct virtnet_sq {
 	bool do_dma;
 
 	struct virtnet_sq_dma_head dmainfo;
+	struct {
+		struct xsk_buff_pool __rcu *pool;
+
+		dma_addr_t hdr_dma_address;
+	} xsk;
 };
 
 /* Internal representation of a receive virtqueue */
@@ -134,6 +141,13 @@ struct virtnet_rq {
 
 	/* Do dma by self */
 	bool do_dma;
+
+	struct {
+		struct xsk_buff_pool __rcu *pool;
+
+		/* xdp rxq used by xsk */
+		struct xdp_rxq_info xdp_rxq;
+	} xsk;
 };
 
 struct virtnet_info {
@@ -218,6 +232,8 @@ struct virtnet_info {
 	struct failover *failover;
 };
 
+#include "xsk.h"
+
 static inline bool virtnet_is_xdp_frame(void *ptr)
 {
 	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
@@ -309,4 +325,6 @@ void virtnet_tx_pause(struct virtnet_info *vi, struct virtnet_sq *sq);
 void virtnet_tx_resume(struct virtnet_info *vi, struct virtnet_sq *sq);
 int virtnet_sq_set_premapped(struct virtnet_sq *sq);
 void virtnet_sq_unset_premapped(struct virtnet_sq *sq);
+void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
+void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
 #endif
diff --git a/drivers/net/virtio/xsk.c b/drivers/net/virtio/xsk.c
new file mode 100644
index 000000000000..adbaefb77480
--- /dev/null
+++ b/drivers/net/virtio/xsk.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * virtio-net xsk
+ */
+
+#include "virtio_net.h"
+
+static struct virtio_net_hdr_mrg_rxbuf xsk_hdr;
+
+static int virtnet_rq_bind_xsk_pool(struct virtnet_info *vi, struct virtnet_rq *rq,
+				    struct xsk_buff_pool *pool)
+{
+	int err, qindex;
+
+	qindex = rq - vi->rq;
+
+	if (pool) {
+		err = xdp_rxq_info_reg(&rq->xsk.xdp_rxq, vi->dev, qindex, rq->napi.napi_id);
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
+	virtnet_rx_pause(vi, rq);
+
+	err = virtqueue_reset(rq->vq, virtnet_rq_free_unused_buf);
+	if (err)
+		netdev_err(vi->dev, "reset rx fail: rx queue index: %d err: %d\n", qindex, err);
+
+	if (pool && err)
+		xdp_rxq_info_unreg(&rq->xsk.xdp_rxq);
+	else
+		rcu_assign_pointer(rq->xsk.pool, pool);
+
+	virtnet_rx_resume(vi, rq);
+
+	return err;
+}
+
+static int virtnet_sq_bind_xsk_pool(struct virtnet_info *vi,
+				    struct virtnet_sq *sq,
+				    struct xsk_buff_pool *pool)
+{
+	int err, qindex;
+
+	qindex = sq - vi->sq;
+
+	virtnet_tx_pause(vi, sq);
+
+	err = virtqueue_reset(sq->vq, virtnet_sq_free_unused_buf);
+	if (err)
+		netdev_err(vi->dev, "reset tx fail: tx queue index: %d err: %d\n", qindex, err);
+
+	if (pool) {
+		if (!err)
+			err = virtnet_sq_set_premapped(sq);
+
+		if (!err)
+			rcu_assign_pointer(sq->xsk.pool, pool);
+	} else {
+		rcu_assign_pointer(sq->xsk.pool, NULL);
+		virtnet_sq_unset_premapped(sq);
+	}
+
+	virtnet_tx_resume(vi, sq);
+
+	return err;
+}
+
+static int virtnet_xsk_pool_enable(struct net_device *dev,
+				   struct xsk_buff_pool *pool,
+				   u16 qid)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct virtnet_rq *rq;
+	struct virtnet_sq *sq;
+	struct device *dma_dev;
+	dma_addr_t hdr_dma;
+	int err;
+
+	/* In big_packets mode, xdp cannot work, so there is no need to
+	 * initialize xsk of rq.
+	 */
+	if (vi->big_packets && !vi->mergeable_rx_bufs)
+		return -ENOENT;
+
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
+	sq = &vi->sq[qid];
+	rq = &vi->rq[qid];
+
+	/* xsk tx zerocopy depend on the tx napi.
+	 *
+	 * All xsk packets are actually consumed and sent out from the xsk tx
+	 * queue under the tx napi mechanism.
+	 */
+	if (!sq->napi.weight)
+		return -EPERM;
+
+	if (!rq->do_dma)
+		return -EPERM;
+
+	if (virtqueue_dma_dev(rq->vq) != virtqueue_dma_dev(sq->vq))
+		return -EPERM;
+
+	dma_dev = virtqueue_dma_dev(rq->vq);
+	if (!dma_dev)
+		return -EPERM;
+
+	hdr_dma = dma_map_single(dma_dev, &xsk_hdr, vi->hdr_len, DMA_TO_DEVICE);
+	if (dma_mapping_error(dma_dev, hdr_dma))
+		return -ENOMEM;
+
+	err = xsk_pool_dma_map(pool, dma_dev, 0);
+	if (err)
+		goto err_xsk_map;
+
+	err = virtnet_rq_bind_xsk_pool(vi, rq, pool);
+	if (err)
+		goto err_rq;
+
+	err = virtnet_sq_bind_xsk_pool(vi, sq, pool);
+	if (err)
+		goto err_sq;
+
+	sq->xsk.hdr_dma_address = hdr_dma;
+
+	return 0;
+
+err_sq:
+	virtnet_rq_bind_xsk_pool(vi, rq, NULL);
+err_rq:
+	xsk_pool_dma_unmap(pool, 0);
+err_xsk_map:
+	dma_unmap_single(dma_dev, hdr_dma, vi->hdr_len, DMA_TO_DEVICE);
+	return err;
+}
+
+static int virtnet_xsk_pool_disable(struct net_device *dev, u16 qid)
+{
+	struct virtnet_info *vi = netdev_priv(dev);
+	struct device *dma_dev;
+	struct virtnet_rq *rq;
+	struct virtnet_sq *sq;
+	int err1, err2;
+
+	if (qid >= vi->curr_queue_pairs)
+		return -EINVAL;
+
+	sq = &vi->sq[qid];
+	rq = &vi->rq[qid];
+
+	dma_dev = virtqueue_dma_dev(rq->vq);
+
+	dma_unmap_single(dma_dev, sq->xsk.hdr_dma_address, vi->hdr_len, DMA_TO_DEVICE);
+
+	xsk_pool_dma_unmap(sq->xsk.pool, 0);
+
+	/* Sync with the XSK wakeup and with NAPI. */
+	synchronize_net();
+
+	err1 = virtnet_sq_bind_xsk_pool(vi, sq, NULL);
+	err2 = virtnet_rq_bind_xsk_pool(vi, rq, NULL);
+
+	return err1 | err2;
+}
+
+int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp)
+{
+	if (xdp->xsk.pool)
+		return virtnet_xsk_pool_enable(dev, xdp->xsk.pool,
+					       xdp->xsk.queue_id);
+	else
+		return virtnet_xsk_pool_disable(dev, xdp->xsk.queue_id);
+}
diff --git a/drivers/net/virtio/xsk.h b/drivers/net/virtio/xsk.h
new file mode 100644
index 000000000000..1918285c310c
--- /dev/null
+++ b/drivers/net/virtio/xsk.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __XSK_H__
+#define __XSK_H__
+
+int virtnet_xsk_pool_setup(struct net_device *dev, struct netdev_bpf *xdp);
+#endif
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
