Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC1025DD07
	for <virtualization@lists.linux.dev>; Tue, 25 Mar 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923246; cv=none; b=SL6cVJeegbIAZEeDTsQAeWI/DfcPFAJKitlLDI1vhADABCK4vb06wqu7dZsAEQ1WXGOJHT0Rg8AUWsiFTLvkM1uEeyyscXzzT0bJHmRLcZ1pFh6+faV/Fhj4BAZMQHFK0VnjL0NLQs8tXNgZd8xCOvk64PSCVk2ayx4nNzPxWiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923246; c=relaxed/simple;
	bh=RdpY+gStXtBy7jyl5rJyhJGKPPlwUwh8j2kMWCJzkjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D0Ew+Jj1YnG71aKAxvKKBMylTzpCRhkAx2VizmF43n2RhrJq+0MxeNmEvjVa3zQzx6foN2/wFegWhMfpiIqqUTCxdMQoT6djPDqwM4MbT69g7KDS5ScTQtirCMMyIylEJeVxrPjq9vdSfSGxQedehort1YWdRtSZaMaIJ7BBJc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A00E91F395;
	Tue, 25 Mar 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70F8813A41;
	Tue, 25 Mar 2025 17:20:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iLtCGurl4mfzWAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 25 Mar 2025 17:20:42 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com,
	airlied@redhat.com
Cc: virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/4] drm/cirrus-qemu: Use framebuffer format as-is, drop adjustments
Date: Tue, 25 Mar 2025 18:12:51 +0100
Message-ID: <20250325171716.154097-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325171716.154097-1-tzimmermann@suse.de>
References: <20250325171716.154097-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: A00E91F395
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Remove internal adjustments to framebuffer format from cirrus-qemu
driver. The driver did this to support higher resolutions by reducing
the per-pixel memory consumption.

DRM has a policy of exporting formats as they are implemented in
hardware. So avoid internal adjustments if possible.

Also remove the call to drm_fb_blit() from cirrus-qemu. The helper
is useful if source and destination format are not known beforehand.
This is not the case for cirrus-qemu.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/cirrus-qemu.c | 71 ++++--------------------------
 1 file changed, 9 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
index 0306433ec117..76744394e2a3 100644
--- a/drivers/gpu/drm/tiny/cirrus-qemu.c
+++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
@@ -72,10 +72,6 @@ struct cirrus_device {
 
 struct cirrus_primary_plane_state {
 	struct drm_shadow_plane_state base;
-
-	/* HW scanout buffer */
-	const struct drm_format_info   *format;
-	unsigned int		       pitch;
 };
 
 static inline struct cirrus_primary_plane_state *
@@ -144,37 +140,6 @@ static void wreg_hdr(struct cirrus_device *cirrus, u8 val)
 	iowrite8(val, cirrus->mmio + VGA_DAC_MASK);
 }
 
