Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6451F1E49A
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 08:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2EA682F51
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 08:04:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2EA682F51
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gm5NA34TiF9p
	for <virtualization@lists.linux-foundation.org>;
	Thu,  7 Dec 2023 08:04:01 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 633AE81063
	for <virtualization@lists.linux-foundation.org>; Thu,  7 Dec 2023 08:04:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 633AE81063
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vy.5bgz_1701936235;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Vy.5bgz_1701936235)
          by smtp.aliyun-inc.com;
          Thu, 07 Dec 2023 16:03:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 2/5] virtio_ring: virtqueue_disable_and_recycle let the callback detach bufs
Date: Thu,  7 Dec 2023 16:03:50 +0800
Message-Id: <20231207080353.6575-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231207080353.6575-1-xuanzhuo@linux.alibaba.com>
References: <20231207080353.6575-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: b3688db07ee6
Content-Transfer-Encoding: 8bit

Now, inside virtqueue_disable_and_recycle, the recycle() just has two
parameters(vq, buf) after detach operate.

But if we are in premapped mode, we may need to get some dma info when
detach buf like virtqueue_get_buf_ctx_dma().

So we call recycle directly, this callback detaches bufs self. It should
complete the work of detaching all the unused buffers.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio/main.c    | 31 ++++++++++++++++++++++---------
 drivers/virtio/virtio_ring.c | 10 ++++------
 include/linux/virtio.h       |  4 ++--
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
index 0037c0bda0c1..d81ee75142e0 100644
--- a/drivers/net/virtio/main.c
+++ b/drivers/net/virtio/main.c
@@ -149,8 +149,8 @@ struct virtio_net_common_hdr {
 	};
 };
 
-static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
-static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
+static void virtnet_rq_free_unused_bufs(struct virtqueue *vq);
+static void virtnet_sq_free_unused_bufs(struct virtqueue *vq);
 
 static bool is_xdp_frame(void *ptr)
 {
@@ -2197,7 +2197,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
 	if (running)
 		napi_disable(&rq->napi);
 
-	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
+	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_bufs);
 	if (err)
 		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
 
@@ -2236,7 +2236,7 @@ static int virtnet_tx_resize(struct virtnet_info *vi,
 
 	__netif_tx_unlock_bh(txq);
 
-	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_buf);
+	err = virtqueue_resize(sq->vq, ring_num, virtnet_sq_free_unused_bufs);
 	if (err)
 		netdev_err(vi->dev, "resize tx fail: tx queue index: %d err: %d\n", qindex, err);
 
@@ -3850,22 +3850,35 @@ static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
 	virtnet_rq_free_buf(vi, rq, buf);
 }
 
-static void free_unused_bufs(struct virtnet_info *vi)
+static void virtnet_sq_free_unused_bufs(struct virtqueue *vq)
+{
+	void *buf;
+
+	while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+		virtnet_sq_free_unused_buf(vq, buf);
+}
+
+static void virtnet_rq_free_unused_bufs(struct virtqueue *vq)
 {
 	void *buf;
+
+	while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
+		virtnet_rq_free_unused_buf(vq, buf);
+}
+
+static void free_unused_bufs(struct virtnet_info *vi)
+{
 	int i;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->sq[i].vq;
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
-			virtnet_sq_free_unused_buf(vq, buf);
+		virtnet_sq_free_unused_bufs(vq);
 		cond_resched();
 	}
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		struct virtqueue *vq = vi->rq[i].vq;
-		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
-			virtnet_rq_free_unused_buf(vq, buf);
+		virtnet_rq_free_unused_bufs(vq);
 		cond_resched();
 	}
 }
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 3bcf3e6067af..42d28bee1294 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2194,11 +2194,10 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 }
 
 static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
-					 void (*recycle)(struct virtqueue *vq, void *buf))
+					 void (*recycle)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct virtio_device *vdev = vq->vq.vdev;
-	void *buf;
 	int err;
 
 	if (!vq->we_own_ring)
@@ -2214,8 +2213,7 @@ static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
 	if (err)
 		return err;
 
-	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
-		recycle(_vq, buf);
+	recycle(_vq);
 
 	return 0;
 }
@@ -2810,7 +2808,7 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
  *
  */
 int virtqueue_resize(struct virtqueue *_vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf))
+		     void (*recycle)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
@@ -2901,7 +2899,7 @@ EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
  * -EPERM: Operation not permitted
  */
 int virtqueue_reset(struct virtqueue *_vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf))
+		    void (*recycle)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 572aecec205b..7a5e9ea7d420 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -115,9 +115,9 @@ dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
 dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
 
 int virtqueue_resize(struct virtqueue *vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf));
+		     void (*recycle)(struct virtqueue *vq));
 int virtqueue_reset(struct virtqueue *vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf));
+		    void (*recycle)(struct virtqueue *vq));
 
 /**
  * struct virtio_device - representation of a device using virtio
-- 
2.32.0.3.g01195cf9f

