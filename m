Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E786E95A67
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 07:45:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0FB5F41919;
	Sun,  8 Oct 2023 07:45:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0FB5F41919
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yn2ad-lkbQnQ; Sun,  8 Oct 2023 07:45:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F7A5414E4;
	Sun,  8 Oct 2023 07:45:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F7A5414E4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0CAC0C0071;
	Sun,  8 Oct 2023 07:45:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78777C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 07:45:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 40F5E61084
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 07:45:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 40F5E61084
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3zOPUTdWPbSy
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 07:45:43 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6023261057
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 07:45:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6023261057
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VtdYxsB_1696751136; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VtdYxsB_1696751136) by smtp.aliyun-inc.com;
 Sun, 08 Oct 2023 15:45:36 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v1 1/2] virtio_pci: fix the common map size and add
 check for vq-reset
Date: Sun,  8 Oct 2023 15:45:34 +0800
Message-Id: <20231008074535.102871-2-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231008074535.102871-1-xuanzhuo@linux.alibaba.com>
References: <20231008074535.102871-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 13d22f15596c
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
which corresponds to the size of virtio_pci_common_cfg. As a result,
this indicates the size of memory area to map.

However, if the _F_RING_RESET is negotiated, the extra items will be
used. Therefore, we need to use the size of virtio_pci_modre_common_cfg
to map more space.

Meanwhile, this patch checks the common cfg size when _F_RING_ERSET is
negotiated.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 27 ++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index aad7d9296e77..45d41e6c7799 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <linux/virtio_pci_modern.h>
+#include <linux/virtio_config.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
@@ -142,6 +143,22 @@ static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
 	return 0;
 }
 
+static inline int check_common_size(struct virtio_pci_modern_device *mdev,
+				     size_t common_len)
+{
+	u64 features;
+
+	features = vp_modern_get_features(mdev);
+
+	if (features & BIT_ULL(VIRTIO_F_RING_RESET)) {
+		if (unlikely(common_len < offsetofend(struct virtio_pci_modern_common_cfg,
+						      queue_reset)))
+			return -ENOENT;
+	}
+
+	return 0;
+}
+
 /* This is part of the ABI.  Don't screw with it. */
 static inline void check_offsets(void)
 {
@@ -218,6 +235,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	int err, common, isr, notify, device;
 	u32 notify_length;
 	u32 notify_offset;
+	size_t common_len;
 	int devid;
 
 	check_offsets();
@@ -291,10 +309,14 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	err = -EINVAL;
 	mdev->common = vp_modern_map_capability(mdev, common,
 				      sizeof(struct virtio_pci_common_cfg), 4,
-				      0, sizeof(struct virtio_pci_common_cfg),
-				      NULL, NULL);
+				      0, sizeof(struct virtio_pci_modern_common_cfg),
+				      &common_len, NULL);
 	if (!mdev->common)
 		goto err_map_common;
+
+	if (check_common_size(mdev, common_len))
+		goto err_common_size;
+
 	mdev->isr = vp_modern_map_capability(mdev, isr, sizeof(u8), 1,
 					     0, 1,
 					     NULL, NULL);
@@ -353,6 +375,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 err_map_notify:
 	pci_iounmap(pci_dev, mdev->isr);
 err_map_isr:
+err_common_size:
 	pci_iounmap(pci_dev, mdev->common);
 err_map_common:
 	pci_release_selected_regions(pci_dev, mdev->modern_bars);
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
