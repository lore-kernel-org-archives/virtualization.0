Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0489C433EF
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 09:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A198C83E42;
	Mon, 14 Mar 2022 09:35:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fQlFrrYt0xtb; Mon, 14 Mar 2022 09:35:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 475AE833D3;
	Mon, 14 Mar 2022 09:35:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88D2CC0085;
	Mon, 14 Mar 2022 09:35:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84263C0089
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 760F041570
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rtQT6aPOfcxi
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60AB441561
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:11 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V7877qV_1647250506; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V7877qV_1647250506) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Mar 2022 17:35:06 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v8 12/16] virtio_ring: packed: extract the logic of alloc
 state and extra
Date: Mon, 14 Mar 2022 17:34:51 +0800
Message-Id: <20220314093455.34707-13-xuanzhuo@linux.alibaba.com>
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

Separate the logic for alloc desc_state and desc_extra, which will
be called separately by subsequent patches.

Use struct vring_packed to pass desc_state, desc_extra.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 50 ++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 96ff2dabda14..980bd77d8243 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -95,6 +95,9 @@ struct vring_packed {
 	dma_addr_t device_event_dma_addr;
 	size_t ring_size_in_bytes;
 	size_t event_size_in_bytes;
+
+	struct vring_desc_state_packed *desc_state;
+	struct vring_desc_extra *desc_extra;
 };
 
 struct vring_virtqueue {
@@ -1825,6 +1828,32 @@ static int vring_alloc_queue_packed(struct vring_packed *vring,
 	return -ENOMEM;
 }
 
+static int vring_alloc_state_extra_packed(u32 num, struct vring_packed *vring)
+{
+	struct vring_desc_state_packed *state;
+	struct vring_desc_extra *extra;
+
+	state = kmalloc_array(num, sizeof(struct vring_desc_state_packed), GFP_KERNEL);
+	if (!state)
+		goto err_desc_state;
+
+	memset(state, 0, num * sizeof(struct vring_desc_state_packed));
+
+	extra = vring_alloc_desc_extra(num);
+	if (!extra)
+		goto err_desc_extra;
+
+	vring->desc_state = state;
+	vring->desc_extra = extra;
+
+	return 0;
+
+err_desc_extra:
+	kfree(state);
+err_desc_state:
+	return -ENOMEM;
+}
+
 static struct virtqueue *vring_create_virtqueue_packed(
 	unsigned int index,
 	unsigned int num,
@@ -1839,6 +1868,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 {
 	struct vring_virtqueue *vq;
 	struct vring_packed vring;
+	int err;
 
 	if (vring_alloc_queue_packed(&vring, vdev, num))
 		goto err_vq;
@@ -1891,22 +1921,16 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->packed.event_flags_shadow = 0;
 	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
 
-	vq->packed.desc_state = kmalloc_array(num,
-			sizeof(struct vring_desc_state_packed),
-			GFP_KERNEL);
-	if (!vq->packed.desc_state)
-		goto err_desc_state;
+	err = vring_alloc_state_extra_packed(num, &vring);
+	if (err)
+		goto err_state_extra;
 
-	memset(vq->packed.desc_state, 0,
-		num * sizeof(struct vring_desc_state_packed));
+	vq->packed.desc_state = vring.desc_state;
+	vq->packed.desc_extra = vring.desc_extra;
 
 	/* Put everything in free lists. */
 	vq->free_head = 0;
 
-	vq->packed.desc_extra = vring_alloc_desc_extra(num);
-	if (!vq->packed.desc_extra)
-		goto err_desc_extra;
-
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback) {
 		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
@@ -1919,9 +1943,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	spin_unlock(&vdev->vqs_list_lock);
 	return &vq->vq;
 
-err_desc_extra:
-	kfree(vq->packed.desc_state);
-err_desc_state:
+err_state_extra:
 	kfree(vq);
 err_vq:
 	vring_free_vring_packed(&vring, vdev);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
