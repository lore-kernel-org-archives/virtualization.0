Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A4B26FD9B
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567293; cv=none; b=RVU64Ml+GTuEhJytQoXJ4HPuHii9RH44iKhVg8QOh0Y7AcBjg+V9CRLrBs5sjOVNtWYDidiDyWMnqWP6TnOee7dZv8Z5/Vo/MYjXSGIl8/zcSfkiEPif7fYiOysTYUd9eKMbqN2HLW4kBJfWoBPXFdUtHq6tSRA4ftlKu8qeBzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567293; c=relaxed/simple;
	bh=aX1MaoLciRJuCC3h/iX+r91QTYs2N07cJsPk6VLliKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RN9FOKyoRoxQLG3kyW38Aa5Y/Uc+PHIMv8t4U9Twt9jSK93UkVnXgnj2EubV3nzoacI0YxUFQxuxAuMT2o/dgd5HNZC+XTJAMdhKoU56RPSXxwSbdlcRWRli55+JNzK5t7Mgv8eiyyQFcq9e0p30sSzAGB9u4qBp/UV6M3Ct2Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WokDQwue; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MjJmW8Bj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WokDQwue; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MjJmW8Bj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WokDQwue";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MjJmW8Bj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WokDQwue";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MjJmW8Bj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C6E21F7A6;
	Tue, 15 Jul 2025 08:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752567275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mceqlRFOZFi8Ou2yah8L7DAx9CH23McNnkaeoGpddyM=;
	b=WokDQwue0g0A/W1Dx5RcuP4StW4BFOu1OW229eni2g/qXIxZ2gqFv0yG86oygF3xPnbTpe
	dSZoXPCybS3+xdFL6WdLAIp/GJ65//Oqt+yI/AJd8Q4OWSlNoOLHWOOEDNF9sucx/UlvPn
	w2l/iq0lXy9MN/+Xk5/raqyXsC2AfKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752567275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mceqlRFOZFi8Ou2yah8L7DAx9CH23McNnkaeoGpddyM=;
	b=MjJmW8BjbQxfkgEteAtH3VGlCIrDhAMryIOjix0oGFRTOl5SHyodjRdMl9z1SjLkBkxhSt
	e4VyeI0AcgiKYgAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752567275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mceqlRFOZFi8Ou2yah8L7DAx9CH23McNnkaeoGpddyM=;
	b=WokDQwue0g0A/W1Dx5RcuP4StW4BFOu1OW229eni2g/qXIxZ2gqFv0yG86oygF3xPnbTpe
	dSZoXPCybS3+xdFL6WdLAIp/GJ65//Oqt+yI/AJd8Q4OWSlNoOLHWOOEDNF9sucx/UlvPn
	w2l/iq0lXy9MN/+Xk5/raqyXsC2AfKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752567275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mceqlRFOZFi8Ou2yah8L7DAx9CH23McNnkaeoGpddyM=;
	b=MjJmW8BjbQxfkgEteAtH3VGlCIrDhAMryIOjix0oGFRTOl5SHyodjRdMl9z1SjLkBkxhSt
	e4VyeI0AcgiKYgAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC9A213A6C;
	Tue, 15 Jul 2025 08:14:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0JnCKOoNdmgJUAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 15 Jul 2025 08:14:34 +0000
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
	Simona Vetter <simona.vetter@ffwll.ch>
Subject: [PATCH v2 7/7] Revert "drm/gem-dma: Use dma_buf from GEM object instance"
Date: Tue, 15 Jul 2025 10:07:58 +0200
Message-ID: <20250715081121.34473-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250715081121.34473-1-tzimmermann@suse.de>
References: <20250715081121.34473-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-5.30 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[etnaviv];
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,amd.com,linux-foundation.org,linux.intel.com,kernel.org,pengutronix.de,armlinux.org.uk,redhat.com,collabora.com,chromium.org,broadcom.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLk1j8fm6pferx3phn9ndszqb3)];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -5.30

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

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Simona Vetter <simona.vetter@ffwll.ch>
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

