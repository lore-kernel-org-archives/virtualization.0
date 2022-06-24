Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7F1CCA480
	for <virtualization@archiver.kernel.org>; Fri, 24 Jun 2022 02:57:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B6A283F3F;
	Fri, 24 Jun 2022 02:57:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3B6A283F3F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jGT65sgKOUh7; Fri, 24 Jun 2022 02:57:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A1B5184827;
	Fri, 24 Jun 2022 02:57:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1B5184827
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AD86C0082;
	Fri, 24 Jun 2022 02:57:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84892C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:57:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5AF5A42552
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:57:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5AF5A42552
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y1dzRCNv11sL
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:57:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8105A4257A
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8105A4257A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Jun 2022 02:57:44 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046060;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=37; SR=0;
 TI=SMTPD_---0VHEo9Sy_1656039456; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VHEo9Sy_1656039456) by smtp.aliyun-inc.com;
 Fri, 24 Jun 2022 10:57:37 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v10 33/41] virtio_pci: support the arg sizes of find_vqs()
Date: Fri, 24 Jun 2022 10:56:13 +0800
Message-Id: <20220624025621.128843-34-xuanzhuo@linux.alibaba.com>
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

Virtio PCI supports new parameter sizes of find_vqs().

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_common.c | 18 ++++++++++--------
 drivers/virtio/virtio_pci_common.h |  1 +
 drivers/virtio/virtio_pci_legacy.c |  6 +++++-
 drivers/virtio/virtio_pci_modern.c | 10 +++++++---
 4 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 7ad734584823..00ad476a815d 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -174,6 +174,7 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int index,
 				     void (*callback)(struct virtqueue *vq),
 				     const char *name,
+				     u32 size,
 				     bool ctx,
 				     u16 msix_vec)
 {
@@ -186,7 +187,7 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int in
 	if (!info)
 		return ERR_PTR(-ENOMEM);
 
-	vq = vp_dev->setup_vq(vp_dev, info, index, callback, name, ctx,
+	vq = vp_dev->setup_vq(vp_dev, info, index, callback, name, size, ctx,
 			      msix_vec);
 	if (IS_ERR(vq))
 		goto out_info;
@@ -283,7 +284,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], bool per_vq_vectors,
+		const char * const names[], u32 sizes[], bool per_vq_vectors,
 		const bool *ctx,
 		struct irq_affinity *desc)
 {
@@ -326,8 +327,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 		else
 			msix_vec = VP_MSIX_VQ_VECTOR;
 		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
-				     ctx ? ctx[i] : false,
-				     msix_vec);
+				     sizes ? sizes[i] : 0,
+				     ctx ? ctx[i] : false, msix_vec);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
@@ -357,7 +358,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned int nvqs,
 
 static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
-		const char * const names[], const bool *ctx)
+		const char * const names[], u32 sizes[], const bool *ctx)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	int i, err, queue_idx = 0;
@@ -379,6 +380,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned int nvqs,
 			continue;
 		}
 		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
+				     sizes ? sizes[i] : 0,
 				     ctx ? ctx[i] : false,
 				     VIRTIO_MSI_NO_VECTOR);
 		if (IS_ERR(vqs[i])) {
@@ -402,15 +404,15 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	int err;
 
 	/* Try MSI-X with one vector per queue. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, true, ctx, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, sizes, true, ctx, desc);
 	if (!err)
 		return 0;
 	/* Fallback: MSI-X with one vector for config, one shared for queues. */
-	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, false, ctx, desc);
+	err = vp_find_vqs_msix(vdev, nvqs, vqs, callbacks, names, sizes, false, ctx, desc);
 	if (!err)
 		return 0;
 	/* Finally fall back to regular interrupts. */
-	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, ctx);
+	return vp_find_vqs_intx(vdev, nvqs, vqs, callbacks, names, sizes, ctx);
 }
 
 const char *vp_bus_name(struct virtio_device *vdev)
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index a5ff838b85a5..c0448378b698 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -80,6 +80,7 @@ struct virtio_pci_device {
 				      unsigned int idx,
 				      void (*callback)(struct virtqueue *vq),
 				      const char *name,
+				      u32 size,
 				      bool ctx,
 				      u16 msix_vec);
 	void (*del_vq)(struct virtio_pci_vq_info *info);
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index 2257f1b3d8ae..d75e5c4e637f 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -112,6 +112,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  unsigned int index,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
+				  u32 size,
 				  bool ctx,
 				  u16 msix_vec)
 {
@@ -125,10 +126,13 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!num || vp_legacy_get_queue_enable(&vp_dev->ldev, index))
 		return ERR_PTR(-ENOENT);
 
+	if (!size || size > num)
+		size = num;
+
 	info->msix_vector = msix_vec;
 
 	/* create the vring */
-	vq = vring_create_virtqueue(index, num,
+	vq = vring_create_virtqueue(index, size,
 				    VIRTIO_PCI_VRING_ALIGN, &vp_dev->vdev,
 				    true, false, ctx,
 				    vp_notify, callback, name);
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index ed30c98f01ac..8d960d230e08 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -297,6 +297,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  unsigned int index,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
+				  u32 size,
 				  bool ctx,
 				  u16 msix_vec)
 {
@@ -314,15 +315,18 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
 
-	if (num & (num - 1)) {
-		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
+	if (!size || size > num)
+		size = num;
+
+	if (size & (size - 1)) {
+		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", size);
 		return ERR_PTR(-EINVAL);
 	}
 
 	info->msix_vector = msix_vec;
 
 	/* create the vring */
-	vq = vring_create_virtqueue(index, num,
+	vq = vring_create_virtqueue(index, size,
 				    SMP_CACHE_BYTES, &vp_dev->vdev,
 				    true, true, ctx,
 				    vp_notify, callback, name);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
