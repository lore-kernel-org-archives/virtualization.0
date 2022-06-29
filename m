Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC755C433EF
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 06:57:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C8B841A27;
	Wed, 29 Jun 2022 06:57:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4C8B841A27
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6Hkw92UtBLQq; Wed, 29 Jun 2022 06:57:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 525E141A1A;
	Wed, 29 Jun 2022 06:57:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 525E141A1A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1C8E7C0032;
	Wed, 29 Jun 2022 06:57:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7D6A9C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:57:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4B4D78344C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:57:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B4D78344C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aKdb9d0TSPY4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:57:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 24F1382F32
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 24F1382F32
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:57:26 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R791e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VHml7x-_1656485836; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VHml7x-_1656485836) by smtp.aliyun-inc.com;
 Wed, 29 Jun 2022 14:57:17 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v11 09/40] virtio_ring: split: extract the logic of alloc
 state and extra
Date: Wed, 29 Jun 2022 14:56:25 +0800
Message-Id: <20220629065656.54420-10-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 3fdaf102dd89
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

Separate the logic of creating desc_state, desc_extra, and subsequent
patches will call it independently.

Since only the structure vring is passed into __vring_new_virtqueue(),
when creating the function vring_alloc_state_extra_split(), we prefer to
use vring_virtqueue_split as a parameter, and it will be more convenient
to pass vring_virtqueue_split to some subsequent functions.

So a new vring_virtqueue_split variable is added in
__vring_new_virtqueue().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 58 +++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 18 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a9ceb9c16c54..cedd340d6db7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -204,6 +204,7 @@ struct vring_virtqueue {
 #endif
 };
 
+static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
 
 /*
  * Helpers.
@@ -939,6 +940,32 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 	return NULL;
 }
 
+static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring)
+{
+	struct vring_desc_state_split *state;
+	struct vring_desc_extra *extra;
+	u32 num = vring->vring.num;
+
+	state = kmalloc_array(num, sizeof(struct vring_desc_state_split), GFP_KERNEL);
+	if (!state)
+		goto err_state;
+
+	extra = vring_alloc_desc_extra(num);
+	if (!extra)
+		goto err_extra;
+
+	memset(state, 0, num * sizeof(struct vring_desc_state_split));
+
+	vring->desc_state = state;
+	vring->desc_extra = extra;
+	return 0;
+
+err_extra:
+	kfree(state);
+err_state:
+	return -ENOMEM;
+}
+
 static void vring_free_split(struct vring_virtqueue_split *vring,
 			     struct virtio_device *vdev)
 {
@@ -2224,7 +2251,7 @@ EXPORT_SYMBOL_GPL(vring_interrupt);
 
 /* Only available for split ring */
 struct virtqueue *__vring_new_virtqueue(unsigned int index,
-					struct vring vring,
+					struct vring _vring,
 					struct virtio_device *vdev,
 					bool weak_barriers,
 					bool context,
@@ -2232,7 +2259,9 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					void (*callback)(struct virtqueue *),
 					const char *name)
 {
+	struct vring_virtqueue_split vring = {};
 	struct vring_virtqueue *vq;
+	int err;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return NULL;
@@ -2261,7 +2290,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->split.queue_dma_addr = 0;
 	vq->split.queue_size_in_bytes = 0;
 
-	vq->split.vring = vring;
+	vq->split.vring = _vring;
 	vq->split.avail_flags_shadow = 0;
 	vq->split.avail_idx_shadow = 0;
 
@@ -2273,30 +2302,23 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					vq->split.avail_flags_shadow);
 	}
 
-	vq->split.desc_state = kmalloc_array(vring.num,
-			sizeof(struct vring_desc_state_split), GFP_KERNEL);
-	if (!vq->split.desc_state)
-		goto err_state;
+	vring.vring = _vring;
 
-	vq->split.desc_extra = vring_alloc_desc_extra(vring.num);
-	if (!vq->split.desc_extra)
-		goto err_extra;
+	err = vring_alloc_state_extra_split(&vring);
+	if (err) {
+		kfree(vq);
+		return NULL;
+	}
 
-	memset(vq->split.desc_state, 0, vring.num *
-			sizeof(struct vring_desc_state_split));
+	vq->split.desc_state = vring.desc_state;
+	vq->split.desc_extra = vring.desc_extra;
 
-	virtqueue_init(vq, vq->split.vring.num);
+	virtqueue_init(vq, vring.vring.num);
 
 	spin_lock(&vdev->vqs_list_lock);
 	list_add_tail(&vq->vq.list, &vdev->vqs);
 	spin_unlock(&vdev->vqs_list_lock);
 	return &vq->vq;
-
-err_extra:
-	kfree(vq->split.desc_state);
-err_state:
-	kfree(vq);
-	return NULL;
 }
 EXPORT_SYMBOL_GPL(__vring_new_virtqueue);
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
