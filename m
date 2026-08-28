Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448AE3CBE74
	for <virtualization@lists.linux.dev>; Fri, 28 Aug 2026 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903031; cv=none; b=JFAw3hAJC7ROONXCN+s8IXRV5DIAq7xDR+7ZPmU/PBEo2htdMzG59CS7ZFeTsqWQyZ950sz33upE0L4s4PO1rHx4rP9ffxYWzCbxLUkoC0ZMtHnodGRxV/8ckxtyljVGZWpcHDVBdyKzDcBcVqhxsHXhCw4gHY8drE4lCo4JIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903031; c=relaxed/simple;
	bh=82vo3mOeH7dCiVmyQ8VYld3vG9UemxOCw5F1cKSD+eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XRtCUMgCnboY+wocuaulCcv6kKrMtmH+0cg1g2g2fY0q2pY+2mn+VCftf6UShZrEjZYPcKCw9QOqjm9+Ita5dmXX4C0LhslZt+auibBMN7HdFtih0fe4K5xYx5V4BMh86Z5jbfPsKyLveOa/j+ctA5n9gCs7iQ5/eO57+q3oKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=isMI+pZG; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="isMI+pZG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Mm
	/lyXYELslfIyQ8Db9xoIQlzWwMPaGWYAtgdV5sJ3c=; b=isMI+pZGovWIcFheKU
	VABHLIsDYSvhNKVcqaP3/oSyaXDplgFw8u0ehTaFkpOeTGz50vpB7h4iT8nl5s33
	dmAeNNaedQmP5ZC1kXhS2v8/vBzzMMLVul1f640dDf1DE233/fiSrpiisCrLVYIa
	jP18MhHFkhPfPvJtK3QEiUICY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD31xMfPJFqXWYePg--.48947S3;
	Fri, 28 Aug 2026 15:43:28 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org
Cc: jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: [RFC PATCH 1/3] virtio: add virtqueue_get_last_used_idx() helper
Date: Fri, 28 Aug 2026 15:43:24 +0800
Message-Id: <20260828074326.65594-2-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260828074326.65594-1-lange_tang@163.com>
References: <20260828074326.65594-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD31xMfPJFqXWYePg--.48947S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4UWF48GF18Ar1fXr48Crg_yoW5ur17pF
	WDKrW5trWkGFWxZFyfGr1jvrya9wsrGw13tryxuw1DuFy5tFn8ZF1j9w1rJr18Ar4kC34x
	Zrs0grZ8Kr1DuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UMxRgUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4gAWRGqRPCACWAAA3N

From: Longjun Tang <tanglongjun@kylinos.cn>

Export a read-only accessor for the last consumed used ring index.
It's useful for drivers that need to detect whether the device has
produced buffers that have not been consumed yet, by passing the
returned value to virtqueue_poll().

The split ring now writes the field with WRITE_ONCE() (the packed
ring already did) to document that the new reader can run concurrently
with the poll path.

Assisted-by: Kilo:deepseek-v4-pro
Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 drivers/virtio/virtio_ring.c | 23 +++++++++++++++++++++--
 include/linux/virtio.h       |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5c169fbb418a..7b21fe573cde 100644
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
@@ -3197,6 +3197,25 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
 
+/**
+ * virtqueue_get_last_used_idx - get the last consumed used ring index
+ * @_vq: the struct virtqueue we're talking about.
+ *
+ * Returns the index of the most recently consumed used buffer. It is
+ * mainly useful to detect whether the device has produced buffers that
+ * have not been consumed yet, by passing the returned value to
+ * virtqueue_poll().
+ *
+ * This does not need to be serialized.
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
2.43.0

