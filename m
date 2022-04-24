Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADE0C433F5
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 02:41:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C968D81CE1;
	Sun, 24 Apr 2022 02:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V5ZmLor_0H5w; Sun, 24 Apr 2022 02:41:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6C71581B70;
	Sun, 24 Apr 2022 02:40:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 918ACC007F;
	Sun, 24 Apr 2022 02:40:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03FF6C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DF9C781A73
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UTKt--V_suHD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB1F281A39
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:51 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VAzbmr0_1650768049; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAzbmr0_1650768049) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 24 Apr 2022 10:40:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 05/16] virtio_ring: split: support copy from vring
Date: Sun, 24 Apr 2022 10:40:33 +0800
Message-Id: <20220424024044.94749-6-xuanzhuo@linux.alibaba.com>
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

This process is similar to virtqueue_add_split(), but skips DMA. Use
the function virtqueue_update_split() provided by the previous patch to
update the state of the vq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 60 ++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index aa85058978cb..167442cfdb2a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -703,6 +703,66 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	return -ENOMEM;
 }
 
+static u32 vring_copy_desc_split(struct vring_virtqueue *vq, u32 i,
+				 struct vring_virtqueue_split *vring,
+				 u32 src)
+{
+	struct vring_desc_extra *extra = vq->split.desc_extra;
+	struct vring_desc *desc = vq->split.vring.desc;
+	u16 next;
+
+	desc[i].flags = vring->vring.desc[src].flags;
+	desc[i].addr  = vring->vring.desc[src].addr;
+	desc[i].len   = vring->vring.desc[src].len;
+
+	next = extra[i].next;
+
+	desc[i].next = cpu_to_virtio16(vq->vq.vdev, next);
+
+	extra[i].addr  = vring->desc_extra[src].addr;
+	extra[i].len   = vring->desc_extra[src].len;
+	extra[i].flags = vring->desc_extra[src].flags;
+
+	return next;
+}
+
+static int vring_copy_to_vq_split(struct vring_virtqueue *vq,
+				  struct vring_virtqueue_split *vring,
+				  u32 old_index)
+{
+	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
+	struct vring_desc_state_split *state;
+	u32 i, num = 1, old_idx;
+
+	old_idx = old_index;
+	while (vring->vring.desc[old_idx].flags & nextflag) {
+		old_idx = vring->desc_extra[old_idx].next;
+		++num;
+	}
+
+	if (num > vq->vq.num_free)
+		return -ENOSPC;
+
+	i = vq->free_head;
+
+	old_idx = old_index;
+	while (vring->vring.desc[old_idx].flags & nextflag) {
+		i = vring_copy_desc_split(vq, i, vring, old_idx);
+
+		old_idx = vring->desc_extra[old_idx].next;
+	}
+
+	i = vring_copy_desc_split(vq, i, vring, old_idx);
+
+	state = &vring->desc_state[old_index];
+
+	virtqueue_update_split(vq, num, i, state->indir_desc, state->data);
+
+	state->data = NULL;
+
+	return num;
+}
+
 static bool virtqueue_kick_prepare_split(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
