From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 18/19] drm/hisilicon: Convert hibmc-drm driver to |struct
	drm_gem_vram_object|
Date: Mon,  6 May 2019 10:26:48 +0200
Message-ID: <20190506082649.942-19-tzimmermann__36217.3392948293$1557131461$gmane$org@suse.de>
References: <20190506082649.942-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190506082649.942-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: daniel@ffwll.ch, airlied@linux.ie, kraxel@redhat.com, christian.koenig@amd.com, ray.huang@amd.com, hdegoede@redhat.com, noralf@tronnes.org, sam@ravnborg.org, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The data structure |struct drm_gem_vram_object| and its helpers replace
|struct hibmc_bo|. It's the same implementation; except for the type
names.

v4:
	* select config option DRM_VRAM_HELPER

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hisilicon/hibmc/Kconfig       |   1 +
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    |  21 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |   5 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |  25 +--
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c |  30 +--
 drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c   | 210 +-----------------
 6 files changed, 44 insertions(+), 248 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/Kconfig b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
index c7129dc3bdfc..04d0bc685560 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/Kconfig
+++ b/drivers/gpu/drm/hisilicon/hibmc/Kconfig
@@ -3,6 +3,7 @@ config DRM_HISI_HIBMC
 	depends on DRM && PCI && MMU
 	select DRM_KMS_HELPER
 	select DRM_TTM
