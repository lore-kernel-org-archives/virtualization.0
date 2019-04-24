From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 10/17] drm/bochs: Convert bochs driver to VRAM MM
Date: Wed, 24 Apr 2019 13:48:35 +0200
Message-ID: <20190424114842.4723-11-tzimmermann__18779.9231194489$1556106634$gmane$org@suse.de>
References: <20190424114842.4723-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190424114842.4723-1-tzimmermann@suse.de>
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

The data structure |struct drm_vram_mm| and its helpers replace bochs'
TTM-based memory manager. It's the same implementation; except for the
type names.

v2:
	* implement bochs_mmap() with drm_vram_mm_mmap()

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/bochs/Kconfig    |   1 +
 drivers/gpu/drm/bochs/bochs.h    |  11 +--
 drivers/gpu/drm/bochs/bochs_mm.c | 129 +++----------------------------
 3 files changed, 16 insertions(+), 125 deletions(-)

diff --git a/drivers/gpu/drm/bochs/Kconfig b/drivers/gpu/drm/bochs/Kconfig
index c04f8041a2b9..7ad1cfe47b38 100644
--- a/drivers/gpu/drm/bochs/Kconfig
+++ b/drivers/gpu/drm/bochs/Kconfig
@@ -4,6 +4,7 @@ config DRM_BOCHS
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	select DRM_GEM_VRAM_HELPER
+	select DRM_VRAM_MM_HELPER
 	help
 	  Choose this option for qemu.
 	  If M is selected the module will be called bochs-drm.
diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 4ccf82e1ca68..ff75d9238c47 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -12,8 +12,7 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_vram_helper.h>
 
-#include <drm/ttm/ttm_bo_driver.h>
-#include <drm/ttm/ttm_page_alloc.h>
+#include <drm/drm_vram_mm_helper.h>
 
 /* ---------------------------------------------------------------------- */
 
