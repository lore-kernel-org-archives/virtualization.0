Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF4BC433FE
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 02:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1556181A39;
	Sun, 24 Apr 2022 02:40:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9V3zanjriDxp; Sun, 24 Apr 2022 02:40:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 82F4581A73;
	Sun, 24 Apr 2022 02:40:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D54CDC007F;
	Sun, 24 Apr 2022 02:40:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A04E8C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E735481A3E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a0K_PhCSjZqL
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D4E9E81A39
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:50 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VAzRZYU_1650768047; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAzRZYU_1650768047) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 24 Apr 2022 10:40:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/16] virtio_ring: split: extract virtqueue_update_split()
Date: Sun, 24 Apr 2022 10:40:31 +0800
Message-Id: <20220424024044.94749-4-xuanzhuo@linux.alibaba.com>
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

Separate the logic for updating the vq state from virtqueue_add_split().

In this way, when the subsequent patch implements the logic of reusing
the buffer when resize, we can share this function.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 95 ++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index f3ad9322b512..6fd45c9a3517 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -507,6 +507,51 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 	return next;
 }
 
+static inline void virtqueue_update_split(struct vring_virtqueue *vq,
+					  u32 descs_used,
+					  u32 next,
+					  struct vring_desc *desc,
+					  void *data)
+{
+	struct virtqueue *_vq = &vq->vq;
+	u32 avail, head;
+
+	head = vq->free_head;
+
+	/* We're using some buffers from the free list. */
+	vq->vq.num_free -= descs_used;
+
+	/* Update free pointer */
+	vq->free_head = next;
+
+	/* Store token and indirect buffer state. */
+	vq->split.desc_state[head].data = data;
+	vq->split.desc_state[head].indir_desc = desc;
+
+	/* Put entry in available array (but don't update avail->idx until they
+	 * do sync).
+	 */
+	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
+	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
+
+	/* Descriptors and available array need to be set before we expose the
+	 * new available array entries.
+	 */
+	virtio_wmb(vq->weak_barriers);
+	vq->split.avail_idx_shadow++;
+	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
+						vq->split.avail_idx_shadow);
+	vq->num_added++;
+
+	pr_debug("Added buffer head %i to %p\n", head, vq);
+
+	/* This is very unlikely, but theoretically possible.  Kick
+	 * just in case.
+	 */
+	if (unlikely(vq->num_added == (1 << 16) - 1))
+		virtqueue_kick(_vq);
+}
+
 static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      struct scatterlist *sgs[],
 				      unsigned int total_sg,
@@ -519,7 +564,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
+	unsigned int i, n, descs_used, prev, err_idx;
 	int head;
 	bool indirect;
 
@@ -619,50 +664,18 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		if (vring_mapping_error(vq, addr))
 			goto unmap_release;
 
-		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
-					 head, addr,
-					 total_sg * sizeof(struct vring_desc),
-					 VRING_DESC_F_INDIRECT,
-					 false);
+		i = virtqueue_add_desc_split(_vq, vq->split.vring.desc,
+					     head, addr,
+					     total_sg * sizeof(struct vring_desc),
+					     VRING_DESC_F_INDIRECT,
+					     false);
+	} else {
+		desc = ctx;
 	}
 
-	/* We're using some buffers from the free list. */
-	vq->vq.num_free -= descs_used;
-
-	/* Update free pointer */
-	if (indirect)
-		vq->free_head = vq->split.desc_extra[head].next;
-	else
-		vq->free_head = i;
-
-	/* Store token and indirect buffer state. */
-	vq->split.desc_state[head].data = data;
-	if (indirect)
-		vq->split.desc_state[head].indir_desc = desc;
-	else
-		vq->split.desc_state[head].indir_desc = ctx;
-
-	/* Put entry in available array (but don't update avail->idx until they
-	 * do sync). */
-	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
-	vq->split.vring.avail->ring[avail] = cpu_to_virtio16(_vq->vdev, head);
-
-	/* Descriptors and available array need to be set before we expose the
-	 * new available array entries. */
-	virtio_wmb(vq->weak_barriers);
-	vq->split.avail_idx_shadow++;
-	vq->split.vring.avail->idx = cpu_to_virtio16(_vq->vdev,
-						vq->split.avail_idx_shadow);
-	vq->num_added++;
-
-	pr_debug("Added buffer head %i to %p\n", head, vq);
+	virtqueue_update_split(vq, descs_used, i, desc, data);
 	END_USE(vq);
 
-	/* This is very unlikely, but theoretically possible.  Kick
-	 * just in case. */
-	if (unlikely(vq->num_added == (1 << 16) - 1))
-		virtqueue_kick(_vq);
-
 	return 0;
 
 unmap_release:
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
