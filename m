Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414B1C433F5
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 09:35:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72F6583E4A;
	Mon, 14 Mar 2022 09:35:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0P1NUNF6vQjB; Mon, 14 Mar 2022 09:35:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B404C83E22;
	Mon, 14 Mar 2022 09:35:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7068DC0088;
	Mon, 14 Mar 2022 09:35:16 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11227C008B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1582741571
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pIS9YIEF_vq3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBFC541574
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:09 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V76sSyf_1647250505; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V76sSyf_1647250505) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Mar 2022 17:35:05 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v8 11/16] virtio_ring: packed: extract the logic of alloc queue
Date: Mon, 14 Mar 2022 17:34:50 +0800
Message-Id: <20220314093455.34707-12-xuanzhuo@linux.alibaba.com>
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

Separate the logic of packed to create vring queue.

For the convenience of passing parameters, add a structure
vring_packed.

This feature is required for subsequent virtuqueue reset vring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 121 ++++++++++++++++++++++++++---------
 1 file changed, 92 insertions(+), 29 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a15869514146..96ff2dabda14 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -85,6 +85,18 @@ struct vring_desc_extra {
 	u16 next;			/* The next desc state in a list. */
 };
 
+struct vring_packed {
+	u32 num;
+	struct vring_packed_desc *ring;
+	struct vring_packed_desc_event *driver;
+	struct vring_packed_desc_event *device;
+	dma_addr_t ring_dma_addr;
+	dma_addr_t driver_event_dma_addr;
+	dma_addr_t device_event_dma_addr;
+	size_t ring_size_in_bytes;
+	size_t event_size_in_bytes;
+};
+
 struct vring_virtqueue {
 	struct virtqueue vq;
 
@@ -1735,45 +1747,101 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
 	return desc_extra;
 }
 
-static struct virtqueue *vring_create_virtqueue_packed(
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
+static void vring_free_vring_packed(struct vring_packed *vring,
+				    struct virtio_device *vdev)
+{
+	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
+	struct vring_packed_desc_event *driver, *device;
+	size_t ring_size_in_bytes, event_size_in_bytes;
+	struct vring_packed_desc *ring;
+
+	ring                  = vring->ring;
+	driver                = vring->driver;
+	device                = vring->device;
+	ring_size_in_bytes    = vring->ring_size_in_bytes;
+	event_size_in_bytes   = vring->event_size_in_bytes;
+	ring_dma_addr         = vring->ring_dma_addr;
+	driver_event_dma_addr = vring->driver_event_dma_addr;
+	device_event_dma_addr = vring->device_event_dma_addr;
+
+	if (device)
+		vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
+
+	if (driver)
+		vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
+
+	if (ring)
+		vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
+}
+
+static int vring_alloc_queue_packed(struct vring_packed *vring,
+				    struct virtio_device *vdev,
+				    u32 num)
 {
-	struct vring_virtqueue *vq;
 	struct vring_packed_desc *ring;
 	struct vring_packed_desc_event *driver, *device;
 	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
 	size_t ring_size_in_bytes, event_size_in_bytes;
 
+	memset(vring, 0, sizeof(*vring));
+
 	ring_size_in_bytes = num * sizeof(struct vring_packed_desc);
 
 	ring = vring_alloc_queue(vdev, ring_size_in_bytes,
 				 &ring_dma_addr,
 				 GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 	if (!ring)
-		goto err_ring;
+		goto err;
+
+	vring->num = num;
+	vring->ring = ring;
+	vring->ring_size_in_bytes = ring_size_in_bytes;
+	vring->ring_dma_addr = ring_dma_addr;
 
 	event_size_in_bytes = sizeof(struct vring_packed_desc_event);
+	vring->event_size_in_bytes = event_size_in_bytes;
 
 	driver = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &driver_event_dma_addr,
 				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 	if (!driver)
-		goto err_driver;
+		goto err;
+
+	vring->driver = driver;
+	vring->driver_event_dma_addr = driver_event_dma_addr;
 
 	device = vring_alloc_queue(vdev, event_size_in_bytes,
 				   &device_event_dma_addr,
 				   GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 	if (!device)
-		goto err_device;
+		goto err;
+
+	vring->device = device;
+	vring->device_event_dma_addr = device_event_dma_addr;
+	return 0;
+
+err:
+	vring_free_vring_packed(vring, vdev);
+	return -ENOMEM;
+}
+
+static struct virtqueue *vring_create_virtqueue_packed(
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
+	struct vring_virtqueue *vq;
+	struct vring_packed vring;
+
+	if (vring_alloc_queue_packed(&vring, vdev, num))
+		goto err_vq;
 
 	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
 	if (!vq)
@@ -1805,17 +1873,17 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
 
-	vq->packed.ring_dma_addr = ring_dma_addr;
-	vq->packed.driver_event_dma_addr = driver_event_dma_addr;
-	vq->packed.device_event_dma_addr = device_event_dma_addr;
+	vq->packed.ring_dma_addr = vring.ring_dma_addr;
+	vq->packed.driver_event_dma_addr = vring.driver_event_dma_addr;
+	vq->packed.device_event_dma_addr = vring.device_event_dma_addr;
 
-	vq->packed.ring_size_in_bytes = ring_size_in_bytes;
-	vq->packed.event_size_in_bytes = event_size_in_bytes;
+	vq->packed.ring_size_in_bytes = vring.ring_size_in_bytes;
+	vq->packed.event_size_in_bytes = vring.event_size_in_bytes;
 
 	vq->packed.vring.num = num;
-	vq->packed.vring.desc = ring;
-	vq->packed.vring.driver = driver;
-	vq->packed.vring.device = device;
+	vq->packed.vring.desc = vring.ring;
+	vq->packed.vring.driver = vring.driver;
+	vq->packed.vring.device = vring.device;
 
 	vq->packed.next_avail_idx = 0;
 	vq->packed.avail_wrap_counter = 1;
@@ -1856,12 +1924,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 err_desc_state:
 	kfree(vq);
 err_vq:
-	vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
-err_device:
-	vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
-err_driver:
-	vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
-err_ring:
+	vring_free_vring_packed(&vring, vdev);
 	return NULL;
 }
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
