Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01CF1F4282
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226880; cv=none; b=WZ8QNC6sH7JZmP2L/iwC0tldmpg9TWXel9k2ZuQGa/smdn50tBWEPT7CHfWm58UBjiWV4jWl3M9+pYm3PsGRX3iq8kEa24szmsUhRn9plunr/SjHpy51SjCm0XdSV5RqabhNxNi/BAJqdhn/lEVjxZwC/ITLcIR65jT4yib40IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226880; c=relaxed/simple;
	bh=1QPfacgHeE12tfx0vKJuFVztMPC7+eXNd20otjqM3Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LU7BAxIgvtOoNmXkjxLOo5rUyml2M+gphEaFNsLPlSAqClhENhtYsaz/iUJ7WLTr4iDW5x0hvoFAxsO+HwrGwHn+Mjop49xqU3u0I+g5b7Q/D1j3Ras6VdVnpcC+uJ8l36JB1+hC1H7ZP5HLSFDoL6lHvXuOicAYCv8MD1Jxu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBADC21237;
	Fri, 11 Jul 2025 09:40:57 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 724EC1388B;
	Fri, 11 Jul 2025 09:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8EGLGinccGjbcAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 11 Jul 2025 09:40:57 +0000
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
Subject: [PATCH 4/9] Revert "drm/vmwgfx: Use dma_buf from GEM object instance"
Date: Fri, 11 Jul 2025 11:35:19 +0200
Message-ID: <20250711093744.120962-5-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[etnaviv]
X-Rspamd-Queue-Id: EBADC21237
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

This reverts commit aec8a40228acb385d60feec59b54573d307e60f3.

Reverting because the fix-up commits are suspected to cause regressions.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
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

