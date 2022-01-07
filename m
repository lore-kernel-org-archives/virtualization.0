Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BCCC43217
	for <virtualization@archiver.kernel.org>; Fri,  7 Jan 2022 06:33:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E07196FC78;
	Fri,  7 Jan 2022 06:33:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xnD5EhbmCJ6o; Fri,  7 Jan 2022 06:33:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 504716FC7F;
	Fri,  7 Jan 2022 06:33:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08262C0076;
	Fri,  7 Jan 2022 06:33:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D3612C0030
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A8C086FC7B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dSgIhLEioymG
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C5AA26FC77
 for <virtualization@lists.linux-foundation.org>;
 Fri,  7 Jan 2022 06:33:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V19hjzR_1641537191; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V19hjzR_1641537191) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 07 Jan 2022 14:33:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 6/6] virtio: add api virtio_dma_map() for advance dma
Date: Fri,  7 Jan 2022 14:33:06 +0800
Message-Id: <20220107063306.23240-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
References: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
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

Added virtio_dma_map() to map DMA addresses for virtual memory in
advance. The purpose of adding this function is to check
vring_use_dma_api() for virtio dma operation and get vdev->dev.parent as
the parameter of dma_map_page().

Added virtio_dma_unmap() for unmap DMA address.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 47 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  9 +++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index e165bc2e1344..f4a0fb85df27 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2472,4 +2472,51 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_vring);
 
+/**
+ * virtio_dma_map - get the DMA addr of the memory for virtio device
+ * @vdev: virtio device
+ * @page: the page of the memory to DMA
+ * @offset: the offset of the memory inside page
+ * @length: memory length
+ * @dir: DMA direction
+ *
+ * Returns the DMA addr. Zero means error.
+ */
+dma_addr_t virtio_dma_map(struct virtio_device *vdev,
+			  struct page *page, size_t offset,
+			  unsigned int length,
+			  enum dma_data_direction dir)
+{
+	dma_addr_t addr;
+
+	if (!vring_use_dma_api(vdev))
+		return page_to_phys(page) + offset;
+
+	addr = dma_map_page(vdev->dev.parent, page, offset, length, dir);
+
+	if (dma_mapping_error(vdev->dev.parent, addr))
+		return 0;
+
+	return addr;
+}
+EXPORT_SYMBOL_GPL(virtio_dma_map);
+
+/**
+ * virtio_dma_unmap - unmap DMA addr
+ * @vdev: virtio device
+ * @dma: DMA address
+ * @length: memory length
+ * @dir: DMA direction
+ */
+void virtio_dma_unmap(struct virtio_device *vdev,
+		      dma_addr_t dma, unsigned int length,
+		      enum dma_data_direction dir)
+{
+	if (!vring_use_dma_api(vdev))
+		return;
+
+	dma_unmap_page(vdev->dev.parent, dma, length, dir);
+}
+EXPORT_SYMBOL_GPL(virtio_dma_unmap);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 41edbc01ffa4..6e6c6e18ecf8 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
+#include <linux/dma-mapping.h>
 
 /**
  * virtqueue - a queue to register buffers for sending or receiving.
@@ -195,4 +196,12 @@ void unregister_virtio_driver(struct virtio_driver *drv);
 #define module_virtio_driver(__virtio_driver) \
 	module_driver(__virtio_driver, register_virtio_driver, \
 			unregister_virtio_driver)
+
+dma_addr_t virtio_dma_map(struct virtio_device *vdev,
+			  struct page *page, size_t offset,
+			  unsigned int length,
+			  enum dma_data_direction dir);
+void virtio_dma_unmap(struct virtio_device *vdev,
+		      dma_addr_t dma, unsigned int length,
+		      enum dma_data_direction dir);
 #endif /* _LINUX_VIRTIO_H */
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
