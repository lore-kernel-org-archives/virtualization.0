Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98879C433EF
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 09:35:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 61F4283381;
	Mon, 14 Mar 2022 09:35:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6eXuCSXXtJSL; Mon, 14 Mar 2022 09:35:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C72A3818B5;
	Mon, 14 Mar 2022 09:35:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 22550C0070;
	Mon, 14 Mar 2022 09:35:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D128C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D575D60601
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yABmmkVDG0gx
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F1BC560EAF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:09 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R681e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V76s61R_1647250506; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V76s61R_1647250506) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Mar 2022 17:35:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v8 13/16] virtio_ring: packed: extract the logic of attach
 vring
Date: Mon, 14 Mar 2022 17:34:52 +0800
Message-Id: <20220314093455.34707-14-xuanzhuo@linux.alibaba.com>
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

Separate the logic of attach vring, the subsequent patch will call it
separately.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 41 +++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 980bd77d8243..e8d4de25e90b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1854,6 +1854,31 @@ static int vring_alloc_state_extra_packed(u32 num, struct vring_packed *vring)
 	return -ENOMEM;
 }
 
+static void vring_virtqueue_attach_packed(struct vring_virtqueue *vq,
+					  struct vring_packed *vring)
+{
+	u32 num;
+
+	num = vring->num;
+
+	vq->vq.num_free = num;
+
+	vq->packed.ring_dma_addr = vring->ring_dma_addr;
+	vq->packed.driver_event_dma_addr = vring->driver_event_dma_addr;
+	vq->packed.device_event_dma_addr = vring->device_event_dma_addr;
+
+	vq->packed.ring_size_in_bytes = vring->ring_size_in_bytes;
+	vq->packed.event_size_in_bytes = vring->event_size_in_bytes;
+
+	vq->packed.vring.num = num;
+	vq->packed.vring.desc = vring->ring;
+	vq->packed.vring.driver = vring->driver;
+	vq->packed.vring.device = vring->device;
+
+	vq->packed.desc_state = vring->desc_state;
+	vq->packed.desc_extra = vring->desc_extra;
+}
+
 static struct virtqueue *vring_create_virtqueue_packed(
 	unsigned int index,
 	unsigned int num,
@@ -1880,7 +1905,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
-	vq->vq.num_free = num;
 	vq->vq.index = index;
 	vq->we_own_ring = true;
 	vq->notify = notify;
@@ -1903,18 +1927,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
 
-	vq->packed.ring_dma_addr = vring.ring_dma_addr;
-	vq->packed.driver_event_dma_addr = vring.driver_event_dma_addr;
-	vq->packed.device_event_dma_addr = vring.device_event_dma_addr;
-
-	vq->packed.ring_size_in_bytes = vring.ring_size_in_bytes;
-	vq->packed.event_size_in_bytes = vring.event_size_in_bytes;
-
-	vq->packed.vring.num = num;
-	vq->packed.vring.desc = vring.ring;
-	vq->packed.vring.driver = vring.driver;
-	vq->packed.vring.device = vring.device;
-
 	vq->packed.next_avail_idx = 0;
 	vq->packed.avail_wrap_counter = 1;
 	vq->packed.used_wrap_counter = 1;
@@ -1925,8 +1937,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (err)
 		goto err_state_extra;
 
-	vq->packed.desc_state = vring.desc_state;
-	vq->packed.desc_extra = vring.desc_extra;
+	vring_virtqueue_attach_packed(vq, &vring);
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
