Return-Path: <SRS0=GFjK=P3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184D8C433FE
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 11:50:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E986120D
	for <virtualization@archiver.kernel.org>; Mon,  8 Nov 2021 11:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B4E986120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82962607D2;
	Mon,  8 Nov 2021 11:50:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D6iTt7cQKaxT; Mon,  8 Nov 2021 11:50:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E255E60678;
	Mon,  8 Nov 2021 11:49:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38B00C0035;
	Mon,  8 Nov 2021 11:49:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 64E07C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 11:49:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4748980DAA
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 11:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7Jm6GLhqJ8B7
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 11:49:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9501180D85
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Nov 2021 11:49:55 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R471e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0Uvb9Wct_1636372191; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Uvb9Wct_1636372191) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 08 Nov 2021 19:49:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v4 1/3] virtio: cache indirect desc for split
Date: Mon,  8 Nov 2021 19:49:49 +0800
Message-Id: <20211108114951.92862-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211108114951.92862-1-xuanzhuo@linux.alibaba.com>
References: <20211108114951.92862-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
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

In the case of using indirect, indirect desc must be allocated and
released each time, which increases a lot of cpu overhead.

Here, a cache is added for indirect. If the number of indirect desc to be
applied for is less than desc_cache_thr, the desc array with
the size of desc_cache_thr is fixed and cached for reuse.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 126 ++++++++++++++++++++++++++++++++---
 include/linux/virtio.h       |  17 +++++
 2 files changed, 135 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index dd95dfd85e98..a4a91c497a83 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -85,6 +85,19 @@ struct vring_desc_extra {
 	u16 next;			/* The next desc state in a list. */
 };
 
