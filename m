Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 990F2C7EE23
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 05:47:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 42CBB81638;
	Fri, 26 May 2023 05:47:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 42CBB81638
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=BmFD4aUJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id twYbKWT6lzwH; Fri, 26 May 2023 05:47:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A5B1181413;
	Fri, 26 May 2023 05:47:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A5B1181413
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8E041C0036;
	Fri, 26 May 2023 05:47:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B32F8C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 05:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8010781413
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 05:47:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8010781413
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s89AJmzh_edt
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 05:47:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AE626813F3
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AE626813F3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 05:47:04 +0000 (UTC)
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-64d5f65a2f7so408724b3a.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 22:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685080024; x=1687672024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9aKMfg1fHr2OSnJGRh9PC/RqpCNLsXjfCs8xZ/3DKhk=;
 b=BmFD4aUJPmEqKXrXWhOQ/s9gV3WbY9AQDVH4Z6IWJOiTooyBSk6OGmx//+EBiA1QjC
 7wempSXYAZanDs5r5PjpXnbwsBzGPE93m1xOOlVDG6dbWMO5IwrEvvSN91ktPkHCMwGW
 zIceiISirgOMXblsX2oRowb4Y++oO5yu43TMfDGEOxNGK8ay0cG5E+4j09gbYkIcM6jG
 nvdi0wRY9DmyhZCBNDeQelbgqAmrPQ9hPyIIOsliOLJG9PHWX5chz43zAFfG90efyVXT
 00aSq3u7F3c7cIOXk+oY/vLXKeCntIEV+jqhhDdpVUbBcKVRNkxn5ZW2EKIlDFXIVvvT
 qjNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685080024; x=1687672024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9aKMfg1fHr2OSnJGRh9PC/RqpCNLsXjfCs8xZ/3DKhk=;
 b=ij0AeYCydiu6+7Sd8SNr1nmf3rJRftIz48mSlPoYH0Hk0oHIenyN5xepJtgMzb9cQU
 pYND8QXSE3GRd277DKfqjEUlN1EE8PrzW3JU/i66VkSeINIdNIKNt7ABn0VNRwHpxbxH
 tMmfO+Hp2PsWAn6xwBPWfnah8MukfaoD3Gfv630sDLcXbB/rBQSNBa5UI0ox51A2wu4W
 MOiD1jsZzGKcPS47umUEhRLQ6b4Sp5gW+cATxUsr4c68sHc8pIlOilPXMuYMga3yOx6x
 yf6W5PuzrFIC4fdO4H3yw2EW12rVojIUpL565gj/9iFEOMqiW0F2Z85zmu1g9oTA9hVs
 eOFw==
X-Gm-Message-State: AC+VfDwNcH6ySSAA1gcj5g3cNrLEDT9mp8vyxUKxpnpMD0tl0qtQPp/z
 Bo3cumr37OOtHCGd8pD3OGc=
X-Google-Smtp-Source: ACHHUZ7nCPPQO2FAtG/9EEZJcOORV5prAxpUNUZpAJ9rRcv9tbqMF0YLxC5O2GvRX9b4AG5b877RTg==
X-Received: by 2002:a05:6a21:6709:b0:10a:a0e1:96fa with SMTP id
 wh9-20020a056a21670900b0010aa0e196famr837654pzb.22.1685080023982; 
 Thu, 25 May 2023 22:47:03 -0700 (PDT)
Received: from localhost.localdomain ([104.149.188.130])
 by smtp.gmail.com with ESMTPSA id
 b23-20020a6567d7000000b0050a0227a4bcsm1836485pgs.57.2023.05.25.22.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 22:47:02 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [PATCH net-next 4/5] virtio_ring: Introduce DMA pre-handler
Date: Fri, 26 May 2023 13:46:20 +0800
Message-Id: <20230526054621.18371-4-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230526054621.18371-1-liangchen.linux@gmail.com>
References: <20230526054621.18371-1-liangchen.linux@gmail.com>
MIME-Version: 1.0
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

