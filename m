Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7281C3BED64
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 12:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777033822; cv=none; b=VOfjLG2QtugXcfpOO+u0+Y/4zoF1JtLvAh+SBWPchZF8Lc5nWaTB0BM6Sqd/pSK/+Sh/H9k8/G7FvEbkhsuZcoi2y66f5IpjibgutR1wLlHZe/COQ77bYWkdFIPW8+A34w7euRFBI9JZ55T94skrI2tR/Tx5pMvQUalQ81jMsZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777033822; c=relaxed/simple;
	bh=Wp+rXTYV6cCR7GQckednAxBMcKVMT6SIRlSrHu1tg4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J431ZPi+GRW60bfaHS3O52xGXw84grgghDB6I9k9sD7+KghoEbsBTmQbuY5SyKgHJMihYW5jRKIKc8xxLy4dMufZlxj+/4IYMoVSXPgCIEWeCLGUNqPnWJzCc+rc/15/UmDj95p7OexJTP+dDJuq0eGXDJXYje2ql9AqBfhgZ9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngDt6utJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngDt6utJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad9f316d68so35141585ad.2
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 05:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777033821; x=1777638621; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zfrLDAY7+No90zlR6HffZqbGM74lFTvO1IbltHEt5HY=;
        b=ngDt6utJlq/RCvwp9Gucnm26UjGYo8JerIF+S1LNKN3ZOCRCtcq+VzcMbDFADEB+pZ
         WgqrPf0pO4plUwbEskfl5SUr2iF6hFwshYht6NrZU1guqc377WrykdgU0Wwuc35U5wXd
         PE4YU8FCMw8diwBQ9kf1OhDhxa4VtAJaeYtRPoSYFCuTIRADv7+xVCtbSG4lZYS5JElO
         mRhompIG9Ia94vz9nRdhSGXqf97PJj3R29Gffqxc2BjE6R9HAvTXscm8+l3VcKnUqzHa
         uobuWig6qKFnTjklkQTg55NQ+0fvkEYIZT5WzBukq1AS7OOZGBg4WaGixmdL/Z2cYqtd
         pz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777033821; x=1777638621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zfrLDAY7+No90zlR6HffZqbGM74lFTvO1IbltHEt5HY=;
        b=oDD3/hddGMdSoZZatWiRt2oi2582oKWYaNQxBwTwPQ/3fyvTOJvDfJpzXzFpuUQIx3
         J8SpSYj7hkR8YH9EjyVf3FE/0Waq7PTLIKo/xupSgjwagkQ3SSD651HAYCuXgMQocU1d
         2Z8rNqZhZSFtimxlVgn16w+LSM4U+kenWNLLkphNT5GYAKay4d7yvTB9ZwjBMjoXQZgA
         9WwwYlqHdX2NrbYHpOdr3d4nkaZr2G+SA3lisLJwIFMxw1HmXzeMD7qcKUBGbC70gAQL
         hyyUekAQ4NIPgWURlf6Bwv7uDXFjTZFGTizLHDN2x0ZTHEPUp3jfmjpAF/2eTC3pFSxN
         INvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pX4XO+Q3BLK0laieffrjc2xKL/HxDBHH+u4mcT+6/7/zoJgTUmaucJ+4TUvFfc1zoJMc+hRZlTzoXOdkj2w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzX3SsldoYfsF6zxu5Ie/BA90dQny1o1EdpluGf0h4MI9GT3B/J
	FjMqia93faLXQ9RNuqrkYZDe0tc5CS6/IntdHvZDq3PwZCyw7q0EvUvP
X-Gm-Gg: AeBDieviqPUyhWssgO23T8UsDaG8SZb7S3wPfaF8bgW/e0byg+GyhLbXYa61Re9IGR0
	E3D90lbm93yb4AdmMPn6vG64yqkO7LZpjiIvoMM5IS2LtuCCSBe4VFSrVR+fNsoR1JI2iAaW713
	oWPuFc2KCLYXdnSynWpWjq5DjkwKxd55dAsxN6VEhpgmOCgNwvSil8NAJEzAwt4h8+CorKqZUcn
	5oKOJlKL0c4/8m4NW4gRbSfvk+xCbtRRUdl+Tzu0XolYxXkzllSw2gZ/vI9yeu9skXpynOaWWM1
	eaOmqR0gju3wkKBykKjpEfczBqvyB+FTQDi/haUYap7kKlETOEKZBckgSf1PPgoFDOuXqVhWSjC
	CqPAzxnYg3EsJRVc2DCxrsZKBljkar+5A9RqjMObTDetgJCCLhM0vkLKfBjPNpg3hS0cfA5yY0A
	F99u860/c12AS2XrcKeRaSUhAuIIniiDMp/Z4+keVsAmTqAxDyG6wXf3zEu5mRpzt4m2h4My8dd
	94kWYEjxHOitx+uPLkU7fp3S8WUExa9iJ9Mycv5usFOmhvm
X-Received: by 2002:a17:902:8f90:b0:2b4:5f96:184d with SMTP id d9443c01a7336-2b5f9e5da53mr238303975ad.5.1777033820417;
        Fri, 24 Apr 2026 05:30:20 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff734sm218006415ad.10.2026.04.24.05.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 05:30:19 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v5 2/4] virtio_ring: export virtqueue_reinit_vring() for noirq restore
Date: Fri, 24 Apr 2026 21:29:52 +0900
Message-Id: <20260424122954.273-3-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260424122954.273-1-baver.bae@gmail.com>
References: <20260424122954.273-1-baver.bae@gmail.com>
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

