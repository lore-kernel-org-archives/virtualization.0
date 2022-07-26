Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB65EC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 07:22:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8BAA9401D5;
	Tue, 26 Jul 2022 07:22:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8BAA9401D5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29stuc5GEHqP; Tue, 26 Jul 2022 07:22:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2A06741051;
	Tue, 26 Jul 2022 07:22:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2A06741051
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBCB9C007E;
	Tue, 26 Jul 2022 07:22:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DEE7C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4ADA583FEC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4ADA583FEC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3hOm54Kke77K
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1BD8583FB1
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BD8583FB1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:45 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VKUIJXA_1658820159; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VKUIJXA_1658820159) by smtp.aliyun-inc.com;
 Tue, 26 Jul 2022 15:22:40 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v13 07/42] virtio_ring: split: stop __vring_new_virtqueue as
 export symbol
Date: Tue, 26 Jul 2022 15:21:50 +0800
Message-Id: <20220726072225.19884-8-xuanzhuo@linux.alibaba.com>
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

There is currently only one place to reference __vring_new_virtqueue()
directly from the outside of virtio core. And here vring_new_virtqueue()
can be used instead.

Subsequent patches will modify __vring_new_virtqueue, so stop it as an
export symbol for now.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 25 ++++++++++++++++---------
 include/linux/virtio_ring.h  | 10 ----------
 tools/virtio/virtio_test.c   |  4 ++--
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0ad35eca0d39..4e54ed7ee7fb 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -204,6 +204,14 @@ struct vring_virtqueue {
 #endif
 };
 
+static struct virtqueue *__vring_new_virtqueue(unsigned int index,
+					       struct vring vring,
+					       struct virtio_device *vdev,
+					       bool weak_barriers,
+					       bool context,
+					       bool (*notify)(struct virtqueue *),
+					       void (*callback)(struct virtqueue *),
+					       const char *name);
 
 /*
  * Helpers.
@@ -2197,14 +2205,14 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
 EXPORT_SYMBOL_GPL(vring_interrupt);
 
 /* Only available for split ring */
-struct virtqueue *__vring_new_virtqueue(unsigned int index,
-					struct vring vring,
-					struct virtio_device *vdev,
-					bool weak_barriers,
-					bool context,
-					bool (*notify)(struct virtqueue *),
-					void (*callback)(struct virtqueue *),
-					const char *name)
+static struct virtqueue *__vring_new_virtqueue(unsigned int index,
+					       struct vring vring,
+					       struct virtio_device *vdev,
+					       bool weak_barriers,
+					       bool context,
+					       bool (*notify)(struct virtqueue *),
+					       void (*callback)(struct virtqueue *),
+					       const char *name)
 {
 	struct vring_virtqueue *vq;
 
@@ -2272,7 +2280,6 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
 	kfree(vq);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(__vring_new_virtqueue);
 
 struct virtqueue *vring_create_virtqueue(
 	unsigned int index,
diff --git a/include/linux/virtio_ring.h b/include/linux/virtio_ring.h
index b485b13fa50b..8b8af1a38991 100644
--- a/include/linux/virtio_ring.h
+++ b/include/linux/virtio_ring.h
@@ -76,16 +76,6 @@ struct virtqueue *vring_create_virtqueue(unsigned int index,
 					 void (*callback)(struct virtqueue *vq),
 					 const char *name);
 
-/* Creates a virtqueue with a custom layout. */
-struct virtqueue *__vring_new_virtqueue(unsigned int index,
-					struct vring vring,
-					struct virtio_device *vdev,
-					bool weak_barriers,
-					bool ctx,
-					bool (*notify)(struct virtqueue *),
-					void (*callback)(struct virtqueue *),
-					const char *name);
-
 /*
  * Creates a virtqueue with a standard layout but a caller-allocated
  * ring.
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 23f142af544a..86a410ddcedd 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -102,8 +102,8 @@ static void vq_reset(struct vq_info *info, int num, struct virtio_device *vdev)
 
 	memset(info->ring, 0, vring_size(num, 4096));
 	vring_init(&info->vring, num, info->ring, 4096);
-	info->vq = __vring_new_virtqueue(info->idx, info->vring, vdev, true,
-					 false, vq_notify, vq_callback, "test");
+	info->vq = vring_new_virtqueue(info->idx, num, 4096, vdev, true, false,
+				       info->ring, vq_notify, vq_callback, "test");
 	assert(info->vq);
 	info->vq->priv = info;
 }
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
