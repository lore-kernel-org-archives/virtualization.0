Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BECBC49EA4
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 11:20:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25968613B8
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 11:20:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25968613B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 42440404FD;
	Wed,  9 Jun 2021 11:20:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ws3kkP89rDo4; Wed,  9 Jun 2021 11:20:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B521140524;
	Wed,  9 Jun 2021 11:20:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62839C0030;
	Wed,  9 Jun 2021 11:20:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F75CC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 11:20:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F7F883C44
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 11:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="hgqBLcoJ";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="eGgR9KjA"; dkim=pass (1024-bit key)
 header.d=suse.de header.b="hgqBLcoJ"; dkim=neutral
 reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="eGgR9KjA"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QAyHn5w4a2BW
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 11:20:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 30E2C83C46
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 11:20:21 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 70A741FD4E;
 Wed,  9 Jun 2021 11:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623237619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHgjG881Tzc6TF1wm3lJNykWl3nzYgQpZTifsGlExSU=;
 b=hgqBLcoJY2hRbV6/3Hrf2WYuynMUd9lzWYUR+DdXlNfTZli8hzGqhtU3QmtTRRAqV6fS8M
 wDJdF1FkdaZY1ArXcHL5VCIPMV0PRYELkHJOZDDwCl2CsYPEyMKRwPJ3ZZ5Ic5fk30uGGW
 rCSXuXdk8BiSRqjnpkEqOsqJ8E3bvFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623237619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHgjG881Tzc6TF1wm3lJNykWl3nzYgQpZTifsGlExSU=;
 b=eGgR9KjAmEUGAXpoJk3a/G6GTIkV9mSVYZLHZAU/NHGNMndowHzlD+P9aLIVMDFR5MbUPm
 KIutgtmlNht3fHCg==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id CDACA118DD;
 Wed,  9 Jun 2021 11:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623237619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHgjG881Tzc6TF1wm3lJNykWl3nzYgQpZTifsGlExSU=;
 b=hgqBLcoJY2hRbV6/3Hrf2WYuynMUd9lzWYUR+DdXlNfTZli8hzGqhtU3QmtTRRAqV6fS8M
 wDJdF1FkdaZY1ArXcHL5VCIPMV0PRYELkHJOZDDwCl2CsYPEyMKRwPJ3ZZ5Ic5fk30uGGW
 rCSXuXdk8BiSRqjnpkEqOsqJ8E3bvFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623237619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uHgjG881Tzc6TF1wm3lJNykWl3nzYgQpZTifsGlExSU=;
 b=eGgR9KjAmEUGAXpoJk3a/G6GTIkV9mSVYZLHZAU/NHGNMndowHzlD+P9aLIVMDFR5MbUPm
 KIutgtmlNht3fHCg==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 0G1AMfKjwGBTUgAALh3uQQ
 (envelope-from <tzimmermann@suse.de>); Wed, 09 Jun 2021 11:20:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 l.stach@pengutronix.de, linux+etnaviv@armlinux.org.uk,
 christian.gmeiner@gmail.com, inki.dae@samsung.com, jy0922.shim@samsung.com,
 sw0312.kim@samsung.com, kyungmin.park@samsung.com,
 krzysztof.kozlowski@canonical.com, chunkuang.hu@kernel.org,
 p.zabel@pengutronix.de, matthias.bgg@gmail.com, robdclark@gmail.com,
 sean@poorly.run, airlied@redhat.com, kraxel@redhat.com, hjc@rock-chips.com,
 heiko@sntech.de, oleksandr_andrushchenko@epam.com, sumit.semwal@linaro.org,
 christian.koenig@amd.com
Subject: [PATCH 8/9] drm/rockchip: Implement mmap as GEM object function
Date: Wed,  9 Jun 2021 13:20:11 +0200
Message-Id: <20210609112012.10019-9-tzimmermann@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210609112012.10019-1-tzimmermann@suse.de>
References: <20210609112012.10019-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
 linux-rockchip@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Thomas Zimmermann <tzimmermann@suse.de>, xen-devel@lists.xenproject.org,
 spice-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

Moving the driver-specific mmap code into a GEM object function allows
for using DRM helpers for various mmap callbacks.

The respective rockchip functions are being removed. The file_operations
structure fops is now being created by the helper macro
DEFINE_DRM_GEM_FOPS().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   | 13 +-----
 drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c |  3 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c   | 44 +++++--------------
 drivers/gpu/drm/rockchip/rockchip_drm_gem.h   |  7 ---
 4 files changed, 15 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index b730b8d5d949..2e3ab573a817 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -208,16 +208,7 @@ static void rockchip_drm_unbind(struct device *dev)
 	drm_dev_put(drm_dev);
 }
 
