Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787B617BEB2
	for <virtualization@lists.linux.dev>; Mon,  2 Sep 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274553; cv=none; b=gfO4LIKcW0wT+QP/Y0r7dK7ZYrWchAL8fhNy1h/MW0ScID3X531TEa8wZFc4IXLTvp37mE5/Nf+ReZBsXkhova6nHuoFUHUgU0gRMidRAxzzwrm5JYBJVstzPnx9eT6C3L55tpPpBfMqNIUcr5tWHHRLnRpDjGQu+umLelH0Yv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274553; c=relaxed/simple;
	bh=8RxZG0Xwx0RtyePwgmsBZ8UVqJoNZGzJirht5A5KIkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzwQvmoIkdVy0b5+ZJ+hwWbg3YEKD6blUtb91uJaIhtlDvnbRKDTUIgw1jtz5G9z1WpITzUZVEIJj4hKpBJ5JNg8KovHx+4k5TqMRrZl2YRnX/GVCMSPBOu3RXeCscclpe3JkbRDGfx+QKfIVIm9TWhzDHtJcSzaoWqtfyvqD8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCD7E1FBA6;
	Mon,  2 Sep 2024 10:55:49 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84F4613A7C;
	Mon,  2 Sep 2024 10:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WGM0H7WZ1WZQcAAAD6G6ig
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
Subject: [PATCH v2 04/10] drm/bochs: Pass bochs device to various functions
Date: Mon,  2 Sep 2024 12:53:42 +0200
Message-ID: <20240902105546.792625-5-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: BCD7E1FBA6
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Avoid upcasting from struct drm_device by passing the bochs device
directly to functions.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/tiny/bochs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 5d09b4cb28ed..acb2652577d4 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -204,9 +204,9 @@ static const struct drm_edid *bochs_hw_read_edid(struct drm_connector *connector
 	return drm_edid_read_custom(connector, bochs_get_edid_block, bochs);
 }
 
-static int bochs_hw_init(struct drm_device *dev)
+static int bochs_hw_init(struct bochs_device *bochs)
 {
-	struct bochs_device *bochs = dev->dev_private;
+	struct drm_device *dev = bochs->dev;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	unsigned long addr, size, mem, ioaddr, iosize;
 	u16 id;
@@ -481,9 +481,9 @@ static const struct drm_connector_funcs bochs_connector_connector_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
-static void bochs_connector_init(struct drm_device *dev)
+static void bochs_connector_init(struct bochs_device *bochs)
 {
-	struct bochs_device *bochs = dev->dev_private;
+	struct drm_device *dev = bochs->dev;
 	struct drm_connector *connector = &bochs->connector;
 
 	drm_connector_init(dev, connector, &bochs_connector_connector_funcs,
@@ -516,7 +516,7 @@ static int bochs_kms_init(struct bochs_device *bochs)
 
 	bochs->dev->mode_config.funcs = &bochs_mode_funcs;
 
-	bochs_connector_init(bochs->dev);
+	bochs_connector_init(bochs);
 	drm_simple_display_pipe_init(bochs->dev,
 				     &bochs->pipe,
 				     &bochs_pipe_funcs,
@@ -544,7 +544,7 @@ static int bochs_load(struct drm_device *dev)
 	dev->dev_private = bochs;
 	bochs->dev = dev;
 
-	ret = bochs_hw_init(dev);
+	ret = bochs_hw_init(bochs);
 	if (ret)
 		return ret;
 
-- 
2.46.0

