Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECA4C636D7
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 16:15:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0843880ADB;
	Wed, 15 Feb 2023 16:15:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0843880ADB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Qkx6Jo1e;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ropEMg2z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9AaSyzD88696; Wed, 15 Feb 2023 16:15:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5CD0D81F0D;
	Wed, 15 Feb 2023 16:15:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5CD0D81F0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A041C0078;
	Wed, 15 Feb 2023 16:15:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B9C92C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 950E040BF1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 950E040BF1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Qkx6Jo1e; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ropEMg2z
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WL4HOCrq0uDP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AACAF4012B
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AACAF4012B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:31 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DC0261FEA6;
 Wed, 15 Feb 2023 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676477727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Lz8YtMpwlaPc9vsob+e6Y4PRHQ9b8ltUxQiSOFrWPo=;
 b=Qkx6Jo1epm1H5ErGeXbFToLM20qzIAYR03gzunB1mLXEMoc5CRt7xFD8C/2PNM9yloqFri
 3W6rpkNdiHyLOiGrZd5WDwncreO70p9M8hcj2zEvaGh4rk8U7ySqO4ZmNDWaQfcy0H3IWv
 A3VAwi+UekmcECQN7/v07PghXIjpJdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676477727;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1Lz8YtMpwlaPc9vsob+e6Y4PRHQ9b8ltUxQiSOFrWPo=;
 b=ropEMg2zetOxate/v0evIEkNGf8g9W0HswefPhdXN0o335VdZGlpOhZbFnJ9rqE2v0zFN0
 4BMIsgSLl2p9bhBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6876E134BA;
 Wed, 15 Feb 2023 16:15:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QMLJFR8F7WNHOgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Feb 2023 16:15:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com, airlied@redhat.com, daniel@ffwll.ch, sam@ravnborg.org,
 javierm@redhat.com, dri-devel@lists.freedesktop.org
Subject: [PATCH 10/17] drm/cirrus: Inline cirrus_fb_blit_rect()
Date: Wed, 15 Feb 2023 17:15:10 +0100
Message-Id: <20230215161517.5113-11-tzimmermann@suse.de>
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

Inline cirrus_fb_blit_rect into its only caller. While at it, update
the code to use IOSYS_MAP_INIT_OFFSET(), which is the ideomatic way
of initializing struct iosys_map with an offset.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/cirrus.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index 46c6aa34ba79..a483abc2e6ba 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -317,21 +317,6 @@ static void cirrus_pitch_set(struct cirrus_device *cirrus,
 	cirrus_set_start_address(cirrus, 0);
 }
 
-static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
-			       const struct iosys_map *vmap,
-			       struct drm_rect *rect)
-{
-	struct cirrus_device *cirrus = to_cirrus(fb->dev);
-	struct iosys_map dst;
-
-	iosys_map_set_vaddr_iomem(&dst, cirrus->vram);
-	iosys_map_incr(&dst, drm_fb_clip_offset(cirrus->pitch, fb->format, rect));
-
-	drm_fb_blit(&dst, &cirrus->pitch, cirrus->format->format, vmap, fb, rect);
-
-	return 0;
-}
-
 static int cirrus_check_size(int width, int height,
 			     struct drm_framebuffer *fb)
 {
@@ -393,6 +378,7 @@ static void cirrus_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
+	struct iosys_map vaddr = IOSYS_MAP_INIT_VADDR_IOMEM(cirrus->vram);
 	struct drm_atomic_helper_damage_iter iter;
 	struct drm_rect damage;
 	int idx;
@@ -410,7 +396,11 @@ static void cirrus_primary_plane_helper_atomic_update(struct drm_plane *plane,
 
 	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
 	drm_atomic_for_each_plane_damage(&iter, &damage) {
-		cirrus_fb_blit_rect(fb, &shadow_plane_state->data[0], &damage);
+		unsigned int offset = drm_fb_clip_offset(cirrus->pitch, fb->format, &damage);
+		struct iosys_map dst = IOSYS_MAP_INIT_OFFSET(&vaddr, offset);
+
+		drm_fb_blit(&dst, &cirrus->pitch, cirrus->format->format,
+			    &shadow_plane_state->data[0], fb, &damage);
 	}
 
 	drm_dev_exit(idx);
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
