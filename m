Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153CAC64EC4
	for <virtualization@archiver.kernel.org>; Wed, 15 Feb 2023 16:25:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AC45040BE2;
	Wed, 15 Feb 2023 16:25:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC45040BE2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=sN4/0aSE;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DjGOf9Pt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0fe1YIseH9Yk; Wed, 15 Feb 2023 16:25:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0A8204012E;
	Wed, 15 Feb 2023 16:25:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A8204012E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D394BC007D;
	Wed, 15 Feb 2023 16:25:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBBB7C0085
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:25:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C0E56408B3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:25:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C0E56408B3
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=sN4/0aSE; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=DjGOf9Pt
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t-HzJQb3Z00g
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:25:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 94D74408C3
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 94D74408C3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Feb 2023 16:25:25 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96FF7200FE;
 Wed, 15 Feb 2023 16:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1676477728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1BM2d13cHOWxOOXcWmdpVLKai8Z6PGV5O4/2zcDhOGk=;
 b=sN4/0aSEwS/qhPT0XQRO3odk13GIGxwhepeCr/s8kwHZ8lxq/XBZx58AwM8xB8aGdDYRZc
 F3NqQwIG5IaHtOURd8P9mADAx4fthxxUdWEOiaiY0krBnVmIF39DYydHZey1FamTMgfktT
 D6nxf30y58ap5uFu/h6J957Qnt6hmwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1676477728;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1BM2d13cHOWxOOXcWmdpVLKai8Z6PGV5O4/2zcDhOGk=;
 b=DjGOf9Pty95t41DwdfeMd+A3QKvty9D5mpM2uYxceSnK8SnehJx1UYD9Rc7t/S8krduvqZ
 LcFFP1ECy4PdZ/Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47AD2134BA;
 Wed, 15 Feb 2023 16:15:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sJCLECAF7WNHOgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Feb 2023 16:15:28 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com, airlied@redhat.com, daniel@ffwll.ch, sam@ravnborg.org,
 javierm@redhat.com, dri-devel@lists.freedesktop.org
Subject: [PATCH 12/17] drm/cirrus: Remove size test from cirrus_fb_create()
Date: Wed, 15 Feb 2023 17:15:12 +0100
Message-Id: <20230215161517.5113-13-tzimmermann@suse.de>
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

The DRM core implements a size check against the mode config's
limits when creating a framebuffer. [1] Remove the unnecessary
test from cirrus_fb_create() and remove the now-empty function.
Create framebuffers with drm_gem_fb_create_with_dirty().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://elixir.bootlin.com/linux/v6.1/source/drivers/gpu/drm/drm_framebuffer.c#L287 # [1]
---
 drivers/gpu/drm/tiny/cirrus.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index c1ffbbe1d545..c2d7bb775629 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -555,17 +555,8 @@ static int cirrus_pipe_init(struct cirrus_device *cirrus)
 /* ------------------------------------------------------------------ */
 /* cirrus framebuffers & mode config				      */
 
-static struct drm_framebuffer*
-cirrus_fb_create(struct drm_device *dev, struct drm_file *file_priv,
-		 const struct drm_mode_fb_cmd2 *mode_cmd)
-{
-	if (cirrus_check_size(mode_cmd->width, mode_cmd->height, NULL) < 0)
-		return ERR_PTR(-EINVAL);
-	return drm_gem_fb_create_with_dirty(dev, file_priv, mode_cmd);
-}
-
 static const struct drm_mode_config_funcs cirrus_mode_config_funcs = {
-	.fb_create = cirrus_fb_create,
+	.fb_create = drm_gem_fb_create_with_dirty,
 	.atomic_check = drm_atomic_helper_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
-- 
2.39.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
