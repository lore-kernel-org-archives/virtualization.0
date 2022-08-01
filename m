Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2392C19F2C
	for <virtualization@archiver.kernel.org>; Mon,  1 Aug 2022 06:39:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 71B8A40328;
	Mon,  1 Aug 2022 06:39:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 71B8A40328
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id leMFQgIEBtm0; Mon,  1 Aug 2022 06:39:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E167C4036A;
	Mon,  1 Aug 2022 06:39:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E167C4036A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64900C007D;
	Mon,  1 Aug 2022 06:39:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D11EBC002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:39:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AA833611AF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:39:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA833611AF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id y4ARrS0CKity
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:39:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8867761195
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8867761195
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:39:21 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R721e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VL1cCFD_1659335954; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VL1cCFD_1659335954) by smtp.aliyun-inc.com;
 Mon, 01 Aug 2022 14:39:15 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v14 06/42] virtio_ring: introduce virtqueue_init()
Date: Mon,  1 Aug 2022 14:38:26 +0800
Message-Id: <20220801063902.129329-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
References: <20220801063902.129329-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 0f12e405b061
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

Separate the logic of virtqueue initialization. These variables should
be reset during reset.

This logic can be called independently when implementing resize/reset
later.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 38 +++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1bc5794e9739..a63ef2d99955 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -368,6 +368,24 @@ static int vring_mapping_error(const struct vring_virtqueue *vq,
 	return dma_mapping_error(vring_dma_dev(vq), addr);
 }
 
+static void virtqueue_init(struct vring_virtqueue *vq, u32 num)
+{
+	vq->vq.num_free = num;
+
+	if (vq->packed_ring)
+		vq->last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
+	else
+		vq->last_used_idx = 0;
+
+	vq->event_triggered = false;
+	vq->num_added = 0;
+
+#ifdef DEBUG
+	vq->in_use = false;
+	vq->last_add_time_valid = false;
+#endif
+}
+
 
 /*
  * Split ring specific functions - *_split().
@@ -1706,7 +1724,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
-	vq->vq.num_free = num;
 	vq->vq.index = index;
 	vq->we_own_ring = true;
 	vq->notify = notify;
@@ -1716,15 +1733,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
 #else
 	vq->broken = false;
 #endif
-	vq->last_used_idx = 0 | (1 << VRING_PACKED_EVENT_F_WRAP_CTR);
-	vq->event_triggered = false;
-	vq->num_added = 0;
 	vq->packed_ring = true;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-#ifdef DEBUG
-	vq->in_use = false;
-	vq->last_add_time_valid = false;
-#endif
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -1773,6 +1783,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
 			cpu_to_le16(vq->packed.event_flags_shadow);
 	}
 
+	virtqueue_init(vq, num);
+
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
 	spin_unlock(&vdev->vqs_list_lock);
@@ -2205,7 +2217,6 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->vq.callback = callback;
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
-	vq->vq.num_free = vring.num;
 	vq->vq.index = index;
 	vq->we_own_ring = false;
 	vq->notify = notify;
@@ -2215,14 +2226,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 #else
 	vq->broken = false;
 #endif
-	vq->last_used_idx = 0;
-	vq->event_triggered = false;
-	vq->num_added = 0;
 	vq->use_dma_api = vring_use_dma_api(vdev);
-#ifdef DEBUG
-	vq->in_use = false;
-	vq->last_add_time_valid = false;
-#endif
 
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
@@ -2260,6 +2264,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	memset(vq->split.desc_state, 0, vring.num *
 			sizeof(struct vring_desc_state_split));
 
+	virtqueue_init(vq, vring.num);
+
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
 	spin_unlock(&vdev->vqs_list_lock);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
