Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907276;
	b=ZN5ieSAQ2COd2xrzldEzcuxkomUmzEM5UqZkY4WMSDwwFAUtpWU3oI3Id2D8bUmkpTKQ
	 WeccDVykjz5xHB5kY8GoJR6RkRbxOp98H0iLUbjGIfxuzPO4tVGuAD/4Df5CbxGOX2lDo
	 eeilF2LABXTC9Yq7SOlQ4IFvHEce1BM0qH09aJ8cBx08DoQ2NPMzOhYl0quDu9+GOwF+V
	 5CuCDVHxNz6mD5vaHikEbkM34SNGDzGw4VYGIHSzey7ISFkvbLQeld94Gb6H+KZS49iQo
	 sVdgDiEeywMj8M98Kk4eXgTVfMIjLiJNBmZNeUAr7/KLvJ8Bi/N1xxz+uKb95j/PM8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gCnltw4xBZg9rf91kbCMq2uc9N/TBEgzKyF8/A/W2/A=;
	b=JASzKV1N+TuFKpIv7zbvVw4K00sac6AIyerApUdl+48u2eKZcYPl5eyL4Jq4VoYbXqln
	 xFUxFWi9BoVrzyXp/zqsAt83jqEx5cQMpTHeaRcFZ8yts8TqBECmTGzA/pl0zT23gu3ed
	 u7A5i6DlTr/zOeNysvW6C3GgubjwTsDjTdxnARuQC7ZeP6nw128rSrgCp2etFQu0mNOTq
	 ZVJvbem1bAwHgZJ4Ptfcs6psCH9bBphmy/nfnG0tM4vN7DtNERdJ0gC0Zj0UDJg6y1fd4
	 SOZWNcQ58+/AvRcFm1QJ/LZyY0wcc2mlrZICmj7HQ96Vj66J2UutibYmYioTUGZ3Y3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cQxTLvvR;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4076360705ED
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 19:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4076360705ED
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cQxTLvvR
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-490c1d337d8so1245219f8f.2
        for <virtualization@lists.linux.dev>; Thu, 05 Nov 2026 11:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907275; x=1794512075; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gCnltw4xBZg9rf91kbCMq2uc9N/TBEgzKyF8/A/W2/A=;
        b=cQxTLvvRRKC7PCf12FhID+93O+eYrNpnD/9/jWKaoc9fetuuXyXEgmsuv3JWcY7Wl1
         xevRi+k5X4jGsNHT2VpsKps+EwPzDgOk2sL/iZ69Ih5esSoPhOrZlP73uFkSgRYsjeGK
         scZEc5EFu/PGU5xDxEbcY/UNtYQuv+h59yJUypHrgjCAZuEoThQ0tEdPEBvE8FQsXOAJ
         4RK+wuZenmi4C6qHRfbZKkbLtUZJpZ/l7LAMuZISFq0fgDKOX6TVItVwsPqwINPoEzYd
         Z7BOLIKDiXUKRJqKU1AyoYjufvfmbggqeWsn0N0m2tHJnu6V8dIjE+W4xzfw/0AXUwz1
         pMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907275; x=1794512075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gCnltw4xBZg9rf91kbCMq2uc9N/TBEgzKyF8/A/W2/A=;
        b=bbMHa3ZmDjXF1PJGJ4TIcWGSN2Gv4DaEkcYLsTvNElplqch8IYOly2Drm5i98qHf49
         lUNmVX1l8WoEGVYbvkaVVyrm6zOjsnm+m31Isy61bAwSlz28mMVMugF8v+EkGrNRqNfc
         Ow0McpxXVeXK1Y1LPIawGo3bxe0B8rfCCkFn7IlE2n1zKi5eZfRRSMJIlsSa+ZsXGp8o
         4JOJ4Q3IaB4HjN+JbLP67TjZD/3KPpcw+LY6ftbaJx2QZesNU/uzF6l02bGzrPyJ2wxW
         iMxi31HubQciptv+lc3MFd+D0Es4Ly2yPRA765CSR4sWzAXdjDyinCGb1Nzm0hbqUr/p
         yBMA==
X-Forwarded-Encrypted: i=1; AKwUvByQ8PPjijeIzHxll/1/iRVG35lO3nuUre4erfJOCso4O/y0IXV0uGMfQ8nYV4xhmr5TYukazn4yQG8X2g1PIQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8CkYc5SLlvZAP6CW4A7wruhGP48VJL/FkIPVWcmiBfmAFQK/dE
	/jAKk7Kz6gJLKQaT0xn+mngVAydF3hDhf58ftKzur/RakE3adDPZpDDQ
