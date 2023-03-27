Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43065C76195
	for <virtualization@archiver.kernel.org>; Mon, 27 Mar 2023 04:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4139360F8C;
	Mon, 27 Mar 2023 04:05:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4139360F8C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4MeHHHqgCRh9; Mon, 27 Mar 2023 04:05:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id A318B60FA0;
	Mon, 27 Mar 2023 04:05:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A318B60FA0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 935F0C0097;
	Mon, 27 Mar 2023 04:05:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 602A2C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 04:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3C2C081E67
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 04:05:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3C2C081E67
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0hi0rv-OSBEB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 04:05:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1530B81E85
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1530B81E85
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Mar 2023 04:05:49 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0Vef7-MF_1679889945; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vef7-MF_1679889945) by smtp.aliyun-inc.com;
 Mon, 27 Mar 2023 12:05:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v6 11/11] virtio_ring: introduce virtqueue_reset()
Date: Mon, 27 Mar 2023 12:05:36 +0800
Message-Id: <20230327040536.48338-12-xuanzhuo@linux.alibaba.com>
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

Introduce virtqueue_reset() to release all buffer inside vq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 33 +++++++++++++++++++++++++++++++++
 include/linux/virtio.h       |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 6b5d29fbb83d..e4cffd63fd06 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2799,6 +2799,39 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 }
 EXPORT_SYMBOL_GPL(virtqueue_resize);
 
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
index 1fa50191cf0a..22bbd06ef8c8 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -97,6 +97,8 @@ dma_addr_t virtqueue_get_used_addr(struct virtqueue *vq);
 
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
