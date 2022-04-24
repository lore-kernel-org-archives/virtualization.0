Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 344C8C433F5
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 02:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC5144092F;
	Sun, 24 Apr 2022 02:41:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K-triOq6s3K1; Sun, 24 Apr 2022 02:41:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2290D4170E;
	Sun, 24 Apr 2022 02:41:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 34D26C008C;
	Sun, 24 Apr 2022 02:41:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19E1BC002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BCBD581A99
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id R74lBh41zMkf
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DFEC781A5F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:51 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R741e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VAzpPIS_1650768048; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAzpPIS_1650768048) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 24 Apr 2022 10:40:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/16] virtio_ring: split: extract
 detach_from_vring_split()
Date: Sun, 24 Apr 2022 10:40:32 +0800
Message-Id: <20220424024044.94749-5-xuanzhuo@linux.alibaba.com>
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

To handle freeing buf from the detached vring, do a split for
detach_buf_split().

The split function detach_buf_from_vring_split() is used to release buf
from vring, and the vq passed in is read-only. All modifications are for
vring.

In this way, detach_buf_from_vring_split() becomes a general function,
which can be used for detach_buf_split() and also for handling detached
vrings.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 54 +++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6fd45c9a3517..aa85058978cb 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -734,54 +734,68 @@ static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 	return needs_kick;
 }
 
-static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
-			     void **ctx)
+static int detach_buf_from_vring_split(struct vring_virtqueue_split *vring,
+				       struct vring_virtqueue const *vq,
+				       unsigned int head,
+				       unsigned int free_head,
+				       void **ctx)
 {
-	unsigned int i, j;
+	unsigned int i, j, num = 0;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
 
 	/* Clear data ptr. */
-	vq->split.desc_state[head].data = NULL;
+	vring->desc_state[head].data = NULL;
 
 	/* Put back on free list: unmap first-level descriptors and find end */
 	i = head;
 
-	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, &vq->split.desc_extra[i]);
-		i = vq->split.desc_extra[i].next;
-		vq->vq.num_free++;
+	while (vring->vring.desc[i].flags & nextflag) {
+		vring_unmap_one_split(vq, &vring->desc_extra[i]);
+		i = vring->desc_extra[i].next;
+		++num;
 	}
 
-	vring_unmap_one_split(vq, &vq->split.desc_extra[i]);
-	vq->split.desc_extra[i].next = vq->free_head;
-	vq->free_head = head;
+	vring_unmap_one_split(vq, &vring->desc_extra[i]);
+	vring->desc_extra[i].next = free_head;
 
-	/* Plus final descriptor */
-	vq->vq.num_free++;
+	++num;
 
 	if (vq->indirect) {
 		struct vring_desc *indir_desc =
-				vq->split.desc_state[head].indir_desc;
+				vring->desc_state[head].indir_desc;
 		u32 len;
 
 		/* Free the indirect table, if any, now that it's unmapped. */
 		if (!indir_desc)
-			return;
+			return num;
 
-		len = vq->split.desc_extra[head].len;
+		len = vring->desc_extra[head].len;
 
-		BUG_ON(!(vq->split.desc_extra[head].flags &
-				VRING_DESC_F_INDIRECT));
+		BUG_ON(!(vring->desc_extra[head].flags & VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
 		for (j = 0; j < len / sizeof(struct vring_desc); j++)
 			vring_unmap_one_split_indirect(vq, &indir_desc[j]);
 
 		kfree(indir_desc);
-		vq->split.desc_state[head].indir_desc = NULL;
+		vring->desc_state[head].indir_desc = NULL;
 	} else if (ctx) {
-		*ctx = vq->split.desc_state[head].indir_desc;
+		*ctx = vring->desc_state[head].indir_desc;
 	}
+
+	return num;
+}
+
+static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
+			     void **ctx)
+{
+	int num;
+
+	num = detach_buf_from_vring_split(&vq->split, vq, head, vq->free_head,
+					  ctx);
+
+	vq->vq.num_free += num;
+	vq->free_head = head;
 }
 
 static inline bool more_used_split(const struct vring_virtqueue *vq)
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
