Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A85C433EF
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 03:44:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BD9B81A30;
	Wed,  6 Apr 2022 03:44:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FWj9LEr_ljL6; Wed,  6 Apr 2022 03:44:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C918681699;
	Wed,  6 Apr 2022 03:44:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9EC31C002C;
	Wed,  6 Apr 2022 03:44:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB254C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CAE6481A3E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:44:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GHpEyXkrHraJ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:44:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out199-2.us.a.mail.aliyun.com (out199-2.us.a.mail.aliyun.com
 [47.90.199.2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 95AC2817BA
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:44:08 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R261e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=34; SR=0; TI=SMTPD_---0V9K2X4R_1649216639; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V9K2X4R_1649216639) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 06 Apr 2022 11:44:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v9 06/32] virtio_ring: split: extract the logic of alloc queue
Date: Wed,  6 Apr 2022 11:43:20 +0800
Message-Id: <20220406034346.74409-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 881cb3483d12
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
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
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

This feature is required for subsequent virtuqueue reset vring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 53 ++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 33fddfb907a6..72d5ae063fa0 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -915,23 +915,15 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
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
+static void *vring_alloc_queue_split(struct virtio_device *vdev,
+				     dma_addr_t *dma_addr,
+				     u32 *n,
+				     unsigned int vring_align,
+				     bool weak_barriers,
+				     bool may_reduce_num)
 {
-	struct virtqueue *vq;
 	void *queue = NULL;
-	dma_addr_t dma_addr;
-	size_t queue_size_in_bytes;
-	struct vring vring;
+	u32 num = *n;
 
 	/* We assume num is a power of 2. */
 	if (num & (num - 1)) {
@@ -942,7 +934,7 @@ static struct virtqueue *vring_create_virtqueue_split(
 	/* TODO: allocate each queue chunk individually */
 	for (; num && vring_size(num, vring_align) > PAGE_SIZE; num /= 2) {
 		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
-					  &dma_addr,
+					  dma_addr,
 					  GFP_KERNEL|__GFP_NOWARN|__GFP_ZERO);
 		if (queue)
 			break;
@@ -956,11 +948,38 @@ static struct virtqueue *vring_create_virtqueue_split(
 	if (!queue) {
 		/* Try to get a single page. You are my only hope! */
 		queue = vring_alloc_queue(vdev, vring_size(num, vring_align),
-					  &dma_addr, GFP_KERNEL|__GFP_ZERO);
+					  dma_addr, GFP_KERNEL|__GFP_ZERO);
 	}
 	if (!queue)
 		return NULL;
 
+	*n = num;
+	return queue;
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
+	size_t queue_size_in_bytes;
+	struct virtqueue *vq;
+	dma_addr_t dma_addr;
+	struct vring vring;
+	void *queue;
+
+	queue = vring_alloc_queue_split(vdev, &dma_addr, &num, vring_align,
+					weak_barriers, may_reduce_num);
+	if (!queue)
+		return NULL;
+
 	queue_size_in_bytes = vring_size(num, vring_align);
 	vring_init(&vring, num, queue, vring_align);
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
