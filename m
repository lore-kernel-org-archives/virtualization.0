Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A927C43217
	for <virtualization@archiver.kernel.org>; Mon, 14 Feb 2022 08:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D1A27404F6;
	Mon, 14 Feb 2022 08:14:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fQ3wuOgCJGLQ; Mon, 14 Feb 2022 08:14:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 68FF440493;
	Mon, 14 Feb 2022 08:14:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 50739C0011;
	Mon, 14 Feb 2022 08:14:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73E16C000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 558338175A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NDfkM-AWMXD0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7BF5481551
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:50 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V4Oo2CB_1644826468; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4Oo2CB_1644826468) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Feb 2022 16:14:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 11/22] virtio_pci: queue_reset: release vq by vp_dev->vqs
Date: Mon, 14 Feb 2022 16:14:05 +0800
Message-Id: <20220214081416.117695-12-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
References: <20220214081416.117695-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 24fd8391539b
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
