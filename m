Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C7AC05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 11:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9697940C61;
	Thu,  2 Feb 2023 11:01:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9697940C61
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AIOpJYDJlfQ8; Thu,  2 Feb 2023 11:01:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0C92640C37;
	Thu,  2 Feb 2023 11:01:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0C92640C37
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A560C007D;
	Thu,  2 Feb 2023 11:01:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 05731C002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C688940C37
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C688940C37
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Gz_UxuE9glG6
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C10040C61
Received: from out30-118.freemail.mail.aliyun.com
 (out30-118.freemail.mail.aliyun.com [115.124.30.118])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1C10040C61
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 11:01:19 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R291e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=21; SR=0;
 TI=SMTPD_---0VaktKMa_1675335668; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VaktKMa_1675335668) by smtp.aliyun-inc.com;
 Thu, 02 Feb 2023 19:01:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: netdev@vger.kernel.org
Subject: [PATCH 08/33] virtio_ring: introduce dma sync api for virtio
Date: Thu,  2 Feb 2023 19:00:33 +0800
Message-Id: <20230202110058.130695-9-xuanzhuo@linux.alibaba.com>
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

In the process of dma sync, we involved whether virtio uses dma api. On
the other hand, it is also necessary to read vdev->dev.parent. So these
API has been introduced.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 61 ++++++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  8 +++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 67eda7bc23ea..7b393133fd27 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -3102,4 +3102,65 @@ void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
 }
 EXPORT_SYMBOL_GPL(virtio_dma_unmap);
 
+/**
+ * virtio_dma_need_sync - check dma address need sync
+ * @dev: virtio device
+ * @addr: DMA address
+ */
+bool virtio_dma_need_sync(struct device *dev, dma_addr_t addr)
+{
+	struct virtio_device *vdev = dev_to_virtio(dev);
+
+	if (!vring_use_dma_api(vdev))
+		return 0;
+
+	return dma_need_sync(vdev->dev.parent, addr);
+}
+EXPORT_SYMBOL_GPL(virtio_dma_need_sync);
+
+/**
+ * virtio_dma_sync_signle_range_for_cpu - dma sync for cpu
+ * @dev: virtio device
+ * @addr: DMA address
+ * @offset: DMA address offset
+ * @size: mem size for sync
+ * @dir: DMA direction
+ *
+ * Before calling this function, use virtio_dma_need_sync() to confirm that the
+ * DMA address really needs to be synchronized
+ */
+void virtio_dma_sync_signle_range_for_cpu(struct device *dev, dma_addr_t addr,
+					  unsigned long offset, size_t size,
+					  enum dma_data_direction dir)
+{
+	struct virtio_device *vdev = dev_to_virtio(dev);
+
+	dma_sync_single_range_for_cpu(vdev->dev.parent, addr, offset,
+				      size, DMA_BIDIRECTIONAL);
+}
+EXPORT_SYMBOL_GPL(virtio_dma_sync_signle_range_for_cpu);
+
+/**
+ * virtio_dma_sync_signle_range_for_device - dma sync for device
+ * @dev: virtio device
+ * @addr: DMA address
+ * @offset: DMA address offset
+ * @size: mem size for sync
+ * @dir: DMA direction
+ *
+ * Before calling this function, use virtio_dma_need_sync() to confirm that the
+ * DMA address really needs to be synchronized
+ */
+void virtio_dma_sync_signle_range_for_device(struct device *dev,
+					     dma_addr_t addr,
+					     unsigned long offset, size_t size,
+					     enum dma_data_direction dir)
+{
+	struct virtio_device *vdev = dev_to_virtio(dev);
+
+	dma_sync_single_range_for_device(vdev->dev.parent, addr, offset,
+					 size, DMA_BIDIRECTIONAL);
+}
+EXPORT_SYMBOL_GPL(virtio_dma_sync_signle_range_for_device);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index ce89126becc5..8c2fae318b0c 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -227,4 +227,12 @@ dma_addr_t virtio_dma_map(struct device *dev, void *addr, unsigned int length,
 int virtio_dma_mapping_error(struct device *dev, dma_addr_t addr);
 void virtio_dma_unmap(struct device *dev, dma_addr_t dma, unsigned int length,
 		      enum dma_data_direction dir);
+bool virtio_dma_need_sync(struct device *dev, dma_addr_t addr);
+void virtio_dma_sync_signle_range_for_cpu(struct device *dev, dma_addr_t addr,
+					  unsigned long offset, size_t size,
+					  enum dma_data_direction dir);
+void virtio_dma_sync_signle_range_for_device(struct device *dev,
+					     dma_addr_t addr,
+					     unsigned long offset, size_t size,
+					     enum dma_data_direction dir);
 #endif /* _LINUX_VIRTIO_H */
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
