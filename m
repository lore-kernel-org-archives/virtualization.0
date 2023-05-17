Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFAEC7EE2C
	for <virtualization@archiver.kernel.org>; Wed, 17 May 2023 02:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7461841176;
	Wed, 17 May 2023 02:23:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7461841176
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JKsGTsSPTF9B; Wed, 17 May 2023 02:23:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C241441181;
	Wed, 17 May 2023 02:23:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C241441181
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A7DD7C0091;
	Wed, 17 May 2023 02:23:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 236DFC002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:23:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F3A0940895
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:22:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org F3A0940895
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ftkheb7J7xl9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:22:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D853D405EC
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D853D405EC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 02:22:58 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0ViqlPLP_1684290173; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0ViqlPLP_1684290173) by smtp.aliyun-inc.com;
 Wed, 17 May 2023 10:22:54 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v9 04/12] virtio_ring: virtqueue_add() support premapped
Date: Wed, 17 May 2023 10:22:41 +0800
Message-Id: <20230517022249.20790-5-xuanzhuo@linux.alibaba.com>
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

virtuque_add() adds parameter premapped.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1ffab1eb40c0..e2fc50c05bec 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2135,6 +2135,7 @@ static inline int virtqueue_add(struct virtqueue *_vq,
 				unsigned int in_sgs,
 				void *data,
 				void *ctx,
+				bool premapped,
 				gfp_t gfp)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
@@ -2176,7 +2177,7 @@ int virtqueue_add_sgs(struct virtqueue *_vq,
 			total_sg++;
 	}
 	return virtqueue_add(_vq, sgs, total_sg, out_sgs, in_sgs,
-			     data, NULL, gfp);
+			     data, NULL, false, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_sgs);
 
@@ -2198,7 +2199,7 @@ int virtqueue_add_outbuf(struct virtqueue *vq,
 			 void *data,
 			 gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, gfp);
+	return virtqueue_add(vq, &sg, num, 1, 0, data, NULL, false, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_outbuf);
 
@@ -2220,7 +2221,7 @@ int virtqueue_add_inbuf(struct virtqueue *vq,
 			void *data,
 			gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, data, NULL, false, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf);
 
@@ -2244,7 +2245,7 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 			void *ctx,
 			gfp_t gfp)
 {
-	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, gfp);
+	return virtqueue_add(vq, &sg, num, 0, 1, data, ctx, false, gfp);
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
 
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
