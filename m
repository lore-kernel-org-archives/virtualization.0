Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA04C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 03:45:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B7220607EC;
	Wed,  6 Apr 2022 03:45:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7RMIn5CDDlga; Wed,  6 Apr 2022 03:45:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4A274610C0;
	Wed,  6 Apr 2022 03:45:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23215C002C;
	Wed,  6 Apr 2022 03:45:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 53B48C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3FEFC417CD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:45:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rumwx2Tg2B9G
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:45:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0BB0E417CB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:45:00 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=34; SR=0; TI=SMTPD_---0V9KCOR._1649216693; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V9KCOR._1649216693) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 06 Apr 2022 11:44:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v9 31/32] virtio_net: support rx/tx queue resize
Date: Wed,  6 Apr 2022 11:43:45 +0800
Message-Id: <20220406034346.74409-32-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 881cb3483d12
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
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
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

This patch implements the resize function of the rx, tx queues.
Based on this function, it is possible to modify the ring num of the
queue.

There may be an exception during the resize process, the resize may
fail, or the vq can no longer be used. Either way, we must execute
napi_enable(). Because napi_disable is similar to a lock, napi_enable
must be called after calling napi_disable.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c | 81 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b8bf00525177..ba6859f305f7 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -251,6 +251,9 @@ struct padded_vnet_hdr {
 	char padding[4];
 };
 
+static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
+static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
+
 static bool is_xdp_frame(void *ptr)
 {
 	return (unsigned long)ptr & VIRTIO_XDP_FLAG;
@@ -1369,6 +1372,15 @@ static void virtnet_napi_enable(struct virtqueue *vq, struct napi_struct *napi)
 {
 	napi_enable(napi);
 
+	/* Check if vq is in reset state. The normal reset/resize process will
+	 * be protected by napi. However, the protection of napi is only enabled
+	 * during the operation, and the protection of napi will end after the
+	 * operation is completed. If re-enable fails during the process, vq
+	 * will remain unavailable with reset state.
+	 */
+	if (vq->reset)
+		return;
+
 	/* If all buffers were filled by other side before we napi_enabled, we
 	 * won't get another interrupt, so process any outstanding packets now.
 	 * Call local_bh_enable after to trigger softIRQ processing.
@@ -1413,6 +1425,15 @@ static void refill_work(struct work_struct *work)
 		struct receive_queue *rq = &vi->rq[i];
 
 		napi_disable(&rq->napi);
+
+		/* Check if vq is in reset state. See more in
+		 * virtnet_napi_enable()
+		 */
+		if (rq->vq->reset) {
+			virtnet_napi_enable(rq->vq, &rq->napi);
+			continue;
+		}
+
 		still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
 		virtnet_napi_enable(rq->vq, &rq->napi);
 
@@ -1523,6 +1544,10 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
 	if (!sq->napi.weight || is_xdp_raw_buffer_queue(vi, index))
 		return;
 
+	/* Check if vq is in reset state. See more in virtnet_napi_enable() */
+	if (sq->vq->reset)
+		return;
+
 	if (__netif_tx_trylock(txq)) {
 		do {
 			virtqueue_disable_cb(sq->vq);
@@ -1769,6 +1794,62 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 }
 
+static int virtnet_rx_resize(struct virtnet_info *vi,
+			     struct receive_queue *rq, u32 ring_num)
+{
+	int err;
+
+	napi_disable(&rq->napi);
+
+	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
+	if (err)
+		goto err;
+
+	if (!try_fill_recv(vi, rq, GFP_KERNEL))
+		schedule_delayed_work(&vi->refill, 0);
+
+	virtnet_napi_enable(rq->vq, &rq->napi);
+	return 0;
+
+err:
+	netdev_err(vi->dev,
+		   "reset rx reset vq fail: rx queue index: %td err: %d\n",
+		   rq - vi->rq, err);
+	virtnet_napi_enable(rq->vq, &rq->napi);
+	return err;
+}
+
+static int virtnet_tx_resize(struct virtnet_info *vi,
+			     struct send_queue *sq, u32 ring_num)
+{
+	struct netdev_queue *txq;
+	int err, qindex;
+
+	qindex = sq - vi->sq;
+
+	virtnet_napi_tx_disable(&sq->napi);
+
+	txq = netdev_get_tx_queue(vi->dev, qindex);
+	__netif_tx_lock_bh(txq);
+	netif_stop_subqueue(vi->dev, qindex);
+	__netif_tx_unlock_bh(txq);
+
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
+	if (err)
+		goto err;
+
+	netif_start_subqueue(vi->dev, qindex);
+	virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
+	return 0;
+
+err:
+	netdev_err(vi->dev,
+		   "reset tx reset vq fail: tx queue index: %td err: %d\n",
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
