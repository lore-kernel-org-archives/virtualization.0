Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5786C001DE
	for <virtualization@archiver.kernel.org>; Mon, 10 Jul 2023 03:42:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4E66960D76;
	Mon, 10 Jul 2023 03:42:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4E66960D76
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q2wMeeySPfbn; Mon, 10 Jul 2023 03:42:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6FDB060DC6;
	Mon, 10 Jul 2023 03:42:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6FDB060DC6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55D04C0DDC;
	Mon, 10 Jul 2023 03:42:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D754DC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:42:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9C39A819F3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:42:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9C39A819F3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7P04VoL-rkGA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:42:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78905819BC
Received: from out30-124.freemail.mail.aliyun.com
 (out30-124.freemail.mail.aliyun.com [115.124.30.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78905819BC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jul 2023 03:42:54 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R981e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0VmxDgow_1688960568; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VmxDgow_1688960568) by smtp.aliyun-inc.com;
 Mon, 10 Jul 2023 11:42:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v11 08/10] virtio_ring: separate the logic of
 reset/enable from virtqueue_resize
Date: Mon, 10 Jul 2023 11:42:35 +0800
Message-Id: <20230710034237.12391-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 39991abed41c
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

The subsequent reset function will reuse these logic.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 58 ++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index dcbc8a5eaf16..bed0237402fa 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2152,6 +2152,43 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	return -ENOMEM;
 }
 
+static int virtqueue_disable_and_recycle(struct virtqueue *_vq,
+					 void (*recycle)(struct virtqueue *vq, void *buf))
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = vq->vq.vdev;
+	void *buf;
+	int err;
+
+	if (!vq->we_own_ring)
+		return -EPERM;
+
+	if (!vdev->config->disable_vq_and_reset)
+		return -ENOENT;
+
+	if (!vdev->config->enable_vq_after_reset)
+		return -ENOENT;
+
+	err = vdev->config->disable_vq_and_reset(_vq);
+	if (err)
+		return err;
+
+	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
+		recycle(_vq, buf);
+
+	return 0;
+}
+
+static int virtqueue_enable_after_reset(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = vq->vq.vdev;
+
+	if (vdev->config->enable_vq_after_reset(_vq))
+		return -EBUSY;
+
+	return 0;
+}
 
 /*
  * Generic functions and exported symbols.
@@ -2702,13 +2739,8 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 		     void (*recycle)(struct virtqueue *vq, void *buf))
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	struct virtio_device *vdev = vq->vq.vdev;
-	void *buf;
 	int err;
 
-	if (!vq->we_own_ring)
-		return -EPERM;
-
 	if (num > vq->vq.num_max)
 		return -E2BIG;
 
@@ -2718,28 +2750,16 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 	if ((vq->packed_ring ? vq->packed.vring.num : vq->split.vring.num) == num)
 		return 0;
 
-	if (!vdev->config->disable_vq_and_reset)
-		return -ENOENT;
-
-	if (!vdev->config->enable_vq_after_reset)
-		return -ENOENT;
-
-	err = vdev->config->disable_vq_and_reset(_vq);
+	err = virtqueue_disable_and_recycle(_vq, recycle);
 	if (err)
 		return err;
 
-	while ((buf = virtqueue_detach_unused_buf(_vq)) != NULL)
-		recycle(_vq, buf);
-
 	if (vq->packed_ring)
 		err = virtqueue_resize_packed(_vq, num);
 	else
 		err = virtqueue_resize_split(_vq, num);
 
-	if (vdev->config->enable_vq_after_reset(_vq))
-		return -EBUSY;
-
-	return err;
+	return virtqueue_enable_after_reset(_vq);
 }
 EXPORT_SYMBOL_GPL(virtqueue_resize);
 
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
