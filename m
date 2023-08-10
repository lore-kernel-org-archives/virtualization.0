Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FA8C04FDF
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 12:31:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 14E2141761;
	Thu, 10 Aug 2023 12:31:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 14E2141761
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AgzwIoS8ZKQP; Thu, 10 Aug 2023 12:31:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A671A4172D;
	Thu, 10 Aug 2023 12:31:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A671A4172D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A0C8C0072;
	Thu, 10 Aug 2023 12:31:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83F71C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FD7A41742
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:31:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FD7A41742
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mAsEq1xStJA8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:31:19 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3A1B241753
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:31:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3A1B241753
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R421e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0VpTrCYt_1691670672; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VpTrCYt_1691670672) by smtp.aliyun-inc.com;
 Thu, 10 Aug 2023 20:31:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v13 11/12] virtio_ring: introduce dma sync api for
 virtqueue
Date: Thu, 10 Aug 2023 20:30:56 +0800
Message-Id: <20230810123057.43407-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 6ea114ee5d47
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

These API has been introduced:

* virtqueue_dma_need_sync
* virtqueue_dma_sync_single_range_for_cpu
* virtqueue_dma_sync_single_range_for_device

These APIs can be used together with the premapped mechanism to sync the
DMA address.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 76 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  8 ++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 916479c9c72c..81ecb29c88f1 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3175,4 +3175,80 @@ int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
 }
 EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
 
+/**
+ * virtqueue_dma_need_sync - check a dma address needs sync
+ * @_vq: the struct virtqueue we're talking about.
+ * @addr: DMA address
+ *
+ * Check if the dma address mapped by the virtqueue_dma_map_* APIs needs to be
+ * synchronized
+ *
+ * return bool
+ */
+bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (!vq->use_dma_api)
+		return false;
+
+	return dma_need_sync(vring_dma_dev(vq), addr);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_need_sync);
+
+/**
+ * virtqueue_dma_sync_single_range_for_cpu - dma sync for cpu
+ * @_vq: the struct virtqueue we're talking about.
+ * @addr: DMA address
+ * @offset: DMA address offset
+ * @size: buf size for sync
+ * @dir: DMA direction
+ *
+ * Before calling this function, use virtqueue_dma_need_sync() to confirm that
+ * the DMA address really needs to be synchronized
+ *
+ */
+void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq,
+					     dma_addr_t addr,
+					     unsigned long offset, size_t size,
+					     enum dma_data_direction dir)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct device *dev = vring_dma_dev(vq);
+
+	if (!vq->use_dma_api)
+		return;
+
+	dma_sync_single_range_for_cpu(dev, addr, offset, size,
+				      DMA_BIDIRECTIONAL);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_cpu);
+
+/**
+ * virtqueue_dma_sync_single_range_for_device - dma sync for device
+ * @_vq: the struct virtqueue we're talking about.
+ * @addr: DMA address
+ * @offset: DMA address offset
+ * @size: buf size for sync
+ * @dir: DMA direction
+ *
+ * Before calling this function, use virtqueue_dma_need_sync() to confirm that
+ * the DMA address really needs to be synchronized
+ */
+void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq,
+						dma_addr_t addr,
+						unsigned long offset, size_t size,
+						enum dma_data_direction dir)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct device *dev = vring_dma_dev(vq);
+
+	if (!vq->use_dma_api)
+		return;
+
+	dma_sync_single_range_for_device(dev, addr, offset, size,
+					 DMA_BIDIRECTIONAL);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_sync_single_range_for_device);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 79e3c74391e0..1311a7fbe675 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -220,4 +220,12 @@ void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
 				      size_t size, enum dma_data_direction dir,
 				      unsigned long attrs);
 int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
+
+bool virtqueue_dma_need_sync(struct virtqueue *_vq, dma_addr_t addr);
+void virtqueue_dma_sync_single_range_for_cpu(struct virtqueue *_vq, dma_addr_t addr,
+					     unsigned long offset, size_t size,
+					     enum dma_data_direction dir);
+void virtqueue_dma_sync_single_range_for_device(struct virtqueue *_vq, dma_addr_t addr,
+						unsigned long offset, size_t size,
+						enum dma_data_direction dir);
 #endif /* _LINUX_VIRTIO_H */
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
