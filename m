Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BDCC6FA8E
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30DAB611DF;
	Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 30DAB611DF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 02NVR0BIKfAX; Thu,  2 Mar 2023 11:59:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 806FA60EC4;
	Thu,  2 Mar 2023 11:59:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 806FA60EC4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CF33C0035;
	Thu,  2 Mar 2023 11:59:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5A1B5C008D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D9E3E60EC4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D9E3E60EC4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s0iQjjnA911p
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C83E610D9
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7C83E610D9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VcxMh1c_1677758349; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VcxMh1c_1677758349) by smtp.aliyun-inc.com;
 Thu, 02 Mar 2023 19:59:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v1 01/12] virtio_ring: split: refactor
 virtqueue_add_split() for premapped
Date: Thu,  2 Mar 2023 19:58:57 +0800
Message-Id: <20230302115908.1461-2-xuanzhuo@linux.alibaba.com>
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

This commit splits virtqueue_add_split() to two functions. The purpose
of such splitting is to separate DMA operations.

The first function includes all codes that may fail before the DMA
operation. The subsequent part is used as the second function.

In this way, we can perform DMA operations in the middle of the two
functions. If the first function fails, we do not need to perform DMA
operations. If it is premapped, we can pass the DMA operation.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 131 +++++++++++++++++++++++------------
 1 file changed, 88 insertions(+), 43 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 41144b5246a8..3005893ecc61 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -520,57 +520,38 @@ static inline unsigned int virtqueue_add_desc_split(struct virtqueue *vq,
 	return next;
 }
 
-static inline int virtqueue_add_split(struct virtqueue *_vq,
-				      struct scatterlist *sgs[],
-				      unsigned int total_sg,
-				      unsigned int out_sgs,
-				      unsigned int in_sgs,
-				      void *data,
-				      void *ctx,
-				      gfp_t gfp)
+/* note: return NULL means no indirect that is valid. */
+static struct vring_desc *virtqueue_get_desc_split(struct vring_virtqueue *vq,
+						   unsigned int total_sg,
+						   unsigned int out_sgs,
+						   void *data,
+						   void *ctx,
+						   gfp_t gfp)
 {
-	struct vring_virtqueue *vq = to_vvq(_vq);
-	struct scatterlist *sg;
 	struct vring_desc *desc;
-	unsigned int i, n, avail, descs_used, prev, err_idx;
-	int head;
-	bool indirect;
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
 
-	head = vq->free_head;
-
 	if (virtqueue_use_indirect(vq, total_sg))
-		desc = alloc_indirect_split(_vq, total_sg, gfp);
+		desc = alloc_indirect_split(&vq->vq, total_sg, gfp);
 	else {
 		desc = NULL;
 		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
 	}
 
-	if (desc) {
-		/* Use a single buffer which doesn't continue */
-		indirect = true;
-		/* Set up rest to use this indirect table. */
-		i = 0;
+	if (desc)
 		descs_used = 1;
-	} else {
-		indirect = false;
-		desc = vq->split.vring.desc;
-		i = head;
+	else
 		descs_used = total_sg;
-	}
 
 	if (unlikely(vq->vq.num_free < descs_used)) {
 		pr_debug("Can't add buf len %i - avail = %i\n",
@@ -580,10 +561,39 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		 * host should service the ring ASAP. */
 		if (out_sgs)
 			vq->notify(&vq->vq);
-		if (indirect)
-			kfree(desc);
-		END_USE(vq);
-		return -ENOSPC;
+		kfree(desc);
+		return ERR_PTR(-ENOSPC);
+	}
+
+	return desc;
+}
+
+static inline int virtqueue_add_vring_split(struct vring_virtqueue *vq,
+					    struct scatterlist *sgs[],
+					    unsigned int total_sg,
+					    unsigned int out_sgs,
+					    unsigned int in_sgs,
+					    struct vring_desc *desc)
+{
+	struct virtqueue *_vq = &vq->vq;
+	struct scatterlist *sg;
+	unsigned int i, n, avail, descs_used, prev, err_idx;
+	int head;
+	bool indirect;
+
+	head = vq->free_head;
+
+	if (desc) {
+		/* Use a single buffer which doesn't continue */
+		indirect = true;
+		/* Set up rest to use this indirect table. */
+		i = 0;
+		descs_used = 1;
+	} else {
+		indirect = false;
+		desc = vq->split.vring.desc;
+		i = head;
+		descs_used = total_sg;
 	}
 
 	for (n = 0; n < out_sgs; n++) {
@@ -648,13 +658,6 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	else
 		vq->free_head = i;
 
-	/* Store token and indirect buffer state. */
-	vq->split.desc_state[head].data = data;
-	if (indirect)
-		vq->split.desc_state[head].indir_desc = desc;
-	else
-		vq->split.desc_state[head].indir_desc = ctx;
-
 	/* Put entry in available array (but don't update avail->idx until they
 	 * do sync). */
 	avail = vq->split.avail_idx_shadow & (vq->split.vring.num - 1);
@@ -703,6 +706,48 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	return -ENOMEM;
 }
 
+static inline int virtqueue_add_split(struct virtqueue *_vq,
+				      struct scatterlist *sgs[],
+				      unsigned int total_sg,
+				      unsigned int out_sgs,
+				      unsigned int in_sgs,
+				      void *data,
+				      void *ctx,
+				      gfp_t gfp)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct vring_desc *desc;
+	int head;
+	int err;
+
+	START_USE(vq);
+
+	/* check vq state and try to alloc desc for indirect. */
+	desc = virtqueue_get_desc_split(vq, total_sg, out_sgs, data, ctx, gfp);
+	if (IS_ERR(desc)) {
+		err = PTR_ERR(desc);
+		goto end;
+	}
+
+	head = vq->free_head;
+	err = virtqueue_add_vring_split(vq, sgs, total_sg, out_sgs, in_sgs, desc);
+	if (err)
+		goto err;
+
+	/* Store token and indirect buffer state. */
+	vq->split.desc_state[head].data = data;
+	vq->split.desc_state[head].indir_desc = desc ? desc : ctx;
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
 static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
