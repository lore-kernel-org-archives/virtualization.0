Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82164C4332F
	for <virtualization@archiver.kernel.org>; Thu, 20 Jan 2022 06:43:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10AED60E22;
	Thu, 20 Jan 2022 06:43:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 969oRrFke6EL; Thu, 20 Jan 2022 06:43:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AA8BA60E2E;
	Thu, 20 Jan 2022 06:43:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54A79C007E;
	Thu, 20 Jan 2022 06:43:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1A527C0039
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EFC5260BF2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V5aAynf9ESSw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8B7EA60BDA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Jan 2022 06:43:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R651e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V2KWFJl_1642660990; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2KWFJl_1642660990) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 20 Jan 2022 14:43:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 06/12] virtio: queue_reset: pci: add independent function
 to enable msix vq
Date: Thu, 20 Jan 2022 14:42:57 +0800
Message-Id: <20220120064303.106639-7-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220120064303.106639-1-xuanzhuo@linux.alibaba.com>
References: <20220120064303.106639-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

Extract the vp_enable_vq_msix() function from vp_find_vqs_msix() . Used
to enable a msix vq individually.

In the subsequent patches that supports queue reset, I have the
need to enable a vq separately.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_common.c | 61 ++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index cb1eec0a6bf3..5afe207ce28a 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -311,6 +311,40 @@ void vp_del_vqs(struct virtio_device *vdev)
 	vp_dev->vqs = NULL;
 }
 
+static struct virtqueue *vp_enable_vq_msix(struct virtio_device *vdev,
+					   int queue_index,
+					   vq_callback_t *callback,
+					   const char * const name,
+					   bool ctx,
+					   u16 msix_vec)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+	struct virtqueue *vq;
+	int err;
+
+	vq = vp_setup_vq(vdev, queue_index, callback, name, ctx, msix_vec);
+	if (IS_ERR(vq))
+		return vq;
+
+	if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
+		return vq;
+
+	/* allocate per-vq irq if available and necessary */
+	snprintf(vp_dev->msix_names[msix_vec],
+		 sizeof *vp_dev->msix_names,
+		 "%s-%s", dev_name(&vp_dev->vdev.dev), name);
+
+	err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
+			  vring_interrupt, IRQF_NO_AUTOEN,
+			  vp_dev->msix_names[msix_vec], vq);
+	if (err) {
+		vp_del_vq(vq);
+		return ERR_PTR(err);
+	}
+
+	return vq;
+}
+
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
 		const char * const names[], bool per_vq_vectors,
@@ -320,6 +354,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	u16 msix_vec;
 	int i, err, nvectors, allocated_vectors, queue_idx = 0;
+	struct virtqueue *vq;
 
 	vp_dev->vqs = kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
 	if (!vp_dev->vqs)
@@ -355,28 +390,14 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			msix_vec = allocated_vectors++;
 		else
 			msix_vec = VP_MSIX_VQ_VECTOR;
-		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
-				     ctx ? ctx[i] : false,
-				     msix_vec);
-		if (IS_ERR(vqs[i])) {
-			err = PTR_ERR(vqs[i]);
-			goto error_find;
-		}
-
-		if (!vp_dev->per_vq_vectors || msix_vec == VIRTIO_MSI_NO_VECTOR)
-			continue;
 
-		/* allocate per-vq irq if available and necessary */
-		snprintf(vp_dev->msix_names[msix_vec],
-			 sizeof *vp_dev->msix_names,
-			 "%s-%s",
-			 dev_name(&vp_dev->vdev.dev), names[i]);
-		err = request_irq(pci_irq_vector(vp_dev->pci_dev, msix_vec),
-				  vring_interrupt, IRQF_NO_AUTOEN,
-				  vp_dev->msix_names[msix_vec],
-				  vqs[i]);
-		if (err)
+		vq = vp_enable_vq_msix(vdev, queue_idx++, callbacks[i],
+				       names[i], ctx ? ctx[i] : false, msix_vec);
+		if (IS_ERR(vq)) {
+			err = PTR_ERR(vq);
 			goto error_find;
+		}
+		vqs[i] = vq;
 	}
 	return 0;
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
