Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEADC48BE8
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 11:20:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152F361040
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 11:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152F361040
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D4A6C40523;
	Wed,  9 Jun 2021 11:20:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 21F6FXJsMIth; Wed,  9 Jun 2021 11:20:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5775440518;
	Wed,  9 Jun 2021 11:20:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2BCA7C002E;
	Wed,  9 Jun 2021 11:20:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA872C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 11:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CB06460597
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 11:20:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="feETavSA";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="FiHMe32N"; dkim=pass (1024-bit key)
 header.d=suse.de header.b="feETavSA"; dkim=neutral
 reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="FiHMe32N"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o3TBDT25PDNo
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 11:20:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9B881608DD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 11:20:20 +0000 (UTC)
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C9F0C219E7;
 Wed,  9 Jun 2021 11:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623237618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LgmkNBFCrk1hW0/5PXKqc/A6qw4hyWmJvURgp3U/IY=;
 b=feETavSAwPIN91p0cp256C9fiEsKaNYIKuVNT50Mf3so2lwsaBjQikkEdEpjs8+dLr+wQZ
 aRXgCTaShXVXVpbrYad0kOe3F7/pN97IxqZCBf5JanIEjq1G4uCGdjvA1wfggeqAJJdyA7
 cuUfQ5zlL3AEG3KxZiJ6na/5xlBS7gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623237618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LgmkNBFCrk1hW0/5PXKqc/A6qw4hyWmJvURgp3U/IY=;
 b=FiHMe32Ni2REvI8BzxgNMv2YcNCb3Od9taV4cLY/CDSaTllreQL1Zf7x3eX+qMtrvXbqLK
 svw5Gcb+w5vufCDQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id 249C311A98;
 Wed,  9 Jun 2021 11:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623237618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LgmkNBFCrk1hW0/5PXKqc/A6qw4hyWmJvURgp3U/IY=;
 b=feETavSAwPIN91p0cp256C9fiEsKaNYIKuVNT50Mf3so2lwsaBjQikkEdEpjs8+dLr+wQZ
 aRXgCTaShXVXVpbrYad0kOe3F7/pN97IxqZCBf5JanIEjq1G4uCGdjvA1wfggeqAJJdyA7
 cuUfQ5zlL3AEG3KxZiJ6na/5xlBS7gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623237618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LgmkNBFCrk1hW0/5PXKqc/A6qw4hyWmJvURgp3U/IY=;
 b=FiHMe32Ni2REvI8BzxgNMv2YcNCb3Od9taV4cLY/CDSaTllreQL1Zf7x3eX+qMtrvXbqLK
 svw5Gcb+w5vufCDQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id gK7nB/KjwGBTUgAALh3uQQ
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
Subject: [PATCH 7/9] drm/xen: Implement mmap as GEM object function
Date: Wed,  9 Jun 2021 13:20:10 +0200
Message-Id: <20210609112012.10019-8-tzimmermann@suse.de>
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

The respective xen functions are being removed. The file_operations
structure fops is now being created by the helper macro
DEFINE_DRM_GEM_FOPS().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/xen/xen_drm_front.c     |  16 +---
 drivers/gpu/drm/xen/xen_drm_front_gem.c | 108 +++++++++---------------
 drivers/gpu/drm/xen/xen_drm_front_gem.h |   7 --
 3 files changed, 44 insertions(+), 87 deletions(-)

diff --git a/drivers/gpu/drm/xen/xen_drm_front.c b/drivers/gpu/drm/xen/xen_drm_front.c
index 9f14d99c763c..434064c820e8 100644
--- a/drivers/gpu/drm/xen/xen_drm_front.c
+++ b/drivers/gpu/drm/xen/xen_drm_front.c
@@ -469,19 +469,7 @@ static void xen_drm_drv_release(struct drm_device *dev)
 	kfree(drm_info);
 }
 
