Return-Path: <SRS0=LX6v=GL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BF5C433DB
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:44:00 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A877236F9
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A877236F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 335EF2E126;
	Fri,  8 Jan 2021 09:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r26rAgOMJou5; Fri,  8 Jan 2021 09:43:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 022EC2E125;
	Fri,  8 Jan 2021 09:43:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5913C1E71;
	Fri,  8 Jan 2021 09:43:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 182D8C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id A292787593
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q5f3JQxnMfc9
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E085E87564
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:47 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 65BF9AFA7;
 Fri,  8 Jan 2021 09:43:46 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, airlied@redhat.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 kraxel@redhat.com, hdegoede@redhat.com, sean@poorly.run, eric@anholt.net,
 sam@ravnborg.org
Subject: [PATCH v4 04/13] drm/shmem-helper: Provide a vmap function for
 short-term mappings
Date: Fri,  8 Jan 2021 10:43:31 +0100
Message-Id: <20210108094340.15290-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108094340.15290-1-tzimmermann@suse.de>
References: <20210108094340.15290-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linaro-mm-sig@lists.linaro.org, virtualization@lists.linux-foundation.org,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org
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
This is less of an issue with private SHMEM buffers, but may happen
with imported ones.

Therefore provide the new interfaces drm_gem_shmem_vmap_local() and
drm_gem_shmem_vunmap_local(), which only perform the vmap/vunmap
operations. Callers have to hold the reservation lock while the mapping
persists.

This patch also connects GEM SHMEM helpers to GEM object functions with
equivalent functionality.

v4:
	* call dma_buf_{vmap,vunmap}_local() where necessary (Daniel)
	* move driver changes into separate patches (Daniel)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c | 90 +++++++++++++++++++++++---
 include/drm/drm_gem_shmem_helper.h     |  2 +
 2 files changed, 84 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 9825c378dfa6..298832b2b43b 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -32,6 +32,8 @@ static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
 	.get_sg_table = drm_gem_shmem_get_sg_table,
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
+	.vmap_local = drm_gem_shmem_vmap_local,
+	.vunmap_local = drm_gem_shmem_vunmap_local,
 	.mmap = drm_gem_shmem_mmap,
 };
 
@@ -261,7 +263,8 @@ void drm_gem_shmem_unpin(struct drm_gem_object *obj)
 }
 EXPORT_SYMBOL(drm_gem_shmem_unpin);
 
