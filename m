Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B324ACE7A97
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 03:58:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DD5A60F76;
	Mon, 25 Sep 2023 03:58:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3DD5A60F76
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KZbxn7AUWDto; Mon, 25 Sep 2023 03:58:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AA34960F54;
	Mon, 25 Sep 2023 03:58:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AA34960F54
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8584CC0039;
	Mon, 25 Sep 2023 03:58:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BDCC9C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 03:58:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9903481E3F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 03:58:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9903481E3F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7OYUJFwjE_i5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 03:58:39 +0000 (UTC)
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 99B3481E35
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 03:58:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 99B3481E35
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R791e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VskEg.C_1695614311; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VskEg.C_1695614311) by smtp.aliyun-inc.com;
 Mon, 25 Sep 2023 11:58:31 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH 1/2] virtio_pci: fix the common map size and add check for
 vq-reset
Date: Mon, 25 Sep 2023 11:58:29 +0800
Message-Id: <20230925035830.117710-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20230925035830.117710-1-xuanzhuo@linux.alibaba.com>
References: <20230925035830.117710-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: fc0cf0f2263f
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
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

Now, the function vp_modern_map_capability() takes the size parameter,
which corresponds to the size of virtio_pci_common_cfg. As a result, the
pci_iomap_range() function maps the memory area for
virtio_pci_common_cfg.

However, if the _F_RING_RESET is negotiated, the extra items will be
used. Therefore, we need to use the size of virtio_pci_modre_common_cfg
to map more space.

Meanwhile, I have introduced a new variable called common_len in the
mdev. This allows us to check common_len when accessing the new item of
virtio_pci_modre_common_cfg.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 8 ++++++--
 include/linux/virtio_pci_modern.h      | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index aad7d9296e77..ef6667de1b38 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -291,8 +291,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	err = -EINVAL;
 	mdev->common = vp_modern_map_capability(mdev, common,
 				      sizeof(struct virtio_pci_common_cfg), 4,
-				      0, sizeof(struct virtio_pci_common_cfg),
-				      NULL, NULL);
+				      0, sizeof(struct virtio_pci_modern_common_cfg),
+				      &mdev->common_len, NULL);
 	if (!mdev->common)
 		goto err_map_common;
 	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
@@ -493,6 +493,8 @@ int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
 {
 	struct virtio_pci_modern_common_cfg __iomem *cfg;
 
+	BUG_ON(mdev->common_len < offsetofend(struct virtio_pci_modern_common_cfg, queue_reset));
+
 	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
 
 	vp_iowrite16(index, &cfg->cfg.queue_select);
@@ -509,6 +511,8 @@ void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
 {
 	struct virtio_pci_modern_common_cfg __iomem *cfg;
 
+	BUG_ON(mdev->common_len < offsetofend(struct virtio_pci_modern_common_cfg, queue_reset));
+
 	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
 
 	vp_iowrite16(index, &cfg->cfg.queue_select);
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
index 067ac1d789bc..edf62bae0474 100644
--- a/include/linux/virtio_pci_modern.h
+++ b/include/linux/virtio_pci_modern.h
@@ -28,6 +28,7 @@ struct virtio_pci_modern_device {
 	/* So we can sanity-check accesses. */
 	size_t notify_len;
 	size_t device_len;
+	size_t common_len;
 
 	/* Capability for when we need to map notifications per-vq. */
 	int notify_map_cap;
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