-static const struct file_operations xen_drm_dev_fops = {
-	.owner          = THIS_MODULE,
-	.open           = drm_open,
-	.release        = drm_release,
-	.unlocked_ioctl = drm_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl   = drm_compat_ioctl,
-#endif
-	.poll           = drm_poll,
-	.read           = drm_read,
-	.llseek         = no_llseek,
-	.mmap           = xen_drm_front_gem_mmap,
-};
+DEFINE_DRM_GEM_FOPS(xen_drm_dev_fops);
 
 static const struct drm_driver xen_drm_driver = {
 	.driver_features           = DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
@@ -489,7 +477,7 @@ static const struct drm_driver xen_drm_driver = {
 	.prime_handle_to_fd        = drm_gem_prime_handle_to_fd,
 	.prime_fd_to_handle        = drm_gem_prime_fd_to_handle,
 	.gem_prime_import_sg_table = xen_drm_front_gem_import_sg_table,
-	.gem_prime_mmap            = xen_drm_front_gem_prime_mmap,
+	.gem_prime_mmap            = drm_gem_prime_mmap,
 	.dumb_create               = xen_drm_drv_dumb_create,
 	.fops                      = &xen_drm_dev_fops,
 	.name                      = "xendrm-du",
diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index b293c67230ef..dd358ba2bf8e 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -57,6 +57,47 @@ static void gem_free_pages_array(struct xen_gem_object *xen_obj)
 	xen_obj->pages = NULL;
 }
 
+static int xen_drm_front_gem_object_mmap(struct drm_gem_object *gem_obj,
+					 struct vm_area_struct *vma)
+{
+	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
+	int ret;
+
+	vma->vm_ops = gem_obj->funcs->vm_ops;
+
+	/*
+	 * Clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
+	 * vm_pgoff (used as a fake buffer offset by DRM) to 0 as we want to map
+	 * the whole buffer.
+	 */
+	vma->vm_flags &= ~VM_PFNMAP;
+	vma->vm_flags |= VM_MIXEDMAP;
+	vma->vm_pgoff = 0;
+
+	/*
+	 * According to Xen on ARM ABI (xen/include/public/arch-arm.h):
+	 * all memory which is shared with other entities in the system
+	 * (including the hypervisor and other guests) must reside in memory
+	 * which is mapped as Normal Inner Write-Back Outer Write-Back
+	 * Inner-Shareable.
+	 */
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
+
+	/*
+	 * vm_operations_struct.fault handler will be called if CPU access
+	 * to VM is here. For GPUs this isn't the case, because CPU  doesn't
+	 * touch the memory. Insert pages now, so both CPU and GPU are happy.
+	 *
+	 * FIXME: as we insert all the pages now then no .fault handler must
+	 * be called, so don't provide one
+	 */
+	ret = vm_map_pages(vma, xen_obj->pages, xen_obj->num_pages);
+	if (ret < 0)
+		DRM_ERROR("Failed to map pages into vma: %d\n", ret);
+
+	return ret;
+}
+
 static const struct vm_operations_struct xen_drm_drv_vm_ops = {
 	.open           = drm_gem_vm_open,
 	.close          = drm_gem_vm_close,
@@ -67,6 +108,7 @@ static const struct drm_gem_object_funcs xen_drm_front_gem_object_funcs = {
 	.get_sg_table = xen_drm_front_gem_get_sg_table,
 	.vmap = xen_drm_front_gem_prime_vmap,
 	.vunmap = xen_drm_front_gem_prime_vunmap,
+	.mmap = xen_drm_front_gem_object_mmap,
 	.vm_ops = &xen_drm_drv_vm_ops,
 };
 
@@ -238,58 +280,6 @@ xen_drm_front_gem_import_sg_table(struct drm_device *dev,
 	return &xen_obj->base;
 }
 
-static int gem_mmap_obj(struct xen_gem_object *xen_obj,
-			struct vm_area_struct *vma)
-{
-	int ret;
-
-	/*
-	 * clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
-	 * vm_pgoff (used as a fake buffer offset by DRM) to 0 as we want to map
-	 * the whole buffer.
-	 */
-	vma->vm_flags &= ~VM_PFNMAP;
-	vma->vm_flags |= VM_MIXEDMAP;
-	vma->vm_pgoff = 0;
-	/*
-	 * According to Xen on ARM ABI (xen/include/public/arch-arm.h):
-	 * all memory which is shared with other entities in the system
-	 * (including the hypervisor and other guests) must reside in memory
-	 * which is mapped as Normal Inner Write-Back Outer Write-Back
-	 * Inner-Shareable.
-	 */
-	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-
-	/*
-	 * vm_operations_struct.fault handler will be called if CPU access
-	 * to VM is here. For GPUs this isn't the case, because CPU
-	 * doesn't touch the memory. Insert pages now, so both CPU and GPU are
-	 * happy.
-	 * FIXME: as we insert all the pages now then no .fault handler must
-	 * be called, so don't provide one
-	 */
-	ret = vm_map_pages(vma, xen_obj->pages, xen_obj->num_pages);
-	if (ret < 0)
-		DRM_ERROR("Failed to map pages into vma: %d\n", ret);
-
-	return ret;
-}
-
-int xen_drm_front_gem_mmap(struct file *filp, struct vm_area_struct *vma)
-{
-	struct xen_gem_object *xen_obj;
-	struct drm_gem_object *gem_obj;
-	int ret;
-
-	ret = drm_gem_mmap(filp, vma);
-	if (ret < 0)
-		return ret;
-
-	gem_obj = vma->vm_private_data;
-	xen_obj = to_xen_gem_obj(gem_obj);
-	return gem_mmap_obj(xen_obj, vma);
-}
-
 int xen_drm_front_gem_prime_vmap(struct drm_gem_object *gem_obj, struct dma_buf_map *map)
 {
 	struct xen_gem_object *xen_obj = to_xen_gem_obj(gem_obj);
@@ -313,17 +303,3 @@ void xen_drm_front_gem_prime_vunmap(struct drm_gem_object *gem_obj,
 {
 	vunmap(map->vaddr);
 }
-
-int xen_drm_front_gem_prime_mmap(struct drm_gem_object *gem_obj,
-				 struct vm_area_struct *vma)
-{
-	struct xen_gem_object *xen_obj;
-	int ret;
-
-	ret = drm_gem_mmap_obj(gem_obj, gem_obj->size, vma);
-	if (ret < 0)
-		return ret;
-
-	xen_obj = to_xen_gem_obj(gem_obj);
-	return gem_mmap_obj(xen_obj, vma);
-}
diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.h b/drivers/gpu/drm/xen/xen_drm_front_gem.h
index a4e67d0a149c..eaea470f7001 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.h
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.h
@@ -15,9 +15,7 @@ struct dma_buf_attachment;
 struct dma_buf_map;
 struct drm_device;
 struct drm_gem_object;
-struct file;
 struct sg_table;
-struct vm_area_struct;
 
 struct drm_gem_object *xen_drm_front_gem_create(struct drm_device *dev,
 						size_t size);
@@ -33,15 +31,10 @@ struct page **xen_drm_front_gem_get_pages(struct drm_gem_object *obj);
 
 void xen_drm_front_gem_free_object_unlocked(struct drm_gem_object *gem_obj);
 
-int xen_drm_front_gem_mmap(struct file *filp, struct vm_area_struct *vma);
-
 int xen_drm_front_gem_prime_vmap(struct drm_gem_object *gem_obj,
 				 struct dma_buf_map *map);
 
 void xen_drm_front_gem_prime_vunmap(struct drm_gem_object *gem_obj,
 				    struct dma_buf_map *map);
 
-int xen_drm_front_gem_prime_mmap(struct drm_gem_object *gem_obj,
-				 struct vm_area_struct *vma);
-
 #endif /* __XEN_DRM_FRONT_GEM_H */
-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
