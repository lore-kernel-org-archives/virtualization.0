Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF5F15EFBD
	for <virtualization@lists.linux.dev>; Mon, 25 Mar 2024 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711356885; cv=none; b=ONPfGEXEKxPZMFi4xXckOfxhl9GyYCePaqHkcCp223l3hCzYQrv8eTbHYg6RDptiIf3hGKKwSepTG1Qj3BgdQgz34InGDVHFSDn8z0twicnaWQXVqslFQ0/dpFGcfXka2qPLnJftXW8WUrLOCyOmT72uVAPNyDl6OTzXeLyqZ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711356885; c=relaxed/simple;
	bh=PenURxLjJqQVuVFEQ4m9LeQUvZgE4pnwCHNO6ibq9bY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LS68twVhk3gCVdI98+hxHqIYMldHzGAvtcqeOy8CmWzkb98s7p2G+KO7oVAbAX3073n+SWctc3vUf9MPNVqLDG+bZFJdrAajF53UTce8kQ56shxic3DMfKtSXmcJfnXd++zIVnGs/zzDQoYoKQU5Q/aQ4dSRKwtVTfaD+Kq+kMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=a8IQyreF; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="a8IQyreF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711356880; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NIMwk14M2PMyID2sN7g5BjYmL2dIHvJ1tq5lXY8RhzI=;
	b=a8IQyreFFd/LYKX1ODc5L0gXURqL1XFhPzvfAJuhIKuukRCyQxB1a/FnuB8eaS+QViN6VZZjJhRLDG9rV5yR5p1xS0pLB7J9ca7Fn0CFRYbUk03UMe4emv3sbaxwOraWuWxxkMNMuuvnSScgg3wHGu0yGoMjrJu2E3vhK55pVIk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3DMz-k_1711356878;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W3DMz-k_1711356878)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 16:54:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH vhost v5 10/10] virtio_ring: virtqueue_set_dma_premapped support disable
Date: Mon, 25 Mar 2024 16:54:28 +0800
Message-Id: <20240325085428.7275-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
References: <20240325085428.7275-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 630d711f51f7
Content-Transfer-Encoding: 8bit

Now, the API virtqueue_set_dma_premapped just support to
enable premapped mode.

If we allow enabling the premapped dynamically, we should
make this API to support disable the premapped mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 39 +++++++++++++++++++++++++++---------
 include/linux/virtio.h       |  2 +-
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 86a60c720a62..6ddabf280218 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2792,6 +2792,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
 /**
  * virtqueue_set_dma_premapped - set the vring premapped mode
  * @_vq: the struct virtqueue we're talking about.
+ * @premapped: enable/disable the premapped mode.
  *
  * Enable the premapped mode of the vq.
  *
@@ -2808,11 +2809,15 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  *
  * Returns zero or a negative error.
  * 0: success.
- * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
+ * -EINVAL:
+ *	vring does not use the dma api, so we can not enable premapped mode.
+ *	Or some descs are used, this is not called immediately after creating
+ *	the vq, or after vq reset.
  */
-int virtqueue_set_dma_premapped(struct virtqueue *_vq)
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
+	int err = 0;
 	u32 num;
 
 	START_USE(vq);
@@ -2824,24 +2829,40 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 		return -EINVAL;
 	}
 
+	if (vq->vq.premapped == premapped) {
+		END_USE(vq);
+		return 0;
+	}
+
 	if (!vq->use_dma_api) {
 		END_USE(vq);
 		return -EINVAL;
 	}
 
-	vq->vq.premapped = true;
+	if (premapped) {
+		vq->vq.premapped = true;
+
+		if (vq->packed_ring) {
+			kfree(vq->packed.desc_dma);
+			vq->packed.desc_dma = NULL;
+		} else {
+			kfree(vq->split.desc_dma);
+			vq->split.desc_dma = NULL;
+		}
 
-	if (vq->packed_ring) {
-		kfree(vq->packed.desc_dma);
-		vq->packed.desc_dma = NULL;
 	} else {
-		kfree(vq->split.desc_dma);
-		vq->split.desc_dma = NULL;
+		if (vq->packed_ring)
+			err = vring_alloc_dma_split(&vq->split, false);
+		else
+			err = vring_alloc_dma_packed(&vq->packed, false);
+
+		if (!err)
+			vq->vq.premapped = false;
 	}
 
 	END_USE(vq);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
 
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 407277d5a16b..4b338590abf4 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -82,7 +82,7 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
-int virtqueue_set_dma_premapped(struct virtqueue *_vq);
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped);
 
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
-- 
2.32.0.3.g01195cf9f

