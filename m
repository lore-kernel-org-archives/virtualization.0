Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795159125;
	b=qiMkWhGo9r8y+/qUxJhOjrbfztmcp19a40XBzF4z2MBuUlxqxTcNCWOFEZV92H675QtO
	 1EtdqeUZoEiU00ReyUWQSSogqHYWVET89fFURQ5BE46v4Vlodl4qM0eYerbVMRwbn/5Te
	 RkbUXLMNmi8R6hS1m1a337CdUfZoHlmJYt28pvdgLjQ9ReotpSxbydvENhSpNILq3i+Rq
	 Vj9ldoS9wQ58P5Ci4WX8+WEs6y8I0PuhHb6Q6YNShoCi2pkQ8buloi36a9eXGiCeQReew
	 iPCvtfXb2Ymx/t6d+QxsRaaWebs43IcjEyHIF7u6TDLLUdAC484jiYUbvsGQ0WZKDAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795159125;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=W0JhyG/3pAXwDfIBhCcxcDEJVltQTzcmdJUOS5CF/wY=;
	b=ricwrqNIk6pDIHjVC4eoC0rhxc4rbnLkGd+YTP4Ydok5wxiSzqeWTBrA3n//ClHotA+g
	 LrJB/kN7weaNgK+EMFjZSE6gN7unfuk97NpguDP/v35g0++UhZe42WDyuxtZzeJHGPlvf
	 wR3NVJuz5Ajv0DmW5hys1ZGt+IoKLGnKTaDLV4F6gzcpVZWpDvLnpCMBnvvNT05Cracvj
	 r3NJ0IRaIFfH5QeOSyV6RWLrKdKaJQnxZ1VEE+6XNKQxirdJdkbH/BYXM96mx77kbMHRQ
	 LuwqA2QiCDPJy55cIH8EkjKHCdjKEx3KpmnHNRbEpYvec4ppGJU5szET7p5kJEn8WGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=i4tdVMCo;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F79606A330
	for <virtualization@lists.linux.dev>; Fri, 20 Nov 2026 07:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46F79606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=i4tdVMCo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=W0
	JhyG/3pAXwDfIBhCcxcDEJVltQTzcmdJUOS5CF/wY=; b=i4tdVMCo95A+8q1cZZ
	EFTUXlGe/u1aTzl7DzwpADxCq70uXULNVLFVJWBXONI1lNHbQ/6EidhfMDkoT/h1
	/RRYMn0W7l9jEUhm5oqXOXeZLtkPqEW7Ehs7N4OtDvANsWfMXLZ/hV59BqNY2SQw
	DsZaBSuQsvuUBRtPovKXLMdq0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD354ZD9P9qmowxJA--.12595S3;
	Fri, 20 Nov 2026 15:18:28 +0800 (CST)
From: Longjun Tang <lange_tang@163.com>
To: mst@redhat.com,
	kuba@kernel.org,
	eperezma@redhat.com,
	jasowangio@gmail.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	tanglongjun@kylinos.cn
Subject: [PATCH v2 1/3] virtio: add virtqueue_get_last_used_idx() helper
Date: Fri, 20 Nov 2026 15:18:24 +0800
Message-Id: <20261120071826.198604-2-lange_tang@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261120071826.198604-1-lange_tang@163.com>
References: <20261120071826.198604-1-lange_tang@163.com>
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
X-CM-TRANSID:_____wD354ZD9P9qmowxJA--.12595S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJw4Utr1DGrW7Jr48GFy8Zrb_yoW5CF4DpF
	srKry5trWkGFWxZFyfWr4qvr1a9wsxGw13KrWxuw1DW3Z8tFyq9F1j9w1rJr18Ar4kC347
	ZrsIgrZ8KF1DuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0c_-UUUUU=
X-CM-SenderInfo: 5odqwvxbwd0wi6rwjhhfrp/xtbC4QToF2r-9ESxfwAA3x

From: Longjun Tang <tanglongjun@kylinos.cn>

Expose last_used_idx through a new helper, which is used by both the split
and the packed ring and denotes the position the driver has last consumed.
It is useful for drivers that need to detect whether the device has
produced buffers that have not been consumed yet, by passing the returned
value to virtqueue_poll().

The split ring now writes the field with WRITE_ONCE() (the packed ring
already did) to document that the new reader can run concurrently with
the poll path.

Signed-off-by: Longjun Tang <tanglongjun@kylinos.cn>
---
 drivers/virtio/virtio_ring.c | 18 ++++++++++++++++--
 include/linux/virtio.h       |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f683a2d6a200..e8af6d5c6432 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1005,7 +1005,7 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
 	/* detach_buf_split clears data, so grab it now. */
 	ret = vq->split.desc_state[i].data;
 	detach_buf_split(vq, i, ctx);
-	vq->last_used_idx++;
+	WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1);
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
 	 * the read in the next get_buf call. */
@@ -1072,7 +1072,7 @@ static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtqueue *vq,
 	ret = vq->split.desc_state[last_used].data;
 	detach_buf_split_in_order(vq, last_used, ctx);
 
-	vq->last_used_idx++;
+	WRITE_ONCE(vq->last_used_idx, vq->last_used_idx + 1);
 	vq->last_used += (vq->vq.num_free - num_free);
 	/* If we expect an interrupt for the next entry, tell host
 	 * by writing event index and flush out the write before
@@ -3236,6 +3236,20 @@ bool virtqueue_poll(struct virtqueue *_vq, unsigned int last_used_idx)
 }
 EXPORT_SYMBOL_GPL(virtqueue_poll);
 
+/**
+ * virtqueue_get_last_used_idx - get the ring's last consumed position
+ * @_vq: the struct virtqueue we're talking about.
+ *
+ * Returns: the vring_virtqueue's last_used_idx.
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

