Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2939BC4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 09:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D91AF4156A;
	Mon, 14 Mar 2022 09:35:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EKdcEWf4HB1t; Mon, 14 Mar 2022 09:35:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id AB8334155B;
	Mon, 14 Mar 2022 09:35:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B0962C008F;
	Mon, 14 Mar 2022 09:35:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAF50C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8385640895
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IZ0gqHwtASvB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 434AB404A6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:04 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V7877oz_1647250500; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V7877oz_1647250500) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Mar 2022 17:35:01 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v8 06/16] virtio_ring: split: extract the logic of alloc queue
Date: Mon, 14 Mar 2022 17:34:45 +0800
Message-Id: <20220314093455.34707-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d6feaa0fb7e7
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

Separate the logic of split to create vring queue.

This feature is required for subsequent virtuqueue reset vring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 53 ++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 763532a2ffe4..d7667f74c42b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -915,23 +915,15 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 	return NULL;
 }
 
-static struct virtqueue *vring_create_virtqueue_split(
-	unsigned int index,
-	unsigned int num,
-	unsigned int vring_align,
-	struct virtio_device *vdev,
-	bool weak_barriers,
-	bool may_reduce_num,
-	bool context,
-	bool (*notify)(struct virtqueue *),
-	void (*callback)(struct virtqueue *),
-	const char *name)
+static void *vring_alloc_queue_split(struct virtio_device *vdev,
+				     dma_addr_t *dma_addr,
+				     u32 *n,
+				     unsigned int vring_align,
+				     bool weak_barriers,
+				     bool may_reduce_num)
 {
-	struct virtqueue *vq;
 	void *queue = NULL;
-	dma_addr_t dma_addr;
-	size_t queue_size_in_bytes;
-	struct vring vring;
+	u32 num = *n;
 
 	/* We assume num is a power of 2. */
 	if (num & (num - 1)) {
@@ -942,7 +934,7 @@ static struct virtqueue *vring_create_virtqueue_split(
 	/* TODO: allocate each queue chunk individually */
 	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
 		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
-					  &dma_addr,
+					  dma_addr,
 					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 		if (queue)
 			break;
@@ -956,11 +948,38 @@ static struct virtqueue *vring_create_virtqueue_split(
 	if (!queue) {
 		/* Try to get a single page. You are my only hope! */
 		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
-					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
+					  dma_addr, GFP_KERNEL|__GFP_ZERO);
 	}
 	if (!queue)
 		return NULL;
 
+	*n = num;
+	return queue;
+}
+
+static struct virtqueue *vring_create_virtqueue_split(
+	unsigned int index,
+	unsigned int num,
+	unsigned int vring_align,
+	struct virtio_device *vdev,
+	bool weak_barriers,
+	bool may_reduce_num,
+	bool context,
+	bool (*notify)(struct virtqueue *),
+	void (*callback)(struct virtqueue *),
+	const char *name)
+{
+	size_t queue_size_in_bytes;
+	struct virtqueue *vq;
+	dma_addr_t dma_addr;
+	struct vring vring;
+	void *queue;
+
+	queue = vring_alloc_queue_split(vdev, &dma_addr, &num, vring_align,
+					weak_barriers, may_reduce_num);
+	if (!queue)
+		return NULL;
+
 	queue_size_in_bytes = vring_size(num, vring_align);
 	vring_init(&vring, num, queue, vring_align);
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
