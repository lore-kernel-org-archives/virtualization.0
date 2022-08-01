Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2CDC00144
	for <virtualization@archiver.kernel.org>; Mon,  1 Aug 2022 06:39:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D84B98417F;
	Mon,  1 Aug 2022 06:39:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D84B98417F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1OL0gTm1wnnQ; Mon,  1 Aug 2022 06:39:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B86E58417B;
	Mon,  1 Aug 2022 06:39:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B86E58417B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8151C007E;
	Mon,  1 Aug 2022 06:39:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14BBCC0071
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:39:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AF031611D6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:39:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AF031611D6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yaMxy9hXcN7W
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:39:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6DDAA611D8
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6DDAA611D8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Aug 2022 06:39:47 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R221e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VL1vSnT_1659335981; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VL1vSnT_1659335981) by smtp.aliyun-inc.com;
 Mon, 01 Aug 2022 14:39:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v14 20/42] virtio_ring: packed: extract the logic of vring init
Date: Mon,  1 Aug 2022 14:38:40 +0800
Message-Id: <20220801063902.129329-21-xuanzhuo@linux.alibaba.com>
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

Separate the logic of initializing vring, and subsequent patches will
call it separately.

This function completes the variable initialization of packed vring. It
together with the logic of atatch constitutes the initialization of
vring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 533af061d009..a6f90e6e621b 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1932,6 +1932,22 @@ static int vring_alloc_state_extra_packed(struct vring_virtqueue_packed *vring_p
 	return -ENOMEM;
 }
 
+static void virtqueue_vring_init_packed(struct vring_virtqueue_packed *vring_packed,
+					bool callback)
+{
+	vring_packed->next_avail_idx = 0;
+	vring_packed->avail_wrap_counter = 1;
+	vring_packed->event_flags_shadow = 0;
+	vring_packed->avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
+
+	/* No callback?  Tell other side not to bother us. */
+	if (!callback) {
+		vring_packed->event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
+		vring_packed->vring.driver->flags =
+			cpu_to_le16(vring_packed->event_flags_shadow);
+	}
+}
+
 static struct virtqueue *vring_create_virtqueue_packed(
 	unsigned int index,
 	unsigned int num,
@@ -1986,11 +2002,6 @@ static struct virtqueue *vring_create_virtqueue_packed(
 
 	vq->packed.vring = vring_packed.vring;
 
-	vq->packed.next_avail_idx = 0;
-	vq->packed.avail_wrap_counter = 1;
-	vq->packed.event_flags_shadow = 0;
-	vq->packed.avail_used_flags = 1 << VRING_PACKED_DESC_F_AVAIL;
-
 	err = vring_alloc_state_extra_packed(&vring_packed);
 	if (err)
 		goto err_state_extra;
@@ -2001,12 +2012,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->packed.desc_state = vring_packed.desc_state;
 	vq->packed.desc_extra = vring_packed.desc_extra;
 
-	/* No callback?  Tell other side not to bother us. */
-	if (!callback) {
-		vq->packed.event_flags_shadow = VRING_PACKED_EVENT_FLAG_DISABLE;
-		vq->packed.vring.driver->flags =
-			cpu_to_le16(vq->packed.event_flags_shadow);
-	}
+	virtqueue_vring_init_packed(&vring_packed, !!callback);
 
 	virtqueue_init(vq, num);
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
