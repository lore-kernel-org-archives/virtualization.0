Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4A7347B
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274554; cv=none; b=oODRQ3jJrmhFnSW/BJz5IfNDPl1DNox/Y89MYSEe9+GSJ2aV5k1UiqpraSacPDlO1dPpLkOKq/py9XBxqicxo2DcTv34rKUFG4k92bRfslG12C2krOptsVM+JUbfD7SjukARwTKRsX6wvZ/DtFJ4k1tTbIwry1LXDOpjv0FNIfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274554; c=relaxed/simple;
	bh=PMyyuG/5RXOMbpiABYZc1c7F3kW6JlsCUB1CcDt1Pq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCPngPYh8NZgaz5LnL32ET7fHXD1cEfs43JMjg1cXPMcUKxI09ZihQiXT4El+u7yhk8FNY05iyPsPwTo/ehyLfFEwDwepaN/2NQAJ8cU930Jq7TXjnoFtELun+2fih5L9BkrWz1TVqrHA9RTYVTcgP1y+w74FVHC2NS7hNUsazE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EA/vqMwu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4XeX8nxN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EA/vqMwu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4XeX8nxN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EA/vqMwu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4XeX8nxN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EA/vqMwu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4XeX8nxN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4232E1FBA5;
	Mon,  2 Sep 2024 10:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725274549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQqkq9lU5DfLvQK11OEAscnf5N+dQYhgVOQxSBRE/lY=;
	b=EA/vqMwur4N+71cmUhdUJuPsBra4G4S4pxskYjEN4t0otWk0jvfuAM21p16evsWM95ghOx
	ZG8/CSmiwIAhbYDA+kG7XqZUpERRXH1YbHqbEpfES9zgKQg/MxR0fO/wFbV9lwJqAfG7M+
	AZSdmW3LoioPczNWdDg5VoBewlMkvNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725274549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQqkq9lU5DfLvQK11OEAscnf5N+dQYhgVOQxSBRE/lY=;
	b=4XeX8nxNF9ehH8/M8/zvoOom2Aj14nE4dgiXjlgfXvZO1rDUNi7/1hp2du9vGgvHARocCE
	B1pv4ZEc+CvaZIAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725274549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQqkq9lU5DfLvQK11OEAscnf5N+dQYhgVOQxSBRE/lY=;
	b=EA/vqMwur4N+71cmUhdUJuPsBra4G4S4pxskYjEN4t0otWk0jvfuAM21p16evsWM95ghOx
	ZG8/CSmiwIAhbYDA+kG7XqZUpERRXH1YbHqbEpfES9zgKQg/MxR0fO/wFbV9lwJqAfG7M+
	AZSdmW3LoioPczNWdDg5VoBewlMkvNM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725274549;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lQqkq9lU5DfLvQK11OEAscnf5N+dQYhgVOQxSBRE/lY=;
	b=4XeX8nxNF9ehH8/M8/zvoOom2Aj14nE4dgiXjlgfXvZO1rDUNi7/1hp2du9vGgvHARocCE
	B1pv4ZEc+CvaZIAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A70013A7C;
	Mon,  2 Sep 2024 10:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qJhZAbWZ1WZQcAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Sep 2024 10:55:49 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com,
	daniel@ffwll.ch,
	airlied@gmail.com,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 02/10] drm/bochs: Use helpers for struct drm_edid
