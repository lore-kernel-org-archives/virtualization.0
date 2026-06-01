Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F21C84DC
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323594; cv=none; b=HMwVGWMllmSQxpiXIp5nf6+4U9snRpKm32dH4eD0ouPRfiRBeuzDcYJw74j1lvC5xOHYSkL+S4I5IhJPynwHEWosfFXJh7TkV39sGX2pQlHiWJ4zfplaMOCtcfnaAb4wiYVXecbz1JosccKOVWWEe0mWlVBMU/ZpW9DAqwy3SYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323594; c=relaxed/simple;
	bh=V48Rg+S/oTf0ZuJQlPszWEDwCpqSFt0cbXTLTP/BG5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTgqWcMYnGdYB8qzluE5CboK7fCKRaPDTPXD8fAep/GVYggHVfnhMfltgBPkn9bHgowE5Y5S2KLkEnWQHxnpk5ch7dFnwZiYMr6mHr3TeWs7fhgaos/Bwg7WUpVPazmXpRNaif0qJ5eSctPQG+iV5ls8ByA1j6tmZGT5xDN7TzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4339D6784A;
	Mon,  1 Jun 2026 14:19:30 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6242779A7;
	Mon,  1 Jun 2026 14:19:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KCUDN/GUHWpSdwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 01 Jun 2026 14:19:29 +0000
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
Subject: [PATCH 7/7] drm/vblank: timer: Avoid reading the vblank time unnecessarily
Date: Mon,  1 Jun 2026 16:08:35 +0200
Message-ID: <20260601141922.91498-8-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 4339D6784A
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

In drm_crtc_vblank_get_vblank_timeout(), there's a loop to read
a consistent vblank count and time. Only read the time once per
iteration and avoid costly locking and an atomic read.

Return an error after 10 retries. This indicates that the vblank
counter is broken or being updated way too often.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 75e2183be0ab..05f28e27cbff 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2316,7 +2316,8 @@ bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
 
 	if (READ_ONCE(vblank->enabled)) {
 		ktime_t cur_time;
-		u64 cur_count;
+		u64 lst_count, cur_count;
+		unsigned int retries = 10;
 
 		/*
 		 * A concurrent vblank timeout could update the expires field before
@@ -2324,10 +2325,15 @@ bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
 		 * expiry time to the new vblank time; deducing the timer had already
 		 * expired. Reread until we get consistent values from both fields.
 		 */
+		cur_count = drm_crtc_vblank_count(crtc);
 		do {
-			cur_count = drm_crtc_vblank_count_and_time(crtc, &cur_time);
+			lst_count = cur_count;
 			*vblank_time = READ_ONCE(vtimer->timer.node.expires);
-		} while (cur_count != drm_crtc_vblank_count_and_time(crtc, &cur_time));
+			cur_count = drm_crtc_vblank_count_and_time(crtc, &cur_time);
+		} while (cur_count != lst_count && retries--);
+
+		if (drm_WARN_ON(dev, cur_count != lst_count))
+			return false; /* broken vblank counter */
 
 		if (drm_WARN_ON(dev, !ktime_after(*vblank_time, cur_time)))
 			return false; /* already expired */
-- 
2.54.0

