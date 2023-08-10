Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C8B4C04A94
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 12:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D229660FB5;
	Thu, 10 Aug 2023 12:31:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D229660FB5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iHqKjJz6sV-m; Thu, 10 Aug 2023 12:31:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5D7E260F30;
	Thu, 10 Aug 2023 12:31:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D7E260F30
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37152C0DD7;
	Thu, 10 Aug 2023 12:31:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23A99C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:31:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E6507416F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:31:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E6507416F1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jKw2B9yJMaCd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:31:17 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com
 (out30-99.freemail.mail.aliyun.com [115.124.30.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2C28C4172D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 12:31:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C28C4172D
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=15; SR=0;
 TI=SMTPD_---0VpTnUZO_1691670669; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VpTnUZO_1691670669) by smtp.aliyun-inc.com;
 Thu, 10 Aug 2023 20:31:10 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v13 09/12] virtio_ring: introduce virtqueue_reset()
Date: Thu, 10 Aug 2023 20:30:54 +0800
Message-Id: <20230810123057.43407-10-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 6ea114ee5d47
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

Introduce virtqueue_reset() to release all buffer inside vq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 23172d98e48e..639c20b19e06 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2812,6 +2812,39 @@ int virtqueue_set_dma_premapped(struct virtqueue *_vq)
 }
 EXPORT_SYMBOL_GPL(virtqueue_set_dma_premapped);
 
+/**
+ * virtqueue_reset - detach and recycle all unused buffers
+ * @_vq: the struct virtqueue we're talking about.
+ * @recycle: callback to recycle unused buffers
+ *
+ * Caller must ensure we don't call this with other virtqueue operations
+ * at the same time (except where noted).
+ *
+ * Returns zero or a negative error.
+ * 0: success.
+ * -EBUSY: Failed to sync with device, vq may not work properly
+ * -ENOENT: Transport or device not supported
+ * -EPERM: Operation not permitted
+ */
+int virtqueue_reset(struct virtqueue *_vq,
+		    void (*recycle)(struct virtqueue *vq, void *buf))
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	int err;
+
+	err = virtqueue_disable_and_recycle(_vq, recycle);
+	if (err)
+		return err;
+
+	if (vq->packed_ring)
+		virtqueue_reinit_packed(vq);
+	else
+		virtqueue_reinit_split(vq);
+
+	return virtqueue_enable_after_reset(_vq);
+}
+EXPORT_SYMBOL_GPL(virtqueue_reset);
+
 /* Only available for split ring */
 struct virtqueue *vring_new_virtqueue(unsigned int index,
 				      unsigned int num,
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index bd55a05eec04..49a640e0a6f4 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -99,6 +99,8 @@ dma_addr_t virtqueue_get_used_addr(const struct virtqueue *vq);
 
 int virtqueue_resize(struct virtqueue *vq, u32 num,
 		     void (*recycle)(struct virtqueue *vq, void *buf));
+int virtqueue_reset(struct virtqueue *vq,
+		    void (*recycle)(struct virtqueue *vq, void *buf));
 
 /**
  * struct virtio_device - representation of a device using virtio
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
