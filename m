Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D274BC433FE
	for <virtualization@archiver.kernel.org>; Mon, 14 Mar 2022 09:35:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8884F40608;
	Mon, 14 Mar 2022 09:35:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gEd9WjF_XY3v; Mon, 14 Mar 2022 09:35:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1C22B4060E;
	Mon, 14 Mar 2022 09:35:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9121C0085;
	Mon, 14 Mar 2022 09:35:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7E5FC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8BF1837C9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Wm-jtkDDZT9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com
 [47.90.199.9])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7CBD483E14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Mar 2022 09:35:09 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R551e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V77y4J9_1647250504; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V77y4J9_1647250504) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Mar 2022 17:35:04 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v8 10/16] virtio_ring: split: implement
 virtqueue_resize_split()
Date: Mon, 14 Mar 2022 17:34:49 +0800
Message-Id: <20220314093455.34707-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: d6feaa0fb7e7
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

virtio ring split supports resize.

Only after the new vring is successfully allocated based on the new num,
we will release the old vring. In any case, an error is returned,
indicating that the vring still points to the old vring. In the case of
an error, we will re-initialize the state of the vring to ensure that
the vring can be used.

In addition, vring_align, may_reduce_num are necessary for reallocating
vring, so they are retained for creating vq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 62 ++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 81bbfd65411e..a15869514146 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -139,6 +139,12 @@ struct vring_virtqueue {
 			/* DMA address and size information */
 			dma_addr_t queue_dma_addr;
 			size_t queue_size_in_bytes;
+
+			/* The parameters for creating vrings are reserved for
+			 * creating new vrings when enabling reset queue.
+			 */
+			u32 vring_align;
+			bool may_reduce_num;
 		} split;
 
 		/* Available for packed ring */
@@ -198,6 +204,16 @@ struct vring_virtqueue {
 #endif
 };
 
+static void __vring_free(struct virtqueue *_vq);
+static void __vring_virtqueue_init_split(struct vring_virtqueue *vq,
+					 struct virtio_device *vdev);
+static void __vring_virtqueue_attach_split(struct vring_virtqueue *vq,
+					   struct vring vring,
+					   struct vring_desc_state_split *desc_state,
+					   struct vring_desc_extra *desc_extra);
+static int __vring_alloc_state_extra_split(u32 num,
+					   struct vring_desc_state_split **desc_state,
+					   struct vring_desc_extra **desc_extra);
 
 /*
  * Helpers.
@@ -991,6 +1007,8 @@ static struct virtqueue *vring_create_virtqueue_split(
 		return NULL;
 	}
 
+	to_vvq(vq)->split.vring_align = vring_align;
+	to_vvq(vq)->split.may_reduce_num = may_reduce_num;
 	to_vvq(vq)->split.queue_dma_addr = dma_addr;
 	to_vvq(vq)->split.queue_size_in_bytes = queue_size_in_bytes;
 	to_vvq(vq)->we_own_ring = true;
@@ -998,6 +1016,50 @@ static struct virtqueue *vring_create_virtqueue_split(
 	return vq;
 }
 
+static int virtqueue_resize_split(struct virtqueue *_vq, u32 num)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = _vq->vdev;
+	struct vring_desc_state_split *state;
+	struct vring_desc_extra *extra;
+	size_t queue_size_in_bytes;
+	dma_addr_t dma_addr;
+	struct vring vring;
+	int err = -ENOMEM;
+	void *queue;
+
+	BUG_ON(!vq->we_own_ring);
+
+	queue = vring_alloc_queue_split(vdev, &dma_addr, &num,
+					vq->split.vring_align,
+					vq->weak_barriers,
+					vq->split.may_reduce_num);
+	if (!queue)
+		goto init;
+
+	queue_size_in_bytes = vring_size(num, vq->split.vring_align);
+
+	err = __vring_alloc_state_extra_split(num, &state, &extra);
+	if (err) {
+		vring_free_queue(vdev, queue_size_in_bytes, queue, dma_addr);
+		goto init;
+	}
+
+	__vring_free(&vq->vq);
+
+	vring_init(&vring, num, queue, vq->split.vring_align);
+	__vring_virtqueue_attach_split(vq, vring, state, extra);
+	vq->split.queue_dma_addr = dma_addr;
+	vq->split.queue_size_in_bytes = queue_size_in_bytes;
+
+	err = 0;
+
+init:
+	__vring_virtqueue_init_split(vq, vdev);
+	vq->we_own_ring = true;
+	return err;
+}
+
 
 /*
  * Packed ring specific functions - *_packed().
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
