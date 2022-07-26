Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD43FCCA48E
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 07:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60C7A4221B;
	Tue, 26 Jul 2022 07:23:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60C7A4221B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lgm-aW9vlUa3; Tue, 26 Jul 2022 07:23:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7CD2541B9A;
	Tue, 26 Jul 2022 07:23:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7CD2541B9A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8905C007E;
	Tue, 26 Jul 2022 07:22:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1960BC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E69AB41BD3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E69AB41BD3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KuPUcWxbPr0F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A45F941BB7
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A45F941BB7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:55 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R481e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=37; SR=0; TI=SMTPD_---0VKUN6Ot_1658820164; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VKUN6Ot_1658820164) by smtp.aliyun-inc.com;
 Tue, 26 Jul 2022 15:22:46 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v13 10/42] virtio_ring: split: extract the logic of alloc queue
Date: Tue, 26 Jul 2022 15:21:53 +0800
Message-Id: <20220726072225.19884-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 19d2a6aae0b1
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
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

Separate the logic of split to create vring queue.

This feature is required for subsequent virtuqueue reset vring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 65 ++++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ba7cc560d823..3817520371ee 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -958,29 +958,19 @@ static void vring_free_split(struct vring_virtqueue_split *vring_split,
 	kfree(vring_split->desc_extra);
 }
 
-static struct virtqueue *vring_create_virtqueue_split(
-	unsigned int index,
-	unsigned int num,
-	unsigned int vring_align,
-	struct virtio_device *vdev,
-	bool weak_barriers,
-	bool may_reduce_num,
-	bool context,
-	bool (*notify)(struct virtqueue *),
-	void (*callback)(struct virtqueue *),
-	const char *name)
+static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_split,
+				   struct virtio_device *vdev,
+				   u32 num,
+				   unsigned int vring_align,
+				   bool may_reduce_num)
 {
-	struct vring_virtqueue_split vring_split = {};
-	struct virtqueue *vq;
 	void *queue = NULL;
 	dma_addr_t dma_addr;
-	size_t queue_size_in_bytes;
-	struct vring vring;
 
 	/* We assume num is a power of 2. */
 	if (num & (num - 1)) {
 		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
-		return NULL;
+		return -EINVAL;
 	}
 
 	/* TODO: allocate each queue chunk individually */
@@ -991,11 +981,11 @@ static struct virtqueue *vring_create_virtqueue_split(
 		if (queue)
 			break;
 		if (!may_reduce_num)
-			return NULL;
+			return -ENOMEM;
 	}
 
 	if (!num)
-		return NULL;
+		return -ENOMEM;
 
 	if (!queue) {
 		/* Try to get a single page. You are my only hope! */
@@ -1003,21 +993,46 @@ static struct virtqueue *vring_create_virtqueue_split(
 					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
 	}
 	if (!queue)
-		return NULL;
+		return -ENOMEM;
+
+	vring_init(&vring_split->vring, num, queue, vring_align);
 
-	queue_size_in_bytes = vring_size(num, vring_align);
-	vring_init(&vring_split.vring, num, queue, vring_align);
+	vring_split->queue_dma_addr = dma_addr;
+	vring_split->queue_size_in_bytes = vring_size(num, vring_align);
+
+	return 0;
+}
+
+static struct virtqueue *vring_create_virtqueue_split(
+	unsigned int index,
+	unsigned int num,
+	unsigned int vring_align,
+	struct virtio_device *vdev,
+	bool weak_barriers,
+	bool may_reduce_num,
+	bool context,
+	bool (*notify)(struct virtqueue *),
+	void (*callback)(struct virtqueue *),
+	const char *name)
+{
+	struct vring_virtqueue_split vring_split = {};
+	struct virtqueue *vq;
+	int err;
+
+	err = vring_alloc_queue_split(&vring_split, vdev, num, vring_align,
+				      may_reduce_num);
+	if (err)
+		return NULL;
 
 	vq = __vring_new_virtqueue(index, &vring_split, vdev, weak_barriers,
 				   context, notify, callback, name);
 	if (!vq) {
-		vring_free_queue(vdev, queue_size_in_bytes, queue,
-				 dma_addr);
+		vring_free_split(&vring_split, vdev);
 		return NULL;
 	}
 
-	to_vvq(vq)->split.queue_dma_addr = dma_addr;
-	to_vvq(vq)->split.queue_size_in_bytes = queue_size_in_bytes;
+	to_vvq(vq)->split.queue_dma_addr = vring_split.queue_dma_addr;
+	to_vvq(vq)->split.queue_size_in_bytes = vring_split.queue_size_in_bytes;
 	to_vvq(vq)->we_own_ring = true;
 
 	return vq;
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
