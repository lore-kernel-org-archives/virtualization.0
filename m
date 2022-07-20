Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A472C43334
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 03:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E923083A47;
	Wed, 20 Jul 2022 03:05:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E923083A47
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Csocw3gCK7BW; Wed, 20 Jul 2022 03:05:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7B4B883F10;
	Wed, 20 Jul 2022 03:05:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B4B883F10
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 551D2C0033;
	Wed, 20 Jul 2022 03:05:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A050C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 66387419B7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:05:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66387419B7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gxZcOIM7Hz8l
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:05:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F151741998
Received: from out199-12.us.a.mail.aliyun.com (out199-12.us.a.mail.aliyun.com
 [47.90.199.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F151741998
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:05:27 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=37; SR=0; TI=SMTPD_---0VJuvIdk_1658286319; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VJuvIdk_1658286319) by smtp.aliyun-inc.com;
 Wed, 20 Jul 2022 11:05:20 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v12 18/40] virtio_ring: packed: extract the logic of attach
 vring
Date: Wed, 20 Jul 2022 11:04:14 +0800
Message-Id: <20220720030436.79520-19-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
References: <20220720030436.79520-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 366032b2ffac
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

Separate the logic of attach vring, the subsequent patch will call it
separately.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1f8d6417b46a..19ed20d7d433 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1932,6 +1932,22 @@ static int vring_alloc_state_extra_packed(struct vring_virtqueue_packed *vring_p
 	return -ENOMEM;
 }
 
+static void virtqueue_vring_attach_packed(struct vring_virtqueue *vq,
+					  struct vring_virtqueue_packed *vring_packed)
+{
+	vq->packed.ring_dma_addr = vring_packed->ring_dma_addr;
+	vq->packed.driver_event_dma_addr = vring_packed->driver_event_dma_addr;
+	vq->packed.device_event_dma_addr = vring_packed->device_event_dma_addr;
+
+	vq->packed.ring_size_in_bytes = vring_packed->ring_size_in_bytes;
+	vq->packed.event_size_in_bytes = vring_packed->event_size_in_bytes;
+
+	vq->packed.vring = vring_packed->vring;
+
+	vq->packed.desc_state = vring_packed->desc_state;
+	vq->packed.desc_extra = vring_packed->desc_extra;
+}
+
 static struct virtqueue *vring_create_virtqueue_packed(
 	unsigned int index,
 	unsigned int num,
@@ -1972,15 +1988,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
 
-	vq->packed.ring_dma_addr = vring_packed.ring_dma_addr;
-	vq->packed.driver_event_dma_addr = vring_packed.driver_event_dma_addr;
-	vq->packed.device_event_dma_addr = vring_packed.device_event_dma_addr;
-
-	vq->packed.ring_size_in_bytes = vring_packed.ring_size_in_bytes;
-	vq->packed.event_size_in_bytes = vring_packed.event_size_in_bytes;
-
-	vq->packed.vring = vring_packed.vring;
-
 	vq->packed.next_avail_idx = 0;
 	vq->packed.avail_wrap_counter = 1;
 	vq->packed.event_flags_shadow = 0;
@@ -1990,10 +1997,8 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	if (err)
 		goto err_state_extra;
 
-	vq->packed.desc_state = vring.desc_state;
-	vq->packed.desc_extra = vring.desc_extra;
-
 	virtqueue_init(vq, num);
+	virtqueue_vring_attach_packed(vq, &vring_packed);
 
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback) {
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
