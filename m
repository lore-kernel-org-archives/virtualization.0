Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371B7C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 12:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDA70415DD;
	Wed,  9 Feb 2022 12:29:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g6I2kTyCEgXw; Wed,  9 Feb 2022 12:29:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8BDDB409AC;
	Wed,  9 Feb 2022 12:29:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 624BFC0011;
	Wed,  9 Feb 2022 12:29:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 130F1C0077
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F1BAA60F08
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id evu5OpWEW26W
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out199-17.us.a.mail.aliyun.com (out199-17.us.a.mail.aliyun.com
 [47.90.199.17])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A154960F38
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:10 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R681e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V4.E4CU_1644409745; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4.E4CU_1644409745) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 20:29:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/14] virtio_ring: queue_reset: split: support enable
 reset queue
Date: Wed,  9 Feb 2022 20:28:52 +0800
Message-Id: <20220209122901.51790-6-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org,
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

The purpose of this patch is to make vring split support re-enable reset
vq.

Based on whether the incoming vq passed by vring_setup_virtqueue() is
NULL or not, distinguish whether it is a normal create virtqueue or
re-enable a reset queue.

When re-enable a reset queue, reuse the original callback, name, priv,
indirect.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 53 ++++++++++++++++++++++++++----------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 30be9173c263..8530f144329b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -198,6 +198,16 @@ struct vring_virtqueue {
 #endif
 };
 
+static int __vring_init_virtqueue(struct virtqueue *_vq,
+				  unsigned int index,
+				  struct vring vring,
+				  struct virtio_device *vdev,
+				  bool weak_barriers,
+				  bool context,
+				  bool (*notify)(struct virtqueue *),
+				  void (*callback)(struct virtqueue *),
+				  const char *name,
+				  bool reset);
 
 /*
  * Helpers.
@@ -925,9 +935,9 @@ static struct virtqueue *vring_create_virtqueue_split(
 	bool context,
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
-	const char *name)
+	const char *name,
+	struct virtqueue *vq)
 {
-	struct virtqueue *vq;
 	void *queue = NULL;
 	dma_addr_t dma_addr;
 	size_t queue_size_in_bytes;
@@ -964,12 +974,17 @@ static struct virtqueue *vring_create_virtqueue_split(
 	queue_size_in_bytes = vring_size(num, vring_align);
 	vring_init(&vring, num, queue, vring_align);
 
-	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
-				   notify, callback, name);
 	if (!vq) {
-		vring_free_queue(vdev, queue_size_in_bytes, queue,
-				 dma_addr);
-		return NULL;
+		vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers,
+					   context, notify, callback, name);
+		if (!vq)
+			goto err;
+
+	} else {
+		if (__vring_init_virtqueue(vq, index, vring, vdev,
+					   weak_barriers, context, notify,
+					   callback, name, true))
+			goto err;
 	}
 
 	to_vvq(vq)->split.queue_dma_addr = dma_addr;
@@ -977,6 +992,9 @@ static struct virtqueue *vring_create_virtqueue_split(
 	to_vvq(vq)->we_own_ring = true;
 
 	return vq;
+err:
+	vring_free_queue(vdev, queue_size_in_bytes, queue, dma_addr);
+	return NULL;
 }
 
 
@@ -2175,14 +2193,21 @@ static int __vring_init_virtqueue(struct virtqueue *_vq,
 				  bool context,
 				  bool (*notify)(struct virtqueue *),
 				  void (*callback)(struct virtqueue *),
-				  const char *name)
+				  const char *name,
+				  bool reset)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
+	if (!reset) {
+		vq->vq.callback = callback;
+		vq->vq.name = name;
+		vq->vq.priv = NULL;
+		vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
+			!context;
+	}
+
 	vq->packed_ring = false;
-	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
-	vq->vq.name = name;
 	vq->vq.num_free = vring.num;
 	vq->vq.index = index;
 	vq->we_own_ring = false;
@@ -2198,8 +2223,6 @@ static int __vring_init_virtqueue(struct virtqueue *_vq,
 	vq->last_add_time_valid = false;
 #endif
 
-	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
-		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
@@ -2213,7 +2236,7 @@ static int __vring_init_virtqueue(struct virtqueue *_vq,
 	vq->split.avail_idx_shadow = 0;
 
 	/* No callback?  Tell other side not to bother us. */
-	if (!callback) {
+	if (!vq->vq.callback) {
 		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
 		if (!vq->event)
 			vq->split.vring.avail->flags = cpu_to_virtio16(vdev,
@@ -2265,7 +2288,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 		return NULL;
 
 	err = __vring_init_virtqueue(&vq->vq, index, vring, vdev, weak_barriers,
-				     context, notify, callback, name);
+				     context, notify, callback, name, false);
 
 	if (err) {
 		kfree(vq);
@@ -2297,7 +2320,7 @@ struct virtqueue *vring_setup_virtqueue(
 
 	return vring_create_virtqueue_split(index, num, vring_align,
 			vdev, weak_barriers, may_reduce_num,
-			context, notify, callback, name);
+			context, notify, callback, name, vq);
 }
 EXPORT_SYMBOL_GPL(vring_setup_virtqueue);
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
