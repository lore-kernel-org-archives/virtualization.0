Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DF51E130D
	for <virtualization@lists.linux.dev>; Wed, 30 Oct 2024 08:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730276707; cv=none; b=C/kv25bit1xL+8fM1uzD2BMQYU/xPjXcRCSdMU7bC5CGQcJZlBTPYTLZDzUpWzSySvPP5qJUpl4WBKgI53xcLLNM7KNgmndqSs390g36NzVXZXmqK/KXih4IqU2SxoGpnq6NsylbD6fgRfoTVxwr6By0mQkacMeHryq3w6RJHpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730276707; c=relaxed/simple;
	bh=KhTAe/lRtyEIDr7cN8FsaWuMEvCDcUBbLUgDo5HNyeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RyePSmW3EDhL1rQLydJnXYLrSJMIvJVOmmgytW0STDBBOudWV5j7mWKeeGgjMjBIMiv8pOeJ4D7luSqlC/N/awkq5wpDQiU00WVXgtEWTg/SW9//waRkDZzHipQXxKAEEozXAaWZQciFn+Ao0zn2FrPEwLK/irVIp1ZwnjunwT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nS9LaykQ; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nS9LaykQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730276701; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AwJI5xb/R/ouaxTo/m6B+dTZQr+oPsH0APB+pzG7M0U=;
	b=nS9LaykQ8HTiy+vDsXZq6YvlfervnKak71Pb6OX/gMf3dvcY9/XYgcbtU/hsG1k0qe7A/QEccEi+S7hvOpQqT8DH4F63LSR/bf3i6I0ynbPNw6WQYiidjpU7Mdg+hQAnbwJMp7O9mpaNugT7DWXWOb7D+AweNr8B5f6kyqfa32s=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIDQizY_1730276698 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Oct 2024 16:24:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
Subject: [PATCH net-next v2 05/13] virtio_ring: introduce add api for premapped
Date: Wed, 30 Oct 2024 16:24:45 +0800
Message-Id: <20241030082453.97310-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
References: <20241030082453.97310-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 87bfcb32ef14
Content-Transfer-Encoding: 8bit

Two APIs are introduced to submit premapped per-buffers.

int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
                                 struct scatterlist *sg, unsigned int num,
                                 void *data,
                                 void *ctx,
                                 bool premapped,
                                 gfp_t gfp);

int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
                                  struct scatterlist *sg, unsigned int num,
                                  void *data,
                                  bool premapped,
                                  gfp_t gfp);

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 48 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       | 13 ++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a89295b79e66..525308d82728 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2272,6 +2272,29 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
 
+/**
+ * virtqueue_add_outbuf_premapped - expose output buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg readable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
+				   struct scatterlist *sg, unsigned int num,
+				   void *data,
+				   bool premapped,
+				   gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, premapped, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_outbuf_premapped);
+
 /**
  * virtqueue_add_inbuf - expose input buffers to other end
  * @vq: the struct virtqueue we're talking about.
@@ -2318,6 +2341,31 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
 
+/**
+ * virtqueue_add_inbuf_premapped - expose input buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg writable by other side
+ * @data: the token identifying the buffer.
+ * @ctx: extra context for the token
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
+				  struct scatterlist *sg, unsigned int num,
+				  void *data,
+				  void *ctx,
+				  bool premapped,
+				  gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, premapped, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
+
 /**
  * virtqueue_dma_dev - get the dma dev
  * @_vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 306137a15d07..19afa49b92d0 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -56,6 +56,19 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 			    void *ctx,
 			    gfp_t gfp);
 
+int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
+				  struct scatterlist *sg, unsigned int num,
+				  void *data,
+				  void *ctx,
+				  bool premapped,
+				  gfp_t gfp);
+
+int virtqueue_add_outbuf_premapped(struct virtqueue *vq,
+				   struct scatterlist *sg, unsigned int num,
+				   void *data,
+				   bool premapped,
+				   gfp_t gfp);
+
 int virtqueue_add_sgs(struct virtqueue *vq,
 		      struct scatterlist *sgs[],
 		      unsigned int out_sgs,
-- 
2.32.0.3.g01195cf9f

