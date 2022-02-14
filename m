Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9274EC43217
	for <virtualization@archiver.kernel.org>; Mon, 14 Feb 2022 08:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DEE360D57;
	Mon, 14 Feb 2022 08:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vMakpFmwPGB1; Mon, 14 Feb 2022 08:14:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B6C9260C0C;
	Mon, 14 Feb 2022 08:14:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E162C007B;
	Mon, 14 Feb 2022 08:14:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A018C0011
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E0A1040443
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lqq-SmbUZ7wR
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51A8F4026E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:34 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V4NbDOX_1644826465; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4NbDOX_1644826465) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Feb 2022 16:14:25 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 08/22] virtio_ring: queue_reset: add
 vring_release_virtqueue()
Date: Mon, 14 Feb 2022 16:14:02 +0800
Message-Id: <20220214081416.117695-9-xuanzhuo@linux.alibaba.com>
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

Added vring_release_virtqueue() to release the ring of the vq.

In this process, vq is removed from the vdev->vqs queue. And the memory
of the ring is released

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 18 +++++++++++++++++-
 include/linux/virtio.h       | 12 ++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c5dd17c7dd4a..b37753bdbbc4 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1730,6 +1730,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->vq.vdev = vdev;
 	vq->vq.num_free = num;
 	vq->vq.index = index;
+	vq->vq.reset = VIRTQUEUE_RESET_STAGE_NONE;
 	vq->we_own_ring = true;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
@@ -2218,6 +2219,7 @@ static int __vring_init_virtqueue(struct virtqueue *_vq,
 	vq->vq.vdev = vdev;
 	vq->vq.num_free = vring.num;
 	vq->vq.index = index;
+	vq->vq.reset = VIRTQUEUE_RESET_STAGE_NONE;
 	vq->we_own_ring = false;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
@@ -2397,11 +2399,25 @@ void vring_del_virtqueue(struct virtqueue *_vq)
 {
 	struct vring_virtqueue *vq = to_vvq(_vq);
 
-	__vring_del_virtqueue(vq);
+	if (_vq->reset != VIRTQUEUE_RESET_STAGE_RELEASE)
+		__vring_del_virtqueue(vq);
 	kfree(vq);
 }
 EXPORT_SYMBOL_GPL(vring_del_virtqueue);
 
+void vring_release_virtqueue(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (_vq->reset != VIRTQUEUE_RESET_STAGE_DEVICE)
+		return;
+
+	__vring_del_virtqueue(vq);
+
+	_vq->reset = VIRTQUEUE_RESET_STAGE_RELEASE;
+}
+EXPORT_SYMBOL_GPL(vring_release_virtqueue);
+
 /* Manipulates transport-specific feature bits. */
 void vring_transport_features(struct virtio_device *vdev)
 {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 72292a62cd90..cdb2a551257c 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -10,6 +10,12 @@
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
 
+enum virtqueue_reset_stage {
+	VIRTQUEUE_RESET_STAGE_NONE,
+	VIRTQUEUE_RESET_STAGE_DEVICE,
+	VIRTQUEUE_RESET_STAGE_RELEASE,
+};
+
 /**
  * virtqueue - a queue to register buffers for sending or receiving.
  * @list: the chain of virtqueues for this device
@@ -32,6 +38,7 @@ struct virtqueue {
 	unsigned int index;
 	unsigned int num_free;
 	void *priv;
+	enum virtqueue_reset_stage reset;
 };
 
 int virtqueue_add_outbuf(struct virtqueue *vq,
@@ -196,4 +203,9 @@ void unregister_virtio_driver(struct virtio_driver *drv);
 #define module_virtio_driver(__virtio_driver) \
 	module_driver(__virtio_driver, register_virtio_driver, \
 			unregister_virtio_driver)
+/*
+ * Resets a virtqueue. Just frees the ring, not free vq.
+ * This function must be called after reset_vq().
+ */
+void vring_release_virtqueue(struct virtqueue *vq);
 #endif /* _LINUX_VIRTIO_H */
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
