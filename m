Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6029449
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 07:23:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F077B40179
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 07:23:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F077B40179
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G65qs5eEmizG
	for <virtualization@lists.linux-foundation.org>;
	Mon,  4 Dec 2023 07:23:39 +0000 (UTC)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 38D18401A1
	for <virtualization@lists.linux-foundation.org>; Mon,  4 Dec 2023 07:23:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38D18401A1
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VxkmuC4_1701674613;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VxkmuC4_1701674613)
          by smtp.aliyun-inc.com;
          Mon, 04 Dec 2023 15:23:33 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/4] virtio_ring: virtqueue_disable_and_recycle let the callback detach bufs
Date: Mon,  4 Dec 2023 15:23:29 +0800
Message-Id: <20231204072331.73776-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231204072331.73776-1-xuanzhuo@linux.alibaba.com>
References: <20231204072331.73776-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: a973224d7b9a
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
index 103d181f05bb..a30f7f8298cb 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2173,11 +2173,10 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
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
@@ -2193,8 +2192,7 @@ static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
 	if (err)
 		return err;
 
-	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
-		recycle(_vq, buf);
+	recycle(_vq);
 
 	return 0;
 }
@@ -2789,7 +2787,7 @@ EXPORT_SYMBOL_GPL(vring_create_virtqueue_dma);
  *
  */
 int virtqueue_resize(struct virtqueue *_vq, u32 num,
-		     void (*recycle)(struct virtqueue *vq, void *buf))
+		     void (*recycle)(struct virtqueue *vq))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	int err;
@@ -2880,7 +2878,7 @@ EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
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

