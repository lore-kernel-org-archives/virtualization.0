Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBD8C43217
	for <virtualization@archiver.kernel.org>; Wed, 16 Nov 2022 16:09:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BF1C640BF5;
	Wed, 16 Nov 2022 16:09:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF1C640BF5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nZIZ5XSp;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dOOcyXma
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nEoyPP9RRRtx; Wed, 16 Nov 2022 16:09:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C8B5140BA1;
	Wed, 16 Nov 2022 16:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C8B5140BA1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B319C0083;
	Wed, 16 Nov 2022 16:09:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D059CC008B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A324560BF0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A324560BF0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=nZIZ5XSp; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=dOOcyXma
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FvODF_XuxH2x
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D5F1860B48
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D5F1860B48
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:23 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E4086220DE;
 Wed, 16 Nov 2022 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668614960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8dKocCqDOpvDnx/KNSV5OGKEHPE/CTQlmk/W3MK910=;
 b=nZIZ5XSpdd7OuuHA9YOM3VV0yflgWu8EGIYF1Q2EIuhWq7mlPyKztQBqnF3LyohaWELZti
 Y7b4malWXdFquwJ17dnE97jIYRXeXZhNSW8hw2cV44Y0S7nYKZhMVqQjBH9Ckl6qPPMsVr
 XHsg7EQkhuefsYwx3Wm7eaCQN9jrkt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668614960;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8dKocCqDOpvDnx/KNSV5OGKEHPE/CTQlmk/W3MK910=;
 b=dOOcyXmaHjhY6AlYZzwAq/SxLOBHzuySJg6g5aqCMppy45TLaxVMSorR5bSBbTgh35Il0i
 SZEQbSFEfqTTHrAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D937134CE;
 Wed, 16 Nov 2022 16:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gHOlJTALdWP/fwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 16 Nov 2022 16:09:20 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, xinliang.liu@linaro.org,
 tiantao6@hisilicon.com, jstultz@google.com, kong.kongxinwei@hisilicon.com,
 puck.chen@hisilicon.com, paul.kocialkowski@bootlin.com, javierm@redhat.com,
 airlied@redhat.com, kraxel@redhat.com
Subject: [PATCH 6/7] drm/solomon: Set preferred color depth and bpp to the
 correct values
Date: Wed, 16 Nov 2022 17:09:16 +0100
Message-Id: <20221116160917.26342-7-tzimmermann@suse.de>
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

Set the preferred color depth to 24 bits and the fbdev bpp to 32
bits. This will signal XRGB8888 as default format to clients.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/solomon/ssd130x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 53464afc2b9ac..c3bf3a18302ea 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -876,7 +876,7 @@ static int ssd130x_init_modeset(struct ssd130x_device *ssd130x)
 	drm->mode_config.max_width = max_width;
 	drm->mode_config.min_height = mode->vdisplay;
 	drm->mode_config.max_height = max_height;
-	drm->mode_config.preferred_depth = 32;
+	drm->mode_config.preferred_depth = 24;
 	drm->mode_config.funcs = &ssd130x_mode_config_funcs;
 
 	/* Primary plane */
@@ -1006,7 +1006,7 @@ struct ssd130x_device *ssd130x_probe(struct device *dev, struct regmap *regmap)
 	if (ret)
 		return ERR_PTR(dev_err_probe(dev, ret, "DRM device register failed\n"));
 
-	drm_fbdev_generic_setup(drm, 0);
+	drm_fbdev_generic_setup(drm, 32);
 
 	return ssd130x;
 }
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
