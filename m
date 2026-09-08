Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED26A4EE863
	for <virtualization@lists.linux.dev>; Tue,  8 Sep 2026 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859630; cv=none; b=BIFJlOQ3wSaOmyD5Ai7qCxvrsCjb2bOaT6i9Pmc9wnRe98d7oB6I4M3BD0RPZX9tCokDy5j/BJq/YpnXZhPzpb9gRTV0IIsCOC9SYHRzdbZ9xL1oGDzAQkOPHIt0+jYcirc9qd2/JIxobPX3eVjk39EvbeefetYxbcZebGqs8O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859630; c=relaxed/simple;
	bh=d/A8tklRTIeIpWm0KCy54X99GYAM3miKmKKAhI1IL8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSJR+ihD2z0kIEbdniWMviOCskPnmiiIkb77iOwH/CsJZmWNFrPTb4cjxM8RKsQmPHvgdYNu7vpHNmTg5Vr4vAtVcS1ILtZZ+DGwJyCt87AgYN/IGcfTIS1BvhRx3ze7DNo6/1olz4wW+tCB8OL7GmAE40AU9ciZMkijrQBuDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dMMeHFni; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dMMeHFni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=+O
	c8d0VLEx58SQdHDoudoa+M7TnhLHVEHuJoMm4VLxQ=; b=dMMeHFni41KnuBXRq7
	n4jeevzEXa5TwdwiKUuEUIjKE9Yf40QVBo91VbUP3AC9fT1SvKSqxjbrFp6O+98v
	P9aT/KfBL9yGEyYmro/V7udeVYd/ULQnLj5yuRaXA0uvkdEdJYeS7XqaidBXLThL
	Uds5lHcoxtw9s53QDmwUYYNdw=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgD3Bf3X1J9qaBRdRg--.18019S3;
	Tue, 08 Sep 2026 17:26:49 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org
Cc: jasowangio@gmail.com,
	xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: [RFC RESEND 1/3] virtio: add virtqueue_get_last_used_idx() helper
Date: Tue,  8 Sep 2026 17:26:44 +0800
Message-Id: <20260908092646.108865-2-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260908092646.108865-1-lange_tang@163.com>
References: <20260908092646.108865-1-lange_tang@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgD3Bf3X1J9qaBRdRg--.18019S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4UWF48GF18Ar1fXr48Crg_yoW5CrWUpF
	WDKryUtrWkGFWxZFyfWF4qvrya9wsxGw13KrWxuw1DuF98tFyDZF1j9w1rJr1xAr4kC34x
	ZrsIgrZ8KF1DuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4hntHGqf1NmxDQAA3O

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
 drivers/virtio/virtio_ring.c | 18 ++++++++++++++++--
 include/linux/virtio.h       |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5c169fbb418a..f29ef246cff8 100644
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
@@ -3197,6 +3197,20 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
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
2.25.1

