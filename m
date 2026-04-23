Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CBD3A9D84
	for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966059; cv=none; b=s1kWNKqqZSOvK7S43+hr0j89eiYqVq40INEkeSAzoldXv0Oh3/K2487xkJlJ5Az+XzIMc0q7q/JAeSedtNFk2hMYK6BoPOkDgQd8S2gz3ARbVn23aES8WW12auKgueYlV76aV6A5g07jbdk+hjeRw3GCS3xPCj8SXHHMMvRjQzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966059; c=relaxed/simple;
	bh=Wp+rXTYV6cCR7GQckednAxBMcKVMT6SIRlSrHu1tg4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AbDyUlWXyj2fiEEFgllRcGVn97TbLpS4uaCC/XfbFHqdpPypn3c8lTbZ0+LQ4bnqJTYlYxWn4CqF0h4s0Y7WJBn0aVdNEU5s5KT7uTcuwe3ax0Tb03gLHI+JnzYG4s1noyJwfUveoWYMs3VpErniRwmv2PxDMwPPhyKlY6GzgKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GND/1bqv; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GND/1bqv"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82faf871346so3987511b3a.0
        for <virtualization@lists.linux.dev>; Thu, 23 Apr 2026 10:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776966057; x=1777570857; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfrLDAY7+No90zlR6HffZqbGM74lFTvO1IbltHEt5HY=;
        b=GND/1bqvtUqHBF/fsRYBAJK+PyB1EPecUQHlb5CLTI0+Eo7hSbzuT7w2Xd0ane8Oi2
         fCVlR8R1wXCZTcaCFePWgkBSyccydkKnLTDHkPNhW/98GKLHDvFXe9zTrAJ/aB/JENmZ
         +DtotoI8x+B9J80vO875qq/6AYlVJKAuCOy4tt4XVUtVE/n0lxtGdlz1MbXboB+uxj8z
         AO66MxRrcv/5aEKaPfJDBYj5AfUcqJv5UWcq635UFzRqbqt65RTjfllWYB8KYv5RIeKT
         7dAMVQenDpi1ioCSS6P/ysXc+UjPjX4kKfV138oGe/b2KgfbGYdQC1OKXdmcGdOKq6Ka
         2rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776966057; x=1777570857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zfrLDAY7+No90zlR6HffZqbGM74lFTvO1IbltHEt5HY=;
        b=qJDaSe4ME6H7V31gVUv+AReae6RjlrtiKk7hxya5oo7rdD/+pJ5Sli88l3pLpGn3gM
         Vxz/00/NW1b8nzdD/6pqIQ6JPViOEF877EFc2QRzg0CnxWe8GxzN4/qieeTuGZifHQSU
         CPhHrT6vHwCoJutq6LCXcWjGSnIA2Eil6Oma3JD7gUw8WeyI79haqTmfpGLN8dpNis+2
         RlECvlHHi1/lWQUTqvO1icvY+f5BsjH/yPuftFXHzeGde/wH1RXwzquQGI6OtJ6ppEEK
         3MyY152w40J11nqXTflg+CPbV/7ixz2xdYXWlIMmR+XQetX8f0S0QIv3xB2UP9p4WYvH
         5e2g==
X-Forwarded-Encrypted: i=1; AFNElJ/AiqeFLjrFpzroq28RS25yHW2dq/AnUXNUul32fR+u7HbeaP+t9uiajKEx0hWA1gD2q6CBeRn0mGp+hwPHvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyU86lO9xbD+heu1pZdTW0Q8ka6yEjdf75ecVRkXe43Uzmu7bDL
	PMPpSiwyNB1pKFgP8j1is9XMDGPqsbVOj7Q8oO+N3hkg+nzZuHA8ZqIw
X-Gm-Gg: AeBDietxJNGzNBytLMll9bRr6xaJe0r2iU1phGh1vjwv0CkQ0iUB6gATtI08hjf/JF5
	vqxfFPCmWd8a8km2TQsv4+/iqTiAuzjPn1GNusPjH6avpiQsW/a44Vm+g4TMfIXOh+WyXBcZGVk
	Ni0I67W7lJCxfttY2H8RwR/RgFox3VUoihaWOtUETbv5bQifHwQ6iNRYO6Y3vosScBCAaz++8rX
	mxfYXyx47TxEBVh1hUQpUL2uDYEVJyPtIV+4RHsnF5EsUGmbMoBSZ9rGs1MecZ3k9G7Gg41Wsb+
	VypwOrU/7Ix441lZ15qHxwd1AwGU/5HG65Vyfkn+9RAXJ7Wda5OSc3HmWYwSz0GFRb9Py6pNk6r
	cUqoobAU2GEkyT0Wvs500WA7JhBcFXE3xEssYpEafbDk1gNUMNJS+52MPrmkDRgeRqIL3iabaGd
	DQDhoP//vKnH5Y2fW6mjFNEUdClM6w/VblcLUBEltujvyZV2v8GtdIg8MeYGU/zkY3cLcuZ05Nn
	KQqg4xf7PJ4Wwubf9l/I2zBwqCtzvCInr42Ug==