+struct vring_desc_cache {
+	/* desc cache chain */
+	struct list_head list;
+
+	void *array;
+
+	/* desc cache threshold
+	 *    0   - disable desc cache
+	 *    > 0 - enable desc cache. As the threshold of the desc cache.
+	 */
+	u32 threshold;
+};
+
 struct vring_virtqueue {
 	struct virtqueue vq;
 
@@ -117,6 +130,8 @@ struct vring_virtqueue {
 	/* Hint for event idx: already triggered no need to disable. */
 	bool event_triggered;
 
+	struct vring_desc_cache desc_cache;
+
 	union {
 		/* Available for split ring */
 		struct {
@@ -423,7 +438,50 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 	return extra[i].next;
 }
 
-static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
+static void desc_cache_init(struct vring_virtqueue *vq)
+{
+	vq->desc_cache.array = NULL;
+	vq->desc_cache.threshold = 0;
+	INIT_LIST_HEAD(&vq->desc_cache.list);
+}
+
+static void desc_cache_free(struct vring_virtqueue *vq)
+{
+	kfree(vq->desc_cache.array);
+}
+
+static void __desc_cache_put(struct vring_virtqueue *vq,
+			     struct list_head *node, int n)
+{
+	if (n <= vq->desc_cache.threshold)
+		list_add(node, &vq->desc_cache.list);
+	else
+		kfree(node);
+}
+
+#define desc_cache_put(vq, desc, n) \
+	__desc_cache_put(vq, (struct list_head *)desc, n)
+
+static void *desc_cache_get(struct vring_virtqueue *vq,
+			    int size, int n, gfp_t gfp)
+{
+	struct list_head *node;
+
+	if (n > vq->desc_cache.threshold)
+		return kmalloc_array(n, size, gfp);
+
+	node = vq->desc_cache.list.next;
+	list_del(node);
+	return node;
+}
+
+#define _desc_cache_get(vq, n, gfp, tp) \
+	((tp *)desc_cache_get(vq, (sizeof(tp)), n, gfp))
+
+#define desc_cache_get_split(vq, n, gfp) \
+	_desc_cache_get(vq, n, gfp, struct vring_desc)
+
+static struct vring_desc *alloc_indirect_split(struct vring_virtqueue *vq,
 					       unsigned int total_sg,
 					       gfp_t gfp)
 {
@@ -437,12 +495,12 @@ static struct vring_desc *alloc_indirect_split(struct virtqueue *_vq,
 	 */
 	gfp &= ~__GFP_HIGHMEM;
 
-	desc = kmalloc_array(total_sg, sizeof(struct vring_desc), gfp);
+	desc = desc_cache_get_split(vq, total_sg, gfp);
 	if (!desc)
 		return NULL;
 
 	for (i = 0; i < total_sg; i++)
-		desc[i].next = cpu_to_virtio16(_vq->vdev, i + 1);
+		desc[i].next = cpu_to_virtio16(vq->vq.vdev, i + 1);
 	return desc;
 }
 
@@ -508,7 +566,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	head = vq->free_head;
 
 	if (virtqueue_use_indirect(_vq, total_sg))
-		desc = alloc_indirect_split(_vq, total_sg, gfp);
+		desc = alloc_indirect_split(vq, total_sg, gfp);
 	else {
 		desc = NULL;
 		WARN_ON_ONCE(total_sg > vq->split.vring.num && !vq->indirect);
@@ -652,7 +710,7 @@ static inline int virtqueue_add_split(struct virtqueue *_vq,
 	}
 
 	if (indirect)
-		kfree(desc);
+		desc_cache_put(vq, desc, total_sg);
 
 	END_USE(vq);
 	return -ENOMEM;
@@ -717,7 +775,7 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 	if (vq->indirect) {
 		struct vring_desc *indir_desc =
 				vq->split.desc_state[head].indir_desc;
-		u32 len;
+		u32 len, n;
 
 		/* Free the indirect table, if any, now that it's unmapped. */
 		if (!indir_desc)
@@ -729,10 +787,12 @@ static void detach_buf_split(struct vring_virtqueue *vq, unsigned int head,
 				VRING_DESC_F_INDIRECT));
 		BUG_ON(len == 0 || len % sizeof(struct vring_desc));
 
-		for (j = 0; j < len / sizeof(struct vring_desc); j++)
+		n = len / sizeof(struct vring_desc);
+
+		for (j = 0; j < n; j++)
 			vring_unmap_one_split_indirect(vq, &indir_desc[j]);
 
-		kfree(indir_desc);
+		desc_cache_put(vq, indir_desc, n);
 		vq->split.desc_state[head].indir_desc = NULL;
 	} else if (ctx) {
 		*ctx = vq->split.desc_state[head].indir_desc;
@@ -2200,6 +2260,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
+	desc_cache_init(vq);
+
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
 
@@ -2329,6 +2391,7 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 	if (!vq->packed_ring) {
 		kfree(vq->split.desc_state);
 		kfree(vq->split.desc_extra);
+		desc_cache_free(vq);
 	}
 	kfree(vq);
 }
@@ -2445,6 +2508,53 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_used_addr);
 
+int virtqueue_set_desc_cache(struct virtqueue *_vq, u32 threshold)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct list_head *node;
+	int size, num, i;
+
+	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct vring_desc));
+	BUILD_BUG_ON(sizeof(struct list_head) > sizeof(struct vring_packed_desc));
+
+	BUG_ON(!vq->we_own_ring);
+
+	if (!vq->indirect)
+		return 0;
+
+	vq->desc_cache.threshold = threshold;
+
+	if (!threshold)
+		return 0;
+
+	if (vq->packed_ring) {
+		size = sizeof(struct vring_packed_desc);
+		num = vq->packed.vring.num;
+	} else {
+		size = sizeof(struct vring_desc);
+		num = vq->split.vring.num;
+	}
+
+	size = size * vq->desc_cache.threshold;
+
+	vq->desc_cache.array = kmalloc_array(num, size, GFP_KERNEL);
+	if (!vq->desc_cache.array) {
+		vq->desc_cache.threshold = 0;
+		dev_warn(&vq->vq.vdev->dev,
+			 "queue[%d] alloc desc cache fail. turn off it.\n",
+			 vq->vq.index);
+		return -1;
+	}
+
+	for (i = 0; i < num; ++i) {
+		node = vq->desc_cache.array + (i * size);
+		list_add(node, &vq->desc_cache.list);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtqueue_set_desc_cache);
+
 /* Only available for split ring */
 const struct vring *virtqueue_get_vring(struct virtqueue *vq)
 {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 41edbc01ffa4..e24b2e90dd42 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -89,6 +89,23 @@ dma_addr_t virtqueue_get_desc_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_avail_addr(struct virtqueue *vq);
 dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
 
+/**
+ * virtqueue_set_desc_cache - set virtio ring desc cache threshold
+ *
+ * virtio will allocate ring.num desc arrays of size threshold in advance. If
+ * total_sg exceeds the threshold, use kmalloc/kfree allocation indirect desc,
+ * if total_sg is less than or equal to the threshold, use these pre-allocated
+ * desc arrays.
+ *
+ * This function must be called immediately after find_vqs and before device
+ * ready.
+ *
+ * @threshold:
+ *    0   - disable desc cache
+ *    > 0 - enable desc cache. As the threshold of the desc cache.
+ */
+int virtqueue_set_desc_cache(struct virtqueue *_vq, u32 threshold);
+
 /**
  * virtio_device - representation of a device using virtio
  * @index: unique position on the virtio bus
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
