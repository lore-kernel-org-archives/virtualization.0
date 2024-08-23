Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FAC1865E7
	for <virtualization@lists.linux.dev>; Fri, 23 Aug 2024 12:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417070; cv=none; b=BBY2sHO3sAeS+sMTD33DRiL7HoUwz1HU2JCj35/UjJktAwcemmMISm2qGw3JErshb9pUH/VIeyPKL0k3N/wLUQxORhkKYUo6Hgr7OdSvU8DSQhe+NGTa1Q8OjUI8TwfoDBCcYi9o9cRcsk/fyxmDMabf9nm6WdltsaflD89Pu8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417070; c=relaxed/simple;
	bh=YeFPXMoUOv+tWqhDfYbCewojEb0Sl9/bbZSorIBMrjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p1amb9xJmuVkC3dKzk7Em9pEr5e6Dhnnde37AP1P567Za/LI8qJyhwKfMRddKG+pxqMANhwAolCZH5UScogSjXurbGPhWsKDhXgzfZMf83WtGFaGUb9nJt10RjLwI6AmlO6TxjTEUvQK89mdm208BGf1/5wcvbqPX/b1he/3V/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ABA9220317;
	Fri, 23 Aug 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75ADE13A61;
	Fri, 23 Aug 2024 12:44:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GKaPGyqEyGbKVwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 23 Aug 2024 12:44:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com,
	daniel@ffwll.ch,
	airlied@gmail.com,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 09/10] drm/bochs: Validate display modes against available video memory
Date: Fri, 23 Aug 2024 14:28:52 +0200
Message-ID: <20240823124422.286989-10-tzimmermann@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823124422.286989-1-tzimmermann@suse.de>
References: <20240823124422.286989-1-tzimmermann@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: ABA9220317
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

For each mode, test the required memory against the available video
memory. Filters out modes that do not fit into display memory.

Also remove the old test against the 4 MiB limit. It is now obsolete
and did not necessarily produce correct results.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/bochs.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index bde70a6075ec..b09c6c76923b 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -558,8 +558,28 @@ static const struct drm_connector_funcs bochs_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
+static enum drm_mode_status bochs_mode_config_mode_valid(struct drm_device *dev,
+							 const struct drm_display_mode *mode)
+{
+	struct bochs_device *bochs = to_bochs_device(dev);
+	const struct drm_format_info *format = drm_format_info(DRM_FORMAT_XRGB8888);
+	uint64_t pitch;
+
+	if (drm_WARN_ON(dev, !format))
+		return MODE_ERROR;
+
+	pitch = drm_format_info_min_pitch(format, 0, mode->vdisplay);
+	if (!pitch)
+		return MODE_BAD_WIDTH;
+	if (bochs->fb_size / pitch < mode->hdisplay)
+		return MODE_MEM;
+
+	return MODE_OK;
+}
+
 static const struct drm_mode_config_funcs bochs_mode_config_funcs = {
 	.fb_create = drm_gem_fb_create_with_dirty,
+	.mode_valid = bochs_mode_config_mode_valid,
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
@@ -687,15 +707,8 @@ static int bochs_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent
 {
 	struct bochs_device *bochs;
 	struct drm_device *dev;
-	unsigned long fbsize;
 	int ret;
 
-	fbsize = pci_resource_len(pdev, 0);
-	if (fbsize < 4 * 1024 * 1024) {
-		DRM_ERROR("less than 4 MB video memory, ignoring device\n");
-		return -ENOMEM;
-	}
-
 	ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &bochs_driver);
 	if (ret)
 		return ret;
-- 
2.46.0

