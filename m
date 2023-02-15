Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40AD1C636D4
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 16:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD39C60D5F;
	Wed, 15 Feb 2023 16:15:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DD39C60D5F
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=raA0uq4x;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zEBumgpF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JhKa7qtT3XIG; Wed, 15 Feb 2023 16:15:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3E9B061018;
	Wed, 15 Feb 2023 16:15:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E9B061018
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F134C007D;
	Wed, 15 Feb 2023 16:15:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32B34C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 00E59802D5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 00E59802D5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=raA0uq4x; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=zEBumgpF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gQhumO52pSpu
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 292CC80ADB
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 292CC80ADB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:27 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CBBD533744;
 Wed, 15 Feb 2023 16:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676477722; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyu8khKOgc4qqreKLhcnNC0DSrsoyv00Sw+7FE3xizY=;
 b=raA0uq4xcCy+5rByB5ahKLOjwbNuqv6GwYTgLHw0rUQwnodba7ETLWEUAL9KyxtZZM+PDf
 q0qQkHSjE2tmS94+Df0YdKpn44tw04CKYhND56x1BZc+5t4/kQfousT/HwANSyiZXUI7nu
 dmkBvNlfXLEU/scXXqgUx/5qwbyCI7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676477722;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oyu8khKOgc4qqreKLhcnNC0DSrsoyv00Sw+7FE3xizY=;
 b=zEBumgpFUSdFYWzfsxCo3UIkQEPPloxxshCfrkTdrt0pIeVyp2tXBEqsbyCgr89zB+QLqF
 EdDAzKNS5FBLtDAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED844134BA;
 Wed, 15 Feb 2023 16:15:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ILzxNhkF7WNHOgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Feb 2023 16:15:21 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com, airlied@redhat.com, daniel@ffwll.ch, sam@ravnborg.org,
 javierm@redhat.com, dri-devel@lists.freedesktop.org
Subject: [PATCH 02/17] drm/cirrus: Replace cpp value with format
Date: Wed, 15 Feb 2023 17:15:02 +0100
Message-Id: <20230215161517.5113-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215161517.5113-1-tzimmermann@suse.de>
References: <20230215161517.5113-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
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

Using components per pixel to describe a color format is obsolete.
Use the format info and 4CC value instead.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/cirrus.c | 50 ++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index 7fb21db8416d..67e83fa42a32 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -58,7 +58,7 @@ struct cirrus_device {
 	struct drm_device	       dev;
 	struct drm_simple_display_pipe pipe;
 	struct drm_connector	       conn;
-	unsigned int		       cpp;
+	const struct drm_format_info   *format;
 	unsigned int		       pitch;
 	void __iomem		       *vram;
 	void __iomem		       *mmio;
@@ -126,34 +126,34 @@ static void wreg_hdr(struct cirrus_device *cirrus, u8 val)
 	iowrite8(val, cirrus->mmio + VGA_DAC_MASK);
 }
 
-static int cirrus_convert_to(struct drm_framebuffer *fb)
+static const struct drm_format_info *cirrus_convert_to(struct drm_framebuffer *fb)
 {
-	if (fb->format->cpp[0] == 4 && fb->pitches[0] > CIRRUS_MAX_PITCH) {
+	if (fb->format->format == DRM_FORMAT_XRGB8888 && fb->pitches[0] > CIRRUS_MAX_PITCH) {
 		if (fb->width * 3 <= CIRRUS_MAX_PITCH)
 			/* convert from XR24 to RG24 */
-			return 3;
+			return drm_format_info(DRM_FORMAT_RGB888);
 		else
 			/* convert from XR24 to RG16 */
-			return 2;
+			return drm_format_info(DRM_FORMAT_RGB565);
 	}
-	return 0;
+	return NULL;
 }
 
-static int cirrus_cpp(struct drm_framebuffer *fb)
+static const struct drm_format_info *cirrus_format(struct drm_framebuffer *fb)
 {
-	int convert_cpp = cirrus_convert_to(fb);
+	const struct drm_format_info *format = cirrus_convert_to(fb);
 
-	if (convert_cpp)
-		return convert_cpp;
-	return fb->format->cpp[0];
+	if (format)
+		return format;
+	return fb->format;
 }
 
 static int cirrus_pitch(struct drm_framebuffer *fb)
 {
-	int convert_cpp = cirrus_convert_to(fb);
+	const struct drm_format_info *format = cirrus_convert_to(fb);
 
-	if (convert_cpp)
-		return convert_cpp * fb->width;
+	if (format)
+		return drm_format_info_min_pitch(format, 0, fb->width);
 	return fb->pitches[0];
 }
 
@@ -263,20 +263,20 @@ static int cirrus_mode_set(struct cirrus_device *cirrus,
 	sr07 &= 0xe0;
 	hdr = 0;
 
-	cirrus->cpp = cirrus_cpp(fb);
-	switch (cirrus->cpp * 8) {
-	case 8:
+	cirrus->format = cirrus_format(fb);
+	switch (cirrus->format->format) {
+	case DRM_FORMAT_C8:
 		sr07 |= 0x11;
 		break;
-	case 16:
+	case DRM_FORMAT_RGB565:
 		sr07 |= 0x17;
 		hdr = 0xc1;
 		break;
-	case 24:
+	case DRM_FORMAT_RGB888:
 		sr07 |= 0x15;
 		hdr = 0xc5;
 		break;
-	case 32:
+	case DRM_FORMAT_XRGB8888:
 		sr07 |= 0x19;
 		hdr = 0xc5;
 		break;
@@ -329,13 +329,15 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
 	iosys_map_set_vaddr_iomem(&dst, cirrus->vram);
 	iosys_map_incr(&dst, drm_fb_clip_offset(cirrus->pitch, fb->format, rect));
 
-	if (cirrus->cpp == fb->format->cpp[0]) {
+	if (cirrus->format == fb->format) {
 		drm_fb_memcpy(&dst, fb->pitches, vmap, fb, rect);
 
-	} else if (fb->format->cpp[0] == 4 && cirrus->cpp == 2) {
+	} else if (fb->format->format == DRM_FORMAT_XRGB8888 &&
+		   cirrus->format->format == DRM_FORMAT_RGB565) {
 		drm_fb_xrgb8888_to_rgb565(&dst, &cirrus->pitch, vmap, fb, rect, false);
 
-	} else if (fb->format->cpp[0] == 4 && cirrus->cpp == 3) {
+	} else if (fb->format->format == DRM_FORMAT_XRGB8888 &&
+		   cirrus->format->format == DRM_FORMAT_RGB565) {
 		drm_fb_xrgb8888_to_rgb888(&dst, &cirrus->pitch, vmap, fb, rect);
 
 	} else {
@@ -450,7 +452,7 @@ static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
 	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_rect rect;
 
-	if (state->fb && cirrus->cpp != cirrus_cpp(state->fb))
+	if (state->fb && cirrus->format != cirrus_format(state->fb))
 		cirrus_mode_set(cirrus, &crtc->mode, state->fb);
 
 	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
