Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11A0261396
	for <virtualization@lists.linux.dev>; Tue, 25 Mar 2025 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742923252; cv=none; b=u+B0igUaHK/u9HN4Ub+Qp9bdJ7JqITtLx9Fb/4e2JhE7VvFJjog6/vIvHQzy5/jIFTIhvQxTBKTLfiAtXkVCZ8dvAbSXRG7KJKjbx9sOhWZtxBFpo5TGwqYoLEBYPU7fOmTAF50JuWfXtMvQmTPDjpr1KrQDWF7jMjLCdZfwSy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742923252; c=relaxed/simple;
	bh=6Tfu8sMOCW1FwfpbPmPqOAWPZW741K43C6W0iy4kRvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSAZLSuEDVYJRy8KQGaxmo1iPXxvy8+KzICDUqweQ9IzTs/UuwkzjEmu1bC9OtLg/ysmJoVB9x3RBF1dH3q3CRrYnu0LStWyp+gHDzTEs+JSjkZHXg6h8MFiPg49Ho1rWgsbOZzrUvVPP1y9D1A4i/S1hphG2VL1Dp0iev0QjUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB0D21F397;
	Tue, 25 Mar 2025 17:20:42 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A609713957;
	Tue, 25 Mar 2025 17:20:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iCJMJ+rl4mfzWAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 25 Mar 2025 17:20:42 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com,
	airlied@redhat.com
Cc: virtualization@lists.linux.dev,
	dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/4] drm/cirrus-qemu: Remove custom plane state
Date: Tue, 25 Mar 2025 18:12:52 +0100
Message-ID: <20250325171716.154097-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325171716.154097-1-tzimmermann@suse.de>
References: <20250325171716.154097-1-tzimmermann@suse.de>
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
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: DB0D21F397
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

Remove struct cirrus_primary_plane_state and its helpers, which
are all unused. Use struct drm_shadow_plane_state instead.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/cirrus-qemu.c | 59 +-----------------------------
 1 file changed, 1 insertion(+), 58 deletions(-)

diff --git a/drivers/gpu/drm/tiny/cirrus-qemu.c b/drivers/gpu/drm/tiny/cirrus-qemu.c
index 76744394e2a3..ccf3f6551344 100644
--- a/drivers/gpu/drm/tiny/cirrus-qemu.c
+++ b/drivers/gpu/drm/tiny/cirrus-qemu.c
@@ -70,16 +70,6 @@ struct cirrus_device {
 
 #define to_cirrus(_dev) container_of(_dev, struct cirrus_device, dev)
 
-struct cirrus_primary_plane_state {
-	struct drm_shadow_plane_state base;
-};
-
-static inline struct cirrus_primary_plane_state *
-to_cirrus_primary_plane_state(struct drm_plane_state *plane_state)
-{
-	return container_of(plane_state, struct cirrus_primary_plane_state, base.base);
-};
-
 /* ------------------------------------------------------------------ */
 /*
  * The meat of this driver. The core passes us a mode and we have to program
@@ -374,58 +364,11 @@ static const struct drm_plane_helper_funcs cirrus_primary_plane_helper_funcs = {
 	.atomic_update = cirrus_primary_plane_helper_atomic_update,
 };
 
-static struct drm_plane_state *
-cirrus_primary_plane_atomic_duplicate_state(struct drm_plane *plane)
-{
-	struct drm_plane_state *plane_state = plane->state;
-	struct cirrus_primary_plane_state *new_primary_plane_state;
-	struct drm_shadow_plane_state *new_shadow_plane_state;
-
-	if (!plane_state)
-		return NULL;
-
-	new_primary_plane_state = kzalloc(sizeof(*new_primary_plane_state), GFP_KERNEL);
-	if (!new_primary_plane_state)
-		return NULL;
-	new_shadow_plane_state = &new_primary_plane_state->base;
-
-	__drm_gem_duplicate_shadow_plane_state(plane, new_shadow_plane_state);
-
-	return &new_shadow_plane_state->base;
-}
-
-static void cirrus_primary_plane_atomic_destroy_state(struct drm_plane *plane,
-						      struct drm_plane_state *plane_state)
-{
-	struct cirrus_primary_plane_state *primary_plane_state =
-		to_cirrus_primary_plane_state(plane_state);
-
-	__drm_gem_destroy_shadow_plane_state(&primary_plane_state->base);
-	kfree(primary_plane_state);
-}
-
-static void cirrus_reset_primary_plane(struct drm_plane *plane)
-{
-	struct cirrus_primary_plane_state *primary_plane_state;
-
-	if (plane->state) {
-		cirrus_primary_plane_atomic_destroy_state(plane, plane->state);
-		plane->state = NULL; /* must be set to NULL here */
-	}
-
-	primary_plane_state = kzalloc(sizeof(*primary_plane_state), GFP_KERNEL);
-	if (!primary_plane_state)
-		return;
-	__drm_gem_reset_shadow_plane(plane, &primary_plane_state->base);
-}
-
 static const struct drm_plane_funcs cirrus_primary_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = drm_plane_cleanup,
-	.reset = cirrus_reset_primary_plane,
-	.atomic_duplicate_state = cirrus_primary_plane_atomic_duplicate_state,
-	.atomic_destroy_state = cirrus_primary_plane_atomic_destroy_state,
+	DRM_GEM_SHADOW_PLANE_FUNCS,
 };
 
 static int cirrus_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
-- 
2.48.1

