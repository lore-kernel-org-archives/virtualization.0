Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EAC185B70
	for <virtualization@lists.linux.dev>; Fri, 23 Aug 2024 12:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724417068; cv=none; b=COtbAJRJWb89zII2oDU4KPxIoCTAfVJ+Y9nwmolX/DY2eB1MPJ2IYyKiOMdJC/oB3hGbZeY7x7B+Gvq1aPRuETDYhRSaOCUbaeCo4ei61P//Ck+OJwR750pureaszagEjhloeQDJzISa7xqoEiuORFa9s12ZiNfOUFg8l1U4j2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724417068; c=relaxed/simple;
	bh=2YR2E3hz5hu4K51sGUTEeLxa8Hxs0GDe8ZzQaLYGv80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MI1hrAF0O1jOlX/znpAsn9RgKT2XlFY7zcz92/SRakmp1+dGFA+NXO2WusmStCKPthjAbKqh7r9iVY3BM93IgfeebcUsQGkiPz8cADSsAlP4zGGtLldxx4ldKdXOzjAV1fi+A/jWWbDDvkp9qMjmECLh8yA7d3I92jzs0jh3hZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6AFC20312;
	Fri, 23 Aug 2024 12:44:25 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6EFF113A61;
	Fri, 23 Aug 2024 12:44:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SHjLGSmEyGbKVwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 23 Aug 2024 12:44:25 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com,
	daniel@ffwll.ch,
	airlied@gmail.com,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 05/10] drm/bochs: Upcast with to_bochs_device()
Date: Fri, 23 Aug 2024 14:28:48 +0200
Message-ID: <20240823124422.286989-6-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: A6AFC20312
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

The dev_private field in struct drm_device is deprecated. Limit its
use by moving it into a helper function. A later change will remove
it entirely.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/bochs.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index acb2652577d4..61b2b7aa03cb 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -92,6 +92,11 @@ struct bochs_device {
 	struct drm_connector connector;
 };
 
+static struct bochs_device *to_bochs_device(const struct drm_device *dev)
+{
+	return (struct bochs_device *)dev->dev_private;
+}
+
 /* ---------------------------------------------------------------------- */
 
 static void bochs_vga_writeb(struct bochs_device *bochs, u16 ioport, u8 val)
@@ -191,7 +196,7 @@ static int bochs_get_edid_block(void *data, u8 *buf, unsigned int block, size_t
 static const struct drm_edid *bochs_hw_read_edid(struct drm_connector *connector)
 {
 	struct drm_device *dev = connector->dev;
-	struct bochs_device *bochs = dev->dev_private;
+	struct bochs_device *bochs = to_bochs_device(dev);
 	u8 header[8];
 
 	/* check header to detect whenever edid support is enabled in qemu */
@@ -420,7 +425,7 @@ static void bochs_pipe_enable(struct drm_simple_display_pipe *pipe,
 			      struct drm_crtc_state *crtc_state,
 			      struct drm_plane_state *plane_state)
 {
-	struct bochs_device *bochs = pipe->crtc.dev->dev_private;
+	struct bochs_device *bochs = to_bochs_device(pipe->crtc.dev);
 
 	bochs_hw_setmode(bochs, &crtc_state->mode);
 	bochs_plane_update(bochs, plane_state);
@@ -428,7 +433,7 @@ static void bochs_pipe_enable(struct drm_simple_display_pipe *pipe,
 
 static void bochs_pipe_disable(struct drm_simple_display_pipe *pipe)
 {
-	struct bochs_device *bochs = pipe->crtc.dev->dev_private;
+	struct bochs_device *bochs = to_bochs_device(pipe->crtc.dev);
 
 	bochs_hw_blank(bochs, true);
 }
@@ -436,7 +441,7 @@ static void bochs_pipe_disable(struct drm_simple_display_pipe *pipe)
 static void bochs_pipe_update(struct drm_simple_display_pipe *pipe,
 			      struct drm_plane_state *old_state)
 {
-	struct bochs_device *bochs = pipe->crtc.dev->dev_private;
+	struct bochs_device *bochs = to_bochs_device(pipe->crtc.dev);
 
 	bochs_plane_update(bochs, pipe->plane.state);
 }
-- 
2.46.0

