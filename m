Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5619CC6FD1C
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 06:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00E6E40AB8;
	Fri, 24 Mar 2023 06:30:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00E6E40AB8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x16nYNknL6na; Fri, 24 Mar 2023 06:30:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7CAE840920;
	Fri, 24 Mar 2023 06:30:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7CAE840920
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65FA6C0035;
	Fri, 24 Mar 2023 06:30:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 839B5C0035
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:30:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4E8D060E63
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:30:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E8D060E63
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id K2xcfsPasxbO
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:30:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F23FD60E28
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F23FD60E28
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 06:30:20 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VeWgk3S_1679639415; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeWgk3S_1679639415) by smtp.aliyun-inc.com;
 Fri, 24 Mar 2023 14:30:16 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v5 07/11] virtio_ring: update document for
 virtqueue_add_*
Date: Fri, 24 Mar 2023 14:30:06 +0800
Message-Id: <20230324063010.48670-8-xuanzhuo@linux.alibaba.com>
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

Update the document of virtqueue_add_* series API, allowing the callers to
use sg->dma_address to pass the dma address to Virtio Core.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 511d791ba9cc..fab956784564 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2201,6 +2201,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
  *
+ * If the caller has done dma map then use sg->dma_address to pass dma address.
+ * If one sg->dma_address is used, then all sgs must use sg->dma_address;
+ * otherwise all sg->dma_address must be NULL.
+ *
  * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
  */
 int virtqueue_add_sgs(struct virtqueue *_vq,
@@ -2235,6 +2239,10 @@ EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
  *
+ * If the caller has done dma map then use sg->dma_address to pass dma address.
+ * If one sg->dma_address is used, then all sgs must use sg->dma_address;
+ * otherwise all sg->dma_address must be NULL.
+ *
  * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
  */
 int virtqueue_add_outbuf(struct virtqueue *vq,
@@ -2257,6 +2265,10 @@ EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
  *
+ * If the caller has done dma map then use sg->dma_address to pass dma address.
+ * If one sg->dma_address is used, then all sgs must use sg->dma_address;
+ * otherwise all sg->dma_address must be NULL.
+ *
  * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
  */
 int virtqueue_add_inbuf(struct virtqueue *vq,
@@ -2280,6 +2292,10 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
  * Caller must ensure we don't call this with other virtqueue operations
  * at the same time (except where noted).
  *
+ * If the caller has done dma map then use sg->dma_address to pass dma address.
+ * If one sg->dma_address is used, then all sgs must use sg->dma_address;
+ * otherwise all sg->dma_address must be NULL.
+ *
  * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
  */
 int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
