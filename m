Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECCEC7618A
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 00:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBE1781948;
	Mon, 20 Mar 2023 00:55:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DBE1781948
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=usnykf1G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yyiVQrtVhmXJ; Mon, 20 Mar 2023 00:55:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 659058149B;
	Mon, 20 Mar 2023 00:55:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 659058149B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DC3BC0035;
	Mon, 20 Mar 2023 00:55:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F227C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 00:55:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C4ED607FE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 00:55:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C4ED607FE
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=usnykf1G
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2SCL-IGFDm6C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 00:55:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 650AB60742
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 650AB60742
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 00:55:25 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B3CD7611DD;
 Mon, 20 Mar 2023 00:55:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A804C4339C;
 Mon, 20 Mar 2023 00:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679273724;
 bh=+hI0EX1Y/j+AMA/T6C5h+0aoDUP1nfK6Qa6Evui8qmM=;
 h=From:To:Cc:Subject:Date:From;
 b=usnykf1Gexl+kAp95PgxjLZ5zA314E2KzKe8lldbp2+OUwIrB0woFZqkjo9kDSIFc
 EuN3gono4J9BnZ391ht1jDeGhljLI+ZCPNwgBZTMykY4zOLI+bO+GnG5nBJZiqbgwY
 KkBvSM3xKgleVVuJv+1MiADF7huE77B0tCGNqVNo741ToG5W9++PTrqaR4L0LiRfAm
 /pLKQZy5kD3exLtN97iAE+BrP/CtACIdR11A80eHjnv1+W6T9uTu9k8dn8wfxJ9ThC
 fOo1IXGEy5MZdUYEtGdS7LE6k6Ma0FVoSef67Rsi234m2UA8Rh6pdc3OHkjF9rullP
 Wj6k6/uX4Mklg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 01/17] drm/cirrus: NULL-check
 pipe->plane.state->fb in cirrus_pipe_update()
Date: Sun, 19 Mar 2023 20:55:03 -0400
Message-Id: <20230320005521.1428820-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, daniel@ffwll.ch, jani.nikula@intel.com,
 sam@ravnborg.org, javierm@redhat.com, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 Alexandr Sapozhnikov <alsp705@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com, airlied@gmail.com,
 ville.syrjala@linux.intel.com
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

From: Alexandr Sapozhnikov <alsp705@gmail.com>

[ Upstream commit 7245e629dcaaf308f1868aeffa218e9849c77893 ]

After having been compared to NULL value at cirrus.c:455, pointer
'pipe->plane.state->fb' is passed as 1st parameter in call to function
'cirrus_fb_blit_rect' at cirrus.c:461, where it is dereferenced at
cirrus.c:316.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

v2:
	* aligned commit message to line-length limits

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20230215171549.16305-1-alsp705@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/cirrus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index 4611ec408506b..2a81311b22172 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -450,7 +450,7 @@ static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
 	if (state->fb && cirrus->cpp != cirrus_cpp(state->fb))
 		cirrus_mode_set(cirrus, &crtc->mode, state->fb);
 
-	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
+	if (state->fb && drm_atomic_helper_damage_merged(old_state, state, &rect))
 		cirrus_fb_blit_rect(state->fb, &shadow_plane_state->data[0], &rect);
 }
 
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
