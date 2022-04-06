Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352E3C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 03:44:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFED041794;
	Wed,  6 Apr 2022 03:44:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ecsuJ5XAinuw; Wed,  6 Apr 2022 03:44:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 260444177E;
	Wed,  6 Apr 2022 03:44:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F243DC002C;
	Wed,  6 Apr 2022 03:44:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09345C0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:44:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 05EC981A18
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:44:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UqLMdorzvrik
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:44:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 39A5D81A92
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:44:18 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=34; SR=0; TI=SMTPD_---0V9K8DYd_1649216652; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V9K8DYd_1649216652) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 06 Apr 2022 11:44:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v9 12/32] virtio_ring: packed: extract the logic of alloc queue
Date: Wed,  6 Apr 2022 11:43:26 +0800
Message-Id: <20220406034346.74409-13-xuanzhuo@linux.alibaba.com>
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

Separate the logic of packed to create vring queue.

For the convenience of passing parameters, add a structure
vring_packed.

This feature is required for subsequent virtuqueue reset vring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 70 ++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 33864134a744..ea451ae2aaef 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1817,19 +1817,17 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
 	return desc_extra;
 }
 
-static struct virtqueue *vring_create_virtqueue_packed(
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
+static int vring_alloc_queue_packed(struct virtio_device *vdev,
+				    u32 num,
+				    struct vring_packed_desc **_ring,
+				    struct vring_packed_desc_event **_driver,
+				    struct vring_packed_desc_event **_device,
+				    dma_addr_t *_ring_dma_addr,
+				    dma_addr_t *_driver_event_dma_addr,
+				    dma_addr_t *_device_event_dma_addr,
+				    size_t *_ring_size_in_bytes,
+				    size_t *_event_size_in_bytes)
 {
-	struct vring_virtqueue *vq;
 	struct vring_packed_desc *ring;
 	struct vring_packed_desc_event *driver, *device;
 	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
@@ -1857,6 +1855,52 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (!device)
 		goto err_device;
 
+	*_ring                   = ring;
+	*_driver                 = driver;
+	*_device                 = device;
+	*_ring_dma_addr          = ring_dma_addr;
+	*_driver_event_dma_addr  = driver_event_dma_addr;
+	*_device_event_dma_addr  = device_event_dma_addr;
+	*_ring_size_in_bytes     = ring_size_in_bytes;
+	*_event_size_in_bytes    = event_size_in_bytes;
+
+	return 0;
+
+err_device:
+	vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
+
+err_driver:
+	vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
+
+err_ring:
+	return -ENOMEM;
+}
+
+static struct virtqueue *vring_create_virtqueue_packed(
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
+	dma_addr_t ring_dma_addr, driver_event_dma_addr, device_event_dma_addr;
+	struct vring_packed_desc_event *driver, *device;
+	size_t ring_size_in_bytes, event_size_in_bytes;
+	struct vring_packed_desc *ring;
+	struct vring_virtqueue *vq;
+
+	if (vring_alloc_queue_packed(vdev, num, &ring, &driver, &device,
+				     &ring_dma_addr, &driver_event_dma_addr,
+				     &device_event_dma_addr,
+				     &ring_size_in_bytes,
+				     &event_size_in_bytes))
+		goto err_ring;
+
 	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
 	if (!vq)
 		goto err_vq;
@@ -1939,9 +1983,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	kfree(vq);
 err_vq:
 	vring_free_queue(vdev, event_size_in_bytes, device, device_event_dma_addr);
-err_device:
 	vring_free_queue(vdev, event_size_in_bytes, driver, driver_event_dma_addr);
-err_driver:
 	vring_free_queue(vdev, ring_size_in_bytes, ring, ring_dma_addr);
 err_ring:
 	return NULL;
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
