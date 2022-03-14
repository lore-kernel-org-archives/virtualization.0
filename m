Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DB5C433F5
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 09:35:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E8B2B60EAF;
	Mon, 14 Mar 2022 09:35:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6X43i4raJHIC; Mon, 14 Mar 2022 09:35:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8205A60EC3;
	Mon, 14 Mar 2022 09:35:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52EB1C0084;
	Mon, 14 Mar 2022 09:35:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCDFAC0070
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C0E2D60EB3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q2wB9wmItB1x
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DCB6A60EAF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:06 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V76sSy7_1647250503; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V76sSy7_1647250503) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Mar 2022 17:35:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v8 09/16] virtio_ring: split: extract the logic of vq init
Date: Mon, 14 Mar 2022 17:34:48 +0800
Message-Id: <20220314093455.34707-10-xuanzhuo@linux.alibaba.com>
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

Separate the logic of initializing vq, and subsequent patches will call
it separately.

The feature of this part is that it does not depend on the information
passed by the upper layer and can be called repeatedly.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 65 ++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 29 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6ed10c46d6d6..81bbfd65411e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2228,6 +2228,41 @@ static void __vring_virtqueue_attach_split(struct vring_virtqueue *vq,
 	vq->split.desc_extra = desc_extra;
 }
 
+static void __vring_virtqueue_init_split(struct vring_virtqueue *vq,
+					 struct virtio_device *vdev)
+{
+	vq->packed_ring = false;
+	vq->we_own_ring = false;
+	vq->broken = false;
+	vq->last_used_idx = 0;
+	vq->event_triggered = false;
+	vq->num_added = 0;
+	vq->use_dma_api = vring_use_dma_api(vdev);
+#ifdef DEBUG
+	vq->in_use = false;
+	vq->last_add_time_valid = false;
+#endif
+
+	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
+
+	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
+		vq->weak_barriers = false;
+
+	vq->split.avail_flags_shadow = 0;
+	vq->split.avail_idx_shadow = 0;
+
+	/* No callback?  Tell other side not to bother us. */
+	if (!vq->vq.callback) {
+		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
+		if (!vq->event)
+			vq->split.vring.avail->flags = cpu_to_virtio16(vdev,
+					vq->split.avail_flags_shadow);
+	}
+
+	/* Put everything in free lists. */
+	vq->free_head = 0;
+}
+
 /* Only available for split ring */
 struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					struct vring vring,
@@ -2250,41 +2285,15 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	if (!vq)
 		return NULL;
 
-	vq->packed_ring = false;
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
 	vq->vq.index = index;
-	vq->we_own_ring = false;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
-	vq->broken = false;
-	vq->last_used_idx = 0;
-	vq->event_triggered = false;
-	vq->num_added = 0;
-	vq->use_dma_api = vring_use_dma_api(vdev);
-#ifdef DEBUG
-	vq->in_use = false;
-	vq->last_add_time_valid = false;
-#endif
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
-	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
-
-	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
-		vq->weak_barriers = false;
-
-	vq->split.avail_flags_shadow = 0;
-	vq->split.avail_idx_shadow = 0;
-
-	/* No callback?  Tell other side not to bother us. */
-	if (!callback) {
-		vq->split.avail_flags_shadow |= VRING_AVAIL_F_NO_INTERRUPT;
-		if (!vq->event)
-			vq->split.vring.avail->flags = cpu_to_virtio16(vdev,
-					vq->split.avail_flags_shadow);
-	}
 
 	err = __vring_alloc_state_extra_split(vring.num, &state, &extra);
 	if (err) {
@@ -2293,9 +2302,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	}
 
 	__vring_virtqueue_attach_split(vq, vring, state, extra);
-
-	/* Put everything in free lists. */
-	vq->free_head = 0;
+	__vring_virtqueue_init_split(vq, vdev);
 
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
