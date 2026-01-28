Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797DD35FF68
	for <virtualization@lists.linux.dev>; Wed, 28 Jan 2026 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.143.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769608795; cv=none; b=FZUYFiGfT2F4ttzLkbxCdy3hnkMBOgOSPA1e9Tv53Hc1vrFkpjhzZDA6Ur/l/4KpBiRl+C6fMrYQ7zZLHIYtn4SnVfn+UsHoMsd4465Rt8rp4xOQgRMvLKoLwHU2tJbEYOOWwiv6VJk48Ct27c8w87k07CUgDwYuYvRRQeW0f/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769608795; c=relaxed/simple;
	bh=QaQb6j3jXzajzNp05IUg7CUQjd9/7+x6wgHgwHNZtlA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ow7e95mF1W0ZYeIlSWcY2Jq37MwICzhPwSbiggFVRXQKC4+odRsJUP69zkqUwDrzDz1mPC9thnrYmQkDyKpEB7BpbkE33TPqZrqXXD//jHwZ/S88QV5o6q60BdDGeMO6hXcES66/zhEpVeN7oh5X1U6uQksqrs7RVE1kNrqrNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QpZtr5pT; arc=none smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QpZtr5pT"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769608792; x=1801144792;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QaQb6j3jXzajzNp05IUg7CUQjd9/7+x6wgHgwHNZtlA=;
  b=QpZtr5pTWWJ80us5xsZmSIS9xVOcPNW+tE4kbYu3PbzXZWH2U2Bdf1wP
   D4dEanr7Tq4iAG+DJwUy9F6Xu2+bSS9gI/9zZT9ilqfJ+792/s/amToDy
   AzOMMJNGQIwmcs93lqmFxrXJ/U3ooYj3D6SYifSQpSq2/1NUvnd7ztLUe
   5c3zbPwTxNCKHzZO5krxwxIOSc8zeMCjapqK3Al4qhPGjkwXglycpx9MG
   f3hhccB5XIeb51jiTI2GyG4aPrrtS3R4VlgP0zxLkjQWoRS52zp5nOF/C
   qZR5jaymGW4kCRchgnYFRzpWp1044vVl5IyEvKJuLG321zolld/mOX1nb
   A==;
X-CSE-ConnectionGUID: LyeDW+n8SdmzBJpklqtF6w==
X-CSE-MsgGUID: ErcPWLk2RFyq2WbF15jmuQ==
X-IronPort-AV: E=Sophos;i="6.21,258,1763395200"; 
   d="scan'208";a="140798282"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2026 21:59:51 +0800
IronPort-SDR: 697a1657_tI+xNVm1NAb0kwsydEW7awEaOYUa3Zro/WG3duiI8AQ9XSr
 P+bJSD4uQWCs1w1O9C1neDS5HntM7+Y2u9lEFOw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2026 05:59:52 -0800
WDCIronportException: Internal
Received: from c02cd2rwlvdl.ad.shared (HELO neo.wdc.com) ([10.224.28.86])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Jan 2026 05:59:49 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE),
	linux-kernel@vger.kernel.org (open list)
Cc: Alexander Graf <graf@amazon.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] virtio_ring: Add READ_ONCE annotations for device-writable fields
Date: Wed, 28 Jan 2026 14:59:46 +0100
Message-ID: <20260128135947.455686-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Graf <graf@amazon.com>

KCSAN reports data races when accessing virtio ring fields that are
concurrently written by the device (host). These are legitimate
concurrent accesses where the CPU reads fields that the device updates
via DMA-like mechanisms.

Add accessor functions that use READ_ONCE() to properly annotate these
device-writable fields and prevent compiler optimizations that could
break the code. This also serves as documentation showing which fields
are shared with the device.

The affected fields are:
- Split ring: used->idx, used->ring[].id, used->ring[].len
- Packed ring: desc[].flags, desc[].id, desc[].len

Reported-by: Kernel Concurrency Sanitizer (KCSAN)
Signed-off-by: Alexander Graf <graf@amazon.com>
[jth: Add READ_ONCE in virtqueue_kick_prepare_split ]
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/virtio/virtio_ring.c | 88 ++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ddab68959671..74957c83e138 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -222,6 +222,63 @@ struct vring_virtqueue {
 #endif
 };
 
