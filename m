Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C625C4321E
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 12:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2AD8E60FD1;
	Wed,  9 Feb 2022 12:29:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sOAgXxbO3pCO; Wed,  9 Feb 2022 12:29:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B30A460FD6;
	Wed,  9 Feb 2022 12:29:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98DB5C0021;
	Wed,  9 Feb 2022 12:29:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC4F4C0079
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E4862408D4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Yr3K-y6coql1
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 26482404B7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 12:29:15 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R901e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0V4.E4Dp_1644409752; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V4.E4Dp_1644409752) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 20:29:12 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/14] virtio_pci: queue_reset: vp_setup_vq() support
 ring_num
Date: Wed,  9 Feb 2022 20:29:00 +0800
Message-Id: <20220209122901.51790-14-xuanzhuo@linux.alibaba.com>
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

vp_setup_vq() adds parameter ring_num to allow specifying ring num
during setup.

This can be used to implement virtio-net support set_ringparm(ethtool
-G eth0 rx 128 tx 128)

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_common.c | 8 ++++----
 drivers/virtio/virtio_pci_common.h | 5 +++--
 drivers/virtio/virtio_pci_legacy.c | 3 ++-
 drivers/virtio/virtio_pci_modern.c | 9 ++++++++-
 4 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 5a4f750a0b97..cb01eb0cb2e4 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -209,7 +209,7 @@ struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int index,
 			      void (*callback)(struct virtqueue *vq),
 			      const char *name,
 			      bool ctx,
-			      u16 msix_vec)
+			      u16 msix_vec, u16 ring_num)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info;
@@ -226,7 +226,7 @@ struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int index,
 	}
 
 	vq = vp_dev->setup_vq(vp_dev, info, index, callback, name, ctx,
-			      msix_vec, info->vq);
+			      msix_vec, info->vq, ring_num);
 	if (IS_ERR(vq))
 		goto out_info;
 
@@ -375,7 +375,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			msix_vec = VP_MSIX_VQ_VECTOR;
 		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false,
-				     msix_vec);
+				     msix_vec, 0);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
@@ -430,7 +430,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 		}
 		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false,
-				     VIRTIO_MSI_NO_VECTOR);
+				     VIRTIO_MSI_NO_VECTOR, 0);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto out_del_vqs;
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 696e3f6a493b..41051d29152c 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -85,7 +85,8 @@ struct virtio_pci_device {
 				      const char *name,
 				      bool ctx,
 				      u16 msix_vec,
-				      struct virtqueue *vq);
+				      struct virtqueue *vq,
+				      u16 ring_num);
 	void (*del_vq)(struct virtio_pci_vq_info *info);
 
 	u16 (*config_vector)(struct virtio_pci_device *vp_dev, u16 vector);
@@ -122,7 +123,7 @@ struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned int index,
 			      void (*callback)(struct virtqueue *vq),
 			      const char *name,
 			      bool ctx,
-			      u16 msix_vec);
+			      u16 msix_vec, u16 ring_num);
 const char *vp_bus_name(struct virtio_device *vdev);
 
 /* Setup the affinity for a virtqueue:
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index aa28a02d11f2..9bc41b764624 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -114,7 +114,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  const char *name,
 				  bool ctx,
 				  u16 msix_vec,
-				  struct virtqueue *vq)
+				  struct virtqueue *vq,
+				  u16 ring_num)
 {
 	u16 num;
 	int err;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5af82948f0ae..d29d40bf0b45 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -188,7 +188,8 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  const char *name,
 				  bool ctx,
 				  u16 msix_vec,
-				  struct virtqueue *vq)
+				  struct virtqueue *vq,
+				  u16 ring_num)
 {
 
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
@@ -203,6 +204,12 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
 
+	if (ring_num) {
+		if (ring_num > num)
+			return ERR_PTR(-ENOENT);
+		num = ring_num;
+	}
+
 	if (num & (num - 1)) {
 		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
 		return ERR_PTR(-EINVAL);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
