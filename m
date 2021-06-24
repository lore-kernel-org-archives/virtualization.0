Return-Path: <SRS0=YcCX=LS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC08C48BDF
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 09:05:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04EBD613BE
	for <virtualization@archiver.kernel.org>; Thu, 24 Jun 2021 09:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04EBD613BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B867D60B70;
	Thu, 24 Jun 2021 09:05:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LZgDPWBpsNNu; Thu, 24 Jun 2021 09:05:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0BEFC607DA;
	Thu, 24 Jun 2021 09:05:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD293C0010;
	Thu, 24 Jun 2021 09:05:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 70281C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 09:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62E0E41482
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 09:05:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="A2vOlXQ7";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="qjdg5zwY"; dkim=pass (1024-bit key)
 header.d=suse.de header.b="A2vOlXQ7"; dkim=neutral
 reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="qjdg5zwY"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vjuS4hVua_tz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 09:05:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 365AD406A8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Jun 2021 09:05:05 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6ABE52197D;
 Thu, 24 Jun 2021 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624525502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T5Qe+XA5tUEIi39mYqUowu6I4/Ub2Rn/PDDgcGNwwIY=;
 b=A2vOlXQ7JcR73UdNs8+O0k6o10MNtB8iCnZj2yC43VTG4HgQALN4R4nNsYqsGieP79xA93
 aJ7pxi9TpiC/+5UAi209i698VwlKlIyskhIRkPQa6Yz07h0Y+eq019drKVbTnEhgtA7NuO
 gnGTGGG1t7tVzw5M2cW7UEA0LkDEd7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624525502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T5Qe+XA5tUEIi39mYqUowu6I4/Ub2Rn/PDDgcGNwwIY=;
 b=qjdg5zwY0tPij6ffuVV2eAKh9LKxQIX8mhMVZLebPpWColU0kCK0HLK0FKSq0I+AvJNloq
 YQ2eHq1Qi03lLDAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 43AA911A97;
 Thu, 24 Jun 2021 09:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624525502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T5Qe+XA5tUEIi39mYqUowu6I4/Ub2Rn/PDDgcGNwwIY=;
 b=A2vOlXQ7JcR73UdNs8+O0k6o10MNtB8iCnZj2yC43VTG4HgQALN4R4nNsYqsGieP79xA93
 aJ7pxi9TpiC/+5UAi209i698VwlKlIyskhIRkPQa6Yz07h0Y+eq019drKVbTnEhgtA7NuO
 gnGTGGG1t7tVzw5M2cW7UEA0LkDEd7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624525502;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T5Qe+XA5tUEIi39mYqUowu6I4/Ub2Rn/PDDgcGNwwIY=;
 b=qjdg5zwY0tPij6ffuVV2eAKh9LKxQIX8mhMVZLebPpWColU0kCK0HLK0FKSq0I+AvJNloq
 YQ2eHq1Qi03lLDAQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id /RmrD75K1GCFNQAALh3uQQ
 (envelope-from <tzimmermann@suse.de>); Thu, 24 Jun 2021 09:05:02 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com,
	kraxel@redhat.com,
	daniel@ffwll.ch
Subject: [PATCH] drm/qxl: Remove empty qxl_gem_prime_mmap()
Date: Thu, 24 Jun 2021 11:05:00 +0200
Message-Id: <20210624090500.8320-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Cc: spice-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

The function qxl_gem_prime_mmap() returns an error. The two callers
of gem_prime_mmap are drm_fbdev_fb_mmap() and drm_gem_dmabuf_mmap(),
which both already handle NULL-callbacks with an error code. So clear
gem_prime_mmap in qxl and remove qxl_gem_prime_mmap().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/qxl/qxl_drv.c   | 1 -
 drivers/gpu/drm/qxl/qxl_drv.h   | 2 --
 drivers/gpu/drm/qxl/qxl_prime.c | 6 ------
 3 files changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 854e6c5a563f..b3d75ea7e6b3 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -281,7 +281,6 @@ static struct drm_driver qxl_driver = {
 	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
 	.gem_prime_import_sg_table = qxl_gem_prime_import_sg_table,
-	.gem_prime_mmap = qxl_gem_prime_mmap,
 	.fops = &qxl_fops,
 	.ioctls = qxl_ioctls,
 	.irq_handler = qxl_irq_handler,
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index dd6abee55f56..f95885a8bd2b 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -434,8 +434,6 @@ struct drm_gem_object *qxl_gem_prime_import_sg_table(
 int qxl_gem_prime_vmap(struct drm_gem_object *obj, struct dma_buf_map *map);
 void qxl_gem_prime_vunmap(struct drm_gem_object *obj,
 			  struct dma_buf_map *map);
-int qxl_gem_prime_mmap(struct drm_gem_object *obj,
-				struct vm_area_struct *vma);
 
 /* qxl_irq.c */
 int qxl_irq_init(struct qxl_device *qdev);
diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
index 0628d1cc91fe..4a10cb0a413b 100644
--- a/drivers/gpu/drm/qxl/qxl_prime.c
+++ b/drivers/gpu/drm/qxl/qxl_prime.c
@@ -73,9 +73,3 @@ void qxl_gem_prime_vunmap(struct drm_gem_object *obj,
 
 	qxl_bo_vunmap(bo);
 }
-
-int qxl_gem_prime_mmap(struct drm_gem_object *obj,
-		       struct vm_area_struct *area)
-{
-	return -ENOSYS;
-}
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
