Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60EEC433F5
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 06:33:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5FD274248B;
	Fri,  7 Jan 2022 06:33:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jIFtiSdx0dxt; Fri,  7 Jan 2022 06:33:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D329A42487;
	Fri,  7 Jan 2022 06:33:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98DD9C0030;
	Fri,  7 Jan 2022 06:33:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F395DC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D645442487
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q8YsW69ldKxs
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4AF5F4014E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V19hjyw_1641537187; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V19hjyw_1641537187) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 07 Jan 2022 14:33:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 1/6] virtio: rename vring_unmap_state_packed() to
 vring_unmap_extra_packed()
Date: Fri,  7 Jan 2022 14:33:01 +0800
Message-Id: <20220107063306.23240-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
References: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
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

The actual parameter handled by vring_unmap_state_packed() is that
vring_desc_extra, so this function should use "extra" instead of "state".

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 028b05d44546..81531cbb08a7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -984,24 +984,24 @@ static struct virtqueue *vring_create_virtqueue_split(
  * Packed ring specific functions - *_packed().
  */
 
-static void vring_unmap_state_packed(const struct vring_virtqueue *vq,
-				     struct vring_desc_extra *state)
+static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
+				     struct vring_desc_extra *extra)
 {
 	u16 flags;
 
 	if (!vq->use_dma_api)
 		return;
 
-	flags = state->flags;
+	flags = extra->flags;
 
 	if (flags & VRING_DESC_F_INDIRECT) {
 		dma_unmap_single(vring_dma_dev(vq),
-				 state->addr, state->len,
+				 extra->addr, extra->len,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
 		dma_unmap_page(vring_dma_dev(vq),
-			       state->addr, state->len,
+			       extra->addr, extra->len,
 			       (flags & VRING_DESC_F_WRITE) ?
 			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	}
@@ -1301,8 +1301,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	for (n = 0; n < total_sg; n++) {
 		if (i == err_idx)
 			break;
-		vring_unmap_state_packed(vq,
-					 &vq->packed.desc_extra[curr]);
+		vring_unmap_extra_packed(vq, &vq->packed.desc_extra[curr]);
 		curr = vq->packed.desc_extra[curr].next;
 		i++;
 		if (i >= vq->packed.vring.num)
@@ -1381,8 +1380,8 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	if (unlikely(vq->use_dma_api)) {
 		curr = id;
 		for (i = 0; i < state->num; i++) {
-			vring_unmap_state_packed(vq,
-				&vq->packed.desc_extra[curr]);
+			vring_unmap_extra_packed(vq,
+						 &vq->packed.desc_extra[curr]);
 			curr = vq->packed.desc_extra[curr].next;
 		}
 	}
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
