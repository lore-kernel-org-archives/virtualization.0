Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217411;
	b=VOTmzpDjB3VYslGSCSNKMpLm7Zi3bP/lbycjN6zp0Z9irrFvBpZG5HaH9z4x+grEkCEJ
	 FDCz5kC3vBw8WkAQSYUpH43BqAQuY/mdLHaceU4t6xw0oKFr9tQ+oijC5dH576Z8ydtaB
	 LOozHecxnPORpBu1TWEnDooD+dDmddARZ3GAgnSr4G+Ku6LxoxTkNyspHLlu5zajzrjnd
	 A79actKd8X0SijbNA3LOg6eJrMgZT9jHCOja8qboj75DLvpnMfs0TRy9GVHrn3Va0lxus
	 TH26oweKT30ob2Lh0RGm3GoqfSk5c7duUXmw8QuBwcmLEvDCoAy4waM2a2n3OYMWIlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217411;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=nXAH+OU9RqM5dRAWXG7ExEKpjcRp36K9MyANZBxAazs=;
	b=iVtrTdMGEZR2sBzzPe1+c6wcbTze4fywMjf233dmnlsa6SJ0Ecs2vTG62NcXYJkipDKh
	 z0UVHpE8ite/+qRB4Z4L34uKBvOgGPlRwhf5MWWc3nSsD3iez5jrHXhuPuILhxMuhiqhy
	 2AWS65ar8T8e5IV4ge6k8oDLrqPnff/rb2nRT0ZYQLBuEfbtmdVbEouHHU3R2oyRoxs0B
	 BRIZ4T9WVAIqCeHpi6f5QcmGDEMI+wKLrpNf0OhLpmQ5CGCCNXCUddCh3g+bHY1nD3zzp
	 DwaWjHHeqOX0mBJd+Acyvyo3e6YgAjhH+yaPEcpIfVwxxCM6cNRCmovxwW8+yJUr5pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hSE3cG+M;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD1606A31C
	for <virtualization@lists.linux.dev>; Mon,  9 Nov 2026 09:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8DD1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=hSE3cG+M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nX
	AH+OU9RqM5dRAWXG7ExEKpjcRp36K9MyANZBxAazs=; b=hSE3cG+MfLLbFxCrQx
	BkegqjPlQx2fmJOhAOyLxP1vpj/AF51qIPbthFlT6tpL251zcqmKvKBn2cwwHRxW
	gX5cAO/23UYvyjoWD2/Wj+p7BsZoUnV3Qe/DXwuJLonBIMuRW7sd8PwTbjsFNGaf
	kF8l4IVbYYuI7PCccL6n5+MEs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBHJCGvlfFq58sxGQ--.4049S3;
	Mon, 09 Nov 2026 17:43:12 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org,
	eperezma@redhat.com,
	jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: [PATCH 1/3] virtio: add virtqueue_get_last_used_idx() helper
Date: Mon,  9 Nov 2026 17:43:08 +0800
Message-Id: <20261109094310.103979-2-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261109094310.103979-1-lange_tang@163.com>
References: <20261109094310.103979-1-lange_tang@163.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBHJCGvlfFq58sxGQ--.4049S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4UWF48GF4rtFW3JFWxCrg_yoW5Aw4DpF
	4DKrWUtrWkGFWxZFyfWF4qvrnI9wsrGw13KrWxuw1DuF98tFyq9F1j9w1rJr1fAr4kC34x
	Zrs0grZ8KF1DuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0a0PUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC-hCo1mrxlbBWIQAA3Z

From: Longjun Tang <tanglongjun@kylinos.cn>

Export a read-only accessor for the last consumed used ring index.
It's useful for drivers that need to detect whether the device has
produced buffers that have not been consumed yet, by passing the
returned value to virtqueue_poll().

The split ring now writes the field with WRITE_ONCE() (the packed
ring already did) to document that the new reader can run concurrently
with the poll path.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 drivers/virtio/virtio_ring.c | 18 ++++++++++++++++--
 include/linux/virtio.h       |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index db678f5a80e0..6d8485c73881 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1001,7 +1001,7 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
 	/* detach_buf_split clears data, so grab it now. */
 	ret = vq->split.desc_state[i].data;
 	detach_buf_split(vq, i, ctx);
-	vq->last_used_idx++;
+	WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1);
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call. */
@@ -1068,7 +1068,7 @@ static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtqueue *vq,
 	ret = vq->split.desc_state[last_used].data;
 	detach_buf_split_in_order(vq, last_used, ctx);
 
-	vq->last_used_idx++;
+	WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1);
 	vq->last_used += (vq->vq.num_free - num_free);
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
@@ -3227,6 +3227,20 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
 
+/**
+ * virtqueue_get_last_used_idx - get the last consumed used ring index
+ * @_vq: the struct virtqueue we're talking about.
+ *
+ * Returns the index of the most recently consumed used buffer.
+ */
+unsigned int virtqueue_get_last_used_idx(const struct virtqueue *_vq)
+{
+	const struct vring_virtqueue *vq = to_vvq(_vq);
+
+	return READ_ONCE(vq->last_used_idx);
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_last_used_idx);
+
 /**
  * virtqueue_enable_cb - restart callbacks after disable_cb.
  * @_vq: the struct virtqueue we're talking about.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index f923e42cfd01..1aed4d9235c8 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -112,6 +112,8 @@ unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
+unsigned int virtqueue_get_last_used_idx(const struct virtqueue *vq);
+
 bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
 
 void *virtqueue_detach_unused_buf(struct virtqueue *vq);
-- 
2.51.0

