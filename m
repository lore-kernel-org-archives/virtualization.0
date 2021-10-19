Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75929C433EF
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 11:52:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A5CC60FD8
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 11:52:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2A5CC60FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0607683CB1;
	Tue, 19 Oct 2021 11:52:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C3a59M5Jsl68; Tue, 19 Oct 2021 11:52:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C1E1D83C46;
	Tue, 19 Oct 2021 11:52:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9160BC0011;
	Tue, 19 Oct 2021 11:52:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 617FBC000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:52:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 44C1B40770
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:52:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PTW-toSHJ4cV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:52:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B233D40771
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 11:52:44 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UsvUncz_1634644356; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UsvUncz_1634644356) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 19 Oct 2021 19:52:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org
Subject: [PATCH v4 2/2] virtio_ring: check desc == NULL when using indirect
 with packed
Date: Tue, 19 Oct 2021 19:52:35 +0800
Message-Id: <20211019115235.106507-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211019115235.106507-1-xuanzhuo@linux.alibaba.com>
References: <20211019115235.106507-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: "David S. Miller" <davem@davemloft.net>, Tiwei Bie <tiwei.bie@intel.com>
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

Fixes: 1ce9e6055fa ("virtio_ring: introduce packed ring support")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 91a46c4da87d..44a03b6e4dc4 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1065,6 +1065,9 @@ static int virtqueue_add_indirect_packed(struct vring_virtqueue *vq,
 
 	head = vq->packed.next_avail_idx;
 	desc = alloc_indirect_packed(total_sg, gfp);
+	if (!desc)
+		/* fall back on direct */
+		return -EAGAIN;
 
 	if (unlikely(vq->vq.num_free < 1)) {
 		pr_debug("Can't add buf len 1 - avail = 0\n");
@@ -1176,6 +1179,7 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 	unsigned int i, n, c, descs_used, err_idx;
 	__le16 head_flags, flags;
 	u16 head, id, prev, curr, avail_used_flags;
+	int err;
 
 	START_USE(vq);
 
@@ -1191,9 +1195,12 @@ static inline int virtqueue_add_packed(struct virtqueue *_vq,
 
 	BUG_ON(total_sg == 0);
 
-	if (virtqueue_use_indirect(_vq, total_sg))
-		return virtqueue_add_indirect_packed(vq, sgs, total_sg,
-				out_sgs, in_sgs, data, gfp);
+	if (virtqueue_use_indirect(_vq, total_sg)) {
+		err = virtqueue_add_indirect_packed(vq, sgs, total_sg, out_sgs,
+						    in_sgs, data, gfp);
+		if (err != -EAGAIN)
+			return err;
+	}
 
 	head = vq->packed.next_avail_idx;
 	avail_used_flags = vq->packed.avail_used_flags;
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