X-Gm-Gg: AYBFou2LAl+DYgwmb4dO+1E492c4kTRaF9YqxiiCRb2ayuRjq4dFjN0pcia6TsphrV7
	L9S0c2G1MTqUe0adus7RY5/iWR69yQBkQPoz4tfPlzwVjxcfFgkgIuIUPEuy9kf4ATbr8aKwwas
	HrqB6C+Q26hxeLeOsCMBmTFssVBQCL4Rab8atPLNdlrccZXyqgaIDIjN81G5sco67ViDpod0HtM
	RPNdCEOLKXoecH+PuX+WrWLKw0Sln/gomekQl2TC2+kbNzh5QlLZ6LKbyLMf92rtNZ5cAiWiZ35
	AwT5TVEv4GmyflBduwbMb+AvcN1QXHBEzjksCA1EPK6K0UJGlP+vUbAi5IQKlNkPk1vpSDYanhv
	omewulYVSnY/RAOSfFBrJmNeojtQfzVk7zIZkI1m9DrDR/PgfVfLO1TQpyO7AjhG6CfM8wE+Wt+
	iNXjj1XqkN45LWDkq/umq3fDqfuINqgioN9L/xrBlRB7n/xMi0QJqjxt3gy0aajcRKvvB6SNhe8
	poUI/BUW0o4SF3aPZNK1Gi3zq5k2b38bLjVYT4+/EjzzmsYxbAEOoPeRq8LAJKyoju0DTkGVAk0
	AfMPXIi9A17KHnLMmdctnGEsDyvtN2sk7jwMtCjelNrMeDw0KZ9l2Kvjrtp3nz/eQJEyi+mnfFo
	2
X-Received: by 2002:a05:6000:2f83:b0:48c:4553:790b with SMTP id ffacd0b85a97d-4927fb63ecfmr790286f8f.48.1793907274442;
        Thu, 05 Nov 2026 11:34:34 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:452b:db14:9bf:f8a8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea18104bsm12092866f8f.6.2026.11.05.11.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:34:33 -0800 (PST)
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Cornelia Huck <cohuck@redhat.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Eric Farman <farman@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alexander Graf <graf@amazon.com>,
	virtualization@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] virtio_ring: return an error pointer from vring_create_virtqueue()
Date: Thu,  5 Nov 2026 20:34:25 +0100
Message-ID: <20261105193426.2999631-1-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
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

vring_create_virtqueue() and vring_create_virtqueue_map() return NULL
on any failure, so the error returned from vring_alloc_queue_split()
is lost and turned into -ENOMEM. This is especially misleading if
vring_alloc_queue_split() rejects a queue size with -EINVAL (i.e. if
queue size is not a power of two):

  virtio_blk virtio0: Bad virtqueue length 100
  virtio_blk virtio0: probe with driver virtio_blk failed with error -12

So the error points whoever debugs it at an allocation failure that
never happened.

Return an ERR_PTR() instead: the error from vring_alloc_queue_split()
or vring_alloc_queue_packed(), or -ENOMEM when allocating the
virtqueue itself fails. Make the callers, virtio_pci (modern and
legacy), virtio_mmio, virtio_vdpa, virtio_ccw and virtio_uml, check
with IS_ERR() and pass the error on. The error path in virtio_ccw
deletes a non-NULL vq, so clear vq there before taking it.

Co-Authored-By: Claude Opus 5.5 <noreply@anthropic.com>
Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>
---
Tested on x86_64 with a virtio-mmio virtio-blk device offering a
100-entry queue: the probe now fails with -22 instead of -12, and a
128-entry queue probes as before. The other transports are only
compile-tested (x86_64, ARCH=um, s390 with clang, W=1).

No Fixes: tag, since the error has been -ENOMEM since 2010 and nothing
regressed.

This conflicts trivially with patch 07/12 of Alexander Graf's "virtio:
support devices that own their virtqueue memory" v2:
https://lore.kernel.org/virtualization/20260818211425.91009-1-graf@amazon.com/
---
 arch/um/drivers/virtio_uml.c       |  4 ++--
 drivers/s390/virtio/virtio_ccw.c   |  5 +++--
 drivers/virtio/virtio_mmio.c       |  4 ++--
 drivers/virtio/virtio_pci_legacy.c |  4 ++--
 drivers/virtio/virtio_pci_modern.c |  4 ++--
 drivers/virtio/virtio_ring.c       | 12 +++++++-----
 drivers/virtio/virtio_vdpa.c       |  4 ++--
 include/linux/virtio_ring.h        |  6 +++++-
 8 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 881c34098a74..8b645523277f 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -984,8 +984,8 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 
 	vq = vring_create_virtqueue(index, num, PAGE_SIZE, vdev, true, true,
 				    ctx, vu_notify, callback, info->name);
