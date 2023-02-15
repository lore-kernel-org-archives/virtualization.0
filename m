Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B66C64ED8
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 16:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 58FB740884;
	Wed, 15 Feb 2023 16:15:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 58FB740884
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=1iYrfqgJ;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VBx5lfZI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f1q1usgQIFV4; Wed, 15 Feb 2023 16:15:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9C28041725;
	Wed, 15 Feb 2023 16:15:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9C28041725
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8053AC0033;
	Wed, 15 Feb 2023 16:15:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73C04C0085
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D0756116F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D0756116F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=1iYrfqgJ; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=VBx5lfZI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1MZ9To1_2BfH
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFC3E61168
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFC3E61168
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:15:30 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 499AE3399F;
 Wed, 15 Feb 2023 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676477727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+B95xkA2xVnz+6CgGcPRUJusPpgeES0t/M9GUw7O8E=;
 b=1iYrfqgJ7Z7NRGGVeABzZhSlfRmdh6pmB+hI03BM+O1lSmkB4JIAE6YGZFtCLKOHUxz2IG
 kvlm+oQoCO+aQSVdss03Mk2r4Js6PnCOhQ99cmctwRtpgedTP9jcxXJZ0ygoHS3R99uRN7
 cN7ehd8rwQjEUSPX55A6ZhYmxCrw2gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676477727;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+B95xkA2xVnz+6CgGcPRUJusPpgeES0t/M9GUw7O8E=;
 b=VBx5lfZINJ+wA5TaTlv992QsnPpY9mfb3L69iSUa+pS9ni5lw6MsW8mJlvY9sX4I34/5vL
 ZLK5bb6xbYTSEqCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA82D134BA;
 Wed, 15 Feb 2023 16:15:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AKeeIx4F7WNHOgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Feb 2023 16:15:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com, airlied@redhat.com, daniel@ffwll.ch, sam@ravnborg.org,
 javierm@redhat.com, dri-devel@lists.freedesktop.org
Subject: [PATCH 09/17] drm/cirrus: Enable damage clipping on primary plane
Date: Wed, 15 Feb 2023 17:15:09 +0100
Message-Id: <20230215161517.5113-10-tzimmermann@suse.de>
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

Enable damage clipping on the primary plane and iterate over small
areas of reported framebuffer damage. Avoid the overhead of permanent
full-screen updates that cirrus currently implements.

This problem is indicated by the warning

  drm_plane_enable_fb_damage_clips() not called

in the kernel's log. Without damage clipping, drivers do full updates
of the screen area. This is costly as many screen updates, such as
cursor movement or command-line input, only change a small portion
of the output. Damage clipping allows renderers to inform drivers about
the changed areas.

With the damage information known, cirrus now iterates over a list of
change areas and only flushes those to the hardware's scanout buffer.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/cirrus.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index af26de9ef329..46c6aa34ba79 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -393,7 +393,8 @@ static void cirrus_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(state, plane);
-	struct drm_rect rect;
+	struct drm_atomic_helper_damage_iter iter;
+	struct drm_rect damage;
 	int idx;
 
 	if (!fb)
@@ -407,8 +408,10 @@ static void cirrus_primary_plane_helper_atomic_update(struct drm_plane *plane,
 	if (cirrus->pitch != cirrus_pitch(fb))
 		cirrus_pitch_set(cirrus, fb);
 
-	if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &rect))
-		cirrus_fb_blit_rect(fb, &shadow_plane_state->data[0], &rect);
+	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
+	drm_atomic_for_each_plane_damage(&iter, &damage) {
+		cirrus_fb_blit_rect(fb, &shadow_plane_state->data[0], &damage);
+	}
 
 	drm_dev_exit(idx);
 }
@@ -529,6 +532,7 @@ static int cirrus_pipe_init(struct cirrus_device *cirrus)
 	if (ret)
 		return ret;
 	drm_plane_helper_add(primary_plane, &cirrus_primary_plane_helper_funcs);
+	drm_plane_enable_fb_damage_clips(primary_plane);
 
 	crtc = &cirrus->crtc;
 	ret = drm_crtc_init_with_planes(dev, crtc, primary_plane, NULL,
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