Currently, DMA operations of virtio devices' data buffer are encapsulated
within the underlying virtqueue implementation. DMA map/unmap operations
are performed for each data buffer attached to/detached from the virtqueue,
which is transparent and invisible to the higher-level virtio device
drivers. This encapsulation makes it not viable for device drivers to
introduce certain mechanisms, such as page pool, that require explicit
management of DMA map/unmap. Therefore, by inserting a pre-handler before
the generic DMA map/unmap operations, virtio device drivers have the
opportunity to participate in DMA operations.

Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
---
 drivers/virtio/virtio_ring.c | 73 +++++++++++++++++++++++++++++++++---
 include/linux/virtio.h       | 18 +++++++++
 2 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c5310eaf8b46..a99641260555 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -213,6 +213,9 @@ struct vring_virtqueue {
 	bool last_add_time_valid;
 	ktime_t last_add_time;
 #endif
+
+	/* DMA mapping Pre-handler for virtio device driver */
+	struct virtqueue_pre_dma_ops *pre_dma_ops;
 };
 
 static struct virtqueue *__vring_new_virtqueue(unsigned int index,
@@ -369,6 +372,19 @@ static dma_addr_t vring_map_one_sg(const struct vring_virtqueue *vq,
 		return (dma_addr_t)sg_phys(sg);
 	}
 
+	/* Allow virtio drivers to perform customized mapping operation, and
+	 * fallback to the generic path if it fails to handle the mapping.
+	 */
+	if (vq->pre_dma_ops && vq->pre_dma_ops->map_page) {
+		dma_addr_t addr;
+
+		addr = vq->pre_dma_ops->map_page(vring_dma_dev(vq),
+				sg_page(sg), sg->offset, sg->length,
+				direction, 0);
+		if (addr)
+			return addr;
+	}
+
 	/*
 	 * We can't use dma_map_sg, because we don't use scatterlists in
 	 * the way it expects (we don't guarantee that the scatterlist
@@ -432,6 +448,15 @@ static void vring_unmap_one_split_indirect(const struct vring_virtqueue *vq,
 
 	flags = virtio16_to_cpu(vq->vq.vdev, desc->flags);
 
+	if (vq->pre_dma_ops && vq->pre_dma_ops->unmap_page) {
+		if (vq->pre_dma_ops->unmap_page(vring_dma_dev(vq),
+					virtio64_to_cpu(vq->vq.vdev, desc->addr),
+					virtio32_to_cpu(vq->vq.vdev, desc->len),
+					(flags & VRING_DESC_F_WRITE) ?
+					DMA_FROM_DEVICE : DMA_TO_DEVICE, 0))
+			return;
+	}
+
 	dma_unmap_page(vring_dma_dev(vq),
 		       virtio64_to_cpu(vq->vq.vdev, desc->addr),
 		       virtio32_to_cpu(vq->vq.vdev, desc->len),
@@ -456,14 +481,22 @@ static unsigned int vring_unmap_one_split(const struct vring_virtqueue *vq,
 				 extra[i].len,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
-	} else {
-		dma_unmap_page(vring_dma_dev(vq),
-			       extra[i].addr,
-			       extra[i].len,
-			       (flags & VRING_DESC_F_WRITE) ?
-			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+		goto out;
+	} else if (vq->pre_dma_ops && vq->pre_dma_ops->unmap_page) {
+		if (vq->pre_dma_ops->unmap_page(vring_dma_dev(vq),
+					extra[i].addr,
+					extra[i].len,
+					(flags & VRING_DESC_F_WRITE) ?
+					DMA_FROM_DEVICE : DMA_TO_DEVICE, 0))
+			goto out;
 	}
 
+	dma_unmap_page(vring_dma_dev(vq),
+			extra[i].addr,
+			extra[i].len,
+			(flags & VRING_DESC_F_WRITE) ?
+			DMA_FROM_DEVICE : DMA_TO_DEVICE);
+
 out:
 	return extra[i].next;
 }
@@ -1206,10 +1239,19 @@ static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
 				 (flags & VRING_DESC_F_WRITE) ?
 				 DMA_FROM_DEVICE : DMA_TO_DEVICE);
 	} else {
+		if (vq->pre_dma_ops && vq->pre_dma_ops->unmap_page) {
+			if (vq->pre_dma_ops->unmap_page(vring_dma_dev(vq),
+						extra->addr,
+						extra->len,
+						(flags & VRING_DESC_F_WRITE) ?
+						DMA_FROM_DEVICE : DMA_TO_DEVICE, 0))
+				return;
+		}
 		dma_unmap_page(vring_dma_dev(vq),
 			       extra->addr, extra->len,
 			       (flags & VRING_DESC_F_WRITE) ?
 			       DMA_FROM_DEVICE : DMA_TO_DEVICE);
+
 	}
 }
 
@@ -1223,6 +1265,15 @@ static void vring_unmap_desc_packed(const struct vring_virtqueue *vq,
 
 	flags = le16_to_cpu(desc->flags);
 
+	if (vq->pre_dma_ops && vq->pre_dma_ops->unmap_page) {
+		if (vq->pre_dma_ops->unmap_page(vring_dma_dev(vq),
+					le64_to_cpu(desc->addr),
+					le32_to_cpu(desc->len),
+					(flags & VRING_DESC_F_WRITE) ?
+					DMA_FROM_DEVICE : DMA_TO_DEVICE, 0))
+			return;
+	}
+
 	dma_unmap_page(vring_dma_dev(vq),
 		       le64_to_cpu(desc->addr),
 		       le32_to_cpu(desc->len),
@@ -2052,6 +2103,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->packed_ring = true;
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
+	vq->pre_dma_ops = NULL;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -2541,6 +2593,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 #endif
 	vq->dma_dev = dma_dev;
 	vq->use_dma_api = vring_use_dma_api(vdev);
+	vq->pre_dma_ops = NULL;
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -2945,4 +2998,12 @@ const struct vring *virtqueue_get_vring(const struct virtqueue *vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_get_vring);
 
+/* The virtio device driver can register its own DMA map/unmap pre-handler. */
+void virtqueue_register_pre_dma_ops(struct virtqueue *vq,
+		struct virtqueue_pre_dma_ops *pre_dma_ops)
+{
+	to_vvq(vq)->pre_dma_ops = pre_dma_ops;
+}
+EXPORT_SYMBOL_GPL(virtqueue_register_pre_dma_ops);
+
 MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index b93238db94e3..1d5755b5e03f 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
+#include <linux/dma-map-ops.h>
 
 /**
  * struct virtqueue - a queue to register buffers for sending or receiving.
@@ -203,4 +204,21 @@ void unregister_virtio_driver(struct virtio_driver *drv);
 #define module_virtio_driver(__virtio_driver) \
 	module_driver(__virtio_driver, register_virtio_driver, \
 			unregister_virtio_driver)
+/**
+ * struct virtqueue_pre_dma_ops - DMA pre-handler for virtio device driver
+ * @map_page: map a single page of memory for DMA
+ * @unmap_page: unmap a single page of memory for DMA
+ */
+struct virtqueue_pre_dma_ops {
+	dma_addr_t (*map_page)(struct device *dev, struct page *page,
+			unsigned long offset, size_t size,
+			enum dma_data_direction dir, unsigned long attrs);
+	bool (*unmap_page)(struct device *dev, dma_addr_t dma_handle,
+			size_t size, enum dma_data_direction dir,
+			unsigned long attrs);
+};
+
+void virtqueue_register_pre_dma_ops(struct virtqueue *vq,
+		struct virtqueue_pre_dma_ops *pre_dma_ops);
+
 #endif /* _LINUX_VIRTIO_H */
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
