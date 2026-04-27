Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A8B3E4C92
	for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777311129; cv=none; b=ifaCqp1OiIFj0bssRp94hKWXyzyZ41qhZ2xF0PfZGh/hoPAdVxSjcTiNYf7U1lgsaxr/YfsHU7olikqyyFGrNubOFMlzXSXVOC2N4LCIyzG1MATsmWDpEcUK3W3ZYSybFmJKi9Ts/HwKiGOUNzDlTpbl+J25oq1KDJDgjwO+dzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777311129; c=relaxed/simple;
	bh=MWBv1DHfHJ5MORln2uC6zteVz62qSKn6Mmg1BPVPwwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e9mGkCcYHYSi/t5hLECcafsQLretcjnR+dna+iJfl/0VDAfa74u7cuRbV8mXLaSKJi0lvmMRGL2fP9NtMSd338uIOU5xhcBe7YukoNbxLpF5+OqxM5znGj5Hfv9OV5liYAqwVAedXv/U1LZKz/vttSUmwRZ5XOLx6cC4gaFgaIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GW5xxEkD; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GW5xxEkD"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c76b994f7a8so4173994a12.3
        for <virtualization@lists.linux.dev>; Mon, 27 Apr 2026 10:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777311128; x=1777915928; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0D2OjrENWJxNTLidObtJYsE1ofQWJtzpBHNBO0DSMM=;
        b=GW5xxEkDcTSdA+ys6Om6Mh9xeAFhkCsxZYbsoclmAnMOktD4gIJD+22ZiUFdifvtfq
         sDd89whL5nA4hRWvxi76aEiKg1OHtr5RUxntbLT80T7t4v1lhPLP2J8rWRonbvMyDfOc
         lQWGzWTCKuibqecyMHgtGz+gGisYq0OClvyEuKGc/7/m8/6XzngRcNVhn5ho5X5QbY0P
         8DWTTJgJfSNsP8s6tty78czJXeqU/BbkQdJMBA6ehr9tR0IhEuqB2LFTgjDodHv6W6SS
         yERBWNea6QemPCu590yuIZJqKJJtpOkt4IBEVBsrYgT6yLcK0+FmLcT6HPCjSod2gBev
         5l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777311128; x=1777915928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r0D2OjrENWJxNTLidObtJYsE1ofQWJtzpBHNBO0DSMM=;
        b=ilTymOEYl1vkySZpDiGBp+edOWf3LvTk+5FBFL7mAF91Fh59MWuLOVuG8zCUY7A2CC
         UMEQb07VNgmVarz0WqBe59usc4ccI8ANlvYlFkLGeqZPCKegL2XkngFYQ4em99TIHZnC
         Z+adrQRL7UZ/xwJOzuu+86cFL5eyA6NbfWLVGFuli3g/nJV+cveSLxUpSbKhvq1qLmkW
         CdN6bssfpGjoa5CmREJWVCWtr6Vp/50idWA9uUjLe/nes2LQ2sITj8HiJGXV72lQIPKK
         0+7J0z8lpP9Rpn2eN6jeNp7Vw6KIb+TmmvJFcmVwO08IIn9ZXDsPM4PyVX0f1Zry/auF
         E2rA==
X-Forwarded-Encrypted: i=1; AFNElJ8LUJMebkdcuvRFuv/XRL7pXBXhQpsSFuWb7xtmqOxOfbo6cJ205rZfGjzdICXoznH8Nff6gBePCn+mSzvPSg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZRebvcIcAYQPgaE85Sj8dzZOw/efM2eoEjUEOD98QFzoI0oeq
	LH2gTWM3NpWRVtpxVbMq+w5e97N/0aVtIV/wfzos6YOk/C7XWC44kMvb
X-Gm-Gg: AeBDieuPjtlvLVT4SPDAvXeAvvDb4tPqtF/bemwWT5fEZg068/sSaa1ybRctBM5yWbs
	h86JgZ7sPDujxTt+8AxYphOKK9ITDL1CLrps53fQt9AjYcmCxVe39pUhu4Kq2zeT3r/pVQPc6/I
	ulAg822LZ9W0LKh/9w4X2Q1yOIebrn25c04xLPQXeI62vnEjYnmUAHqzgMgV47wYnn9aZl/4rVo
	R3G9cDuy/+Jl4RsQaVZKhoz47QumTBahf4YzEoBJvaVRalao2EekrFBCANIKm4R9dQ1Ty4GqUwg
	kLs2SgbBoRnoHXKGfOpX+g5GKnLmPdoecFPX/3pSzlfwIj7JqFEQPXkrp3r90FGYoV04l1+jKX1
	JJOpqY+0wlHPA5F2mslrC3W2V6N4ZrEpbse/VDN4P1uLoOCQ2AaNxbWdMIZBOq561ZoWpA2jHyg
	Dmnul3GDLAXRrwIEYBYgeZoVcJe2kBgMxLlOLs7VWKzJdZLBOERhV/hSB/74dV4v11pCB25I5FU
	vvL/rTdjWZte78wuw5MIET62K/iQd89kvaLWg==
X-Received: by 2002:a05:6a20:394a:b0:3a2:d68d:9e7e with SMTP id adf61e73a8af0-3a398e542acmr321376637.41.1777311127480;
        Mon, 27 Apr 2026 10:32:07 -0700 (PDT)
Received: from baver-zenith.localdomain ([124.49.88.131])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7977031729sm26246246a12.25.2026.04.27.10.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:32:06 -0700 (PDT)
From: Sungho Bae <baver.bae@gmail.com>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Sungho Bae <baver.bae@lge.com>
Subject: [RFC PATCH v6 2/4] virtio_ring: export virtqueue_reinit_vring() for noirq restore
Date: Tue, 28 Apr 2026 02:30:43 +0900
Message-Id: <20260427173045.28652-3-baver.bae@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260427173045.28652-1-baver.bae@gmail.com>
References: <20260427173045.28652-1-baver.bae@gmail.com>
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