@@ -75,11 +74,9 @@ struct bochs_device {
 	struct drm_simple_display_pipe pipe;
 	struct drm_connector connector;
 
-	/* ttm */
-	struct {
-		struct ttm_bo_device bdev;
-		bool initialized;
-	} ttm;
+	/* vram */
+	struct drm_vram_mm vmm;
+	bool vmm_initialized;
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index 5837adc6ae17..27fe4fdc808b 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -9,138 +9,31 @@
 
 /* ---------------------------------------------------------------------- */
 
-static inline struct bochs_device *bochs_bdev(struct ttm_bo_device *bd)
-{
-	return container_of(bd, struct bochs_device, ttm.bdev);
-}
-
-static int bochs_bo_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
-				  struct ttm_mem_type_manager *man)
-{
-	switch (type) {
-	case TTM_PL_SYSTEM:
-		man->flags = TTM_MEMTYPE_FLAG_MAPPABLE;
-		man->available_caching = TTM_PL_MASK_CACHING;
-		man->default_caching = TTM_PL_FLAG_CACHED;
-		break;
-	case TTM_PL_VRAM:
-		man->func = &ttm_bo_manager_func;
-		man->flags = TTM_MEMTYPE_FLAG_FIXED |
-			TTM_MEMTYPE_FLAG_MAPPABLE;
-		man->available_caching = TTM_PL_FLAG_UNCACHED |
-			TTM_PL_FLAG_WC;
-		man->default_caching = TTM_PL_FLAG_WC;
-		break;
-	default:
-		DRM_ERROR("Unsupported memory type %u\n", (unsigned)type);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-static int bochs_ttm_io_mem_reserve(struct ttm_bo_device *bdev,
-				    struct ttm_mem_reg *mem)
-{
-	struct ttm_mem_type_manager *man = &bdev->man[mem->mem_type];
-	struct bochs_device *bochs = bochs_bdev(bdev);
-
-	mem->bus.addr = NULL;
-	mem->bus.offset = 0;
-	mem->bus.size = mem->num_pages << PAGE_SHIFT;
-	mem->bus.base = 0;
-	mem->bus.is_iomem = false;
-	if (!(man->flags & TTM_MEMTYPE_FLAG_MAPPABLE))
-		return -EINVAL;
-	switch (mem->mem_type) {
-	case TTM_PL_SYSTEM:
-		/* system memory */
-		return 0;
-	case TTM_PL_VRAM:
-		mem->bus.offset = mem->start << PAGE_SHIFT;
-		mem->bus.base = bochs->fb_base;
-		mem->bus.is_iomem = true;
-		break;
-	default:
-		return -EINVAL;
-		break;
-	}
-	return 0;
-}
-
-static void bochs_ttm_io_mem_free(struct ttm_bo_device *bdev,
-				  struct ttm_mem_reg *mem)
-{
-}
-
-static void bochs_ttm_backend_destroy(struct ttm_tt *tt)
-{
-	ttm_tt_fini(tt);
-	kfree(tt);
-}
-
-static struct ttm_backend_func bochs_tt_backend_func = {
-	.destroy = &bochs_ttm_backend_destroy,
-};
-
-static struct ttm_tt *bochs_ttm_tt_create(struct ttm_buffer_object *bo,
-					  uint32_t page_flags)
-{
-	struct ttm_tt *tt;
-
-	tt = kzalloc(sizeof(struct ttm_tt), GFP_KERNEL);
-	if (tt == NULL)
-		return NULL;
-	tt->func = &bochs_tt_backend_func;
-	if (ttm_tt_init(tt, bo, page_flags)) {
-		kfree(tt);
-		return NULL;
-	}
-	return tt;
-}
-
-static struct ttm_bo_driver bochs_bo_driver = {
-	.ttm_tt_create = bochs_ttm_tt_create,
-	.init_mem_type = bochs_bo_init_mem_type,
-	.eviction_valuable = ttm_bo_eviction_valuable,
+static const struct drm_vram_mm_funcs bochs_vram_mm_funcs = {
 	.evict_flags = drm_gem_vram_bo_driver_evict_flags,
-	.move = NULL,
-	.verify_access = drm_gem_vram_bo_driver_verify_access,
-	.io_mem_reserve = &bochs_ttm_io_mem_reserve,
-	.io_mem_free = &bochs_ttm_io_mem_free,
+	.verify_access = drm_gem_vram_bo_driver_verify_access
 };
 
 int bochs_mm_init(struct bochs_device *bochs)
 {
-	struct ttm_bo_device *bdev = &bochs->ttm.bdev;
-	int ret;
-
-	ret = ttm_bo_device_init(&bochs->ttm.bdev,
-				 &bochs_bo_driver,
-				 bochs->dev->anon_inode->i_mapping,
-				 true);
-	if (ret) {
-		DRM_ERROR("Error initialising bo driver; %d\n", ret);
-		return ret;
-	}
-
-	ret = ttm_bo_init_mm(bdev, TTM_PL_VRAM,
-			     bochs->fb_size >> PAGE_SHIFT);
+	int ret = drm_vram_mm_init(&bochs->vmm, bochs->dev, bochs->fb_base,
+				   bochs->fb_size, &bochs_vram_mm_funcs);
 	if (ret) {
-		DRM_ERROR("Failed ttm VRAM init: %d\n", ret);
+		DRM_ERROR("Error initializing VRAM MM; %d\n", ret);
 		return ret;
 	}
 
-	bochs->ttm.initialized = true;
+	bochs->vmm_initialized = true;
 	return 0;
 }
 
 void bochs_mm_fini(struct bochs_device *bochs)
 {
-	if (!bochs->ttm.initialized)
+	if (!bochs->vmm_initialized)
 		return;
 
-	ttm_bo_device_release(&bochs->ttm.bdev);
-	bochs->ttm.initialized = false;
+	drm_vram_mm_cleanup(&bochs->vmm);
+	bochs->vmm_initialized = false;
 }
 
 int bochs_mmap(struct file *filp, struct vm_area_struct *vma)
@@ -148,7 +41,7 @@ int bochs_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct drm_file *file_priv = filp->private_data;
 	struct bochs_device *bochs = file_priv->minor->dev->dev_private;
 
-	return ttm_bo_mmap(filp, vma, &bochs->ttm.bdev);
+	return drm_vram_mm_mmap(filp, vma, &bochs->vmm);
 }
 
 /* ---------------------------------------------------------------------- */
@@ -158,7 +51,7 @@ int bochs_dumb_create(struct drm_file *file, struct drm_device *dev,
 {
 	struct bochs_device *bochs = dev->dev_private;
 
-	return drm_gem_vram_fill_create_dumb(file, dev, &bochs->ttm.bdev, 0,
+	return drm_gem_vram_fill_create_dumb(file, dev, &bochs->vmm.bdev, 0,
 					     false, args);
 }
 
-- 
2.21.0
