Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27C126281
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595389; cv=none; b=nX0dktCVGiGzfYOWZZ9z26Of6hOoW34oZ5aTJjjMi+w17ZudzuxcCSn2zXoxZSvidrCvJdm6O0JN1PvdGlZasOVQv3y37MoSZrsvB4mzjLaB0/6zA99How7bOttFC7oWD7hGw1+VXWRo50XVcmGzKH54bsg+HI87djPg7MDdlmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595389; c=relaxed/simple;
	bh=GySNd/Ey/cxzDL9LJEXGrYaDgS5ZHHEsO5PxTEvAnNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6q2pnKGz0adJ8NOxUg8n7+w7chazoicRiOLdKTlcKOsaf5eGlEmEhv008+5QgpPGZiH664OK6b0s21DVo3x7Nc7HfZ8rDrjWMDVX/Skkwn6arCNwGos+g1j+92d00hEgfaxx4893MFiMWIDcRCmOV7fMpRMXD4LJ9TfEiooZMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kx19ppPn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GUIw/J1A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kx19ppPn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GUIw/J1A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kx19ppPn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GUIw/J1A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kx19ppPn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GUIw/J1A"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 988252121B;
	Tue, 15 Jul 2025 16:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752595368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcGWtr+L/LI2+sDjY2Iirbo5frB20K7UQbrnTHRIT2E=;
	b=Kx19ppPnLS6ALz8ka97RA3yB8q2daRo95y8pXRGzUL8+eZI79kfZXPWLRSApYcgsl40H7w
	4HR1lOpD5iRpOU3MdA102Fsu38uw76UpGdlRE7bOGL43XcBKPvv+XfabSHQlYU+N5pFvVY
	CvYBKO7WRxii+94wuB6wbPDXIt45yKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752595368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcGWtr+L/LI2+sDjY2Iirbo5frB20K7UQbrnTHRIT2E=;
	b=GUIw/J1AvkvKrXHvlobReYUX7EzS21QJV4I6XsxNUpzOkLrI6doSWi9fw+fw1E8kneBKEr
	1FAXfpYnU/bhb2CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752595368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcGWtr+L/LI2+sDjY2Iirbo5frB20K7UQbrnTHRIT2E=;
	b=Kx19ppPnLS6ALz8ka97RA3yB8q2daRo95y8pXRGzUL8+eZI79kfZXPWLRSApYcgsl40H7w
	4HR1lOpD5iRpOU3MdA102Fsu38uw76UpGdlRE7bOGL43XcBKPvv+XfabSHQlYU+N5pFvVY
	CvYBKO7WRxii+94wuB6wbPDXIt45yKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752595368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcGWtr+L/LI2+sDjY2Iirbo5frB20K7UQbrnTHRIT2E=;
	b=GUIw/J1AvkvKrXHvlobReYUX7EzS21QJV4I6XsxNUpzOkLrI6doSWi9fw+fw1E8kneBKEr
	1FAXfpYnU/bhb2CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CEA013A6C;
	Tue, 15 Jul 2025 16:02:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gAW/Aah7dmiFaQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 15 Jul 2025 16:02:48 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch,
	airlied@gmail.com,
	christian.koenig@amd.com,
	torvalds@linux-foundation.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	l.stach@pengutronix.de,
	linux+etnaviv@armlinux.org.uk,
	kraxel@redhat.com,
	christian.gmeiner@gmail.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	zack.rusin@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	dri-devel@lists.freedesktop.org,
	etnaviv@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	intel-gfx@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	stable@vger.kernel.org
Subject: [PATCH v3 7/7] Revert "drm/gem-dma: Use dma_buf from GEM object instance"
Date: Tue, 15 Jul 2025 17:58:17 +0200
Message-ID: <20250715155934.150656-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250715155934.150656-1-tzimmermann@suse.de>
References: <20250715155934.150656-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_RCPT(0.00)[etnaviv];
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,amd.com,linux-foundation.org,linux.intel.com,kernel.org,pengutronix.de,armlinux.org.uk,redhat.com,collabora.com,chromium.org,broadcom.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLk1j8fm6pferx3phn9ndszqb3)];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.80

This reverts commit e8afa1557f4f963c9a511bd2c6074a941c308685.

The dma_buf field in struct drm_gem_object is not stable over the
object instance's lifetime. The field becomes NULL when user space
releases the final GEM handle on the buffer object. This resulted
in a NULL-pointer deref.

Workarounds in commit 5307dce878d4 ("drm/gem: Acquire references on
GEM handles for framebuffers") and commit f6bfc9afc751 ("drm/framebuffer:
Acquire internal references on GEM handles") only solved the problem
partially. They especially don't work for buffer objects without a DRM
framebuffer associated.

Hence, this revert to going back to using .import_attach->dmabuf.

v3:
- cc stable

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
Acked-by: Christian König <christian.koenig@amd.com>
Cc: <stable@vger.kernel.org> # v6.15+
---
 drivers/gpu/drm/drm_gem_dma_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_dma_helper.c b/drivers/gpu/drm/drm_gem_dma_helper.c
index b7f033d4352a..4f0320df858f 100644
--- a/drivers/gpu/drm/drm_gem_dma_helper.c
+++ b/drivers/gpu/drm/drm_gem_dma_helper.c
@@ -230,7 +230,7 @@ void drm_gem_dma_free(struct drm_gem_dma_object *dma_obj)
 
 	if (drm_gem_is_imported(gem_obj)) {
 		if (dma_obj->vaddr)
-			dma_buf_vunmap_unlocked(gem_obj->dma_buf, &map);
+			dma_buf_vunmap_unlocked(gem_obj->import_attach->dmabuf, &map);
 		drm_prime_gem_destroy(gem_obj, dma_obj->sgt);
 	} else if (dma_obj->vaddr) {
 		if (dma_obj->map_noncoherent)
-- 
2.50.0

