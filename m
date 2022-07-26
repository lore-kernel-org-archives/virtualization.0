Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E33C43334
	for <virtualization@archiver.kernel.org>; Tue, 26 Jul 2022 07:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 09CAF41041;
	Tue, 26 Jul 2022 07:22:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 09CAF41041
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mQAifSOdEfa9; Tue, 26 Jul 2022 07:22:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 67F9640B80;
	Tue, 26 Jul 2022 07:22:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 67F9640B80
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A6AEC0033;
	Tue, 26 Jul 2022 07:22:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45D53C007E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9FF8C83FA9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9FF8C83FA9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zaTF0Gt6B0Jz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3235A83FA3
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3235A83FA3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 07:22:35 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=37; SR=0; TI=SMTPD_---0VKUOEOC_1658820147; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VKUOEOC_1658820147) by smtp.aliyun-inc.com;
 Tue, 26 Jul 2022 15:22:28 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v13 01/42] virtio: record the maximum queue num supported by
 the device.
Date: Tue, 26 Jul 2022 15:21:44 +0800
Message-Id: <20220726072225.19884-2-xuanzhuo@linux.alibaba.com>
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

virtio-net can display the maximum (supported by hardware) ring size in
ethtool -g eth0.

When the subsequent patch implements vring reset, it can judge whether
the ring size passed by the driver is legal based on this.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 arch/um/drivers/virtio_uml.c             | 1 +
 drivers/platform/mellanox/mlxbf-tmfifo.c | 2 ++
 drivers/remoteproc/remoteproc_virtio.c   | 2 ++
 drivers/s390/virtio/virtio_ccw.c         | 3 +++
 drivers/virtio/virtio_mmio.c             | 2 ++
 drivers/virtio/virtio_pci_legacy.c       | 2 ++
 drivers/virtio/virtio_pci_modern.c       | 2 ++
 drivers/virtio/virtio_vdpa.c             | 2 ++
 include/linux/virtio.h                   | 2 ++
 9 files changed, 18 insertions(+)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 82ff3785bf69..e719af8bdf56 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -958,6 +958,7 @@ static struct virtqueue *vu_setup_vq(struct virtio_device *vdev,
 		goto error_create;
 	}
 	vq->priv = info;
+	vq->num_max = num;
 	num = virtqueue_get_vring_size(vq);
 
 	if (vu_dev->protocol_features &
diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 38800e86ed8a..1ae3c56b66b0 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -959,6 +959,8 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 			goto error;
 		}
 
+		vq->num_max = vring->num;
+
 		vqs[i] = vq;
 		vring->vq = vq;
 		vq->priv = vring;
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index d43d74733f0a..0f7706e23eb9 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -125,6 +125,8 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 		return ERR_PTR(-ENOMEM);
 	}
 
+	vq->num_max = num;
+
 	rvring->vq = vq;
 	vq->priv = rvring;
 
diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 161d3b141f0d..6b86d0280d6b 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -530,6 +530,9 @@ static struct virtqueue *virtio_ccw_setup_vq(struct virtio_device *vdev,
 		err = -ENOMEM;
 		goto out_err;
 	}
+
+	vq->num_max = info->num;
+
 	/* it may have been reduced */
 	info->num = virtqueue_get_vring_size(vq);
 
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 083ff1eb743d..a20d5a6b5819 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -403,6 +403,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 		goto error_new_virtqueue;
 	}
 
+	vq->num_max = num;
+
 	/* Activate the queue */
 	writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
 	if (vm_dev->version == 1) {
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index a5e5721145c7..2257f1b3d8ae 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -135,6 +135,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
+	vq->num_max = num;
+
 	q_pfn = virtqueue_get_desc_addr(vq) >> VIRTIO_PCI_QUEUE_ADDR_SHIFT;
 	if (q_pfn >> 32) {
 		dev_err(&vp_dev->pci_dev->dev,
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 623906b4996c..e7e0b8c850f6 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -218,6 +218,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
+	vq->num_max = num;
+
 	/* activate the queue */
 	vp_modern_set_queue_size(mdev, index, virtqueue_get_vring_size(vq));
 	vp_modern_queue_address(mdev, index, virtqueue_get_desc_addr(vq),
diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index c40f7deb6b5a..9670cc79371d 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -183,6 +183,8 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 		goto error_new_virtqueue;
 	}
 
+	vq->num_max = max_num;
+
 	/* Setup virtqueue callback */
 	cb.callback = callback ? virtio_vdpa_virtqueue_cb : NULL;
 	cb.private = info;
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index d8fdf170637c..129bde7521e3 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -19,6 +19,7 @@
  * @priv: a pointer for the virtqueue implementation to use.
  * @index: the zero-based ordinal number for this queue.
  * @num_free: number of elements we expect to be able to fit.
+ * @num_max: the maximum number of elements supported by the device.
  *
  * A note on @num_free: with indirect buffers, each buffer needs one
  * element in the queue, otherwise a buffer will need one element per
@@ -31,6 +32,7 @@ struct virtqueue {
 	struct virtio_device *vdev;
 	unsigned int index;
 	unsigned int num_free;
+	unsigned int num_max;
 	void *priv;
 };
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
