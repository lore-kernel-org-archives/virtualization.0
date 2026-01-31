Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584022F0C45
	for <virtualization@lists.linux.dev>; Sat, 31 Jan 2026 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769855311; cv=none; b=fwb6Q7HYSmY+cpE0NMabmx96G4BAJymrTn+DlFDvUv4ESGNKqbH8SV+664duE/YXLJuvXRlK0aJYn9XrNucK8/tpc8eiTuZIFc5/RAY3IEl3bmSHZ8P2P6Z5dXq0uQ1HiGcqwUjlPpa+1Q9pmSXnpi3LERzCfg9uyvpRKoOPAFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769855311; c=relaxed/simple;
	bh=DMCxBkoHpftcCdx0n/bqP7jWub7fpG/9GDmaVwg3dB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQrAYhxQaTbfjpRdx+cfdb/JzO37YzXf3btj46+PGYkgBcAqFNG07rsElVaiMi2fTLBrfMRGMuIbgNlQL7ZUl25//Tl5gl5k3WUdQIB4dp/Ns8oeKhUWX1NEe33AUbjcY1cJA3IaIgjusWlIBxPLCLe2cTQ/4GG3Us4peyRpd44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=YTMZ4hBb; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="YTMZ4hBb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769855310; x=1801391310;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DMCxBkoHpftcCdx0n/bqP7jWub7fpG/9GDmaVwg3dB0=;
  b=YTMZ4hBb1LvsLcfWCviGyq6DaExiwv7wZEu4nztGvGzQnfu5h2d8goW4
   bI48DgMLvcMITq9PNDIQd9PPUQ+XglPl5eSNwwgRBrqaJOHL2hDOLhSdD
   yy6BOyu9VM1UzJ+ugIHSPrYBlvHIT1yNRkI9cmYx6aSFfZieZ/TZdammx
   3gk/QZxbXrQlEMF0MwD7dYCjDReza5Ggo8eM3be2cGs8g911tdP3Gt0eg
   V+3aRg3/2djF/pdBVBROkHGSk4kqv5ULR+r7Hz8D+6qrDy8s0ulvjMfcg
   oFt6KsaoqggxYMLCqzVrajj6kLGaUbIdyNMNcXdtt3wMAVlA+WPII+eRr
   A==;
X-CSE-ConnectionGUID: WBBt3lB3Q8eY2xQESKcSWg==
X-CSE-MsgGUID: OIacozc1Rh6Fh0KROr613w==
X-IronPort-AV: E=Sophos;i="6.21,264,1763395200"; 
   d="scan'208";a="139536079"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2026 18:28:23 +0800
IronPort-SDR: 697dd947_/mHDnvPKe2YKXkLZxgHG6Bavo1MdSqvRter0601tOW9SvWx
 YO1JG3BU/GtsWLBaiaUHN1dOSLoWw+v0RdSFj5g==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 Jan 2026 02:28:24 -0800
