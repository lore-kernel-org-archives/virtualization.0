Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC67C433F5
	for <virtualization@archiver.kernel.org>; Thu, 20 Jan 2022 06:43:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F12A982AC3;
	Thu, 20 Jan 2022 06:43:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PcFRpnDLO46F; Thu, 20 Jan 2022 06:43:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9D46782B21;
	Thu, 20 Jan 2022 06:43:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03B6BC007B;
	Thu, 20 Jan 2022 06:43:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75E9BC0080
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 55D9182A0E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WNjcX7mENXYV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58BA98276B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:17 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R291e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V2LASB-_1642660992; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2LASB-_1642660992) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 20 Jan 2022 14:43:13 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 08/12] virtio: queue_reset: add helper
Date: Thu, 20 Jan 2022 14:42:59 +0800
Message-Id: <20220120064303.106639-9-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220120064303.106639-1-xuanzhuo@linux.alibaba.com>
References: <20220120064303.106639-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
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

Add helper for virtio queue reset.

* virtio_reset_vq: reset a queue individually
* virtio_enable_resetq: enable a reset queue

In the virtio_reset_vq(), these tasks will be completed:
   1. notify the hardware queue to reset
   2. recycle the buffer from vq
   3. delete the vq

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_config.h | 43 +++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index e50a377c27a0..f84347f4e4ee 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -239,6 +239,49 @@ int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
 				      desc);
 }
 
+/**
+ * virtio_reset_vq - reset a queue individually
+ * @vdev: the device
+ * @queue_index: the queue index
+ * @callback: callback to free unused bufs
+ * @data: pass to callback
+ *
+ * returns 0 on success or error status
+ *
+ */
+static inline
+int virtio_reset_vq(struct virtio_device *vdev, u16 queue_index,
+		    vq_reset_callback_t *callback, void *data)
+{
+	if (!vdev->config->reset_vq)
+		return -ENOENT;
+
+	return vdev->config->reset_vq(vdev, queue_index, callback, data);
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
