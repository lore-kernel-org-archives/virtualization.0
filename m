Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A908C14884C
	for <virtualization@lists.linux.dev>; Fri, 14 Jun 2024 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718347189; cv=none; b=LSOU8WwRQi3m1URgjyG+4d284yT4DxzBWFtpur5gyjAxbU2MEkpTkxF2vzJiulo3hxd8HoOz+Cx7GcrkgKIKDzWGqMwoE53OmNjOa/z+S00Uv8YxLmRjuZzDcWE4n70PDWTvFeeGYPCL/pqObyr0w9jzl+b+e4UklLNz0OcM6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718347189; c=relaxed/simple;
	bh=tcxopaJoD+u815bFN/f9f0HYtcCX8rUPp/jcsEYNy3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Plx+fqZ7cSi6Aoi+WUutg+hHSxLbDV2nlKNX6rN8e1cZ0TRSOnTLyHaQCHyo6EckAPsGorGz8dvaxLHK7PHxFzDURhvd189jrtCZU/72G/KkQE79/cl0l//nPeMmi/HzNT+GFwdubredtgkx1UIGLSAXJLIkCqi5kTTdWJrIMMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NASL+KsT; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NASL+KsT"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718347177; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TukRhtN8QeiEObGWmfADeZDtr0qZu2kwqlq7Wk+V02Y=;
	b=NASL+KsToaV+3ibjQmDWusJZlxMe7kFbekIghkSzC11dQqSwxdB/7J412vRGnSlpb5Bl6nBTVzHch2QsE3x9QjjhJKA7HmFrRjBcQ5/DpZ6DWo/uf3gcEOaJTPRP6S8PRg70GMo8ECOUd3/PXlF19DMm2tTVlzgyaHJISyPzWtk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W8QEk9._1718347176;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W8QEk9._1718347176)
          by smtp.aliyun-inc.com;
          Fri, 14 Jun 2024 14:39:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v5 03/15] virtio_ring: virtqueue_set_dma_premapped() support to disable
Date: Fri, 14 Jun 2024 14:39:21 +0800
Message-Id: <20240614063933.108811-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
References: <20240614063933.108811-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: e008fb4a0943
Content-Transfer-Encoding: 8bit

virtio-net sq will only enable premapped mode when sq is bound to
the af-xdp.

So we need the helper (virtqueue_set_dma_premapped) to enable the
premapped mode when af-xdp binds to sq. And to disable the
premapped mode when af-xdp unbinds to sq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/net/virtio_net.c     | 2 +-
 drivers/virtio/virtio_ring.c | 7 ++++---
 include/linux/virtio.h       | 2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 61a57d134544..838b450d9591 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -938,7 +938,7 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
 
 	for (i = 0; i < vi->max_queue_pairs; i++)
 		/* error should never happen */
-		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
+		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq, true));
 }
 
 static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index d0d3004a408a..12083a0e6052 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2764,8 +2764,9 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
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
@@ -2782,7 +2783,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * 0: success.
  * -EINVAL: too late to enable premapped mode, the vq already contains buffers.
  */
-int virtqueue_set_dma_premapped(struct virtqueue *_vq)
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	u32 num;
@@ -2796,7 +2797,7 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
-	vq->premapped = true;
+	vq->premapped = premapped;
 
 	END_USE(vq);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index ca318a66a7e1..69677d02cee9 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -81,7 +81,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
-int virtqueue_set_dma_premapped(struct virtqueue *_vq);
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped);
 
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
-- 
2.32.0.3.g01195cf9f

