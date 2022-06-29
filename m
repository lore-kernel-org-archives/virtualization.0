Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222F9CCA482
	for <virtualization@archiver.kernel.org>; Wed, 29 Jun 2022 06:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B0FE041A1A;
	Wed, 29 Jun 2022 06:57:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B0FE041A1A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z-Uy0Xsuf32A; Wed, 29 Jun 2022 06:57:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 83EC741A33;
	Wed, 29 Jun 2022 06:57:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 83EC741A33
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57EEBC0032;
	Wed, 29 Jun 2022 06:57:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1FBAC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:57:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 726D140C09
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:57:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 726D140C09
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BlFjHhoWQkeV
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:57:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 43E7340C91
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 43E7340C91
 for <virtualization@lists.linux-foundation.org>;
 Wed, 29 Jun 2022 06:57:36 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=37; SR=0; TI=SMTPD_---0VHmlufA_1656485849; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VHmlufA_1656485849) by smtp.aliyun-inc.com;
 Wed, 29 Jun 2022 14:57:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v11 15/40] virtio_ring: packed: introduce vring_free_packed
Date: Wed, 29 Jun 2022 14:56:31 +0800
Message-Id: <20220629065656.54420-16-xuanzhuo@linux.alibaba.com>
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

Free the structure struct vring_vritqueue_packed.

Subsequent patches require it.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 1aaa1e5f9991..4f497b6f2d04 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1830,6 +1830,27 @@ static struct vring_desc_extra *vring_alloc_desc_extra(unsigned int num)
 	return desc_extra;
 }
 
+static void vring_free_packed(struct vring_virtqueue_packed *vring,
+			      struct virtio_device *vdev)
+{
+	if (vring->vring.desc)
+		vring_free_queue(vdev, vring->ring_size_in_bytes,
+				 vring->vring.desc, vring->ring_dma_addr);
+
+	if (vring->vring.driver)
+		vring_free_queue(vdev, vring->event_size_in_bytes,
+				 vring->vring.driver,
+				 vring->driver_event_dma_addr);
+
+	if (vring->vring.device)
+		vring_free_queue(vdev, vring->event_size_in_bytes,
+				 vring->vring.device,
+				 vring->device_event_dma_addr);
+
+	kfree(vring->desc_state);
+	kfree(vring->desc_extra);
+}
+
 static struct virtqueue *vring_create_virtqueue_packed(
 	unsigned int index,
 	unsigned int num,
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