+	select DRM_VRAM_HELPER
 
 	help
 	  Choose this option if you have a Hisilicon Hibmc soc chipset.
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index 9316b724e7a2..db0dfa57844e 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -96,27 +96,32 @@ static void hibmc_plane_atomic_update(struct drm_plane *plane,
 	struct drm_plane_state	*state	= plane->state;
 	u32 reg;
 	int ret;
-	u64 gpu_addr = 0;
+	s64 gpu_addr = 0;
 	unsigned int line_l;
 	struct hibmc_drm_private *priv = plane->dev->dev_private;
 	struct hibmc_framebuffer *hibmc_fb;
-	struct hibmc_bo *bo;
+	struct drm_gem_vram_object *gbo;
 
 	if (!state->fb)
 		return;
 
 	hibmc_fb = to_hibmc_framebuffer(state->fb);
-	bo = gem_to_hibmc_bo(hibmc_fb->obj);
-	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
+	gbo = drm_gem_vram_of_gem(hibmc_fb->obj);
+	ret = drm_gem_vram_reserve(gbo, false);
 	if (ret) {
-		DRM_ERROR("failed to reserve ttm_bo: %d", ret);
+		DRM_ERROR("failed to reserve BO: %d", ret);
 		return;
 	}
 
-	ret = hibmc_bo_pin(bo, TTM_PL_FLAG_VRAM, &gpu_addr);
-	ttm_bo_unreserve(&bo->bo);
+	ret = drm_gem_vram_pin(gbo, DRM_GEM_VRAM_PL_FLAG_VRAM);
+	drm_gem_vram_unreserve(gbo);
 	if (ret) {
-		DRM_ERROR("failed to pin hibmc_bo: %d", ret);
+		DRM_ERROR("failed to pin bo: %d", ret);
+		return;
+	}
+	gpu_addr = drm_gem_vram_offset(gbo);
+	if (gpu_addr < 0) {
+		drm_gem_vram_unpin(gbo);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 8ed94fcd42a7..7027a1a05768 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -63,9 +63,10 @@ static struct drm_driver hibmc_driver = {
 	.desc			= "hibmc drm driver",
 	.major			= 1,
 	.minor			= 0,
-	.gem_free_object_unlocked = hibmc_gem_free_object,
+	.gem_free_object_unlocked =
+		drm_gem_vram_driver_gem_free_object_unlocked,
 	.dumb_create            = hibmc_dumb_create,
-	.dumb_map_offset        = hibmc_dumb_mmap_offset,
+	.dumb_map_offset        = drm_gem_vram_driver_dumb_mmap_offset,
 	.irq_handler		= hibmc_drm_interrupt,
 };
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 0a381c22de26..6b3430fc5148 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -23,6 +23,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_fb_helper.h>
 #include <drm/drm_gem.h>
+#include <drm/drm_gem_vram_helper.h>
 #include <drm/ttm/ttm_bo_driver.h>
 
 struct hibmc_framebuffer {
@@ -59,25 +60,6 @@ struct hibmc_drm_private {
 
 #define to_hibmc_framebuffer(x) container_of(x, struct hibmc_framebuffer, fb)
 
-struct hibmc_bo {
-	struct ttm_buffer_object bo;
-	struct ttm_placement placement;
-	struct ttm_bo_kmap_obj kmap;
-	struct drm_gem_object gem;
-	struct ttm_place placements[3];
-	int pin_count;
-};
-
-static inline struct hibmc_bo *hibmc_bo(struct ttm_buffer_object *bo)
-{
-	return container_of(bo, struct hibmc_bo, bo);
-}
-
-static inline struct hibmc_bo *gem_to_hibmc_bo(struct drm_gem_object *gem)
-{
-	return container_of(gem, struct hibmc_bo, gem);
-}
-
 void hibmc_set_power_mode(struct hibmc_drm_private *priv,
 			  unsigned int power_mode);
 void hibmc_set_current_gate(struct hibmc_drm_private *priv,
@@ -97,13 +79,8 @@ hibmc_framebuffer_init(struct drm_device *dev,
 
 int hibmc_mm_init(struct hibmc_drm_private *hibmc);
 void hibmc_mm_fini(struct hibmc_drm_private *hibmc);
-int hibmc_bo_pin(struct hibmc_bo *bo, u32 pl_flag, u64 *gpu_addr);
-int hibmc_bo_unpin(struct hibmc_bo *bo);
-void hibmc_gem_free_object(struct drm_gem_object *obj);
 int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
 		      struct drm_mode_create_dumb *args);
-int hibmc_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
-			   u32 handle, u64 *offset);
 int hibmc_mmap(struct file *filp, struct vm_area_struct *vma);
 
 extern const struct drm_mode_config_funcs hibmc_mode_funcs;
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
index 8026859aa07d..9d2025fa16f8 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_fbdev.c
@@ -66,7 +66,8 @@ static int hibmc_drm_fb_create(struct drm_fb_helper *helper,
 	int ret1;
 	size_t size;
 	unsigned int bytes_per_pixel;
-	struct hibmc_bo *bo = NULL;
+	struct drm_gem_vram_object *gbo = NULL;
+	void *base;
 
 	DRM_DEBUG_DRIVER("surface width(%d), height(%d) and bpp(%d)\n",
 			 sizes->surface_width, sizes->surface_height,
@@ -88,26 +89,27 @@ static int hibmc_drm_fb_create(struct drm_fb_helper *helper,
 		return -ENOMEM;
 	}
 
-	bo = gem_to_hibmc_bo(gobj);
+	gbo = drm_gem_vram_of_gem(gobj);
 
-	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
+	ret = drm_gem_vram_reserve(gbo, false);
 	if (ret) {
-		DRM_ERROR("failed to reserve ttm_bo: %d\n", ret);
+		DRM_ERROR("failed to reserve bo: %d\n", ret);
 		goto out_unref_gem;
 	}
 
-	ret = hibmc_bo_pin(bo, TTM_PL_FLAG_VRAM, NULL);
+	ret = drm_gem_vram_pin(gbo, DRM_GEM_VRAM_PL_FLAG_VRAM);
 	if (ret) {
 		DRM_ERROR("failed to pin fbcon: %d\n", ret);
 		goto out_unreserve_ttm_bo;
 	}
 
-	ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages, &bo->kmap);
-	if (ret) {
+	base = drm_gem_vram_kmap(gbo, true, NULL);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
 		DRM_ERROR("failed to kmap fbcon: %d\n", ret);
 		goto out_unpin_bo;
 	}
-	ttm_bo_unreserve(&bo->bo);
+	drm_gem_vram_unreserve(gbo);
 
 	info = drm_fb_helper_alloc_fbi(helper);
 	if (IS_ERR(info)) {
@@ -131,24 +133,24 @@ static int hibmc_drm_fb_create(struct drm_fb_helper *helper,
 
 	drm_fb_helper_fill_info(info, &priv->fbdev->helper, sizes);
 
-	info->screen_base = bo->kmap.virtual;
+	info->screen_base = base;
 	info->screen_size = size;
 
-	info->fix.smem_start = bo->bo.mem.bus.offset + bo->bo.mem.bus.base;
+	info->fix.smem_start = gbo->bo.mem.bus.offset + gbo->bo.mem.bus.base;
 	info->fix.smem_len = size;
 	return 0;
 
 out_release_fbi:
-	ret1 = ttm_bo_reserve(&bo->bo, true, false, NULL);
+	ret1 = drm_gem_vram_reserve(gbo, false);
 	if (ret1) {
 		DRM_ERROR("failed to rsv ttm_bo when release fbi: %d\n", ret1);
 		goto out_unref_gem;
 	}
-	ttm_bo_kunmap(&bo->kmap);
+	drm_gem_vram_kunmap(gbo);
 out_unpin_bo:
-	hibmc_bo_unpin(bo);
+	drm_gem_vram_unpin(gbo);
 out_unreserve_ttm_bo:
-	ttm_bo_unreserve(&bo->bo);
+	drm_gem_vram_unreserve(gbo);
 out_unref_gem:
 	drm_gem_object_put_unlocked(gobj);
 
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
index 6093c421daff..fbf8eb048ebc 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_ttm.c
@@ -27,19 +27,6 @@ hibmc_bdev(struct ttm_bo_device *bd)
 	return container_of(bd, struct hibmc_drm_private, bdev);
 }
 
-static void hibmc_bo_ttm_destroy(struct ttm_buffer_object *tbo)
-{
-	struct hibmc_bo *bo = container_of(tbo, struct hibmc_bo, bo);
-
-	drm_gem_object_release(&bo->gem);
-	kfree(bo);
-}
-
-static bool hibmc_ttm_bo_is_hibmc_bo(struct ttm_buffer_object *bo)
-{
-	return bo->destroy == &hibmc_bo_ttm_destroy;
-}
-
 static int
 hibmc_bo_init_mem_type(struct ttm_bo_device *bdev, u32 type,
 		       struct ttm_mem_type_manager *man)
@@ -65,52 +52,6 @@ hibmc_bo_init_mem_type(struct ttm_bo_device *bdev, u32 type,
 	return 0;
 }
 
-void hibmc_ttm_placement(struct hibmc_bo *bo, int domain)
-{
-	u32 count = 0;
-	u32 i;
-
-	bo->placement.placement = bo->placements;
-	bo->placement.busy_placement = bo->placements;
-	if (domain & TTM_PL_FLAG_VRAM)
-		bo->placements[count++].flags = TTM_PL_FLAG_WC |
-			TTM_PL_FLAG_UNCACHED | TTM_PL_FLAG_VRAM;
-	if (domain & TTM_PL_FLAG_SYSTEM)
-		bo->placements[count++].flags = TTM_PL_MASK_CACHING |
-			TTM_PL_FLAG_SYSTEM;
-	if (!count)
-		bo->placements[count++].flags = TTM_PL_MASK_CACHING |
-			TTM_PL_FLAG_SYSTEM;
-
-	bo->placement.num_placement = count;
-	bo->placement.num_busy_placement = count;
-	for (i = 0; i < count; i++) {
-		bo->placements[i].fpfn = 0;
-		bo->placements[i].lpfn = 0;
-	}
-}
-
-static void
-hibmc_bo_evict_flags(struct ttm_buffer_object *bo, struct ttm_placement *pl)
-{
-	struct hibmc_bo *hibmcbo = hibmc_bo(bo);
-
-	if (!hibmc_ttm_bo_is_hibmc_bo(bo))
-		return;
-
-	hibmc_ttm_placement(hibmcbo, TTM_PL_FLAG_SYSTEM);
-	*pl = hibmcbo->placement;
-}
-
-static int hibmc_bo_verify_access(struct ttm_buffer_object *bo,
-				  struct file *filp)
-{
-	struct hibmc_bo *hibmcbo = hibmc_bo(bo);
-
-	return drm_vma_node_verify_access(&hibmcbo->gem.vma_node,
-					  filp->private_data);
-}
-
 static int hibmc_ttm_io_mem_reserve(struct ttm_bo_device *bdev,
 				    struct ttm_mem_reg *mem)
 {
@@ -173,9 +114,9 @@ static struct ttm_tt *hibmc_ttm_tt_create(struct ttm_buffer_object *bo,
 struct ttm_bo_driver hibmc_bo_driver = {
 	.ttm_tt_create		= hibmc_ttm_tt_create,
 	.init_mem_type		= hibmc_bo_init_mem_type,
-	.evict_flags		= hibmc_bo_evict_flags,
+	.evict_flags		= drm_gem_vram_bo_driver_evict_flags,
 	.move			= NULL,
-	.verify_access		= hibmc_bo_verify_access,
+	.verify_access		= drm_gem_vram_bo_driver_verify_access,
 	.io_mem_reserve		= &hibmc_ttm_io_mem_reserve,
 	.io_mem_free		= NULL,
 };
@@ -215,108 +156,6 @@ void hibmc_mm_fini(struct hibmc_drm_private *hibmc)
 	hibmc->mm_inited = false;
 }
 
-static void hibmc_bo_unref(struct hibmc_bo **bo)
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
-int hibmc_bo_create(struct drm_device *dev, int size, int align,
-		    u32 flags, struct hibmc_bo **phibmcbo)
-{
-	struct hibmc_drm_private *hibmc = dev->dev_private;
-	struct hibmc_bo *hibmcbo;
-	size_t acc_size;
-	int ret;
-
-	hibmcbo = kzalloc(sizeof(*hibmcbo), GFP_KERNEL);
-	if (!hibmcbo) {
-		DRM_ERROR("failed to allocate hibmcbo\n");
-		return -ENOMEM;
-	}
-	ret = drm_gem_object_init(dev, &hibmcbo->gem, size);
-	if (ret) {
-		DRM_ERROR("failed to initialize drm gem object: %d\n", ret);
-		kfree(hibmcbo);
-		return ret;
-	}
-
-	hibmcbo->bo.bdev = &hibmc->bdev;
-
-	hibmc_ttm_placement(hibmcbo, TTM_PL_FLAG_VRAM | TTM_PL_FLAG_SYSTEM);
-
-	acc_size = ttm_bo_dma_acc_size(&hibmc->bdev, size,
-				       sizeof(struct hibmc_bo));
-
-	ret = ttm_bo_init(&hibmc->bdev, &hibmcbo->bo, size,
-			  ttm_bo_type_device, &hibmcbo->placement,
-			  align >> PAGE_SHIFT, false, acc_size,
-			  NULL, NULL, hibmc_bo_ttm_destroy);
-	if (ret) {
-		hibmc_bo_unref(&hibmcbo);
-		DRM_ERROR("failed to initialize ttm_bo: %d\n", ret);
-		return ret;
-	}
-
-	*phibmcbo = hibmcbo;
-	return 0;
-}
-
-int hibmc_bo_pin(struct hibmc_bo *bo, u32 pl_flag, u64 *gpu_addr)
-{
-	struct ttm_operation_ctx ctx = { false, false };
-	int i, ret;
-
-	if (bo->pin_count) {
-		bo->pin_count++;
-		if (gpu_addr)
-			*gpu_addr = bo->bo.offset;
-		return 0;
-	}
-
-	hibmc_ttm_placement(bo, pl_flag);
-	for (i = 0; i < bo->placement.num_placement; i++)
-		bo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
-	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
-	if (ret)
-		return ret;
-
-	bo->pin_count = 1;
-	if (gpu_addr)
-		*gpu_addr = bo->bo.offset;
-	return 0;
-}
-
-int hibmc_bo_unpin(struct hibmc_bo *bo)
-{
-	struct ttm_operation_ctx ctx = { false, false };
-	int i, ret;
-
-	if (!bo->pin_count) {
-		DRM_ERROR("unpin bad %p\n", bo);
-		return 0;
-	}
-	bo->pin_count--;
-	if (bo->pin_count)
-		return 0;
-
-	for (i = 0; i < bo->placement.num_placement ; i++)
-		bo->placements[i].flags &= ~TTM_PL_FLAG_NO_EVICT;
-	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
-	if (ret) {
-		DRM_ERROR("validate failed for unpin: %d\n", ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 int hibmc_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct drm_file *file_priv = filp->private_data;
@@ -328,24 +167,24 @@ int hibmc_mmap(struct file *filp, struct vm_area_struct *vma)
 int hibmc_gem_create(struct drm_device *dev, u32 size, bool iskernel,
 		     struct drm_gem_object **obj)
 {
-	struct hibmc_bo *hibmcbo;
+	struct hibmc_drm_private *hibmc = dev->dev_private;
+	struct drm_gem_vram_object *gbo;
 	int ret;
 
 	*obj = NULL;
 
-	size = PAGE_ALIGN(size);
-	if (size == 0) {
-		DRM_ERROR("error: zero size\n");
+	size = roundup(size, PAGE_SIZE);
+	if (size == 0)
 		return -EINVAL;
-	}
 
-	ret = hibmc_bo_create(dev, size, 0, 0, &hibmcbo);
-	if (ret) {
+	gbo = drm_gem_vram_create(dev, &hibmc->bdev, size, 0, false);
+	if (IS_ERR(gbo)) {
+		ret = PTR_ERR(gbo);
 		if (ret != -ERESTARTSYS)
 			DRM_ERROR("failed to allocate GEM object: %d\n", ret);
 		return ret;
 	}
-	*obj = &hibmcbo->gem;
+	*obj = &gbo->gem;
 	return 0;
 }
 
@@ -377,35 +216,6 @@ int hibmc_dumb_create(struct drm_file *file, struct drm_device *dev,
 	return 0;
 }
 
-void hibmc_gem_free_object(struct drm_gem_object *obj)
-{
-	struct hibmc_bo *hibmcbo = gem_to_hibmc_bo(obj);
-
-	hibmc_bo_unref(&hibmcbo);
-}
-
-static u64 hibmc_bo_mmap_offset(struct hibmc_bo *bo)
-{
-	return drm_vma_node_offset_addr(&bo->bo.vma_node);
-}
-
-int hibmc_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
-			   u32 handle, u64 *offset)
-{
-	struct drm_gem_object *obj;
-	struct hibmc_bo *bo;
-
-	obj = drm_gem_object_lookup(file, handle);
-	if (!obj)
-		return -ENOENT;
-
-	bo = gem_to_hibmc_bo(obj);
-	*offset = hibmc_bo_mmap_offset(bo);
-
-	drm_gem_object_put_unlocked(obj);
-	return 0;
-}
-
 static void hibmc_user_framebuffer_destroy(struct drm_framebuffer *fb)
 {
 	struct hibmc_framebuffer *hibmc_fb = to_hibmc_framebuffer(fb);
-- 
2.21.0
