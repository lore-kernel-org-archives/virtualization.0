From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 11/19] drm/bochs: Convert bochs driver to |struct
	drm_gem_vram_object|
Date: Mon, 29 Apr 2019 16:43:33 +0200
Message-ID: <20190429144341.12615-12-tzimmermann__38599.8967614555$1556549371$gmane$org@suse.de>
References: <20190429144341.12615-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190429144341.12615-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: daniel@ffwll.ch, airlied@linux.ie, kraxel@redhat.com, christian.koenig@amd.com, ray.huang@amd.com, Jerry.Zhang@amd.com, hdegoede@redhat.com, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The data structure |struct drm_gem_vram_object| and its helpers replace
|struct bochs_bo|. It's the same implementation; except for the type
names.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/bochs/Kconfig     |   1 +
 drivers/gpu/drm/bochs/bochs.h     |  34 +---
 drivers/gpu/drm/bochs/bochs_drv.c |   4 +-
 drivers/gpu/drm/bochs/bochs_kms.c |  18 +-
 drivers/gpu/drm/bochs/bochs_mm.c  | 270 +++---------------------------
 5 files changed, 34 insertions(+), 293 deletions(-)

diff --git a/drivers/gpu/drm/bochs/Kconfig b/drivers/gpu/drm/bochs/Kconfig
index bd2718015cdb..c04f8041a2b9 100644
--- a/drivers/gpu/drm/bochs/Kconfig
+++ b/drivers/gpu/drm/bochs/Kconfig
@@ -3,6 +3,7 @@ config DRM_BOCHS
 	depends on DRM && PCI && MMU
 	select DRM_KMS_HELPER
 	select DRM_TTM
+	select DRM_GEM_VRAM_HELPER
 	help
 	  Choose this option for qemu.
 	  If M is selected the module will be called bochs-drm.
diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 341cc9d1bab4..4ccf82e1ca68 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -10,6 +10,7 @@
 #include <drm/drm_simple_kms_helper.h>
 
 #include <drm/drm_gem.h>
+#include <drm/drm_gem_vram_helper.h>
 
 #include <drm/ttm/ttm_bo_driver.h>
 #include <drm/ttm/ttm_page_alloc.h>
@@ -81,30 +82,6 @@ struct bochs_device {
 	} ttm;
 };
 
-struct bochs_bo {
-	struct ttm_buffer_object bo;
-	struct ttm_placement placement;
-	struct ttm_bo_kmap_obj kmap;
-	struct drm_gem_object gem;
-	struct ttm_place placements[3];
-	int pin_count;
-};
-
-static inline struct bochs_bo *bochs_bo(struct ttm_buffer_object *bo)
-{
-	return container_of(bo, struct bochs_bo, bo);
-}
-
-static inline struct bochs_bo *gem_to_bochs_bo(struct drm_gem_object *gem)
-{
-	return container_of(gem, struct bochs_bo, gem);
-}
-
-static inline u64 bochs_bo_mmap_offset(struct bochs_bo *bo)
-{
-	return drm_vma_node_offset_addr(&bo->bo.vma_node);
-}
-
 /* ---------------------------------------------------------------------- */
 
 /* bochs_hw.c */
@@ -124,17 +101,8 @@ int bochs_mm_init(struct bochs_device *bochs);
 void bochs_mm_fini(struct bochs_device *bochs);
 int bochs_mmap(struct file *filp, struct vm_area_struct *vma);
 
-int bochs_gem_create(struct drm_device *dev, u32 size, bool iskernel,
-		     struct drm_gem_object **obj);
-int bochs_gem_init_object(struct drm_gem_object *obj);
-void bochs_gem_free_object(struct drm_gem_object *obj);
 int bochs_dumb_create(struct drm_file *file, struct drm_device *dev,
 		      struct drm_mode_create_dumb *args);
-int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
-			   uint32_t handle, uint64_t *offset);
-
-int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag);
-int bochs_bo_unpin(struct bochs_bo *bo);
 
 int bochs_gem_prime_pin(struct drm_gem_object *obj);
 void bochs_gem_prime_unpin(struct drm_gem_object *obj);
diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 6b6e037258c3..4f269f464e6d 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -82,9 +82,9 @@ static struct drm_driver bochs_driver = {
 	.date			= "20130925",
 	.major			= 1,
 	.minor			= 0,
-	.gem_free_object_unlocked = bochs_gem_free_object,
+	.gem_free_object_unlocked = drm_gem_vram_driver_gem_free_object_unlocked,
 	.dumb_create            = bochs_dumb_create,
-	.dumb_map_offset        = bochs_dumb_mmap_offset,
+	.dumb_map_offset        = drm_gem_vram_driver_dumb_mmap_offset,
 
 	.gem_prime_export = drm_gem_prime_export,
 	.gem_prime_import = drm_gem_prime_import,
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 5e905f50449d..9e3ee7b511fb 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -30,16 +30,16 @@ static const uint32_t bochs_formats[] = {
 static void bochs_plane_update(struct bochs_device *bochs,
 			       struct drm_plane_state *state)
 {
-	struct bochs_bo *bo;
+	struct drm_gem_vram_object *gbo;
 
 	if (!state->fb || !bochs->stride)
 		return;
 
-	bo = gem_to_bochs_bo(state->fb->obj[0]);
+	gbo = drm_gem_vram_of_gem(state->fb->obj[0]);
 	bochs_hw_setbase(bochs,
 			 state->crtc_x,
 			 state->crtc_y,
-			 bo->bo.offset);
+			 gbo->bo.offset);
 	bochs_hw_setformat(bochs, state->fb->format);
 }
 
@@ -72,23 +72,23 @@ static void bochs_pipe_update(struct drm_simple_display_pipe *pipe,
 static int bochs_pipe_prepare_fb(struct drm_simple_display_pipe *pipe,
 				 struct drm_plane_state *new_state)
 {
-	struct bochs_bo *bo;
+	struct drm_gem_vram_object *gbo;
 
 	if (!new_state->fb)
 		return 0;
-	bo = gem_to_bochs_bo(new_state->fb->obj[0]);
-	return bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
+	gbo = drm_gem_vram_of_gem(new_state->fb->obj[0]);
+	return drm_gem_vram_pin(gbo, DRM_GEM_VRAM_PL_FLAG_VRAM);
 }
 
 static void bochs_pipe_cleanup_fb(struct drm_simple_display_pipe *pipe,
 				  struct drm_plane_state *old_state)
 {
-	struct bochs_bo *bo;
+	struct drm_gem_vram_object *gbo;
 
 	if (!old_state->fb)
 		return;
-	bo = gem_to_bochs_bo(old_state->fb->obj[0]);
-	bochs_bo_unpin(bo);
+	gbo = drm_gem_vram_of_gem(old_state->fb->obj[0]);
+	drm_gem_vram_unpin(gbo);
 }
 
 static const struct drm_simple_display_pipe_funcs bochs_pipe_funcs = {
diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index 4a40308169c4..5837adc6ae17 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -7,8 +7,6 @@
 
 #include "bochs.h"
 
-static void bochs_ttm_placement(struct bochs_bo *bo, int domain);
-
 /* ---------------------------------------------------------------------- */
 
 static inline struct bochs_device *bochs_bdev(struct ttm_bo_device *bd)
@@ -16,22 +14,6 @@ static inline struct bochs_device *bochs_bdev(struct ttm_bo_device *bd)
 	return container_of(bd, struct bochs_device, ttm.bdev);
 }
 
-static void bochs_bo_ttm_destroy(struct ttm_buffer_object *tbo)
-{
-	struct bochs_bo *bo;
-
-	bo = container_of(tbo, struct bochs_bo, bo);
-	drm_gem_object_release(&bo->gem);
-	kfree(bo);
-}
-
-static bool bochs_ttm_bo_is_bochs_bo(struct ttm_buffer_object *bo)
-{
-	if (bo->destroy == &bochs_bo_ttm_destroy)
-		return true;
-	return false;
-}
-
 static int bochs_bo_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 				  struct ttm_mem_type_manager *man)
 {
@@ -56,27 +38,6 @@ static int bochs_bo_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 	return 0;
 }
 
-static void
-bochs_bo_evict_flags(struct ttm_buffer_object *bo, struct ttm_placement *pl)
-{
-	struct bochs_bo *bochsbo = bochs_bo(bo);
-
-	if (!bochs_ttm_bo_is_bochs_bo(bo))
-		return;
-
-	bochs_ttm_placement(bochsbo, TTM_PL_FLAG_SYSTEM);
-	*pl = bochsbo->placement;
-}
-
-static int bochs_bo_verify_access(struct ttm_buffer_object *bo,
-				  struct file *filp)
-{
-	struct bochs_bo *bochsbo = bochs_bo(bo);
-
-	return drm_vma_node_verify_access(&bochsbo->gem.vma_node,
-					  filp->private_data);
-}
-
 static int bochs_ttm_io_mem_reserve(struct ttm_bo_device *bdev,
 				    struct ttm_mem_reg *mem)
 {
@@ -141,9 +102,9 @@ static struct ttm_bo_driver bochs_bo_driver = {
 	.ttm_tt_create = bochs_ttm_tt_create,
 	.init_mem_type = bochs_bo_init_mem_type,
 	.eviction_valuable = ttm_bo_eviction_valuable,
-	.evict_flags = bochs_bo_evict_flags,
+	.evict_flags = drm_gem_vram_bo_driver_evict_flags,
 	.move = NULL,
-	.verify_access = bochs_bo_verify_access,
+	.verify_access = drm_gem_vram_bo_driver_verify_access,
 	.io_mem_reserve = &bochs_ttm_io_mem_reserve,
 	.io_mem_free = &bochs_ttm_io_mem_free,
 };
@@ -182,85 +143,6 @@ void bochs_mm_fini(struct bochs_device *bochs)
 	bochs->ttm.initialized = false;
 }
 
-static void bochs_ttm_placement(struct bochs_bo *bo, int domain)
-{
-	unsigned i;
-	u32 c = 0;
-	bo->placement.placement = bo->placements;
-	bo->placement.busy_placement = bo->placements;
-	if (domain & TTM_PL_FLAG_VRAM) {
-		bo->placements[c++].flags = TTM_PL_FLAG_WC
-			| TTM_PL_FLAG_UNCACHED
-			| TTM_PL_FLAG_VRAM;
-	}
-	if (domain & TTM_PL_FLAG_SYSTEM) {
-		bo->placements[c++].flags = TTM_PL_MASK_CACHING
-			| TTM_PL_FLAG_SYSTEM;
-	}
-	if (!c) {
-		bo->placements[c++].flags = TTM_PL_MASK_CACHING
-			| TTM_PL_FLAG_SYSTEM;
-	}
-	for (i = 0; i < c; ++i) {
-		bo->placements[i].fpfn = 0;
-		bo->placements[i].lpfn = 0;
-	}
-	bo->placement.num_placement = c;
-	bo->placement.num_busy_placement = c;
-}
-
-int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag)
-{
-	struct ttm_operation_ctx ctx = { false, false };
-	int i, ret;
-
-	if (bo->pin_count) {
-		bo->pin_count++;
-		return 0;
-	}
-
-	bochs_ttm_placement(bo, pl_flag);
-	for (i = 0; i < bo->placement.num_placement; i++)
-		bo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
-	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
-	if (ret)
-		return ret;
-	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
-	ttm_bo_unreserve(&bo->bo);
-	if (ret)
-		return ret;
-
-	bo->pin_count = 1;
-	return 0;
-}
-
-int bochs_bo_unpin(struct bochs_bo *bo)
-{
-	struct ttm_operation_ctx ctx = { false, false };
-	int i, ret;
-
-	if (!bo->pin_count) {
-		DRM_ERROR("unpin bad %p\n", bo);
-		return 0;
-	}
-	bo->pin_count--;
-
-	if (bo->pin_count)
-		return 0;
-
-	for (i = 0; i < bo->placement.num_placement; i++)
-		bo->placements[i].flags &= ~TTM_PL_FLAG_NO_EVICT;
-	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
-	if (ret)
-		return ret;
-	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
-	ttm_bo_unreserve(&bo->bo);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 int bochs_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct drm_file *file_priv = filp->private_data;
@@ -271,171 +153,61 @@ int bochs_mmap(struct file *filp, struct vm_area_struct *vma)
 
 /* ---------------------------------------------------------------------- */
 
-static int bochs_bo_create(struct drm_device *dev, int size, int align,
-			   uint32_t flags, struct bochs_bo **pbochsbo)
-{
-	struct bochs_device *bochs = dev->dev_private;
-	struct bochs_bo *bochsbo;
-	size_t acc_size;
-	int ret;
-
-	bochsbo = kzalloc(sizeof(struct bochs_bo), GFP_KERNEL);
-	if (!bochsbo)
-		return -ENOMEM;
-
-	ret = drm_gem_object_init(dev, &bochsbo->gem, size);
-	if (ret) {
-		kfree(bochsbo);
-		return ret;
-	}
-
-	bochsbo->bo.bdev = &bochs->ttm.bdev;
-	bochsbo->bo.bdev->dev_mapping = dev->anon_inode->i_mapping;
-
-	bochs_ttm_placement(bochsbo, TTM_PL_FLAG_VRAM | TTM_PL_FLAG_SYSTEM);
-
-	acc_size = ttm_bo_dma_acc_size(&bochs->ttm.bdev, size,
-				       sizeof(struct bochs_bo));
-
-	ret = ttm_bo_init(&bochs->ttm.bdev, &bochsbo->bo, size,
-			  ttm_bo_type_device, &bochsbo->placement,
-			  align >> PAGE_SHIFT, false, acc_size,
-			  NULL, NULL, bochs_bo_ttm_destroy);
-	if (ret)
-		return ret;
-
-	*pbochsbo = bochsbo;
-	return 0;
-}
-
-int bochs_gem_create(struct drm_device *dev, u32 size, bool iskernel,
-		     struct drm_gem_object **obj)
-{
-	struct bochs_bo *bochsbo;
-	int ret;
-
-	*obj = NULL;
-
-	size = PAGE_ALIGN(size);
-	if (size == 0)
-		return -EINVAL;
-
-	ret = bochs_bo_create(dev, size, 0, 0, &bochsbo);
-	if (ret) {
-		if (ret != -ERESTARTSYS)
-			DRM_ERROR("failed to allocate GEM object\n");
-		return ret;
-	}
-	*obj = &bochsbo->gem;
-	return 0;
-}
-
 int bochs_dumb_create(struct drm_file *file, struct drm_device *dev,
 		      struct drm_mode_create_dumb *args)
 {
-	struct drm_gem_object *gobj;
-	u32 handle;
-	int ret;
-
-	args->pitch = args->width * ((args->bpp + 7) / 8);
-	args->size = args->pitch * args->height;
-
-	ret = bochs_gem_create(dev, args->size, false,
-			       &gobj);
-	if (ret)
-		return ret;
-
-	ret = drm_gem_handle_create(file, gobj, &handle);
-	drm_gem_object_put_unlocked(gobj);
-	if (ret)
-		return ret;
-
-	args->handle = handle;
-	return 0;
-}
-
-static void bochs_bo_unref(struct bochs_bo **bo)
-{
-	struct ttm_buffer_object *tbo;
-
-	if ((*bo) == NULL)
-		return;
-
-	tbo = &((*bo)->bo);
-	ttm_bo_put(tbo);
-	*bo = NULL;
-}
-
-void bochs_gem_free_object(struct drm_gem_object *obj)
-{
-	struct bochs_bo *bochs_bo = gem_to_bochs_bo(obj);
-
-	bochs_bo_unref(&bochs_bo);
-}
-
-int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
-			   uint32_t handle, uint64_t *offset)
-{
-	struct drm_gem_object *obj;
-	struct bochs_bo *bo;
-
-	obj = drm_gem_object_lookup(file, handle);
-	if (obj == NULL)
-		return -ENOENT;
-
-	bo = gem_to_bochs_bo(obj);
-	*offset = bochs_bo_mmap_offset(bo);
+	struct bochs_device *bochs = dev->dev_private;
 
-	drm_gem_object_put_unlocked(obj);
-	return 0;
+	return drm_gem_vram_fill_create_dumb(file, dev, &bochs->ttm.bdev, 0,
+					     false, args);
 }
 
 /* ---------------------------------------------------------------------- */
 
 int bochs_gem_prime_pin(struct drm_gem_object *obj)
 {
-	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(obj);
 
-	return bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
+	return drm_gem_vram_pin(gbo, DRM_GEM_VRAM_PL_FLAG_VRAM);
 }
 
 void bochs_gem_prime_unpin(struct drm_gem_object *obj)
 {
-	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(obj);
 
-	bochs_bo_unpin(bo);
+	drm_gem_vram_unpin(gbo);
 }
 
 void *bochs_gem_prime_vmap(struct drm_gem_object *obj)
 {
-	struct bochs_bo *bo = gem_to_bochs_bo(obj);
-	bool is_iomem;
+	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(obj);
 	int ret;
+	void* base;
 
-	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
+	ret = drm_gem_vram_pin(gbo, DRM_GEM_VRAM_PL_FLAG_VRAM);
 	if (ret)
 		return NULL;
-	ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages, &bo->kmap);
-	if (ret) {
-		bochs_bo_unpin(bo);
+	base = drm_gem_vram_kmap(gbo, true, NULL);
+	if (IS_ERR(base)) {
+		drm_gem_vram_unpin(gbo);
 		return NULL;
 	}
-	return ttm_kmap_obj_virtual(&bo->kmap, &is_iomem);
+	return base;
 }
 
 void bochs_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
 {
-	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(obj);
 
-	ttm_bo_kunmap(&bo->kmap);
-	bochs_bo_unpin(bo);
+	drm_gem_vram_kunmap(gbo);
+	drm_gem_vram_unpin(gbo);
 }
 
 int bochs_gem_prime_mmap(struct drm_gem_object *obj,
 			 struct vm_area_struct *vma)
 {
-	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(obj);
 
-	bo->gem.vma_node.vm_node.start = bo->bo.vma_node.vm_node.start;
+	gbo->gem.vma_node.vm_node.start = gbo->bo.vma_node.vm_node.start;
 	return drm_gem_prime_mmap(obj, vma);
 }
-- 
2.21.0
