Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E488C636CC
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 16:15:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CC8B341744;
	Wed, 15 Feb 2023 16:15:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CC8B341744
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rO1VzL1s;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pdEHnDqK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4lMWWp3mTbJ4; Wed, 15 Feb 2023 16:15:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 16DB54174C;
	Wed, 15 Feb 2023 16:15:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 16DB54174C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D09B5C007D;
	Wed, 15 Feb 2023 16:15:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 23BCDC0033
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 600C340278
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 600C340278
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WNE5RXfAUzAO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1171F4173E
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1171F4173E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:33 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 44EC020623;
 Wed, 15 Feb 2023 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676477730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lrHZl8AETaVXT9eBQiWd6PbqrRgR6tEvkF9TypK9U7c=;
 b=rO1VzL1sNcdSd9mzC3Ze9i8Pj+MLBGxtkQDDjY4nghYIeqUBBP516WigSh6QgnLeH7R02R
 HwzVCyHbwMDkZpfZDLkxW61SYSPo4mwTRpUlqdPtX4K78sG8FkrtMiajs/C4Sy6CGmRtub
 ql/R7S8c3elgGzyyuaFc+TmMcMN3Tac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676477730;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lrHZl8AETaVXT9eBQiWd6PbqrRgR6tEvkF9TypK9U7c=;
 b=pdEHnDqKubeLRGq8/IRGZ0RGBfjiyxwB+1ubuutKPI5RS9oo7UpxLm9XO52kTcVuF4gLrC
 E4sCLkfmpgWKNUAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E9F813928;
 Wed, 15 Feb 2023 16:15:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EMwEGiEF7WNHOgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Feb 2023 16:15:29 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com, airlied@redhat.com, daniel@ffwll.ch, sam@ravnborg.org,
 javierm@redhat.com, dri-devel@lists.freedesktop.org
Subject: [PATCH 15/17] drm/cirrus: Introduce struct cirrus_primary_plane_state
Date: Wed, 15 Feb 2023 17:15:15 +0100
Message-Id: <20230215161517.5113-16-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230215161517.5113-1-tzimmermann@suse.de>
References: <20230215161517.5113-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

The cirrus driver maintains plane state, format and pitch, in it's
device structure. Introduce a plane state for the primary plane to
store the values.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/cirrus.c | 59 ++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index 8a1ae94d9106..ec6b918dce7b 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -74,6 +74,16 @@ struct cirrus_device {
 
 #define to_cirrus(_dev) container_of(_dev, struct cirrus_device, dev)
 
+struct cirrus_primary_plane_state {
+	struct drm_shadow_plane_state base;
+};
+
+static inline struct cirrus_primary_plane_state *
+to_cirrus_primary_plane_state(struct drm_plane_state *plane_state)
+{
+	return container_of(plane_state, struct cirrus_primary_plane_state, base.base);
+};
+
 /* ------------------------------------------------------------------ */
 /*
  * The meat of this driver. The core passes us a mode and we have to program
@@ -406,11 +416,58 @@ static const struct drm_plane_helper_funcs cirrus_primary_plane_helper_funcs = {
 	.atomic_update = cirrus_primary_plane_helper_atomic_update,
 };
 
+static struct drm_plane_state *
+cirrus_primary_plane_atomic_duplicate_state(struct drm_plane *plane)
+{
+	struct drm_plane_state *plane_state = plane->state;
+	struct cirrus_primary_plane_state *new_primary_plane_state;
+	struct drm_shadow_plane_state *new_shadow_plane_state;
+
+	if (!plane_state)
+		return NULL;
+
+	new_primary_plane_state = kzalloc(sizeof(*new_primary_plane_state), GFP_KERNEL);
+	if (!new_primary_plane_state)
+		return NULL;
+	new_shadow_plane_state = &new_primary_plane_state->base;
+
+	__drm_gem_duplicate_shadow_plane_state(plane, new_shadow_plane_state);
+
+	return &new_shadow_plane_state->base;
+}
+
+static void cirrus_primary_plane_atomic_destroy_state(struct drm_plane *plane,
+						      struct drm_plane_state *plane_state)
+{
+	struct cirrus_primary_plane_state *primary_plane_state =
+		to_cirrus_primary_plane_state(plane_state);
+
+	__drm_gem_destroy_shadow_plane_state(&primary_plane_state->base);
+	kfree(primary_plane_state);
+}
+
+static void cirrus_reset_primary_plane(struct drm_plane *plane)
+{
+	struct cirrus_primary_plane_state *primary_plane_state;
+
+	if (plane->state) {
+		cirrus_primary_plane_atomic_destroy_state(plane, plane->state);
+		plane->state = NULL; /* must be set to NULL here */
+	}
+
+	primary_plane_state = kzalloc(sizeof(*primary_plane_state), GFP_KERNEL);
+	if (!primary_plane_state)
+		return;
+	__drm_gem_reset_shadow_plane(plane, &primary_plane_state->base);
+}
+
 static const struct drm_plane_funcs cirrus_primary_plane_funcs = {
 	.update_plane = drm_atomic_helper_update_plane,
 	.disable_plane = drm_atomic_helper_disable_plane,
 	.destroy = drm_plane_cleanup,
-	DRM_GEM_SHADOW_PLANE_FUNCS,
+	.reset = cirrus_reset_primary_plane,
+	.atomic_duplicate_state = cirrus_primary_plane_atomic_duplicate_state,
+	.atomic_destroy_state = cirrus_primary_plane_atomic_destroy_state,
 };
 
 static int cirrus_crtc_helper_atomic_check(struct drm_crtc *crtc, struct drm_atomic_state *state)
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
