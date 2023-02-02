Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3034C636D3
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:01:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5854440C0F;
	Thu,  2 Feb 2023 11:01:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5854440C0F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ThhrMu9_Zk-I; Thu,  2 Feb 2023 11:01:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9F10B40C37;
	Thu,  2 Feb 2023 11:01:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9F10B40C37
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85ECFC0082;
	Thu,  2 Feb 2023 11:01:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BD9C1C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9930E41B88
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9930E41B88
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GJiDL49KAV-x
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11D3941B60
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11D3941B60
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:16 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VakkM26_1675335667; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VakkM26_1675335667) by smtp.aliyun-inc.com;
 Thu, 02 Feb 2023 19:01:08 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 07/33] virtio_ring: add api virtio_dma_map() for advance dma
Date: Thu,  2 Feb 2023 19:00:32 +0800
Message-Id: <20230202110058.130695-8-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d7589ab6ea10
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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
 drivers/virtio/virtio_ring.c | 80 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  9 ++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 7dfce7001f9f..67eda7bc23ea 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3022,4 +3022,84 @@ const struct vring *virtqueue_get_vring(struct virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_vring);
 
+/**
+ * virtio_dma_map_page - get the DMA addr of the memory for virtio device
+ * @dev: virtio device
+ * @page: the page of the memory to DMA
+ * @offset: the offset of the memory inside page
+ * @length: memory length
+ * @dir: DMA direction
+ *
+ * Returns the DMA addr. DMA_MAPPING_ERROR means error.
+ */
+dma_addr_t virtio_dma_map_page(struct device *dev, struct page *page, size_t offset,
+			       unsigned int length, enum dma_data_direction dir)
+{
+	struct virtio_device *vdev = dev_to_virtio(dev);
+
+	if (!vring_use_dma_api(vdev))
+		return page_to_phys(page) + offset;
+
+	return dma_map_page(vdev->dev.parent, page, offset, length, dir);
+}
+
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
+	struct page *page;
+	size_t offset;
+
+	page = virt_to_page(addr);
+	offset = offset_in_page(addr);
+
+	return virtio_dma_map_page(dev, page, offset, length, dir);
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
index 3ca2edb1aef3..ce89126becc5 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
+#include <linux/dma-mapping.h>
 
 /**
  * struct virtqueue - a queue to register buffers for sending or receiving.
@@ -218,4 +219,12 @@ void unregister_virtio_driver(struct virtio_driver *drv);
 #define module_virtio_driver(__virtio_driver) \
 	module_driver(__virtio_driver, register_virtio_driver, \
 			unregister_virtio_driver)
+
+dma_addr_t virtio_dma_map_page(struct device *dev, struct page *page, size_t offset,
+			       unsigned int length, enum dma_data_direction dir);
+dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
+			  enum dma_data_direction dir);
+int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr);
+void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
+		      enum dma_data_direction dir);
 #endif /* _LINUX_VIRTIO_H */
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
