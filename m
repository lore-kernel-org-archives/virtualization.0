Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D2B27AC24
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226872; cv=none; b=R4E9xNDoZ5WVig+i5omecS0Sf6vtfsAYq/gxLeHF3Z6mS7lEVfZdC5QrWBIK89aSY7FDwtrjL+FXGJeL8v9WwMWm+Rl4NOLxkqw60VyAm33jRjbddQLrvOcos81tA2mxkDvzqZ1RuxnGlMn6hX5wS22CIhVi1n5J6pbMk2g0t14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226872; c=relaxed/simple;
	bh=txn4I7t+Ah1rN5m9rDbCYM1Fz7nur/DyyviZXAVKetI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjSqK/P0EqYF4A6AI3QDZFrWYLBpXrMiMajEoEU61EOs4onWdrdYLUf5fDMCyBnfRAoAGvURTvmX3UYQQ0UswFHxc9PclKMlZei/reswweHA8rNxASvZi40/uT/xUXazBFbwY9gbTdwZrD6G8+6t42hX7xqADsh5GzYo1+TPaPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vKnRXOCt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jHw1WZq0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vKnRXOCt; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=jHw1WZq0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vKnRXOCt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jHw1WZq0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vKnRXOCt";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jHw1WZq0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 270972123A;
	Fri, 11 Jul 2025 09:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752226860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQEz/yZZ/WEnH1Lii4E7MonrpAU1Igfk5arQzloGwrc=;
	b=vKnRXOCtwz3S2bvYpHk6WsT4NpiainibGja2mL758qi6KQmERttUCuvW4pnaD47ZL2MNx3
	QZ7HTsnPgIZhSC9EEUULNm3crEZWkDxOWyeuwxsay8IucWPLqo/cmojzIw29fhatxcWpWn
	l35E68vhuQPcSWXaqKH2bY/qltot9eA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752226860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQEz/yZZ/WEnH1Lii4E7MonrpAU1Igfk5arQzloGwrc=;
	b=jHw1WZq0anqkuipo5/fLfSXYJQE4OQVBPybfuDyw8KptcZL3mokIyRmbaMaUAt22KSDWb4
	xq/hrLssK+jI18Bw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752226860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQEz/yZZ/WEnH1Lii4E7MonrpAU1Igfk5arQzloGwrc=;
	b=vKnRXOCtwz3S2bvYpHk6WsT4NpiainibGja2mL758qi6KQmERttUCuvW4pnaD47ZL2MNx3
	QZ7HTsnPgIZhSC9EEUULNm3crEZWkDxOWyeuwxsay8IucWPLqo/cmojzIw29fhatxcWpWn
	l35E68vhuQPcSWXaqKH2bY/qltot9eA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752226860;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQEz/yZZ/WEnH1Lii4E7MonrpAU1Igfk5arQzloGwrc=;
	b=jHw1WZq0anqkuipo5/fLfSXYJQE4OQVBPybfuDyw8KptcZL3mokIyRmbaMaUAt22KSDWb4
	xq/hrLssK+jI18Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B5451388B;
	Fri, 11 Jul 2025 09:40:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iKOHJCvccGjbcAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 11 Jul 2025 09:40:59 +0000
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
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 8/9] Revert "drm/gem-shmem: Use dma_buf from GEM object instance"
Date: Fri, 11 Jul 2025 11:35:23 +0200
Message-ID: <20250711093744.120962-9-tzimmermann@suse.de>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711093744.120962-1-tzimmermann@suse.de>
References: <20250711093744.120962-1-tzimmermann@suse.de>
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
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[etnaviv];
	FREEMAIL_TO(0.00)[ffwll.ch,gmail.com,amd.com,linux-foundation.org,linux.intel.com,kernel.org,pengutronix.de,armlinux.org.uk,redhat.com,collabora.com,chromium.org,broadcom.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_RATELIMIT(0.00)[to_ip_from(RLk1j8fm6pferx3phn9ndszqb3)];
	FROM_EQ_ENVFROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -5.30

This reverts commit 1a148af06000e545e714fe3210af3d77ff903c11.

Reverting because the fix-up commits are suspected to cause regressions.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 8ac0b1fa5287..5d1349c34afd 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -351,7 +351,7 @@ int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem,
 	dma_resv_assert_held(obj->resv);
 
 	if (drm_gem_is_imported(obj)) {
-		ret = dma_buf_vmap(obj->dma_buf, map);
+		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
 	} else {
 		pgprot_t prot = PAGE_KERNEL;
 
@@ -413,7 +413,7 @@ void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 	dma_resv_assert_held(obj->resv);
 
 	if (drm_gem_is_imported(obj)) {
-		dma_buf_vunmap(obj->dma_buf, map);
+		dma_buf_vunmap(obj->import_attach->dmabuf, map);
 	} else {
 		dma_resv_assert_held(shmem->base.resv);
 
-- 
2.50.0

