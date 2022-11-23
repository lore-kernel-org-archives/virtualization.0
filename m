Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C63C47088
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 11:54:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E81EE60FFC;
	Wed, 23 Nov 2022 11:54:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E81EE60FFC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=b6dj5AAH;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=zaKuG3HU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2Ltj7-7B9Yt0; Wed, 23 Nov 2022 11:53:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5470D60B1E;
	Wed, 23 Nov 2022 11:53:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5470D60B1E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 38358C0086;
	Wed, 23 Nov 2022 11:53:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBCD3C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 11:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A79FE4021C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 11:53:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A79FE4021C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=b6dj5AAH; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=zaKuG3HU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VWs77NdVF3U0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 11:53:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E8984400DB
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8984400DB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 11:53:53 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 24A1A1F8C9;
 Wed, 23 Nov 2022 11:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669204432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rd629cJKpTWnShessI5CnK7kLhqYmet7OX4ME+FxVCc=;
 b=b6dj5AAHzO6dzHqLsMv1GzEQ/wUpcG1Dge4EQx3rs7+xq7CNDI/GRMJer2BZZj+lfRKK9l
 3mJHJh5riQeLZAFFtnLv8iFYyAy8+Niwluhbv/h8NEn+Vpiz7s1c701PYblVKZCl7M8zR5
 MhYEz9QF5w208kIs86aajh+esUS03E8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669204432;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rd629cJKpTWnShessI5CnK7kLhqYmet7OX4ME+FxVCc=;
 b=zaKuG3HU3hzT5+CDUmXJFH/VntoBQOUjfeXt/TA10oc/Z64b0v2fRQU7yVnY20GC+MnBlR
 2AX3HyxT4JSkdXAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2E1813AE7;
 Wed, 23 Nov 2022 11:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YN/NLs8JfmMwVwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 23 Nov 2022 11:53:51 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, xinliang.liu@linaro.org,
 tiantao6@hisilicon.com, jstultz@google.com, kong.kongxinwei@hisilicon.com,
 puck.chen@hisilicon.com, paul.kocialkowski@bootlin.com, javierm@redhat.com,
 airlied@redhat.com, kraxel@redhat.com
Subject: [PATCH v2 4/7] drm/ofdrm: Set preferred depth from format of scanout
 buffer
Date: Wed, 23 Nov 2022 12:53:45 +0100
Message-Id: <20221123115348.2521-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123115348.2521-1-tzimmermann@suse.de>
References: <20221123115348.2521-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
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
value cannot be hardcoded, as the scanout buffer is only known at
runtime. Keeping the existing switch statement just duplicates the
driver's existing logic for format detection.

Also remove the FIXME comment from the call to drm_fbdev_generic_setup()
as the driver now handles color depth and bpp values correctly.

v2:
	* fix commit-message typo

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/tiny/ofdrm.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
index dc9e4d71b12ae..33eefeba437c5 100644
--- a/drivers/gpu/drm/tiny/ofdrm.c
+++ b/drivers/gpu/drm/tiny/ofdrm.c
@@ -1284,14 +1284,7 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
 	dev->mode_config.min_height = height;
 	dev->mode_config.max_height = max_height;
 	dev->mode_config.funcs = &ofdrm_mode_config_funcs;
-	switch (depth) {
-	case 32:
-		dev->mode_config.preferred_depth = 24;
-		break;
-	default:
-		dev->mode_config.preferred_depth = depth;
-		break;
-	}
+	dev->mode_config.preferred_depth = format->depth;
 	dev->mode_config.quirk_addfb_prefer_host_byte_order = true;
 
 	/* Primary plane */
@@ -1390,10 +1383,6 @@ static int ofdrm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/*
-	 * FIXME: 24-bit color depth does not work reliably with a 32-bpp
-	 * value. Force the bpp value of the scanout buffer's format.
-	 */
 	drm_fbdev_generic_setup(dev, drm_format_info_bpp(odev->format, 0));
 
 	return 0;
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
