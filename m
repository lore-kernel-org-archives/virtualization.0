Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81E27AC4D
	for <virtualization@lists.linux.dev>; Sat, 16 May 2026 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778896753; cv=none; b=Yiuo+fxFX7/yCkGFgMlIjjcBMQGykLCsCG9LejCzpa/P/jvan96Grdi6CTTP03SHETk3DCXMb2VhU4xrR2x2P3sWnAbTzgO/WqHULEULxMUadZyeaJgElpOqU1CpHMAjaK1s46rG0C1QxrHiqKv1LzH3kLrOBYcxt7g8s60DXbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778896753; c=relaxed/simple;
	bh=3U2JuWoZlQw/6bodDnQIfAdeJKPuMhDGQJGcPm8dlt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dHvHpQoQN5/1t8AvZuDaX7RHdPhWMqz6F70z5st1Tawm9kugcKcL04QDxYGGHuxOrh4MHUdaa0RIDaHoJ934AhO7ji1uWY+xz0idi0+pekcvoOvjFZBiLl+mweJ5ZJPEmaML6z5wlJGDAIKIyBCFMN9mnHRbFQaXboNgDCiRHzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g45msCF5; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g45msCF5"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8028fa6039so280545a12.2
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 18:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778896751; x=1779501551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+/zy+vJjZtJy4sI1VAJYrcW/C5hH9QlOgZTXMyZTJA=;
        b=g45msCF5555FSxQTjpjeU1bJN5fH0MRLn12gtXgRIbBDneNGnSFvvkx7kAtBemPQX9
         oMY3qPCZgflGzqwAZKjumy5GxHW9+v3sfhXVN3X/SP6cenasPwCQ/0DgHq2PMEei1tis
         oGV9C34lnyACDdMqQlteixB84kpO8QQ2AZ7qPH0MAap/Toh/mLXGk6pKumhdr4zwQlKH
         MSV6whr2/da8DwkTWvIo/rgonHjz7ms16sIs0YYpDZlAKDzzXsnN9ayJ1Vi1JkxQavQG
         xVQBYk3cvBT+Nuc2yTe+A1zkDLbaAEws7o4m03ecBmqI/id9GmlxWccCe9FEW8yBie/C
         RpJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778896751; x=1779501551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y+/zy+vJjZtJy4sI1VAJYrcW/C5hH9QlOgZTXMyZTJA=;
        b=c2zmSNCegSn0vjdGSOAzCHgj9UjPyNugaxC0j8kFiH6pMxglH5n7SkIjswt3KmnUZn
         XrLBUhG8WjOCvGKQVrwQnYiwQrDJj50vA+HIVi3d8G2X01TJx3myZpQ8DNsU1jDU+ncE
         FJGHk/vv0VOkuQoJk0Upa6OWKaIObQqxI4X3lQkkgTqjPZ+Yi6JwRtVoRjxdQryqKo40
         7kOZ1Qa3ppCRWoiW+FHnawLnvn0Sr0Znlli2+9rLGqC9Zq1RcQqnR3zR24u4oZmFxR+J
         3v0gpoiZZK1IWUC3ftiGtBa5ajX9V5y4FLAhu1HYdEjuffmF9hIz2YWgDcA0kI9/Skvi
         lYdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9A4zhwvpQFOsxHJosPrGH2lVDNr7v55Rqkv16GpuVWiSLo/NGh/GyE8ykr9dbn6BssdjWzKSDiI7GsTro0qQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6XjjU48bPJ2G1SnbfJsQQWZN1IL0yX2ZYaWVdsodgHx1fisj9
	2MKiHqRXk1DEnzECGr41gpQGDVlg7nRoFC10ugfpAZ2iTEux4h65o1/E
X-Gm-Gg: Acq92OHs3E3hLtpLR7VI6y3cwcN4LztFYXfXB0RuF6cgPjscuA/VmBQC2XeoM2tBZ51
	VkPUinv0lUi0O8t7z/Xu0cygz1mpsX42O63cH8NZqGXjGweL7tGasCzrElkXuMs32O52gGiB7f/
	ACVMf/lcMHECj4IWlDr8oEbMBNFzusonxO845S4eeDC7E9v/wCz0BiBZ12PFfRRIVEWqwVMGI3n
	FI6TOUn8pgwT+kZeAetYnfxi/lZxGFf8+5bfYA/YomErAjq8p5fgYDaiuiiXdSPOpzHraLaTtsG
	IFsca0xGZhq36gDUkmSbfwG7cwnjfGD61rF2jCLfSykbsD9VBlZpKlk04uj1e5X92byDbULXHEg
	mwNLz4JeC30+9PbFKOyvacUFng2hOVOQHQA8FevZhJ1i9tiYQHkisuR5IBIdnXQm6joEZvmJ0mG
	tWcxahT2JQjneJnPDhu6hS87C31w/7EyLS6wId7OqRV15w6KIYtts+lHdDSmfXsV/XfsWghd236
	zP/J9M8BE1mw0xx3XPfEC3Hy88=
X-Received: by 2002:a05:6a20:a120:b0:3a2:c685:f9bf with SMTP id adf61e73a8af0-3b22edfcbf2mr7146917637.47.1778896750996;
        Fri, 15 May 2026 18:59:10 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb07b007sm6605080a12.11.2026.05.15.18.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 18:59:10 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	stephan.gerhold@kernkonzept.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v9 3/5] virtio_ring: export virtqueue_reinit_vring() for noirq restore
Date: Sat, 16 May 2026 10:57:54 +0900
Message-Id: <20260516015756.20948-4-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260516015756.20948-1-baver.bae@gmail.com>
References: <20260516015756.20948-1-baver.bae@gmail.com>
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
 drivers/virtio/virtio_ring.c | 58 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio_ring.h  |  3 ++
 2 files changed, 61 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index fbca7ce1c6bf..d3339b820f6b 100644
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
@@ -3936,5 +3945,54 @@ void virtqueue_map_sync_single_range_for_device(const struct virtqueue *_vq,
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
+ *
+ * Return:
+ * 0 on success, or -EBUSY if preconditions are not met.
+ */
+int virtqueue_reinit_vring(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	unsigned int num = virtqueue_is_packed(vq) ?
+		vq->packed.vring.num : vq->split.vring.num;
+
+	/* All in-flight descriptors must be completed or detached */
+	if (WARN_ON(vq->vq.num_free != num))
+		return -EBUSY;
+
+	if (virtqueue_is_packed(vq)) {
+		virtqueue_reset_packed(vq);
+	} else {
+		/*
+		 * Split queue shadow index should match the visible avail
+		 * index when the queue is fully quiesced.
+		 */
+		if (WARN_ON(vq->split.avail_idx_shadow !=
+			virtio16_to_cpu(vq->vq.vdev,
+					vq->split.vring.avail->idx)))
+			return -EBUSY;
+
+		virtqueue_reset_split(vq);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtqueue_reinit_vring);
+
 MODULE_DESCRIPTION("Virtio ring implementation");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index c97a12c1cda3..8b421fef4fef 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -118,6 +118,9 @@ void vring_del_virtqueue(struct virtqueue *vq);
 /* Filter out transport-specific feature bits. */
 void vring_transport_features(struct virtio_device *vdev);
 
+/* Reinitialize a virtqueue without reallocation (safe in noirq context) */
+int virtqueue_reinit_vring(struct virtqueue *_vq);
+
 irqreturn_t vring_interrupt(int irq, void *_vq);
 
 u32 vring_notification_data(struct virtqueue *_vq);
-- 
2.34.1

