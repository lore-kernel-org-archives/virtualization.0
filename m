Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B23EC433F5
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 08:11:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B04E9409DB;
	Thu, 24 Feb 2022 08:11:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CZCqdj34ReqO; Thu, 24 Feb 2022 08:11:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0E196409D5;
	Thu, 24 Feb 2022 08:11:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC5FEC0021;
	Thu, 24 Feb 2022 08:11:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32C90C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1DD18831CA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qNlvJBorAiMk
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1EE1B83005
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:28 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=34; SR=0; TI=SMTPD_---0V5NDo9f_1645690281; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V5NDo9f_1645690281) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Feb 2022 16:11:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 09/26] virtio_ring: split: implement
 virtqueue_reset_vring_split()
Date: Thu, 24 Feb 2022 16:10:45 +0800
Message-Id: <20220224081102.80224-10-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220224081102.80224-1-xuanzhuo@linux.alibaba.com>
References: <20220224081102.80224-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: bd1c915e263f
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

In addition, vring_align, may_reduce_num are necessary for reallocating
vring, so they are retained when creating vq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_ring.c | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 0b5360052ac2..a2e771263ea7 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -158,6 +158,12 @@ struct vring_virtqueue {
 			/* DMA address and size information */
 			dma_addr_t queue_dma_addr;
 			size_t queue_size_in_bytes;
+
+			/* The parameters for creating vrings are reserved for
+			 * creating new vrings when enabling reset queue.
+			 */
+			u32 vring_align;
+			bool may_reduce_num;
 		} split;
 
 		/* Available for packed ring */
@@ -217,6 +223,12 @@ struct vring_virtqueue {
 #endif
 };
 
+static void vring_free(struct virtqueue *vq);
+static void __vring_virtqueue_init_split(struct vring_virtqueue *vq,
+					 struct virtio_device *vdev);
+static int __vring_virtqueue_attach_split(struct vring_virtqueue *vq,
+					  struct virtio_device *vdev,
+					  struct vring vring);
 
 /*
  * Helpers.
@@ -1012,6 +1024,8 @@ static struct virtqueue *vring_create_virtqueue_split(
 		return NULL;
 	}
 
+	to_vvq(vq)->split.vring_align = vring_align;
+	to_vvq(vq)->split.may_reduce_num = may_reduce_num;
 	to_vvq(vq)->split.queue_dma_addr = vring.dma_addr;
 	to_vvq(vq)->split.queue_size_in_bytes = vring.queue_size_in_bytes;
 	to_vvq(vq)->we_own_ring = true;
@@ -1019,6 +1033,59 @@ static struct virtqueue *vring_create_virtqueue_split(
 	return vq;
 }
 
+static int virtqueue_reset_vring_split(struct virtqueue *_vq, u32 num)
+{
+	struct vring_virtqueue *vq = to_vvq(_vq);
+	struct virtio_device *vdev = _vq->vdev;
+	struct vring_split vring;
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
+		if (vq->split.vring.num == num || !num)
+			break;
+
+		vring_free(_vq);
+
+		fallthrough;
+
+	case VIRTIO_VQ_RESET_STEP_VRING_RELEASE:
+		if (!num)
+			num = vq->split.vring.num;
+
+		err = vring_create_vring_split(&vring, vdev,
+					       vq->split.vring_align,
+					       vq->weak_barriers,
+					       vq->split.may_reduce_num, num);
+		if (err)
+			return -ENOMEM;
+
+		err = __vring_virtqueue_attach_split(vq, vdev, vring.vring);
+		if (err) {
+			vring_free_queue(vdev, vring.queue_size_in_bytes,
+					 vring.queue,
+					 vring.dma_addr);
+			return -ENOMEM;
+		}
+
+		vq->split.queue_dma_addr = vring.dma_addr;
+		vq->split.queue_size_in_bytes = vring.queue_size_in_bytes;
+	}
+
+	__vring_virtqueue_init_split(vq, vdev);
+	vq->we_own_ring = true;
+	vq->vq.reset = VIRTIO_VQ_RESET_STEP_VRING_ATTACH;
+
+	return 0;
+}
+
 
 /*
  * Packed ring specific functions - *_packed().
@@ -2317,6 +2384,8 @@ static int __vring_virtqueue_attach_split(struct vring_virtqueue *vq,
 static void __vring_virtqueue_init_split(struct vring_virtqueue *vq,
 					 struct virtio_device *vdev)
 {
+	vq->vq.reset = VIRTIO_VQ_RESET_STEP_NONE;
+
 	vq->packed_ring = false;
 	vq->we_own_ring = false;
 	vq->broken = false;
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
