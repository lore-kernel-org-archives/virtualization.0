Return-Path: <SRS0=ZIIO=PN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB0C433FE
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 01:56:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5410861029
	for <virtualization@archiver.kernel.org>; Mon, 25 Oct 2021 01:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5410861029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 304B440312;
	Mon, 25 Oct 2021 01:56:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HHWwjrNBDLB3; Mon, 25 Oct 2021 01:56:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E15F940310;
	Mon, 25 Oct 2021 01:56:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C929DC0019;
	Mon, 25 Oct 2021 01:56:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 727EEC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 01:56:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5FF0840243
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 01:56:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NgMg8UtgIKbp
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 01:56:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D2C9940297
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Oct 2021 01:56:46 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0UtUyC2j_1635127002; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UtUyC2j_1635127002) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 25 Oct 2021 09:56:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: sfr@canb.auug.org.au
Subject: [PATCH v7 2/2] virtio_ring: check desc == NULL when using indirect
 with packed
Date: Mon, 25 Oct 2021 09:56:41 +0800
Message-Id: <20211025015641.48293-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211025015641.48293-1-xuanzhuo@linux.alibaba.com>
References: <20211025015641.48293-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, Tiwei Bie <tiwei.bie@intel.com>,
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

When using indirect with packed, we don't check for allocation failures.
This patch checks that and fall back on direct.

Fixes: 1ce9e6055fa0 ("virtio_ring: introduce packed ring support")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 91a46c4da87d..bc92a2faa28f 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1065,6 +1065,8 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 
 	head = vq->packed.next_avail_idx;
 	desc = alloc_indirect_packed(total_sg, gfp);
+	if (!desc)
+		return -ENOMEM;
 
 	if (unlikely(vq->vq.num_free < 1)) {
 		pr_debug("Can't add buf len 1 - avail = 0\n");
@@ -1176,6 +1178,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	unsigned int i, n, c, descs_used, err_idx;
 	__le16 head_flags, flags;
 	u16 head, id, prev, curr, avail_used_flags;
+	int err;
 
 	START_USE(vq);
 
@@ -1191,9 +1194,14 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	BUG_ON(total_sg == 0);
 
-	if (virtqueue_use_indirect(_vq, total_sg))
-		return virtqueue_add_indirect_packed(vq, sgs, total_sg,
-				out_sgs, in_sgs, data, gfp);
+	if (virtqueue_use_indirect(_vq, total_sg)) {
+		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
+						    in_sgs, data, gfp);
+		if (err != -ENOMEM)
+			return err;
+
+		/* fall back on direct */
+	}
 
 	head = vq->packed.next_avail_idx;
 	avail_used_flags = vq->packed.avail_used_flags;
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
