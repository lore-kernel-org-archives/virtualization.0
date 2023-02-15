Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DA75C677F1
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 16:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 04ADB61183;
	Wed, 15 Feb 2023 16:15:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 04ADB61183
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=v6Oj3weR;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=UtYf68N4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aWo-2WAgLAJg; Wed, 15 Feb 2023 16:15:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 309186117C;
	Wed, 15 Feb 2023 16:15:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 309186117C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0B3D3C008A;
	Wed, 15 Feb 2023 16:15:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9DC60C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 76D6440134
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 76D6440134
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=v6Oj3weR; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=UtYf68N4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KN_pQUd-e1Kv
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AADB040BF7
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AADB040BF7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:32 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 17890339A3;
 Wed, 15 Feb 2023 16:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676477729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tgfwC4HTlECoV8bLgLGrSLYiHXhh0M9Td1f5HdAONmY=;
 b=v6Oj3weR/sdlY5Gw6FqpBh26tEvy+tVIoyf+D+N488SSZRmbWumUA0L779LoYuiuX7hp5e
 oPEkQ7OYAbm84chXAIep/kjs3QUEKg5OPQNHDDuCbXRKb8lFmT/ReA9M+OOlvQdTcy3aZH
 yLpIKP/cILPwpk11j4/kI/KEiXRHfxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676477729;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tgfwC4HTlECoV8bLgLGrSLYiHXhh0M9Td1f5HdAONmY=;
 b=UtYf68N4LlEW+U82nQHR6s9nYB2Ayas/RypHSXdc4sLNp8GI+Mtnv4k6wvoMjZkkIDvwqV
 y2EY9HZzx0quf0BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD5AA134BA;
 Wed, 15 Feb 2023 16:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SBCmKSAF7WNHOgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Feb 2023 16:15:28 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com, airlied@redhat.com, daniel@ffwll.ch, sam@ravnborg.org,
 javierm@redhat.com, dri-devel@lists.freedesktop.org
Subject: [PATCH 13/17] drm/cirrus: Test mode against video-memory size in
 device-wide mode_valid
Date: Wed, 15 Feb 2023 17:15:13 +0100
Message-Id: <20230215161517.5113-14-tzimmermann@suse.de>
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

Test a display mode against the available amount of video memory in
struct drm_mode_config_funcs.mode_valid, which cirrus implements in
cirrus_mode_config_mode_valid(). This helper tests display modes against
device-wide limits. Remove the now-obsolete per-CRTC test.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/cirrus.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index c2d7bb775629..6c2be39d79a5 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -419,15 +419,6 @@ static const struct drm_plane_funcs cirrus_primary_plane_funcs = {
 	DRM_GEM_SHADOW_PLANE_FUNCS,
 };
 
-static enum drm_mode_status cirrus_crtc_helper_mode_valid(struct drm_crtc *crtc,
-							  const struct drm_display_mode *mode)
-{
-	if (cirrus_check_size(mode->hdisplay, mode->vdisplay, NULL) < 0)
-		return MODE_BAD;
-
-	return MODE_OK;
-}
-
 static int cirrus_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
 {
 	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
@@ -462,7 +453,6 @@ static void cirrus_crtc_helper_atomic_enable(struct drm_crtc *crtc,
 }
 
 static const struct drm_crtc_helper_funcs cirrus_crtc_helper_funcs = {
-	.mode_valid = cirrus_crtc_helper_mode_valid,
 	.atomic_check = cirrus_crtc_helper_atomic_check,
 	.atomic_enable = cirrus_crtc_helper_atomic_enable,
 };
@@ -555,8 +545,21 @@ static int cirrus_pipe_init(struct cirrus_device *cirrus)
 /* ------------------------------------------------------------------ */
 /* cirrus framebuffers & mode config				      */
 
+static enum drm_mode_status cirrus_mode_config_mode_valid(struct drm_device *dev,
+							  const struct drm_display_mode *mode)
+{
+	const struct drm_format_info *format = drm_format_info(DRM_FORMAT_XRGB8888);
+	uint64_t pitch = drm_format_info_min_pitch(format, 0, mode->hdisplay);
+
+	if (pitch * mode->vdisplay > CIRRUS_VRAM_SIZE)
+		return MODE_MEM;
+
+	return MODE_OK;
+}
+
 static const struct drm_mode_config_funcs cirrus_mode_config_funcs = {
 	.fb_create = drm_gem_fb_create_with_dirty,
+	.mode_valid = cirrus_mode_config_mode_valid,
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
