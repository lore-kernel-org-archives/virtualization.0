Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF37AEB64D9
	for <virtualization@archiver.kernel.org>; Fri, 30 Jun 2023 02:37:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37E4941EB0;
	Fri, 30 Jun 2023 02:37:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37E4941EB0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UDWTvT4O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kF-a2h2C5q3v; Fri, 30 Jun 2023 02:37:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 25FCA41E97;
	Fri, 30 Jun 2023 02:37:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25FCA41E97
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD695C0072;
	Fri, 30 Jun 2023 02:37:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9094EC0037
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 02:37:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 570658328E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 02:37:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 570658328E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=UDWTvT4O
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UYQHnWZu0QEq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 02:37:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEE4482293
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EEE4482293
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Jun 2023 02:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688092621; x=1719628621;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=zWpCqTgzd21E/AzUYtJScGd5IATiUO7gwCoJyMaK1LA=;
 b=UDWTvT4OzAzeAy9SASN+6olU73D0cb9sPk/cBCFQ+ObbkWsZhC3kMIwF
 /JD+9hsrK5zrF5yk+sCq18wAURxZ0DXFOqotdka4EBuXmCNqdvqTWJAfX
 h4rlwy5coDgl9IZbUQbKOy6LhCuz4uNRlUWkrFF8+Fd54PJSPEK8W0VKN
 0oF4IA0R5/p6jan4lXXIEPC5PGb+NUe091ZBPC9RXawGKkifJTpS2QpsQ
 +lwMRahVE0dF+klwLec8F1JQTW9QRK3rUGV+wV4IhsrHzV3nM2qjWhZVD
 XtkvQ/hyEYRuS5KyO+MA5x478IRSwLxFC+Bh6Q6+t1o/mVc9ggMIf53w4 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="365776704"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; d="scan'208";a="365776704"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 19:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="964215956"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; d="scan'208";a="964215956"
Received: from lingshan-icx.bj.intel.com ([10.240.192.125])
 by fmsmga006.fm.intel.com with ESMTP; 29 Jun 2023 19:36:59 -0700
From: Zhu Lingshan <lingshan.zhu@intel.com>
To: mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH] vp_vdpa: synchronize irq when free irq
Date: Fri, 30 Jun 2023 18:36:56 +0800
Message-Id: <20230630103656.345870-1-lingshan.zhu@intel.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Cc: Cindy Lu <lulu@redhat.com>, virtualization@lists.linux-foundation.org
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

This commits synchronizes irqs when free them

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Tested-by: Cindy Lu <lulu@redhat.com>
---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index 281287fae89f..d8ee3e68cd2d 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -116,6 +116,7 @@ static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
 	for (i = 0; i < vp_vdpa->queues; i++) {
 		if (vp_vdpa->vring[i].irq != VIRTIO_MSI_NO_VECTOR) {
 			vp_modern_queue_vector(mdev, i, VIRTIO_MSI_NO_VECTOR);
+			synchronize_irq(vp_vdpa->vring[i].irq);
 			devm_free_irq(&pdev->dev, vp_vdpa->vring[i].irq,
 				      &vp_vdpa->vring[i]);
 			vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
@@ -124,6 +125,7 @@ static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
 
 	if (vp_vdpa->config_irq != VIRTIO_MSI_NO_VECTOR) {
 		vp_modern_config_vector(mdev, VIRTIO_MSI_NO_VECTOR);
+		synchronize_irq(vp_vdpa->config_irq);
 		devm_free_irq(&pdev->dev, vp_vdpa->config_irq, vp_vdpa);
 		vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
 	}
-- 
2.39.3

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
