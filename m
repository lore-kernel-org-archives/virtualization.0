Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EEC1F4282
	for <virtualization@lists.linux.dev>; Fri, 11 Jul 2025 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752226905; cv=none; b=WYkMbarfbCJ3JFRmT/2RHwdmUZ3BC+VygdoLWkhHFSbgq7xNcrNMMG8wbmVp3u061a+dQodBKf5TQgxZxhV5H0NaTA213Oy8XLNGCVibcHt5oLAERoLozNFq2kMSuxOMxIpqHloGyEVo/2Qto1V6/C0U1Ur++udvB/xmU+QpKO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752226905; c=relaxed/simple;
	bh=83++whlltaFvHgk5A3njx/j9KTU8hOMKAX5D4npk+M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sk0P3vBd/fBOOD0HnY5i40o4WjBpRyJpl5b3jZGclAERRvowYqG9RLOke6c+tfxzZDrxvpc0xyghX5Q9WYVlMTQqv6P0wKsks115vY0AK7pxuh9oOYt46LQghnsylmnjvxRFry46k4WMqTWFLAI0hg7vJUnDGHVVnh25EVMLE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1113A1F7B6;
	Fri, 11 Jul 2025 09:40:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 837E91388B;
	Fri, 11 Jul 2025 09:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eNrFHirccGjbcAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 11 Jul 2025 09:40:58 +0000
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
Subject: [PATCH 6/9] Revert "drm/prime: Use dma_buf from GEM object instance"
Date: Fri, 11 Jul 2025 11:35:21 +0200
Message-ID: <20250711093744.120962-7-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: 1113A1F7B6
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00

This reverts commit f83a9b8c7fd0557b0c50784bfdc1bbe9140c9bf8.

Reverting because the fix-up commits are suspected to cause regressions.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_prime.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
index b703f83874e1..a23fc712a8b7 100644
--- a/drivers/gpu/drm/drm_prime.c
+++ b/drivers/gpu/drm/drm_prime.c
@@ -453,7 +453,13 @@ struct dma_buf *drm_gem_prime_handle_to_dmabuf(struct drm_device *dev,
 	}
 
 	mutex_lock(&dev->object_name_lock);
-	/* re-export the original imported/exported object */
+	/* re-export the original imported object */
+	if (obj->import_attach) {
+		dmabuf = obj->import_attach->dmabuf;
+		get_dma_buf(dmabuf);
+		goto out_have_obj;
+	}
+
 	if (obj->dma_buf) {
 		get_dma_buf(obj->dma_buf);
 		dmabuf = obj->dma_buf;
-- 
2.50.0

