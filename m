Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E143B994F
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323576; cv=none; b=K2MEvH9jmBV9JDU5oeS3DdYrG2oiEmn+mkUAK+/R1mhTxZLFn7w4gZVs8WX1qK5ycxLLW4kqTmvO+Me9cyvSVaucAsWb/93zJGhTS6pqrPASgzXWKqi8bv1bk+FOuVzwiT4nQPZSjcYqPApIa2Bu58US8OwgTiSGQot8gtY9sX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323576; c=relaxed/simple;
	bh=y64imgJLKW1iHCMTQEg1PXDexQOTRTmUneEv/kamMBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZtjhcXyyBer+mLlMfUzNgryz0Vf7NbMbDD/XrFfHO40udQIyiHYN1xU13uqIFvfZyTryJoNqecVG0HdxVvOde2aFVscFWxJEgrZcw9C+UaiQD/GDk9g5IOljhk6X42hAn/PVOzhhFOKe6vBXpfuJWFIIhVsKHI5TMFPVixvDvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C32A67222;
	Mon,  1 Jun 2026 14:19:28 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 077B7779A7;
	Mon,  1 Jun 2026 14:19:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YACkAPCUHWpSdwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 01 Jun 2026 14:19:28 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch,
	michel.daenzer@mailbox.org,
	louis.chauvet@bootlin.com,
	ville.syrjala@linux.intel.com,
	jani.nikula@intel.com,
	mhklkml@zohomail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/7] drm/vblank: timer: Fix timestamp calculation
Date: Mon,  1 Jun 2026 16:08:30 +0200
Message-ID: <20260601141922.91498-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601141922.91498-1-tzimmermann@suse.de>
References: <20260601141922.91498-1-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5C32A67222
X-Rspamd-Action: no action

In drm_crtc_vblank_get_vblank_timeout(), return the timestamp of the
first visible scanline after the last vblank timeout. This is what the
caller expects.

A vblank phase starts with a vblank timeout. At this point the display
is blanked for several scanlines. Afterwards the display is unblanked
until the next vblank timeout occurs. The display content is only visible
during that second part.

The current implementation of drm_crtc_vblank_get_vblank_timeout()
returns the timestamp of the last vblank timeout that started the current
vblank phase. But the display only unblanks after 20 to 30 percent of
the overall frame duration. The returned timestamp is therefore too early.

The next vblank timeout is already known when calculating the returned
timestamp. Instead of subtracting the duration of a full frame from the
value, only subtract the duration of the active, visible part. The result
is the timestamp of the first visible scanline, as expected by the caller.

This bug was not introduced by the generic vblank timer. It appears that
the get_vblank_timeout logic has always been buggy since it was first
added in commit 3a0709928b17 ("drm/vkms: Add vblank events simulated by
hrtimers").

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 96d70c3d4522..d52df247d04e 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2293,10 +2293,19 @@ EXPORT_SYMBOL(drm_crtc_vblank_cancel_timer);
  */
 bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_time)
 {
+	struct drm_device *dev = crtc->dev;
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 	struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
+	const struct drm_display_mode *mode;
 	u64 cur_count;
 	ktime_t cur_time;
+	s64 framedur_ns;
+	s64 activedur_ns;
+
+	if (drm_drv_uses_atomic_modeset(dev))
+		mode = &vblank->hwmode;
+	else
+		mode = &crtc->hwmode;
 
 	if (!READ_ONCE(vblank->enabled))
 		return false;
@@ -2312,17 +2321,26 @@ bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
 		*vblank_time = READ_ONCE(vtimer->timer.node.expires);
 	} while (cur_count != drm_crtc_vblank_count_and_time(crtc, &cur_time));
 
-	if (drm_WARN_ON(crtc->dev, !ktime_compare(*vblank_time, cur_time)))
+	if (drm_WARN_ON(dev, !ktime_compare(*vblank_time, cur_time)))
 		return false; /* Already expired */
 
+	framedur_ns = vblank->framedur_ns;
+
 	/*
-	 * To prevent races we roll the hrtimer forward before we do any
-	 * interrupt processing - this is how real hw works (the interrupt
-	 * is only generated after all the vblank registers are updated)
-	 * and what the vblank core expects. Therefore we need to always
-	 * correct the timestamp by one frame.
+	 * To prevent races we rolled the hrtimer forward before we did any
+	 * timeout processing - this is how real hw works (the interrupt is
+	 * only generated after all the vblank registers are updated) and what
+	 * the vblank core expects.
+	 *
+	 * Therefore we always need to correct the timestamp. The returned
+	 * time should be the time of the first active scanline after the
+	 * previous vblank. Hence subtract the active phase's duration from
+	 * the next expiration time.
 	 */
-	*vblank_time = ktime_sub(*vblank_time, vtimer->interval);
+	if (drm_WARN_ON(dev, !mode->crtc_vtotal))
+		return false;
+	activedur_ns = div_s64(framedur_ns * mode->crtc_vdisplay, mode->crtc_vtotal);
+	*vblank_time = ktime_sub_ns(*vblank_time, activedur_ns);
 
 	return true;
 }
-- 
2.54.0

