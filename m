Return-Path: <SRS0=LX6v=GL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3B6C43381
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:44:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F3B235FC
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F3B235FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F108A2E11D;
	Fri,  8 Jan 2021 09:44:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UC5+lECfEYz4; Fri,  8 Jan 2021 09:43:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 872A5204F6;
	Fri,  8 Jan 2021 09:43:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6E09EC088B;
	Fri,  8 Jan 2021 09:43:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A385C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 79198875A3
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SceU5NYQH296
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 697E08757C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:51 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 02ED9AFE2;
 Fri,  8 Jan 2021 09:43:50 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, airlied@redhat.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 kraxel@redhat.com, hdegoede@redhat.com, sean@poorly.run, eric@anholt.net,
 sam@ravnborg.org
Subject: [PATCH v4 09/13] drm/vram-helper: Provide a vmap function for
 short-term mappings
Date: Fri,  8 Jan 2021 10:43:36 +0100
Message-Id: <20210108094340.15290-10-tzimmermann@suse.de>
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
It's somewhat inconvenient to callers that simply require a mapping of
the contained memory; and also ipmplies a certain overhead.

Therefore provide drm_gem_vram_vmap_local() drm_gem_vram_vunmap_local(),
which only perform the vmap/vunmap operations. Callers have to hold the
reservation lock while the mapping persists; or have to pin the BO by
themselves.

This patch connects GEM VRAM helpers to GEM object functions with
equivalent functionality.

v4:
	* move driver changes into separate patches (Daniel)
	* update documentation (Daniel)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 141 +++++++++++++++++---------
 include/drm/drm_gem_vram_helper.h     |   2 +
 2 files changed, 95 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 02ca22e90290..c7fba3a0758e 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -379,47 +379,6 @@ int drm_gem_vram_unpin(struct drm_gem_vram_object *gbo)
 }
 EXPORT_SYMBOL(drm_gem_vram_unpin);
 
