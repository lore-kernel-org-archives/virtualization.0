Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686DDC742A7
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 06:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B1E6661108;
	Wed,  8 Mar 2023 06:45:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B1E6661108
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ISq7Cgtk9j_O; Wed,  8 Mar 2023 06:44:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 11BFB6110B;
	Wed,  8 Mar 2023 06:44:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 11BFB6110B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D671C0099;
	Wed,  8 Mar 2023 06:44:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A555C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0C7676110A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0C7676110A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MyF7jiL-93Yj
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9B00560FB1
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B00560FB1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:53 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VdORVwD_1678257889; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VdORVwD_1678257889) by smtp.aliyun-inc.com;
 Wed, 08 Mar 2023 14:44:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v2 07/12] virtio_ring: packed-indirect: support premapped
Date: Wed,  8 Mar 2023 14:44:38 +0800
Message-Id: <20230308064443.50639-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: a39da90ba7d5
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

virtio core only supports virtual addresses, dma is completed in virtio
core.

In some scenarios (such as the AF_XDP), the memory is allocated
and DMA is completed in advance, so it is necessary for us to support
passing the DMA address to virtio core.

Drives can use sg->dma_address to pass the mapped dma address to virtio
core. If one sg->dma_address is used then all sgs must use sg->dma_address,
otherwise all dma_address must be null.

On the indirect path, if dma_address is used, desc_state.indir_desc will
be mixed with VRING_INDIRECT_NO_DMA_MAP. So when do unmap, we can pass it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 11827d2e56a8..b23d301effb5 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1331,6 +1331,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	unsigned int i, n;
 	u16 head, id;
 	dma_addr_t addr;
+	bool do_map;
 
 	head = vq->packed.next_avail_idx;
 	desc = alloc_indirect_packed(total_sg, gfp);
@@ -1348,7 +1349,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	id = vq->free_head;
 	BUG_ON(id == vq->packed.vring.num);
 
-	if (virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
+	do_map = !sgs[0]->dma_address;
+	if (do_map && virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
 		return -ENOMEM;
 
 	for (n = 0; n < out_sgs + in_sgs; n++) {
@@ -1408,7 +1410,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	/* Store token and indirect buffer state. */
 	vq->packed.desc_state[id].num = 1;
 	vq->packed.desc_state[id].data = data;
-	vq->packed.desc_state[id].indir_desc = desc;
+	vq->packed.desc_state[id].indir_desc = desc_mix_dma_map(do_map, desc);
 	vq->packed.desc_state[id].last = id;
 
 	vq->num_added += 1;
@@ -1419,7 +1421,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	return 0;
 
 unmap_release:
-	virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+	if (do_map)
+		virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
 
 	kfree(desc);
 
@@ -1633,14 +1636,17 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 	}
 
 	if (vq->indirect) {
+		struct vring_packed_desc *mix;
 		u32 len;
 
 		/* Free the indirect table, if any, now that it's unmapped. */
-		desc = state->indir_desc;
-		if (!desc)
+		mix = state->indir_desc;
+		if (!mix)
 			return;
 
-		if (vq->use_dma_api) {
+		desc = desc_rm_dma_map(mix);
+
+		if (vq->use_dma_api && desc_map_inter(mix)) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
