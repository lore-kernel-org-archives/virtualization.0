Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BA34D9E3
	for <virtualization@lists.linux.dev>; Thu,  1 Feb 2024 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781384; cv=none; b=mPPTMUHycRFUi/jBjFjZOfLtsNbwPMNTTjOW6rSDhC3dQ/nRgcjvde7NL/lKsJNMy6Fu8cNgPc+HueWO8RbGV/ncCOZjwSj04YxCzA1gMwK/rCxTDm+AB0+sfK7tck1kCgAxzj/9YPqm09wXf2VhmQsX8whaNuso3qP0q2Ywj/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781384; c=relaxed/simple;
	bh=v1eAiJGbGLI6+e3ky6a/r2B5Hg6sz/HUut0TYhsZWJU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mcvTg4OjoIMG1bdlG3JeEYZbtlXi2CARYoRHDFPVV0aLi0UDBXuQhk6oh6kv563r9WQawOffb6KxQnIK9DcrEF6SuELfgFMENJDfvcoXqd8JMOPBgNi4xS3PUuNPC50m9CQG0bkH/mPHBgNenzoCzZ4RrNQc4qNCE+5ycjqMeHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SnSy4oLx; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SnSy4oLx"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706781379; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=VnxPrI9NKDGksbyXIni3zRLFRcC5dDC2V+SZI3uZTi8=;
	b=SnSy4oLxD4o9kL3uQvIHRXt4p19o2BqQ3M3z0JZd8dNTSfZbyhmk71nwqx6ud9EbS7N7RwgdkcVCUDL9KI9E4Gb7SrTZKSy5drPzbazZ4sEoLP55lIMeUXze5hfPPNcKbKB2syCUi8N6NxzfYTwtw8KsPxbjoGts8DI3vt9dwjI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.sgHgy_1706781378;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W.sgHgy_1706781378)
          by smtp.aliyun-inc.com;
          Thu, 01 Feb 2024 17:56:19 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH] virtio: packed: fix unmap leak for indirect desc table
Date: Thu,  1 Feb 2024 17:56:18 +0800
Message-Id: <20240201095618.2288-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 35e365ea5bf5
Content-Transfer-Encoding: 8bit

When use_dma_api and premapped are true, then the do_unmap is false.

Because the do_unmap is false, vring_unmap_extra_packed is not called by
detach_buf_packed.

 if (unlikely(vq->do_unmap)) {
               curr = id;
               for (i = 0; i < state->num; i++) {
                       vring_unmap_extra_packed(vq,
                                                &vq->packed.desc_extra[curr]);
                       curr = vq->packed.desc_extra[curr].next;
               }
  }

So the indirect desc table is not unmapped. This causes the unmap leak.

On the other side, the dma addr and the flags is not updated. That
will be used by vring_unmap_extra_packed.

For safety in this patch, the flags of desc without indirect flag is
also updated.

This bug does not occur, because no driver use the premapped with
indirect.

Fixes: b319940f83c2 ("virtio_ring: skip unmap for premapped")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 49299b1f9ec7..097258a10819 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1340,14 +1340,15 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 				sizeof(struct vring_packed_desc));
 	vq->packed.vring.desc[head].id = cpu_to_le16(id);
 
-	if (vq->do_unmap) {
+	if (vq->use_dma_api) {
 		vq->packed.desc_extra[id].addr = addr;
 		vq->packed.desc_extra[id].len = total_sg *
 				sizeof(struct vring_packed_desc);
-		vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
-						  vq->packed.avail_used_flags;
 	}
 
+	vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
+		vq->packed.avail_used_flags;
+
 	/*
 	 * A driver MUST NOT make the first descriptor in the list
 	 * available before all subsequent descriptors comprising
@@ -1484,9 +1485,10 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			if (unlikely(vq->do_unmap)) {
 				vq->packed.desc_extra[curr].addr = addr;
 				vq->packed.desc_extra[curr].len = sg->length;
-				vq->packed.desc_extra[curr].flags =
-					le16_to_cpu(flags);
 			}
+
+			vq->packed.desc_extra[curr].flags = le16_to_cpu(flags);
+
 			prev = curr;
 			curr = vq->packed.desc_extra[curr].next;
 
@@ -1615,13 +1617,11 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	vq->free_head = id;
 	vq->vq.num_free += state->num;
 
-	if (unlikely(vq->do_unmap)) {
-		curr = id;
-		for (i = 0; i < state->num; i++) {
-			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
-			curr = vq->packed.desc_extra[curr].next;
-		}
+	curr = id;
+	for (i = 0; i < state->num; i++) {
+		vring_unmap_extra_packed(vq,
+					 &vq->packed.desc_extra[curr]);
+		curr = vq->packed.desc_extra[curr].next;
 	}
 
 	if (vq->indirect) {
-- 
2.32.0.3.g01195cf9f