-static int drm_gem_vram_kmap_locked(struct drm_gem_vram_object *gbo,
-				    struct dma_buf_map *map)
-{
-	int ret;
-
-	if (gbo->vmap_use_count > 0)
-		goto out;
-
-	ret = ttm_bo_vmap(&gbo->bo, &gbo->map);
-	if (ret)
-		return ret;
-
-out:
-	++gbo->vmap_use_count;
-	*map = gbo->map;
-
-	return 0;
-}
-
-static void drm_gem_vram_kunmap_locked(struct drm_gem_vram_object *gbo,
-				       struct dma_buf_map *map)
-{
-	struct drm_device *dev = gbo->bo.base.dev;
-
-	if (drm_WARN_ON_ONCE(dev, !gbo->vmap_use_count))
-		return;
-
-	if (drm_WARN_ON_ONCE(dev, !dma_buf_map_is_equal(&gbo->map, map)))
-		return; /* BUG: map not mapped from this BO */
-
-	if (--gbo->vmap_use_count > 0)
-		return;
-
-	/*
-	 * Permanently mapping and unmapping buffers adds overhead from
-	 * updating the page tables and creates debugging output. Therefore,
-	 * we delay the actual unmap operation until the BO gets evicted
-	 * from memory. See drm_gem_vram_bo_driver_move_notify().
-	 */
-}
-
 /**
  * drm_gem_vram_vmap() - Pins and maps a GEM VRAM object into kernel address
  *                       space
@@ -447,7 +406,7 @@ int drm_gem_vram_vmap(struct drm_gem_vram_object *gbo, struct dma_buf_map *map)
 	ret = drm_gem_vram_pin_locked(gbo, 0);
 	if (ret)
 		goto err_ttm_bo_unreserve;
-	ret = drm_gem_vram_kmap_locked(gbo, map);
+	ret = drm_gem_vram_vmap_local(gbo, map);
 	if (ret)
 		goto err_drm_gem_vram_unpin_locked;
 
@@ -479,13 +438,83 @@ void drm_gem_vram_vunmap(struct drm_gem_vram_object *gbo, struct dma_buf_map *ma
 	if (WARN_ONCE(ret, "ttm_bo_reserve_failed(): ret=%d\n", ret))
 		return;
 
-	drm_gem_vram_kunmap_locked(gbo, map);
+	drm_gem_vram_vunmap_local(gbo, map);
 	drm_gem_vram_unpin_locked(gbo);
 
 	ttm_bo_unreserve(&gbo->bo);
 }
 EXPORT_SYMBOL(drm_gem_vram_vunmap);
 
+/**
+ * drm_gem_vram_vmap_local() - Maps a GEM VRAM object into kernel address space
+ * @gbo: The GEM VRAM object to map
+ * @map: Returns the kernel virtual address of the VRAM GEM object's backing
+ *       store.
+ *
+ * The vmap_local function maps the buffer of a GEM VRAM object into kernel address
+ * space. Call drm_gem_vram_vunmap_local() with the returned address to unmap and
+ * unpin the GEM VRAM object.
+ *
+ * The function is called with the BO's reservation object locked. For short-term
+ * mappings, callers must hold the BO's reservation lock until after unmapping the
+ * buffer.
+ *
+ * Returns:
+ * 0 on success, or a negative error code otherwise.
+ */
+int drm_gem_vram_vmap_local(struct drm_gem_vram_object *gbo, struct dma_buf_map *map)
+{
+	int ret;
+
+	dma_resv_assert_held(gbo->bo.base.resv);
+
+	if (gbo->vmap_use_count > 0)
+		goto out;
+
+	ret = ttm_bo_vmap(&gbo->bo, &gbo->map);
+	if (ret)
+		return ret;
+
+out:
+	++gbo->vmap_use_count;
+	*map = gbo->map;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_gem_vram_vmap_local);
+
+/**
+ * drm_gem_vram_vunmap_local() - Unmaps a GEM VRAM object
+ * @gbo: The GEM VRAM object to unmap
+ * @map: Kernel virtual address where the VRAM GEM object was mapped
+ *
+ * A call to drm_gem_vram_vunmap_local() unmaps a GEM VRAM object's buffer. See
+ * the documentation for drm_gem_vram_vmap_local() for more information.
+ */
+void drm_gem_vram_vunmap_local(struct drm_gem_vram_object *gbo, struct dma_buf_map *map)
+{
+	struct drm_device *dev = gbo->bo.base.dev;
+
+	dma_resv_assert_held(gbo->bo.base.resv);
+
+	if (drm_WARN_ON_ONCE(dev, !gbo->vmap_use_count))
+		return;
+
+	if (drm_WARN_ON_ONCE(dev, !dma_buf_map_is_equal(&gbo->map, map)))
+		return; /* BUG: map not mapped from this BO */
+
+	if (--gbo->vmap_use_count > 0)
+		return;
+
+	/*
+	 * Permanently mapping and unmapping buffers adds overhead from
+	 * updating the page tables and creates debugging output. Therefore,
+	 * we delay the actual unmap operation until the BO gets evicted
+	 * from memory. See drm_gem_vram_bo_driver_move_notify().
+	 */
+}
+EXPORT_SYMBOL(drm_gem_vram_vunmap_local);
+
 /**
  * drm_gem_vram_fill_create_dumb() - \
 	Helper for implementing &struct drm_driver.dumb_create
@@ -871,17 +900,33 @@ static void drm_gem_vram_object_vunmap(struct drm_gem_object *gem, struct dma_bu
 	drm_gem_vram_vunmap(gbo, map);
 }
 
+static int drm_gem_vram_object_vmap_local(struct drm_gem_object *gem, struct dma_buf_map *map)
+{
+	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(gem);
+
+	return drm_gem_vram_vmap_local(gbo, map);
+}
+
+static void drm_gem_vram_object_vunmap_local(struct drm_gem_object *gem, struct dma_buf_map *map)
+{
+	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(gem);
+
+	drm_gem_vram_vunmap_local(gbo, map);
+}
+
 /*
  * GEM object funcs
  */
 
 static const struct drm_gem_object_funcs drm_gem_vram_object_funcs = {
-	.free	= drm_gem_vram_object_free,
-	.pin	= drm_gem_vram_object_pin,
-	.unpin	= drm_gem_vram_object_unpin,
-	.vmap	= drm_gem_vram_object_vmap,
+	.free = drm_gem_vram_object_free,
+	.pin = drm_gem_vram_object_pin,
+	.unpin = drm_gem_vram_object_unpin,
+	.vmap = drm_gem_vram_object_vmap,
 	.vunmap	= drm_gem_vram_object_vunmap,
-	.mmap   = drm_gem_ttm_mmap,
+	.vmap_local = drm_gem_vram_object_vmap_local,
+	.vunmap_local = drm_gem_vram_object_vunmap_local,
+	.mmap = drm_gem_ttm_mmap,
 	.print_info = drm_gem_ttm_print_info,
 };
 
diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index a4bac02249c2..bd6a60e7c22b 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -99,6 +99,8 @@ int drm_gem_vram_pin(struct drm_gem_vram_object *gbo, unsigned long pl_flag);
 int drm_gem_vram_unpin(struct drm_gem_vram_object *gbo);
 int drm_gem_vram_vmap(struct drm_gem_vram_object *gbo, struct dma_buf_map *map);
 void drm_gem_vram_vunmap(struct drm_gem_vram_object *gbo, struct dma_buf_map *map);
+int drm_gem_vram_vmap_local(struct drm_gem_vram_object *gbo, struct dma_buf_map *map);
+void drm_gem_vram_vunmap_local(struct drm_gem_vram_object *gbo, struct dma_buf_map *map);
 
 int drm_gem_vram_fill_create_dumb(struct drm_file *file,
 				  struct drm_device *dev,
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
