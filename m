Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A73B9D84
	for <virtualization@lists.linux.dev>; Mon,  1 Jun 2026 14:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780323575; cv=none; b=fSdYPjl5GIsF4GC4zKdir1y8Tm6EiwVyCkz6Xg8eo06xQRILKVwlMhxHK4ta6CLFUGIuwqzzwf2NIFFC8ms+/gDDR2RFUHPJJsf5qTiajhcSpsyOmavBcbQ9fygQlYwIkMEAr5+Zw1chDJdfELSxYuWzXDFNwpxQqAoGTrcdp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780323575; c=relaxed/simple;
	bh=DukkPKbs350UO2T0QCGBK9ekYqiawsKPHuYICrlHNdA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KWBJKcdYUAJbU9R+d2yowRx9CqEMyO9rCSUciY01pM87B+8qyUo/wvcKGL0swRCWWoV86trqRoPjxKUs23H0heSZhmzpbjIk43W5m71JjTjk/HlU3lmAG4qtZ/qJOiEnGfLw4Po1cuUJIeqlfbrLVfFhg6/LIv0iyzsYvO7/fLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PD3oWoSN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kFdkoam1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PD3oWoSN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kFdkoam1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PD3oWoSN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kFdkoam1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PD3oWoSN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kFdkoam1"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 980416ABFE;
	Mon,  1 Jun 2026 14:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780323567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AR3xA5zcPnacGPzvxoEEDF5FVLEWtEBpLQoIFPOUVm0=;
	b=PD3oWoSNEFtNGwyN6IK92t0ZsjjN9g2oael27TKdx7u5tfGP8HRAkTzVfpbASOH9Z/igMw
	MxrKATOQZIp8Yxc7fpHqkRZgbl95b83/RtuJwCcm2eDtcFPYX9RqTyf+B9r1pPIoqRrYuh
	JmgfaUYnQHgZUc0/p4cJnr7OLoPLYgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780323567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AR3xA5zcPnacGPzvxoEEDF5FVLEWtEBpLQoIFPOUVm0=;
	b=kFdkoam1sKfsAFsgx00LfxAOCnAvYHR9u49Ao5gduVjcq1bOOIcwqtElvim2lEblQQ+8JH
	YEdXMQ6CP0+JJUDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780323567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AR3xA5zcPnacGPzvxoEEDF5FVLEWtEBpLQoIFPOUVm0=;
	b=PD3oWoSNEFtNGwyN6IK92t0ZsjjN9g2oael27TKdx7u5tfGP8HRAkTzVfpbASOH9Z/igMw
	MxrKATOQZIp8Yxc7fpHqkRZgbl95b83/RtuJwCcm2eDtcFPYX9RqTyf+B9r1pPIoqRrYuh
	JmgfaUYnQHgZUc0/p4cJnr7OLoPLYgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780323567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AR3xA5zcPnacGPzvxoEEDF5FVLEWtEBpLQoIFPOUVm0=;
	b=kFdkoam1sKfsAFsgx00LfxAOCnAvYHR9u49Ao5gduVjcq1bOOIcwqtElvim2lEblQQ+8JH
	YEdXMQ6CP0+JJUDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 423C5779A7;
	Mon,  1 Jun 2026 14:19:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kqG8Du+UHWpSdwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 01 Jun 2026 14:19:27 +0000
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
Subject: [PATCH 0/7] drm/vblank: timer: Fix timestamps and improve reliabilty
Date: Mon,  1 Jun 2026 16:08:28 +0200
Message-ID: <20260601141922.91498-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[ffwll.ch,mailbox.org,bootlin.com,linux.intel.com,intel.com,zohomail.com,kernel.org,gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.30

It appears that the DRM's vblank timers have always been somewhat buggy
in their timestamp calculations. Fix the generic implementation and
improve reliability.

Patch 1 returns success/failure to the caller, as expected by DRM.

Patch 2 fixes the timestamp calculation to return the time of the first
visible scanline in the current vblank phase.

Patch 3 switches the hrtimer to absolute values since boot, so that it's
easier to work with and we can predict future timestamps reliably.

Patches 4 and 5 allow for estimating timestamps even with the timer
being disabled.

Patches 6 and 7 improve the retrieval of the next vblank timeout's
timestamp.

Tested under heavy CPU-load on bochs and virtio. No ersors or warnings
showed up.

There have been reports about vblank timeouts being handled so late,
that they trigger DRM's internal error checks. Maybe these fixes and
adjustments can help to further avoid hick ups from delayed vblank
timers.

Thomas Zimmermann (7):
  drm/vblank: timer: Return success status from get_vblank_timeout
  drm/vblank: timer: Fix timestamp calculation
  drm/vblank: timer: Use absolute timer since boot
  drm/vblank: timer: Reorganize get_vblank_timeout
  drm/vblank: timer: Estimate vblank timeout if timer is disabled
  drm/vblank: timer: Verify that expiry time is in the future
  drm/vblank: timer: Avoid reading the vblank time unnecessarily

 drivers/gpu/drm/drm_vblank.c        | 105 ++++++++++++++++++++--------
 drivers/gpu/drm/drm_vblank_helper.c |   4 +-
 include/drm/drm_vblank.h            |   2 +-
 3 files changed, 79 insertions(+), 32 deletions(-)


base-commit: 4f554688dffcacf48630c14f9fb77a9f60394c1c
-- 
2.54.0

