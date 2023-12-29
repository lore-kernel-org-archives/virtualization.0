Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6DBE64
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E83460A69
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E83460A69
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -9.899
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2tizXvIeh0sb
	for <virtualization@lists.linux-foundation.org>;
	Fri, 29 Dec 2023 07:31:24 +0000 (UTC)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 02FDB60A63
	for <virtualization@lists.linux-foundation.org>; Fri, 29 Dec 2023 07:31:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 02FDB60A63
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VzQsXtn_1703835078;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzQsXtn_1703835078)
          by smtp.aliyun-inc.com;
          Fri, 29 Dec 2023 15:31:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux-foundation.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 08/27] virtio_ring: introduce virtqueue_detach_unused_buf_dma()
Date: Fri, 29 Dec 2023 15:30:49 +0800
Message-Id: <20231229073108.57778-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
References: <20231229073108.57778-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 20112a26898d
Content-Transfer-Encoding: 8bit

introduce virtqueue_detach_unused_buf_dma() to collect the dma
info when get buf from virtio core for premapped mode.

If the virtio queue is premapped mode, the virtio-net send buf may
have many desc. Every desc dma address need to be unmap. So here we
introduce a new helper to collect the dma address of the buffer from
the virtio core.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 33 +++++++++++++++++++++++++--------
 include/linux/virtio.h       |  1 +
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b700d4e6e7dd..a2d6aea551a7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1012,7 +1012,7 @@ static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
 	return true;
 }
 
-static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
+static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq, struct virtio_dma_head *dma)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	unsigned int i;
@@ -1025,7 +1025,7 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 			continue;
 		/* detach_buf_split clears data, so grab it now. */
 		buf = vq->split.desc_state[i].data;
-		detach_buf_split(vq, i, NULL, NULL);
+		detach_buf_split(vq, i, dma, NULL);
 		vq->split.avail_idx_shadow--;
 		vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
 				vq->split.avail_idx_shadow);
@@ -1909,7 +1909,7 @@ static bool virtqueue_enable_cb_delayed_packed(struct virtqueue *_vq)
 	return true;
 }
 
-static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
+static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq, struct virtio_dma_head *dma)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	unsigned int i;
@@ -1922,7 +1922,7 @@ static void *virtqueue_detach_unused_buf_packed(struct virtqueue *_vq)
 			continue;
 		/* detach_buf clears data, so grab it now. */
 		buf = vq->packed.desc_state[i].data;
-		detach_buf_packed(vq, i, NULL, NULL);
+		detach_buf_packed(vq, i, dma, NULL);
 		END_USE(vq);
 		return buf;
 	}
@@ -2614,19 +2614,36 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *_vq)
 EXPORT_SYMBOL_GPL(virtqueue_enable_cb_delayed);
 
 /**
- * virtqueue_detach_unused_buf - detach first unused buffer
+ * virtqueue_detach_unused_buf_dma - detach first unused buffer
  * @_vq: the struct virtqueue we're talking about.
+ * @dma: the head of the array to store the dma info
+ *
+ * more see virtqueue_get_buf_ctx_dma()
  *
  * Returns NULL or the "data" token handed to virtqueue_add_*().
  * This is not valid on an active queue; it is useful for device
  * shutdown or the reset queue.
  */
-void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
+void *virtqueue_detach_unused_buf_dma(struct virtqueue *_vq, struct virtio_dma_head *dma)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq) :
-				 virtqueue_detach_unused_buf_split(_vq);
+	return vq->packed_ring ? virtqueue_detach_unused_buf_packed(_vq, dma) :
+				 virtqueue_detach_unused_buf_split(_vq, dma);
+}
+EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf_dma);
+
+/**
+ * virtqueue_detach_unused_buf - detach first unused buffer
+ * @_vq: the struct virtqueue we're talking about.
+ *
+ * Returns NULL or the "data" token handed to virtqueue_add_*().
+ * This is not valid on an active queue; it is useful for device
+ * shutdown or the reset queue.
+ */
+void *virtqueue_detach_unused_buf(struct virtqueue *_vq)
+{
+	return virtqueue_detach_unused_buf_dma(_vq, NULL);
 }
 EXPORT_SYMBOL_GPL(virtqueue_detach_unused_buf);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 7a5e9ea7d420..2596f0e7e395 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -104,6 +104,7 @@ bool virtqueue_poll(struct virtqueue *vq, unsigned);
 bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
 
 void *virtqueue_detach_unused_buf(struct virtqueue *vq);
+void *virtqueue_detach_unused_buf_dma(struct virtqueue *_vq, struct virtio_dma_head *dma);
 
 unsigned int virtqueue_get_vring_size(const struct virtqueue *vq);
 
-- 
2.32.0.3.g01195cf9f

