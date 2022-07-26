Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53CDC433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 07:23:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6A4D641BEE;
	Tue, 26 Jul 2022 07:23:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6A4D641BEE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oH4HlBeDqgeS; Tue, 26 Jul 2022 07:23:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 926C641BB7;
	Tue, 26 Jul 2022 07:22:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 926C641BB7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 531DEC0071;
	Tue, 26 Jul 2022 07:22:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E0648C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C7D3660D96
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C7D3660D96
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sr5SBgXKjidk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7A73260C20
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7A73260C20
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:56 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R801e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VKUOEem_1658820166; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VKUOEem_1658820166) by smtp.aliyun-inc.com;
 Tue, 26 Jul 2022 15:22:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v13 11/42] virtio_ring: split: extract the logic of alloc
 state and extra
Date: Tue, 26 Jul 2022 15:21:54 +0800
Message-Id: <20220726072225.19884-12-xuanzhuo@linux.alibaba.com>
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

Separate the logic of creating desc_state, desc_extra, and subsequent
patches will call it independently.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 51 +++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 3817520371ee..6c24b33ea186 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -212,6 +212,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					       bool (*notify)(struct virtqueue *),
 					       void (*callback)(struct virtqueue *),
 					       const char *name);
+static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num);
 
 /*
  * Helpers.
@@ -947,6 +948,32 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 	return NULL;
 }
 
+static int vring_alloc_state_extra_split(struct vring_virtqueue_split *vring_split)
+{
+	struct vring_desc_state_split *state;
+	struct vring_desc_extra *extra;
+	u32 num = vring_split->vring.num;
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
+	vring_split->desc_state = state;
+	vring_split->desc_extra = extra;
+	return 0;
+
+err_extra:
+	kfree(state);
+err_state:
+	return -ENOMEM;
+}
+
 static void vring_free_split(struct vring_virtqueue_split *vring_split,
 			     struct virtio_device *vdev)
 {
@@ -2242,6 +2269,7 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					       const char *name)
 {
 	struct vring_virtqueue *vq;
+	int err;
 
 	if (virtio_has_feature(vdev, VIRTIO_F_RING_PACKED))
 		return NULL;
@@ -2282,17 +2310,14 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
 					vq->split.avail_flags_shadow);
 	}
 
-	vq->split.desc_state = kmalloc_array(vring_split->vring.num,
-			sizeof(struct vring_desc_state_split), GFP_KERNEL);
-	if (!vq->split.desc_state)
-		goto err_state;
-
-	vq->split.desc_extra = vring_alloc_desc_extra(vring_split->vring.num);
-	if (!vq->split.desc_extra)
-		goto err_extra;
+	err = vring_alloc_state_extra_split(vring_split);
+	if (err) {
+		kfree(vq);
+		return NULL;
+	}
 
-	memset(vq->split.desc_state, 0, vring_split->vring.num *
-			sizeof(struct vring_desc_state_split));
+	vq->split.desc_state = vring_split->desc_state;
+	vq->split.desc_extra = vring_split->desc_extra;
 
 	virtqueue_init(vq, vring_split->vring.num);
 
@@ -2300,12 +2325,6 @@ static struct virtqueue *__vring_new_virtqueue(unsigned int index,
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
 
 struct virtqueue *vring_create_virtqueue(
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
