Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66BA175A79
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323581; cv=none; b=McMSmZ+YOgzjykemKv4papru4xQJXnsJzzMiwzuPM6Fj8Fq6WLHQ/FrKOliOe7WjusSRBxtjmY0tq1Wd9KqScaLiAbParWo7yEGd8DnQ50/n/lk5QrqW87jgg2iMzC3juJThOpWtqM83ghERfYaORb9IF18/3BsIjqk9lJwlnDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323581; c=relaxed/simple;
	bh=pdiBnBuDBX213d3Xd0qDkVBCIP5rK/RiwQRSfeeoRu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFLwZzHUTdEIcTNzmx76/qmgCL0bSlLVMQbcLxLwYinz2enzXUHynuQWI6l0giMR+aQNpdPJ9yv1QtA/N6SlbH7cWqevp5WCGQ2nq1M50iAIc5GdKMvnruCrgCWqPD9rygFs2fjU9prnvKx877L2aGJ38hzXEhBHsWAWLr72HK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 202CE6ACA3;
	Mon,  1 Jun 2026 14:19:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1232779A7;
	Mon,  1 Jun 2026 14:19:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eID3LfCUHWpSdwAAD6G6ig
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
Subject: [PATCH 4/7] drm/vblank: timer: Reorganize get_vblank_timeout
Date: Mon,  1 Jun 2026 16:08:32 +0200
Message-ID: <20260601141922.91498-5-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 202CE6ACA3
X-Rspamd-Action: no action

Handle vblank->enabled in a separate branch before handling the
opposite case. Prepares the code for estimating the vblank timeout
while vblanking is disabled. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c | 36 +++++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 03b07e3c2598..cecaef98aa52 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2306,8 +2306,6 @@ bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 	struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
 	const struct drm_display_mode *mode;
-	u64 cur_count;
-	ktime_t cur_time;
 	s64 framedur_ns;
 	s64 activedur_ns;
 
@@ -2316,24 +2314,28 @@ bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
 	else
 		mode = &crtc->hwmode;
 
-	if (!READ_ONCE(vblank->enabled))
-		return false;
+	if (READ_ONCE(vblank->enabled)) {
+		ktime_t cur_time;
+		u64 cur_count;
 
-	/*
-	 * A concurrent vblank timeout could update the expires field before
-	 * we compare it with the vblank time. Hence we'd compare the old
-	 * expiry time to the new vblank time; deducing the timer had already
-	 * expired. Reread until we get consistent values from both fields.
-	 */
-	do {
-		cur_count = drm_crtc_vblank_count_and_time(crtc, &cur_time);
-		*vblank_time = READ_ONCE(vtimer->timer.node.expires);
-	} while (cur_count != drm_crtc_vblank_count_and_time(crtc, &cur_time));
+		/*
+		 * A concurrent vblank timeout could update the expires field before
+		 * we compare it with the vblank time. Hence we'd compare the old
+		 * expiry time to the new vblank time; deducing the timer had already
+		 * expired. Reread until we get consistent values from both fields.
+		 */
+		do {
+			cur_count = drm_crtc_vblank_count_and_time(crtc, &cur_time);
+			*vblank_time = READ_ONCE(vtimer->timer.node.expires);
+		} while (cur_count != drm_crtc_vblank_count_and_time(crtc, &cur_time));
 
-	if (drm_WARN_ON(dev, !ktime_compare(*vblank_time, cur_time)))
-		return false; /* Already expired */
+		if (drm_WARN_ON(dev, !ktime_compare(*vblank_time, cur_time)))
+			return false; /* already expired */
 
-	framedur_ns = vblank->framedur_ns;
+		framedur_ns = vblank->framedur_ns;
+	} else {
+		return false;
+	}
 
 	/*
 	 * To prevent races we rolled the hrtimer forward before we did any
-- 
2.54.0