X-Received: by 2002:a05:6a00:e1a:b0:82f:7bec:2050 with SMTP id d2e1a72fcca58-82f8c90d174mr30741300b3a.39.1776966057112;
        Thu, 23 Apr 2026 10:40:57 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebcc9easm27014498b3a.39.2026.04.23.10.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 10:40:56 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v4 2/4] virtio_ring: export virtqueue_reinit_vring() for noirq restore
Date: Fri, 24 Apr 2026 02:40:37 +0900
Message-Id: <20260423174039.276-3-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260423174039.276-1-baver.bae@gmail.com>
References: <20260423174039.276-1-baver.bae@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sungho Bae <baver.bae@lge.com>

After a device reset in noirq context the existing vrings must be
re-initialized without any memory allocation, because GFP_KERNEL is
not available.

The internal helpers virtqueue_reset_split() and
virtqueue_reset_packed() already reset vring indices and descriptor
state in place.  Add a thin exported wrapper, virtqueue_reinit_vring(),
that dispatches to the appropriate helper based on the ring layout.

This will be used by a subsequent patch that adds noirq system-sleep
PM callbacks for virtio-mmio.

Signed-off-by: Sungho Bae <baver.bae@lge.com>
---
 drivers/virtio/virtio_ring.c | 51 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio_ring.h  |  3 +++
 2 files changed, 54 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fbca7ce1c6bf..6631c30cb706 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -506,6 +506,15 @@ static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
 	vq->event_triggered = false;
 	vq->num_added = 0;
 
+	/*
+	 * Keep IN_ORDER state aligned with a freshly initialized/reset queue.
+	 * For packed IN_ORDER, free_head is unused but harmlessly reset.
+	 */
+	if (virtqueue_is_in_order(vq)) {
+		vq->free_head = 0;
+		vq->batch_last.id = UINT_MAX;
+	}
+
 #ifdef DEBUG
 	vq->in_use = false;
 	vq->last_add_time_valid = false;
@@ -3936,5 +3945,47 @@ void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_map_sync_single_range_for_device);
 
+/**
+ * virtqueue_reinit_vring - reinitialize vring state without reallocation
+ * @_vq: the virtqueue
+ *
+ * Reset the avail/used indices and descriptor state of an existing
+ * virtqueue so it can be reused after a device reset.  No memory is
+ * allocated or freed, making this safe for use in noirq context.
+ *
+ * Preconditions for callers:
+ * 1) The vq must be fully quiesced (no concurrent add/get/kick/IRQ callback).
+ * 2) Transport/device side must already have stopped/reset this queue.
+ * 3) All in-flight buffers must already be completed or detached.
+ *
+ * If called with outstanding descriptors, free-list state can be corrupted:
+ * num_free is restored to full capacity while desc_extra next-chain/free_head
+ * may still represent a partially consumed list.
+ */
+void virtqueue_reinit_vring(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	unsigned int num = virtqueue_is_packed(vq) ?
+		vq->packed.vring.num : vq->split.vring.num;
+
+	/* All in-flight descriptors must be completed or detached */
+	WARN_ON(vq->vq.num_free != num);
+
+	if (virtqueue_is_packed(vq)) {
+		virtqueue_reset_packed(vq);
+	} else {
+		/*
+		 * Split queue shadow index should match the visible avail
+		 * index when the queue is fully quiesced.
+		 */
+		WARN_ON(vq->split.avail_idx_shadow !=
+			virtio16_to_cpu(vq->vq.vdev,
+					vq->split.vring.avail->idx));
+
+		virtqueue_reset_split(vq);
+	}
+}
+EXPORT_SYMBOL_GPL(virtqueue_reinit_vring);
+
 MODULE_DESCRIPTION("Virtio ring implementation");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index c97a12c1cda3..26c7c9d0a151 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -118,6 +118,9 @@ void vring_del_virtqueue(struct virtqueue *vq);
 /* Filter out transport-specific feature bits. */
 void vring_transport_features(struct virtio_device *vdev);
 
+/* Reinitialize a virtqueue without reallocation (safe in noirq context) */
+void virtqueue_reinit_vring(struct virtqueue *_vq);
+
 irqreturn_t vring_interrupt(int irq, void *_vq);
 
 u32 vring_notification_data(struct virtqueue *_vq);
-- 
2.43.0

