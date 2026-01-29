Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276313876CE
	for <virtualization@lists.linux.dev>; Thu, 29 Jan 2026 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769689005; cv=none; b=Boro7As5BpTdAWvAfcTF7wWNmXcbBY5okJJcj+UMSo9/lR6iitf+UbtCpF7bRhDyzbtjedS+jv7GPUzDekkpj37ozJMAXHz9RpjCL5YQNmWTbmexLAByGpRPVDC70ZBlzHksfIzfj6YfF17z51LEA6LOjphLaOY0ZiSYJiB5d7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769689005; c=relaxed/simple;
	bh=JMkdvNMJSlH436HKF5aGctvMhpbIyLyE7TXVNQEAl6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYQLcAgqOlIy70qvzVVCKBwDXKg3YTisNKMpHhzMTdrknEfTXSuPqsZtfJRNrBwBGz1ykRia7PM1scbPSesq6xW/VYzNan3iupxOG+zr6sOjRRTJlVqQjhVlSgZtZxrE6MYMrMkpfBEeGKVf/keDi+zDvuknoxdbrAetQyO3v9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=cCCzBOHL; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cCCzBOHL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769689003; x=1801225003;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JMkdvNMJSlH436HKF5aGctvMhpbIyLyE7TXVNQEAl6Y=;
  b=cCCzBOHLcO2nMngkbm7QQtFQs61061pgkS2uvoJ1McRuH5vEA099c11K
   IaEwD/SuasHZPG4AilOmdLqlwyCBWZPFfN4P/GxVUhWolgN+p6ajS2EsO
   JMdH0Qkt/iHviZvxcAkX3omTZLQK/WluNFsZKwR+wR8X0aKWAt1/tUWCB
   fvf60aGMUymCIMMvScTm31glUblgphdHOjh4epa5129gkVwdgFZeJU5of
   c5OuZDzQ471hPcemI5VKYwU4shCdcX7x6STOl3HSiJ555c6WsmNc2qIj9
   B/QpHhhNuwRvLiOd5JUVWhwXS51cCPfK1/SLKenbj54+gnnkBvAjXUotK
   Q==;
X-CSE-ConnectionGUID: NtQGVIzuSs2WyFVnICtc8g==
X-CSE-MsgGUID: 4mEm+WUVSoq2uzfTBsWejA==
X-IronPort-AV: E=Sophos;i="6.21,260,1763395200"; 
   d="scan'208";a="136271620"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2026 20:16:36 +0800
IronPort-SDR: 697b4fa4_yJNPIWRv5zYLGtOngewxM3AoIi/NjQEaUTlaiYPtFxFeMBE
 VUDSfsNfHPWsuIiE4UKhdwdgSiFLelZBjpK5vlA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Jan 2026 04:16:37 -0800
WDCIronportException: Internal
Received: from wdap-6j0m9urvwf.ad.shared (HELO neo.fritz.box) ([10.224.28.90])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2026 04:16:34 -0800
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
To: 
Cc: Alexander Graf <graf@amazon.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev (open list:VIRTIO CORE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] virtio_ring: Add READ_ONCE annotations for device-writable fields
Date: Thu, 29 Jan 2026 13:15:58 +0100
Message-ID: <20260129121604.745681-1-johannes.thumshirn@wdc.com>
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

Signed-off-by: Alexander Graf <graf@amazon.com>
[jth: Add READ_ONCE in virtqueue_kick_prepare_split ]
Co-developed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v1:
- Updated comments (mst, agraf)
- Moved _read suffix to prefix in newly introduced functions (mst)
- Update my minor contribution to Co-developed-by (agraf)
- Add "in theory" to changelog
---
 drivers/virtio/virtio_ring.c | 69 ++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ddab68959671..66802d11d30e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -222,6 +222,48 @@ struct vring_virtqueue {
 #endif
 };
 
+/*
+ * Accessors for device-writable fields in virtio rings.
+ * These fields are concurrently written by the device and read by the driver.
+ * Use READ_ONCE() to prevent compiler optimizations and document the
+ * intentional data race and prevent KCSAN warnings.
+ */
+static inline u16 vring_read_used_idx(const struct vring_virtqueue *vq)
+{
+	return virtio16_to_cpu(vq->vq.vdev,
+			       READ_ONCE(vq->split.vring.used->idx));
+}
+
+static inline u32 vring_read_used_id(const struct vring_virtqueue *vq, u16 idx)
+{
+	return virtio32_to_cpu(vq->vq.vdev,
+			       READ_ONCE(vq->split.vring.used->ring[idx].id));
+}
+
+static inline u32 vring_read_used_len(const struct vring_virtqueue *vq, u16 idx)
+{
+	return virtio32_to_cpu(vq->vq.vdev,
+			       READ_ONCE(vq->split.vring.used->ring[idx].len));
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
 
@@ -736,9 +778,10 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
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
@@ -808,8 +851,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 
 static bool more_used_split(const struct vring_virtqueue *vq)
 {
-	return vq->last_used_idx != virtio16_to_cpu(vq->vq.vdev,
-			vq->split.vring.used->idx);
+	return vq->last_used_idx != vring_read_used_idx(vq);
 }
 
 static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
@@ -838,10 +880,8 @@ static void *virtqueue_get_buf_ctx_split(struct virtqueue *_vq,
 	virtio_rmb(vq->weak_barriers);
 
 	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
-	i = virtio32_to_cpu(_vq->vdev,
-			vq->split.vring.used->ring[last_used].id);
-	*len = virtio32_to_cpu(_vq->vdev,
-			vq->split.vring.used->ring[last_used].len);
+	i = vring_read_used_id(vq, last_used);
+	*len = vring_read_used_len(vq, last_used);
 
 	if (unlikely(i >= vq->split.vring.num)) {
 		BAD_RING(vq, "id %u out of range\n", i);
@@ -923,8 +963,7 @@ static bool virtqueue_poll_split(struct virtqueue *_vq, unsigned int last_used_i
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	return (u16)last_used_idx != virtio16_to_cpu(_vq->vdev,
-			vq->split.vring.used->idx);
+	return (u16)last_used_idx != vring_read_used_idx(vq);
 }
 
 static bool virtqueue_enable_cb_delayed_split(struct virtqueue *_vq)
@@ -1701,10 +1740,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
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
 
@@ -1751,8 +1790,8 @@ static void *virtqueue_get_buf_ctx_packed(struct virtqueue *_vq,
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

