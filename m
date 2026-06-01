Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21703B27D6
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323589; cv=none; b=FD2Tt4zyqMz7PcnLlUdquBBkEhHlkrU4m1yKeGP0xqZcvugAWnODwVMKQv3qaz1JDBbDKB3Ztv5P7Wh8i/CFL6zmWemr+/SnpRfUn9ahBGxrClrefSSt07EuM4Oe/kzrcrJLSRBRLzVVGGjJVDilaU81RVZh4y3SXd7I2K0ZvgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323589; c=relaxed/simple;
	bh=FgjIF2+FeEGQXOWNpTVfpMvGQopjd+KQ80FsJCb01DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNyRsnqac4a3LYWgbgm4m/sfD5VqnT3pt4wHyx60mJn7topqSdo5AaDjPgko2GDqCT5/Dmd1LlN83V8B0+v0AhLXkwFBkyOwW2WfCuNNT/B9b60bfQeBajpMCBNDuvvaCzQ59GZ3ey1Z9kx/Egnl513vUigBtXjeqlQtJ7QJijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 83BE7676DD;
	Mon,  1 Jun 2026 14:19:29 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27E0D779A7;
	Mon,  1 Jun 2026 14:19:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aN1ICPGUHWpSdwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 01 Jun 2026 14:19:29 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: simona@ffwll.ch,
	michel.daenzer@mailbox.org,
	louis.chauvet@bootlin.com,
	ville.syrjala@linux.intel.com,
	jani.nikula@intel.com,
	mhklkml@zohomail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 5/7] drm/vblank: timer: Estimate vblank timeout if timer is disabled
Date: Mon,  1 Jun 2026 16:08:33 +0200
Message-ID: <20260601141922.91498-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601141922.91498-1-tzimmermann@suse.de>
References: <20260601141922.91498-1-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 83BE7676DD
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

Estimate the next vblank timeout from the duration of a frame in
the currently programmed display mode. Timeouts are aligned to
frame duration, so we can round up to the next alignment.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_vblank.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index cecaef98aa52..b5d2fb741b2d 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -2333,6 +2333,17 @@ bool drm_crtc_vblank_get_vblank_timeout(struct drm_crtc *crtc, ktime_t *vblank_t
 			return false; /* already expired */
 
 		framedur_ns = vblank->framedur_ns;
+	} else if (mode->crtc_clock) {
+		u64 framesize = mode->crtc_htotal * mode->crtc_vtotal;
+
+		/*
+		 * With the vblank timer being disabled, we don't have an
+		 * expiry time. As the timeouts are aligned to the display
+		 * mode's clock, we can estimate when the expiry time would
+		 * have been.
+		 */
+		framedur_ns = div_u64(framesize * 1000000llu, mode->crtc_clock);
+		*vblank_time = roundup(ktime_get_ns(), framedur_ns);
 	} else {
 		return false;
 	}
-- 
2.54.0

