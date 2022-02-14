Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69774C433EF
	for <virtualization@archiver.kernel.org>; Mon, 14 Feb 2022 08:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1CB384048D;
	Mon, 14 Feb 2022 08:14:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eckPmY9zO0jT; Mon, 14 Feb 2022 08:14:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4C166404D0;
	Mon, 14 Feb 2022 08:14:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17113C0011;
	Mon, 14 Feb 2022 08:14:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87923C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8311D8149D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lYRtOAR0oNiy
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 924CC813DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:47 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V4OcHDr_1644826462; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4OcHDr_1644826462) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Feb 2022 16:14:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 06/22] virtio_ring: queue_reset: packed: support enable
 reset queue
Date: Mon, 14 Feb 2022 16:14:00 +0800
Message-Id: <20220214081416.117695-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 24fd8391539b
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
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

The purpose of this patch is to make vring packed support re-enable reset
vq.

Based on whether the incoming vq passed by vring_setup_virtqueue() is
NULL or not, distinguish whether it is a normal create virtqueue or
re-enable a reset queue.

When re-enable a reset queue, reuse the original callback, name, indirect.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4639e1643c78..20659f7ca582 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1683,7 +1683,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	bool context,
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
-	const char *name)
+	const char *name,
+	struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq;
 	struct vring_packed_desc *ring;
@@ -1713,13 +1714,20 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (!device)
 		goto err_device;
 
-	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
-	if (!vq)
-		goto err_vq;
+	if (_vq) {
+		vq = to_vvq(_vq);
+	} else {
+		vq = kmalloc(sizeof(*vq), GFP_KERNEL);
+		if (!vq)
+			goto err_vq;
+
+		vq->vq.callback = callback;
+		vq->vq.name = name;
+		vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
+			!context;
+	}
 
-	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
-	vq->vq.name = name;
 	vq->vq.num_free = num;
 	vq->vq.index = index;
 	vq->we_own_ring = true;
@@ -1736,8 +1744,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->last_add_time_valid = false;
 #endif
 
-	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
-		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
@@ -1778,7 +1784,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 		goto err_desc_extra;
 
 	/* No callback?  Tell other side not to bother us. */
-	if (!callback) {
+	if (!vq->vq.callback) {
 		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
 		vq->packed.vring.driver->flags =
 			cpu_to_le16(vq->packed.event_flags_shadow);
@@ -1792,7 +1798,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
 err_desc_extra:
 	kfree(vq->packed.desc_state);
 err_desc_state:
-	kfree(vq);
+	if (!_vq)
+		kfree(vq);
 err_vq:
 	vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
 err_device:
@@ -2317,7 +2324,7 @@ struct virtqueue *vring_setup_virtqueue(
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return vring_create_virtqueue_packed(index, num, vring_align,
 				vdev, weak_barriers, may_reduce_num,
-				context, notify, callback, name);
+				context, notify, callback, name, vq);
 
 	return vring_create_virtqueue_split(index, num, vring_align,
 			vdev, weak_barriers, may_reduce_num,
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
