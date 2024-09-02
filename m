Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED80C1E51D
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274552; cv=none; b=OduDFUhXI3sJMozmQzNMEadsHjmmJ9E4wXjdUCKsyXqi1Wx0sY4U1qQ1ug8/xwFYE8hQGU5UJ4tYpxu8cRvl1ztvG9MwmASWQiQ4q4hjpEQkbWQHAA43WJWk745SEigCbUi8e8TDOvfHU06+/8MAkU4m+iXrnLRfmXAPymLfYhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274552; c=relaxed/simple;
	bh=gjqTPyR+gDP4j+EpqYJwE2BMHQPUgoa7e6Kvc6eFalk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qNTxiYEX9uKzD4/Y7yrvu4436TlCIrCd3os59z741GroiZ47UuN07ZRSHy2hHAZlSwPLWgggPB2Xm/O2u+h797Lj2gts/2rw9b1glJTGpADnPFZQ6lagl3cP7O1Or11wTCz9bq7TD6aynp5mO6XXpdoXhGB60eiertefMz4Wu0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kn8maqIp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FRFmTYqV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kn8maqIp; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FRFmTYqV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kn8maqIp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FRFmTYqV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kn8maqIp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FRFmTYqV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 04FD41F78A;
	Mon,  2 Sep 2024 10:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725274549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OAqVDl2ormI8gHXrZvUE+AW28pA/oQN+9Q1NG5RKzo=;
	b=Kn8maqIpTQ1w/KU2H5B7K2FHjbCtl2jhh8L0dcDKLXf9xBH9F3pO4EJzNHr+ioWYLhfN11
	yI/XNb7tzsRU0WejhdSC2zvpWQDFpt3yRe3s3W8071E12WnGHzz43PXPNGuCDZb0eoBLQv
	J6wZ7t65OVS2N7gy05MhXqdZCllW/1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725274549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OAqVDl2ormI8gHXrZvUE+AW28pA/oQN+9Q1NG5RKzo=;
	b=FRFmTYqVqUzhmyrbQtG3TDNXnxvOcUYMyjvYOQTKaJOvhrGe1ffpg+UQqyd0kGPdD9Qvie
	1TyHx3BnoQ4pSHBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725274549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OAqVDl2ormI8gHXrZvUE+AW28pA/oQN+9Q1NG5RKzo=;
	b=Kn8maqIpTQ1w/KU2H5B7K2FHjbCtl2jhh8L0dcDKLXf9xBH9F3pO4EJzNHr+ioWYLhfN11
	yI/XNb7tzsRU0WejhdSC2zvpWQDFpt3yRe3s3W8071E12WnGHzz43PXPNGuCDZb0eoBLQv
	J6wZ7t65OVS2N7gy05MhXqdZCllW/1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725274549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0OAqVDl2ormI8gHXrZvUE+AW28pA/oQN+9Q1NG5RKzo=;
	b=FRFmTYqVqUzhmyrbQtG3TDNXnxvOcUYMyjvYOQTKaJOvhrGe1ffpg+UQqyd0kGPdD9Qvie
	1TyHx3BnoQ4pSHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1FC513AE5;
	Mon,  2 Sep 2024 10:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AF0VLrSZ1WZQcAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Sep 2024 10:55:48 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com,
	daniel@ffwll.ch,
	airlied@gmail.com,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 01/10] drm/bochs: Remove manual format test from fb_create
Date: Mon,  2 Sep 2024 12:53:39 +0200
Message-ID: <20240902105546.792625-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902105546.792625-1-tzimmermann@suse.de>
References: <20240902105546.792625-1-tzimmermann@suse.de>
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
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
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

