Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF28AC001DF
	for <virtualization@archiver.kernel.org>; Mon, 10 Jul 2023 03:42:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 66208404E0;
	Mon, 10 Jul 2023 03:42:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 66208404E0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kSSmxodmTthH; Mon, 10 Jul 2023 03:42:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EBAA240129;
	Mon, 10 Jul 2023 03:42:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EBAA240129
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA2C8C008C;
	Mon, 10 Jul 2023 03:42:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D26D4C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:42:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9F5F8818E6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:42:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9F5F8818E6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pvKMnab4jF9s
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:42:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E3AA817A1
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E3AA817A1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:42:49 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R801e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0VmxJHXo_1688960563; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VmxJHXo_1688960563) by smtp.aliyun-inc.com;
 Mon, 10 Jul 2023 11:42:44 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v11 04/10] virtio_ring: support add premapped buf
Date: Mon, 10 Jul 2023 11:42:31 +0800
Message-Id: <20230710034237.12391-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 39991abed41c
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

If the vq is the premapped mode, use the sg_dma_address() directly.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5ace4539344c..d471dee3f4f7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -361,6 +361,11 @@ static struct device *vring_dma_dev(const struct vring_virtqueue *vq)
 static int vring_map_one_sg(const struct vring_virtqueue *vq, struct scatterlist *sg,
 			    enum dma_data_direction direction, dma_addr_t *addr)
 {
+	if (vq->premapped) {
+		*addr = sg_dma_address(sg);
+		return 0;
+	}
+
 	if (!vq->use_dma_api) {
 		/*
 		 * If DMA is not used, KMSAN doesn't know that the scatterlist
@@ -639,8 +644,12 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 		dma_addr_t addr = vring_map_single(
 			vq, desc, total_sg * sizeof(struct vring_desc),
 			DMA_TO_DEVICE);
-		if (vring_mapping_error(vq, addr))
+		if (vring_mapping_error(vq, addr)) {
+			if (vq->premapped)
+				goto free_indirect;
+
 			goto unmap_release;
+		}
 
 		virtqueue_add_desc_split(_vq, vq->split.vring.desc,
 					 head, addr,
@@ -706,6 +715,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 			i = vring_unmap_one_split(vq, i);
 	}
 
+free_indirect:
 	if (indirect)
 		kfree(desc);
 
@@ -1307,8 +1317,12 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	addr = vring_map_single(vq, desc,
 			total_sg * sizeof(struct vring_packed_desc),
 			DMA_TO_DEVICE);
-	if (vring_mapping_error(vq, addr))
+	if (vring_mapping_error(vq, addr)) {
+		if (vq->premapped)
+			goto free_desc;
+
 		goto unmap_release;
+	}
 
 	vq->packed.vring.desc[head].addr = cpu_to_le64(addr);
 	vq->packed.vring.desc[head].len = cpu_to_le32(total_sg *
@@ -1366,6 +1380,7 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 	for (i = 0; i < err_idx; i++)
 		vring_unmap_desc_packed(vq, &desc[i]);
 
+free_desc:
 	kfree(desc);
 
 	END_USE(vq);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
