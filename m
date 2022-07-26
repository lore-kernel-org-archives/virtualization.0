Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCF2C43334
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 07:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9C53661049;
	Tue, 26 Jul 2022 07:22:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9C53661049
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fnP9CCUrQN4q; Tue, 26 Jul 2022 07:22:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1E5E660D95;
	Tue, 26 Jul 2022 07:22:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1E5E660D95
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88ED0C007E;
	Tue, 26 Jul 2022 07:22:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA875C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B66D883FE1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B66D883FE1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TNw9GGlR7L59
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 927F583FB1
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 927F583FB1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:43 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VKUN6LO_1658820155; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VKUN6LO_1658820155) by smtp.aliyun-inc.com;
 Tue, 26 Jul 2022 15:22:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v13 05/42] virtio_ring: split vring_virtqueue
Date: Tue, 26 Jul 2022 15:21:48 +0800
Message-Id: <20220726072225.19884-6-xuanzhuo@linux.alibaba.com>
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

Separate the two inline structures(split and packed) from the structure
vring_virtqueue.

In this way, we can use these two structures later to pass parameters
and retain temporary variables.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 116 ++++++++++++++++++-----------------
 1 file changed, 60 insertions(+), 56 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a3d76fd87983..1bc5794e9739 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -85,6 +85,64 @@ struct vring_desc_extra {
 	u16 next;			/* The next desc state in a list. */
 };
 
+struct vring_virtqueue_split {
+	/* Actual memory layout for this queue. */
+	struct vring vring;
+
+	/* Last written value to avail->flags */
+	u16 avail_flags_shadow;
+
+	/*
+	 * Last written value to avail->idx in
+	 * guest byte order.
+	 */
+	u16 avail_idx_shadow;
+
+	/* Per-descriptor state. */
+	struct vring_desc_state_split *desc_state;
+	struct vring_desc_extra *desc_extra;
+
+	/* DMA address and size information */
+	dma_addr_t queue_dma_addr;
+	size_t queue_size_in_bytes;
+};
+
+struct vring_virtqueue_packed {
+	/* Actual memory layout for this queue. */
+	struct {
+		unsigned int num;
+		struct vring_packed_desc *desc;
+		struct vring_packed_desc_event *driver;
+		struct vring_packed_desc_event *device;
+	} vring;
+
+	/* Driver ring wrap counter. */
+	bool avail_wrap_counter;
+
+	/* Avail used flags. */
+	u16 avail_used_flags;
+
+	/* Index of the next avail descriptor. */
+	u16 next_avail_idx;
+
+	/*
+	 * Last written value to driver->flags in
+	 * guest byte order.
+	 */
+	u16 event_flags_shadow;
+
+	/* Per-descriptor state. */
+	struct vring_desc_state_packed *desc_state;
+	struct vring_desc_extra *desc_extra;
+
+	/* DMA address and size information */
+	dma_addr_t ring_dma_addr;
+	dma_addr_t driver_event_dma_addr;
+	dma_addr_t device_event_dma_addr;
+	size_t ring_size_in_bytes;
+	size_t event_size_in_bytes;
+};
+
 struct vring_virtqueue {
 	struct virtqueue vq;
 
@@ -124,64 +182,10 @@ struct vring_virtqueue {
 
 	union {
 		/* Available for split ring */
-		struct {
-			/* Actual memory layout for this queue. */
-			struct vring vring;
-
-			/* Last written value to avail->flags */
-			u16 avail_flags_shadow;
-
-			/*
-			 * Last written value to avail->idx in
-			 * guest byte order.
-			 */
-			u16 avail_idx_shadow;
-
-			/* Per-descriptor state. */
-			struct vring_desc_state_split *desc_state;
-			struct vring_desc_extra *desc_extra;
-
-			/* DMA address and size information */
-			dma_addr_t queue_dma_addr;
-			size_t queue_size_in_bytes;
-		} split;
+		struct vring_virtqueue_split split;
 
 		/* Available for packed ring */
-		struct {
-			/* Actual memory layout for this queue. */
-			struct {
-				unsigned int num;
-				struct vring_packed_desc *desc;
-				struct vring_packed_desc_event *driver;
-				struct vring_packed_desc_event *device;
-			} vring;
-
-			/* Driver ring wrap counter. */
-			bool avail_wrap_counter;
-
-			/* Avail used flags. */
-			u16 avail_used_flags;
-
-			/* Index of the next avail descriptor. */
-			u16 next_avail_idx;
-
-			/*
-			 * Last written value to driver->flags in
-			 * guest byte order.
-			 */
-			u16 event_flags_shadow;
-
-			/* Per-descriptor state. */
-			struct vring_desc_state_packed *desc_state;
-			struct vring_desc_extra *desc_extra;
-
-			/* DMA address and size information */
-			dma_addr_t ring_dma_addr;
-			dma_addr_t driver_event_dma_addr;
-			dma_addr_t device_event_dma_addr;
-			size_t ring_size_in_bytes;
-			size_t event_size_in_bytes;
-		} packed;
+		struct vring_virtqueue_packed packed;
 	};
 
 	/* How to notify other side. FIXME: commonalize hcalls! */
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
