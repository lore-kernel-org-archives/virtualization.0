Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2FEC433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 12:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DABEC408CB;
	Wed,  9 Feb 2022 12:29:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hfLwyamQmCNL; Wed,  9 Feb 2022 12:29:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 494EB4093A;
	Wed,  9 Feb 2022 12:29:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 174F3C007B;
	Wed,  9 Feb 2022 12:29:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C358FC0021
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AC4B660F38
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S_RbnGhwuwF0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99DB460F49
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R961e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V4.E4DR_1644409750; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4.E4DR_1644409750) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 20:29:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/14] virtio_pci: queue_reset: release vq by vp_dev->vqs
Date: Wed,  9 Feb 2022 20:28:58 +0800
Message-Id: <20220209122901.51790-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
References: <20220209122901.51790-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

In the process of queue reset, vq leaves vdev->vqs, so the original
processing logic may miss some vq. So modify the processing method of
releasing vq. Release vq by listing vqs.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_common.c | 22 ++++++++++++++++++----
 drivers/virtio/virtio_pci_common.h |  2 ++
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index fdbde1db5ec5..6b2573ec1ae8 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -260,12 +260,20 @@ static void vp_del_vq(struct virtqueue *vq)
 void vp_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtqueue *vq, *n;
-	int i;
+	struct virtio_pci_vq_info *info;
+	struct virtqueue *vq;
+	int i, v;
+
+	for (i = 0; i < vp_dev->nvqs; ++i) {
+
+		info = vp_dev->vqs[i];
+		if (!info)
+			continue;
+
+		vq = info->vq;
 
-	list_for_each_entry_safe(vq, n, &vdev->vqs, list) {
 		if (vp_dev->per_vq_vectors) {
-			int v = vp_dev->vqs[vq->index]->msix_vector;
+			v = info->msix_vector;
 
 			if (v != VIRTIO_MSI_NO_VECTOR) {
 				int irq = pci_irq_vector(vp_dev->pci_dev, v);
@@ -275,6 +283,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 			}
 		}
 		vp_del_vq(vq);
+		vp_dev->vqs[i] = NULL;
 	}
 	vp_dev->per_vq_vectors = false;
 
@@ -308,6 +317,7 @@ void vp_del_vqs(struct virtio_device *vdev)
 	vp_dev->msix_affinity_masks = NULL;
 	kfree(vp_dev->vqs);
 	vp_dev->vqs = NULL;
+	vp_dev->nvqs = 0;
 }
 
 static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
@@ -324,6 +334,8 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 	if (!vp_dev->vqs)
 		return -ENOMEM;
 
+	vp_dev->nvqs = nvqs;
+
 	if (per_vq_vectors) {
 		/* Best option: one for change interrupt, one per vq. */
 		nvectors = 1;
@@ -395,6 +407,8 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 	if (!vp_dev->vqs)
 		return -ENOMEM;
 
+	vp_dev->nvqs = nvqs;
+
 	err = request_irq(vp_dev->pci_dev->irq, vp_interrupt, IRQF_SHARED,
 			dev_name(&vdev->dev), vp_dev);
 	if (err)
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 23f6c5c678d5..392d990b7c73 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -60,6 +60,8 @@ struct virtio_pci_device {
 	/* array of all queues for house-keeping */
 	struct virtio_pci_vq_info **vqs;
 
+	u32 nvqs;
+
 	/* MSI-X support */
 	int msix_enabled;
 	int intx_enabled;
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
