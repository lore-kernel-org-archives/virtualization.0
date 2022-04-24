Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A65C4332F
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 02:41:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0DCE1823EB;
	Sun, 24 Apr 2022 02:41:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PJ1_UQydZeiG; Sun, 24 Apr 2022 02:41:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B1D7781D24;
	Sun, 24 Apr 2022 02:41:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F9E4C002D;
	Sun, 24 Apr 2022 02:41:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87B8CC008F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 66EFB4057A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HVXUK3Ps34no
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1B4D6404BB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:58 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R851e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VAzcuah_1650768055; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAzcuah_1650768055) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 24 Apr 2022 10:40:55 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 12/16] virtio_ring: packed: extract
 detach_from_vring_packed()
Date: Sun, 24 Apr 2022 10:40:40 +0800
Message-Id: <20220424024044.94749-13-xuanzhuo@linux.alibaba.com>
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
detach_buf_packed().

The split function detach_buf_from_vring_packed() is used to release buf
from vring, and the vq passed in is read-only. All modifications are for
vring.

In this way, detach_buf_from_vring_packed() becomes a general function,
which can be used for detach_buf_packed() and also for handling detached
vrings.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 36 +++++++++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5e6bd9a4e648..1efb47b88b40 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1703,28 +1703,28 @@ static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 	return needs_kick;
 }
 
-static void detach_buf_packed(struct vring_virtqueue *vq,
-			      unsigned int id, void **ctx)
+static int detach_buf_from_vring_packed(struct vring_virtqueue_packed *vring,
+					struct vring_virtqueue const *vq,
+					unsigned int id,
+					unsigned int free_head,
+					void **ctx)
 {
 	struct vring_desc_state_packed *state = NULL;
 	struct vring_packed_desc *desc;
 	unsigned int i, curr;
 
-	state = &vq->packed.desc_state[id];
+	state = &vring->desc_state[id];
 
 	/* Clear data ptr. */
 	state->data = NULL;
 
-	vq->packed.desc_extra[state->last].next = vq->free_head;
-	vq->free_head = id;
-	vq->vq.num_free += state->num;
+	vring->desc_extra[state->last].next = free_head;
 
 	if (unlikely(vq->use_dma_api)) {
 		curr = id;
 		for (i = 0; i < state->num; i++) {
-			vring_unmap_extra_packed(vq,
-						 &vq->packed.desc_extra[curr]);
-			curr = vq->packed.desc_extra[curr].next;
+			vring_unmap_extra_packed(vq, &vring->desc_extra[curr]);
+			curr = vring->desc_extra[curr].next;
 		}
 	}
 
@@ -1734,10 +1734,10 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		/* Free the indirect table, if any, now that it's unmapped. */
 		desc = state->indir_desc;
 		if (!desc)
-			return;
+			return state->num;
 
 		if (vq->use_dma_api) {
-			len = vq->packed.desc_extra[id].len;
+			len = vring->desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
 				vring_unmap_desc_packed(vq, &desc[i]);
@@ -1747,6 +1747,20 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	} else if (ctx) {
 		*ctx = state->indir_desc;
 	}
+
+	return state->num;
+}
+
+static void detach_buf_packed(struct vring_virtqueue *vq,
+			      unsigned int id, void **ctx)
+{
+	int num;
+
+	num = detach_buf_from_vring_packed(&vq->packed, vq, id, vq->free_head,
+					   ctx);
+
+	vq->free_head = id;
+	vq->vq.num_free += num;
 }
 
 static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
