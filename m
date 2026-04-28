Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095D3C6A56
	for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388896; cv=none; b=rDhkz1bRamzpFj1xOE5qZ4LUXMnaBb/2g2V3UpdE8cL3FwZtJ5LypEyra/BiNzPtnnTYFrYDlvXoqjZr9fnBDdgVaGHFDcbGayNV8Ujaiqg8ZQiNBaC+6b+HkUyr/IRuWSIJvbOCnes/r86MRr5GGhxcEE6YPPJiVy5hgOeE0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388896; c=relaxed/simple;
	bh=MWBv1DHfHJ5MORln2uC6zteVz62qSKn6Mmg1BPVPwwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k8mGv1GzYVyOdL1RhkCTu0Qxb6HlRlAqSy5kQT3ZOiqlU3AbVlecr1XnivsJoCxjl9KNnoSorrgs8R1fH0KdTe7hV8BWcvOAeG/QOXRoO6mHChIKpEr/JPuFopUT2X/AiX2HPWzvJNptGZRY36Uk5gAAVWt17ZoLMtqE+I7hnqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhRtJN91; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhRtJN91"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35fc0d7c310so7494664a91.1
        for <virtualization@lists.linux.dev>; Tue, 28 Apr 2026 08:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388893; x=1777993693; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0D2OjrENWJxNTLidObtJYsE1ofQWJtzpBHNBO0DSMM=;
        b=qhRtJN91SRfyydRIIae3nz2S5sXHPlfSUgMa1BEQAnbpN/NJw7qHH/85bxK6xYsURR
         4Z1mCc9DnrDjvpqzgIvGnaYdddgPF1oJFd1utZFseha/eGIINsJPaKinnDTATY7xqWEg
         YcxAwWKNp8fjt+R/vfGRXuDuNEtqb29JftRINNf2FIUQVh7Zoznf0IF60OO+n6euyG2E
         SvlvGmKR3Z13wXcVuxE343n/+dS3OEncmicn0ex7dZk7gBJZvJ5YRa3PGprDpyKgoYS6
         kMZ6tER8CetkZvEAjGnOimxG9AoZTxNdxqzBhs+l0e+ouBudgRWejWsE8wfHPsJlRh2P
         QBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388893; x=1777993693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r0D2OjrENWJxNTLidObtJYsE1ofQWJtzpBHNBO0DSMM=;
        b=QQcfmx3ospAI6c3D0vgBriUUqIJDrzMS/SYlPN4sIQFlC/2lrTbIp9vfCFLY3uW7r3
         FJ+bMFpYP33Mn6inKfuNfH2Qa5A5Ojh9xUdFAdwb8LEo/b9xslx+IfmtgiANs76Pn//x
         XgFRUIUzGj3TeOK+5faYQwom/wQlJL/srCAQsYeomMBgWDbrYV9jiQfkeJQsthSkV9M5
         cBphVN9VVjCDN06VTCVDK+dz1r59ssHY1IR0Hc+M1eD58iurmvzeYIcXt815W7hPUgg5
         P5wejEXde4Lic56d2k+Ih4p7U1qVjwqJeXuTsy2Ux1YlhMJGUBjX0BtvHuQ0++5ULqw4
         1JBQ==
X-Forwarded-Encrypted: i=1; AFNElJ+JGNrQ+RM9kFOBWZ7tgpodG6GcVE4IP6E8ni9N2CvxegNmTT360Wua5z9MqMM6YYUaT8lrx6vk4omR9RRWjA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwrjtkoM2ORihvTNCUlr4+4GBbxdjZKTQIBuARZTFaI02Mw2Gd
	0GMMGTdhgn2SgHnRHsTzsIfmW6QvF3dTm6KfoLJWBJbB82HGQ7POh60wt09tWDf+
X-Gm-Gg: AeBDiev7v/72wNNaYudS4kAAOjq9RdS2ZqEa86CxsOgnGHyWwQ8fVh3vfArrj/BUf7h
	rtU5ymQY9ZbrmFy6MsZlfK7T/DnzIVih2X1AyMZCVK5W3+HvliO3Euw/uxb4ogi7MRACwn/UQDd
	Ks9rA0X5Cs+k0+hvuYbdwiW6+9JkZPiOtukcJQFwArc8U0w/75OVEeFKGxJi14c8E13Vba7cZys
	sLHzmc38NyiIsclRvwSJBD+muxcEHpQz0hYYrbu07oqvi1d1tah5e8QGD8WedP3ISF25Tx1w8Sl
	ubulZa+F6++oiiqkCyBYyG2HyVxcxpObVvN0a0pxVyKfOiXOKeqgwtRSJW5G2QxCgcZpTXD/Ait
	rg2im/fHeQBbiPKW47N8ll5xxdbh9Xe+CP4e5Fc4F/7neFv8OH5FyQVxEY8wPjzfG6VekwlVfls
	+e9wN71HC9nAmppSeXoDLK36/DkTVtcASg/eyX385F0paBnoek/H39MoOvopkqRx20zoxkwI+jO
	eT6Fhcejg3zdFIhMZ2R2Ru+DoENIjN0E6jpeQ==
X-Received: by 2002:a17:90b:3bcd:b0:35f:b5df:449 with SMTP id 98e67ed59e1d1-3649204f819mr3632492a91.21.1777388892918;
        Tue, 28 Apr 2026 08:08:12 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490bd66f6sm1606127a91.3.2026.04.28.08.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 08:08:12 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v7 2/4] virtio_ring: export virtqueue_reinit_vring() for noirq restore
Date: Wed, 29 Apr 2026 00:07:40 +0900
Message-Id: <20260428150742.23999-3-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428150742.23999-1-baver.bae@gmail.com>
References: <20260428150742.23999-1-baver.bae@gmail.com>
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

