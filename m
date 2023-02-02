Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91BF7C05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:01:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2F47B61107;
	Thu,  2 Feb 2023 11:01:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F47B61107
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ER1QRVV8SNjv; Thu,  2 Feb 2023 11:01:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ABA5060B50;
	Thu,  2 Feb 2023 11:01:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ABA5060B50
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 92F8EC0032;
	Thu,  2 Feb 2023 11:01:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6DB20C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4933360E58
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4933360E58
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fHAWWgCANcnX
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1B4F60B95
Received: from out30-110.freemail.mail.aliyun.com
 (out30-110.freemail.mail.aliyun.com [115.124.30.110])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1B4F60B95
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:08 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0Vakpy8s_1675335661; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vakpy8s_1675335661) by smtp.aliyun-inc.com;
 Thu, 02 Feb 2023 19:01:02 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 02/33] virtio_ring: split: virtqueue_add_split() support
 premapped
Date: Thu,  2 Feb 2023 19:00:27 +0800
Message-Id: <20230202110058.130695-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d7589ab6ea10
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

virtqueue_add_split() only supports virtual addresses, dma is completed
in virtqueue_add_split().

In some scenarios (such as the AF_XDP scenario), the memory is allocated
and DMA is completed in advance, so it is necessary for us to support
passing the DMA address to virtqueue_add_split().

Record this information in desc_state, we can skip unmap based on this
when executing dma unmap.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 55 +++++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c9f194c86aec..ec622403cbd5 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -70,6 +70,7 @@
 struct vring_desc_state_split {
 	void *data;			/* Data for callback. */
 	struct vring_desc *indir_desc;	/* Indirect descriptor, if any. */
+	bool premapped;
 };
 
 struct vring_desc_state_packed {
@@ -434,7 +435,7 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 }
 
 static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
-					  unsigned int i)
+					  unsigned int i, bool premapped)
 {
 	struct vring_desc_extra *extra = vq->split.desc_extra;
 	u16 flags;
@@ -451,6 +452,9 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
+		if (premapped)
+			goto out;
+
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra[i].addr,
 			       extra[i].len,
@@ -521,6 +525,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 				      unsigned int in_sgs,
 				      void *data,
 				      void *ctx,
+				      bool premapped,
 				      gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -582,9 +587,16 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	for (n = 0; n < out_sgs; n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
-			if (vring_mapping_error(vq, addr))
-				goto unmap_release;
+			dma_addr_t addr;
+
+			if (premapped) {
+				addr = sg_dma_address(sg);
+
+			} else {
+				addr = vring_map_one_sg(vq, sg, DMA_TO_DEVICE);
+				if (vring_mapping_error(vq, addr))
+					goto unmap_release;
+			}
 
 			prev = i;
 			/* Note that we trust indirect descriptor
@@ -597,9 +609,16 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	}
 	for (; n < (out_sgs + in_sgs); n++) {
 		for (sg = sgs[n]; sg; sg = sg_next(sg)) {
-			dma_addr_t addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
-			if (vring_mapping_error(vq, addr))
-				goto unmap_release;
+			dma_addr_t addr;
+
+			if (premapped) {
+				addr = sg_dma_address(sg);
+
+			} else {
+				addr = vring_map_one_sg(vq, sg, DMA_FROM_DEVICE);
+				if (vring_mapping_error(vq, addr))
+					goto unmap_release;
+			}
 
 			prev = i;
 			/* Note that we trust indirect descriptor
@@ -644,6 +663,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 
 	/* Store token and indirect buffer state. */
 	vq->split.desc_state[head].data = data;
+	vq->split.desc_state[head].premapped = premapped;
 	if (indirect)
 		vq->split.desc_state[head].indir_desc = desc;
 	else
@@ -673,6 +693,9 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	return 0;
 
 unmap_release:
+	if (premapped)
+		goto unmap_free;
+
 	err_idx = i;
 
 	if (indirect)
@@ -687,9 +710,10 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			vring_unmap_one_split_indirect(vq, &desc[i]);
 			i = virtio16_to_cpu(_vq->vdev, desc[i].next);
 		} else
-			i = vring_unmap_one_split(vq, i);
+			i = vring_unmap_one_split(vq, i, false);
 	}
 
+unmap_free:
 	if (indirect)
 		kfree(desc);
 
@@ -733,20 +757,23 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 {
 	unsigned int i, j;
 	__virtio16 nextflag = cpu_to_virtio16(vq->vq.vdev, VRING_DESC_F_NEXT);
+	bool premapped;
 
 	/* Clear data ptr. */
 	vq->split.desc_state[head].data = NULL;
 
+	premapped = vq->split.desc_state[head].premapped;
+
 	/* Put back on free list: unmap first-level descriptors and find end */
 	i = head;
 
 	while (vq->split.vring.desc[i].flags & nextflag) {
-		vring_unmap_one_split(vq, i);
+		vring_unmap_one_split(vq, i, premapped);
 		i = vq->split.desc_extra[i].next;
 		vq->vq.num_free++;
 	}
 
-	vring_unmap_one_split(vq, i);
+	vring_unmap_one_split(vq, i, premapped);
 	vq->split.desc_extra[i].next = vq->free_head;
 	vq->free_head = head;
 
@@ -768,8 +795,10 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 				VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
-		for (j = 0; j < len / sizeof(struct vring_desc); j++)
-			vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+		if (!premapped) {
+			for (j = 0; j < len / sizeof(struct vring_desc); j++)
+				vring_unmap_one_split_indirect(vq, &indir_desc[j]);
+		}
 
 		kfree(indir_desc);
 		vq->split.desc_state[head].indir_desc = NULL;
@@ -2095,7 +2124,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 	return vq->packed_ring ? virtqueue_add_packed(_vq, sgs, total_sg,
 					out_sgs, in_sgs, data, ctx, gfp) :
 				 virtqueue_add_split(_vq, sgs, total_sg,
-					out_sgs, in_sgs, data, ctx, gfp);
+					out_sgs, in_sgs, data, ctx, premapped, gfp);
 }
 
 /**
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
