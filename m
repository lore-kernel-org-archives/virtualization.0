Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59851C43217
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 02:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 153904091A;
	Sun, 24 Apr 2022 02:41:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PdOMS6GyGI2k; Sun, 24 Apr 2022 02:41:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7A22B40915;
	Sun, 24 Apr 2022 02:41:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65FAEC0086;
	Sun, 24 Apr 2022 02:41:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1657CC007E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 92B68404BB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v30ICHyMaGfJ
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:41:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A892F404A6
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:59 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VAzcub1_1650768055; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAzcub1_1650768055) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 24 Apr 2022 10:40:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 13/16] virtio_ring: packed: support copy from vring
Date: Sun, 24 Apr 2022 10:40:41 +0800
Message-Id: <20220424024044.94749-14-xuanzhuo@linux.alibaba.com>
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

To support reusing old buffers during resize.

This patch implements copying a buffer from the detached vring to the vq
where the new vring is attached.

This process is similar to virtqueue_add_packed(), but skips DMA. Use
the function virtqueue_update_packed() provided by the previous patch to
update the state of the vq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 76 ++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1efb47b88b40..8ca9985ffb4b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1654,6 +1654,82 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	return -EIO;
 }
 
+static u32 vring_copy_desc_packed(struct vring_virtqueue *vq,
+				  u32 idx,
+				  u16 curr,
+				  __le16 *head_flags,
+				  struct vring_virtqueue_packed *vring,
+				  u32 src)
+{
+	u16 old_flags = vring->desc_extra[src].flags;
+	u16 flags = vq->packed.avail_used_flags;
+	struct vring_packed_desc *desc;
+	struct vring_desc_extra *extra;
+
+	if (old_flags & VRING_DESC_F_NEXT)
+		flags |= VRING_DESC_F_NEXT;
+
+	if (old_flags & VRING_DESC_F_WRITE)
+		flags |= VRING_DESC_F_WRITE;
+
+	if (old_flags & VRING_DESC_F_INDIRECT)
+		flags |= VRING_DESC_F_INDIRECT;
+
+	desc = vq->packed.vring.desc + idx;
+	extra = vq->packed.desc_extra + curr;
+
+	if (head_flags)
+		*head_flags = cpu_to_le16(flags);
+	else
+		desc->flags = cpu_to_le16(flags);
+
+	desc->addr = cpu_to_le64(vring->desc_extra[src].addr);
+	desc->len  = cpu_to_le32(vring->desc_extra[src].len);
+	desc->id   = cpu_to_le16(vq->free_head);
+
+	extra->addr  = vring->desc_extra[src].addr;
+	extra->len   = vring->desc_extra[src].len;
+	extra->flags = vring->desc_extra[src].flags;
+
+	return vq->packed.desc_extra[curr].next;
+}
+
+static int vring_copy_to_vq_packed(struct vring_virtqueue *vq,
+				   struct vring_virtqueue_packed *vring,
+				   u32 old_id)
+{
+	struct vring_desc_state_packed *state;
+	__le16 head_flags;
+	u16 prev, curr;
+	u32 i, n;
+
+	state = &vring->desc_state[old_id];
+
+	if (state->num > vq->vq.num_free)
+		return -ENOSPC;
+
+	i = vq->packed.next_avail_idx;
+	curr = vq->free_head;
+
+	for (n = 0; n < state->num; n++) {
+		prev = curr;
+		curr = vring_copy_desc_packed(vq, i, curr,
+					      n ? NULL : &head_flags,
+					      vring, old_id);
+
+		old_id = vring->desc_extra[old_id].next;
+
+		i = next_idx(vq, i);
+	}
+
+	virtqueue_update_packed(vq, state->num, curr, prev, i, head_flags,
+				state->indir_desc, state->data);
+
+	state->data = NULL;
+
+	return state->num;
+}
+
 static bool virtqueue_kick_prepare_packed(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
