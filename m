Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E73C77B60
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 00:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B08C040925;
	Mon, 20 Mar 2023 00:53:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B08C040925
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MOfUIfzw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rlD6iGzX486U; Mon, 20 Mar 2023 00:53:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D2B9740918;
	Mon, 20 Mar 2023 00:53:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D2B9740918
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9B31EC0035;
	Mon, 20 Mar 2023 00:53:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEC30C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 00:53:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B9BC560777
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 00:53:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B9BC560777
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=MOfUIfzw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0nBxhjXOo3Af
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 00:53:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 877F460742
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 877F460742
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 00:53:03 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6855D6114C;
 Mon, 20 Mar 2023 00:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 637A7C433D2;
 Mon, 20 Mar 2023 00:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679273581;
 bh=jSUNIjL8GeyeDz0d1ATeTeuULRx6zQ5sbGxW0nJ5JMc=;
 h=From:To:Cc:Subject:Date:From;
 b=MOfUIfzwPNQIWOynyJHERDXNnvOFwWNWABOTrCX5MDGQsPyaGDkAiSB9e7HNWNWlI
 MKxegEGZe/QAyTwxAuHjNDDgKOaOGY5BRl0sCOZkJmDMqMFAWyug2Y6xc8wSHVqXkh
 SSaXzLVuRTseWJ8796mITxvuU8WaUxX0fgOgvxe2h2aDJ/mt0wAKleNSk28BZERL0X
 eeOt6ATv3Tdeg8ZGQEoXunHbjq/njcAZuyImpJATF3fjU8BpoPVztu+R3xl64SQQ0M
 ISxVOsm7JPnB8XdkZr3uJVqryGFkyDcgA1BUEA4SC1jf91EuJTzy8K3vo26f5i71r4
 hhBKzjBXlc6QA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.2 01/30] drm/cirrus: NULL-check
 pipe->plane.state->fb in cirrus_pipe_update()
Date: Sun, 19 Mar 2023 20:52:26 -0400
Message-Id: <20230320005258.1428043-1-sashal@kernel.org>
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
index 678c2ef1cae70..ffa7e61dd1835 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -455,7 +455,7 @@ static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
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
