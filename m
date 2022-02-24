Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E81C433EF
	for <virtualization@archiver.kernel.org>; Thu, 24 Feb 2022 08:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BBF1A409CE;
	Thu, 24 Feb 2022 08:11:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QFO4cmGAlIGv; Thu, 24 Feb 2022 08:11:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EE313404B7;
	Thu, 24 Feb 2022 08:11:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6823C0021;
	Thu, 24 Feb 2022 08:11:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DFF3C0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1A71D60FE7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pi2cT-qXuTXz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A0F8760BED
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Feb 2022 08:11:15 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R471e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=34; SR=0; TI=SMTPD_---0V5NDo6n_1645690268; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V5NDo6n_1645690268) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Feb 2022 16:11:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v6 03/26] virtio: add helper virtqueue_get_vring_max_size()
Date: Thu, 24 Feb 2022 16:10:39 +0800
Message-Id: <20220224081102.80224-4-xuanzhuo@linux.alibaba.com>
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

Record the maximum queue num supported by the device.

virtio-net can display the maximum (supported by hardware) ring size in
ethtool -g eth0.

When the subsequent patch implements vring reset, it can judge whether
the ring size passed by the driver is legal based on this.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_mmio.c       |  2 ++
 drivers/virtio/virtio_pci_legacy.c |  2 ++
 drivers/virtio/virtio_pci_modern.c |  2 ++
 drivers/virtio/virtio_ring.c       | 14 ++++++++++++++
 include/linux/virtio.h             |  2 ++
 5 files changed, 22 insertions(+)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 56128b9c46eb..a41abc8051b9 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -390,6 +390,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned index,
 		goto error_new_virtqueue;
 	}
 
+	vq->num_max = num;
+
 	/* Activate the queue */
 	writel(virtqueue_get_vring_size(vq), vm_dev->base + VIRTIO_MMIO_QUEUE_NUM);
 	if (vm_dev->version == 1) {
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 34141b9abe27..b68934fe6b5d 100644
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
index 5455bc041fb6..86d301f272b8 100644
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
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 962f1477b1fa..b87130c8f312 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2371,6 +2371,20 @@ void vring_transport_features(struct virtio_device *vdev)
 }
 EXPORT_SYMBOL_GPL(vring_transport_features);
 
+/**
+ * virtqueue_get_vring_max_size - return the max size of the virtqueue's vring
+ * @_vq: the struct virtqueue containing the vring of interest.
+ *
+ * Returns the max size of the vring.
+ *
+ * Unlike other operations, this need not be serialized.
+ */
+unsigned int virtqueue_get_vring_max_size(struct virtqueue *_vq)
+{
+	return _vq->num_max;
+}
+EXPORT_SYMBOL_GPL(virtqueue_get_vring_max_size);
+
 /**
  * virtqueue_get_vring_size - return the size of the virtqueue's vring
  * @_vq: the struct virtqueue containing the vring of interest.
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 72292a62cd90..d59adc4be068 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -31,6 +31,7 @@ struct virtqueue {
 	struct virtio_device *vdev;
 	unsigned int index;
 	unsigned int num_free;
+	unsigned int num_max;
 	void *priv;
 };
 
@@ -80,6 +81,7 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *vq);
 
 void *virtqueue_detach_unused_buf(struct virtqueue *vq);
 
+unsigned int virtqueue_get_vring_max_size(struct virtqueue *vq);
 unsigned int virtqueue_get_vring_size(struct virtqueue *vq);
 
 bool virtqueue_is_broken(struct virtqueue *vq);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
