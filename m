Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AA3C433FE
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 02:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A5DD94091E;
	Sun, 24 Apr 2022 02:41:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MNCk2ctsxwic; Sun, 24 Apr 2022 02:41:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3B09340A5D;
	Sun, 24 Apr 2022 02:41:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14B31C007F;
	Sun, 24 Apr 2022 02:41:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C79F1C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B2D5A409EE
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GPpzDXCyczh9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:41:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B0EA4057A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:41:01 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R531e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VAzpPKB_1650768057; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAzpPKB_1650768057) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 24 Apr 2022 10:40:58 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 15/16] virtio_ring: packed: resize support re-use buffers
Date: Sun, 24 Apr 2022 10:40:43 +0800
Message-Id: <20220424024044.94749-16-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
References: <20220424024044.94749-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: c42022d07dde
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

Packed vring resize supports reusing the original buffer.

The packed vring resize function implemented earlier uses the method
of letting the upper layer recycle all the buffers. This commit will
first try to re-put it to the new vring in the order submitted to the
old vring. The remaining buffers that cannot be submitted to the new
vring will be called the recycle callback to release.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 66f71e22ece0..730c8dded4c7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -217,7 +217,6 @@ struct vring_virtqueue {
 };
 
 static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
-static void vring_free(struct virtqueue *_vq);
 
 /*
  * Helpers.
@@ -2357,11 +2356,13 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	return NULL;
 }
 
-static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
+static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num,
+				   void (*recycle)(struct virtqueue *vq, void *buf))
 {
-	struct vring_virtqueue_packed vring = {};
+	struct vring_virtqueue_packed vring = {}, vring_old = {};
 	struct vring_virtqueue *vq = to_vvq(_vq);
 	struct virtio_device *vdev = _vq->vdev;
+	void *buf;
 	int err;
 
 	if (vring_alloc_queue_packed(&vring, vdev, num))
@@ -2371,17 +2372,28 @@ static int virtqueue_resize_packed(struct virtqueue *_vq, u32 num)
 	if (err)
 		goto err_state_extra;
 
-	vring_free(&vq->vq);
+	vring_virtqueue_detach_packed(vq, &vring_old);
 
 	virtqueue_init(vq, vring.vring.num);
 	virtqueue_vring_attach_packed(vq, &vring);
 	virtqueue_vring_init_packed(vq);
 
+	vring_reuse_bufs_packed(vq, &vring_old, recycle);
+	vring_free_packed(&vring_old, vdev);
+
 	return 0;
 
 err_state_extra:
 	vring_free_packed(&vring, vdev);
 err_ring:
+	/*
+	 * In the case of failure to create vring, do not try to reuse the
+	 * original buffer. Because the probability of this situation is not
+	 * high, but we have to introduce new logic.
+	 */
+	while ((buf = virtqueue_detach_unused_buf(&vq->vq)))
+		recycle(&vq->vq, buf);
+
 	virtqueue_reinit_packed(vq);
 	return -ENOMEM;
 }
@@ -2914,7 +2926,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 		recycle(_vq, buf);
 
 	if (packed)
-		err = virtqueue_resize_packed(_vq, num);
+		err = virtqueue_resize_packed(_vq, num, recycle);
 	else
 		err = virtqueue_resize_split(_vq, num, recycle);
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
