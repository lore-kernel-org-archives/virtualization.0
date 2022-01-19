Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4843EC43217
	for <virtualization@archiver.kernel.org>; Wed, 19 Jan 2022 02:35:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3555460E80;
	Wed, 19 Jan 2022 02:35:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K3wSKw5afYgp; Wed, 19 Jan 2022 02:35:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E131860E8A;
	Wed, 19 Jan 2022 02:35:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8B5FC007D;
	Wed, 19 Jan 2022 02:35:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1523BC002F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 02:35:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CFA1E410D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 02:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id P1h-ajqC_pWm
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 02:35:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 09F14409F3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 19 Jan 2022 02:35:50 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R621e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V2F5bCZ_1642559747; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2F5bCZ_1642559747) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 19 Jan 2022 10:35:48 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 6/6] virtio: queue_reset: add helper
Date: Wed, 19 Jan 2022 10:35:43 +0800
Message-Id: <20220119023543.91620-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220119023543.91620-1-xuanzhuo@linux.alibaba.com>
References: <20220119023543.91620-1-xuanzhuo@linux.alibaba.com>
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

Add helper for virtio queue reset.

* virtio_reset_vq: reset a queue individually
* virtio_del_resetq: del a reset queue
* virtio_enable_resetq: enable a reset queue

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_config.h | 57 +++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 6e94f7d0e153..ddc26a5e74fd 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -240,6 +240,63 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 				      desc);
 }
 
+/**
+ * virtio_reset_vq - reset a queue individually
+ * @vdev: the device
+ * @queue_index: the queue index
+ *
+ * returns 0 on success or error status
+ *
+ */
+static inline
+int virtio_reset_vq(struct virtio_device *vdev, u16 queue_index)
+{
+	if (!vdev->config->reset_vq)
+		return -ENOENT;
+
+	return vdev->config->reset_vq(vdev, queue_index);
+}
+
+/**
+ * virtio_del_resetq - del a reset queue
+ * @vdev: the device
+ * @queue_index: the queue index
+ *
+ * returns 0 on success or error status.
+ *
+ */
+static inline
+int virtio_del_resetq(struct virtio_device *vdev, u16 queue_index)
+{
+	if (!vdev->config->del_reset_vq)
+		return -ENOENT;
+
+	return vdev->config->del_reset_vq(vdev, queue_index);
+}
+
+/**
+ * virtio_enable_resetq - enable a reset queue
+ * @vdev: the device
+ * @queue_index: the queue index
+ * @callback: callback for the virtqueue, NULL for vq that do not need a callback
+ * @name: virtqueue names (mainly for debugging), NULL for vq unused by driver
+ * @ctx: ctx
+ *
+ * returns vq on success or error status
+ *
+ */
+static inline
+struct virtqueue *virtio_enable_resetq(struct virtio_device *vdev,
+				       u16 queue_index, vq_callback_t *callback,
+				       const char *name, const bool *ctx)
+{
+	if (!vdev->config->enable_reset_vq)
+		return ERR_PTR(-ENOENT);
+
+	return vdev->config->enable_reset_vq(vdev, queue_index, callback,
+					     name, ctx);
+}
+
 /**
  * virtio_device_ready - enable vq use in probe function
  * @vdev: the device
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
