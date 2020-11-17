Return-Path: <SRS0=We/I=EX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863C2C2D0E4
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 13:32:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1285321734
	for <virtualization@archiver.kernel.org>; Tue, 17 Nov 2020 13:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1285321734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B6B8483970;
	Tue, 17 Nov 2020 13:32:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fpc5-ZjkN2Ec; Tue, 17 Nov 2020 13:32:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E66E3849A6;
	Tue, 17 Nov 2020 13:32:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C81ECC0800;
	Tue, 17 Nov 2020 13:32:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4371BC07FF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 13:32:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 29F022047D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 13:32:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jcvhlO-s91FC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 13:32:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 4BA522046F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Nov 2020 13:32:01 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 67719AF93;
 Tue, 17 Nov 2020 13:31:58 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, yuq825@gmail.com, robh@kernel.org,
 tomeu.vizoso@collabora.com, steven.price@arm.com,
 alyssa.rosenzweig@collabora.com, sean@poorly.run, eric@anholt.net,
 kraxel@redhat.com, rodrigosiqueiramelo@gmail.com, melissa.srw@gmail.com,
 hamohammed.sa@gmail.com, hdegoede@redhat.com
Subject: [PATCH v3 1/2] drm/shmem-helper: Use cached mappings by default
Date: Tue, 17 Nov 2020 14:31:55 +0100
Message-Id: <20201117133156.26822-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117133156.26822-1-tzimmermann@suse.de>
References: <20201117133156.26822-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Thomas Zimmermann <tzimmermann@suse.de>, lima@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

SHMEM-buffer backing storage is allocated from system memory; which is
typically cachable. The default mode for SHMEM objects is writecombine
though.

Unify SHMEM semantics by defaulting to cached mappings. The exception
is pages imported via dma-buf. DMA memory is usually not cached.

DRM drivers that require write-combined mappings set the map_wc flag
in struct drm_gem_shmem_object to true. This currently affects lima,
panfrost and v3d.

The drivers mgag200, udl, virtio and vkms continue to use default
shmem mappings.

The drivers cirrus and gm12u320 change caching flags. Both used
writecombine and now switch over to shmem defaults. Both drivers use
SHMEM objects as shadow buffers for internal video memory, so cached
mappings will not affect them negatively.

v3:
	* set value of shmem pointer before dereferencing it in
	  __drm_gem_shmem_create() (Dan, kernel test robot)
v2:
	* recreate patch on top of latest SHMEM helpers
	* update lima, panfrost, v3d to select writecombine (Daniel, Rob)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_shmem_helper.c  | 14 ++++++++------
 drivers/gpu/drm/lima/lima_gem.c         |  2 +-
 drivers/gpu/drm/panfrost/panfrost_gem.c |  2 +-
 drivers/gpu/drm/v3d/v3d_bo.c            |  2 +-
 drivers/gpu/drm/virtio/virtgpu_object.c |  1 -
 include/drm/drm_gem_shmem_helper.h      |  4 ++--
 6 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index 499189c48f0b..b1c7a316f232 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -51,13 +51,17 @@ __drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private)
 	if (!obj)
 		return ERR_PTR(-ENOMEM);
 
+	shmem = to_drm_gem_shmem_obj(obj);
+
 	if (!obj->funcs)
 		obj->funcs = &drm_gem_shmem_funcs;
 
-	if (private)
+	if (private) {
 		drm_gem_private_object_init(dev, obj, size);
-	else
+		shmem->map_wc = false; /* dma-buf mappings use always writecombine */
+	} else {
 		ret = drm_gem_object_init(dev, obj, size);
+	}
 	if (ret)
 		goto err_free;
 
@@ -65,7 +69,6 @@ __drm_gem_shmem_create(struct drm_device *dev, size_t size, bool private)
 	if (ret)
 		goto err_release;
 
-	shmem = to_drm_gem_shmem_obj(obj);
 	mutex_init(&shmem->pages_lock);
 	mutex_init(&shmem->vmap_lock);
 	INIT_LIST_HEAD(&shmem->madv_list);
@@ -284,7 +287,7 @@ static int drm_gem_shmem_vmap_locked(struct drm_gem_shmem_object *shmem, struct
 		if (ret)
 			goto err_zero_use;
 
-		if (!shmem->map_cached)
+		if (shmem->map_wc)
 			prot = pgprot_writecombine(prot);
 		shmem->vaddr = vmap(shmem->pages, obj->size >> PAGE_SHIFT,
 				    VM_MAP, prot);
@@ -497,7 +500,6 @@ drm_gem_shmem_create_object_cached(struct drm_device *dev, size_t size)
 	shmem = kzalloc(sizeof(*shmem), GFP_KERNEL);
 	if (!shmem)
 		return NULL;
-	shmem->map_cached = true;
 
 	return &shmem->base;
 }
@@ -626,7 +628,7 @@ int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 
 	vma->vm_flags |= VM_MIXEDMAP | VM_DONTEXPAND;
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-	if (!shmem->map_cached)
+	if (shmem->map_wc)
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 	vma->vm_ops = &drm_gem_shmem_vm_ops;
 
diff --git a/drivers/gpu/drm/lima/lima_gem.c b/drivers/gpu/drm/lima/lima_gem.c
index 832e5280a6ed..de62966243cd 100644
--- a/drivers/gpu/drm/lima/lima_gem.c
+++ b/drivers/gpu/drm/lima/lima_gem.c
@@ -225,7 +225,7 @@ struct drm_gem_object *lima_gem_create_object(struct drm_device *dev, size_t siz
 
 	mutex_init(&bo->lock);
 	INIT_LIST_HEAD(&bo->va);
-
+	bo->base.map_wc = true;
 	bo->base.base.funcs = &lima_gem_funcs;
 
 	return &bo->base.base;
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index 57a31dd0ffed..3e0723bc36bd 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -228,7 +228,7 @@ struct drm_gem_object *panfrost_gem_create_object(struct drm_device *dev, size_t
 	INIT_LIST_HEAD(&obj->mappings.list);
 	mutex_init(&obj->mappings.lock);
 	obj->base.base.funcs = &panfrost_gem_funcs;
-	obj->base.map_cached = pfdev->coherent;
+	obj->base.map_wc = !pfdev->coherent;
 
 	return &obj->base.base;
 }
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index 8b52cb25877c..6a8731ab9d7d 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -78,7 +78,7 @@ struct drm_gem_object *v3d_create_object(struct drm_device *dev, size_t size)
 	obj = &bo->base.base;
 
 	obj->funcs = &v3d_gem_funcs;
-
+	bo->base.map_wc = true;
 	INIT_LIST_HEAD(&bo->unref_head);
 
 	return &bo->base.base;
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index d9ad27e00905..d69a5b6da553 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -144,7 +144,6 @@ struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
 
 	dshmem = &shmem->base.base;
 	dshmem->base.funcs = &virtio_gpu_shmem_funcs;
-	dshmem->map_cached = true;
 	return &dshmem->base;
 }
 
diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 3449a0353fe0..f32801db3203 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -98,9 +98,9 @@ struct drm_gem_shmem_object {
 	unsigned int vmap_use_count;
 
 	/**
-	 * @map_cached: map object cached (instead of using writecombine).
+	 * @map_wc: map object write-combined (instead of using shmem defaults).
 	 */
-	bool map_cached;
+	bool map_wc;
 };
 
 #define to_drm_gem_shmem_obj(obj) \
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
