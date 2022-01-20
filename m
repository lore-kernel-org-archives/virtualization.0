Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A724C4332F
	for <virtualization@archiver.kernel.org>; Thu, 20 Jan 2022 06:43:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBE308291D;
	Thu, 20 Jan 2022 06:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zTXFbZakbOay; Thu, 20 Jan 2022 06:43:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3A8B982B34;
	Thu, 20 Jan 2022 06:43:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6C568C007C;
	Thu, 20 Jan 2022 06:43:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 77D56C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5DD0F82B3E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cdPkUqO5C7M3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3E63C82A8F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:21 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R941e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V2KlUeA_1642660996; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2KlUeA_1642660996) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 20 Jan 2022 14:43:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 12/12] virtio-net: support pair disable/enable
Date: Thu, 20 Jan 2022 14:43:03 +0800
Message-Id: <20220120064303.106639-13-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220120064303.106639-1-xuanzhuo@linux.alibaba.com>
References: <20220120064303.106639-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

This patch implements virtio-net rx/tx pair disable/enable functionality
based on virtio queue reset. The purpose of the current implementation
is to quickly recycle the buffer submitted to vq.

In the process of pair disable, in theory, as long as virtio supports
queue reset, there will be no exceptions.

However, in the process of pari enable, there may be exceptions due to
memory allocation. In this case, vq == NULL, but napi will still
be enabled. Because napi_disable is similar to a lock, napi_enable must
be called after calling napi_disable.

Since enable fails, the driver will not receive an interrupt from the
device to wake up napi, so the driver is safe. But we still need to add
vq checks in some places to ensure safety, such as refill_work().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 148 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index ea90a1a57c9e..dba95553247c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1369,6 +1369,9 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 {
 	napi_enable(napi);
 
+	if (!vq)
+		return;
+
 	/* If all buffers were filled by other side before we napi_enabled, we
 	 * won't get another interrupt, so process any outstanding packets now.
 	 * Call local_bh_enable after to trigger softIRQ processing.
@@ -1413,6 +1416,10 @@ static void refill_work(struct work_struct *work)
 		struct receive_queue *rq = &vi->rq[i];
 
 		napi_disable(&rq->napi);
+		if (!rq->vq) {
+			virtnet_napi_enable(rq->vq, &rq->napi);
+			continue;
+		}
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
 		virtnet_napi_enable(rq->vq, &rq->napi);
 
@@ -2871,6 +2878,147 @@ static unsigned int mergeable_min_buf_len(struct virtnet_info *vi, struct virtqu
 		   (unsigned int)GOOD_PACKET_LEN);
 }
 
+static void virtnet_rq_free_unused_buf_cb(struct virtio_device *vdev,
+					  void *buf, void *data)
+{
+	virtnet_rq_free_unused_buf(vdev->priv, data, buf);
+}
+
+static void virtnet_sq_free_unused_buf_cb(struct virtio_device *vdev,
+					  void *buf, void *data)
+{
+	virtnet_rq_free_unused_buf(vdev->priv, data, buf);
+}
+
+static int __virtnet_rx_vq_disable(struct virtnet_info *vi,
+				   struct receive_queue *rq)
+{
+	int err, qnum;
+
+	qnum = rxq2vq(rq - vi->rq);
+
+	napi_disable(&rq->napi);
+
+	err = virtio_reset_vq(vi->vdev, qnum, virtnet_rq_free_unused_buf_cb, rq);
+	if (err) {
+		virtnet_napi_enable(rq->vq, &rq->napi);
+		return err;
+	}
+
+	rq->vq = NULL;
+
+	return err;
+}
+
+static int __virtnet_tx_vq_disable(struct virtnet_info *vi,
+				   struct send_queue *sq)
+{
+	struct netdev_queue *txq;
+	int err, qnum;
+
+	qnum = txq2vq(sq - vi->sq);
+
+	netif_stop_subqueue(vi->dev, sq - vi->sq);
+	virtnet_napi_tx_disable(&sq->napi);
+
+	/* wait xmit done */
+	txq = netdev_get_tx_queue(vi->dev, qnum);
+	__netif_tx_lock(txq, raw_smp_processor_id());
+	__netif_tx_unlock(txq);
+
+	err = virtio_reset_vq(vi->vdev, qnum, virtnet_sq_free_unused_buf_cb, sq);
+	if (err) {
+		virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+		netif_start_subqueue(vi->dev, sq - vi->sq);
+		return err;
+	}
+
+	sq->vq = NULL;
+
+	return err;
+}
+
+static int virtnet_pair_disable(struct virtnet_info *vi, int i)
+{
+	int err;
+
+	err = __virtnet_rx_vq_disable(vi, vi->rq + i);
+	if (err)
+		return err;
+
+	return __virtnet_tx_vq_disable(vi, vi->sq + i);
+}
+
+static int virtnet_enable_resetq(struct virtnet_info *vi,
+				 struct receive_queue *rq,
+				 struct send_queue *sq)
+{
+	vq_callback_t *callback;
+	struct virtqueue *vq;
+	const char *name;
+	int vq_idx;
+	bool ctx;
+
+	if (rq) {
+		vq = rq->vq;
+		vq_idx = rxq2vq(rq - vi->rq);
+		callback = skb_recv_done;
+		name = rq->name;
+
+	} else {
+		vq = sq->vq;
+		vq_idx = txq2vq(sq - vi->sq);
+		callback = skb_xmit_done;
+		name = sq->name;
+	}
+
+	if (vq)
+		return -EBUSY;
+
+	if (!vi->big_packets || vi->mergeable_rx_bufs)
+		ctx = true;
+	else
+		ctx = false;
+
+	vq = virtio_enable_resetq(vi->vdev, vq_idx, callback, name, &ctx);
+	if (IS_ERR(vq))
+		return PTR_ERR(vq);
+
+	if (rq)
+		rq->vq = vq;
+	else
+		sq->vq = vq;
+
+	return 0;
+}
+
+static int virtnet_pair_enable(struct virtnet_info *vi, int i)
+{
+	struct receive_queue *rq;
+	struct send_queue *sq;
+	int err;
+
+	rq = vi->rq + i;
+	sq = vi->sq + i;
+
+	/* tx */
+	err = virtnet_enable_resetq(vi, NULL, sq);
+	if (err)
+		goto err;
+	else
+		netif_start_subqueue(vi->dev, sq - vi->sq);
+
+	/* rx */
+	err = virtnet_enable_resetq(vi, rq, NULL);
+	if (err)
+		return err;
+
+err:
+	virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+	virtnet_napi_enable(rq->vq, &rq->napi);
+	return 0;
+}
+
 static int virtnet_find_vqs(struct virtnet_info *vi)
 {
 	vq_callback_t **callbacks;
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
