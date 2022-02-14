Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F374C4332F
	for <virtualization@archiver.kernel.org>; Mon, 14 Feb 2022 08:15:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C855040531;
	Mon, 14 Feb 2022 08:15:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NFjjNTN36hl3; Mon, 14 Feb 2022 08:15:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D7E0440500;
	Mon, 14 Feb 2022 08:14:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 961DBC0011;
	Mon, 14 Feb 2022 08:14:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5E81DC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DD54404E0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fgknJBQQtx_D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A33E5404ED
 for <virtualization@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 08:14:55 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V4O5x9Z_1644826469; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4O5x9Z_1644826469) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 14 Feb 2022 16:14:30 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v5 12/22] virtio_pci: queue_reset: setup_vq() support
 vring_setup_virtqueue()
Date: Mon, 14 Feb 2022 16:14:06 +0800
Message-Id: <20220214081416.117695-13-xuanzhuo@linux.alibaba.com>
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
index 34141b9abe27..96ec2b04e97d 100644
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
