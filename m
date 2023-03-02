Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F58C678D4
	for <virtualization@archiver.kernel.org>; Thu,  2 Mar 2023 11:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4BDFB61230;
	Thu,  2 Mar 2023 11:59:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BDFB61230
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EVJIn9018b0m; Thu,  2 Mar 2023 11:59:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CE9EC60EC4;
	Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CE9EC60EC4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A50EBC008A;
	Thu,  2 Mar 2023 11:59:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 285FAC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E811840FCE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E811840FCE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0eAr-wLoaFuC
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ADED640CB0
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADED640CB0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Mar 2023 11:59:16 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R271e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VcxG4yP_1677758351; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VcxG4yP_1677758351) by smtp.aliyun-inc.com;
 Thu, 02 Mar 2023 19:59:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v1 04/12] virtio_ring: packed: separate prepare code
 from virtuque_add_indirect_packed()
Date: Thu,  2 Mar 2023 19:59:00 +0800
Message-Id: <20230302115908.1461-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
References: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: b21604ee9ed7
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
index 5b186ce73d35..178edf1171e2 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1348,25 +1348,14 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
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
@@ -1488,11 +1477,17 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
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
