Return-Path: <SRS0=jeLh=E6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9018BC56201
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 11:38:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB433206D8
	for <virtualization@archiver.kernel.org>; Tue, 24 Nov 2020 11:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB433206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A43585AE9;
	Tue, 24 Nov 2020 11:38:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eq3ufgjO0HfI; Tue, 24 Nov 2020 11:38:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7CC8185BC8;
	Tue, 24 Nov 2020 11:38:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43EEDC1D9F;
	Tue, 24 Nov 2020 11:38:32 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8DDBC0052
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D507D214EC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23m79ClNt07A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 1B5852107A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Nov 2020 11:38:29 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 78CB5AD7C;
 Tue, 24 Nov 2020 11:38:27 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH 03/15] drm/bochs: Remove references to struct drm_device.pdev
Date: Tue, 24 Nov 2020 12:38:12 +0100
Message-Id: <20201124113824.19994-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124113824.19994-1-tzimmermann@suse.de>
References: <20201124113824.19994-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 amd-gfx@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 spice-devel@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org
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

Using struct drm_device.pdev is deprecated. Convert bochs to struct
drm_device.dev. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 1 -
 drivers/gpu/drm/bochs/bochs_hw.c  | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index fd454225fd19..b469624fe40d 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -121,7 +121,6 @@ static int bochs_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_dev;
 
-	dev->pdev = pdev;
 	pci_set_drvdata(pdev, dev);
 
 	ret = bochs_load(dev);
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index dce4672e3fc8..2d7380a9890e 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -110,7 +110,7 @@ int bochs_hw_load_edid(struct bochs_device *bochs)
 int bochs_hw_init(struct drm_device *dev)
 {
 	struct bochs_device *bochs = dev->dev_private;
-	struct pci_dev *pdev = dev->pdev;
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	unsigned long addr, size, mem, ioaddr, iosize;
 	u16 id;
 
@@ -201,7 +201,7 @@ void bochs_hw_fini(struct drm_device *dev)
 		release_region(VBE_DISPI_IOPORT_INDEX, 2);
 	if (bochs->fb_map)
 		iounmap(bochs->fb_map);
-	pci_release_regions(dev->pdev);
+	pci_release_regions(to_pci_dev(dev->dev));
 	kfree(bochs->edid);
 }
 
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
