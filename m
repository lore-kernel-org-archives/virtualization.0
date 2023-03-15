Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FAC4C76195
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 16:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0147C81E52;
	Wed, 15 Mar 2023 16:14:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0147C81E52
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=iai/JnA9;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ORCxB5Om
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3jePI0nRmsVs; Wed, 15 Mar 2023 16:14:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6FB5D81E47;
	Wed, 15 Mar 2023 16:14:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FB5D81E47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0417BC0095;
	Wed, 15 Mar 2023 16:14:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D305C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9A6A560B1A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A6A560B1A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=iai/JnA9; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ORCxB5Om
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hEdBmPrlx3kW
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BE5C960F0F
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE5C960F0F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:46 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0B1F31FD83;
 Wed, 15 Mar 2023 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678896885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmMfv1uHqiIVby5iEgDguBu7NfRJpZyZK5Pjh/ujQrw=;
 b=iai/JnA9sEDPOkmmcJs7ddXvfiWQzaeAo5gudB2gL5gaqvlWxrA6+oZyUC3bD1ec9YsCCA
 O8wcnPwWAjT+HWj/nEeBLNUj05A1znoFsxiEblmotvuznMzLdiDaQz2AhX9aAXckVc9RW3
 KadkflZe1pXYWgMhGxRIP1oZaUTmsfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678896885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmMfv1uHqiIVby5iEgDguBu7NfRJpZyZK5Pjh/ujQrw=;
 b=ORCxB5Omzve4tlBuOysi1LbZ5uqC90ntSG1aB6UqI/eRo/kGI6a+iSRXMktbLn9oS4s5fx
 XRLmpYHrMpqRrVAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C57FF13A2F;
 Wed, 15 Mar 2023 16:14:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +N4/L/TuEWTrAwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Mar 2023 16:14:44 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, zackr@vmware.com, kraxel@redhat.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-graphics-maintainer@vmware.com
Subject: [PATCH 5/6] drm/fb-helper: Consolidate CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM
Date: Wed, 15 Mar 2023 17:14:41 +0100
Message-Id: <20230315161442.27318-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315161442.27318-1-tzimmermann@suse.de>
References: <20230315161442.27318-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Thomas Zimmermann <tzimmermann@suse.de>
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

Consolidate all handling of CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM by
making the module parameter optional in drm_fb_helper.c.

Without the config option, modules can set smem_start in struct
fb_info for internal usage, but not export if to userspace. The
address can only be exported by enabling the option and setting
the module parameter. Also update the comment.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fb_helper.c | 22 ++++++++--------------
 drivers/gpu/drm/drm_fbdev_dma.c |  9 +--------
 include/drm/drm_fb_helper.h     |  9 ---------
 3 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 7e96ed9efdb5..b536b472f3ef 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -60,16 +60,17 @@ MODULE_PARM_DESC(drm_fbdev_overalloc,
  * In order to keep user-space compatibility, we want in certain use-cases
  * to keep leaking the fbdev physical address to the user-space program
  * handling the fbdev buffer.
- * This is a bad habit essentially kept into closed source opengl driver
- * that should really be moved into open-source upstream projects instead
- * of using legacy physical addresses in user space to communicate with
- * other out-of-tree kernel modules.
+ *
+ * This is a bad habit, essentially kept to support closed-source OpenGL
+ * drivers that should really be moved into open-source upstream projects
+ * instead of using legacy physical addresses in user space to communicate
+ * with other out-of-tree kernel modules.
  *
  * This module_param *should* be removed as soon as possible and be
  * considered as a broken and legacy behaviour from a modern fbdev device.
  */
-#if IS_ENABLED(CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM)
 static bool drm_leak_fbdev_smem;
+#if IS_ENABLED(CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM)
 module_param_unsafe(drm_leak_fbdev_smem, bool, 0600);
 MODULE_PARM_DESC(drm_leak_fbdev_smem,
 		 "Allow unsafe leaking fbdev physical smem address [default=false]");
@@ -1979,10 +1980,6 @@ static int drm_fb_helper_single_fb_probe(struct drm_fb_helper *fb_helper)
 		return ret;
 	}
 
-#if IS_ENABLED(CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM)
-	fb_helper->hint_leak_smem_start = drm_leak_fbdev_smem;
-#endif
-
 	/* push down into drivers */
 	ret = (*fb_helper->funcs->fb_probe)(fb_helper, &sizes);
 	if (ret < 0)
@@ -2181,11 +2178,8 @@ __drm_fb_helper_initial_config_and_unlock(struct drm_fb_helper *fb_helper)
 
 	info = fb_helper->info;
 	info->var.pixclock = 0;
-	/* Shamelessly allow physical address leaking to userspace */
-#if IS_ENABLED(CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM)
-	if (!fb_helper->hint_leak_smem_start)
-#endif
-		/* don't leak any physical addresses to userspace */
+
+	if (!drm_leak_fbdev_smem)
 		info->flags |= FBINFO_HIDE_SMEM_START;
 
 	/* Need to drop locks to avoid recursive deadlock in
diff --git a/drivers/gpu/drm/drm_fbdev_dma.c b/drivers/gpu/drm/drm_fbdev_dma.c
index cf553ac12a0f..728deffcc0d9 100644
--- a/drivers/gpu/drm/drm_fbdev_dma.c
+++ b/drivers/gpu/drm/drm_fbdev_dma.c
@@ -136,16 +136,9 @@ static int drm_fbdev_dma_helper_fb_probe(struct drm_fb_helper *fb_helper,
 		info->flags |= FBINFO_READS_FAST; /* signal caching */
 	info->screen_size = sizes->surface_height * fb->pitches[0];
 	info->screen_buffer = map.vaddr;
+	info->fix.smem_start = page_to_phys(virt_to_page(info->screen_buffer));
 	info->fix.smem_len = info->screen_size;
 
-#if IS_ENABLED(CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM)
-	/*
-	 * Shamelessly leak the physical address to user-space.
-	 */
-	if (fb_helper->hint_leak_smem_start && !info->fix.smem_start)
-		info->fix.smem_start = page_to_phys(virt_to_page(info->screen_buffer));
-#endif
-
 	return 0;
 
 err_drm_client_buffer_vunmap:
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index c5822ec2fdd1..72032c354a30 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -195,15 +195,6 @@ struct drm_fb_helper {
 	 */
 	int preferred_bpp;
 
-	/**
-	 * @hint_leak_smem_start:
-	 *
-	 * Hint to the fbdev emulation to store the framebuffer's physical
-	 * address in struct &fb_info.fix.smem_start. If the hint is unset,
-	 * the smem_start field should always be cleared to zero.
-	 */
-	bool hint_leak_smem_start;
-
 #ifdef CONFIG_FB_DEFERRED_IO
 	/**
 	 * @fbdefio:
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
