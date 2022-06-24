Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5F5CCA481
	for <virtualization@archiver.kernel.org>; Fri, 24 Jun 2022 02:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91251612C3;
	Fri, 24 Jun 2022 02:57:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91251612C3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FsrlJuCkA3x0; Fri, 24 Jun 2022 02:56:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1B473612AD;
	Fri, 24 Jun 2022 02:56:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1B473612AD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE547C0032;
	Fri, 24 Jun 2022 02:56:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D78BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4A9B484813
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A9B484813
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RAeK0UcptNol
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1EF0A8482F
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1EF0A8482F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:55 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VHEw.VQ_1656039408; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VHEw.VQ_1656039408) by smtp.aliyun-inc.com;
 Fri, 24 Jun 2022 10:56:49 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v10 12/41] virtio_ring: split: extract the logic of attach
 vring
Date: Fri, 24 Jun 2022 10:55:52 +0800
Message-Id: <20220624025621.128843-13-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: fef800c86cd2
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

Separate the logic of attach vring, subsequent patches will call it
separately.

Since the "struct vring_virtqueue_split split" is created on the
stack and has been initialized to 0. So using
split->queue_dma_addr/split->queue_size_in_bytes assignment for
queue_dma_addr/queue_size_in_bytes can keep the same as the original
code.

On the other hand, subsequent patches can use the "struct
vring_virtqueue_split split" obtained by vring_alloc_queue_split() to
directly complete the attach operation.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index ef775154536e..7ee8dd4328ca 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -935,6 +935,18 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 	return NULL;
 }
 
+static void virtqueue_vring_attach_split(struct vring_virtqueue *vq,
+					 struct vring_virtqueue_split *vring)
+{
+	vq->split.queue_dma_addr = vring->queue_dma_addr;
+	vq->split.queue_size_in_bytes = vring->queue_size_in_bytes;
+
+	vq->split.vring = vring->vring;
+
+	vq->split.desc_state = vring->desc_state;
+	vq->split.desc_extra = vring->desc_extra;
+}
+
 static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring)
 {
 	struct vring_desc_state_split *state;
@@ -2252,10 +2264,6 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->indirect = virtio_has_feature(vdev, VIRTIO_RING_F_INDIRECT_DESC) &&
 		!context;
 
-	vq->split.queue_dma_addr = 0;
-	vq->split.queue_size_in_bytes = 0;
-
-	vq->split.vring = _vring;
 	vq->split.avail_flags_shadow = 0;
 	vq->split.avail_idx_shadow = 0;
 
@@ -2275,10 +2283,8 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 		return NULL;
 	}
 
-	vq->split.desc_state = vring.desc_state;
-	vq->split.desc_extra = vring.desc_extra;
-
 	virtqueue_init(vq, vring.vring.num);
+	virtqueue_vring_attach_split(vq, &vring);
 
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
