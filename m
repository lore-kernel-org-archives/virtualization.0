Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118F4CCA486
	for <virtualization@archiver.kernel.org>; Wed, 20 Jul 2022 03:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 957796106E;
	Wed, 20 Jul 2022 03:04:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 957796106E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ErIsrGB_WPGm; Wed, 20 Jul 2022 03:04:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0A70A60B3A;
	Wed, 20 Jul 2022 03:04:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0A70A60B3A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D60BEC002D;
	Wed, 20 Jul 2022 03:04:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9B78C0084
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:04:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C1C13402FE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:04:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C1C13402FE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7m5pyG4VprbX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:04:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9FE7F400DB
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9FE7F400DB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jul 2022 03:04:48 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045170;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VJuw0H6_1658286281; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VJuw0H6_1658286281) by smtp.aliyun-inc.com;
 Wed, 20 Jul 2022 11:04:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v12 02/40] virtio: struct virtio_config_ops add callbacks for
 queue_reset
Date: Wed, 20 Jul 2022 11:03:58 +0800
Message-Id: <20220720030436.79520-3-xuanzhuo@linux.alibaba.com>
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

reset can be divided into the following four steps (example):
 1. transport: notify the device to reset the queue
 2. vring:     recycle the buffer submitted
 3. vring:     reset/resize the vring (may re-alloc)
 4. transport: mmap vring to device, and enable the queue

In order to support queue reset, add two callbacks in struct
virtio_config_ops to implement steps 1 and 4.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 include/linux/virtio_config.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b47c2e7ed0ee..36ec7be1f480 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -78,6 +78,18 @@ struct virtio_shm_region {
  * @set_vq_affinity: set the affinity for a virtqueue (optional).
  * @get_vq_affinity: get the affinity for a virtqueue (optional).
  * @get_shm_region: get a shared memory region based on the index.
+ * @disable_vq_and_reset: reset a queue individually (optional).
+ *	vq: the virtqueue
+ *	Returns 0 on success or error status
+ *	disable_vq_and_reset will guarantee that the callbacks are disabled and
+ *	synchronized.
+ *	Except for the callback, the caller should guarantee that the vring is
+ *	not accessed by any functions of virtqueue.
+ * @enable_vq_after_reset: enable a reset queue
+ *	vq: the virtqueue
+ *	Returns 0 on success or error status
+ *	If disable_vq_and_reset is set, then enable_vq_after_reset must also be
+ *	set.
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
@@ -104,6 +116,8 @@ struct virtio_config_ops {
 			int index);
 	bool (*get_shm_region)(struct virtio_device *vdev,
 			       struct virtio_shm_region *region, u8 id);
+	int (*disable_vq_and_reset)(struct virtqueue *vq);
+	int (*enable_vq_after_reset)(struct virtqueue *vq);
 };
 
 /* If driver didn't advertise the feature, it will never appear. */
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
