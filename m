Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8778C74A5B
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 09:35:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4EFD6409EC;
	Tue, 21 Mar 2023 09:35:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4EFD6409EC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tMy6FzcG85NF; Tue, 21 Mar 2023 09:35:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D1E7940B33;
	Tue, 21 Mar 2023 09:35:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D1E7940B33
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EA37C008E;
	Tue, 21 Mar 2023 09:35:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB7F7C0091
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F325409EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:35:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8F325409EC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EoR2DGk-2fzg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:35:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 138E8409EE
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 138E8409EE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 09:35:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VeMbiqP_1679391308; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeMbiqP_1679391308) by smtp.aliyun-inc.com;
 Tue, 21 Mar 2023 17:35:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v3 03/11] virtio_ring: packed-indirect: separate dma
 codes
Date: Tue, 21 Mar 2023 17:34:58 +0800
Message-Id: <20230321093506.6546-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230321093506.6546-1-xuanzhuo@linux.alibaba.com>
References: <20230321093506.6546-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: fa5bd5b2113c
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

DMA-related logic is separated from the virtqueue_add_indirect_packed().

DMA address will be saved as sg->dma_address, then
virtqueue_add_indirect_packed() will use it directly. Unmap operation
will be simpler.

The purpose of this is to facilitate subsequent support to receive
dma address mapped by drivers.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 42e8c9d44161..c8ed4aef9462 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1314,7 +1314,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 {
 	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
-	unsigned int i, n, err_idx;
+	unsigned int i, n;
 	u16 head, id;
 	dma_addr_t addr;
 
@@ -1334,16 +1334,14 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	id = vq->free_head;
 	BUG_ON(id == vq->packed.vring.num);
 
+	if (virtqueue_map_sgs(vq, sgs, total_sg, out_sgs, in_sgs))
+		return -ENOMEM;
+
 	for (n = 0; n < out_sgs + in_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			addr = vring_map_one_sg(vq, sg, n < out_sgs ?
-					DMA_TO_DEVICE : DMA_FROM_DEVICE);
-			if (vring_mapping_error(vq, addr))
-				goto unmap_release;
-
 			desc[i].flags = cpu_to_le16(n < out_sgs ?
 						0 : VRING_DESC_F_WRITE);
-			desc[i].addr = cpu_to_le64(addr);
+			desc[i].addr = cpu_to_le64(vring_sg_address(sg));
 			desc[i].len = cpu_to_le32(sg->length);
 			i++;
 		}
@@ -1407,10 +1405,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	return 0;
 
 unmap_release:
-	err_idx = i;
-
-	for (i = 0; i < err_idx; i++)
-		vring_unmap_desc_packed(vq, &desc[i]);
+	virtqueue_unmap_sgs(vq, sgs, total_sg, out_sgs, in_sgs);
 
 	kfree(desc);
 
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
