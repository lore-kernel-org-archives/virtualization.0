Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2213CCA486
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 03:05:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74F30419D4;
	Wed, 20 Jul 2022 03:05:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 74F30419D4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tl9kXInMwwgO; Wed, 20 Jul 2022 03:05:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 91FE9419C5;
	Wed, 20 Jul 2022 03:05:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91FE9419C5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66656C0033;
	Wed, 20 Jul 2022 03:05:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10358C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D0E9D419C3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:05:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D0E9D419C3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f3L7sNZAwkxg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:05:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6CBF2419C6
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6CBF2419C6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:05:45 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046049;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VJuyeeU_1658286338; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VJuyeeU_1658286338) by smtp.aliyun-inc.com;
 Wed, 20 Jul 2022 11:05:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v12 26/40] virtio_ring: struct virtqueue introduce reset
Date: Wed, 20 Jul 2022 11:04:22 +0800
Message-Id: <20220720030436.79520-27-xuanzhuo@linux.alibaba.com>
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

Introduce a new member reset to the structure virtqueue to determine
whether the current vq is in the reset state. Subsequent patches will
use it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 2 ++
 include/linux/virtio.h       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index bf666dad9904..8278b917ad64 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2011,6 +2011,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
 	vq->vq.index = index;
+	vq->vq.reset = false;
 	vq->we_own_ring = true;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
@@ -2490,6 +2491,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	vq->vq.vdev = vdev;
 	vq->vq.name = name;
 	vq->vq.index = index;
+	vq->vq.reset = false;
 	vq->we_own_ring = false;
 	vq->notify = notify;
 	vq->weak_barriers = weak_barriers;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index d45ee82a4470..a3f73bb6733e 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -20,6 +20,7 @@
  * @index: the zero-based ordinal number for this queue.
  * @num_free: number of elements we expect to be able to fit.
  * @num_max: the maximum number of elements supported by the device.
+ * @reset: vq is in reset state or not.
  *
  * A note on @num_free: with indirect buffers, each buffer needs one
  * element in the queue, otherwise a buffer will need one element per
@@ -34,6 +35,7 @@ struct virtqueue {
 	unsigned int num_free;
 	unsigned int num_max;
 	void *priv;
+	bool reset;
 };
 
 int virtqueue_add_outbuf(struct virtqueue *vq,
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
