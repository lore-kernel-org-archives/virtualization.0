Return-Path: <SRS0=yluT=M2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6269C19F39
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 12:59:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87B3560F93
	for <virtualization@archiver.kernel.org>; Tue,  3 Aug 2021 12:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 87B3560F93
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id ED9DC4035D;
	Tue,  3 Aug 2021 12:59:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TukqMwwhDFJp; Tue,  3 Aug 2021 12:59:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DB204403EC;
	Tue,  3 Aug 2021 12:59:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59DADC0025;
	Tue,  3 Aug 2021 12:59:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11FDEC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7388F400F2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:59:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ET4szw0p4Ab0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:59:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 742FD4034F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Aug 2021 12:59:36 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 86F5222016;
 Tue,  3 Aug 2021 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627995574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7jByc2WvtT3zcwlbXuuN7cwQBMDHASxS+hh4HhGEn0k=;
 b=wOXY1Jksu/KR4gY892FbdRkR6wRfCIDalLykk8hDShzFMZ8w1c6a2J3/Bx1vyR8x10WbeL
 bDnpAYE1f5OQtbXeQELUkyn0A7QYxjxOYLjYi1cjlHhT0S6kqj/eRcDIpFxLRMw/h2DfLz
 o759GKI+fNoSyaZxgKq/m3vO/g/creQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627995574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7jByc2WvtT3zcwlbXuuN7cwQBMDHASxS+hh4HhGEn0k=;
 b=H61hNhGEQmau/v6quCTHDCtBwPzXT09NHUjX3RO/iyVcGlCRAu1dJkQCw/hE0uDDRpItky
 Wlbpq3j9e3/6p7AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04DCC13CD6;
 Tue,  3 Aug 2021 12:59:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GPlTO7U9CWExZwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Tue, 03 Aug 2021 12:59:33 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, noralf@tronnes.org,
 drawat.floss@gmail.com, kraxel@redhat.com, hdegoede@redhat.com,
 sean@poorly.run, rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 sam@ravnborg.org
Subject: [PATCH 07/11] drm/gm12u320: Use offset-adjusted shadow-plane mappings
Date: Tue,  3 Aug 2021 14:59:24 +0200
Message-Id: <20210803125928.27780-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803125928.27780-1-tzimmermann@suse.de>
References: <20210803125928.27780-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

For framebuffers with non-zero offset fields, shadow-plane helpers
provide a pointer to the first byte of the contained data. Use it in
gm12u320.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/gm12u320.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u320.c
index cf7287fccd72..6bc0c298739c 100644
--- a/drivers/gpu/drm/tiny/gm12u320.c
+++ b/drivers/gpu/drm/tiny/gm12u320.c
@@ -554,7 +554,7 @@ static void gm12u320_pipe_enable(struct drm_simple_display_pipe *pipe,
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 
 	gm12u320->fb_update.draw_status_timeout = FIRST_FRAME_TIMEOUT;
-	gm12u320_fb_mark_dirty(plane_state->fb, &shadow_plane_state->map[0], &rect);
+	gm12u320_fb_mark_dirty(plane_state->fb, &shadow_plane_state->data[0], &rect);
 }
 
 static void gm12u320_pipe_disable(struct drm_simple_display_pipe *pipe)
@@ -572,7 +572,7 @@ static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
 	struct drm_rect rect;
 
 	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
-		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->map[0], &rect);
+		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);
 }
 
 static const struct drm_simple_display_pipe_funcs gm12u320_pipe_funcs = {
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
