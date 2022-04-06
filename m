Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3202C433F5
	for <virtualization@archiver.kernel.org>; Wed,  6 Apr 2022 03:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 76955610B0;
	Wed,  6 Apr 2022 03:44:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4IaRd2Qnbl5c; Wed,  6 Apr 2022 03:44:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 00B02610BD;
	Wed,  6 Apr 2022 03:44:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DCA47C002C;
	Wed,  6 Apr 2022 03:44:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63EEBC0012
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:44:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 411D1610B3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:44:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Wq1jJjmnToKJ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:44:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65754610B5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 03:44:27 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R941e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=34; SR=0; TI=SMTPD_---0V9JnaR0_1649216661; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V9JnaR0_1649216661) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 06 Apr 2022 11:44:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v9 16/32] virtio_ring: packed: introduce
 virtqueue_reinit_packed()
Date: Wed,  6 Apr 2022 11:43:30 +0800
Message-Id: <20220406034346.74409-17-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 881cb3483d12
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

Introduce a function to initialize vq without allocating new ring,
desc_state, desc_extra.

Subsequent patches will call this function after reset vq to
reinitialize vq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index c783eb272468..9a4f2db718bd 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1971,6 +1971,27 @@ static void vring_virtqueue_init_packed(struct vring_virtqueue *vq,
 	}
 }
 
+static void virtqueue_reinit_packed(struct vring_virtqueue *vq)
+{
+	struct virtio_device *vdev = vq->vq.vdev;
+	int size, i;
+
+	memset(vq->packed.vring.device, 0, vq->packed.event_size_in_bytes);
+	memset(vq->packed.vring.driver, 0, vq->packed.event_size_in_bytes);
+	memset(vq->packed.vring.desc, 0, vq->packed.ring_size_in_bytes);
+
+	size = sizeof(struct vring_desc_state_packed) * vq->packed.vring.num;
+	memset(vq->packed.desc_state, 0, size);
+
+	size = sizeof(struct vring_desc_extra) * vq->packed.vring.num;
+	memset(vq->packed.desc_extra, 0, size);
+
+	for (i = 0; i < vq->packed.vring.num - 1; i++)
+		vq->packed.desc_extra[i].next = i + 1;
+
+	vring_virtqueue_init_packed(vq, vdev);
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