-static const struct file_operations rockchip_drm_driver_fops = {
-	.owner = THIS_MODULE,
-	.open = drm_open,
-	.mmap = rockchip_gem_mmap,
-	.poll = drm_poll,
-	.read = drm_read,
-	.unlocked_ioctl = drm_ioctl,
-	.compat_ioctl = drm_compat_ioctl,
-	.release = drm_release,
-};
+DEFINE_DRM_GEM_FOPS(rockchip_drm_driver_fops);
 
 static const struct drm_driver rockchip_drm_driver = {
 	.driver_features	= DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
@@ -226,7 +217,7 @@ static const struct drm_driver rockchip_drm_driver = {
 	.prime_handle_to_fd	= drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle	= drm_gem_prime_fd_to_handle,
 	.gem_prime_import_sg_table	= rockchip_gem_prime_import_sg_table,
-	.gem_prime_mmap		= rockchip_gem_mmap_buf,
+	.gem_prime_mmap		= drm_gem_prime_mmap,
 	.fops			= &rockchip_drm_driver_fops,
 	.name	= DRIVER_NAME,
 	.desc	= DRIVER_DESC,
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
index 2fdc455c4ad7..d8418dd39d0e 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fbdev.c
@@ -7,6 +7,7 @@
 #include <drm/drm.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_prime.h>
 #include <drm/drm_probe_helper.h>
 
 #include "rockchip_drm_drv.h"
@@ -24,7 +25,7 @@ static int rockchip_fbdev_mmap(struct fb_info *info,
 	struct drm_fb_helper *helper = info->par;
 	struct rockchip_drm_private *private = to_drm_private(helper);
 
-	return rockchip_gem_mmap_buf(private->fbdev_bo, vma);
+	return drm_gem_prime_mmap(private->fbdev_bo, vma);
 }
 
 static const struct fb_ops rockchip_drm_fbdev_ops = {
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index 7971f57436dd..63eb73b624aa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -240,12 +240,22 @@ static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
 	int ret;
 	struct rockchip_gem_object *rk_obj = to_rockchip_obj(obj);
 
+	/*
+	 * Set vm_pgoff (used as a fake buffer offset by DRM) to 0 and map the
+	 * whole buffer from the start.
+	 */
+	vma->vm_pgoff = 0;
+
 	/*
 	 * We allocated a struct page table for rk_obj, so clear
 	 * VM_PFNMAP flag that was set by drm_gem_mmap_obj()/drm_gem_mmap().
 	 */
+	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
 	vma->vm_flags &= ~VM_PFNMAP;
 
+	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+
 	if (rk_obj->pages)
 		ret = rockchip_drm_gem_object_mmap_iommu(obj, vma);
 	else
@@ -257,39 +267,6 @@ static int rockchip_drm_gem_object_mmap(struct drm_gem_object *obj,
 	return ret;
 }
 
-int rockchip_gem_mmap_buf(struct drm_gem_object *obj,
-			  struct vm_area_struct *vma)
-{
-	int ret;
-
-	ret = drm_gem_mmap_obj(obj, obj->size, vma);
-	if (ret)
-		return ret;
-
-	return rockchip_drm_gem_object_mmap(obj, vma);
-}
-
-/* drm driver mmap file operations */
-int rockchip_gem_mmap(struct file *filp, struct vm_area_struct *vma)
-{
-	struct drm_gem_object *obj;
-	int ret;
-
-	ret = drm_gem_mmap(filp, vma);
-	if (ret)
-		return ret;
-
-	/*
-	 * Set vm_pgoff (used as a fake buffer offset by DRM) to 0 and map the
-	 * whole buffer from the start.
-	 */
-	vma->vm_pgoff = 0;
-
-	obj = vma->vm_private_data;
-
-	return rockchip_drm_gem_object_mmap(obj, vma);
-}
-
 static void rockchip_gem_release_object(struct rockchip_gem_object *rk_obj)
 {
 	drm_gem_object_release(&rk_obj->base);
@@ -301,6 +278,7 @@ static const struct drm_gem_object_funcs rockchip_gem_object_funcs = {
 	.get_sg_table = rockchip_gem_prime_get_sg_table,
 	.vmap = rockchip_gem_prime_vmap,
 	.vunmap	= rockchip_gem_prime_vunmap,
+	.mmap = rockchip_drm_gem_object_mmap,
 	.vm_ops = &drm_gem_cma_vm_ops,
 };
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
index 5a70a56cd406..47c1861eece0 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.h
@@ -34,13 +34,6 @@ rockchip_gem_prime_import_sg_table(struct drm_device *dev,
 int rockchip_gem_prime_vmap(struct drm_gem_object *obj, struct dma_buf_map *map);
 void rockchip_gem_prime_vunmap(struct drm_gem_object *obj, struct dma_buf_map *map);
 
-/* drm driver mmap file operations */
-int rockchip_gem_mmap(struct file *filp, struct vm_area_struct *vma);
-
-/* mmap a gem object to userspace. */
-int rockchip_gem_mmap_buf(struct drm_gem_object *obj,
-			  struct vm_area_struct *vma);
-
 struct rockchip_gem_object *
 	rockchip_gem_create_object(struct drm_device *drm, unsigned int size,
 				   bool alloc_kmap);
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
