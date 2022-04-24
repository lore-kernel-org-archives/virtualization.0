Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A18C433FE
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 02:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ADFF34098F;
	Sun, 24 Apr 2022 02:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7fT9vyeUMMzA; Sun, 24 Apr 2022 02:41:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 24D5240641;
	Sun, 24 Apr 2022 02:41:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F02E1C0032;
	Sun, 24 Apr 2022 02:41:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F62EC0089
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 22250404CC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TEBSiIc5XXeZ
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 410DC404A6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:57 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VAzv5F-_1650768054; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAzv5F-_1650768054) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 24 Apr 2022 10:40:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/16] virtio_ring: packed: extract
 virtqueue_update_packed()
Date: Sun, 24 Apr 2022 10:40:39 +0800
Message-Id: <20220424024044.94749-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
References: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: c42022d07dde
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Separate the logic for updating the vq state from virtqueue_add_packed()
and virtqueue_add_indirect_packed().

In this way, when the subsequent patch implements the logic of reusing
the buffer when resize, we can share this function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 96 ++++++++++++++++++------------------
 1 file changed, 47 insertions(+), 49 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 219e008a4633..5e6bd9a4e648 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1403,6 +1403,47 @@ static struct vring_packed_desc *alloc_indirect_packed(unsigned int total_sg,
 	return desc;
 }
 
+static inline void virtqueue_update_packed(struct vring_virtqueue *vq,
+					   u32 descs_used,
+					   u16 curr,
+					   u16 prev,
+					   u32 idx,
+					   __le16 head_flags,
+					   struct vring_packed_desc *desc,
+					   void *data)
+{
+	u16 head, id;
+
+	id = vq->free_head;
+	head = vq->packed.next_avail_idx;
+
+	if (idx < head)
+		vq->packed.avail_wrap_counter ^= 1;
+
+	/* We're using some buffers from the free list. */
+	vq->vq.num_free -= descs_used;
+
+	/* Update free pointer */
+	vq->packed.next_avail_idx = idx;
+	vq->free_head = curr;
+
+	/* Store token. */
+	vq->packed.desc_state[id].num = descs_used;
+	vq->packed.desc_state[id].data = data;
+	vq->packed.desc_state[id].indir_desc = desc;
+	vq->packed.desc_state[id].last = prev;
+
+	/*
+	 * A driver MUST NOT make the first descriptor in the list
+	 * available before all subsequent descriptors comprising
+	 * the list are made available.
+	 */
+	virtio_wmb(vq->weak_barriers);
+	vq->packed.vring.desc[head].flags = head_flags;
+	vq->num_added += descs_used;
+
+}
+
 static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 struct scatterlist *sgs[],
 					 unsigned int total_sg,
@@ -1414,6 +1455,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, err_idx;
+	__le16 head_flags;
 	u16 head, id;
 	dma_addr_t addr;
 
@@ -1466,34 +1508,13 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	vq->packed.desc_extra[id].flags = VRING_DESC_F_INDIRECT |
 		vq->packed.avail_used_flags;
 
-	/*
-	 * A driver MUST NOT make the first descriptor in the list
-	 * available before all subsequent descriptors comprising
-	 * the list are made available.
-	 */
-	virtio_wmb(vq->weak_barriers);
-	vq->packed.vring.desc[head].flags = cpu_to_le16(VRING_DESC_F_INDIRECT |
-						vq->packed.avail_used_flags);
-
-	/* We're using some buffers from the free list. */
-	vq->vq.num_free -= 1;
+	head_flags = cpu_to_le16(VRING_DESC_F_INDIRECT | vq->packed.avail_used_flags);
 
 	/* Update free pointer */
 	n = next_idx(vq, head);
 
-	if (n < head)
-		vq->packed.avail_wrap_counter ^= 1;
-
-	vq->packed.next_avail_idx = n;
-	vq->free_head = vq->packed.desc_extra[id].next;
-
-	/* Store token and indirect buffer state. */
-	vq->packed.desc_state[id].num = 1;
-	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = desc;
-	vq->packed.desc_state[id].last = id;
-
-	vq->num_added += 1;
+	virtqueue_update_packed(vq, 1, vq->packed.desc_extra[id].next, id, n,
+				head_flags, desc, data);
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 	END_USE(vq);
@@ -1605,31 +1626,8 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 		}
 	}
 
-	if (i < head)
-		vq->packed.avail_wrap_counter ^= 1;
-
-	/* We're using some buffers from the free list. */
-	vq->vq.num_free -= descs_used;
-
-	/* Update free pointer */
-	vq->packed.next_avail_idx = i;
-	vq->free_head = curr;
-
-	/* Store token. */
-	vq->packed.desc_state[id].num = descs_used;
-	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = ctx;
-	vq->packed.desc_state[id].last = prev;
-
-	/*
-	 * A driver MUST NOT make the first descriptor in the list
-	 * available before all subsequent descriptors comprising
-	 * the list are made available.
-	 */
-	virtio_wmb(vq->weak_barriers);
-	vq->packed.vring.desc[head].flags = head_flags;
-	vq->num_added += descs_used;
-
+	virtqueue_update_packed(vq, descs_used, curr, prev, i, head_flags,
+				ctx, data);
 	pr_debug("Added buffer head %i to %p\n", head, vq);
 	END_USE(vq);
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
