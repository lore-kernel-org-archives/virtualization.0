Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF162040BA
	for <virtualization@lists.linux.dev>; Tue,  4 Mar 2025 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741095735; cv=none; b=j0yJJjRs7TIZ0t1f1u3gZE0Z1Fj2Z46ndfeINNx9HxYn7D1N+cK1f++Bu18wIcxI0yWOjjts7Fv+FPuBiVaBqiBDJafj/FbfPwiFKQyOqn1wWzkxsaty3oBRy391Q9hRypYvzcmrYvNU98FwfHI57fGOhlIEtqTNfhWk7YWSJYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741095735; c=relaxed/simple;
	bh=UKqD0GvTjTS5WLgbUwb8EpI54GC7Klx6kteW/PeGvcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaihnYr+yE/vy/+/0J6skNkWrGeXacp10d1qUTXT955yyNFLvrH67qPcSy43FXQ/5+qZXXkGxEI1xX3wp73icISLycUVMJAXXs+ye7WovrqvblxnkDZq0TjhfkqV64PnkRU1/nXT8ILydgX3hYjX7bHbenZXWW0vn2LehZx8qFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j74GWCPR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kbWyiGTU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=j74GWCPR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kbWyiGTU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j74GWCPR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kbWyiGTU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="j74GWCPR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kbWyiGTU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C87F71F74C;
	Tue,  4 Mar 2025 13:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741095731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nyc6J/gksMhLhuBouY5xml3nE5EEMor2jUfF0ZTd8DU=;
	b=j74GWCPRpYz4zVw2x8/0H9aqWSI25IIQFAnNLLlx2WvUQlTz5Ds14UCSt3IHqvvpqKrkeI
	B7kyL+eUFn94wRmVqdREAMQBekAYKAzQiirg1cpfNGI00qBpU/ien359JBdu2BnsPwYi3u
	kKKyjGEehyTM2VVx0eiSc4piyoK2AZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741095731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nyc6J/gksMhLhuBouY5xml3nE5EEMor2jUfF0ZTd8DU=;
	b=kbWyiGTU6+GQhDxR3HzAaJMzkDtXYNKGC5u1G3Si5DAnCVDqB2THNdevcJk6hI/ltfxMrT
	moihjhh498C+XjBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741095731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nyc6J/gksMhLhuBouY5xml3nE5EEMor2jUfF0ZTd8DU=;
	b=j74GWCPRpYz4zVw2x8/0H9aqWSI25IIQFAnNLLlx2WvUQlTz5Ds14UCSt3IHqvvpqKrkeI
	B7kyL+eUFn94wRmVqdREAMQBekAYKAzQiirg1cpfNGI00qBpU/ien359JBdu2BnsPwYi3u
	kKKyjGEehyTM2VVx0eiSc4piyoK2AZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741095731;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=nyc6J/gksMhLhuBouY5xml3nE5EEMor2jUfF0ZTd8DU=;
	b=kbWyiGTU6+GQhDxR3HzAaJMzkDtXYNKGC5u1G3Si5DAnCVDqB2THNdevcJk6hI/ltfxMrT
	moihjhh498C+XjBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9D5E13967;
	Tue,  4 Mar 2025 13:42:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LmDXKDMDx2eNIgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 04 Mar 2025 13:42:11 +0000
From: Takashi Iwai <tiwai@suse.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bochs: Fix DPMS regression
Date: Tue,  4 Mar 2025 14:41:57 +0100
Message-ID: <20250304134203.20534-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.com:url];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

The recent rewrite with the use of regular atomic helpers broke the
DPMS unblanking on X11.  Fix it by moving the call of
bochs_hw_blank(false) from CRTC mode_set_nofb() to atomic_enable().

Fixes: 2037174993c8 ("drm/bochs: Use regular atomic helpers")
Link: https://bugzilla.suse.com/show_bug.cgi?id=1238209
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/gpu/drm/tiny/bochs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 76e29950a807..c1c7d6c9e85f 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -323,8 +323,6 @@ static void bochs_hw_setmode(struct bochs_device *bochs, struct drm_display_mode
 			 bochs->xres, bochs->yres, bochs->bpp,
 			 bochs->yres_virtual);
 
-	bochs_hw_blank(bochs, false);
-
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_ENABLE,      0);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BPP,         bochs->bpp);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_XRES,        bochs->xres);
@@ -494,6 +492,9 @@ static int bochs_crtc_helper_atomic_check(struct drm_crtc *crtc,
 static void bochs_crtc_helper_atomic_enable(struct drm_crtc *crtc,
 					    struct drm_atomic_state *state)
 {
+	struct bochs_device *bochs = to_bochs_device(crtc->dev);
+
+	bochs_hw_blank(bochs, false);
 }
 
 static void bochs_crtc_helper_atomic_disable(struct drm_crtc *crtc,
-- 
2.43.0

