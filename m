Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5A1C677F1
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 16:15:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BB46461018;
	Wed, 15 Feb 2023 16:15:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB46461018
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sPq1MPt1;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VgaGVn33
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1LDhUiVT49St; Wed, 15 Feb 2023 16:15:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5EF8060B1B;
	Wed, 15 Feb 2023 16:15:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5EF8060B1B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 399C7C0083;
	Wed, 15 Feb 2023 16:15:32 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07686C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0744D81A50
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0744D81A50
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=sPq1MPt1; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=VgaGVn33
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gjODq0H9k-Ab
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B8A5781882
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B8A5781882
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:28 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC3F42004D;
 Wed, 15 Feb 2023 16:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676477724; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pqod8UcRfBuiC3hABJRedTN/0Nr+hGkU9F8SFZG9Bq0=;
 b=sPq1MPt1woMS7JjWMCeh+XXp6U2gHA+D3+P195PMvyjwRrSFdcfseDQS8/ZEY2SCuwxi7K
 6WSXaq8ZdctGGW8GR48ansM+neb0a795PGkEODDIl1cE9FKwHEvg879qak8UKR0vHwWWbW
 Fz+lHRyubbFU2EmGE+l0+YnALexKnFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676477724;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pqod8UcRfBuiC3hABJRedTN/0Nr+hGkU9F8SFZG9Bq0=;
 b=VgaGVn33hCUAtv+PRJofFYcRBolgBvhPm3DGkXkPVTc/TADJuUnrSdiNQHCdDQEoW9TdGV
 DV99q2ByJndkcdCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74639134BA;
 Wed, 15 Feb 2023 16:15:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oIqCGxwF7WNHOgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Feb 2023 16:15:24 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com, airlied@redhat.com, daniel@ffwll.ch, sam@ravnborg.org,
 javierm@redhat.com, dri-devel@lists.freedesktop.org
Subject: [PATCH 05/17] drm/cirrus: Split cirrus_mode_set() into smaller
 functions
Date: Wed, 15 Feb 2023 17:15:05 +0100
Message-Id: <20230215161517.5113-6-tzimmermann@suse.de>
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

Split cirrus_mode_set() into smaller functions that set the display
mode, color format and scnaline pitch individually. Better reflects
the design of the DRM modesetting pipeline.

Done in preparation of converting cirrus to regular atomic helpers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/cirrus.c | 63 +++++++++++++++++++++--------------
 1 file changed, 38 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index 0b02244bd9f1..60488e49bdb5 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -178,14 +178,12 @@ static void cirrus_set_start_address(struct cirrus_device *cirrus, u32 offset)
 	wreg_crt(cirrus, 0x1d, tmp);
 }
 
