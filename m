Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BCEC61DA4
	for <virtualization@archiver.kernel.org>; Tue, 14 Feb 2023 07:27:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EF5E61126;
	Tue, 14 Feb 2023 07:27:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6EF5E61126
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bc9YJ7xYXP6a; Tue, 14 Feb 2023 07:27:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 10BF261123;
	Tue, 14 Feb 2023 07:27:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10BF261123
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75F3EC0078;
	Tue, 14 Feb 2023 07:27:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F4E8C002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5DA46416B5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DA46416B5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z8iVmE_CM4zY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A1D3D415FB
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1D3D415FB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 07:27:12 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0Vbeue3n_1676359626; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vbeue3n_1676359626) by smtp.aliyun-inc.com;
 Tue, 14 Feb 2023 15:27:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost 02/10] virtio_ring: packed: separate prepare code from
 virtuque_add_indirect_packed()
Date: Tue, 14 Feb 2023 15:26:56 +0800
Message-Id: <20230214072704.126660-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
References: <20230214072704.126660-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 1d14bf2ff3c2
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

Separating the logic of allocating indirect desc and checking queue
status to the upper layer function.

The proposal of this is convenient to refactor virtqueue_add_packed()
for premapped.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 560ee30d942c..42b1ff87518e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1330,25 +1330,14 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 					 unsigned int out_sgs,
 					 unsigned int in_sgs,
 					 void *data,
-					 gfp_t gfp)
+					 struct vring_packed_desc *desc)
 {
-	struct vring_packed_desc *desc;
 	struct scatterlist *sg;
 	unsigned int i, n, err_idx;
 	u16 head, id;
 	dma_addr_t addr;
 
 	head = vq->packed.next_avail_idx;
-	desc = alloc_indirect_packed(total_sg, gfp);
-	if (!desc)
-		return -ENOMEM;
-
-	if (unlikely(vq->vq.num_free < 1)) {
-		pr_debug("Can't add buf len 1 - avail = 0\n");
-		kfree(desc);
-		END_USE(vq);
-		return -ENOSPC;
-	}
 
 	i = 0;
 	id = vq->free_head;
@@ -1470,11 +1459,17 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	BUG_ON(total_sg == 0);
 
 	if (virtqueue_use_indirect(vq, total_sg)) {
-		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
-						    in_sgs, data, gfp);
-		if (err != -ENOMEM) {
-			END_USE(vq);
-			return err;
+		desc = alloc_indirect_packed(total_sg, gfp);
+		if (desc) {
+			if (unlikely(vq->vq.num_free < 1)) {
+				pr_debug("Can't add buf len 1 - avail = 0\n");
+				kfree(desc);
+				END_USE(vq);
+				return -ENOSPC;
+			}
+
+			return virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
+							     in_sgs, data, desc);
 		}
 
 		/* fall back on direct */
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
