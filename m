Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2C1C77B7A
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 02:23:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 227B5616E1;
	Wed, 17 May 2023 02:23:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 227B5616E1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Deib4yBH8q0N; Wed, 17 May 2023 02:23:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B4E1F61698;
	Wed, 17 May 2023 02:23:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4E1F61698
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6010C0091;
	Wed, 17 May 2023 02:23:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1356C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:23:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7F90E61385
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:23:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F90E61385
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id txFwnoLOJh37
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:23:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C5BF6161C
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6C5BF6161C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:23:02 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R771e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0ViqlmWz_1684290177; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0ViqlmWz_1684290177) by smtp.aliyun-inc.com;
 Wed, 17 May 2023 10:22:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v9 08/12] virtio_ring: introduce
 virtqueue_add_inbuf_premapped()
Date: Wed, 17 May 2023 10:22:45 +0800
Message-Id: <20230517022249.20790-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230517022249.20790-1-xuanzhuo@linux.alibaba.com>
References: <20230517022249.20790-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: c00a8eb40cdd
Cc: Christoph Hellwig <hch@infradead.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
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

Introduce virtqueue_add_inbuf_premapped() to submit premapped sgs.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 25 +++++++++++++++++++++++++
 include/linux/virtio.h       |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 3d3e602fd261..cbeac2f516c7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2310,6 +2310,31 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
 
+/**
+ * virtqueue_add_inbuf_premapped - expose input buffers to other end
+ * @vq: the struct virtqueue we're talking about.
+ * @sg: scatterlist (must be well-formed and terminated!)
+ * @num: the number of entries in @sg writable by other side
+ * @data: the token identifying the buffer.
+ * @gfp: how to do memory allocations (if necessary).
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * It is required that all addrs have completed DMA operations. And use
+ * sg->dma_address, sg->length to pass addr and length.
+ *
+ * Returns zero or a negative error (ie. ENOSPC, ENOMEM, EIO).
+ */
+int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
+				  struct scatterlist *sg, unsigned int num,
+				  void *data,
+				  gfp_t gfp)
+{
+	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, true, gfp);
+}
+EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_premapped);
+
 /**
  * virtqueue_kick_prepare - first half of split virtqueue_kick call.
  * @_vq: the struct virtqueue
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index a533253fa9e8..0f787cdcfd5a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -59,6 +59,11 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 			    void *ctx,
 			    gfp_t gfp);
 
+int virtqueue_add_inbuf_premapped(struct virtqueue *vq,
+				  struct scatterlist *sg, unsigned int num,
+				  void *data,
+				  gfp_t gfp);
+
 int virtqueue_add_sgs(struct virtqueue *vq,
 		      struct scatterlist *sgs[],
 		      unsigned int out_sgs,
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
