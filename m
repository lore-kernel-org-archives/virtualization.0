Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB031863F
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8CA404064E
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 11:31:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8CA404064E
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rwDljqE_XDRA
	for <virtualization@lists.linux-foundation.org>;
	Tue, 14 Nov 2023 11:31:14 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C1874400EA
	for <virtualization@lists.linux-foundation.org>; Tue, 14 Nov 2023 11:31:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1874400EA
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VwPQ82h_1699961466;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VwPQ82h_1699961466)
          by smtp.aliyun-inc.com;
          Tue, 14 Nov 2023 19:31:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Subject: [RFC 2/4] virtio_ring: virtqueue_disable_and_recycle let the callback detach bufs
Date: Tue, 14 Nov 2023 19:31:02 +0800
Message-Id: <20231114113104.33994-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com>
References: <20231114113104.33994-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 52aa29c00172
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
index 46a8be0c609c..57cbd449637a 100644
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
index 0b3caee4ef9d..18f021095afd 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2197,11 +2197,10 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
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
@@ -2217,8 +2216,7 @@ static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
 	if (err)
 		return err;
 
-	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
-		recycle(_vq, buf);
+	recycle(_vq);
 
 	return 0;
 }
@@ -2814,7 +2812,7 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
  *
  */
 int virtqueue_resize(struct virtqueue *_vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf))
+		     void (*recycle)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
@@ -2905,7 +2903,7 @@ EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
  * -EPERM: Operation not permitted
  */
 int virtqueue_reset(struct virtqueue *_vq,
-		    void (*recycle)(struct virtqueue *vq, void *buf))
+		    void (*recycle)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 0b919786ade5..225271940223 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -101,9 +101,9 @@ dma_addr_t virtqueue_get_avail_addr(const struct virtqueue *vq);
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

