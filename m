Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0D5AC433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 12:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3B3BA40919;
	Tue,  8 Mar 2022 12:35:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9fvhGO7Gbjq1; Tue,  8 Mar 2022 12:35:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 575B140AAD;
	Tue,  8 Mar 2022 12:35:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFFA3C0083;
	Tue,  8 Mar 2022 12:35:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49521C001D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AD3E760F3E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id iMAaDbzxr3fN
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8442360F4C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:33 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R891e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=34; SR=0; TI=SMTPD_---0V6eQtXl_1646742927; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6eQtXl_1646742927) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Mar 2022 20:35:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v7 04/26] virtio_ring: split: extract the logic of creating
 vring
Date: Tue,  8 Mar 2022 20:34:56 +0800
Message-Id: <20220308123518.33800-5-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: f06b131dbfed
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

For the convenience of passing parameters, add a structure
vring_split.

This feature is required for subsequent virtuqueue reset vring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 74 +++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 23 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index b87130c8f312..d32793615451 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -85,6 +85,13 @@ struct vring_desc_extra {
 	u16 next;			/* The next desc state in a list. */
 };
 
+struct vring_split {
+	void *queue;
+	dma_addr_t dma_addr;
+	size_t queue_size_in_bytes;
+	struct vring vring;
+};
+
 struct vring_virtqueue {
 	struct virtqueue vq;
 
@@ -915,28 +922,21 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 	return NULL;
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
+static int vring_create_vring_split(struct vring_split *vring,
+				    struct virtio_device *vdev,
+				    unsigned int vring_align,
+				    bool weak_barriers,
+				    bool may_reduce_num,
+				    u32 num)
 {
-	struct virtqueue *vq;
 	void *queue = NULL;
 	dma_addr_t dma_addr;
 	size_t queue_size_in_bytes;
-	struct vring vring;
 
 	/* We assume num is a power of 2. */
 	if (num & (num - 1)) {
 		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);
-		return NULL;
+		return -EINVAL;
 	}
 
 	/* TODO: allocate each queue chunk individually */
@@ -947,11 +947,11 @@ static struct virtqueue *vring_create_virtqueue_split(
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
@@ -959,21 +959,49 @@ static struct virtqueue *vring_create_virtqueue_split(
 					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
 	}
 	if (!queue)
-		return NULL;
+		return -ENOMEM;
 
 	queue_size_in_bytes = vring_size(num, vring_align);
-	vring_init(&vring, num, queue, vring_align);
+	vring_init(&vring->vring, num, queue, vring_align);
+
+	vring->dma_addr = dma_addr;
+	vring->queue = queue;
+	vring->queue_size_in_bytes = queue_size_in_bytes;
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
+	struct vring_split vring;
+	struct virtqueue *vq;
+	int err;
+
+	err = vring_create_vring_split(&vring, vdev, vring_align, weak_barriers,
+				       may_reduce_num, num);
+	if (err)
+		return NULL;
 
-	vq = __vring_new_virtqueue(index, vring, vdev, weak_barriers, context,
+	vq = __vring_new_virtqueue(index, vring.vring, vdev, weak_barriers, context,
 				   notify, callback, name);
 	if (!vq) {
-		vring_free_queue(vdev, queue_size_in_bytes, queue,
-				 dma_addr);
+		vring_free_queue(vdev, vring.queue_size_in_bytes, vring.queue,
+				 vring.dma_addr);
 		return NULL;
 	}
 
-	to_vvq(vq)->split.queue_dma_addr = dma_addr;
-	to_vvq(vq)->split.queue_size_in_bytes = queue_size_in_bytes;
+	to_vvq(vq)->split.queue_dma_addr = vring.dma_addr;
+	to_vvq(vq)->split.queue_size_in_bytes = vring.queue_size_in_bytes;
 	to_vvq(vq)->we_own_ring = true;
 
 	return vq;
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
