Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243F04F1E3
	for <virtualization@lists.linux-foundation.org>; Tue, 26 Dec 2023 09:43:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A859380ED4
	for <virtualization@lists.linux-foundation.org>; Tue, 26 Dec 2023 09:43:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A859380ED4
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rbdIqCcx5coe
	for <virtualization@lists.linux-foundation.org>;
	Tue, 26 Dec 2023 09:43:41 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EEFA280EC9
	for <virtualization@lists.linux-foundation.org>; Tue, 26 Dec 2023 09:43:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEFA280EC9
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VzHM.FN_1703583814;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzHM.FN_1703583814)
          by smtp.aliyun-inc.com;
          Tue, 26 Dec 2023 17:43:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2] virtio_net: fix missing dma unmap for resize
Date: Tue, 26 Dec 2023 17:43:33 +0800
Message-Id: <20231226094333.47740-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 46e187200fab
Content-Transfer-Encoding: 8bit

For rq, we have three cases getting buffers from virtio core:

1. virtqueue_get_buf{,_ctx}
2. virtqueue_detach_unused_buf
3. callback for virtqueue_resize

But in commit 295525e29a5b("virtio_net: merge dma operations when
filling mergeable buffers"), I missed the dma unmap for the #3 case.

That will leak some memory, because I did not release the pages referred
by the unused buffers.

If we do such script, we will make the system OOM.

    while true
    do
            ethtool -G ens4 rx 128
            ethtool -G ens4 rx 256
            free -m
    done

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---

v2: rename to virtnet_rq_unmap_free_buf()

 drivers/net/virtio_net.c | 60 ++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index d16f592c2061..51b1868d2f22 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -334,7 +334,6 @@ struct virtio_net_common_hdr {
 	};
 };

-static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
 static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);

 static bool is_xdp_frame(void *ptr)
@@ -408,6 +407,17 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
 	return p;
 }

+static void virtnet_rq_free_buf(struct virtnet_info *vi,
+				struct receive_queue *rq, void *buf)
+{
+	if (vi->mergeable_rx_bufs)
+		put_page(virt_to_head_page(buf));
+	else if (vi->big_packets)
+		give_pages(rq, buf);
+	else
+		put_page(virt_to_head_page(buf));
+}
+
 static void enable_delayed_refill(struct virtnet_info *vi)
 {
 	spin_lock_bh(&vi->refill_lock);
@@ -634,17 +644,6 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 	return buf;
 }

-static void *virtnet_rq_detach_unused_buf(struct receive_queue *rq)
-{
-	void *buf;
-
-	buf = virtqueue_detach_unused_buf(rq->vq);
-	if (buf && rq->do_dma)
-		virtnet_rq_unmap(rq, buf, 0);
-
-	return buf;
-}
-
 static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
 {
 	struct virtnet_rq_dma *dma;
@@ -744,6 +743,20 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 	}
 }

+static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
+{
+	struct virtnet_info *vi = vq->vdev->priv;
+	struct receive_queue *rq;
+	int i = vq2rxq(vq);
+
+	rq = &vi->rq[i];
+
+	if (rq->do_dma)
+		virtnet_rq_unmap(rq, buf, 0);
+
+	virtnet_rq_free_buf(vi, rq, buf);
+}
+
 static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
 {
 	unsigned int len;
@@ -1764,7 +1777,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
 		pr_debug("%s: short packet %i\n", dev->name, len);
 		DEV_STATS_INC(dev, rx_length_errors);
-		virtnet_rq_free_unused_buf(rq->vq, buf);
+		virtnet_rq_free_buf(vi, rq, buf);
 		return;
 	}

@@ -2392,7 +2405,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	if (running)
 		napi_disable(&rq->napi);

-	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
+	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);

@@ -4031,19 +4044,6 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
 		xdp_return_frame(ptr_to_xdp(buf));
 }

-static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
-{
-	struct virtnet_info *vi = vq->vdev->priv;
-	int i = vq2rxq(vq);
-
-	if (vi->mergeable_rx_bufs)
-		put_page(virt_to_head_page(buf));
-	else if (vi->big_packets)
-		give_pages(&vi->rq[i], buf);
-	else
-		put_page(virt_to_head_page(buf));
-}
-
 static void free_unused_bufs(struct virtnet_info *vi)
 {
 	void *buf;
@@ -4057,10 +4057,10 @@ static void free_unused_bufs(struct virtnet_info *vi)
 	}

 	for (i = 0; i < vi->max_queue_pairs; i++) {
-		struct receive_queue *rq = &vi->rq[i];
+		struct virtqueue *vq = vi->rq[i].vq;

-		while ((buf = virtnet_rq_detach_unused_buf(rq)) != NULL)
-			virtnet_rq_free_unused_buf(rq->vq, buf);
+		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+			virtnet_rq_unmap_free_buf(vq, buf);
 		cond_resched();
 	}
 }
--
2.32.0.3.g01195cf9f