-static const struct drm_format_info *cirrus_convert_to(struct drm_framebuffer *fb)
-{
-	if (fb->format->format == DRM_FORMAT_XRGB8888 && fb->pitches[0] > CIRRUS_MAX_PITCH) {
-		if (fb->width * 3 <= CIRRUS_MAX_PITCH)
-			/* convert from XR24 to RG24 */
-			return drm_format_info(DRM_FORMAT_RGB888);
-		else
-			/* convert from XR24 to RG16 */
-			return drm_format_info(DRM_FORMAT_RGB565);
-	}
-	return NULL;
-}
-
-static const struct drm_format_info *cirrus_format(struct drm_framebuffer *fb)
-{
-	const struct drm_format_info *format = cirrus_convert_to(fb);
-
-	if (format)
-		return format;
-	return fb->format;
-}
-
-static int cirrus_pitch(struct drm_framebuffer *fb)
-{
-	const struct drm_format_info *format = cirrus_convert_to(fb);
-
-	if (format)
-		return drm_format_info_min_pitch(format, 0, fb->width);
-	return fb->pitches[0];
-}
-
 static void cirrus_set_start_address(struct cirrus_device *cirrus, u32 offset)
 {
 	u32 addr;
@@ -341,13 +306,10 @@ static int cirrus_primary_plane_helper_atomic_check(struct drm_plane *plane,
 						    struct drm_atomic_state *state)
 {
 	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state, plane);
-	struct cirrus_primary_plane_state *new_primary_plane_state =
-		to_cirrus_primary_plane_state(new_plane_state);
 	struct drm_framebuffer *fb = new_plane_state->fb;
 	struct drm_crtc *new_crtc = new_plane_state->crtc;
 	struct drm_crtc_state *new_crtc_state = NULL;
 	int ret;
-	unsigned int pitch;
 
 	if (new_crtc)
 		new_crtc_state = drm_atomic_get_new_crtc_state(state, new_crtc);
@@ -361,17 +323,12 @@ static int cirrus_primary_plane_helper_atomic_check(struct drm_plane *plane,
 	else if (!new_plane_state->visible)
 		return 0;
 
-	pitch = cirrus_pitch(fb);
-
 	/* validate size constraints */
-	if (pitch > CIRRUS_MAX_PITCH)
+	if (fb->pitches[0] > CIRRUS_MAX_PITCH)
 		return -EINVAL;
-	else if (pitch * fb->height > CIRRUS_VRAM_SIZE)
+	else if (fb->pitches[0] > CIRRUS_VRAM_SIZE / fb->height)
 		return -EINVAL;
 
-	new_primary_plane_state->format = cirrus_format(fb);
-	new_primary_plane_state->pitch = pitch;
-
 	return 0;
 }
 
@@ -380,15 +337,10 @@ static void cirrus_primary_plane_helper_atomic_update(struct drm_plane *plane,
 {
 	struct cirrus_device *cirrus = to_cirrus(plane->dev);
 	struct drm_plane_state *plane_state = drm_atomic_get_new_plane_state(state, plane);
-	struct cirrus_primary_plane_state *primary_plane_state =
-		to_cirrus_primary_plane_state(plane_state);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
-	const struct drm_format_info *format = primary_plane_state->format;
-	unsigned int pitch = primary_plane_state->pitch;
 	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
-	struct cirrus_primary_plane_state *old_primary_plane_state =
-		to_cirrus_primary_plane_state(old_plane_state);
+	struct drm_framebuffer *old_fb = old_plane_state->fb;
 	struct iosys_map vaddr = IOSYS_MAP_INIT_VADDR_IOMEM(cirrus->vram);
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect damage;
@@ -400,18 +352,17 @@ static void cirrus_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	if (!drm_dev_enter(&cirrus->dev, &idx))
 		return;
 
-	if (old_primary_plane_state->format != format)
-		cirrus_format_set(cirrus, format);
-	if (old_primary_plane_state->pitch != pitch)
-		cirrus_pitch_set(cirrus, pitch);
+	if (!old_fb || old_fb->format != fb->format)
+		cirrus_format_set(cirrus, fb->format);
+	if (!old_fb || old_fb->pitches[0] != fb->pitches[0])
+		cirrus_pitch_set(cirrus, fb->pitches[0]);
 
 	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
-		unsigned int offset = drm_fb_clip_offset(pitch, format, &damage);
+		unsigned int offset = drm_fb_clip_offset(fb->pitches[0], fb->format, &damage);
 		struct iosys_map dst = IOSYS_MAP_INIT_OFFSET(&vaddr, offset);
 
-		drm_fb_blit(&dst, &pitch, format->format, shadow_plane_state->data, fb,
-			    &damage, &shadow_plane_state->fmtcnv_state);
+		drm_fb_memcpy(&dst, fb->pitches, shadow_plane_state->data, fb, &damage);
 	}
 
 	drm_dev_exit(idx);
@@ -427,8 +378,6 @@ static struct drm_plane_state *
 cirrus_primary_plane_atomic_duplicate_state(struct drm_plane *plane)
 {
 	struct drm_plane_state *plane_state = plane->state;
-	struct cirrus_primary_plane_state *primary_plane_state =
-		to_cirrus_primary_plane_state(plane_state);
 	struct cirrus_primary_plane_state *new_primary_plane_state;
 	struct drm_shadow_plane_state *new_shadow_plane_state;
 
@@ -441,8 +390,6 @@ cirrus_primary_plane_atomic_duplicate_state(struct drm_plane *plane)
 	new_shadow_plane_state = &new_primary_plane_state->base;
 
 	__drm_gem_duplicate_shadow_plane_state(plane, new_shadow_plane_state);
-	new_primary_plane_state->format = primary_plane_state->format;
-	new_primary_plane_state->pitch = primary_plane_state->pitch;
 
 	return &new_shadow_plane_state->base;
 }
-- 
2.48.1

