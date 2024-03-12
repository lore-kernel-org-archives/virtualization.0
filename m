Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8842D45028
	for <virtualization@lists.linux.dev>; Tue, 12 Mar 2024 03:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710214573; cv=none; b=k50RwFQ5C5mG5MtJw9bq9UKVacTHhcDBHW/RdzCBnuD42dypx82oVvPQtJu4xUw/4hSxkr20XPhHTSN5EezPAoENUiD7+4Py515rrAhFEBLmQJAqAUedLahj/HD2P3C0FU06DoNksrk0/NfFly4+VLiqMvTyJsmRhAbmPt2kfA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710214573; c=relaxed/simple;
	bh=aG6c01EHqsqfJMf02YwBsTzGgsVAiUSX23A+XdzIku8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O6zduHw7tFfAa8GhNbOcxwsvSMmwHyTCMnpEZ+7ZfT9ctk0VoK7mVoJxEmtz5Ta12ianN2LuR3QlaS/P1MXE1Yg9gceDQ6vQO0psh6P80I+vOqlnIQ2vmhL2Q2ioYp0KImUW+dgg6DWvXZMmFRXCQZO3wpiCjlgb0kg8+hC+hEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LePN0BXt; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LePN0BXt"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710214569; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CNJclvBe1ycxAz95UGG5f9IA7KuXyObb8tOK4Xy4Kg0=;
	b=LePN0BXtV3FxqCjAd8zl5Nn7bL6OXHzKw37Amj7lVkx8jjYWcd9n4IVxVCI8HXKFeTlgN8cEMwImhe7XNA5Htetbum5KKKiSTpHqNGg7+8gijzaEXOPAgCcDIvgv8P8MYxoe/Pt8ijTt6timNn32MQOrhXY38f9nY9TPu4CZn4U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W2KOifi_1710214567;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W2KOifi_1710214567)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 11:36:08 +0800
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
Subject: [PATCH vhost v4 10/10] virtio_ring: virtqueue_set_dma_premapped support disable
Date: Tue, 12 Mar 2024 11:35:57 +0800
Message-Id: <20240312033557.6351-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
References: <20240312033557.6351-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 89bc1d4948eb
Content-Transfer-Encoding: 8bit

Now, the API virtqueue_set_dma_premapped just support to
enable premapped mode.

If we allow enabling the premapped dynamically, we should
make this API to support disable the premapped mode.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 34 ++++++++++++++++++++++++++--------
 include/linux/virtio.h       |  2 +-
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 34f4b2c0c31e..3bf69cae4965 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2801,6 +2801,7 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
 /**
  * virtqueue_set_dma_premapped - set the vring premapped mode
  * @_vq: the struct virtqueue we're talking about.
+ * @premapped: enable/disable the premapped mode.
  *
  * Enable the premapped mode of the vq.
  *
@@ -2819,9 +2820,10 @@ EXPORT_SYMBOL_GPL(virtqueue_resize);
  * 0: success.
  * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
  */
-int virtqueue_set_dma_premapped(struct virtqueue *_vq)
+int virtqueue_set_dma_premapped(struct virtqueue *_vq, bool premapped)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
+	int err = 0;
 	u32 num;
 
 	START_USE(vq);
@@ -2833,24 +2835,40 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
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

