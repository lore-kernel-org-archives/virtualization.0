Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABB212E6F
	for <virtualization@lists.linux.dev>; Fri, 23 Feb 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708672720; cv=none; b=nK2qJlC7qTGhu/ZOXfoKy9F5jvABxQ+k+DkHtO+NFOwoYRXbJOSGmciSmU5ShhhrZYE+imETDDxvfu/xJq77vE+UJtGLK1B2gdVT6A2tp80/nGK9MSk0d89P+hMdEnEoS0H0BjT44r6iJzcGW5iHI/FiEj0eLeZ+JyuWvwBgg/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708672720; c=relaxed/simple;
	bh=JPd+xcwedwSfoRtpExM+gs8JFu0JBxF/LszeUW1TisA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SfFVSuLuCD35uLj6lNZ4dunjrTIoDddVxcZA9Mzft5wOgLGwRiYL+eQ/5wD6DGGAZZeTE4R27mwAEt8+XNNgenMwEcCAQwocb1pSLOROuPJan6p29CSNg6RexgM2A38VscfGAZGiczoc+J0gZ7h1yzpjLxcNH4zLJAz1czzl/8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lmFrbnOh; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lmFrbnOh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708672715; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4rcuD74AvS7fneRQTsL1nt/k9a5Kn0okRauJeobRvY4=;
	b=lmFrbnOhwXgCBQb5cUQYe8rLrb76J/+O2kvH6/OUJy7RdfvbpIoKVrZH0dCy82zVhwHA4f97+YVBICrZ/fSHElF0F9Cu2QRDauUyzAj4XgEh79J0Omcy2e5R/WxWiK0SWliKN5HDUZK1V7xNiMnxYZjWbWWGb03+ZwqP6wvu8aE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W13I6gP_1708672714;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W13I6gP_1708672714)
          by smtp.aliyun-inc.com;
          Fri, 23 Feb 2024 15:18:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [PATCH vhost v1] virtio: packed: fix unmap leak for indirect desc table
Date: Fri, 23 Feb 2024 15:18:33 +0800
Message-Id: <20240223071833.26095-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Git-Hash: 551bf7db48dd
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

So here, we check vq->use_dma_api instead. Synchronously, dma info is
updated based on use_dma_api judgment

This bug does not occur, because no driver use the premapped with
indirect.

Fixes: b319940f83c2 ("virtio_ring: skip unmap for premapped")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---

v1: check use_dma_api to update dma info and unmap

 drivers/virtio/virtio_ring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 49299b1f9ec7..6f7e5010a673 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1340,7 +1340,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 				sizeof(struct vring_packed_desc));
 	vq->packed.vring.desc[head].id = cpu_to_le16(id);

-	if (vq->do_unmap) {
+	if (vq->use_dma_api) {
 		vq->packed.desc_extra[id].addr = addr;
 		vq->packed.desc_extra[id].len = total_sg *
 				sizeof(struct vring_packed_desc);
@@ -1481,7 +1481,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			desc[i].len = cpu_to_le32(sg->length);
 			desc[i].id = cpu_to_le16(id);

-			if (unlikely(vq->do_unmap)) {
+			if (unlikely(vq->use_dma_api)) {
 				vq->packed.desc_extra[curr].addr = addr;
 				vq->packed.desc_extra[curr].len = sg->length;
 				vq->packed.desc_extra[curr].flags =
@@ -1615,7 +1615,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	vq->free_head = id;
 	vq->vq.num_free += state->num;

-	if (unlikely(vq->do_unmap)) {
+	if (unlikely(vq->use_dma_api)) {
 		curr = id;
 		for (i = 0; i < state->num; i++) {
 			vring_unmap_extra_packed(vq,
--
2.32.0.3.g01195cf9f

