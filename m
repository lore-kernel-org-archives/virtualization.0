Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7DEC28CF5
	for <virtualization@archiver.kernel.org>; Wed, 26 Jan 2022 07:35:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66FE860F2C;
	Wed, 26 Jan 2022 07:35:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JJc_QctBuEUH; Wed, 26 Jan 2022 07:35:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F059260EFD;
	Wed, 26 Jan 2022 07:35:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAE08C002D;
	Wed, 26 Jan 2022 07:35:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25326C007F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E79B060EF0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PJQckmIjPn5u
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EEE5C60EDC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 Jan 2022 07:35:50 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V2uPGOq_1643182546; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V2uPGOq_1643182546) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 26 Jan 2022 15:35:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 12/17] virtio_pci: queue_reset: setup_vq use
 vring_setup_virtqueue()
Date: Wed, 26 Jan 2022 15:35:28 +0800
Message-Id: <20220126073533.44994-13-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
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

setup_vq replaces vring_create_virtuque() with vring_setup_virtqueue() to
support the need to enable reset vq.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_common.c |  8 ++++----
 drivers/virtio/virtio_pci_common.h |  4 +++-
 drivers/virtio/virtio_pci_legacy.c |  5 +++--
 drivers/virtio/virtio_pci_modern.c | 20 ++++++++++++++------
 4 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index 6b2573ec1ae8..c02936d29a31 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -209,7 +209,7 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned index,
 				     void (*callback)(struct virtqueue *vq),
 				     const char *name,
 				     bool ctx,
-				     u16 msix_vec)
+				     u16 msix_vec, u16 num)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	struct virtio_pci_vq_info *info = kmalloc(sizeof *info, GFP_KERNEL);
@@ -221,7 +221,7 @@ static struct virtqueue *vp_setup_vq(struct virtio_device *vdev, unsigned index,
 		return ERR_PTR(-ENOMEM);
 
 	vq = vp_dev->setup_vq(vp_dev, info, index, callback, name, ctx,
-			      msix_vec);
+			      msix_vec, NULL, num);
 	if (IS_ERR(vq))
 		goto out_info;
 
@@ -368,7 +368,7 @@ static int vp_find_vqs_msix(struct virtio_device *vdev, unsigned nvqs,
 			msix_vec = VP_MSIX_VQ_VECTOR;
 		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false,
-				     msix_vec);
+				     msix_vec, 0);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto error_find;
@@ -423,7 +423,7 @@ static int vp_find_vqs_intx(struct virtio_device *vdev, unsigned nvqs,
 		}
 		vqs[i] = vp_setup_vq(vdev, queue_idx++, callbacks[i], names[i],
 				     ctx ? ctx[i] : false,
-				     VIRTIO_MSI_NO_VECTOR);
+				     VIRTIO_MSI_NO_VECTOR, 0);
 		if (IS_ERR(vqs[i])) {
 			err = PTR_ERR(vqs[i]);
 			goto out_del_vqs;
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index 392d990b7c73..65db92245e41 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -84,7 +84,9 @@ struct virtio_pci_device {
 				      void (*callback)(struct virtqueue *vq),
 				      const char *name,
 				      bool ctx,
-				      u16 msix_vec);
+				      u16 msix_vec,
+				      struct virtqueue *vq,
+				      u16 num);
 	void (*del_vq)(struct virtio_pci_vq_info *info);
 
 	u16 (*config_vector)(struct virtio_pci_device *vp_dev, u16 vector);
diff --git a/drivers/virtio/virtio_pci_legacy.c b/drivers/virtio/virtio_pci_legacy.c
index b3f8128b7983..9bc41b764624 100644
--- a/drivers/virtio/virtio_pci_legacy.c
+++ b/drivers/virtio/virtio_pci_legacy.c
@@ -113,9 +113,10 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
 				  bool ctx,
-				  u16 msix_vec)
+				  u16 msix_vec,
+				  struct virtqueue *vq,
+				  u16 ring_num)
 {
-	struct virtqueue *vq;
 	u16 num;
 	int err;
 	u64 q_pfn;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 5455bc041fb6..2ce58de549de 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -187,11 +187,12 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 				  void (*callback)(struct virtqueue *vq),
 				  const char *name,
 				  bool ctx,
-				  u16 msix_vec)
+				  u16 msix_vec,
+				  struct virtqueue *vq,
+				  u16 ring_num)
 {
 
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
-	struct virtqueue *vq;
 	u16 num;
 	int err;
 
@@ -203,6 +204,13 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
 
+	if (ring_num) {
+		if (ring_num > num)
+			return ERR_PTR(-ENOENT);
+
+		num = ring_num;
+	}
+
 	if (num & (num - 1)) {
 		dev_warn(&vp_dev->pci_dev->dev, "bad queue size %u", num);
 		return ERR_PTR(-EINVAL);
@@ -211,10 +219,10 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
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
