Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A1FC43219
	for <virtualization@archiver.kernel.org>; Mon, 14 Feb 2022 08:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42014402BE;
	Mon, 14 Feb 2022 08:14:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id egjQAq7anl5H; Mon, 14 Feb 2022 08:14:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E6124400C8;
	Mon, 14 Feb 2022 08:14:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2EBAC0011;
	Mon, 14 Feb 2022 08:14:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A83DFC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2EBA40370
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WND9NBNw866c
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F1C084019E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:30 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R431e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V4OcHDO_1644826460; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4OcHDO_1644826460) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Feb 2022 16:14:21 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 04/22] virtio_ring: queue_reset: split: add
 __vring_init_virtqueue()
Date: Mon, 14 Feb 2022 16:13:58 +0800
Message-Id: <20220214081416.117695-5-xuanzhuo@linux.alibaba.com>
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

Extract vq's initialization function __vring_init_virtqueue() from
__vring_new_virtqueue()

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 61 +++++++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4f95d650b066..9cfbe45ab286 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2169,23 +2169,17 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 EXPORT_SYMBOL_GPL(vring_interrupt);
 
 /* Only available for split ring */
-struct virtqueue *__vring_new_virtqueue(unsigned int index,
-					struct vring vring,
-					struct virtio_device *vdev,
-					bool weak_barriers,
-					bool context,
-					bool (*notify)(struct virtqueue *),
-					void (*callback)(struct virtqueue *),
-					const char *name)
+static int __vring_init_virtqueue(struct virtqueue *_vq,
+				  unsigned int index,
+				  struct vring vring,
+				  struct virtio_device *vdev,
+				  bool weak_barriers,
+				  bool context,
+				  bool (*notify)(struct virtqueue *),
+				  void (*callback)(struct virtqueue *),
+				  const char *name)
 {
-	struct vring_virtqueue *vq;
-
-	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
-		return NULL;
-
-	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
-	if (!vq)
-		return NULL;
+	struct vring_virtqueue *vq = to_vvq(_vq);
 
 	vq->packed_ring = false;
 	vq->vq.callback = callback;
@@ -2245,13 +2239,42 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
 	spin_unlock(&vdev->vqs_list_lock);
-	return &vq->vq;
+	return 0;
 
 err_extra:
 	kfree(vq->split.desc_state);
 err_state:
-	kfree(vq);
-	return NULL;
+	return -ENOMEM;
+}
+
+struct virtqueue *__vring_new_virtqueue(unsigned int index,
+					struct vring vring,
+					struct virtio_device *vdev,
+					bool weak_barriers,
+					bool context,
+					bool (*notify)(struct virtqueue *),
+					void (*callback)(struct virtqueue *),
+					const char *name)
+{
+	struct vring_virtqueue *vq;
+	int err;
+
+	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
+		return NULL;
+
+	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
+	if (!vq)
+		return NULL;
+
+	err = __vring_init_virtqueue(&vq->vq, index, vring, vdev, weak_barriers,
+				     context, notify, callback, name);
+
+	if (err) {
+		kfree(vq);
+		return NULL;
+	}
+
+	return &vq->vq;
 }
 EXPORT_SYMBOL_GPL(__vring_new_virtqueue);
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
