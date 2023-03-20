Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B4BC7618D
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 15:08:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F4BD41781;
	Mon, 20 Mar 2023 15:08:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8F4BD41781
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=WLa/dVrq;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=21l2P8Dp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id snTtZP0HVwBu; Mon, 20 Mar 2023 15:08:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 47554410A0;
	Mon, 20 Mar 2023 15:08:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 47554410A0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A9EDC00A0;
	Mon, 20 Mar 2023 15:08:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2717C0035
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:07:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 847EB40184
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:07:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 847EB40184
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=WLa/dVrq; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=21l2P8Dp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RpBCJIJBUdMg
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:07:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A6357402E5
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A6357402E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:07:56 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 410AB21AC1;
 Mon, 20 Mar 2023 15:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1679324874; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDrGS6vTpomC624UixG7Duf045qZsPbFDoWWn4PkCs4=;
 b=WLa/dVrq4RMvfiKUpr2RaVduaKbc0O0vr/4zBrZM9eo5JuN/3m44AEVB4cyE+lBA/1Owgb
 cQ7QWgLXvE1FzNOl+BhnPAWx9DhDXQwIqK5g7MGKHFl9OcX5kN4soHbilbF5wUa8BjXZJv
 yMSSGnjoVoqJkUvSegiZFXkNwVXZwX0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1679324874;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EDrGS6vTpomC624UixG7Duf045qZsPbFDoWWn4PkCs4=;
 b=21l2P8DpPuOdH8UzmxCSTkMY+NesmR37l0lox0QFNdZ2CRh30d8iQh1mVi1Zqp/+KqWSfd
 6npfixbHVEFPFbCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A9B613A2F;
 Mon, 20 Mar 2023 15:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uN+nAcp2GGTXOgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 20 Mar 2023 15:07:54 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, zackr@vmware.com, kraxel@redhat.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-graphics-maintainer@vmware.com
Subject: [PATCH v2 3/8] drm/fb-helper: Export drm_fb_helper_release_info()
Date: Mon, 20 Mar 2023 16:07:46 +0100
Message-Id: <20230320150751.20399-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230320150751.20399-1-tzimmermann@suse.de>
References: <20230320150751.20399-1-tzimmermann@suse.de>
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

Export the fb_info release code as drm_fb_helper_release_info(). Will
help with cleaning up failed fbdev probing.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Zack Rusin <zackr@vmware.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 33 ++++++++++++++++++++++++---------
 include/drm/drm_fb_helper.h     |  5 +++++
 2 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index a39998047f8a..7e96ed9efdb5 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -538,6 +538,29 @@ struct fb_info *drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper)
 }
 EXPORT_SYMBOL(drm_fb_helper_alloc_info);
 
+/**
+ * drm_fb_helper_release_info - release fb_info and its members
+ * @fb_helper: driver-allocated fbdev helper
+ *
+ * A helper to release fb_info and the member cmap.  Drivers do not
+ * need to release the allocated fb_info structure themselves, this is
+ * automatically done when calling drm_fb_helper_fini().
+ */
+void drm_fb_helper_release_info(struct drm_fb_helper *fb_helper)
+{
+	struct fb_info *info = fb_helper->info;
+
+	if (!info)
+		return;
+
+	fb_helper->info = NULL;
+
+	if (info->cmap.len)
+		fb_dealloc_cmap(&info->cmap);
+	framebuffer_release(info);
+}
+EXPORT_SYMBOL(drm_fb_helper_release_info);
+
 /**
  * drm_fb_helper_unregister_info - unregister fb_info framebuffer device
  * @fb_helper: driver-allocated fbdev helper, can be NULL
@@ -561,8 +584,6 @@ EXPORT_SYMBOL(drm_fb_helper_unregister_info);
  */
 void drm_fb_helper_fini(struct drm_fb_helper *fb_helper)
 {
-	struct fb_info *info;
-
 	if (!fb_helper)
 		return;
 
@@ -574,13 +595,7 @@ void drm_fb_helper_fini(struct drm_fb_helper *fb_helper)
 	cancel_work_sync(&fb_helper->resume_work);
 	cancel_work_sync(&fb_helper->damage_work);
 
-	info = fb_helper->info;
-	if (info) {
-		if (info->cmap.len)
-			fb_dealloc_cmap(&info->cmap);
-		framebuffer_release(info);
-	}
-	fb_helper->info = NULL;
+	drm_fb_helper_release_info(fb_helper);
 
 	mutex_lock(&kernel_fb_helper_lock);
 	if (!list_empty(&fb_helper->kernel_fb_list)) {
diff --git a/include/drm/drm_fb_helper.h b/include/drm/drm_fb_helper.h
index 013654de3fc5..c5822ec2fdd1 100644
--- a/include/drm/drm_fb_helper.h
+++ b/include/drm/drm_fb_helper.h
@@ -256,6 +256,7 @@ int drm_fb_helper_check_var(struct fb_var_screeninfo *var,
 int drm_fb_helper_restore_fbdev_mode_unlocked(struct drm_fb_helper *fb_helper);
 
 struct fb_info *drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper);
+void drm_fb_helper_release_info(struct drm_fb_helper *fb_helper);
 void drm_fb_helper_unregister_info(struct drm_fb_helper *fb_helper);
 void drm_fb_helper_fill_info(struct fb_info *info,
 			     struct drm_fb_helper *fb_helper,
@@ -365,6 +366,10 @@ drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper)
 	return NULL;
 }
 
+static inline void drm_fb_helper_release_info(struct drm_fb_helper *fb_helper)
+{
+}
+
 static inline void drm_fb_helper_unregister_info(struct drm_fb_helper *fb_helper)
 {
 }
-- 
2.40.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
