Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B059AC433EF
	for <virtualization@archiver.kernel.org>; Fri, 24 Jun 2022 02:56:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 482CC60E8E;
	Fri, 24 Jun 2022 02:56:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 482CC60E8E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RR38fw6khpts; Fri, 24 Jun 2022 02:56:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9CD7E60BA1;
	Fri, 24 Jun 2022 02:56:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9CD7E60BA1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 853DDC0032;
	Fri, 24 Jun 2022 02:56:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26377C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 024D060E7B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 024D060E7B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QrdvWo_O2NiJ
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3375160BA1
Received: from out30-57.freemail.mail.aliyun.com
 (out30-57.freemail.mail.aliyun.com [115.124.30.57])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3375160BA1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:56:36 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R121e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046051;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VHEuVqg_1656039386; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VHEuVqg_1656039386) by smtp.aliyun-inc.com;
 Fri, 24 Jun 2022 10:56:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v10 02/41] virtio: add helper virtqueue_get_vring_max_size()
Date: Fri, 24 Jun 2022 10:55:42 +0800
Message-Id: <20220624025621.128843-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
References: <20220624025621.128843-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: fef800c86cd2
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

Record the maximum queue num supported by the device.

virtio-net can display the maximum (supported by hardware) ring size in
ethtool -g eth0.

When the subsequent patch implements vring reset, it can judge whether
the ring size passed by the driver is legal based on this.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 arch/um/drivers/virtio_uml.c             |  1 +
 drivers/platform/mellanox/mlxbf-tmfifo.c |  2 ++
 drivers/remoteproc/remoteproc_virtio.c   |  2 ++
 drivers/s390/virtio/virtio_ccw.c         |  3 +++
 drivers/virtio/virtio_mmio.c             |  2 ++
 drivers/virtio/virtio_pci_legacy.c       |  2 ++
 drivers/virtio/virtio_pci_modern.c       |  2 ++
 drivers/virtio/virtio_ring.c             | 14 ++++++++++++++
 drivers/virtio/virtio_vdpa.c             |  2 ++
 include/linux/virtio.h                   |  2 ++
 10 files changed, 32 insertions(+)

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
index 97e51c34e6cf..cbcdba00e7e9 100644
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
index c9bec3813e94..2e7cbbd21043 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -402,6 +402,8 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
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
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 13a7348cedff..68f55336566c 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -2355,6 +2355,20 @@ void vring_transport_features(struct virtio_device *vdev)
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
index d8fdf170637c..a82620032e43 100644
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
