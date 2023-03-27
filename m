Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162E7C761AF
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 04:05:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 931F460F9A;
	Mon, 27 Mar 2023 04:05:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 931F460F9A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P3GZcN7UlD4I; Mon, 27 Mar 2023 04:05:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 33C9660F51;
	Mon, 27 Mar 2023 04:05:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 33C9660F51
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64631C008E;
	Mon, 27 Mar 2023 04:05:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86A05C0094
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 04:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4F69E60F66
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 04:05:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F69E60F66
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EGGx_mWMoioW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 04:05:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E073460E84
Received: from out30-113.freemail.mail.aliyun.com
 (out30-113.freemail.mail.aliyun.com [115.124.30.113])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E073460E84
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 04:05:46 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R591e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0Vef4Nhm_1679889942; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vef4Nhm_1679889942) by smtp.aliyun-inc.com;
 Mon, 27 Mar 2023 12:05:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v6 07/11] virtio_ring: update document for
 virtqueue_add_*
Date: Mon, 27 Mar 2023 12:05:32 +0800
Message-Id: <20230327040536.48338-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 47bb36a6322f
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
index d5dffbe50070..0b198ec3ff92 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2202,6 +2202,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
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
@@ -2236,6 +2240,10 @@ EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
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
@@ -2258,6 +2266,10 @@ EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
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
@@ -2281,6 +2293,10 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
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
