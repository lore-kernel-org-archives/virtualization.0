Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17205413D69
	for <virtualization@lists.linux.dev>; Mon, 24 Aug 2026 12:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575962; cv=none; b=HW+cSOhGRpuLNi0Li8pFwO9yrv3OtE0h2+S+96Il0OwQZGW6020yiinOf+nz20zEdDtfbIDzlChNkakBf4RQBhErgZ5m7e2z4/B3AZcTPjoS/i0OGVKviaaVEyClDzYtXahzr5MkrVIXw7a6Gq5VeFzJ/zFmhCtx8Gqch1aaDdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575962; c=relaxed/simple;
	bh=luquQq6fwsGGa1cit5g8Nb5t0xmCZxmWD8UU4ZH57cI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+B1lsm9Egmu18t1VUUwWVL1a9AXj2kQ8QwPmSz9FYwa/OKhJDDYVn5DTDHlvK2k6LXb9nfbkehXK43bN3rUXam8FfAiSsXz/60cGu85dmtgefUAVYlmYEFvrMR5GZa0vrKL9MaO2Aq6E3GDwX8apTCQ+NkVYSWFsmFVOD2gWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98D7D86833;
	Mon, 24 Aug 2026 12:52:11 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76CE81340F;
	Mon, 24 Aug 2026 12:52:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YNnDG3o+jGpyNwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 24 Aug 2026 12:52:10 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	javierm@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	geert@linux-m68k.org,
	rdunlap@infradead.org
Cc: dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	nouveau@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org,
	virtualization@lists.linux.dev,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 09/13] drm/panic: Restrict to primary planes; unconditionally unregister
Date: Mon, 24 Aug 2026 14:43:40 +0200
Message-ID: <20260824125201.218863-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824125201.218863-1-tzimmermann@suse.de>
References: <20260824125201.218863-1-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 98D7D86833
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

Restrict panic handling to primary displays. Overlays and cursors
should not display panic output. If there are exceptions, they can
be registered by the driver itself.

For cleanup, unregister each plane unconditionally. The kmsg dumper
already keeps track of the registration status so DRM doesn't have
to.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_panic.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
index 2048a3bf736f..7dbbcc1c219f 100644
--- a/drivers/gpu/drm/drm_panic.c
+++ b/drivers/gpu/drm/drm_panic.c
@@ -1079,6 +1079,8 @@ void drm_panic_register(struct drm_device *dev)
 		return;
 
 	drm_for_each_plane(plane, dev) {
+		if (plane->type != DRM_PLANE_TYPE_PRIMARY)
+			continue;
 		if (!plane->helper_private || !plane->helper_private->get_scanout_buffer)
 			continue;
 		plane->kmsg_panic.dump = drm_panic;
@@ -1105,11 +1107,8 @@ void drm_panic_unregister(struct drm_device *dev)
 	if (!dev->mode_config.num_total_plane)
 		return;
 
-	drm_for_each_plane(plane, dev) {
-		if (!plane->helper_private || !plane->helper_private->get_scanout_buffer)
-			continue;
+	drm_for_each_plane(plane, dev)
 		kmsg_dump_unregister(&plane->kmsg_panic);
-	}
 }
 
 /**
-- 
2.55.0

