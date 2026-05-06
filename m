Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7EF47798D
	for <virtualization@lists.linux.dev>; Wed,  6 May 2026 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084660; cv=none; b=fiGpFNniYwu4vQfcN6jHKs+ihZb2DVhEA1eVUmqbjzCxPJY//TDQiyucxcDZrg3CUNuHpX+kLFekpGTZTpb2scPSAMaGWn4bmwUWBWMFh4xUZJesj/NsJgMsjxff/cM7vz/FGWNTbVfmqmlHpGuOpRwxDKwdYhac5WCmoQy4yjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084660; c=relaxed/simple;
	bh=MWBv1DHfHJ5MORln2uC6zteVz62qSKn6Mmg1BPVPwwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gEALNFquC7QCSERnaEFaS/k2lVUbipiXajbNOjrhhHJ2QnJ/LmSom1mq2HfYJrOPCq22ht7M6raep4e6RNRQQ7h3OwzuEpyovvRkaY5XXzqU3QdvGR+4HL4SQXR8ITavysPMBZyUlP1m0Pg72RUeksQlDed1dJOqAap7wsja5W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qkAPQ3KP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qkAPQ3KP"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82748257f5fso710141b3a.1
        for <virtualization@lists.linux.dev>; Wed, 06 May 2026 09:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778084657; x=1778689457; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0D2OjrENWJxNTLidObtJYsE1ofQWJtzpBHNBO0DSMM=;
        b=qkAPQ3KPhC/IuYFdEaiQvwcPxfRIBM+eciN/9HD6BcueusFHjBW4LBiNuGahJo/bX+
         +FuDAhYLss0e+ggfZdLf35d3vDK2rFQ2cn5roF2CDxjnjuE/ecX37h01gopDWmL9xdOf
         s1jLT9+xkDvz92mc20aPpM6LoAM9H74pTSxnaUuyaxDtKmwpJVDFwsMQ4N1we3u+0y3I
         9IV1dk0GpCHN2gO9KxpTuUs1IwX07LKBjI08izMRdZuARiz77jR4KInDtcu8BXSXEhBj
         wOetAs8cTiLndUUBItPIA52sEFcM6iCes4zOv0fLQ+9sz0/CuAJVuMhDR9zJ4pGg3qqL
         KvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778084657; x=1778689457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r0D2OjrENWJxNTLidObtJYsE1ofQWJtzpBHNBO0DSMM=;
        b=g6h+u6XcCGiJJKAwfjKSE6odqnmKthH7kbwjl1JQtbACdzNLjzBq3IL3/pNKrRXkJA
         hmzWnJbcCCsf86CflPnC65rxiHKoF3JRt3Ls0bUeLiHxKrp6H73002iy/F/Cmua92/dK
         LYzqjEnWFTk992fMMbfd6Y7fovzb1WJ4Tazvy8oCD3ByK6jtoxLlCYX9e07/dmYBAioQ
         PoLVW+KC9mpRT0uR1zeHHBmjjAEJbyqhpBt4Nyq37UjGRCXmy5HBq1fwBQyv/7P2H3Zc
         mSWzPElCaSC5/IdNqxxqJ05xE7gue6+7a+Ts28dZbGy5GDz3bhwEx0T24POGll3jcr79
         TDLw==
X-Forwarded-Encrypted: i=1; AFNElJ+i4qUedF2UqwF2MKlmQUnYJCcIxPxT/S6jVSSjwM53dHPShKFGCctG6oMaam3ThvJOO28SkpHYZvW0ho+DYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxV6ciAiEZ08p3CY/iwNj2tgTEe61owmz3I7If5OMUiKx2KYHIG
	jQ/sPO3O0kHq0mFL7GBLED1kn85/05mAzVm8uTCenhvcGsnp9L7x9LBr
X-Gm-Gg: AeBDievy8nlI5yNzisWcVS2t79HicZSs67qw0KiOUIqYk3tJ4ARXUjDJRCc0rP1rQya
	G/8fkl7VfqGBBdxsLdB82DORpVyvUkqBZLX5xPIepautPVPm3zLLxGLx+I6yyRvqXRobn/Z3YyM
	iEQUqvga3K6zsD7D+ScXJRMUuUwNwIrwO8khkJXf7bt4oMed0Ps5u8lBiiGgGzdUWqMLmC3OMRC
	0gB/P2avHAtDRbxPYJb6SCXxa+fIptuN9vZURrEpvY8g8WajknpNh9qQHog1FVcykIgIY+y1wi3
	CIMZ+nGAtW3s9iRSC405zg9uQloN2/ngkfTOZb2aInl3DlkXR+mEYgVixh2Qo6s9FXcANRvcFJK
	zhsZU/YXqi/NIo446Fw0Mr8aJRbJ3x4VcmakrsM6tAiBt9+g3q9U5awJVJF+KzHxVpiEXd7hlU9
	KxpjG5pEP5cSAblli2SOP9lHbInY6qGNNCcgyRUiQRlmaGgYteS1Rs2n2NzNYbuOLoDlXgKw1Cu
	rZnzNWQzwm3DFJpbDJCl4UtdvxIyQ4RDj4DUA==
X-Received: by 2002:a05:6a00:3d08:b0:81f:5acb:55fc with SMTP id d2e1a72fcca58-83a54de4c38mr3284338b3a.10.1778084656982;
        Wed, 06 May 2026 09:24:16 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8629sm5980337b3a.36.2026.05.06.09.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:24:16 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v8 2/4] virtio_ring: export virtqueue_reinit_vring() for noirq restore
Date: Thu,  7 May 2026 01:22:52 +0900
Message-Id: <20260506162254.25576-3-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506162254.25576-1-baver.bae@gmail.com>
References: <20260506162254.25576-1-baver.bae@gmail.com>
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
2.43.0

