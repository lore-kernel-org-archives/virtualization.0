Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD7633E348
	for <virtualization@lists.linux.dev>; Wed, 10 Jun 2026 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105129; cv=none; b=HACQacujM0MPsis6tPAkSFh8e2/mt11+lVp2wVxvrvqLhm+qp/hPe1t7xYOr0iCo66yf6bboT7zsLGFQMoQvm4PBzo7h7EE2BYvgk2Dz1FNkOpv/WxyTod7KngYSD4Qn9p9mJLjOzKNeDLCrYMMbH7oX94T2R75KZmB/CgSzy+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105129; c=relaxed/simple;
	bh=b3UbWT4WiP4JUoofTkEDRXxbmowndQ5EUTO7LKO/Qnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7fP1eID83jrI/bpIgdpfuo6ReYJ33A4Roa13FyB6NG+LNpih8OoOw03BpF2MnW6L3BFM2ZEyROKm9Az78EpKeCImvSDSpKA/k4YSIP6S3TENGgVVUT0HIOhSmyYlDQYIzy0zgUWN1t46e7f/HCzWgEi9dk+aghAjrV4wlf+ps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ACC786AE60;
	Wed, 10 Jun 2026 15:25:13 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C9234779A7;
	Wed, 10 Jun 2026 15:25:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SGeyL9iBKWr3HwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 10 Jun 2026 15:25:12 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	airlied@redhat.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	admin@kodeit.net,
	gargaditya08@proton.me,
	paul@crapouillou.net,
	jani.nikula@linux.intel.com,
	mhklkml@zohomail.com,
	zack.rusin@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	javierm@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	linux-mips@vger.kernel.org,
	virtualization@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org,
	Zack Rusin <zackr@vmware.com>
Subject: [PATCH v5 02/15] drm/i915/display: Handle struct drm_plane_state.ignore_damage_clips
Date: Wed, 10 Jun 2026 17:18:18 +0200
Message-ID: <20260610152505.260172-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610152505.260172-1-tzimmermann@suse.de>
References: <20260610152505.260172-1-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: ACC786AE60
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

The mode-setting pipeline can disabled damage clippings for a commit
by setting ignore_damage_clips in struct drm_plane_state. The commit
will then do a full display update. Commit 35ed38d58257 ("drm: Allow
drivers to indicate the damage helpers to ignore damage clips") introduced
ignore_damage_clips to selectively ignore damage clipping in certain
framebuffer changes.

The i915 driver does not modify the flag, but DRM's damage iterator
will soon rely on it. Calling drm_atomic_helper_check_plane_damage()
right before drm_atomic_helper_damage_merged() guarantees that it
has the correct state. The i915 driver does not do this elsewhere
so far.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 35ed38d58257 ("drm: Allow drivers to indicate the damage helpers to ignore damage clips")
Cc: <stable@vger.kernel.org> # v6.4+
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Zack Rusin <zackr@vmware.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.8+
---
 drivers/gpu/drm/i915/display/intel_psr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index e138982dc91f..e4f43eb5bd72 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3018,6 +3018,9 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		src = drm_plane_state_src(&new_plane_state->uapi);
 		drm_rect_fp_to_int(&src, &src);
 
+		/* Prepare plane-damage state before using it */
+		drm_atomic_helper_check_plane_damage(&state->base, &new_plane_state->uapi);
+
 		if (!drm_atomic_helper_damage_merged(&old_plane_state->uapi,
 						     &new_plane_state->uapi, &damaged_area))
 			continue;
-- 
2.54.0

