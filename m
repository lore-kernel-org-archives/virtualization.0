Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B50C64EC1
	for <virtualization@archiver.kernel.org>; Thu,  3 Nov 2022 15:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C461281F71;
	Thu,  3 Nov 2022 15:15:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C461281F71
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=yvt0gOxB;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JgfauNgk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qz8aHJu7VpXH; Thu,  3 Nov 2022 15:15:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 29205817AD;
	Thu,  3 Nov 2022 15:15:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 29205817AD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06F1AC0078;
	Thu,  3 Nov 2022 15:15:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22745C007F
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 15:15:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F9DB40BB5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 15:15:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4F9DB40BB5
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=yvt0gOxB; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=JgfauNgk
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Cn_Ipr3U17b
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 15:15:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C15B40B6D
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C15B40B6D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 15:15:01 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1F3C21E06;
 Thu,  3 Nov 2022 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667488499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVBxH0SCO//07QUQ6EK/LfA90pQs6KDqJ9dD5J474xM=;
 b=yvt0gOxB2lenOEStb/UiJX1DHn3g2kKsI7mtE4SGpNQSAhB7lYBWctzlz1reFVQJV5Q7Dr
 9KtiNP07UesIRoJkQ20OBX+QffIA0guywKHcw8bFrTEd942EgwbZfJYBXbqYb3+CHu7FpM
 9uqeHjGX+09FJKRvQbcgI46xl268Eu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667488499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UVBxH0SCO//07QUQ6EK/LfA90pQs6KDqJ9dD5J474xM=;
 b=JgfauNgkk7JwnVqiJlezA/GaUozyirPiPZWwmsrpZSHazdzqxSROAFO3R1veLQkMRJ/Bf/
 B6Qfs11b1jHuJuBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 55B7F13ADB;
 Thu,  3 Nov 2022 15:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OMwZFPPaY2PBGgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Thu, 03 Nov 2022 15:14:59 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@gmail.com, sam@ravnborg.org, javierm@redhat.com,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com
Subject: [PATCH v3 19/23] drm/fb-helper: Always initialize generic fbdev
 emulation
Date: Thu,  3 Nov 2022 16:14:42 +0100
Message-Id: <20221103151446.2638-20-tzimmermann@suse.de>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221103151446.2638-1-tzimmermann@suse.de>
References: <20221103151446.2638-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linux-aspeed@lists.ozlabs.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 spice-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 "linux-hyperv@vger.kernel.orglinux-hyperv"@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>, freedreno@lists.freedesktop.org
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

Initialize the generic fbdev emulation even if it has been disabled
on the kernel command line. The hotplug and mode initialization will
fail accordingly.

The kernel parameter can still be changed at runtime and the emulation
will initialize after hotplugging the connector.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/drm_fb_helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index 3dfda1e3830b3..95f389433c4a6 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -526,11 +526,6 @@ int drm_fb_helper_init(struct drm_device *dev,
 {
 	int ret;
 
-	if (!drm_fbdev_emulation) {
-		dev->fb_helper = fb_helper;
-		return 0;
-	}
-
 	/*
 	 * If this is not the generic fbdev client, initialize a drm_client
 	 * without callbacks so we can use the modesets.
@@ -2716,9 +2711,6 @@ void drm_fbdev_generic_setup(struct drm_device *dev,
 	drm_WARN(dev, !dev->registered, "Device has not been registered.\n");
 	drm_WARN(dev, dev->fb_helper, "fb_helper is already set!\n");
 
-	if (!drm_fbdev_emulation)
-		return;
-
 	fb_helper = kzalloc(sizeof(*fb_helper), GFP_KERNEL);
 	if (!fb_helper) {
 		drm_err(dev, "Failed to allocate fb_helper\n");
-- 
2.38.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
