Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B9F463B9B
	for <virtualization@lists.linux.dev>; Fri, 21 Aug 2026 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304115; cv=none; b=nRCK2EfrDXi5U94Qz01tQA0bpoHIP8Utuc5NkzeUI1GI7bbWMwjBCFwwLTjG4ia3+Oj3NNYGzIEB8Er4EX3seVvCvABMytijlku8/hsBeZhs6xiGafaHbDIfhOskJxYmY/kOHNk+38aJ08J6zdBjUY7KrePpzvSCQSFhL6yEIeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304115; c=relaxed/simple;
	bh=17mRHAcgbScJ010Hr/g1h5u/KKQhxYtSu51f8+ZwMPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nHLMEUxQAPUTcwDLwS6tNIh21g6IkBW5V9w2xoQZvD7LAUnxhSUGBlohN2qx+kxu8f5b8W5g0+236ASNOpJa8+K7JnCWhsUSC33LGJmeIuSnQW4yWgEBHr5z1zctEEcGXIopSxFJAG9+n6cNMqdr1fnj14w7t5o2V4G/zQLTkjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=errqJ8xX; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="errqJ8xX"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d58efc7356so9633795ad.1
        for <virtualization@lists.linux.dev>; Fri, 21 Aug 2026 02:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787304106; x=1787908906; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rIVxI763y0PXJPtee95zvFxNk/MLc74f2lcS4/k1mxE=;
        b=errqJ8xXaU8yKeoEENhIlfrO8ymW8lIstdLmwaG+gLfXx5TVDq3g5HncVivzGVDYsZ
         H2oEFpgOxaDc11pjdEGiHdRSX8VcLzIAcd3FqlfWtOjDyP45zZ19LNQDUB+gmmejxIeo
         Ngmw1nswHuiPq93f5+nazRK8cRY4AplLHhLrHf1jBt0xHsx26spMaD1T6Oh875yPE/TP
         WbmMonywJ8iqtuMQTyucWtKnIdu9YKbD0mHH4MZrSm/mNz+LGPInqkzNo4eYp+goNNbK
         zJu8uEnA2zdF4sLcFOJMzEZXAf8DNMHo7Tq6Ob/C92S6b8BM5qby7rbfJ5wLVuGzMAqC
         DkPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787304106; x=1787908906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rIVxI763y0PXJPtee95zvFxNk/MLc74f2lcS4/k1mxE=;
        b=DGCuJqXQkMTV2uazixbHB1HAS0d+su5pWXjVG0k4KYXv0IWhLI+4kVcmHcJ8mjFp3p
         o85/SKK0CnHiyaTQGBBPEcyRTknJQdGgtbiuHkFv08EfpM7lbwfdR0o7YEvdzJMKzQs2
         1fjU5SWv08w7DvyX7qQ3tinh9c+uqtwLRDH/XmoXSivFzO1fwuawW2M7Kh0HNVUZMGY/
         qYVx/knLo1E+ZY5OECM8W9A7bhxaU3dM7UpigoFs6V3dX8rMqBWRtKoRYO69mh1hHa+b
         wWKBBshec79B3pMNw8FZiIsKWrP7NQMtnE8XUjL4hpgLnzyOIOCIKBae7gc4APa3yjkf
         eZuA==
X-Forwarded-Encrypted: i=1; AHgh+Rp851fkqda3hzyXe8yKf/y4YEL1BsvI7fr3l75IY3clKHLeEsflcy4RprlpHQeOmtlXmGpAuSx+Oi7NGPMhSQ==@lists.linux.dev
X-Gm-Message-State: AFuF++maBSJkrWsexOUe38LjpbA1P1MoY2Wh/zzkdAk6TY9aos+POdCr
	gu2vsWdeNsyxOKR+9pR70/AxrDa164O9h/1S/pyIzNcExQEMRtbMSo38
