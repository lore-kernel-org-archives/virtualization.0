Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D47A274FE3
	for <virtualization@lists.linux.dev>; Tue, 15 Jul 2025 08:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567281; cv=none; b=i51NBxlvkG+aNrW2NdLDN38A6j4olh469QycvmenKXzInGhBD+ucp3WAmlPd1Vm4+xhJq8e2qv7bDnedRLJo4kXfadOn+3e1rm3I3IglvehOVISQcJUrefXcldXktBb6Jff2cQ1Fo0P5cloc6MGpmtNVNsvpKYvCx6doF+kmE/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567281; c=relaxed/simple;
	bh=7OKVidT+GhuEpNuBiWPfdUliLEqGrQvjJk+X0y2eNQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9+2ZkH9ntWzIiKRW3A6TR+s3VevdtnkYzKfo1lBy9o2Bc3xPReJlIib7W50zTkVKoRRucgw9Eu5lLmRnGUjgqLqCSfO7NOMivzHGAGthABD3QbZK9kCPu+i0Pi/rAYRcwdm7MkjTlu8kUXvwb2Dutm9UFwT+Qn6DzpXk6sIG1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB2A01F44F;
	Tue, 15 Jul 2025 08:14:32 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6636A13A6C;
	Tue, 15 Jul 2025 08:14:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kMbIF+gNdmgJUAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 15 Jul 2025 08:14:32 +0000
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
Subject: [PATCH v2 3/7] Revert "drm/etnaviv: Use dma_buf from GEM object instance"
Date: Tue, 15 Jul 2025 10:07:54 +0200
Message-ID: <20250715081121.34473-4-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[etnaviv]
X-Rspamd-Queue-Id: EB2A01F44F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

This reverts commit e91eb3ae415472b28211d7fed07fa283845b311e.

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
 drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
index 917ad527c961..40a50c60dfff 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gem_prime.c
@@ -65,7 +65,7 @@ static void etnaviv_gem_prime_release(struct etnaviv_gem_object *etnaviv_obj)
 	struct iosys_map map = IOSYS_MAP_INIT_VADDR(etnaviv_obj->vaddr);
 
 	if (etnaviv_obj->vaddr)
-		dma_buf_vunmap_unlocked(etnaviv_obj->base.dma_buf, &map);
+		dma_buf_vunmap_unlocked(etnaviv_obj->base.import_attach->dmabuf, &map);
 
 	/* Don't drop the pages for imported dmabuf, as they are not
 	 * ours, just free the array we allocated:
@@ -82,7 +82,7 @@ static void *etnaviv_gem_prime_vmap_impl(struct etnaviv_gem_object *etnaviv_obj)
 
 	lockdep_assert_held(&etnaviv_obj->lock);
 
-	ret = dma_buf_vmap(etnaviv_obj->base.dma_buf, &map);
+	ret = dma_buf_vmap(etnaviv_obj->base.import_attach->dmabuf, &map);
 	if (ret)
 		return NULL;
 	return map.vaddr;
-- 
2.50.0

