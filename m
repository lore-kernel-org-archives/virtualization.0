Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E65EC76196
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 16:14:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2CCAA409EF;
	Wed, 15 Mar 2023 16:14:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2CCAA409EF
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=shcCuD1H;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=e+1/Tje0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7IrTQFJwn8DM; Wed, 15 Mar 2023 16:14:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0C7F641904;
	Wed, 15 Mar 2023 16:14:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0C7F641904
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E83D8C0035;
	Wed, 15 Mar 2023 16:14:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52261C009B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2B93760B97
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2B93760B97
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=shcCuD1H; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=e+1/Tje0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gcDovrtlduPX
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2BB9A60F2D
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2BB9A60F2D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:47 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4FA861FD85;
 Wed, 15 Mar 2023 16:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678896885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z05IXSznCqzxYarOOKdj3wI+Y4rkGtYOeM6hvKI86xQ=;
 b=shcCuD1HIOZjIceRRodqKw2j4KS1BYnWyvN3w/dCtx0RD+lM5YNU4rjCZzwrMCgl2xjGLc
 hHW93zGTWUZLKKJ21bYHgvqtZeBNWjan7n2rIrOZbMqilG/gL2Khwwzg498WVsK0AAZDpY
 SRZPkbQhW5Io0Se+PuRq2IQCuXmJqxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678896885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z05IXSznCqzxYarOOKdj3wI+Y4rkGtYOeM6hvKI86xQ=;
 b=e+1/Tje0I7JAXM6wjFYKPQSV177HUxl/vEqj85LErD8vaa9soUbO9EvoFhblQNmCyRBvKW
 7MNI7syEzgZbowBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1029513A7A;
 Wed, 15 Mar 2023 16:14:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2F4CA/XuEWTrAwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Mar 2023 16:14:45 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, zackr@vmware.com, kraxel@redhat.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-graphics-maintainer@vmware.com
Subject: [PATCH 6/6] drm/fbdev-generic: Rename symbols
Date: Wed, 15 Mar 2023 17:14:42 +0100
Message-Id: <20230315161442.27318-7-tzimmermann@suse.de>
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

Rename symbols to match the style of other fbdev-emulation source
code. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fbdev_generic.c | 66 ++++++++++++++---------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
index 0d08ddbe9608..e70e3138a78e 100644
--- a/drivers/gpu/drm/drm_fbdev_generic.c
+++ b/drivers/gpu/drm/drm_fbdev_generic.c
@@ -13,7 +13,7 @@
 #include <drm/drm_fbdev_generic.h>
 
 /* @user: 1=userspace, 0=fbcon */
-static int drm_fbdev_fb_open(struct fb_info *info, int user)
+static int drm_fbdev_generic_fb_open(struct fb_info *info, int user)
 {
 	struct drm_fb_helper *fb_helper = info->par;
 
@@ -24,7 +24,7 @@ static int drm_fbdev_fb_open(struct fb_info *info, int user)
 	return 0;
 }
 
-static int drm_fbdev_fb_release(struct fb_info *info, int user)
+static int drm_fbdev_generic_fb_release(struct fb_info *info, int user)
 {
 	struct drm_fb_helper *fb_helper = info->par;
 
@@ -34,7 +34,7 @@ static int drm_fbdev_fb_release(struct fb_info *info, int user)
 	return 0;
 }
 
-static void drm_fbdev_fb_destroy(struct fb_info *info)
+static void drm_fbdev_generic_fb_destroy(struct fb_info *info)
 {
 	struct drm_fb_helper *fb_helper = info->par;
 	void *shadow = info->screen_buffer;
@@ -52,10 +52,10 @@ static void drm_fbdev_fb_destroy(struct fb_info *info)
 	kfree(fb_helper);
 }
 
