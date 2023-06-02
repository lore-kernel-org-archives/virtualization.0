Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FA1C7EE2C
	for <virtualization@archiver.kernel.org>; Fri,  2 Jun 2023 09:22:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9103C84366;
	Fri,  2 Jun 2023 09:22:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9103C84366
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id frYIy3G7kDwb; Fri,  2 Jun 2023 09:22:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EB6828437D;
	Fri,  2 Jun 2023 09:22:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EB6828437D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D572AC0037;
	Fri,  2 Jun 2023 09:22:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D9F0C0090
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 09:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 04658426DB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 09:22:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 04658426DB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Taz3jIBuW4Pb
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 09:22:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DBCCE426D2
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DBCCE426D2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jun 2023 09:22:15 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0Vk9OIfj_1685697728; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vk9OIfj_1685697728) by smtp.aliyun-inc.com;
 Fri, 02 Jun 2023 17:22:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v10 02/10] virtio_ring: introduce
 virtqueue_set_premapped()
Date: Fri,  2 Jun 2023 17:21:58 +0800
Message-Id: <20230602092206.50108-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
References: <20230602092206.50108-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 3bf1b1dbeb8a
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

This helper allows the driver change the dma mode to premapped mode.
Under the premapped mode, the virtio core do not do dma mapping
internally.

This just work when the use_dma_api is true. If the use_dma_api is false,
the dma options is not through the DMA APIs, that is not the standard
way of the linux kernel.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 40 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  2 ++
 2 files changed, 42 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 72ed07a604d4..2afdfb9e3e30 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -172,6 +172,9 @@ struct vring_virtqueue {
 	/* Host publishes avail event idx */
 	bool event;
 
+	/* Do DMA mapping by driver */
+	bool premapped;
+
 	/* Head of free buffer list. */
 	unsigned int free_head;
 	/* Number we've added since last sync. */
@@ -2059,6 +2062,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->packed_ring = true;
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
+	vq->premapped = false;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -2548,6 +2552,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 #endif
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
+	vq->premapped = false;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -2691,6 +2696,41 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 }
 EXPORT_SYMBOL_GPL(virtqueue_resize);
 
+/**
+ * virtqueue_set_premapped - set the vring premapped mode
+ * @_vq: the struct virtqueue we're talking about.
+ *
+ * Enable the premapped mode of the vq.
+ *
+ * The vring in premapped mode does not do dma internally, so the driver must
+ * do dma mapping in advance. The driver must pass the dma_address through
+ * dma_address of scatterlist. When the driver got a used buffer from
+ * the vring, it has to unmap the dma address. So the driver must call
+ * virtqueue_get_buf_premapped()/virtqueue_detach_unused_buf_premapped().
+ *
+ * This must be called before adding any buf to vring.
+ * So this should be called immediately after init vq or vq reset.
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error.
+ * 0: success.
+ * -EINVAL: vring does not use the dma api, so we can not enable premapped mode.
+ */
+int virtqueue_set_premapped(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (!vq->use_dma_api)
+		return -EINVAL;
+
+	vq->premapped = true;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtqueue_set_premapped);
+
 /* Only available for split ring */
 struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int num,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b93238db94e3..1fc0e1023bd4 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -78,6 +78,8 @@ bool virtqueue_enable_cb(struct virtqueue *vq);
 
 unsigned virtqueue_enable_cb_prepare(struct virtqueue *vq);
 
+int virtqueue_set_premapped(struct virtqueue *_vq);
+
 bool virtqueue_poll(struct virtqueue *vq, unsigned);
 
 bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
