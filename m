Return-Path: <SRS0=+NJr=LY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C75C11F65
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 14:07:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C3161433
	for <virtualization@archiver.kernel.org>; Wed, 30 Jun 2021 14:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C3161433
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30AC460A49;
	Wed, 30 Jun 2021 14:07:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YYOjeABwRZ-p; Wed, 30 Jun 2021 14:07:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3C36C60A57;
	Wed, 30 Jun 2021 14:07:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E97D2C0024;
	Wed, 30 Jun 2021 14:07:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A1D83C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 14:07:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8054D4159D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 14:07:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="iSbQHpnO";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="L+UXsMsy"; dkim=pass (1024-bit key)
 header.d=suse.de header.b="iSbQHpnO"; dkim=neutral
 reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="L+UXsMsy"
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Sv9p48jHkckx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 14:07:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BA25641582
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Jun 2021 14:07:03 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 871EA1FEAA;
 Wed, 30 Jun 2021 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625062021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4Iok4K/bjhAV6K4mdCzs9O1ke1YMHYqU/bSNrFgKHw=;
 b=iSbQHpnOC73X1LBLsa+S+Zip8xEa4O85KtOvOhzT0Drc8CYz/kYVQlNPCDSai9foLG7N5p
 X1OTYqhVVkzj9i0N6mir7XBXstEzSpOWw1V8NXjno7DDoyrqwxoGJ+ezQX6xvnZF0foEg6
 FmPb+CjjW/FQXJ2t2IiWShC7ASFW/pA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625062021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4Iok4K/bjhAV6K4mdCzs9O1ke1YMHYqU/bSNrFgKHw=;
 b=L+UXsMsygFu+lwbgw99H0NNNJcAMKOOHRNNTwecD5QSGXzJ9M7mtqUcXMYvjJGuMUkp+8J
 lLHgsIGV2cyDG7DA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 51E0D11906;
 Wed, 30 Jun 2021 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625062021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4Iok4K/bjhAV6K4mdCzs9O1ke1YMHYqU/bSNrFgKHw=;
 b=iSbQHpnOC73X1LBLsa+S+Zip8xEa4O85KtOvOhzT0Drc8CYz/kYVQlNPCDSai9foLG7N5p
 X1OTYqhVVkzj9i0N6mir7XBXstEzSpOWw1V8NXjno7DDoyrqwxoGJ+ezQX6xvnZF0foEg6
 FmPb+CjjW/FQXJ2t2IiWShC7ASFW/pA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625062021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l4Iok4K/bjhAV6K4mdCzs9O1ke1YMHYqU/bSNrFgKHw=;
 b=L+UXsMsygFu+lwbgw99H0NNNJcAMKOOHRNNTwecD5QSGXzJ9M7mtqUcXMYvjJGuMUkp+8J
 lLHgsIGV2cyDG7DA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id SC4rE4V63GBNDQAALh3uQQ
 (envelope-from <tzimmermann@suse.de>); Wed, 30 Jun 2021 14:07:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com, daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
Subject: [PATCH 2/3] drm/bochs: Use managed initialization for GEM VRAM helpers
Date: Wed, 30 Jun 2021 16:06:58 +0200
Message-Id: <20210630140659.17623-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210630140659.17623-1-tzimmermann@suse.de>
References: <20210630140659.17623-1-tzimmermann@suse.de>
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

Convert to managed GEM VRAM initialization and switch bochs to
full autocleanup.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/bochs.c | 43 +++++-------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index edcd31db5b9c..254787fbf0ea 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -404,25 +404,6 @@ static void bochs_hw_setbase(struct bochs_device *bochs, int x, int y, int strid
 
 /* ---------------------------------------------------------------------- */
 
-static int bochs_mm_init(struct bochs_device *bochs)
-{
-	struct drm_vram_mm *vmm;
-
-	vmm = drm_vram_helper_alloc_mm(bochs->dev, bochs->fb_base,
-				       bochs->fb_size);
-	return PTR_ERR_OR_ZERO(vmm);
-}
-
-static void bochs_mm_fini(struct bochs_device *bochs)
-{
-	if (!bochs->dev->vram_mm)
-		return;
-
-	drm_vram_helper_release_mm(bochs->dev);
-}
-
-/* ---------------------------------------------------------------------- */
-
 static const uint32_t bochs_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_BGRX8888,
@@ -582,13 +563,6 @@ static int bochs_kms_init(struct bochs_device *bochs)
 /* ---------------------------------------------------------------------- */
 /* drm interface                                                          */
 
-static void bochs_unload(struct drm_device *dev)
-{
-	struct bochs_device *bochs = dev->dev_private;
-
-	bochs_mm_fini(bochs);
-}
-
 static int bochs_load(struct drm_device *dev)
 {
 	struct bochs_device *bochs;
@@ -602,21 +576,17 @@ static int bochs_load(struct drm_device *dev)
 
 	ret = bochs_hw_init(dev);
 	if (ret)
-		goto err;
+		return ret;
 
-	ret = bochs_mm_init(bochs);
+	ret = drmm_vram_helper_init(dev, bochs->fb_base, bochs->fb_size);
 	if (ret)
-		goto err;
+		return ret;
 
 	ret = bochs_kms_init(bochs);
 	if (ret)
-		goto err;
+		return ret;
 
 	return 0;
-
-err:
-	bochs_unload(dev);
-	return ret;
 }
 
 DEFINE_DRM_GEM_FOPS(bochs_fops);
@@ -630,7 +600,6 @@ static const struct drm_driver bochs_driver = {
 	.major			= 1,
 	.minor			= 0,
 	DRM_GEM_VRAM_DRIVER,
-	.release                = bochs_unload,
 };
 
 /* ---------------------------------------------------------------------- */
@@ -693,13 +662,11 @@ static int bochs_pci_probe(struct pci_dev *pdev,
 
 	ret = drm_dev_register(dev, 0);
 	if (ret)
-		goto err_unload;
+		goto err_free_dev;
 
 	drm_fbdev_generic_setup(dev, 32);
 	return ret;
 
-err_unload:
-	bochs_unload(dev);
 err_free_dev:
 	drm_dev_put(dev);
 	return ret;
-- 
2.32.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
