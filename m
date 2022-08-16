Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3741DC00140
	for <virtualization@archiver.kernel.org>; Tue, 16 Aug 2022 03:06:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B608240586;
	Tue, 16 Aug 2022 03:06:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B608240586
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VTkIC61LI9ke; Tue, 16 Aug 2022 03:06:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4A89A4057A;
	Tue, 16 Aug 2022 03:06:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A89A4057A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 051BFC0032;
	Tue, 16 Aug 2022 03:06:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D16E9C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 03:06:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9007E819D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 03:06:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9007E819D6
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3o4YNkNTfTmD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 03:06:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CF01681489
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CF01681489
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Aug 2022 03:06:04 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R851e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046050;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VMO7ks._1660619159; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VMO7ks._1660619159) by smtp.aliyun-inc.com;
 Tue, 16 Aug 2022 11:05:59 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_pci: use container_of replace type conversion
Date: Tue, 16 Aug 2022 11:05:59 +0800
Message-Id: <20220816030559.111057-1-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-Git-Hash: f15347c5eacc
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

Replace type conversion with container_of() in
vp_modern_set_queue_reset()/vp_modern_get_queue_reset() .
Also combine declarations and assignments.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 869cb46bef96..530c954439de 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -482,12 +482,12 @@ EXPORT_SYMBOL_GPL(vp_modern_set_status);
  */
 int vp_modern_get_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
 {
-	struct virtio_pci_modern_common_cfg __iomem *cfg;
-
-	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	struct virtio_pci_modern_common_cfg __iomem *mcfg =
+		container_of(cfg, struct virtio_pci_modern_common_cfg, cfg);
 
-	vp_iowrite16(index, &cfg->cfg.queue_select);
-	return vp_ioread16(&cfg->queue_reset);
+	vp_iowrite16(index, &cfg->queue_select);
+	return vp_ioread16(&mcfg->queue_reset);
 }
 EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
 
@@ -498,17 +498,17 @@ EXPORT_SYMBOL_GPL(vp_modern_get_queue_reset);
  */
 void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
 {
-	struct virtio_pci_modern_common_cfg __iomem *cfg;
-
-	cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+	struct virtio_pci_modern_common_cfg __iomem *mcfg =
+		container_of(cfg, struct virtio_pci_modern_common_cfg, cfg);
 
-	vp_iowrite16(index, &cfg->cfg.queue_select);
-	vp_iowrite16(1, &cfg->queue_reset);
+	vp_iowrite16(index, &cfg->queue_select);
+	vp_iowrite16(1, &mcfg->queue_reset);
 
-	while (vp_ioread16(&cfg->queue_reset))
+	while (vp_ioread16(&mcfg->queue_reset))
 		msleep(1);
 
-	while (vp_ioread16(&cfg->cfg.queue_enable))
+	while (vp_ioread16(&cfg->queue_enable))
 		msleep(1);
 }
 EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
-- 
2.31.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
