Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7914C43334
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 07:22:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B91F83FA9;
	Tue, 26 Jul 2022 07:22:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B91F83FA9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Kj6JAQzP1XXg; Tue, 26 Jul 2022 07:22:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id EF39383FC1;
	Tue, 26 Jul 2022 07:22:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF39383FC1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B2789C0033;
	Tue, 26 Jul 2022 07:22:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71580C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F018415B0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F018415B0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a_Sk4VViM8I9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8997C4165A
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8997C4165A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:53 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VKUJO7._1658820163; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VKUJO7._1658820163) by smtp.aliyun-inc.com;
 Tue, 26 Jul 2022 15:22:44 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v13 09/42] virtio_ring: split: introduce vring_free_split()
Date: Tue, 26 Jul 2022 15:21:52 +0800
Message-Id: <20220726072225.19884-10-xuanzhuo@linux.alibaba.com>
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

Free the structure struct vring_vritqueue_split.

Subsequent patches require it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_ring.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 4d65c437d968..ba7cc560d823 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -947,6 +947,17 @@ static void *virtqueue_detach_unused_buf_split(struct virtqueue *_vq)
 	return NULL;
 }
 
+static void vring_free_split(struct vring_virtqueue_split *vring_split,
+			     struct virtio_device *vdev)
+{
+	vring_free_queue(vdev, vring_split->queue_size_in_bytes,
+			 vring_split->vring.desc,
+			 vring_split->queue_dma_addr);
+
+	kfree(vring_split->desc_state);
+	kfree(vring_split->desc_extra);
+}
+
 static struct virtqueue *vring_create_virtqueue_split(
 	unsigned int index,
 	unsigned int num,
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