+/*
+ * Accessors for device-writable fields in virtio rings.
+ * These fields are concurrently written by the device and read by the driver.
+ * Use READ_ONCE() to prevent compiler optimizations and document the
+ * intentional data race.
+ */
+
+/* Split ring: read device-written fields from used ring */
+static inline u16 vring_used_idx_read(const struct vring_virtqueue *vq)
+{
+	return virtio16_to_cpu(vq->vq.vdev,
+			       READ_ONCE(vq->split.vring.used->idx));
+}
+
+static inline u32 vring_used_id_read(const struct vring_virtqueue *vq,
+				     u16 idx)
+{
+	return virtio32_to_cpu(vq->vq.vdev,
+			       READ_ONCE(vq->split.vring.used->ring[idx].id));
+}
+
+static inline u32 vring_used_len_read(const struct vring_virtqueue *vq,
+				      u16 idx)
+{
+	return virtio32_to_cpu(vq->vq.vdev,
+			       READ_ONCE(vq->split.vring.used->ring[idx].len));
+}
+
+/* Packed ring: read device-written fields from descriptors */
+static inline u16 vring_packed_desc_flags_read(const struct vring_virtqueue *vq,
+					       u16 idx)
+{
+	return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].flags));
+}
+
+static inline u16 vring_packed_desc_id_read(const struct vring_virtqueue *vq,
+					    u16 idx)
+{
+	return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].id));
+}
+
+static inline u32 vring_packed_desc_len_read(const struct vring_virtqueue *vq,
+					     u16 idx)
+{
+	return le32_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].len));
+}
+
+/*
+ * Note: We don't need READ_ONCE for driver->device fields like:
+ * - split.vring.avail->idx (driver writes, device reads)
+ * - packed.vring.desc[].addr (driver writes, device reads)
+ * These are written by the driver and only read by the device, so the
+ * driver can safely access them without READ_ONCE. The device must use
+ * appropriate barriers on its side.
+ */
+
+
 static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
 static void vring_free(struct virtqueue *_vq);
 
@@ -736,9 +793,10 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 	LAST_ADD_TIME_INVALID(vq);
 
 	if (vq->event) {
-		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
-					vring_avail_event(&vq->split.vring)),
-					      new, old);
+		u16 event = virtio16_to_cpu(_vq->vdev,
+				READ_ONCE(vring_avail_event(&vq->split.vring)));
+
+		needs_kick = vring_need_event(event, new, old);
 	} else {
 		needs_kick = !(vq->split.vring.used->flags &
 					cpu_to_virtio16(_vq->vdev,
@@ -808,8 +866,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
 static bool more_used_split(const struct vring_virtqueue *vq)
 {
-	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
-			vq->split.vring.used->idx);
+	return vq->last_used_idx != vring_used_idx_read(vq);
 }
 
 static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
@@ -838,10 +895,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	virtio_rmb(vq->weak_barriers);
 
 	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
-	i = virtio32_to_cpu(_vq->vdev,
-			vq->split.vring.used->ring[last_used].id);
-	*len = virtio32_to_cpu(_vq->vdev,
-			vq->split.vring.used->ring[last_used].len);
+	i = vring_used_id_read(vq, last_used);
+	*len = vring_used_len_read(vq, last_used);
 
 	if (unlikely(i >= vq->split.vring.num)) {
 		BAD_RING(vq, "id %u out of range\n", i);
@@ -923,8 +978,7 @@ static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_used_i
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
-			vq->split.vring.used->idx);
+	return (u16)last_used_idx != vring_used_idx_read(vq);
 }
 
 static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
@@ -1701,10 +1755,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 				       u16 idx, bool used_wrap_counter)
 {
-	bool avail, used;
 	u16 flags;
+	bool avail, used;
 
-	flags = le16_to_cpu(vq->packed.vring.desc[idx].flags);
+	flags = vring_packed_desc_flags_read(vq, idx);
 	avail = !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
 	used = !!(flags & (1 << VRING_PACKED_DESC_F_USED));
 
@@ -1751,8 +1805,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	last_used_idx = READ_ONCE(vq->last_used_idx);
 	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
 	last_used = packed_last_used(last_used_idx);
-	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
-	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
+	id = vring_packed_desc_id_read(vq, last_used);
+	*len = vring_packed_desc_len_read(vq, last_used);
 
 	if (unlikely(id >= vq->packed.vring.num)) {
 		BAD_RING(vq, "id %u out of range\n", id);
@@ -1850,6 +1904,10 @@ static bool virtqueue_poll_packed(struct virtqueue *_vq, u16 off_wrap)
 	bool wrap_counter;
 	u16 used_idx;
 
+	/*
+	 * Note: off_wrap is from virtqueue_enable_cb_prepare_packed() which
+	 * already used READ_ONCE on vq->last_used_idx, so we don't need it again.
+	 */
 	wrap_counter = off_wrap >> VRING_PACKED_EVENT_F_WRAP_CTR;
 	used_idx = off_wrap & ~(1 << VRING_PACKED_EVENT_F_WRAP_CTR);
 
-- 
2.52.0

