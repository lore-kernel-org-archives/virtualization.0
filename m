Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF64C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 12:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3E3182A2D;
	Wed,  9 Feb 2022 12:29:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OGgWAjYibmBy; Wed,  9 Feb 2022 12:29:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 796D882AAA;
	Wed,  9 Feb 2022 12:29:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51643C0011;
	Wed,  9 Feb 2022 12:29:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E2F24C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C44D460F38
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LghkccdlcO0n
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A918060B58
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:07 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V4.Hs8d_1644409744; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4.Hs8d_1644409744) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 20:29:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/14] virtio_ring: queue_reset: add function
 vring_setup_virtqueue()
Date: Wed,  9 Feb 2022 20:28:50 +0800
Message-Id: <20220209122901.51790-4-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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
index 028b05d44546..766f4fd8cf06 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2253,7 +2253,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 }
 EXPORT_SYMBOL_GPL(__vring_new_virtqueue);
 
-struct virtqueue *vring_create_virtqueue(
+struct virtqueue *vring_setup_virtqueue(
 	unsigned int index,
 	unsigned int num,
 	unsigned int vring_align,
@@ -2263,7 +2263,8 @@ struct virtqueue *vring_create_virtqueue(
 	bool context,
 	bool (*notify)(struct virtqueue *),
 	void (*callback)(struct virtqueue *),
-	const char *name)
+	const char *name,
+	struct virtqueue *vq)
 {
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
@@ -2275,7 +2276,7 @@ struct virtqueue *vring_create_virtqueue(
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
