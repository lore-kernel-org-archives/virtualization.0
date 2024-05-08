Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37A9EAF0
	for <virtualization@lists.linux.dev>; Wed,  8 May 2024 02:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715135024; cv=none; b=kdi9h/dTEsVYhF5CUc4yCC8+a4APMQV6yHGJsnH1Fiu+YWtIet/RSZlJyOi+UbG+XWly9tH56oNMAdYP3sHE4YSfLyrvCRkuJaiUAcT2nq7TjgMq2cohIf0J2lNZLuIS2JZbibeExa5qV+vWGgewRwcLEa1qxPpb/f9ABSmpNmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715135024; c=relaxed/simple;
	bh=Ua6MmFtyWLBM+RkYjU3PVACyYS7R+vmMM2aRQ9xBNqA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CgkTEZ2xSrW764BnxoRbwB1I78dyAjXFP8CRHIo4DPmGbQKI+ts0aoestMfstfEBJZcW2UilTt3tn1V9z5oMXglXfIfjnQgDK1JNi4zwL/5STKbhUAq+3iSHFC9IjDWJNZE7YyPhdbcLc1CtSArgKEDmc/9oXlEKtIsHUulWV0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EcXQfE3e; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EcXQfE3e"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715135020; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EO7wn5Fu8gX5iQFZQOKzHSIik4RiTxHVbWyieF/rF/o=;
	b=EcXQfE3eG8+Rk7Gc7zRgma1Fhdlr0gfE2bAXQyQV0AHPwDDUYYjruReM3xBYM3qISm+pV4G1J0s4EmPyi71izplG+hP9I9oRh1CqZgI/l/h5eDl4Gd8DZuemXUo+Qo0E/1awxFc4JEmziKBSSux0HM0UnbZwwRiUBNa4DMA9m0A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W61rwQZ_1715135018;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W61rwQZ_1715135018)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 10:23:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH vhost 4/5] virtio_ring: virtqueue_set_dma_premapped() support to disable
Date: Wed,  8 May 2024 10:23:30 +0800
Message-Id: <20240508022331.63751-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240508022331.63751-1-xuanzhuo@linux.alibaba.com>
References: <20240508022331.63751-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: a0fef46c457b
Content-Transfer-Encoding: 8bit

virtio-net sq will only enable premapped mode when the sq is bound to
the af-xdp.

So we need the helper (virtqueue_set_dma_premapped) to enable the
premapped mode when af-xdp binds to the sq. And to disable the
premapped mode when af-xdp unbinds to the sq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c     | 2 +-
 drivers/virtio/virtio_ring.c | 7 ++++---
 include/linux/virtio.h       | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 3e8694837a29..a28a84101d5b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -795,7 +795,7 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		/* error never happen */
-		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
+		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq, true));
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index dab7f7fa8ec1..78145ad43370 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2712,8 +2712,9 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
 /**
  * virtqueue_set_dma_premapped - set the vring premapped mode
  * @_vq: the struct virtqueue we're talking about.
+ * @premapped: bool enable/disable the premapped mode
  *
- * Enable the premapped mode of the vq.
+ * Enable/disable the premapped mode of the vq.
  *
  * The vring in premapped mode does not do dma internally, so the driver must
  * do dma mapping in advance. The driver must pass the dma_address through
@@ -2730,7 +2731,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * 0: success.
  * -EINVAL: the vq is in use.
  */
-int virtqueue_set_dma_premapped(struct virtqueue *_vq)
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	u32 num;
@@ -2744,7 +2745,7 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
-	vq->premapped = true;
+	vq->premapped = premapped;
 
 	END_USE(vq);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 18694d201698..78687d9a8986 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -81,7 +81,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
-int virtqueue_set_dma_premapped(struct virtqueue *_vq);
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped);
 
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
-- 
2.32.0.3.g01195cf9f

