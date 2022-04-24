Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95616C433FE
	for <virtualization@archiver.kernel.org>; Sun, 24 Apr 2022 02:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E053416FC;
	Sun, 24 Apr 2022 02:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rsRapTLW2lpV; Sun, 24 Apr 2022 02:40:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 932EF410A6;
	Sun, 24 Apr 2022 02:40:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A4EEC0032;
	Sun, 24 Apr 2022 02:40:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BE4B1C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A6A3403AA
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id loM7JfyFanrP
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CD49B4016D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Apr 2022 02:40:53 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VAzcuZE_1650768050; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VAzcuZE_1650768050) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 24 Apr 2022 10:40:51 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [RFC PATCH 07/16] virtio_ring: split: resize support re-use buffers
Date: Sun, 24 Apr 2022 10:40:35 +0800
Message-Id: <20220424024044.94749-8-xuanzhuo@linux.alibaba.com>
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

Split vring resize supports reusing the original buffer.

The split vring resize function implemented earlier uses the method
of letting the upper layer recycle all the buffers. This commit will
first try to re-put it to the new vring in the order submitted to the
old vring. The remaining buffers that cannot be submitted to the new
vring will be called the recycle callback to release.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 02d4ffcc0a3b..fa4270e8c009 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1281,11 +1281,13 @@ static struct virtqueue *vring_create_virtqueue_split(
 	return vq;
 }
 
-static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
+static int virtqueue_resize_split(struct virtqueue *_vq, u32 num,
+				  void (*recycle)(struct virtqueue *vq, void *buf))
 {
+	struct vring_virtqueue_split vring = {}, vring_old = {};
 	struct vring_virtqueue *vq = to_vvq(_vq);
-	struct vring_virtqueue_split vring = {};
 	struct virtio_device *vdev = _vq->vdev;
+	void *buf;
 	int err;
 
 	err = vring_alloc_queue_split(&vring, vdev, num, vq->split.vring_align,
@@ -1299,15 +1301,26 @@ static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
 		goto err;
 	}
 
-	vring_free(&vq->vq);
+	virtqueue_vring_detach_split(vq, &vring_old);
 
 	virtqueue_init(vq, vring.vring.num);
 	virtqueue_vring_attach_split(vq, &vring);
 	virtqueue_vring_init_split(vq);
 
+	vring_reuse_bufs_split(vq, &vring_old, recycle);
+	vring_free_split(&vring_old, vdev);
+
 	return 0;
 
 err:
+	/*
+	 * In the case of failure to create vring, do not try to reuse the
+	 * original buffer. Because the probability of this situation is not
+	 * high, but we have to introduce new logic.
+	 */
+	while ((buf = virtqueue_detach_unused_buf(&vq->vq)))
+		recycle(&vq->vq, buf);
+
 	virtqueue_reinit_split(vq);
 	return -ENOMEM;
 }
@@ -2747,7 +2760,7 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
 	if (packed)
 		err = virtqueue_resize_packed(_vq, num);
 	else
-		err = virtqueue_resize_split(_vq, num);
+		err = virtqueue_resize_split(_vq, num, recycle);
 
 	if (vdev->config->enable_reset_vq(_vq))
 		return -EBUSY;
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