X-Gm-Gg: AR+sD13CzaCsS+0SqOmpwaxCJ0TeZ4xOTQChle0Y+4qQEovQS/ffoswymmwDfMxju/4
	xQGrqBl1u/8JeLIb1S/V+6AFU+lXBn4ZmKWiyDkBLnXOKq0boUc4EnmFgZ8WaVF3EKpl3mflbHm
	ye8NBan3xTQ2+FLIUJGWOuqtkPbngQnUo8SjtgvnNdHpxBzGCofbaBWEzzn5J3QXRcUK9Ffoccm
	fW4gQ8qEjLZHpKK8kbiaf2OWv9HmEmYScITWF6B6D6vKSBtUDp+IM7GWOsnqhjeG/jbJ/pTktCz
	rf8Xo7WUR+shujq8l5ULyso36G3o+0Q1K+GdrMZC7AE+jfFRyWtw5iFOlSEDGu46JNLncZf/dim
	f6AHSEuU+J5PepgqeZ8kfnbt8vEX8M4s6OL8SUX203dGQXjMss84FpziyY0rB7tcCQ2TIABxI/I
	9O+5HoeKJbsdhzglW8f65CzgUBPQbL4I7hZ0kAWVRR9iNp8l/fGZFsOcKfUb5wDiY=
X-Received: by 2002:a17:902:d4cc:b0:2c9:aae1:a61a with SMTP id d9443c01a7336-2d64b0c6a16mr88046515ad.14.1787304105197;
        Fri, 21 Aug 2026 02:21:45 -0700 (PDT)
Received: from [127.0.1.1] ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327c3fc6675sm36658847eec.13.2026.08.21.02.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:21:44 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: mst@redhat.com,
	jasowangio@gmail.com,
	stefanha@redhat.com,
	sgarzare@redhat.com
Cc: eperezma@redhat.com,
	weiyj.lk@gmail.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8] vhost: invalidate vring access on IOTLB transitions
Date: Fri, 21 Aug 2026 17:21:08 +0800
Message-Id: <20260821092108.334318-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When VIRTIO_F_ACCESS_PLATFORM changes, the cached desc, avail, and
used addresses change meaning with the address space. Invalidate the
cached vring access state when switching between direct userspace
addresses and device IOTLB addresses, and discard the device IOTLB when
userspace clears ACCESS_PLATFORM.

Introduce a common device-IOTLB teardown helper and use it from
vhost-net and vhost-vsock. The helper drops the device-wide view,
switches each VQ under its mutex, clears the IOTLB message queues, and
frees the old table after the VQ handoff.

Preserve the existing IOTLB replacement semantics when ACCESS_PLATFORM
is set again. On the first direct-to-IOTLB transition, invalidate the
cached vring addresses. When replacing an existing IOTLB, keep the
GIOVA ring addresses and reset only the metadata cache, so stale
metadata pointers cannot be used after the old table is freed.

A successful live transition leaves the backend attached. Userspace
must configure the vring addresses for the new address mode after
ACCESS_PLATFORM is cleared.

vhost_vq_invalidate_access() clears all three vring addresses together.
Treat the VQ as invalidated only when all three are zero, since an
individual vring address may legitimately be GIOVA 0 in IOTLB mode.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Fixes: e13a6915a03f ("vhost/vsock: add IOTLB API support")
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
Changes since v7:
- Squash the three patches so the common helper is introduced together
  with the vhost-net and vhost-vsock callers.
- Preserve the existing device-IOTLB replacement semantics.
- Treat a VQ as invalidated only when all three vring addresses are zero,
  since an individual vring address may legitimately be GIOVA 0.
- Keep the original vhost-vsock feature-test formatting.

 drivers/vhost/vhost.c | 57 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/vhost/vhost.h |  1 +
 drivers/vhost/vsock.c |  2 ++
 drivers/vhost/net.c   |  2 ++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 14637cff0bd4..4343b811a838 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -344,6 +344,17 @@ static void __vhost_vq_meta_reset(struct vhost_virtqueue *vq)
 		vq->meta_iotlb[j] = NULL;
 }
 
