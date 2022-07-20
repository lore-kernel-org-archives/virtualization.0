Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FF2C433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 03:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C1881405B6;
	Wed, 20 Jul 2022 03:05:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1881405B6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b5e75UcYPl1N; Wed, 20 Jul 2022 03:05:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3DEF94058E;
	Wed, 20 Jul 2022 03:05:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3DEF94058E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E219C0033;
	Wed, 20 Jul 2022 03:05:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE4C7C007C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:05:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BA40D405CF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:05:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA40D405CF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xyvfrj8NblBB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:05:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 95CDF405B6
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 95CDF405B6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:05:24 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R251e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VJuw0T4_1658286317; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VJuw0T4_1658286317) by smtp.aliyun-inc.com;
 Wed, 20 Jul 2022 11:05:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v12 17/40] virtio_ring: packed: extract the logic of alloc
 state and extra
Date: Wed, 20 Jul 2022 11:04:13 +0800
Message-Id: <20220720030436.79520-18-xuanzhuo@linux.alibaba.com>
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

Separate the logic for alloc desc_state and desc_extra, which will
be called separately by subsequent patches.

Use struct vring_packed to pass desc_state, desc_extra.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 48 +++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a495f1cb7fe4..1f8d6417b46a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1905,6 +1905,33 @@ static int vring_alloc_queue_packed(struct vring_virtqueue_packed *vring_packed,
 	return -ENOMEM;
 }
 
+static int vring_alloc_state_extra_packed(struct vring_virtqueue_packed *vring_packed)
+{
+	struct vring_desc_state_packed *state;
+	struct vring_desc_extra *extra;
+	u32 num = vring_packed->vring.num;
+
+	state = kmalloc_array(num, sizeof(struct vring_desc_state_packed), GFP_KERNEL);
+	if (!state)
+		goto err_desc_state;
+
+	memset(state, 0, num * sizeof(struct vring_desc_state_packed));
+
+	extra = vring_alloc_desc_extra(num);
+	if (!extra)
+		goto err_desc_extra;
+
+	vring_packed->desc_state = state;
+	vring_packed->desc_extra = extra;
+
+	return 0;
+
+err_desc_extra:
+	kfree(state);
+err_desc_state:
+	return -ENOMEM;
+}
+
 static struct virtqueue *vring_create_virtqueue_packed(
 	unsigned int index,
 	unsigned int num,
@@ -1919,6 +1946,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 {
 	struct vring_virtqueue_packed vring_packed = {};
 	struct vring_virtqueue *vq;
+	int err;
 
 	if (vring_alloc_queue_packed(&vring_packed, vdev, num))
 		goto err_ring;
@@ -1958,21 +1986,15 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->packed.event_flags_shadow = 0;
 	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
 
-	vq->packed.desc_state = kmalloc_array(num,
-			sizeof(struct vring_desc_state_packed),
-			GFP_KERNEL);
-	if (!vq->packed.desc_state)
-		goto err_desc_state;
+	err = vring_alloc_state_extra_packed(&vring_packed);
+	if (err)
+		goto err_state_extra;
 
-	memset(vq->packed.desc_state, 0,
-		num * sizeof(struct vring_desc_state_packed));
+	vq->packed.desc_state = vring.desc_state;
+	vq->packed.desc_extra = vring.desc_extra;
 
 	virtqueue_init(vq, num);
 
-	vq->packed.desc_extra = vring_alloc_desc_extra(num);
-	if (!vq->packed.desc_extra)
-		goto err_desc_extra;
-
 	/* No callback?  Tell other side not to bother us. */
 	if (!callback) {
 		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
@@ -1985,9 +2007,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	spin_unlock(&vdev->vqs_list_lock);
 	return &vq->vq;
 
-err_desc_extra:
-	kfree(vq->packed.desc_state);
-err_desc_state:
+err_state_extra:
 	kfree(vq);
 err_vq:
 	vring_free_packed(&vring_packed, vdev);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
