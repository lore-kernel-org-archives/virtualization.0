Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7963BC77B7E
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 07:36:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E90060BE6;
	Tue, 25 Apr 2023 07:36:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E90060BE6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zkgpMqCjZ5Zf; Tue, 25 Apr 2023 07:36:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ADC4160C01;
	Tue, 25 Apr 2023 07:36:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADC4160C01
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B85BC0037;
	Tue, 25 Apr 2023 07:36:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24245C0090
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DE2E940983
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:36:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DE2E940983
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oJStHs4bEFeT
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:36:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B8F540982
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B8F540982
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 07:36:28 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R381e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VgzEVtd_1682408182; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VgzEVtd_1682408182) by smtp.aliyun-inc.com;
 Tue, 25 Apr 2023 15:36:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v7 07/11] virtio_ring: update document for
 virtqueue_add_*
Date: Tue, 25 Apr 2023 15:36:09 +0800
Message-Id: <20230425073613.8839-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230425073613.8839-1-xuanzhuo@linux.alibaba.com>
References: <20230425073613.8839-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: c518d34a1cf7
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

Update the document of virtqueue_add_* series API, allowing the callers to
use sg->dma_address to pass the dma address to Virtio Core.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0bc011e6e96e..e7921b27bb01 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2218,6 +2218,10 @@ static inline int virtqueue_add(struct virtqueue *_vq,
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
@@ -2252,6 +2256,10 @@ EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
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
@@ -2274,6 +2282,10 @@ EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
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
@@ -2297,6 +2309,10 @@ EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
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
