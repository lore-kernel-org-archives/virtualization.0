Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA100C28CF5
	for <virtualization@archiver.kernel.org>; Wed, 26 Jan 2022 07:35:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7249A415EF;
	Wed, 26 Jan 2022 07:35:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H7pE-fWx9c09; Wed, 26 Jan 2022 07:35:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3E678415E9;
	Wed, 26 Jan 2022 07:35:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A67CC007C;
	Wed, 26 Jan 2022 07:35:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5590EC0031
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1DC8C4049A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WqWHXaxLPZ5H
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D0AB940629
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:40 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V2uc6jX_1643182536; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2uc6jX_1643182536) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 26 Jan 2022 15:35:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 03/17] virtio: queue_reset: struct virtio_config_ops add
 callbacks for queue_reset
Date: Wed, 26 Jan 2022 15:35:19 +0800
Message-Id: <20220126073533.44994-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
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

Performing reset on a queue is divided into two steps:

1. reset_vq: reset one vq
2. enable_reset_vq: re-enable the reset queue

In the first step, these tasks will be completed:
    1. notify the hardware queue to reset
    2. recycle the buffer from vq
    3. release the ring of the vq

The second step is similar to find vqs, passing parameters callback and
name, etc. Based on the original vq, the ring is re-allocated and
configured to the backend.

So add two callbacks reset_vq, enable_reset_vq to struct
virtio_config_ops.

Add a structure for passing parameters. This will facilitate subsequent
expansion of the parameters of enable reset vq.
There is currently only one default extended parameter ring_num.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_config.h | 43 ++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 4d107ad31149..51dd8461d1b6 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -16,6 +16,44 @@ struct virtio_shm_region {
 	u64 len;
 };
 
+typedef void vq_callback_t(struct virtqueue *);
+
+/* virtio_reset_vq: specify parameters for queue_reset
+ *
+ *	vdev: the device
+ *	queue_index: the queue index
+ *
+ *	free_unused_cb: callback to free unused bufs
+ *	data: used by free_unused_cb
+ *
+ *	callback: callback for the virtqueue, NULL for vq that do not need a
+ *	          callback
+ *	name: virtqueue names (mainly for debugging), NULL for vq unused by
+ *	      driver
+ *	ctx: ctx
+ *
+ *	ring_num: specify ring num for the vq to be re-enabled. 0 means use the
+ *	          default value. MUST be a power of 2.
+ */
+struct virtio_reset_vq;
+typedef void vq_reset_callback_t(struct virtio_reset_vq *param, void *buf);
+struct virtio_reset_vq {
+	struct virtio_device *vdev;
+	u16 queue_index;
+
+	/* reset vq param */
+	vq_reset_callback_t *free_unused_cb;
+	void *data;
+
+	/* enable reset vq param */
+	vq_callback_t *callback;
+	const char *name;
+	const bool *ctx;
+
+	/* ext enable reset vq param */
+	u16 ring_num;
+};
+
 /**
  * virtio_config_ops - operations for configuring a virtio device
  * Note: Do not assume that a transport implements all of the operations
@@ -74,8 +112,9 @@ struct virtio_shm_region {
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
  * @get_shm_region: get a shared memory region based on the index.
+ * @reset_vq: reset a queue individually
+ * @enable_reset_vq: enable a reset queue
  */
-typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
 	void (*enable_cbs)(struct virtio_device *vdev);
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -100,6 +139,8 @@ struct virtio_config_ops {
 			int index);
 	bool (*get_shm_region)(struct virtio_device *vdev,
 			       struct virtio_shm_region *region, u8 id);
+	int (*reset_vq)(struct virtio_reset_vq *param);
+	struct virtqueue *(*enable_reset_vq)(struct virtio_reset_vq *param);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
