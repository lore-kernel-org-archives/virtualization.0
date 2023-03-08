Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572F2C76186
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 06:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EEF0F81E55;
	Wed,  8 Mar 2023 06:45:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEF0F81E55
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B7LJuvbboRQD; Wed,  8 Mar 2023 06:45:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 65F2381E80;
	Wed,  8 Mar 2023 06:45:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 65F2381E80
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94E28C0095;
	Wed,  8 Mar 2023 06:45:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39326C008D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CEB2F81E7A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEB2F81E7A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HpFdYwNsyRNt
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79D8B81E6E
Received: from out30-119.freemail.mail.aliyun.com
 (out30-119.freemail.mail.aliyun.com [115.124.30.119])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 79D8B81E6E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:44:57 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VdOPH0v_1678257890; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VdOPH0v_1678257890) by smtp.aliyun-inc.com;
 Wed, 08 Mar 2023 14:44:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v2 09/12] virtio_ring: introduce virtqueue_dma_dev()
Date: Wed,  8 Mar 2023 14:44:40 +0800
Message-Id: <20230308064443.50639-10-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
References: <20230308064443.50639-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: a39da90ba7d5
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
index 216ac8654982..f63637c288a0 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2297,6 +2297,23 @@ int virtqueue_add_inbuf_ctx(struct virtqueue *vq,
 }
 EXPORT_SYMBOL_GPL(virtqueue_add_inbuf_ctx);
 
+/**
+ * virtqueue_dma_dev - get the dma dev
+ * @vq: the struct virtqueue we're talking about.
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
