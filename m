Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E592BE7DB
	for <virtualization@lists.linux.dev>; Mon, 14 Apr 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636689; cv=none; b=QbztY98uE9y9jMO1jTFKAZvFAhpQhtWsex7QvV4tlWf16GAv7C1HcWY7hJaw6IYSKZy05lsbKr0+8c2SySwip5CS6YTNToLc1KIzyOsnI5FX2U/OKxL15YgMMeoqdxmcAZWtubyNa36D33LGMjV708mUz57Y2bx0Ub0Y+aFqwFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636689; c=relaxed/simple;
	bh=pUGXne/bsfhC3Pkct9bNidQmEfw0qzAlQ96OUI8wPyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o43zRE57vMRtUYaq1ZaPkxenq3/16rFVbYvoL+rGUHKNvR5Rs7LQNLuTlEdyz81xnY3zv6tz6KXmGeFZPxaUOdoWOJQBPWNzf1GiJ/HT8slTmahcLokbFEFVIFf4CA+WtQ6AuvQx5o3ZU3NvJqOBXcFbYjpOtyBJkmCXoAc6VIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tFZob+vl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E+E9/xSZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tFZob+vl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=E+E9/xSZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tFZob+vl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E+E9/xSZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tFZob+vl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="E+E9/xSZ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B6EE1F80E;
	Mon, 14 Apr 2025 13:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744636686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=avi7q3Yv6HSuADiU1OQuL60U0D4yIqorgGlu6a46MNs=;
	b=tFZob+vldQ/bVihy6IaDx+GmzeenKEjaL/EEgdL3c8apBkRRbBX6WzUB/+gkIvE8O8tBDp
	NjC3F9dtPPiirO/kacUtjtuBwK3OonfMk0I/3ffcuBK6+ZDYIvqWE403Kl6Xl0cJjzdCtE
	/oQYXdj67BcohCloPZic4C2Rlnq/jA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744636686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=avi7q3Yv6HSuADiU1OQuL60U0D4yIqorgGlu6a46MNs=;
	b=E+E9/xSZpseHdnWoaqUFZkpAQFa8UP4fPkdqmon+QYSGvmTwH15eI876bPio9ZZZxnB0AW
	RC6K9K8/6Nfe1/CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1744636686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=avi7q3Yv6HSuADiU1OQuL60U0D4yIqorgGlu6a46MNs=;
	b=tFZob+vldQ/bVihy6IaDx+GmzeenKEjaL/EEgdL3c8apBkRRbBX6WzUB/+gkIvE8O8tBDp
	NjC3F9dtPPiirO/kacUtjtuBwK3OonfMk0I/3ffcuBK6+ZDYIvqWE403Kl6Xl0cJjzdCtE
	/oQYXdj67BcohCloPZic4C2Rlnq/jA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1744636686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=avi7q3Yv6HSuADiU1OQuL60U0D4yIqorgGlu6a46MNs=;
	b=E+E9/xSZpseHdnWoaqUFZkpAQFa8UP4fPkdqmon+QYSGvmTwH15eI876bPio9ZZZxnB0AW
	RC6K9K8/6Nfe1/CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D01D8136A7;
	Mon, 14 Apr 2025 13:18:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N3+IMQ0L/WfYeQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 14 Apr 2025 13:18:05 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com,
	dmitry.osipenko@collabora.com,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/2] drm/virtio: Avoid struct drm_gem_object.import_attach
Date: Mon, 14 Apr 2025 15:11:59 +0200
Message-ID: <20250414131507.566072-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[redhat.com,collabora.com,chromium.org,gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -2.80
X-Spam-Flag: NO

Avoid the use of struct drm_gem_object.import_attach to get the
object's dma-buf or test for an imported buffer. The import_attach
field in struct drm_gem_object is an artifact of the import process,
but should not be used otherwise.

The helper drm_gem_is_imported() tests if a GEM object's buffer
has been imported into the driver. The corresponding dma-buf is
referenced by the object itself. Both cases avoid import_attach.

Thomas Zimmermann (2):
  drm/virtio: Test for imported buffers with drm_gem_is_imported()
  drm/virtio: Use dma_buf from GEM object instance

 drivers/gpu/drm/virtio/virtgpu_plane.c | 8 ++++----
 drivers/gpu/drm/virtio/virtgpu_prime.c | 7 +++----
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.49.0

