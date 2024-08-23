Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74641185B64
	for <virtualization@lists.linux.dev>; Fri, 23 Aug 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417068; cv=none; b=Ykcm8TGFIl7s3JAz17+SGkpJ8OdSTCUfXpTxw9sjV3VhpV+51V0mBVOvX01G4coiIHUol94+ZQD0R/cx8LF1O9ojjoQIjcA/ozKvR19fkjIWdngiInufI7s2RG1ikFbdzGIy4qUn6W1czknFxCRPvB2w0wwqV65mLeBjvH50qeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417068; c=relaxed/simple;
	bh=5T3OWIKmr/DqZOg9iihaMK70a7qEwZ1a+OQN5e6XCeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnjyPWi8M1pVdR7bi2QdwqXLtUEeVWMpr+MC2qMRWDoWXgp6Vs7VRY5CYDC3Eg3kgpiUcuQ7ksTmeSNjMVUWJf77SlPE4nNQBHltcXGq8FlRxlNVK0kDuvvpMP70G4GAXCPyRWtRoRH5ILJymBf2Ka8D3aIR3QNdTguXtX00siY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NUOK8vlz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4J83zNpb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NUOK8vlz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4J83zNpb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NUOK8vlz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4J83zNpb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NUOK8vlz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4J83zNpb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6FB0521255;
	Fri, 23 Aug 2024 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724417064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3N+akNSXTFY8T4DxGnI/kWN3nmUzxYTyXXQz/P3gCAU=;
	b=NUOK8vlzbIiYOs8Az6AB3YMw8/BZ4pu0w4BoDZVLZPofszumEEA6JTtS/gWXGpq9scd6/H
	ayHuAD07Eyr6kZa9laIwf6hSE3ajkImy8JVYspfSqDXEVgFsHwa4PPbClZbRv1hYPXg6cL
	ImSz0hVcqA1aPHKf1zfiVTbpzlYB/lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724417064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3N+akNSXTFY8T4DxGnI/kWN3nmUzxYTyXXQz/P3gCAU=;
	b=4J83zNpbMeOtLtx9XFd3nf9IqcdXdmbJOEE5B5nTJudtIMFP/U13cjXXg/XJkJMAFb7BnI
	UgeUFQE8cnG3BqAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724417064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3N+akNSXTFY8T4DxGnI/kWN3nmUzxYTyXXQz/P3gCAU=;
	b=NUOK8vlzbIiYOs8Az6AB3YMw8/BZ4pu0w4BoDZVLZPofszumEEA6JTtS/gWXGpq9scd6/H
	ayHuAD07Eyr6kZa9laIwf6hSE3ajkImy8JVYspfSqDXEVgFsHwa4PPbClZbRv1hYPXg6cL
	ImSz0hVcqA1aPHKf1zfiVTbpzlYB/lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724417064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=3N+akNSXTFY8T4DxGnI/kWN3nmUzxYTyXXQz/P3gCAU=;
	b=4J83zNpbMeOtLtx9XFd3nf9IqcdXdmbJOEE5B5nTJudtIMFP/U13cjXXg/XJkJMAFb7BnI
	UgeUFQE8cnG3BqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DBDB1333E;
	Fri, 23 Aug 2024 12:44:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cHjsCSiEyGbKVwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 23 Aug 2024 12:44:24 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com,
	daniel@ffwll.ch,
	airlied@gmail.com,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/10] rm/bochs: Modernize driver
Date: Fri, 23 Aug 2024 14:28:43 +0200
Message-ID: <20240823124422.286989-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	FREEMAIL_TO(0.00)[redhat.com,ffwll.ch,gmail.com,kernel.org,linux.intel.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 

Bochs is lagging behind the overall state of DRM. This series gives
the driver an update.

Patch 1 removes duplicated functionality that is already handled
by the DRM core.

Patches 2 and 3 streamlines driver cleanup. Patch 2 reworks EDID
handling to follow current best practices. All buffers with EDID
data will now be cleaned up automatically. Patch 3 adds managed
cleanups for I/O resources. No fini function is needed.

Patches 4 to 6 embed struct drm_device in struct bochs_device and
remove all uses of dev_private.

Patch 7 replaces simple display helpers with regular atomic helpers.
The former are a mid-layer that is more often 'in the way' than helping.
Regular atomic helpers are composable with each other. Simple-pipe
is not.

Patch 8 replaces GEM VRAM with GEM SHMEM. The new memory manager
is more reliable and allows for larger resolutions. Display updates
were so slow that Gnome was unmanageable with a flickering cursor and
single FPS. The new memory management makes Gnome at least useable.

Patch 9 implements display-mode validation against the available video
memory. Modes should now be useable iff they passed mode_valid.

Patch 10 removes code from GEM VRAM helpers that is now no longer in
use.

Tested with qemu emulation.

Thomas Zimmermann (10):
  drm/bochs: Remove manual format test from fb_create
  drm/bochs: Use helpers for struct drm_edid
  drm/bochs: Do managed resource cleanup
  drm/bochs: Pass bochs device to various functions
  drm/bochs: Upcast with to_bochs_device()
  drm/bochs: Allocate DRM device in struct bochs_device
  drm/bochs: Use regular atomic helpers
  drm/bochs: Use GEM SHMEM helpers for memory management
  drm/bochs: Validate display modes against available video memory
  drm/gem-vram: Remove support for simple display pipelines

 drivers/gpu/drm/drm_gem_vram_helper.c |  45 ---
 drivers/gpu/drm/tiny/Kconfig          |   4 +-
 drivers/gpu/drm/tiny/bochs.c          | 384 +++++++++++++++-----------
 include/drm/drm_gem_vram_helper.h     |  13 -
 4 files changed, 224 insertions(+), 222 deletions(-)

-- 
2.46.0

