Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE079C43217
	for <virtualization@archiver.kernel.org>; Wed, 16 Nov 2022 16:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3407C60FB6;
	Wed, 16 Nov 2022 16:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3407C60FB6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NWG7lAIx;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LyYmrgi7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qO5fXWCU8VQ7; Wed, 16 Nov 2022 16:09:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B66C560FA5;
	Wed, 16 Nov 2022 16:09:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B66C560FA5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5877AC0086;
	Wed, 16 Nov 2022 16:09:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5884CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F7D5812D5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F7D5812D5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=NWG7lAIx; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=LyYmrgi7
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A2fDNCMNyH7Q
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5EC0B812D3
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5EC0B812D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:22 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9A14922098;
 Wed, 16 Nov 2022 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668614960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lAtkQiFgQLAFTvjdJRCf7otT9z7SpVUnaTH14yZcJbc=;
 b=NWG7lAIxHmqyzjGORqfO2dEaLHsP77KARJOW7lcX3qUCnPhIzMhPlecay7xqtthNDVoS4N
 JirOxKv742ucgmMSIdPIzOMA1GruCUl4hVSOteLq2TW7lCmyUygf3jyvccACimIBwTJZc1
 f4FghklyL71H2a3fnLaPH26xPjWEg8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668614960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lAtkQiFgQLAFTvjdJRCf7otT9z7SpVUnaTH14yZcJbc=;
 b=LyYmrgi7YzSki+A922TxabhFuisRVA678QyKmZi4zbCqVwVrWDN1lIjEYmI3rM2EvIXmLE
 /Z73TH4VYgb7UCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 516F913AC7;
 Wed, 16 Nov 2022 16:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uLIEEzALdWP/fwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 16 Nov 2022 16:09:20 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, xinliang.liu@linaro.org,
 tiantao6@hisilicon.com, jstultz@google.com, kong.kongxinwei@hisilicon.com,
 puck.chen@hisilicon.com, paul.kocialkowski@bootlin.com, javierm@redhat.com,
 airlied@redhat.com, kraxel@redhat.com
Subject: [PATCH 5/7] drm/simpledrm: Set preferred depth from format of scanout
 buffer
Date: Wed, 16 Nov 2022 17:09:15 +0100
Message-Id: <20221116160917.26342-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116160917.26342-1-tzimmermann@suse.de>
References: <20221116160917.26342-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
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

Set the preferred depth from the format of the scanout buffer. The
value cannot be hardcoded, as the scanout buffer's is only known at
runtime. Also derive the fbdev emulations bpp value from the scanout
format.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/simpledrm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 162eb44dcba89..30e928d627e8f 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -739,7 +739,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	dev->mode_config.max_width = max_width;
 	dev->mode_config.min_height = height;
 	dev->mode_config.max_height = max_height;
-	dev->mode_config.preferred_depth = format->cpp[0] * 8;
+	dev->mode_config.preferred_depth = format->depth;
 	dev->mode_config.funcs = &simpledrm_mode_config_funcs;
 
 	/* Primary plane */
@@ -834,7 +834,7 @@ static int simpledrm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	drm_fbdev_generic_setup(dev, 0);
+	drm_fbdev_generic_setup(dev, drm_format_info_bpp(sdev->format, 0));
 
 	return 0;
 }
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