-	if (!vq) {
-		rc = -ENOMEM;
+	if (IS_ERR(vq)) {
+		rc = PTR_ERR(vq);
 		goto error_create;
 	}
 	vq->priv = info;
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 552d77998012..c5a30f0a2bc2 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -590,10 +590,11 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 				    vdev, true, may_reduce, ctx,
 				    notify, callback, name);
 
-	if (!vq) {
+	if (IS_ERR(vq)) {
 		/* For now, we fail if we can't get the requested size. */
 		dev_warn(&vcdev->cdev->dev, "no vq\n");
-		err = -ENOMEM;
+		err = PTR_ERR(vq);
+		vq = NULL;
 		goto out_err;
 	}
 
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index e2ec0ec01d67..c403a025006e 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -396,8 +396,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 	/* Create the vring */
 	vq = vring_create_virtqueue(index, num, VIRTIO_MMIO_VRING_ALIGN, vdev,
 				 true, true, ctx, notify, callback, name);
-	if (!vq) {
-		err = -ENOMEM;
+	if (IS_ERR(vq)) {
+		err = PTR_ERR(vq);
 		goto error_new_virtqueue;
 	}
 
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 8115aa39e01e..9d94fffff344 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -130,8 +130,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
 				    true, false, ctx,
 				    vp_notify, callback, name);
-	if (!vq)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(vq))
+		return vq;
 
 	vq->num_max = num;
 
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 922e2df027de..28ccb2130e27 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -720,8 +720,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				    SMP_CACHE_BYTES, &vp_dev->vdev,
 				    true, true, ctx,
 				    notify, callback, name);
-	if (!vq)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(vq))
+		return vq;
 
 	vq->num_max = num;
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f683a2d6a200..6dd4a7651bde 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1421,13 +1421,13 @@ static struct virtqueue *vring_create_virtqueue_split(
 	err = vring_alloc_queue_split(&vring_split, vdev, num, vring_align,
 				      may_reduce_num, map);
 	if (err)
-		return NULL;
+		return ERR_PTR(err);
 
 	vq = __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
 				   context, notify, callback, name, map);
 	if (!vq) {
 		vring_free_split(&vring_split, vdev, map);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	to_vvq(vq)->we_own_ring = true;
@@ -2671,15 +2671,17 @@ static struct virtqueue *vring_create_virtqueue_packed(
 {
 	struct vring_virtqueue_packed vring_packed = {};
 	struct virtqueue *vq;
+	int err;
 
-	if (vring_alloc_queue_packed(&vring_packed, vdev, num, map))
-		return NULL;
+	err = vring_alloc_queue_packed(&vring_packed, vdev, num, map);
+	if (err)
+		return ERR_PTR(err);
 
 	vq = __vring_new_virtqueue_packed(index, &vring_packed, vdev, weak_barriers,
 					context, notify, callback, name, map);
 	if (!vq) {
 		vring_free_packed(&vring_packed, vdev, map);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	to_vvq(vq)->we_own_ring = true;
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index f9559b6b2e0b..c1b6134b2267 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -208,8 +208,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	vq = vring_create_virtqueue_map(index, max_num, align, vdev,
 					true, may_reduce_num, ctx,
 					notify, callback, name, map);
-	if (!vq) {
-		err = -ENOMEM;
+	if (IS_ERR(vq)) {
+		err = PTR_ERR(vq);
 		goto error_new_virtqueue;
 	}
 
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index c97a12c1cda3..c808ca7e8d58 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -66,6 +66,9 @@ struct device;
  * may_reduce_num is set, then this may allocate a smaller ring than
  * expected.  The caller should query virtqueue_get_vring_size to learn
  * the actual size of the ring.
+ *
+ * Returns the virtqueue or an ERR_PTR() on failure: -EINVAL if num is
+ * not a valid ring size, -ENOMEM if the ring could not be allocated.
  */
 struct virtqueue *vring_create_virtqueue(unsigned int index,
 					 unsigned int num,
@@ -80,7 +83,8 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
 
 /*
  * Creates a virtqueue and allocates the descriptor ring with per
- * virtqueue mapping operations.
+ * virtqueue mapping operations.  Returns the virtqueue or an ERR_PTR()
+ * on failure, like vring_create_virtqueue().
  */
 struct virtqueue *vring_create_virtqueue_map(unsigned int index,
 					     unsigned int num,

base-commit: 1a577f9402c1780cc1e663f48d5dd54c02051b09
-- 
2.53.0

