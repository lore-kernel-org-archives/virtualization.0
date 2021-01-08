Return-Path: <SRS0=LX6v=GL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392F2C433E9
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:43:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCE4A23383
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCE4A23383
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6BCE52E129;
	Fri,  8 Jan 2021 09:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hchWbwSj1AtZ; Fri,  8 Jan 2021 09:43:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 92A542E11D;
	Fri,  8 Jan 2021 09:43:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 69278C1E6F;
	Fri,  8 Jan 2021 09:43:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE3DBC1E70
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D657886D10
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id phs59Y_lWG1c
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 01EF786CF8
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:47 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 914E5AE1C;
 Fri,  8 Jan 2021 09:43:45 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, airlied@redhat.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 kraxel@redhat.com, hdegoede@redhat.com, sean@poorly.run, eric@anholt.net,
 sam@ravnborg.org
Subject: [PATCH v4 03/13] drm/cma-helper: Provide a vmap function for
 short-term mappings
Date: Fri,  8 Jan 2021 10:43:30 +0100
Message-Id: <20210108094340.15290-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108094340.15290-1-tzimmermann@suse.de>
References: <20210108094340.15290-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-media@vger.kernel.org
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

Implementations of the vmap/vunmap GEM callbacks may perform pinning
of the BO and may acquire the associated reservation object's lock.
Callers that only require a mapping of the contained memory can thus
interfere with other tasks that require exact pinning, such as scanout.
This is less of an issue with private CMA buffers, but may happen
with imported ones.

Therefore provide the new interface drm_gem_cma_vmap_local(), which only
performs the vmap operations. Callers have to hold the reservation lock
while the mapping persists.

This patch also connects GEM CMA helpers to the GEM object function with
equivalent functionality.

v4:
	* vc4: don't wrap drm_gem_cma_vmap_local() in BO funcs (Daniel)
	* remove the TODO comment (Daniel)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_gem_cma_helper.c | 27 +++++++++++++++++++++++++++
 drivers/gpu/drm/vc4/vc4_bo.c         |  1 +
 include/drm/drm_gem_cma_helper.h     |  1 +
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
index 7942cf05cd93..f854027fa01f 100644
--- a/drivers/gpu/drm/drm_gem_cma_helper.c
+++ b/drivers/gpu/drm/drm_gem_cma_helper.c
@@ -38,6 +38,7 @@ static const struct drm_gem_object_funcs drm_gem_cma_default_funcs = {
 	.print_info = drm_gem_cma_print_info,
 	.get_sg_table = drm_gem_cma_get_sg_table,
 	.vmap = drm_gem_cma_vmap,
+	.vmap_local = drm_gem_cma_vmap_local,
 	.mmap = drm_gem_cma_mmap,
 	.vm_ops = &drm_gem_cma_vm_ops,
 };
@@ -471,6 +472,32 @@ int drm_gem_cma_vmap(struct drm_gem_object *obj, struct dma_buf_map *map)
 }
 EXPORT_SYMBOL_GPL(drm_gem_cma_vmap);
 
+/**
+ * drm_gem_cma_vmap_local - map a CMA GEM object into the kernel's virtual
+ *     address space
+ * @obj: GEM object
+ * @map: Returns the kernel virtual address of the CMA GEM object's backing
+ *       store.
+ *
+ * This function maps a buffer into the kernel's
+ * virtual address space. Since the CMA buffers are already mapped into the
+ * kernel virtual address space this simply returns the cached virtual
+ * address. Drivers using the CMA helpers should set this as their DRM
+ * driver's &drm_gem_object_funcs.vmap_local callback.
+ *
+ * Returns:
+ * 0 on success, or a negative error code otherwise.
+ */
+int drm_gem_cma_vmap_local(struct drm_gem_object *obj, struct dma_buf_map *map)
+{
+	struct drm_gem_cma_object *cma_obj = to_drm_gem_cma_obj(obj);
+
+	dma_buf_map_set_vaddr(map, cma_obj->vaddr);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(drm_gem_cma_vmap_local);
+
 /**
  * drm_gem_cma_mmap - memory-map an exported CMA GEM object
  * @obj: GEM object
diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index dc316cb79e00..7283c018dbaf 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -387,6 +387,7 @@ static const struct drm_gem_object_funcs vc4_gem_object_funcs = {
 	.export = vc4_prime_export,
 	.get_sg_table = drm_gem_cma_get_sg_table,
 	.vmap = vc4_prime_vmap,
+	.vmap_local = drm_gem_cma_vmap_local,
 	.vm_ops = &vc4_vm_ops,
 };
 
diff --git a/include/drm/drm_gem_cma_helper.h b/include/drm/drm_gem_cma_helper.h
index 0a9711caa3e8..05122e71bc6d 100644
--- a/include/drm/drm_gem_cma_helper.h
+++ b/include/drm/drm_gem_cma_helper.h
@@ -99,6 +99,7 @@ drm_gem_cma_prime_import_sg_table(struct drm_device *dev,
 				  struct dma_buf_attachment *attach,
 				  struct sg_table *sgt);
 int drm_gem_cma_vmap(struct drm_gem_object *obj, struct dma_buf_map *map);
+int drm_gem_cma_vmap_local(struct drm_gem_object *obj, struct dma_buf_map *map);
 int drm_gem_cma_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
 
 /**
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
