Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49B7C43219
	for <virtualization@archiver.kernel.org>; Mon, 14 Feb 2022 08:14:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 513BC4032C;
	Mon, 14 Feb 2022 08:14:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VPAOkY4k_9n5; Mon, 14 Feb 2022 08:14:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EC005402FB;
	Mon, 14 Feb 2022 08:14:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B91A5C007A;
	Mon, 14 Feb 2022 08:14:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C320C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 63E0340370
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fMQT1fPLa_Lb
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BC02040222
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:32 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V4O5x7x_1644826459; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4O5x7x_1644826459) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Feb 2022 16:14:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 03/22] virtio_ring: queue_reset: add function
 vring_setup_virtqueue()
Date: Mon, 14 Feb 2022 16:13:57 +0800
Message-Id: <20220214081416.117695-4-xuanzhuo@linux.alibaba.com>
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

Added function vring_setup_virtqueue() to allow passing existing vq
without reallocating vq.

The purpose of adding this function is to not break the form of
vring_create_virtqueue().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c |  7 ++++---
 include/linux/virtio_ring.h  | 37 ++++++++++++++++++++++++++----------
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 962f1477b1fa..4f95d650b066 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2255,7 +2255,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 }
 EXPORT_SYMBOL_GPL(__vring_new_virtqueue);
 
-struct virtqueue *vring_create_virtqueue(
+struct virtqueue *vring_setup_virtqueue(
 	unsigned int index,
 	unsigned int num,
 	unsigned int vring_align,
@@ -2265,7 +2265,8 @@ struct virtqueue *vring_create_virtqueue(
 	bool context,
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
-	const char *name)
+	const char *name,
+	struct virtqueue *vq)
 {
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
@@ -2277,7 +2278,7 @@ struct virtqueue *vring_create_virtqueue(
 			vdev, weak_barriers, may_reduce_num,
 			context, notify, callback, name);
 }
-EXPORT_SYMBOL_GPL(vring_create_virtqueue);
+EXPORT_SYMBOL_GPL(vring_setup_virtqueue);
 
 /* Only available for split ring */
 struct virtqueue *vring_new_virtqueue(unsigned int index,
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index b485b13fa50b..e90323fce4bf 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -65,16 +65,33 @@ struct virtqueue;
  * expected.  The caller should query virtqueue_get_vring_size to learn
  * the actual size of the ring.
  */
-struct virtqueue *vring_create_virtqueue(unsigned int index,
-					 unsigned int num,
-					 unsigned int vring_align,
-					 struct virtio_device *vdev,
-					 bool weak_barriers,
-					 bool may_reduce_num,
-					 bool ctx,
-					 bool (*notify)(struct virtqueue *vq),
-					 void (*callback)(struct virtqueue *vq),
-					 const char *name);
+struct virtqueue *vring_setup_virtqueue(unsigned int index,
+					unsigned int num,
+					unsigned int vring_align,
+					struct virtio_device *vdev,
+					bool weak_barriers,
+					bool may_reduce_num,
+					bool ctx,
+					bool (*notify)(struct virtqueue *vq),
+					void (*callback)(struct virtqueue *vq),
+					const char *name,
+					struct virtqueue *vq);
+
+static inline struct virtqueue *vring_create_virtqueue(unsigned int index,
+						       unsigned int num,
+						       unsigned int vring_align,
+						       struct virtio_device *vdev,
+						       bool weak_barriers,
+						       bool may_reduce_num,
+						       bool ctx,
+						       bool (*notify)(struct virtqueue *vq),
+						       void (*callback)(struct virtqueue *vq),
+						       const char *name)
+{
+	return vring_setup_virtqueue(index, num, vring_align, vdev,
+				     weak_barriers, may_reduce_num, ctx,
+				     notify, callback, name, NULL);
+}
 
 /* Creates a virtqueue with a custom layout. */
 struct virtqueue *__vring_new_virtqueue(unsigned int index,
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