WDCIronportException: Internal
Received: from gvg0wwcx93.ad.shared (HELO neo.fritz.box) ([10.224.28.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 31 Jan 2026 02:28:21 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Alexander Graf <graf@amazon.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] virtio_ring: Add READ_ONCE annotations for device-writable fields
Date: Sat, 31 Jan 2026 11:28:09 +0100
Message-ID: <20260131102810.1254845-1-johannes.thumshirn@wdc.com>
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
device-writable fields and prevent compiler optimizations that could in
theory break the code. This also serves as documentation showing which
fields are shared with the device.

The affected fields are:
- Split ring: used->idx, used->ring[].id, used->ring[].len
- Packed ring: desc[].flags, desc[].id, desc[].len

This patch was partially written using the help of Kiro, an
AI coding assistant, to automate the mechanical work of generating the
inline function definition.

Signed-off-by: Alexander Graf <graf@amazon.com>
[jth: Add READ_ONCE in virtqueue_kick_prepare_split ]
Co-developed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Alexander Graf <graf@amazon.com>
---
Changes to v2:
- Add AI statement (agraf)
- Add R-b from agraf
- Update comment (mst)
- Add split to function names handling split rings (mst)
- Add vring_read_split_avail_event() (mst)

Changes to v1:
- Updated comments (mst, agraf)
- Moved _read suffix to prefix in newly introduced functions (mst)
- Update my minor contribution to Co-developed-by (agraf)
- Add "in theory" to changelog
---
 drivers/virtio/virtio_ring.c | 72 +++++++++++++++++++++++++++++-------
 1 file changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ddab68959671..53d5334576bc 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -222,6 +222,55 @@ struct vring_virtqueue {
 #endif
 };
 
+/*
+ * Accessors for device-writable fields in virtio rings.
+ * These fields are concurrently written by the device and read by the driver.
+ * Use READ_ONCE() to prevent compiler optimizations, document the
+ * intentional data race and prevent KCSAN warnings.
+ */
+static inline u16 vring_read_split_used_idx(const struct vring_virtqueue *vq)
+{
+	return virtio16_to_cpu(vq->vq.vdev,
+			       READ_ONCE(vq->split.vring.used->idx));
+}
+
+static inline u32 vring_read_split_used_id(const struct vring_virtqueue *vq,
+					   u16 idx)
+{
+	return virtio32_to_cpu(vq->vq.vdev,
+			       READ_ONCE(vq->split.vring.used->ring[idx].id));
+}
+
+static inline u32 vring_read_split_used_len(const struct vring_virtqueue *vq, u16 idx)
+{
+	return virtio32_to_cpu(vq->vq.vdev,
+			       READ_ONCE(vq->split.vring.used->ring[idx].len));
+}
+
+static inline u16 vring_read_split_avail_event(const struct vring_virtqueue *vq)
+{
+	return virtio16_to_cpu(vq->vq.vdev,
+			       READ_ONCE(vring_avail_event(&vq->split.vring)));
+}
+
+static inline u16 vring_read_packed_desc_flags(const struct vring_virtqueue *vq,
+					       u16 idx)
+{
+	return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].flags));
+}
+
+static inline u16 vring_read_packed_desc_id(const struct vring_virtqueue *vq,
+				            u16 idx)
+{
+	return le16_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].id));
+}
+
+static inline u32 vring_read_packed_desc_len(const struct vring_virtqueue *vq,
+				             u16 idx)
+{
+	return le32_to_cpu(READ_ONCE(vq->packed.vring.desc[idx].len));
+}
+
 static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
 static void vring_free(struct virtqueue *_vq);
 
@@ -736,8 +785,7 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 	LAST_ADD_TIME_INVALID(vq);
 
 	if (vq->event) {
-		needs_kick = vring_need_event(virtio16_to_cpu(_vq->vdev,
-					vring_avail_event(&vq->split.vring)),
+		needs_kick = vring_need_event(vring_read_split_avail_event(vq),
 					      new, old);
 	} else {
 		needs_kick = !(vq->split.vring.used->flags &
@@ -808,8 +856,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
 static bool more_used_split(const struct vring_virtqueue *vq)
 {
-	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
-			vq->split.vring.used->idx);
+	return vq->last_used_idx != vring_read_split_used_idx(vq);
 }
 
 static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
@@ -838,10 +885,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	virtio_rmb(vq->weak_barriers);
 
 	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
-	i = virtio32_to_cpu(_vq->vdev,
-			vq->split.vring.used->ring[last_used].id);
-	*len = virtio32_to_cpu(_vq->vdev,
-			vq->split.vring.used->ring[last_used].len);
+	i = vring_read_split_used_id(vq, last_used);
+	*len = vring_read_split_used_len(vq, last_used);
 
 	if (unlikely(i >= vq->split.vring.num)) {
 		BAD_RING(vq, "id %u out of range\n", i);
@@ -923,8 +968,7 @@ static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_used_i
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
-			vq->split.vring.used->idx);
+	return (u16)last_used_idx != vring_read_split_used_idx(vq);
 }
 
 static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
@@ -1701,10 +1745,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
 				       u16 idx, bool used_wrap_counter)
 {
-	bool avail, used;
 	u16 flags;
+	bool avail, used;
 
-	flags = le16_to_cpu(vq->packed.vring.desc[idx].flags);
+	flags = vring_read_packed_desc_flags(vq, idx);
 	avail = !!(flags & (1 << VRING_PACKED_DESC_F_AVAIL));
 	used = !!(flags & (1 << VRING_PACKED_DESC_F_USED));
 
@@ -1751,8 +1795,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
 	last_used_idx = READ_ONCE(vq->last_used_idx);
 	used_wrap_counter = packed_used_wrap_counter(last_used_idx);
 	last_used = packed_last_used(last_used_idx);
-	id = le16_to_cpu(vq->packed.vring.desc[last_used].id);
-	*len = le32_to_cpu(vq->packed.vring.desc[last_used].len);
+	id = vring_read_packed_desc_id(vq, last_used);
+	*len = vring_read_packed_desc_len(vq, last_used);
 
 	if (unlikely(id >= vq->packed.vring.num)) {
 		BAD_RING(vq, "id %u out of range\n", id);
-- 
2.52.0

