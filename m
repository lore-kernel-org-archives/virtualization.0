Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1A3BA232
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 14:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323583; cv=none; b=Pal0g5lldF4ACMtthjBNcOWiWJqRuLbzbTWqURc22ApTw36MREwFR/K54Lbp18nPqJoe5vZXacbOXeRjTtW8B55PESyZuRqdMHGK+MbXtdD3nVPRg9FE5laEH9BQiaVRzuYziAbD0KlsYlJFcpLgxzJUDJdS0OI/fSxTk7ut9rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323583; c=relaxed/simple;
	bh=Xj3BdiSZ08XIa4bhRqa03QRtxVGqqNpn/Pint6mxnYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ba+G4R75XNKNm8dV89eATEmCiOMYCWtv0p32LSgJE64+4qbg5QETUOeKfh8ala8Lq8J4WBadqkG+VmWHs7m1nx/KJLxidnAkmuIVXI+30/ARCZMTHJG5G5/CwOOW5NNtEwWN5SxveuF7zzFjPXleqPFdRPdMzQ1zAFQ7OHEYc/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WxKCMaNj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4IgyksRo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WxKCMaNj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4IgyksRo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WxKCMaNj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4IgyksRo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WxKCMaNj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4IgyksRo"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BAC2D67320;
	Mon,  1 Jun 2026 14:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780323568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eb5ySa3ZIoRexYr2KV174ly4yzBKEEvWhDm8xKUIkdg=;
	b=WxKCMaNjjQx4u8oXFMqAH7K4/brQMMV0akolrMmIdBy9w4/ekbrNbx5PzFqGeWqKPgEEZh
	1GU3KMxPUfLPqbBmlNhFde9ABefPW545iCFRB0iY+JPl6CUNv4qTdc9zgmHFbSs9mEKbFA
	7NWQvV2SpBwnJUmyzLhIy80yX769vkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780323568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eb5ySa3ZIoRexYr2KV174ly4yzBKEEvWhDm8xKUIkdg=;
	b=4IgyksRoxvAyH4YNv3+K6VWSl25Eu5U11uOyBjjCrdk4KR5jUf5oH34ezz2+YJXyX5Ot9H
	qqW9lx+MwzQDVFCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780323568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eb5ySa3ZIoRexYr2KV174ly4yzBKEEvWhDm8xKUIkdg=;
	b=WxKCMaNjjQx4u8oXFMqAH7K4/brQMMV0akolrMmIdBy9w4/ekbrNbx5PzFqGeWqKPgEEZh
	1GU3KMxPUfLPqbBmlNhFde9ABefPW545iCFRB0iY+JPl6CUNv4qTdc9zgmHFbSs9mEKbFA
	7NWQvV2SpBwnJUmyzLhIy80yX769vkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780323568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eb5ySa3ZIoRexYr2KV174ly4yzBKEEvWhDm8xKUIkdg=;
	b=4IgyksRoxvAyH4YNv3+K6VWSl25Eu5U11uOyBjjCrdk4KR5jUf5oH34ezz2+YJXyX5Ot9H
	qqW9lx+MwzQDVFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6274E779A8;
	Mon,  1 Jun 2026 14:19:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8GqxFvCUHWpSdwAAD6G6ig
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
Subject: [PATCH 3/7] drm/vblank: timer: Use absolute timer since boot
Date: Mon,  1 Jun 2026 16:08:31 +0200
Message-ID: <20260601141922.91498-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601141922.91498-1-tzimmermann@suse.de>
References: <20260601141922.91498-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -7.30
X-Spamd-Result: default: False [-7.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	R_RATELIMIT(0.00)[to_ip_from(RLgb6padn6wcu17bxtda1k7h6p)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[ffwll.ch,mailbox.org,bootlin.com,linux.intel.com,intel.com,zohomail.com,kernel.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

Replace HRTIMER_MODE_REL with HRTIMER_MODE_ABS. Align the vblank
timeouts at multiples of the current mode's frame duration. Use
CLOCK_BOOTTIME to avoid clock gaps from suspends. Allows the timer
code to easily estimate future timeouts even while the timer is
disabled.

Also add a separate error message for cases where the timeout handler
tries to forward an unexpired timer. This would indicate a problem in
how the timer is being set up.

Suggested-by: Michel Dänzer <michel.daenzer@mailbox.org>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index d52df247d04e..03b07e3c2598 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2192,7 +2192,9 @@ static enum hrtimer_restart drm_vblank_timer_function(struct hrtimer *timer)
 		return HRTIMER_NORESTART;
 
 	ret_overrun = hrtimer_forward_now(&vtimer->timer, interval);
-	if (ret_overrun != 1)
+	if (!ret_overrun)
+		drm_dbg_vbl(dev, "vblank timer underrun\n");
+	else if (ret_overrun != 1)
 		drm_dbg_vbl(dev, "vblank timer overrun\n");
 
 	if (crtc_funcs->handle_vblank_timeout)
@@ -2221,6 +2223,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 	struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
 	unsigned long flags;
+	s64 vblank_time_ns;
 
 	if (!vtimer->crtc) {
 		/*
@@ -2229,7 +2232,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 		vtimer->crtc = crtc;
 		spin_lock_init(&vtimer->interval_lock);
 		hrtimer_setup(&vtimer->timer, drm_vblank_timer_function,
-			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+			      CLOCK_BOOTTIME, HRTIMER_MODE_ABS);
 	} else {
 		/*
 		 * Timer should not be active. If it is, wait for the
@@ -2245,7 +2248,13 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
 	spin_unlock_irqrestore(&vtimer->interval_lock, flags);
 
-	hrtimer_start(&vtimer->timer, vtimer->interval, HRTIMER_MODE_REL);
+	/*
+	 * Always align the vblank timeout to the frame duration. Allows
+	 * for estimating the next vblank even if the hrtimer has been
+	 * disabled.
+	 */
+	vblank_time_ns = roundup(ktime_get_ns(), vblank->framedur_ns);
+	hrtimer_start(&vtimer->timer, ns_to_ktime(vblank_time_ns), HRTIMER_MODE_ABS);
 
 	return 0;
 }
-- 
2.54.0

