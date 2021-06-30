Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302F0C11F68
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 14:07:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA5F161418
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 14:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA5F161418
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 897DE60787;
	Wed, 30 Jun 2021 14:07:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RjNMM2dYOm4c; Wed, 30 Jun 2021 14:07:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8515F60A5C;
	Wed, 30 Jun 2021 14:07:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 43936C0028;
	Wed, 30 Jun 2021 14:07:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBF99C0010
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 14:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 97385608AB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 14:07:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id arMbrSjGp6JU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 14:07:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BDAC1600B3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 14:07:03 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BFC191FEAB;
 Wed, 30 Jun 2021 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625062021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3nEzMeZqbb4ewi+GPfk/irc8Iv1qfKVTJscFyoUnoQg=;
 b=oPJdLX6lyO6JF4C8anwQtZp61PWrCgZ2V1WtPxFQcmY8jTk76psedE2nlras0VMClOWkWM
 +nco7U6IZunJMmg1ospij3fc0txqg4UJU05E7a6kN/NLWmJpBRbf55GJffGlpSisSh4px2
 iOyfpOjgy8iBQnoTq4gLm2g5R33/Y3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625062021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3nEzMeZqbb4ewi+GPfk/irc8Iv1qfKVTJscFyoUnoQg=;
 b=YqtRSRPM6zHRRVRz79m0va33efiIBKoux38owoLBUyjZyqxBCKhfJ46Es2zWzy3c7ch07X
 4pP46sd1E362lBCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 8B493118DD;
 Wed, 30 Jun 2021 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625062021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3nEzMeZqbb4ewi+GPfk/irc8Iv1qfKVTJscFyoUnoQg=;
 b=oPJdLX6lyO6JF4C8anwQtZp61PWrCgZ2V1WtPxFQcmY8jTk76psedE2nlras0VMClOWkWM
 +nco7U6IZunJMmg1ospij3fc0txqg4UJU05E7a6kN/NLWmJpBRbf55GJffGlpSisSh4px2
 iOyfpOjgy8iBQnoTq4gLm2g5R33/Y3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625062021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3nEzMeZqbb4ewi+GPfk/irc8Iv1qfKVTJscFyoUnoQg=;
 b=YqtRSRPM6zHRRVRz79m0va33efiIBKoux38owoLBUyjZyqxBCKhfJ46Es2zWzy3c7ch07X
 4pP46sd1E362lBCA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id KGsoIYV63GBNDQAALh3uQQ
 (envelope-from <tzimmermann@suse.de>); Wed, 30 Jun 2021 14:07:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com, daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
Subject: [PATCH 3/3] drm/vram-helper: Unexport drm_vram_helper_{alloc,
 release}_mm()
Date: Wed, 30 Jun 2021 16:06:59 +0200
Message-Id: <20210630140659.17623-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210630140659.17623-1-tzimmermann@suse.de>
References: <20210630140659.17623-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
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

All GEM-VRAM-based drivers use auto-cleanup via drmm_vram_helper_init().
Unexport the manual APIs and make them internal implementation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 9 +++------
 include/drm/drm_gem_vram_helper.h     | 4 ----
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 2a1229b8364e..1e9b82e51a07 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -1012,9 +1012,8 @@ static void drm_vram_mm_cleanup(struct drm_vram_mm *vmm)
  * Helpers for integration with struct drm_device
  */
 
-/* deprecated; use drmm_vram_mm_init() */
-struct drm_vram_mm *drm_vram_helper_alloc_mm(
-	struct drm_device *dev, uint64_t vram_base, size_t vram_size)
+static struct drm_vram_mm *drm_vram_helper_alloc_mm(struct drm_device *dev, uint64_t vram_base,
+						    size_t vram_size)
 {
 	int ret;
 
@@ -1036,9 +1035,8 @@ struct drm_vram_mm *drm_vram_helper_alloc_mm(
 	dev->vram_mm = NULL;
 	return ERR_PTR(ret);
 }
-EXPORT_SYMBOL(drm_vram_helper_alloc_mm);
 
-void drm_vram_helper_release_mm(struct drm_device *dev)
+static void drm_vram_helper_release_mm(struct drm_device *dev)
 {
 	if (!dev->vram_mm)
 		return;
@@ -1047,7 +1045,6 @@ void drm_vram_helper_release_mm(struct drm_device *dev)
 	kfree(dev->vram_mm);
 	dev->vram_mm = NULL;
 }
-EXPORT_SYMBOL(drm_vram_helper_release_mm);
 
 static void drm_vram_mm_release(struct drm_device *dev, void *ptr)
 {
diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index f48d181c824b..d3cf06c9af65 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -204,10 +204,6 @@ void drm_vram_mm_debugfs_init(struct drm_minor *minor);
  * Helpers for integration with struct drm_device
  */
 
-struct drm_vram_mm *drm_vram_helper_alloc_mm(
-	struct drm_device *dev, uint64_t vram_base, size_t vram_size);
-void drm_vram_helper_release_mm(struct drm_device *dev);
-
 int drmm_vram_helper_init(struct drm_device *dev, uint64_t vram_base,
 			  size_t vram_size);
 
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
