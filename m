Received: from out30-72.freemail.mail.aliyun.com (out30-72.freemail.mail.aliyun.com [115.124.30.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8257A3793D4
	for <virtualization@lists.linux.dev>; Thu,  5 Mar 2026 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772702980; cv=none; b=tAJQEoFfVNv4hsOmbsZM9VFyAnyPhNW6rRpPSzHRUHYGQkU1Df93rfI/e00WUpLWReVS7w080oDwxGk/1ogASIrnTRJukBJhryNGg+g6uSo/SjJLZF8aZULDsTEynGmQLuonvcLSIklaPsLDTtzX8gZX1Qwa7pCbkulXekRfU5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772702980; c=relaxed/simple;
	bh=zTDZ8kfQPrbB0DwwRLC6SMAHDISXJDdLmvgRU0iGQpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NwQsD8vJJZ9gz1bbmV0gVjotaq7ztMN9hWm5xJbkFmRXVDOu1VWwXJoZu2muyDefU9xGaK24ui9wb/eb2OXnrpmhcjsIJiat7jpdBmNLHuMgQpaSBmsfPHNpWKftaD3TdXXNKBXJFM5RvwThJyx+PuwpcP4DUxbKlbGx9ZscJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=X7+E2t1x; arc=none smtp.client-ip=115.124.30.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="X7+E2t1x"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1772702973; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=SgvdD1R0tMl7mcgnz93Z5XXziMuids5zQlWpyTXglVM=;
	b=X7+E2t1xzar9QhsX0jZ9Ts8Au3iVvkwcqMslv0QEXuNi5sE/h0lpnTvEYKPmyvI+UJebrVY+VqyRKz3ytQ2eDSHBnvhnxy4ojANZpYoaqDoMkGFrFZ66PKtJSv3eI0/z0v7ddq+Qi0pY2YE8YhLLv5itPbmJ4yKOT8E1K9tXeko=
Received: from localhost.localdomain(mailfrom:wdhh6@aliyun.com fp:SMTPD_---0X-IC4HT_1772702969 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Mar 2026 17:29:32 +0800
From: Chaohai Chen <wdhh6@aliyun.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Chaohai Chen <wdhh6@aliyun.com>
Subject: [PATCH] virtio_ring: Fix data races in split virtqueue used ring accesses
Date: Thu,  5 Mar 2026 17:29:27 +0800
Message-ID: <20260305092927.3866089-1-wdhh6@aliyun.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN detected multiple data races when accessing the split virtqueue's
used ring, which is shared memory concurrently accessed by both the CPU
and the virtio device (hypervisor).

The races occur when reading the following fields without proper atomic
operations:
- vring.used->idx
- vring.used->flags
- vring.used->ring[].id
- vring.used->ring[].len

These fields reside in DMA-shared memory and can be modified by the
virtio device at any time. Without READ_ONCE(), the compiler may perform
unsafe optimizations such as value caching or load tearing.

Example KCSAN report:

[  109.277250] ==================================================================
[  109.283600] BUG: KCSAN: data-race in virtqueue_enable_cb_delayed_split+0x10f/0x170

[  109.295263] race at unknown origin, with read to 0xffff8b2a92ef2042 of 2 bytes by interrupt on cpu 1:
[  109.306934]  virtqueue_enable_cb_delayed_split+0x10f/0x170
[  109.312880]  virtqueue_enable_cb_delayed+0x3b/0x70
[  109.318852]  start_xmit+0x315/0x860 [virtio_net]
[  109.324532]  dev_hard_start_xmit+0x85/0x380
[  109.329993]  sch_direct_xmit+0xd3/0x680
[  109.335360]  __dev_xmit_skb+0x4ee/0xcc0
[  109.340568]  __dev_queue_xmit+0x560/0xe00
[  109.345701]  ip_finish_output2+0x49a/0x9b0
[  109.350743]  __ip_finish_output+0x131/0x250
[  109.355789]  ip_finish_output+0x28/0x180
[  109.360712]  ip_output+0xa0/0x1c0
[  109.365479]  __ip_queue_xmit+0x68d/0x9e0
[  109.370156]  ip_queue_xmit+0x33/0x40
[  109.374783]  __tcp_transmit_skb+0x1703/0x1970
[  109.379467]  __tcp_send_ack.part.0+0x1bb/0x320
...
[  109.499585]  do_idle+0x7a/0xe0
[  109.502979]  cpu_startup_entry+0x25/0x30
[  109.506481]  start_secondary+0x116/0x150
[  109.509930]  common_startup_64+0x13e/0x141

[  109.516626] value changed: 0x0029 -> 0x002a

Fix these races by wrapping all reads from the used ring with READ_ONCE()
to ensure:
1. The compiler always loads values from memory (no caching)
2. Loads are atomic (no load tearing)
3. The concurrent access intent is documented for KCSAN and developers

The changes affect the following functions:
- virtqueue_kick_prepare_split(): used->flags and avail event
- virtqueue_get_buf_ctx_split(): used->ring[].id and used->ring[].len
- virtqueue_get_buf_ctx_split_in_order(): used->ring[].id and
used->ring[].len
- virtqueue_enable_cb_delayed_split(): used->idx

Signed-off-by: Chaohai Chen <wdhh6@aliyun.com>
---
 drivers/virtio/virtio_ring.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 335692d41617..a792a3f05837 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -810,10 +810,10 @@ static bool virtqueue_kick_prepare_split(struct vring_virtqueue *vq)
 
 	if (vq->event) {
 		needs_kick = vring_need_event(virtio16_to_cpu(vq->vq.vdev,
-					vring_avail_event(&vq->split.vring)),
+					READ_ONCE(vring_avail_event(&vq->split.vring))),
 					      new, old);
 	} else {
-		needs_kick = !(vq->split.vring.used->flags &
+		needs_kick = !(READ_ONCE(vq->split.vring.used->flags) &
 					cpu_to_virtio16(vq->vq.vdev,
 						VRING_USED_F_NO_NOTIFY));
 	}
@@ -940,9 +940,9 @@ static void *virtqueue_get_buf_ctx_split(struct vring_virtqueue *vq,
 
 	last_used = (vq->last_used_idx & (vq->split.vring.num - 1));
 	i = virtio32_to_cpu(vq->vq.vdev,
-			vq->split.vring.used->ring[last_used].id);
+			READ_ONCE(vq->split.vring.used->ring[last_used].id));
 	*len = virtio32_to_cpu(vq->vq.vdev,
-			vq->split.vring.used->ring[last_used].len);
+			READ_ONCE(vq->split.vring.used->ring[last_used].len));
 
 	if (unlikely(i >= vq->split.vring.num)) {
 		BAD_RING(vq, "id %u out of range\n", i);
@@ -1004,9 +1004,9 @@ static void *virtqueue_get_buf_ctx_split_in_order(struct vring_virtqueue *vq,
 		virtio_rmb(vq->weak_barriers);
 
 		vq->batch_last.id = virtio32_to_cpu(vq->vq.vdev,
-				    vq->split.vring.used->ring[last_used_idx].id);
+				    READ_ONCE(vq->split.vring.used->ring[last_used_idx].id));
 		vq->batch_last.len = virtio32_to_cpu(vq->vq.vdev,
-				     vq->split.vring.used->ring[last_used_idx].len);
+				     READ_ONCE(vq->split.vring.used->ring[last_used_idx].len));
 	}
 
 	if (vq->batch_last.id == last_used) {
@@ -1112,8 +1112,9 @@ static bool virtqueue_enable_cb_delayed_split(struct vring_virtqueue *vq)
 			&vring_used_event(&vq->split.vring),
 			cpu_to_virtio16(vq->vq.vdev, vq->last_used_idx + bufs));
 
-	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev, vq->split.vring.used->idx)
-					- vq->last_used_idx) > bufs)) {
+	if (unlikely((u16)(virtio16_to_cpu(vq->vq.vdev,
+				READ_ONCE(vq->split.vring.used->idx))
+				- vq->last_used_idx) > bufs)) {
 		END_USE(vq);
 		return false;
 	}
-- 
2.43.7

