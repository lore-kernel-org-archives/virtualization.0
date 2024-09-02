Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B206814A4E0
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274553; cv=none; b=UsVfPiCS5JZRFXmKf4l79DaI4h4hcxmlH59DRiC9/JSTAb6uzdSJRvxlLNzIZGCMVLJII97TCTPxmzb8Haciwxfg+VmwsFfOD7QI7bMMsqgIvLqflCDC5a6kZg7Kw36npbZ9+C9Um/Gte1oBeTEg0R9JO9iHahM0j75efA2SMqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274553; c=relaxed/simple;
	bh=AWHXdKb9wykc2F31oLcmdOnb2AbYVPcg0QO8t9XyfmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ap6eMghHqJVc9YiD8YixV5SXzlSEnmKytNy+wQeIsQ/MceZGKWY8oTIRddbspu6Eu4LUW0qGX6b6akJUoAq6fP7Omz497PYoJsJXkaODommFdwrQV9F2XmzueWVprtgPXinhdY3NW8nzKvnVDzXYEDZtvV+B1C1b9N1XpeqKM88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 063441FBA8;
	Mon,  2 Sep 2024 10:55:50 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C297213AE5;
	Mon,  2 Sep 2024 10:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WPJULrWZ1WZQcAAAD6G6ig
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
Subject: [PATCH v2 05/10] drm/bochs: Upcast with to_bochs_device()
Date: Mon,  2 Sep 2024 12:53:43 +0200
Message-ID: <20240902105546.792625-6-tzimmermann@suse.de>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 063441FBA8
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

The dev_private field in struct drm_device is deprecated. Limit its
use by moving it into a helper function. A later change will remove
it entirely.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
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

