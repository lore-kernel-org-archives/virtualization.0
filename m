Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0E9C433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 11:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 72779409CA;
	Thu, 24 Feb 2022 11:04:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZfV_LXCEK3u3; Thu, 24 Feb 2022 11:04:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BEF30409F2;
	Thu, 24 Feb 2022 11:04:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93778C0072;
	Thu, 24 Feb 2022 11:04:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 225DAC0079
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5AF284062A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id obFaLmUUO3hX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 519484051C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 11:04:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R601e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V5O.G4g_1645700650; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V5O.G4g_1645700650) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Feb 2022 19:04:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 7/9] virtio_ring: add api virtio_dma_map() for advance dma
Date: Thu, 24 Feb 2022 19:04:00 +0800
Message-Id: <20220224110402.108161-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
References: <20220224110402.108161-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d02e086a8668
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

Added virtio_dma_map() to map DMA addresses for virtual memory in
advance. The purpose of adding this function is to check
vring_use_dma_api() for virtio dma operation and get vdev->dev.parent as
the parameter of dma_map_page().

Added virtio_dma_unmap() for unmap DMA address.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 63 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  7 ++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c8d63cae8b33..6a1e0ef5498a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2508,4 +2508,67 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_vring);
 
+/**
+ * virtio_dma_map - get the DMA addr of the memory for virtio device
+ * @dev: virtio device
+ * @addr: the addr to DMA
+ * @length: memory length
+ * @dir: DMA direction
+ *
+ * Returns the DMA addr.
+ */
+dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
+			  enum dma_data_direction dir)
+{
+	struct virtio_device *vdev = dev_to_virtio(dev);
+	struct page *page;
+	size_t offset;
+
+	page = virt_to_page(addr);
+	offset = offset_in_page(addr);
+
+	if (!vring_use_dma_api(vdev))
+		return page_to_phys(page) + offset;
+
+	return dma_map_page(vdev->dev.parent, page, offset, length, dir);
+}
+EXPORT_SYMBOL_GPL(virtio_dma_map);
+
+/**
+ * virtio_dma_mapping_error - check dma address
+ * @dev: virtio device
+ * @addr: DMA address
+ *
+ * Returns 0 means dma valid. Other means invalid dma address.
+ */
+int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr)
+{
+	struct virtio_device *vdev = dev_to_virtio(dev);
+
+	if (!vring_use_dma_api(vdev))
+		return 0;
+
+	return dma_mapping_error(vdev->dev.parent, addr);
+}
+EXPORT_SYMBOL_GPL(virtio_dma_mapping_error);
+
+/**
+ * virtio_dma_unmap - unmap DMA addr
+ * @dev: virtio device
+ * @dma: DMA address
+ * @length: memory length
+ * @dir: DMA direction
+ */
+void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
+		      enum dma_data_direction dir)
+{
+	struct virtio_device *vdev = dev_to_virtio(dev);
+
+	if (!vring_use_dma_api(vdev))
+		return;
+
+	dma_unmap_page(vdev->dev.parent, dma, length, dir);
+}
+EXPORT_SYMBOL_GPL(virtio_dma_unmap);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 72292a62cd90..e86ea3b1a124 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
+#include <linux/dma-mapping.h>
 
 /**
  * virtqueue - a queue to register buffers for sending or receiving.
@@ -196,4 +197,10 @@ void unregister_virtio_driver(struct virtio_driver *drv);
 #define module_virtio_driver(__virtio_driver) \
 	module_driver(__virtio_driver, register_virtio_driver, \
 			unregister_virtio_driver)
+
+dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
+			  enum dma_data_direction dir);
+int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr);
+void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
+		      enum dma_data_direction dir);
 #endif /* _LINUX_VIRTIO_H */
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
