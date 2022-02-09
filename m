Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7261AC433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 12:29:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0207160FD4;
	Wed,  9 Feb 2022 12:29:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1CDUWB1CuFxG; Wed,  9 Feb 2022 12:29:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 87A9660FD7;
	Wed,  9 Feb 2022 12:29:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 589FBC007D;
	Wed,  9 Feb 2022 12:29:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22F02C0011
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 03CC860F49
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LWWiJJzDiZ4s
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0371260FC5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:14 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R691e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V4.YQgn_1644409751; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4.YQgn_1644409751) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 20:29:11 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/14] virtio_pci: queue_reset: setup_vq() support
 vring_setup_virtqueue()
Date: Wed,  9 Feb 2022 20:28:59 +0800
Message-Id: <20220209122901.51790-13-xuanzhuo@linux.alibaba.com>
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

modern setup_vq() replaces vring_create_virtqueue() with
vring_setup_virtqueue()

vp_setup_vq() can pass the original vq(from info->vq) to re-enable vq.

Allow direct calls to vp_setup_vq() in virtio_pci_modern.c

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_common.c | 31 ++++++++++++++++++------------
 drivers/virtio/virtio_pci_common.h |  8 +++++++-
 drivers/virtio/virtio_pci_legacy.c |  4 ++--
 drivers/virtio/virtio_pci_modern.c | 12 ++++++------
 4 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 6b2573ec1ae8..5a4f750a0b97 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -205,28 +205,33 @@ static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
 	return err;
 }
 
-static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned index,
-				     void (*callback)(struct virtqueue *vq),
-				     const char *name,
-				     bool ctx,
-				     u16 msix_vec)
+struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int index,
+			      void (*callback)(struct virtqueue *vq),
+			      const char *name,
+			      bool ctx,
+			      u16 msix_vec)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_vq_info *info = kmalloc(sizeof *info, GFP_KERNEL);
+	struct virtio_pci_vq_info *info;
 	struct virtqueue *vq;
 	unsigned long flags;
 
-	/* fill out our structure that represents an active queue */
-	if (!info)
-		return ERR_PTR(-ENOMEM);
+	info = vp_dev->vqs[index];
+	if (!info) {
+		info = kzalloc(sizeof(*info), GFP_KERNEL);
+
+		/* fill out our structure that represents an active queue */
+		if (!info)
+			return ERR_PTR(-ENOMEM);
+	}
 
 	vq = vp_dev->setup_vq(vp_dev, info, index, callback, name, ctx,
-			      msix_vec);
+			      msix_vec, info->vq);
 	if (IS_ERR(vq))
 		goto out_info;
 
 	info->vq = vq;
-	if (callback) {
+	if (vq->callback) {
 		spin_lock_irqsave(&vp_dev->lock, flags);
 		list_add(&info->node, &vp_dev->virtqueues);
 		spin_unlock_irqrestore(&vp_dev->lock, flags);
@@ -238,7 +243,9 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned index,
 	return vq;
 
 out_info:
-	kfree(info);
+	if (!info->vq)
+		kfree(info);
+
 	return vq;
 }
 
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 392d990b7c73..696e3f6a493b 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -84,7 +84,8 @@ struct virtio_pci_device {
 				      void (*callback)(struct virtqueue *vq),
 				      const char *name,
 				      bool ctx,
-				      u16 msix_vec);
+				      u16 msix_vec,
+				      struct virtqueue *vq);
 	void (*del_vq)(struct virtio_pci_vq_info *info);
 
 	u16 (*config_vector)(struct virtio_pci_device *vp_dev, u16 vector);
@@ -117,6 +118,11 @@ int vp_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 		struct virtqueue *vqs[], vq_callback_t *callbacks[],
 		const char * const names[], const bool *ctx,
 		struct irq_affinity *desc);
+struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int index,
+			      void (*callback)(struct virtqueue *vq),
+			      const char *name,
+			      bool ctx,
+			      u16 msix_vec);
 const char *vp_bus_name(struct virtio_device *vdev);
 
 /* Setup the affinity for a virtqueue:
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index b3f8128b7983..aa28a02d11f2 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -113,9 +113,9 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
 				  bool ctx,
-				  u16 msix_vec)
+				  u16 msix_vec,
+				  struct virtqueue *vq)
 {
-	struct virtqueue *vq;
 	u16 num;
 	int err;
 	u64 q_pfn;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5455bc041fb6..5af82948f0ae 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -187,11 +187,11 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
 				  bool ctx,
-				  u16 msix_vec)
+				  u16 msix_vec,
+				  struct virtqueue *vq)
 {
 
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
-	struct virtqueue *vq;
 	u16 num;
 	int err;
 
@@ -211,10 +211,10 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	info->msix_vector = msix_vec;
 
 	/* create the vring */
-	vq = vring_create_virtqueue(index, num,
-				    SMP_CACHE_BYTES, &vp_dev->vdev,
-				    true, true, ctx,
-				    vp_notify, callback, name);
+	vq = vring_setup_virtqueue(index, num,
+				   SMP_CACHE_BYTES, &vp_dev->vdev,
+				   true, true, ctx,
+				   vp_notify, callback, name, vq);
 	if (!vq)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