-static const struct fb_ops drm_fbdev_fb_ops = {
+static const struct fb_ops drm_fbdev_generic_fb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_open	= drm_fbdev_fb_open,
-	.fb_release	= drm_fbdev_fb_release,
+	.fb_open	= drm_fbdev_generic_fb_open,
+	.fb_release	= drm_fbdev_generic_fb_release,
 	.fb_read	= drm_fb_helper_sys_read,
 	.fb_write	= drm_fb_helper_sys_write,
 	DRM_FB_HELPER_DEFAULT_OPS,
@@ -63,14 +63,14 @@ static const struct fb_ops drm_fbdev_fb_ops = {
 	.fb_copyarea	= drm_fb_helper_sys_copyarea,
 	.fb_imageblit	= drm_fb_helper_sys_imageblit,
 	.fb_mmap	= fb_deferred_io_mmap,
-	.fb_destroy	= drm_fbdev_fb_destroy,
+	.fb_destroy	= drm_fbdev_generic_fb_destroy,
 };
 
 /*
  * This function uses the client API to create a framebuffer backed by a dumb buffer.
  */
-static int drm_fbdev_fb_probe(struct drm_fb_helper *fb_helper,
-			      struct drm_fb_helper_surface_size *sizes)
+static int drm_fbdev_generic_helper_fb_probe(struct drm_fb_helper *fb_helper,
+					     struct drm_fb_helper_surface_size *sizes)
 {
 	struct drm_client_dev *client = &fb_helper->client;
 	struct drm_device *dev = fb_helper->dev;
@@ -109,7 +109,7 @@ static int drm_fbdev_fb_probe(struct drm_fb_helper *fb_helper,
 
 	drm_fb_helper_fill_info(info, fb_helper, sizes);
 
-	info->fbops = &drm_fbdev_fb_ops;
+	info->fbops = &drm_fbdev_generic_fb_ops;
 	info->flags = FBINFO_DEFAULT;
 
 	/* screen */
@@ -141,9 +141,9 @@ static int drm_fbdev_fb_probe(struct drm_fb_helper *fb_helper,
 	return ret;
 }
 
-static void drm_fbdev_damage_blit_real(struct drm_fb_helper *fb_helper,
-				       struct drm_clip_rect *clip,
-				       struct iosys_map *dst)
+static void drm_fbdev_generic_damage_blit_real(struct drm_fb_helper *fb_helper,
+					       struct drm_clip_rect *clip,
+					       struct iosys_map *dst)
 {
 	struct drm_framebuffer *fb = fb_helper->fb;
 	size_t offset = clip->y1 * fb->pitches[0];
@@ -180,8 +180,8 @@ static void drm_fbdev_damage_blit_real(struct drm_fb_helper *fb_helper,
 	}
 }
 
-static int drm_fbdev_damage_blit(struct drm_fb_helper *fb_helper,
-				 struct drm_clip_rect *clip)
+static int drm_fbdev_generic_damage_blit(struct drm_fb_helper *fb_helper,
+					 struct drm_clip_rect *clip)
 {
 	struct drm_client_buffer *buffer = fb_helper->buffer;
 	struct iosys_map map, dst;
@@ -205,7 +205,7 @@ static int drm_fbdev_damage_blit(struct drm_fb_helper *fb_helper,
 		goto out;
 
 	dst = map;
-	drm_fbdev_damage_blit_real(fb_helper, clip, &dst);
+	drm_fbdev_generic_damage_blit_real(fb_helper, clip, &dst);
 
 	drm_client_buffer_vunmap(buffer);
 
@@ -215,7 +215,8 @@ static int drm_fbdev_damage_blit(struct drm_fb_helper *fb_helper,
 	return ret;
 }
 
-static int drm_fbdev_fb_dirty(struct drm_fb_helper *helper, struct drm_clip_rect *clip)
+static int drm_fbdev_generic_helper_fb_dirty(struct drm_fb_helper *helper,
+					     struct drm_clip_rect *clip)
 {
 	struct drm_device *dev = helper->dev;
 	int ret;
@@ -224,7 +225,7 @@ static int drm_fbdev_fb_dirty(struct drm_fb_helper *helper, struct drm_clip_rect
 	if (!(clip->x1 < clip->x2 && clip->y1 < clip->y2))
 		return 0;
 
-	ret = drm_fbdev_damage_blit(helper, clip);
+	ret = drm_fbdev_generic_damage_blit(helper, clip);
 	if (drm_WARN_ONCE(dev, ret, "Damage blitter failed: ret=%d\n", ret))
 		return ret;
 
@@ -237,12 +238,12 @@ static int drm_fbdev_fb_dirty(struct drm_fb_helper *helper, struct drm_clip_rect
 	return 0;
 }
 
-static const struct drm_fb_helper_funcs drm_fb_helper_generic_funcs = {
-	.fb_probe = drm_fbdev_fb_probe,
-	.fb_dirty = drm_fbdev_fb_dirty,
+static const struct drm_fb_helper_funcs drm_fbdev_generic_helper_funcs = {
+	.fb_probe = drm_fbdev_generic_helper_fb_probe,
+	.fb_dirty = drm_fbdev_generic_helper_fb_dirty,
 };
 
-static void drm_fbdev_client_unregister(struct drm_client_dev *client)
+static void drm_fbdev_generic_client_unregister(struct drm_client_dev *client)
 {
 	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
 
@@ -255,14 +256,14 @@ static void drm_fbdev_client_unregister(struct drm_client_dev *client)
 	}
 }
 
-static int drm_fbdev_client_restore(struct drm_client_dev *client)
+static int drm_fbdev_generic_client_restore(struct drm_client_dev *client)
 {
 	drm_fb_helper_lastclose(client->dev);
 
 	return 0;
 }
 
-static int drm_fbdev_client_hotplug(struct drm_client_dev *client)
+static int drm_fbdev_generic_client_hotplug(struct drm_client_dev *client)
 {
 	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
 	struct drm_device *dev = client->dev;
@@ -291,11 +292,11 @@ static int drm_fbdev_client_hotplug(struct drm_client_dev *client)
 	return ret;
 }
 
-static const struct drm_client_funcs drm_fbdev_client_funcs = {
+static const struct drm_client_funcs drm_fbdev_generic_client_funcs = {
 	.owner		= THIS_MODULE,
-	.unregister	= drm_fbdev_client_unregister,
-	.restore	= drm_fbdev_client_restore,
-	.hotplug	= drm_fbdev_client_hotplug,
+	.unregister	= drm_fbdev_generic_client_unregister,
+	.restore	= drm_fbdev_generic_client_restore,
+	.hotplug	= drm_fbdev_generic_client_hotplug,
 };
 
 /**
@@ -321,8 +322,7 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
  *
  * The fbdev is destroyed by drm_dev_unregister().
  */
-void drm_fbdev_generic_setup(struct drm_device *dev,
-			     unsigned int preferred_bpp)
+void drm_fbdev_generic_setup(struct drm_device *dev, unsigned int preferred_bpp)
 {
 	struct drm_fb_helper *fb_helper;
 	int ret;
@@ -333,15 +333,15 @@ void drm_fbdev_generic_setup(struct drm_device *dev,
 	fb_helper = kzalloc(sizeof(*fb_helper), GFP_KERNEL);
 	if (!fb_helper)
 		return;
-	drm_fb_helper_prepare(dev, fb_helper, preferred_bpp, &drm_fb_helper_generic_funcs);
+	drm_fb_helper_prepare(dev, fb_helper, preferred_bpp, &drm_fbdev_generic_helper_funcs);
 
-	ret = drm_client_init(dev, &fb_helper->client, "fbdev", &drm_fbdev_client_funcs);
+	ret = drm_client_init(dev, &fb_helper->client, "fbdev", &drm_fbdev_generic_client_funcs);
 	if (ret) {
 		drm_err(dev, "Failed to register client: %d\n", ret);
 		goto err_drm_client_init;
 	}
 
-	ret = drm_fbdev_client_hotplug(&fb_helper->client);
+	ret = drm_fbdev_generic_client_hotplug(&fb_helper->client);
 	if (ret)
 		drm_dbg_kms(dev, "client hotplug ret=%d\n", ret);
 
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
