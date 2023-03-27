Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73946C7619A
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 04:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 370B960F7B;
	Mon, 27 Mar 2023 04:05:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 370B960F7B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Izk8wPpVwdcr; Mon, 27 Mar 2023 04:05:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BFB9460F88;
	Mon, 27 Mar 2023 04:05:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BFB9460F88
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A6E2EC0091;
	Mon, 27 Mar 2023 04:05:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A139C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 04:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F73B60F66
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 04:05:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0F73B60F66
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bTgcQRSwu-N6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 04:05:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 499FF60F12
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 499FF60F12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 04:05:46 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0Vef5sw4_1679889942; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vef5sw4_1679889942) by smtp.aliyun-inc.com;
 Mon, 27 Mar 2023 12:05:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
Date: Mon, 27 Mar 2023 12:05:33 +0800
Message-Id: <20230327040536.48338-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 47bb36a6322f
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

Added virtqueue_dma_dev() to get DMA device for virtio. Then the
caller can do dma operation in advance. The purpose is to keep memory
mapped across multiple add/get buf operations.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio.c      |  6 ++++++
 drivers/virtio/virtio_ring.c | 17 +++++++++++++++++
 include/linux/virtio.h       |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 3893dc29eb26..11c5035369e2 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#include <linux/dma-mapping.h>
 #include <linux/virtio.h>
 #include <linux/spinlock.h>
 #include <linux/virtio_config.h>
@@ -243,6 +244,11 @@ static int virtio_dev_probe(struct device *_d)
 	u64 driver_features;
 	u64 driver_features_legacy;
 
+	_d->dma_mask = &_d->coherent_dma_mask;
+	err = dma_set_mask_and_coherent(_d, DMA_BIT_MASK(64));
+	if (err)
+		return err;
+
 	/* We have a driver! */
 	virtio_add_status(dev, VIRTIO_CONFIG_S_DRIVER);
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0b198ec3ff92..7b538c16c9b5 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2309,6 +2309,23 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
 
+/**
+ * virtqueue_dma_dev - get the dma dev
+ * @_vq: the struct virtqueue we're talking about.
+ *
+ * Returns the dma dev. That can been used for dma api.
+ */
+struct device *virtqueue_dma_dev(struct virtqueue *_vq)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+
+	if (vq->use_dma_api)
+		return vring_dma_dev(vq);
+	else
+		return &vq->vq.vdev->dev;
+}
+EXPORT_SYMBOL_GPL(virtqueue_dma_dev);
+
 /**
  * virtqueue_kick_prepare - first half of split virtqueue_kick call.
  * @_vq: the struct virtqueue
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 2b472514c49b..1fa50191cf0a 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -61,6 +61,8 @@ int virtqueue_add_sgs(struct virtqueue *vq,
 		      void *data,
 		      gfp_t gfp);
 
+struct device *virtqueue_dma_dev(struct virtqueue *vq);
+
 bool virtqueue_kick(struct virtqueue *vq);
 
 bool virtqueue_kick_prepare(struct virtqueue *vq);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
