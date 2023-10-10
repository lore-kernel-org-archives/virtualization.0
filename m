Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF2FCD68E4
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 03:11:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B334F416B5;
	Tue, 10 Oct 2023 03:11:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B334F416B5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8fjgKL56yuwS; Tue, 10 Oct 2023 03:11:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id F1DD04168B;
	Tue, 10 Oct 2023 03:11:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1DD04168B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C84FCC0039;
	Tue, 10 Oct 2023 03:11:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0498EC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 03:11:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CD4E460C16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 03:11:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD4E460C16
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DNZQdROFpwx2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 03:11:30 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com
 (out30-112.freemail.mail.aliyun.com [115.124.30.112])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6361060BD4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 03:11:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6361060BD4
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R391e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=4; SR=0;
 TI=SMTPD_---0Vtr5Hjd_1696907482; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vtr5Hjd_1696907482) by smtp.aliyun-inc.com;
 Tue, 10 Oct 2023 11:11:23 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH vhost v3 2/4] virtio_pci: fix the common cfg map size
Date: Tue, 10 Oct 2023 11:11:18 +0800
Message-Id: <20231010031120.81272-3-xuanzhuo@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20231010031120.81272-1-xuanzhuo@linux.alibaba.com>
References: <20231010031120.81272-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
X-Git-Hash: e40d16fdf29a
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

The function vp_modern_map_capability() takes the size parameter,
which corresponds to the size of virtio_pci_common_cfg. As a result,
this indicates the size of memory area to map.

Now the size is the size of virtio_pci_common_cfg, but some feature(such
as the _F_RING_RESET) needs the virtio_pci_modern_common_cfg, so this
commit changes the size to the size of virtio_pci_modern_common_cfg.

Fixes: 0b50cece0b78 ("virtio_pci: introduce helper to get/set queue reset")
Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index aad7d9296e77..9cb601e16688 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -291,7 +291,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 	err = -EINVAL;
 	mdev->common = vp_modern_map_capability(mdev, common,
 				      sizeof(struct virtio_pci_common_cfg), 4,
-				      0, sizeof(struct virtio_pci_common_cfg),
+				      0, sizeof(struct virtio_pci_modern_common_cfg),
 				      NULL, NULL);
 	if (!mdev->common)
 		goto err_map_common;
-- 
2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