Date: Mon,  2 Sep 2024 12:53:40 +0200
Message-ID: <20240902105546.792625-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902105546.792625-1-tzimmermann@suse.de>
References: <20240902105546.792625-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[redhat.com,ffwll.ch,gmail.com,kernel.org,linux.intel.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -6.80
X-Spam-Flag: NO

Implement a read function for struct drm_edid and read the EDID data
with drm_edit_read_custom(). Update the connector data accordingly.

The EDID data comes from the emulator itself and the connector stores
a copy in its EDID property. The drm_edid field in struct bochs_device
is therefore not required. Remove it.

If qemu provides no EDID data, install default display modes as before.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/tiny/bochs.c | 48 +++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 47a45a14306c..197fc00b373f 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -85,7 +85,6 @@ struct bochs_device {
 	u16 yres_virtual;
 	u32 stride;
 	u32 bpp;
-	const struct drm_edid *drm_edid;
 
 	/* drm */
 	struct drm_device *dev;
@@ -172,12 +171,14 @@ static void bochs_hw_set_little_endian(struct bochs_device *bochs)
 #define bochs_hw_set_native_endian(_b) bochs_hw_set_little_endian(_b)
 #endif
 
-static int bochs_get_edid_block(void *data, u8 *buf,
-				unsigned int block, size_t len)
+static int bochs_get_edid_block(void *data, u8 *buf, unsigned int block, size_t len)
 {
 	struct bochs_device *bochs = data;
 	size_t i, start = block * EDID_LENGTH;
 
+	if (!bochs->mmio)
+		return -1;
+
 	if (start + len > 0x400 /* vga register offset */)
 		return -1;
 
@@ -187,25 +188,20 @@ static int bochs_get_edid_block(void *data, u8 *buf,
 	return 0;
 }
 
-static int bochs_hw_load_edid(struct bochs_device *bochs)
+static const struct drm_edid *bochs_hw_read_edid(struct drm_connector *connector)
 {
+	struct drm_device *dev = connector->dev;
+	struct bochs_device *bochs = dev->dev_private;
 	u8 header[8];
 
-	if (!bochs->mmio)
-		return -1;
-
 	/* check header to detect whenever edid support is enabled in qemu */
 	bochs_get_edid_block(bochs, header, 0, ARRAY_SIZE(header));
 	if (drm_edid_header_is_valid(header) != 8)
-		return -1;
+		return NULL;
 
-	drm_edid_free(bochs->drm_edid);
-	bochs->drm_edid = drm_edid_read_custom(&bochs->connector,
-					       bochs_get_edid_block, bochs);
-	if (!bochs->drm_edid)
-		return -1;
+	drm_dbg(dev, "Found EDID data blob.\n");
 
-	return 0;
+	return drm_edid_read_custom(connector, bochs_get_edid_block, bochs);
 }
 
 static int bochs_hw_init(struct drm_device *dev)
@@ -303,7 +299,6 @@ static void bochs_hw_fini(struct drm_device *dev)
 	if (bochs->fb_map)
 		iounmap(bochs->fb_map);
 	pci_release_regions(to_pci_dev(dev->dev));
-	drm_edid_free(bochs->drm_edid);
 }
 
 static void bochs_hw_blank(struct bochs_device *bochs, bool blank)
@@ -469,21 +464,28 @@ static const struct drm_simple_display_pipe_funcs bochs_pipe_funcs = {
 	.cleanup_fb = drm_gem_vram_simple_display_pipe_cleanup_fb,
 };
 
-static int bochs_connector_get_modes(struct drm_connector *connector)
+static int bochs_connector_helper_get_modes(struct drm_connector *connector)
 {
+	const struct drm_edid *edid;
 	int count;
 
-	count = drm_edid_connector_add_modes(connector);
+	edid = bochs_hw_read_edid(connector);
 
-	if (!count) {
+	if (edid) {
+		drm_edid_connector_update(connector, edid);
+		count = drm_edid_connector_add_modes(connector);
+		drm_edid_free(edid);
+	} else {
+		drm_edid_connector_update(connector, NULL);
 		count = drm_add_modes_noedid(connector, 8192, 8192);
 		drm_set_preferred_mode(connector, defx, defy);
 	}
+
 	return count;
 }
 
 static const struct drm_connector_helper_funcs bochs_connector_connector_helper_funcs = {
-	.get_modes = bochs_connector_get_modes,
+	.get_modes = bochs_connector_helper_get_modes,
 };
 
 static const struct drm_connector_funcs bochs_connector_connector_funcs = {
@@ -501,14 +503,8 @@ static void bochs_connector_init(struct drm_device *dev)
 
 	drm_connector_init(dev, connector, &bochs_connector_connector_funcs,
 			   DRM_MODE_CONNECTOR_VIRTUAL);
+	drm_connector_attach_edid_property(connector);
 	drm_connector_helper_add(connector, &bochs_connector_connector_helper_funcs);
-
-	bochs_hw_load_edid(bochs);
-	if (bochs->drm_edid) {
-		DRM_INFO("Found EDID data blob.\n");
-		drm_connector_attach_edid_property(connector);
-		drm_edid_connector_update(&bochs->connector, bochs->drm_edid);
-	}
 }
 
 static const struct drm_mode_config_funcs bochs_mode_funcs = {
-- 
2.46.0

