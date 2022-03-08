Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7FAC4167E
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 12:35:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 25FA084206;
	Tue,  8 Mar 2022 12:35:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z1ZMVX7C2w4U; Tue,  8 Mar 2022 12:35:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9D75A841F7;
	Tue,  8 Mar 2022 12:35:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 623DBC0070;
	Tue,  8 Mar 2022 12:35:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8DC6C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 896FE60FCB
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hD0IZTMPpPHl
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com
 [47.90.199.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1333260FC9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:43 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=34; SR=0; TI=SMTPD_---0V6ebqTT_1646742933; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6ebqTT_1646742933) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Mar 2022 20:35:34 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v7 07/26] virtio_ring: packed: extract the logic of init vq
 and attach vring
Date: Tue,  8 Mar 2022 20:34:59 +0800
Message-Id: <20220308123518.33800-8-xuanzhuo@linux.alibaba.com>
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

Split the logic of packed assignment vq into three parts.

1. The assignment passed from the function parameter
2. The part that attaches vring to vq. -- vring_virtqueue_attach_packed()
3. The part that initializes vq to a fixed value --
vring_virtqueue_init_packed()

This feature is required for subsequent virtuqueue reset vring

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 138 +++++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 56 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1af98b112996..b5a9bf4f45b3 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1773,36 +1773,53 @@ static int vring_create_vring_packed(struct vring_packed *vring,
 	return -ENOMEM;
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
+static int vring_virtqueue_attach_packed(struct vring_virtqueue *vq,
+					 struct vring_packed *vring,
+					 struct virtio_device *vdev)
 {
-	struct vring_virtqueue *vq;
-	struct vring_packed vring;
-
-	if (vring_create_vring_packed(&vring, vdev, num))
-		goto err_vq;
+	u32 num;
 
-	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
-	if (!vq)
-		goto err_vq;
+	num = vring->num;
 
-	vq->vq.callback = callback;
-	vq->vq.vdev = vdev;
-	vq->vq.name = name;
 	vq->vq.num_free = num;
-	vq->vq.index = index;
+
+	vq->packed.ring_dma_addr = vring->ring_dma_addr;
+	vq->packed.driver_event_dma_addr = vring->driver_event_dma_addr;
+	vq->packed.device_event_dma_addr = vring->device_event_dma_addr;
+
+	vq->packed.ring_size_in_bytes = vring->ring_size_in_bytes;
+	vq->packed.event_size_in_bytes = vring->event_size_in_bytes;
+
+	vq->packed.vring.num = num;
+	vq->packed.vring.desc = vring->ring;
+	vq->packed.vring.driver = vring->driver;
+	vq->packed.vring.device = vring->device;
+
+	vq->packed.desc_state = kmalloc_array(num,
+			sizeof(struct vring_desc_state_packed),
+			GFP_KERNEL);
+	if (!vq->packed.desc_state)
+		goto err_desc_state;
+
+	memset(vq->packed.desc_state, 0,
+		num * sizeof(struct vring_desc_state_packed));
+
+	vq->packed.desc_extra = vring_alloc_desc_extra(vq, num);
+	if (!vq->packed.desc_extra)
+		goto err_desc_extra;
+
+	return 0;
+
+err_desc_extra:
+	kfree(vq->packed.desc_state);
+err_desc_state:
+	return -ENOMEM;
+}
+
+static void vring_virtqueue_init_packed(struct vring_virtqueue *vq,
+					struct virtio_device *vdev)
+{
 	vq->we_own_ring = true;
-	vq->notify = notify;
-	vq->weak_barriers = weak_barriers;
 	vq->broken = false;
 	vq->last_used_idx = 0;
 	vq->event_triggered = false;
@@ -1814,62 +1831,71 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->last_add_time_valid = false;
 #endif
 
-	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
-		!context;
 	vq->event = virtio_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX);
 
 	if (virtio_has_feature(vdev, VIRTIO_F_ORDER_PLATFORM))
 		vq->weak_barriers = false;
 
-	vq->packed.ring_dma_addr = vring.ring_dma_addr;
-	vq->packed.driver_event_dma_addr = vring.driver_event_dma_addr;
-	vq->packed.device_event_dma_addr = vring.device_event_dma_addr;
-
-	vq->packed.ring_size_in_bytes = vring.ring_size_in_bytes;
-	vq->packed.event_size_in_bytes = vring.event_size_in_bytes;
-
-	vq->packed.vring.num = num;
-	vq->packed.vring.desc = vring.ring;
-	vq->packed.vring.driver = vring.driver;
-	vq->packed.vring.device = vring.device;
-
 	vq->packed.next_avail_idx = 0;
 	vq->packed.avail_wrap_counter = 1;
 	vq->packed.used_wrap_counter = 1;
 	vq->packed.event_flags_shadow = 0;
 	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
 
-	vq->packed.desc_state = kmalloc_array(num,
-			sizeof(struct vring_desc_state_packed),
-			GFP_KERNEL);
-	if (!vq->packed.desc_state)
-		goto err_desc_state;
-
-	memset(vq->packed.desc_state, 0,
-		num * sizeof(struct vring_desc_state_packed));
-
 	/* Put everything in free lists. */
 	vq->free_head = 0;
 
-	vq->packed.desc_extra = vring_alloc_desc_extra(vq, num);
-	if (!vq->packed.desc_extra)
-		goto err_desc_extra;
-
 	/* No callback?  Tell other side not to bother us. */
-	if (!callback) {
+	if (!vq->vq.callback) {
 		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
 		vq->packed.vring.driver->flags =
 			cpu_to_le16(vq->packed.event_flags_shadow);
 	}
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
+	struct vring_virtqueue *vq;
+	struct vring_packed vring;
+
+	if (vring_create_vring_packed(&vring, vdev, num))
+		goto err_vq;
+
+	vq = kmalloc(sizeof(*vq), GFP_KERNEL);
+	if (!vq)
+		goto err_vq;
+
+	vq->vq.callback = callback;
+	vq->vq.vdev = vdev;
+	vq->vq.name = name;
+	vq->vq.index = index;
+	vq->notify = notify;
+	vq->weak_barriers = weak_barriers;
+	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
+		!context;
+
+	if (vring_virtqueue_attach_packed(vq, &vring, vdev))
+		goto err;
+
+	vring_virtqueue_init_packed(vq, vdev);
 
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
 	spin_unlock(&vdev->vqs_list_lock);
+
 	return &vq->vq;
 
-err_desc_extra:
-	kfree(vq->packed.desc_state);
-err_desc_state:
+err:
 	kfree(vq);
 err_vq:
 	vring_free_vring_packed(&vring, vdev);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
