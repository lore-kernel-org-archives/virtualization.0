Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDDF1EA7D2
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595375; cv=none; b=saO8a231NJUfJf99AGy5UseiZMmnppVzGORpiDK0CM2YhkP9WjVfaidbZuTPe4cFoz/yQTmDh1c7S7X/Czb/IsMA7N1XJfWsTMR/u6uJznvX7JjO023fSqYdHWsLCAefubKW5GHdcoQlDuZJIpZOPjLgdLQyT/sQ8Hq8emogV0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595375; c=relaxed/simple;
	bh=UkKGgBpZvfUqyvLsjmaCYGuDzTsIpQI4p9Fh4CYqRjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ki0ipBrbbG92qCsKCZeAc/cC/sQDZQLTf5Nqc+Ps9NgJTEzH/4aakjKCImkvWk3Y5YpSdjxy/X9brkGT0MGyifV/2Db1hUmOPIahEdblRS3o1574xamQCua2A1aRNjAjmaLqXbQhapIEqvj4IBlhGzWLXpTWibgRxF8UtaMYYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RLD8t7Kh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J/3GASam; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RLD8t7Kh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J/3GASam; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RLD8t7Kh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J/3GASam";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RLD8t7Kh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J/3GASam"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C3F92116B;
	Tue, 15 Jul 2025 16:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752595365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3DdpuA4h8uXOk1UFfolEuAX/FsDIPpWaZRUHT48EHw=;
	b=RLD8t7KhE9lmKT8Qsarp+dgFfConk6ziuzu5bMYh01hoLhiClVr6wtxsUG09yxyFcErnY3
	dXAu+4mB9wLBIhHS0gPMYr505acTL+bM4NFEyqssM7ax3K2Aexxc00o6sfg9jG0eKhYW+d
	atEHOiEnaIktGeejdPnLeF+BSL9csZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752595365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3DdpuA4h8uXOk1UFfolEuAX/FsDIPpWaZRUHT48EHw=;
	b=J/3GASamfCkx6UIv8adIjRFnDDI8O9OFK4oD8XtQFhHFLzCVihoTckL5XSvodbFZPFDNhC
	bGp9llyTW82scmAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752595365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3DdpuA4h8uXOk1UFfolEuAX/FsDIPpWaZRUHT48EHw=;
	b=RLD8t7KhE9lmKT8Qsarp+dgFfConk6ziuzu5bMYh01hoLhiClVr6wtxsUG09yxyFcErnY3
	dXAu+4mB9wLBIhHS0gPMYr505acTL+bM4NFEyqssM7ax3K2Aexxc00o6sfg9jG0eKhYW+d
	atEHOiEnaIktGeejdPnLeF+BSL9csZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752595365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L3DdpuA4h8uXOk1UFfolEuAX/FsDIPpWaZRUHT48EHw=;
	b=J/3GASamfCkx6UIv8adIjRFnDDI8O9OFK4oD8XtQFhHFLzCVihoTckL5XSvodbFZPFDNhC
	bGp9llyTW82scmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 180A213A68;
	Tue, 15 Jul 2025 16:02:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2G21BKV7dmiFaQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 15 Jul 2025 16:02:45 +0000
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
Subject: [PATCH v3 2/7] Revert "drm/vmwgfx: Use dma_buf from GEM object instance"
Date: Tue, 15 Jul 2025 17:58:12 +0200
Message-ID: <20250715155934.150656-3-tzimmermann@suse.de>
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
	RCPT_COUNT_TWELVE(0.00)[21];
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

This reverts commit aec8a40228acb385d60feec59b54573d307e60f3.

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
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
index 7057d852951b..eedf1fe60be7 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_gem.c
@@ -85,10 +85,10 @@ static int vmw_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 	int ret;
 
 	if (drm_gem_is_imported(obj)) {
-		ret = dma_buf_vmap(obj->dma_buf, map);
+		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
 		if (!ret) {
 			if (drm_WARN_ON(obj->dev, map->is_iomem)) {
-				dma_buf_vunmap(obj->dma_buf, map);
+				dma_buf_vunmap(obj->import_attach->dmabuf, map);
 				return -EIO;
 			}
 		}
@@ -102,7 +102,7 @@ static int vmw_gem_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 static void vmw_gem_vunmap(struct drm_gem_object *obj, struct iosys_map *map)
 {
 	if (drm_gem_is_imported(obj))
-		dma_buf_vunmap(obj->dma_buf, map);
+		dma_buf_vunmap(obj->import_attach->dmabuf, map);
 	else
 		drm_gem_ttm_vunmap(obj, map);
 }
-- 
2.50.0

