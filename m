Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FB2C001DB
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 12:31:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B3D941B81;
	Thu, 10 Aug 2023 12:31:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B3D941B81
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5O0RtInsD-PN; Thu, 10 Aug 2023 12:31:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 72D1E41B5E;
	Thu, 10 Aug 2023 12:31:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72D1E41B5E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9AC5C0DD3;
	Thu, 10 Aug 2023 12:31:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8650C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:31:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CDD583F5D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:31:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8CDD583F5D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IWXsgVRBQ6pM
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:31:19 +0000 (UTC)
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3079883F48
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:31:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3079883F48
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0VpTnUa2_1691670671; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VpTnUa2_1691670671) by smtp.aliyun-inc.com;
 Thu, 10 Aug 2023 20:31:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v13 10/12] virtio_ring: introduce dma map api for
 virtqueue
Date: Thu, 10 Aug 2023 20:30:55 +0800
Message-Id: <20230810123057.43407-11-xuanzhuo@linux.alibaba.com>
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

Added virtqueue_dma_map_api* to map DMA addresses for virtual memory in
advance. The purpose is to keep memory mapped across multiple add/get
buf operations.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 69 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  8 +++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 639c20b19e06..916479c9c72c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3106,4 +3106,73 @@ const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_vring);
 
+/**
+ * virtqueue_dma_map_single_attrs - map DMA for _vq
+ * @_vq: the struct virtqueue we're talking about.
+ * @ptr: the pointer of the buffer to do dma
+ * @size: the size of the buffer to do dma
+ * @dir: DMA direction
+ * @attrs: DMA Attrs
+ *
+ * The caller calls this to do dma mapping in advance. The DMA address can be
+ * passed to this _vq when it is in pre-mapped mode.
+ *
+ * return DMA address. Caller should check that by virtqueue_dma_mapping_error().
+ */
+dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr,
+					  size_t size,
+					  enum dma_data_direction dir,
+					  unsigned long attrs)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (!vq->use_dma_api)
+		return (dma_addr_t)virt_to_phys(ptr);
+
+	return dma_map_single_attrs(vring_dma_dev(vq), ptr, size, dir, attrs);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_map_single_attrs);
+
+/**
+ * virtqueue_dma_unmap_single_attrs - unmap DMA for _vq
+ * @_vq: the struct virtqueue we're talking about.
+ * @addr: the dma address to unmap
+ * @size: the size of the buffer
+ * @dir: DMA direction
+ * @attrs: DMA Attrs
+ *
+ * Unmap the address that is mapped by the virtqueue_dma_map_* APIs.
+ *
+ */
+void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
+				      size_t size, enum dma_data_direction dir,
+				      unsigned long attrs)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (!vq->use_dma_api)
+		return;
+
+	dma_unmap_single_attrs(vring_dma_dev(vq), addr, size, dir, attrs);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_unmap_single_attrs);
+
+/**
+ * virtqueue_dma_mapping_error - check dma address
+ * @_vq: the struct virtqueue we're talking about.
+ * @addr: DMA address
+ *
+ * Returns 0 means dma valid. Other means invalid dma address.
+ */
+int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (!vq->use_dma_api)
+		return 0;
+
+	return dma_mapping_error(vring_dma_dev(vq), addr);
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_mapping_error);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 49a640e0a6f4..79e3c74391e0 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
+#include <linux/dma-mapping.h>
 
 /**
  * struct virtqueue - a queue to register buffers for sending or receiving.
@@ -212,4 +213,11 @@ void unregister_virtio_driver(struct virtio_driver *drv);
 #define module_virtio_driver(__virtio_driver) \
 	module_driver(__virtio_driver, register_virtio_driver, \
 			unregister_virtio_driver)
+
+dma_addr_t virtqueue_dma_map_single_attrs(struct virtqueue *_vq, void *ptr, size_t size,
+					  enum dma_data_direction dir, unsigned long attrs);
+void virtqueue_dma_unmap_single_attrs(struct virtqueue *_vq, dma_addr_t addr,
+				      size_t size, enum dma_data_direction dir,
+				      unsigned long attrs);
+int virtqueue_dma_mapping_error(struct virtqueue *_vq, dma_addr_t addr);
 #endif /* _LINUX_VIRTIO_H */
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