-static int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem, struct dma_buf_map *map)
+static int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem, struct dma_buf_map *map,
+				     bool local)
 {
 	struct drm_gem_object *obj = &shmem->base;
 	int ret = 0;
@@ -272,7 +275,10 @@ static int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem, struct
 	}
 
 	if (obj->import_attach) {
-		ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
+		if (local)
+			ret = dma_buf_vmap_local(obj->import_attach->dmabuf, map);
+		else
+			ret = dma_buf_vmap(obj->import_attach->dmabuf, map);
 		if (!ret) {
 			if (WARN_ON(map->is_iomem)) {
 				ret = -EIO;
@@ -313,7 +319,7 @@ static int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem, struct
 	return ret;
 }
 
-/*
+/**
  * drm_gem_shmem_vmap - Create a virtual mapping for a shmem GEM object
  * @shmem: shmem GEM object
  * @map: Returns the kernel virtual address of the SHMEM GEM object's backing
@@ -339,15 +345,53 @@ int drm_gem_shmem_vmap(struct drm_gem_object *obj, struct dma_buf_map *map)
 	ret = mutex_lock_interruptible(&shmem->vmap_lock);
 	if (ret)
 		return ret;
-	ret = drm_gem_shmem_vmap_locked(shmem, map);
+	ret = drm_gem_shmem_vmap_locked(shmem, map, false);
 	mutex_unlock(&shmem->vmap_lock);
 
 	return ret;
 }
 EXPORT_SYMBOL(drm_gem_shmem_vmap);
 
+/**
+ * drm_gem_shmem_vmap_local - Create a virtual mapping for a shmem GEM object
+ * @shmem: shmem GEM object
+ * @map: Returns the kernel virtual address of the SHMEM GEM object's backing
+ *       store.
+ *
+ * This function makes sure that a contiguous kernel virtual address mapping
+ * exists for the buffer backing the shmem GEM object.
+ *
+ * The function is called with the BO's reservation object locked. Callers must
+ * hold the lock until after unmapping the buffer.
+ *
+ * This function can be used to implement &drm_gem_object_funcs.vmap_local. But
+ * it can also be called by drivers directly, in which case it will hide the
+ * differences between dma-buf imported and natively allocated objects.
+ *
+ * Acquired mappings should be cleaned up by calling drm_gem_shmem_vunmap_local().
+ *
+ * Returns:
+ * 0 on success or a negative error code on failure.
+ */
+int drm_gem_shmem_vmap_local(struct drm_gem_object *obj, struct dma_buf_map *map)
+{
+	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
+	int ret;
+
+	dma_resv_assert_held(obj->resv);
+
+	ret = mutex_lock_interruptible(&shmem->vmap_lock);
+	if (ret)
+		return ret;
+	ret = drm_gem_shmem_vmap_locked(shmem, map, true);
+	mutex_unlock(&shmem->vmap_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL(drm_gem_shmem_vmap_local);
+
 static void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
-					struct dma_buf_map *map)
+					struct dma_buf_map *map, bool local)
 {
 	struct drm_gem_object *obj = &shmem->base;
 
@@ -358,7 +402,10 @@ static void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 		return;
 
 	if (obj->import_attach)
-		dma_buf_vunmap(obj->import_attach->dmabuf, map);
+		if (local)
+			dma_buf_vunmap_local(obj->import_attach->dmabuf, map);
+		else
+			dma_buf_vunmap(obj->import_attach->dmabuf, map);
 	else
 		vunmap(shmem->vaddr);
 
@@ -366,7 +413,7 @@ static void drm_gem_shmem_vunmap_locked(struct drm_gem_shmem_object *shmem,
 	drm_gem_shmem_put_pages(shmem);
 }
 
-/*
+/**
  * drm_gem_shmem_vunmap - Unmap a virtual mapping fo a shmem GEM object
  * @shmem: shmem GEM object
  * @map: Kernel virtual address where the SHMEM GEM object was mapped
@@ -384,11 +431,38 @@ void drm_gem_shmem_vunmap(struct drm_gem_object *obj, struct dma_buf_map *map)
 	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
 
 	mutex_lock(&shmem->vmap_lock);
-	drm_gem_shmem_vunmap_locked(shmem, map);
+	drm_gem_shmem_vunmap_locked(shmem, map, false);
 	mutex_unlock(&shmem->vmap_lock);
 }
 EXPORT_SYMBOL(drm_gem_shmem_vunmap);
 
+/**
+ * drm_gem_shmem_vunmap_local - Unmap a virtual mapping fo a shmem GEM object
+ * @shmem: shmem GEM object
+ * @map: Kernel virtual address where the SHMEM GEM object was mapped
+ *
+ * This function cleans up a kernel virtual address mapping acquired by
+ * drm_gem_shmem_vmap_local(). The mapping is only removed when the use count
+ * drops to zero.
+ *
+ * The function is called with the BO's reservation object locked.
+ *
+ * This function can be used to implement &drm_gem_object_funcs.vmap_local.
+ * But it can also be called by drivers directly, in which case it will hide
+ * the differences between dma-buf imported and natively allocated objects.
+ */
+void drm_gem_shmem_vunmap_local(struct drm_gem_object *obj, struct dma_buf_map *map)
+{
+	struct drm_gem_shmem_object *shmem = to_drm_gem_shmem_obj(obj);
+
+	dma_resv_assert_held(obj->resv);
+
+	mutex_lock(&shmem->vmap_lock);
+	drm_gem_shmem_vunmap_locked(shmem, map, true);
+	mutex_unlock(&shmem->vmap_lock);
+}
+EXPORT_SYMBOL(drm_gem_shmem_vunmap_local);
+
 struct drm_gem_shmem_object *
 drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
 				 struct drm_device *dev, size_t size,
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 434328d8a0d9..3f59bdf749aa 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -114,7 +114,9 @@ void drm_gem_shmem_put_pages(struct drm_gem_shmem_object *shmem);
 int drm_gem_shmem_pin(struct drm_gem_object *obj);
 void drm_gem_shmem_unpin(struct drm_gem_object *obj);
 int drm_gem_shmem_vmap(struct drm_gem_object *obj, struct dma_buf_map *map);
+int drm_gem_shmem_vmap_local(struct drm_gem_object *obj, struct dma_buf_map *map);
 void drm_gem_shmem_vunmap(struct drm_gem_object *obj, struct dma_buf_map *map);
+void drm_gem_shmem_vunmap_local(struct drm_gem_object *obj, struct dma_buf_map *map);
 
 int drm_gem_shmem_madvise(struct drm_gem_object *obj, int madv);
 
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
