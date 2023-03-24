Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803A3C6FD20
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 06:30:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FA3541ED8;
	Fri, 24 Mar 2023 06:30:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1FA3541ED8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lWTF50WvE5U3; Fri, 24 Mar 2023 06:30:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5B95241EDB;
	Fri, 24 Mar 2023 06:30:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5B95241EDB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12EDFC0099;
	Fri, 24 Mar 2023 06:30:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19276C008E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6156B83FBD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:30:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6156B83FBD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kpoL44b95hCJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:30:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0F8A48215A
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0F8A48215A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:30:19 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VeWd0GK_1679639415; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeWd0GK_1679639415) by smtp.aliyun-inc.com;
 Fri, 24 Mar 2023 14:30:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v5 06/11] virtio_ring: packed-indirect: support premapped
Date: Fri, 24 Mar 2023 14:30:05 +0800
Message-Id: <20230324063010.48670-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230324063010.48670-1-xuanzhuo@linux.alibaba.com>
References: <20230324063010.48670-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 4338850ae009
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
and DMA mapping is completed in advance, so it is necessary for us to
support passing the DMA address to virtio core.

Drives can use sg->dma_address to pass the mapped dma address to virtio
core. If one sg->dma_address is used then all sgs must use sg->dma_address,
otherwise all dma_address must be null when passing it to the APIs of
virtio.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index df6d514a681a..511d791ba9cc 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1337,6 +1337,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	unsigned int i, n;
 	u16 head, id;
 	dma_addr_t addr;
+	bool dma_map_internal;
 
 	head = vq->packed.next_avail_idx;
 	desc = alloc_indirect_packed(total_sg, gfp);
@@ -1354,7 +1355,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	id = vq->free_head;
 	BUG_ON(id == vq->packed.vring.num);
 
-	if (virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
+	dma_map_internal = !sgs[0]->dma_address;
+	if (dma_map_internal && virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
 		goto err_map;
 
 	for (n = 0; n < out_sgs + in_sgs; n++) {
@@ -1416,6 +1418,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	vq->packed.desc_state[id].data = data;
 	vq->packed.desc_state[id].indir_desc = desc;
 	vq->packed.desc_state[id].last = id;
+	vq->packed.desc_state[id].flags = dma_map_internal ? VRING_STATE_F_MAP_INTERNAL : 0;
+
 
 	vq->num_added += 1;
 
@@ -1425,7 +1429,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	return 0;
 
 unmap_release:
-	virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
+	if (dma_map_internal)
+		virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
 
 err_map:
 	kfree(desc);
@@ -1652,7 +1657,7 @@ static void detach_buf_packed(struct vring_virtqueue *vq,
 		if (!desc)
 			return;
 
-		if (vq->use_dma_api) {
+		if (vq->use_dma_api && dma_map_internal) {
 			len = vq->packed.desc_extra[id].len;
 			for (i = 0; i < len / sizeof(struct vring_packed_desc);
 					i++)
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
