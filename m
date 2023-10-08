Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D1EE95A8F
	for <virtualization@archiver.kernel.org>; Sun,  8 Oct 2023 09:38:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3F05F40583;
	Sun,  8 Oct 2023 09:38:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F05F40583
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UQk9rS_r0sTG; Sun,  8 Oct 2023 09:38:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B344240395;
	Sun,  8 Oct 2023 09:38:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B344240395
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D1FAC0DD2;
	Sun,  8 Oct 2023 09:38:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27072C008C
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 09:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0576F82245
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 09:38:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0576F82245
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CA8Cb_GEd8eP
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 09:38:51 +0000 (UTC)
Received: from out30-97.freemail.mail.aliyun.com
 (out30-97.freemail.mail.aliyun.com [115.124.30.97])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C2B5581F17
 for <virtualization@lists.linux-foundation.org>;
 Sun,  8 Oct 2023 09:38:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C2B5581F17
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045168;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0VtdqEp4_1696757923; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VtdqEp4_1696757923) by smtp.aliyun-inc.com;
 Sun, 08 Oct 2023 17:38:44 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v2 2/2] virtio_pci: add build offset check for the new
 common cfg items
Date: Sun,  8 Oct 2023 17:38:42 +0800
Message-Id: <20231008093842.87131-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231008093842.87131-1-xuanzhuo@linux.alibaba.com>
References: <20231008093842.87131-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: 44354de94c87
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

Add checks to the check_offsets(void) for queue_notify_data and
queue_reset.

Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 33f319da1558..e2a1fe7bb66c 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -203,6 +203,10 @@ static inline void check_offsets(void)
 		     offsetof(struct virtio_pci_common_cfg, queue_used_lo));
 	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_USEDHI !=
 		     offsetof(struct virtio_pci_common_cfg, queue_used_hi));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_NDATA !=
+		     offsetof(struct virtio_pci_modern_common_cfg, queue_notify_data));
+	BUILD_BUG_ON(VIRTIO_PCI_COMMON_Q_RESET !=
+		     offsetof(struct virtio_pci_modern_common_cfg, queue_reset));
 }
 
 /*
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
