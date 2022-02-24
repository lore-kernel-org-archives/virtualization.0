Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF15C433EF
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 08:12:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A029F40908;
	Thu, 24 Feb 2022 08:12:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wux3gQqd_A7X; Thu, 24 Feb 2022 08:12:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EEFF6409EA;
	Thu, 24 Feb 2022 08:12:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6318AC0037;
	Thu, 24 Feb 2022 08:12:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 31E83C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:12:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2078F41677
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:12:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FfXaHdYbepYT
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 270C8416C6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:58 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R231e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=34; SR=0; TI=SMTPD_---0V5NJNIP_1645690312; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V5NJNIP_1645690312) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Feb 2022 16:11:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 24/26] virtio_net: support rx/tx queue reset
Date: Thu, 24 Feb 2022 16:11:00 +0800
Message-Id: <20220224081102.80224-25-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220224081102.80224-1-xuanzhuo@linux.alibaba.com>
References: <20220224081102.80224-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: bd1c915e263f
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

This patch implements the reset function of the rx, tx queues.

Based on this function, it is possible to modify the ring num of the
queue. And quickly recycle the buffer in the queue.

In the process of the queue disable, in theory, as long as virtio
supports queue reset, there will be no exceptions.

However, in the process of the queue enable, there may be exceptions due to
memory allocation.  In this case, vq is not available, but we still have
to execute napi_enable(). Because napi_disable is similar to a lock,
napi_enable must be called after calling napi_disable.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 107 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 409a8e180918..ffff323dcef0 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -251,6 +251,11 @@ struct padded_vnet_hdr {
 	char padding[4];
 };
 
+static void virtnet_sq_free_unused_bufs(struct virtnet_info *vi,
+					struct send_queue *sq);
+static void virtnet_rq_free_unused_bufs(struct virtnet_info *vi,
+					struct receive_queue *rq);
+
 static bool is_xdp_frame(void *ptr)
 {
 	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
@@ -1369,6 +1374,9 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 {
 	napi_enable(napi);
 
+	if (vq->reset)
+		return;
+
 	/* If all buffers were filled by other side before we napi_enabled, we
 	 * won't get another interrupt, so process any outstanding packets now.
 	 * Call local_bh_enable after to trigger softIRQ processing.
@@ -1413,6 +1421,10 @@ static void refill_work(struct work_struct *work)
 		struct receive_queue *rq = &vi->rq[i];
 
 		napi_disable(&rq->napi);
+		if (rq->vq->reset) {
+			virtnet_napi_enable(rq->vq, &rq->napi);
+			continue;
+		}
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
 		virtnet_napi_enable(rq->vq, &rq->napi);
 
@@ -1523,6 +1535,9 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 	if (!sq->napi.weight || is_xdp_raw_buffer_queue(vi, index))
 		return;
 
+	if (sq->vq->reset)
+		return;
+
 	if (__netif_tx_trylock(txq)) {
 		do {
 			virtqueue_disable_cb(sq->vq);
@@ -1769,6 +1784,98 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static int virtnet_rx_vq_reset(struct virtnet_info *vi,
+			       struct receive_queue *rq, u32 ring_num)
+{
+	int err;
+
+	/* stop napi */
+	napi_disable(&rq->napi);
+
+	/* reset the queue */
+	err = virtio_reset_vq(rq->vq);
+	if (err)
+		goto err;
+
+	/* free bufs */
+	virtnet_rq_free_unused_bufs(vi, rq);
+
+	/* reset vring. */
+	err = virtqueue_reset_vring(rq->vq, ring_num);
+	if (err)
+		goto err;
+
+	/* enable reset queue */
+	err = virtio_enable_resetq(rq->vq);
+	if (err)
+		goto err;
+
+	/* fill recv */
+	if (!try_fill_recv(vi, rq, GFP_KERNEL))
+		schedule_delayed_work(&vi->refill, 0);
+
+	/* enable napi */
+	virtnet_napi_enable(rq->vq, &rq->napi);
+	return 0;
+
+err:
+	netdev_err(vi->dev,
+		   "reset rx reset vq fail: rx queue index: %ld err: %d\n",
+		   rq - vi->rq, err);
+	virtnet_napi_enable(rq->vq, &rq->napi);
+	return err;
+}
+
+static int virtnet_tx_vq_reset(struct virtnet_info *vi,
+			       struct send_queue *sq, u32 ring_num)
+{
+	struct netdev_queue *txq;
+	int err, qindex;
+
+	qindex = sq - vi->sq;
+
+	txq = netdev_get_tx_queue(vi->dev, qindex);
+	__netif_tx_lock_bh(txq);
+
+	/* stop tx queue and napi */
+	netif_stop_subqueue(vi->dev, qindex);
+	virtnet_napi_tx_disable(&sq->napi);
+
+	__netif_tx_unlock_bh(txq);
+
+	/* reset the queue */
+	err = virtio_reset_vq(sq->vq);
+	if (err) {
+		netif_start_subqueue(vi->dev, qindex);
+		goto err;
+	}
+
+	/* free bufs */
+	virtnet_sq_free_unused_bufs(vi, sq);
+
+	/* reset vring. */
+	err = virtqueue_reset_vring(sq->vq, ring_num);
+	if (err)
+		goto err;
+
+	/* enable reset queue */
+	err = virtio_enable_resetq(sq->vq);
+	if (err)
+		goto err;
+
+	/* start tx queue and napi */
+	netif_start_subqueue(vi->dev, qindex);
+	virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+	return 0;
+
+err:
+	netdev_err(vi->dev,
+		   "reset tx reset vq fail: tx queue index: %ld err: %d\n",
+		   sq - vi->sq, err);
+	virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+	return err;
+}
+
 /*
  * Send command via the control virtqueue and check status.  Commands
  * supported by the hypervisor, as indicated by feature bits, should
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
