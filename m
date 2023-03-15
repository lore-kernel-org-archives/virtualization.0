Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08191C61DA4
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 16:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5939A41901;
	Wed, 15 Mar 2023 16:14:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5939A41901
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ONvgv8wX;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ScdUyn7T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id p1ulutPb_36k; Wed, 15 Mar 2023 16:14:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 75D7A4161F;
	Wed, 15 Mar 2023 16:14:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75D7A4161F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94A37C008E;
	Wed, 15 Mar 2023 16:14:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 76D46C0035
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3B5EC60F34
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3B5EC60F34
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=ONvgv8wX; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ScdUyn7T
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 50k-uu8fgnNB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 51C0E60B1A
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 51C0E60B1A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:46 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7DCA2219D2;
 Wed, 15 Mar 2023 16:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678896884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eTpDVoMSd93qEAO9SAHyeliiS1wClvZbyimukwJNAAQ=;
 b=ONvgv8wXwgoWiaJ9wJzmTsu8V/4yD+sfxN3QPsHhyivP2MqNAC2gUO95aUlXYhVDoFBJRd
 6MS2pSiAAq+jpCCiyHaKAj79ZqwPNMVq/tFBa4qPS6UpV+pV6/p2WgPChwu57J0zzQ8EkZ
 1+SQAiZ3X/SdOmX0sukd5fs7VLQOdCY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678896884;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eTpDVoMSd93qEAO9SAHyeliiS1wClvZbyimukwJNAAQ=;
 b=ScdUyn7TcZAXSbPzkKqltC61Al00k5Wddgb13LSdUzpx2aYL8NInDATavZtNWChNcDABkK
 gHj5X+WkRg2RfiAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4568913A2F;
 Wed, 15 Mar 2023 16:14:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wDQPEPTuEWTrAwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Mar 2023 16:14:44 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, zackr@vmware.com, kraxel@redhat.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-graphics-maintainer@vmware.com
Subject: [PATCH 3/6] drm/fb-helper: Export drm_fb_helper_release_info()
Date: Wed, 15 Mar 2023 17:14:39 +0100
Message-Id: <20230315161442.27318-4-tzimmermann@suse.de>
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

Export the fb_info release code as drm_fb_helper_release_info(). Will
help with cleaning up failed fbdev probing.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
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
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
