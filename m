Return-Path: <SRS0=Lmm9=L2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61655C11F6A
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 07:54:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F168C613FC
	for <virtualization@archiver.kernel.org>; Fri,  2 Jul 2021 07:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F168C613FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3893A83C40;
	Fri,  2 Jul 2021 07:54:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yok591h1FyoR; Fri,  2 Jul 2021 07:54:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DA68D83CA6;
	Fri,  2 Jul 2021 07:54:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFCFDC0010;
	Fri,  2 Jul 2021 07:54:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25751C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 07:54:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 054FB60656
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 07:54:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="L+0N36nd";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="YqteQjx6"; dkim=pass (1024-bit key)
 header.d=suse.de header.b="L+0N36nd"; dkim=neutral
 reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="YqteQjx6"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TtcMSG769uiR
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 07:54:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 99C4C606B1
 for <virtualization@lists.linux-foundation.org>;
 Fri,  2 Jul 2021 07:54:39 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 96ADE226A6;
 Fri,  2 Jul 2021 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625212477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BvymrpbYmF9jsIavdnGBjl50PQi+1l1AVrXTfZ6Oghk=;
 b=L+0N36ndtLOlCLZYiZvEp2ny4RE9puq4GDRvy60hE+zMsx8+qgZ86ucdDgExPnthDhO36n
 URl7mXgNwnh1tu2j8NaPDZJCLpV80tFyaRpSOmrpSpGUUa84M4ftHgQHM4p8YcLc428W/5
 bv0qct9r5ZlTCivZ7Vy3PohMSNgsWlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625212477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BvymrpbYmF9jsIavdnGBjl50PQi+1l1AVrXTfZ6Oghk=;
 b=YqteQjx6BQwTQJGmHjuFiYHLQnavLwx3qtUqcrxTtRVoMM2AKc7+0RlCd47/Wb7eIB85Ax
 jzbG5ZMQXZ4MepDw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 5C7C911CD7;
 Fri,  2 Jul 2021 07:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625212477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BvymrpbYmF9jsIavdnGBjl50PQi+1l1AVrXTfZ6Oghk=;
 b=L+0N36ndtLOlCLZYiZvEp2ny4RE9puq4GDRvy60hE+zMsx8+qgZ86ucdDgExPnthDhO36n
 URl7mXgNwnh1tu2j8NaPDZJCLpV80tFyaRpSOmrpSpGUUa84M4ftHgQHM4p8YcLc428W/5
 bv0qct9r5ZlTCivZ7Vy3PohMSNgsWlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625212477;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BvymrpbYmF9jsIavdnGBjl50PQi+1l1AVrXTfZ6Oghk=;
 b=YqteQjx6BQwTQJGmHjuFiYHLQnavLwx3qtUqcrxTtRVoMM2AKc7+0RlCd47/Wb7eIB85Ax
 jzbG5ZMQXZ4MepDw==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 6PS8FT3G3mALDgAALh3uQQ
 (envelope-from <tzimmermann@suse.de>); Fri, 02 Jul 2021 07:54:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: kraxel@redhat.com, daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
Subject: [PATCH v2 2/3] drm/bochs: Use managed initialization for GEM VRAM
 helpers
Date: Fri,  2 Jul 2021 09:54:33 +0200
Message-Id: <20210702075434.27677-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702075434.27677-1-tzimmermann@suse.de>
References: <20210702075434.27677-1-tzimmermann@suse.de>
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

Convert to managed GEM VRAM initialization and switch bochs to
full autocleanup.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/tiny/bochs.c | 43 +++++-------------------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 0700cdacc5d6..a2cfecfa8556 100644
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
@@ -581,13 +562,6 @@ static int bochs_kms_init(struct bochs_device *bochs)
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
@@ -601,21 +575,17 @@ static int bochs_load(struct drm_device *dev)
 
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
@@ -629,7 +599,6 @@ static const struct drm_driver bochs_driver = {
 	.major			= 1,
 	.minor			= 0,
 	DRM_GEM_VRAM_DRIVER,
-	.release                = bochs_unload,
 };
 
 /* ---------------------------------------------------------------------- */
@@ -691,13 +660,11 @@ static int bochs_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent
 
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
