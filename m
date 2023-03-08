Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F040FC678D5
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 06:45:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7C01B41749;
	Wed,  8 Mar 2023 06:45:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7C01B41749
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2RI6NHxp8lT0; Wed,  8 Mar 2023 06:45:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 165274175D;
	Wed,  8 Mar 2023 06:45:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 165274175D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E2BDEC008B;
	Wed,  8 Mar 2023 06:44:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23845C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA6F061108
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA6F061108
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PlxNre0mH4hV
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8A56D61100
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8A56D61100
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:54 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R551e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VdORVwg_1678257890; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VdORVwg_1678257890) by smtp.aliyun-inc.com;
 Wed, 08 Mar 2023 14:44:50 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v2 08/12] virtio_ring: update document for
 virtqueue_add_*
Date: Wed,  8 Mar 2023 14:44:39 +0800
Message-Id: <20230308064443.50639-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: a39da90ba7d5
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
index b23d301effb5..216ac8654982 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2190,6 +2190,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
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
@@ -2224,6 +2228,10 @@ EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
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
@@ -2246,6 +2254,10 @@ EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
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
@@ -2269,6 +2281,10 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
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
