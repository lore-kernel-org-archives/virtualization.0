Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E8EC433EF
	for <virtualization@archiver.kernel.org>; Tue,  8 Mar 2022 12:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2A4EC417A1;
	Tue,  8 Mar 2022 12:35:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id edAOwbKqsOZk; Tue,  8 Mar 2022 12:35:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BE26E417A2;
	Tue,  8 Mar 2022 12:35:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21097C0082;
	Tue,  8 Mar 2022 12:35:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 20CB3C001D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1C25F841FF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cslc9GNPhCiO
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44F5E841F4
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Mar 2022 12:35:45 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=34; SR=0; TI=SMTPD_---0V6ebqUj_1646742940; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6ebqUj_1646742940) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Mar 2022 20:35:41 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v7 10/26] virtio_ring: packed: implement
 virtqueue_reset_vring_packed()
Date: Tue,  8 Mar 2022 20:35:02 +0800
Message-Id: <20220308123518.33800-11-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: f06b131dbfed
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
 Mathieu Poirier <mathieu.poirier@linaro.org>,
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

virtio ring supports reset.

Queue reset is divided into several stages.

1. notify device queue reset
2. vring release
3. attach new vring
4. notify device queue re-enable

After the first step is completed, the vring reset operation can be
performed. If the newly set vring num does not change, then just reset
the vq related value.

Otherwise, the vring will be released and the vring will be reallocated.
And the vring will be attached to the vq. If this process fails, the
function will exit, and the state of the vq will be the vring release
state. You can call this function again to reallocate the vring.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 148fb1fd3d5a..5afcbabcfb1e 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -1886,6 +1886,8 @@ static int vring_virtqueue_attach_packed(struct vring_virtqueue *vq,
 static void vring_virtqueue_init_packed(struct vring_virtqueue *vq,
 					struct virtio_device *vdev)
 {
+	vq->vq.reset = VIRTIO_VQ_RESET_STEP_NONE;
+
 	vq->we_own_ring = true;
 	vq->broken = false;
 	vq->last_used_idx = 0;
@@ -1969,6 +1971,50 @@ static struct virtqueue *vring_create_virtqueue_packed(
 	return NULL;
 }
 
+static int virtqueue_reset_vring_packed(struct virtqueue *_vq, u32 num)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = _vq->vdev;
+	struct vring_packed vring;
+	int err;
+
+	if (num > _vq->num_max)
+		return -E2BIG;
+
+	switch (vq->vq.reset) {
+	case VIRTIO_VQ_RESET_STEP_NONE:
+		return -ENOENT;
+
+	case VIRTIO_VQ_RESET_STEP_VRING_ATTACH:
+	case VIRTIO_VQ_RESET_STEP_DEVICE:
+		if (vq->packed.vring.num == num || !num)
+			break;
+
+		vring_free(_vq);
+
+		fallthrough;
+
+	case VIRTIO_VQ_RESET_STEP_VRING_RELEASE:
+		if (!num)
+			num = vq->packed.vring.num;
+
+		err = vring_create_vring_packed(&vring, vdev, num);
+		if (err)
+			return -ENOMEM;
+
+		err = vring_virtqueue_attach_packed(vq, &vring, vdev);
+		if (err) {
+			vring_free_vring_packed(&vring, vdev);
+			return -ENOMEM;
+		}
+	}
+
+	vring_virtqueue_init_packed(vq, vdev);
+	vq->vq.reset = VIRTIO_VQ_RESET_STEP_VRING_ATTACH;
+
+	return 0;
+}
+
 
 /*
  * Generic functions and exported symbols.
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
