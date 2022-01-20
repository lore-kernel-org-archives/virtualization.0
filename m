Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72C3C4332F
	for <virtualization@archiver.kernel.org>; Thu, 20 Jan 2022 06:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 50B3D81B23;
	Thu, 20 Jan 2022 06:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5NA6ZST9xVYU; Thu, 20 Jan 2022 06:43:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E3AFE82882;
	Thu, 20 Jan 2022 06:43:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D099BC007F;
	Thu, 20 Jan 2022 06:43:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58A31C0039
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 39AD781B01
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sHY5iv3pwpYg
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 655B8828DD
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:12 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V2KlUbq_1642660987; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2KlUbq_1642660987) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 20 Jan 2022 14:43:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 03/12] virtio: queue_reset: struct virtio_config_ops add
 callbacks for queue_reset
Date: Thu, 20 Jan 2022 14:42:54 +0800
Message-Id: <20220120064303.106639-4-xuanzhuo@linux.alibaba.com>
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

Performing reset on a queue is divided into two steps:

1. reset_vq: reset one vq
2. enable_reset_vq: re-enable the reset queue

In the first step, these tasks will be completed:
    1. notify the hardware queue to reset
    2. recycle the buffer from vq
    3. delete the vq

So add two callbacks reset_vq, enable_reset_vq to struct
virtio_config_ops. The parameters of enable_reset_vq are similar to
those of find_vqs.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_config.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 4d107ad31149..e50a377c27a0 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -74,8 +74,22 @@ struct virtio_shm_region {
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
  * @get_shm_region: get a shared memory region based on the index.
+ * @reset_vq: reset a queue individually
+ *	vdev: the device
+ *	queue_index: the queue index
+ *	callback: callback to free unused bufs
+ *	data: pass to callback
+ *	returns 0 on success or error status
+ * @enable_reset_vq: enable a reset queue
+ *	vdev: the device
+ *	queue_index: the queue index
+ *	callback: callback for the virtqueue, NULL for vq that do not need a callback
+ *	name: virtqueue names (mainly for debugging), NULL for vq unused by driver
+ *	ctx: ctx
+ *	returns vq on success or error status
  */
 typedef void vq_callback_t(struct virtqueue *);
+typedef void vq_reset_callback_t(struct virtio_device *vdev, void *buf, void *data);
 struct virtio_config_ops {
 	void (*enable_cbs)(struct virtio_device *vdev);
 	void (*get)(struct virtio_device *vdev, unsigned offset,
@@ -100,6 +114,12 @@ struct virtio_config_ops {
 			int index);
 	bool (*get_shm_region)(struct virtio_device *vdev,
 			       struct virtio_shm_region *region, u8 id);
+	int (*reset_vq)(struct virtio_device *vdev, u16 queue_index,
+			vq_reset_callback_t *callback, void *data);
+	struct virtqueue *(*enable_reset_vq)(struct virtio_device *vdev,
+					     u16 queue_index,
+					     vq_callback_t *callback,
+					     const char *name, const bool *ctx);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
