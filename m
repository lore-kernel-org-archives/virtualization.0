Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F7185B55
	for <virtualization@lists.linux.dev>; Fri, 23 Aug 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417068; cv=none; b=nFEdEkvtpmBMq57XBy5/TzYppkaIRL/GSnFq60Fuw9QzdzZ9+hhTujdRoUFpPQtOYNfJ4BtRl78K1i3dXNp3TrHdZKBrwyFznEXG+ngE4VbKG4P2t7sZcw8FjohjK1BunTbEUPNfftdGMJF0AUvis6pXIgoyk/ZjayhKrRpCI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417068; c=relaxed/simple;
	bh=A5tPUGswpAfJF9VZauPXd6j41Ac2Kfus9pWFLCARjHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXOUnH35jfB9GSwn8q3qvYiDS83aqXhCeJtMJ9ZgBJav/7rli9dqx/MfhaxxjdPnqhZ4a+yB/106pu4Wm10lyInpTzfZcQNtW/eK8laiZZTNmQhFt4kIDSInAayKSQUTk1W3iLAhFk35652y1bQE482uG5t5DboPnSCak3xSHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AjPXoOV1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jYJf1+qV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AjPXoOV1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jYJf1+qV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AjPXoOV1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jYJf1+qV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AjPXoOV1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jYJf1+qV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A306D22206;
	Fri, 23 Aug 2024 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724417064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJhj1xlepifWcGEYAoJsGLExEBwTiXfQ+0MF+BBegk4=;
	b=AjPXoOV1PEJyDcg3WzViQI6jTchrgb4uMcRH2FAcibGG+yB8nc9rW8/56Fmgnc4emjynMC
	YJi3tF0MFVz91aTxduE4ChC0sjXbgorIm/KoXZZfgm5oi+AEMx0Gkld0QMkp3j0DGtdz5X
	5DYUeu2lPL9VUtqnwj+vk5AAFzvUXw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724417064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJhj1xlepifWcGEYAoJsGLExEBwTiXfQ+0MF+BBegk4=;
	b=jYJf1+qV4UDfjI0FzgeBM7gcW8rkIt1L3FVAheA9zMiJ9DamCtLEGXm5RxtyexQcX5p7NX
	fWXEGTl3k7Oc0BCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724417064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJhj1xlepifWcGEYAoJsGLExEBwTiXfQ+0MF+BBegk4=;
	b=AjPXoOV1PEJyDcg3WzViQI6jTchrgb4uMcRH2FAcibGG+yB8nc9rW8/56Fmgnc4emjynMC
	YJi3tF0MFVz91aTxduE4ChC0sjXbgorIm/KoXZZfgm5oi+AEMx0Gkld0QMkp3j0DGtdz5X
	5DYUeu2lPL9VUtqnwj+vk5AAFzvUXw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724417064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJhj1xlepifWcGEYAoJsGLExEBwTiXfQ+0MF+BBegk4=;
	b=jYJf1+qV4UDfjI0FzgeBM7gcW8rkIt1L3FVAheA9zMiJ9DamCtLEGXm5RxtyexQcX5p7NX
	fWXEGTl3k7Oc0BCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C30013A61;
	Fri, 23 Aug 2024 12:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8EwnGSiEyGbKVwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 23 Aug 2024 12:44:24 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com,
	daniel@ffwll.ch,
	airlied@gmail.com,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 01/10] drm/bochs: Remove manual format test from fb_create
Date: Fri, 23 Aug 2024 14:28:44 +0200
Message-ID: <20240823124422.286989-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823124422.286989-1-tzimmermann@suse.de>
References: <20240823124422.286989-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[redhat.com,ffwll.ch,gmail.com,kernel.org,linux.intel.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

An updated implementation of drm_gem_fb_create() already tests the
driver's planes for supported formats. [1] No need to duplicate this
test in bochs.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://elixir.bootlin.com/linux/v6.9/source/drivers/gpu/drm/drm_gem_framebuffer_helper.c#L169 # 1
---
 drivers/gpu/drm/tiny/bochs.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 31fc5d839e10..47a45a14306c 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -511,19 +511,8 @@ static void bochs_connector_init(struct drm_device *dev)
 	}
 }
 
-static struct drm_framebuffer *
-bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
-		    const struct drm_mode_fb_cmd2 *mode_cmd)
-{
-	if (mode_cmd->pixel_format != DRM_FORMAT_XRGB8888 &&
-	    mode_cmd->pixel_format != DRM_FORMAT_BGRX8888)
-		return ERR_PTR(-EINVAL);
-
-	return drm_gem_fb_create(dev, file, mode_cmd);
-}
-
 static const struct drm_mode_config_funcs bochs_mode_funcs = {
-	.fb_create = bochs_gem_fb_create,
+	.fb_create = drm_gem_fb_create,
 	.mode_valid = drm_vram_helper_mode_valid,
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
-- 
2.46.0

