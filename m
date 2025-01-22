Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C080A2147F0
	for <virtualization@lists.linux.dev>; Wed, 22 Jan 2025 16:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737563548; cv=none; b=RHqOOJnJi2kEq4lrOY9mQ1XKIPRvHbDilzOF/kZn/u5aGIK3KnDMnjru8yO9ys9aapTdFTIAxmvnvK8k2QfhsSDcCwf54/lDqHdcgLvhVT8T8TEdPedOr6dcmRyL2vgGN6rDNGIoUIgQlnl5sNX+6xWnqYwq4Sj7jHV7q8jrxgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737563548; c=relaxed/simple;
	bh=ZlbE/d+pbx5+isF5hTQ7Q++2uR8O3le1c5Qu/3Q+H1U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nf6LFosGc+2Lr5nIfAf9/V7ra61NhGnGgHwwsyJyO4xfZf25uqJphXA1er+GEtP50lkOFQXxoujNb69CEJHvy8CNMhGJ2AZUi0plseLgeST7j5q22KSchnBvDwpjSCA7ta1GJxmhA08cNzYZtE1uJ5ry2afgTfCX14gSgkw9l5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ml7qSE6E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ml7qSE6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737563545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xJfPPp9bY+23oh9myB6MDTLZ3jwDQSLQ73GW6TX4SXI=;
	b=Ml7qSE6Ehz3x4RLQERZJSTg0NQHf35/V9TfxJIHeeuSk+jcvCV3yZPzbhuNja4XkivSXSJ
	a4HNFntI8sYjCGfg1H6E7x1uzM1d8w9yvCZrjMDsusChL74ax/67wgLUZJ4ugxunfmGZzT
	1NOBi8dh2GMlBtxpb97Gibth0EywNWg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-x0OwsLZmNNytEKd1bLDm8w-1; Wed,
 22 Jan 2025 11:32:21 -0500
X-MC-Unique: x0OwsLZmNNytEKd1bLDm8w-1
X-Mimecast-MFC-AGG-ID: x0OwsLZmNNytEKd1bLDm8w
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B60FC1956087;
	Wed, 22 Jan 2025 16:32:19 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.193.171])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E98A9195E3E0;
	Wed, 22 Jan 2025 16:32:14 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: linux-kernel@vger.kernel.org,
	mst@redhat.com,
	Hanna Reitz <hreitz@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jason Wang <jasowang@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	German Maglione <gmaglione@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	virtualization@lists.linux.dev
Subject: [RFC 4/5] virtio_ring: add virtqueue premapped out/in buffers support
Date: Wed, 22 Jan 2025 17:31:53 +0100
Message-ID: <20250122163154.1225353-5-eperezma@redhat.com>
In-Reply-To: <20250122163154.1225353-1-eperezma@redhat.com>
References: <20250122163154.1225353-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Convenience function to add chains that mixes out and in buffers.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 drivers/virtio/virtio_ring.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  7 +++++++
 2 files changed, 42 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 05729bc5cbb1..e49912fa77c5 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2385,6 +2385,41 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 					out_sgs, in_sgs, data, ctx, premapped, gfp);
 }
 
+/**
+ * virtqueue_add_sgs_premapped - expose buffers to other end
+ * @_vq: the struct virtqueue we're talking about.
+ * @sgs: array of terminated scatterlists.
+ * @out_sgs: the number of scatterlists readable by other side
+ * @in_sgs: the number of scatterlists which are writable (after readable ones)
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_sgs_premapped(struct virtqueue *_vq,
+				struct scatterlist *sgs[],
+				unsigned int out_sgs,
+				unsigned int in_sgs,
+				void *data,
+				gfp_t gfp)
+{
+	unsigned int i, total_sg = 0;
+
+	/* Count them first. */
+	for (i = 0; i < out_sgs + in_sgs; i++) {
+		struct scatterlist *sg;
+
+		for (sg = sgs[i]; sg; sg = sg_next(sg))
+			total_sg++;
+	}
+	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs,
+			     data, NULL, true, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_sgs_premapped);
+
 /**
  * virtqueue_add_sgs - expose buffers to other end
  * @_vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 28db998d691e..de52a0f6f734 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -84,6 +84,13 @@ int virtqueue_add_sgs(struct virtqueue *vq,
 		      void *data,
 		      gfp_t gfp);
 
+int virtqueue_add_sgs_premapped(struct virtqueue *vq,
+				struct scatterlist *sgs[],
+				unsigned int out_sgs,
+				unsigned int in_sgs,
+				void *data,
+				gfp_t gfp);
+
 struct device *virtqueue_dma_dev(struct virtqueue *vq);
 
 bool virtqueue_kick(struct virtqueue *vq);
-- 
2.48.1

