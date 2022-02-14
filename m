Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE9AC4167D
	for <virtualization@archiver.kernel.org>; Mon, 14 Feb 2022 08:14:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4CD4540484;
	Mon, 14 Feb 2022 08:14:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9Gk0YXHfxAz6; Mon, 14 Feb 2022 08:14:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 943A7404B4;
	Mon, 14 Feb 2022 08:14:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2ACE7C007F;
	Mon, 14 Feb 2022 08:14:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59AD8C007A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1E408813DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iAy39H5ckU6H
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9F3EA81342
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:41 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V4OWZIc_1644826477; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4OWZIc_1644826477) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Feb 2022 16:14:38 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 19/22] virtio: add helper virtio_set_max_ring_num()
Date: Mon, 14 Feb 2022 16:14:13 +0800
Message-Id: <20220214081416.117695-20-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 24fd8391539b
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

Added helper virtio_set_max_ring_num() to set the upper limit of ring
num when creating a virtqueue.

Can be used to limit ring num before find_vqs() call. Or change ring num
when re-enable reset queue.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c  |  6 ++++++
 include/linux/virtio.h        |  1 +
 include/linux/virtio_config.h | 30 ++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1a123b5e5371..a77a82883e44 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -943,6 +943,9 @@ static struct virtqueue *vring_create_virtqueue_split(
 	size_t queue_size_in_bytes;
 	struct vring vring;
 
+	if (vdev->max_ring_num && num > vdev->max_ring_num)
+		num = vdev->max_ring_num;
+
 	/* We assume num is a power of 2. */
 	if (num & (num - 1)) {
 		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
@@ -1692,6 +1695,9 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
 	size_t ring_size_in_bytes, event_size_in_bytes;
 
+	if (vdev->max_ring_num && num > vdev->max_ring_num)
+		num = vdev->max_ring_num;
+
 	ring_size_in_bytes = num * sizeof(struct vring_packed_desc);
 
 	ring = vring_alloc_queue(vdev, ring_size_in_bytes,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 1153b093c53d..45525beb2ec4 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -127,6 +127,7 @@ struct virtio_device {
 	struct list_head vqs;
 	u64 features;
 	void *priv;
+	u16 max_ring_num;
 };
 
 static inline struct virtio_device *dev_to_virtio(struct device *_dev)
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index cd7f7f44ce38..d7cb2d0341ee 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -200,6 +200,36 @@ static inline bool virtio_has_dma_quirk(const struct virtio_device *vdev)
 	return !virtio_has_feature(vdev, VIRTIO_F_ACCESS_PLATFORM);
 }
 
+/**
+ * virtio_set_max_ring_num - set max ring num
+ * @vdev: the device
+ * @num: max ring num. Zero clear the limit.
+ *
+ * When creating a virtqueue, use this value as the upper limit of ring num.
+ *
+ * Returns 0 on success or error status
+ */
+static inline
+int virtio_set_max_ring_num(struct virtio_device *vdev, u16 num)
+{
+	if (!num) {
+		vdev->max_ring_num = num;
+		return 0;
+	}
+
+	if (!virtio_has_feature(vdev, VIRTIO_F_RING_PACKED)) {
+		if (!is_power_of_2(num)) {
+			num = __rounddown_pow_of_two(num);
+
+			if (!num)
+				return -EINVAL;
+		}
+	}
+
+	vdev->max_ring_num = num;
+	return 0;
+}
+
 static inline
 struct virtqueue *virtio_find_single_vq(struct virtio_device *vdev,
 					vq_callback_t *c, const char *n)
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
