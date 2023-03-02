Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86583C7EE30
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:59:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1EBB461224;
	Thu,  2 Mar 2023 11:59:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1EBB461224
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id azi8P18dVOkq; Thu,  2 Mar 2023 11:59:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4931D61228;
	Thu,  2 Mar 2023 11:59:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4931D61228
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 134AFC008A;
	Thu,  2 Mar 2023 11:59:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96D1CC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 68AD560EC4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 68AD560EC4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IWnAldDbC7Qj
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B934B61121
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B934B61121
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:17 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VcxG4yr_1677758352; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VcxG4yr_1677758352) by smtp.aliyun-inc.com;
 Thu, 02 Mar 2023 19:59:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v1 05/12] virtio_ring: packed: refactor
 virtqueue_add_packed() for premapped
Date: Thu,  2 Mar 2023 19:59:01 +0800
Message-Id: <20230302115908.1461-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
References: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: b21604ee9ed7
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

This commit splits virtqueue_add_packed() to two functions. The purpose
of such splitting is to separate DMA operations.

The first function includes all codes that may fail before the DMA
operation. The subsequent part is used as the second function.

In this way, we can perform DMA operations in the middle of the two
functions. If the first function fails, we do not need to perform DMA
operations. If it is premapped, we can pass the DMA operation.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 120 +++++++++++++++++++++++------------
 1 file changed, 81 insertions(+), 39 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 178edf1171e2..6796cbee0207 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1347,7 +1347,6 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 unsigned int total_sg,
 					 unsigned int out_sgs,
 					 unsigned int in_sgs,
-					 void *data,
 					 struct vring_packed_desc *desc)
 {
 	struct scatterlist *sg;
@@ -1422,14 +1421,12 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 
 	/* Store token and indirect buffer state. */
 	vq->packed.desc_state[id].num = 1;
-	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = desc;
 	vq->packed.desc_state[id].last = id;
 
 	vq->num_added += 1;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
-	END_USE(vq);
 
 	return 0;
 
@@ -1441,74 +1438,76 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 
 	kfree(desc);
 
-	END_USE(vq);
 	return -ENOMEM;
 }
 
-static inline int virtqueue_add_packed(struct virtqueue *_vq,
-				       struct scatterlist *sgs[],
-				       unsigned int total_sg,
-				       unsigned int out_sgs,
-				       unsigned int in_sgs,
-				       void *data,
-				       void *ctx,
-				       gfp_t gfp)
+static inline struct vring_packed_desc *virtqueue_get_desc_packed(struct vring_virtqueue *vq,
+								  unsigned int total_sg,
+								  void *data,
+								  void *ctx,
+								  gfp_t gfp)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct vring_packed_desc *desc;
-	struct scatterlist *sg;
-	unsigned int i, n, c, descs_used, err_idx;
-	__le16 head_flags, flags;
-	u16 head, id, prev, curr, avail_used_flags;
-	int err;
-
-	START_USE(vq);
+	unsigned int descs_used;
 
 	BUG_ON(data == NULL);
 	BUG_ON(ctx && vq->indirect);
 
-	if (unlikely(vq->broken)) {
-		END_USE(vq);
-		return -EIO;
-	}
+	if (unlikely(vq->broken))
+		return ERR_PTR(-EIO);
 
 	LAST_ADD_TIME_UPDATE(vq);
 
 	BUG_ON(total_sg == 0);
 
+	desc = NULL;
+
 	if (virtqueue_use_indirect(vq, total_sg)) {
 		desc = alloc_indirect_packed(total_sg, gfp);
 		if (desc) {
 			if (unlikely(vq->vq.num_free < 1)) {
 				pr_debug("Can't add buf len 1 - avail = 0\n");
 				kfree(desc);
-				END_USE(vq);
-				return -ENOSPC;
+				return ERR_PTR(-ENOSPC);
 			}
 
-			return virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
-							     in_sgs, data, desc);
+			return NULL;
 		}
 
 		/* fall back on direct */
 	}
 
-	head = vq->packed.next_avail_idx;
-	avail_used_flags = vq->packed.avail_used_flags;
-
 	WARN_ON_ONCE(total_sg > vq->packed.vring.num && !vq->indirect);
 
-	desc = vq->packed.vring.desc;
-	i = head;
 	descs_used = total_sg;
 
 	if (unlikely(vq->vq.num_free < descs_used)) {
 		pr_debug("Can't add buf len %i - avail = %i\n",
 			 descs_used, vq->vq.num_free);
-		END_USE(vq);
-		return -ENOSPC;
+		return ERR_PTR(-ENOSPC);
 	}
 
+	return desc;
+}
+
+static inline int virtqueue_add_vring_packed(struct vring_virtqueue *vq,
+					     struct scatterlist *sgs[],
+					     unsigned int total_sg,
+					     unsigned int out_sgs,
+					     unsigned int in_sgs)
+{
+	struct vring_packed_desc *desc;
+	struct scatterlist *sg;
+	unsigned int i, n, c, descs_used, err_idx;
+	__le16 head_flags, flags;
+	u16 head, id, prev, curr, avail_used_flags;
+
+	desc = vq->packed.vring.desc;
+	head = vq->packed.next_avail_idx;
+	i = head;
+	descs_used = total_sg;
+	avail_used_flags = vq->packed.avail_used_flags;
+
 	id = vq->free_head;
 	BUG_ON(id == vq->packed.vring.num);
 
@@ -1563,8 +1562,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	/* Store token. */
 	vq->packed.desc_state[id].num = descs_used;
-	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = ctx;
 	vq->packed.desc_state[id].last = prev;
 
 	/*
@@ -1577,7 +1574,6 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	vq->num_added += descs_used;
 
 	pr_debug("Added buffer head %i to %p\n", head, vq);
-	END_USE(vq);
 
 	return 0;
 
@@ -1598,10 +1594,56 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 			i = 0;
 	}
 
-	END_USE(vq);
 	return -EIO;
 }
 
+static inline int virtqueue_add_packed(struct virtqueue *_vq,
+				       struct scatterlist *sgs[],
+				       unsigned int total_sg,
+				       unsigned int out_sgs,
+				       unsigned int in_sgs,
+				       void *data,
+				       void *ctx,
+				       gfp_t gfp)
+{
+
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct vring_packed_desc *desc;
+	u16 id;
+	int err;
+
+	START_USE(vq);
+
+	/* check vq state and try to alloc desc for indirect. */
+	desc = virtqueue_get_desc_packed(vq, total_sg, data, ctx, gfp);
+	if (IS_ERR(desc)) {
+		err = PTR_ERR(desc);
+		goto end;
+	}
+
+	id = vq->free_head;
+
+	if (desc) {
+		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs, in_sgs, desc);
+		if (err)
+			goto err;
+	} else {
+		virtqueue_add_vring_packed(vq, sgs, total_sg, out_sgs, in_sgs);
+		vq->packed.desc_state[id].indir_desc = ctx;
+	}
+
+	vq->packed.desc_state[id].data = data;
+
+	goto end;
+
+err:
+	kfree(desc);
+
+end:
+	END_USE(vq);
+	return err;
+}
+
 static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