+/* Caller must hold the virtqueue mutex. */
+static void vhost_vq_invalidate_access(struct vhost_virtqueue *vq)
+{
+	vq->desc = NULL;
+	vq->avail = NULL;
+	vq->used = NULL;
+	vq->log_used = false;
+	vq->log_addr = -1ull;
+	__vhost_vq_meta_reset(vq);
+}
+
 static void vhost_vq_meta_reset(struct vhost_dev *d)
 {
 	int i;
@@ -1918,6 +1929,13 @@ int vq_meta_prefetch(struct vhost_virtqueue *vq)
 {
 	unsigned int num = vq->num;
 
+	/*
+	 * vhost_vq_invalidate_access() clears all three addresses together.
+	 * A single zero address may be a valid GIOVA in IOTLB mode.
+	 */
+	if (!vq->desc && !vq->avail && !vq->used)
+		return 0;
+
 	if (!vq->iotlb)
 		return 1;
 
@@ -2287,6 +2305,40 @@ long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *arg
 }
 EXPORT_SYMBOL_GPL(vhost_vring_ioctl);
 
+/* Caller must hold the device mutex. */
+void vhost_clear_device_iotlb(struct vhost_dev *d)
+{
+	struct vhost_iotlb *iotlb;
+	int i;
+
+	iotlb = d->iotlb;
+	if (!iotlb)
+		return;
+
+	/*
+	 * Drop the device-wide view first.  Each VQ then drops its
+	 * per-VQ view and its cached ring access under its own mutex.
+	 * Keep the old table alive until every VQ has completed this
+	 * handoff, since a worker may still be using it while waiting
+	 * for its VQ mutex.
+	 */
+	d->iotlb = NULL;
+
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vq->iotlb = NULL;
+		vhost_vq_invalidate_access(vq);
+		mutex_unlock(&vq->mutex);
+	}
+
+	vhost_clear_msg(d);
+	vhost_iotlb_free(iotlb);
+	wake_up_interruptible_poll(&d->wait, EPOLLIN | EPOLLRDNORM);
+}
+EXPORT_SYMBOL_GPL(vhost_clear_device_iotlb);
+
 int vhost_init_device_iotlb(struct vhost_dev *d)
 {
 	struct vhost_iotlb *niotlb, *oiotlb;
@@ -2307,7 +2359,10 @@ int vhost_init_device_iotlb(struct vhost_dev *d)
 
 		mutex_lock(&vq->mutex);
 		vq->iotlb = niotlb;
-		__vhost_vq_meta_reset(vq);
+		if (oiotlb)
+			__vhost_vq_meta_reset(vq);
+		else
+			vhost_vq_invalidate_access(vq);
 		mutex_unlock(&vq->mutex);
 	}
 
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0192ade6e749..3c75e8089373 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -277,6 +277,7 @@ ssize_t vhost_chr_read_iter(struct vhost_dev *dev, struct iov_iter *to,
 			    int noblock);
 ssize_t vhost_chr_write_iter(struct vhost_dev *dev,
 			     struct iov_iter *from);
+void vhost_clear_device_iotlb(struct vhost_dev *d);
 int vhost_init_device_iotlb(struct vhost_dev *d);
 
 void vhost_iotlb_map_free(struct vhost_iotlb *iotlb,
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 9aaab6bb8061..abed1fbcf66c 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -868,6 +868,8 @@ static int vhost_vsock_set_features(struct vhost_vsock *vsock, u64 features)
 	if ((features & (1ULL << VIRTIO_F_ACCESS_PLATFORM))) {
 		if (vhost_init_device_iotlb(&vsock->dev))
 			goto err;
+	} else {
+		vhost_clear_device_iotlb(&vsock->dev);
 	}
 
 	vsock->seqpacket_allow = features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET);
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 38d9c184082d..4d9d7c2216ed 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1696,6 +1696,8 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
 	if (virtio_features_test_bit(features, VIRTIO_F_ACCESS_PLATFORM)) {
 		if (vhost_init_device_iotlb(&n->dev))
 			goto out_unlock;
+	} else {
+		vhost_clear_device_iotlb(&n->dev);
 	}
 
 	for (i = 0; i < VHOST_NET_VQ_MAX; ++i) {

base-commit: b282418bc366194677eafd1dad180d92254586ac
-- 
2.34.1