-static int cirrus_mode_set(struct cirrus_device *cirrus,
-			   struct drm_display_mode *mode,
-			   struct drm_framebuffer *fb)
+static void cirrus_mode_set(struct cirrus_device *cirrus,
+			    struct drm_display_mode *mode)
 {
 	int hsyncstart, hsyncend, htotal, hdispend;
 	int vtotal, vdispend;
 	int tmp;
-	int sr07 = 0, hdr = 0;
 
 	htotal = mode->htotal / 8;
 	hsyncend = mode->hsync_end / 8;
@@ -249,15 +247,21 @@ static int cirrus_mode_set(struct cirrus_device *cirrus,
 
 	/* Disable Hercules/CGA compatibility */
 	wreg_crt(cirrus, VGA_CRTC_MODE, 0x03);
+}
+
+static void cirrus_format_set(struct cirrus_device *cirrus,
+			      struct drm_framebuffer *fb)
+{
+	u8 sr07, hdr;
 
 	sr07 = rreg_seq(cirrus, 0x07);
 	sr07 &= 0xe0;
-	hdr = 0;
 
 	cirrus->format = cirrus_format(fb);
 	switch (cirrus->format->format) {
 	case DRM_FORMAT_C8:
 		sr07 |= 0x11;
+		hdr = 0x00;
 		break;
 	case DRM_FORMAT_RGB565:
 		sr07 |= 0x17;
@@ -272,22 +276,11 @@ static int cirrus_mode_set(struct cirrus_device *cirrus,
 		hdr = 0xc5;
 		break;
 	default:
-		return -1;
+		return;
 	}
 
 	wreg_seq(cirrus, 0x7, sr07);
 
-	/* Program the pitch */
-	cirrus->pitch = cirrus_pitch(fb);
-	tmp = cirrus->pitch / 8;
-	wreg_crt(cirrus, VGA_CRTC_OFFSET, tmp);
-
-	/* Enable extended blanking and pitch bits, and enable full memory */
-	tmp = 0x22;
-	tmp |= (cirrus->pitch >> 7) & 0x10;
-	tmp |= (cirrus->pitch >> 6) & 0x40;
-	wreg_crt(cirrus, 0x1b, tmp);
-
 	/* Enable high-colour modes */
 	wreg_gfx(cirrus, VGA_GFX_MODE, 0x40);
 
@@ -295,13 +288,25 @@ static int cirrus_mode_set(struct cirrus_device *cirrus,
 	wreg_gfx(cirrus, VGA_GFX_MISC, 0x01);
 
 	wreg_hdr(cirrus, hdr);
+}
 
-	cirrus_set_start_address(cirrus, 0);
+static void cirrus_pitch_set(struct cirrus_device *cirrus,
+			     struct drm_framebuffer *fb)
+{
+	u8 cr13, cr1b;
 
-	/* Unblank (needed on S3 resume, vgabios doesn't do it then) */
-	outb(0x20, 0x3c0);
+	/* Program the pitch */
+	cirrus->pitch = cirrus_pitch(fb);
+	cr13 = cirrus->pitch / 8;
+	wreg_crt(cirrus, VGA_CRTC_OFFSET, cr13);
 
-	return 0;
+	/* Enable extended blanking and pitch bits, and enable full memory */
+	cr1b = 0x22;
+	cr1b |= (cirrus->pitch >> 7) & 0x10;
+	cr1b |= (cirrus->pitch >> 6) & 0x40;
+	wreg_crt(cirrus, 0x1b, cr1b);
+
+	cirrus_set_start_address(cirrus, 0);
 }
 
 static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
@@ -413,9 +418,14 @@ static void cirrus_pipe_enable(struct drm_simple_display_pipe *pipe,
 	if (!drm_dev_enter(&cirrus->dev, &idx))
 		return;
 
-	cirrus_mode_set(cirrus, &crtc_state->mode, plane_state->fb);
+	cirrus_mode_set(cirrus, &crtc_state->mode);
+	cirrus_format_set(cirrus, plane_state->fb);
+	cirrus_pitch_set(cirrus, plane_state->fb);
 	cirrus_fb_blit_fullscreen(plane_state->fb, &shadow_plane_state->data[0]);
 
+	/* Unblank (needed on S3 resume, vgabios doesn't do it then) */
+	outb(0x20, 0x3c0);
+
 	drm_dev_exit(idx);
 }
 
@@ -425,15 +435,18 @@ static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
 	struct cirrus_device *cirrus = to_cirrus(pipe->crtc.dev);
 	struct drm_plane_state *state = pipe->plane.state;
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
-	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_rect rect;
 	int idx;
 
 	if (!drm_dev_enter(&cirrus->dev, &idx))
 		return;
 
-	if (state->fb && cirrus->format != cirrus_format(state->fb))
-		cirrus_mode_set(cirrus, &crtc->mode, state->fb);
+	if (state->fb) {
+		if (cirrus->format != cirrus_format(state->fb))
+			cirrus_format_set(cirrus, state->fb);
+		if (cirrus->pitch != cirrus_pitch(state->fb))
+			cirrus_pitch_set(cirrus, state->fb);
+	}
 
 	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
 		cirrus_fb_blit_rect(state->fb, &shadow_plane_state->data[0], &rect);
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
