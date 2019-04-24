From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 12/17] drm/mgag200: Convert mgag200 driver to VRAM MM
Date: Wed, 24 Apr 2019 13:48:37 +0200
Message-ID: <20190424114842.4723-13-tzimmermann__46286.1486406595$1556106671$gmane$org@suse.de>
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

The data structure |struct drm_vram_mm| and its helpers replace mgag200's
TTM-based memory manager. It's the same implementation; except for the type
names.

v2:
	* implement mgag200_mmap() with drm_vram_mm_mmap()

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/mgag200/Kconfig        |   1 +
 drivers/gpu/drm/mgag200/mgag200_drv.h  |  11 +--
 drivers/gpu/drm/mgag200/mgag200_main.c |   8 +-
 drivers/gpu/drm/mgag200/mgag200_ttm.c  | 123 ++-----------------------
 4 files changed, 17 insertions(+), 126 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/Kconfig b/drivers/gpu/drm/mgag200/Kconfig
index 52b7c3ee3064..8368fc5f4ca9 100644
--- a/drivers/gpu/drm/mgag200/Kconfig
+++ b/drivers/gpu/drm/mgag200/Kconfig
@@ -4,6 +4,7 @@ config DRM_MGAG200
 	select DRM_KMS_HELPER
 	select DRM_TTM
 	select DRM_GEM_VRAM_HELPER
+	select DRM_VRAM_MM_HELPER
 	help
 	 This is a KMS driver for the MGA G200 server chips, it
          does not support the original MGA G200 or any of the desktop
diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
index 86b33e23ab7f..0d498b1312e1 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.h
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
@@ -17,15 +17,12 @@
 
 #include <drm/drm_encoder.h>
 #include <drm/drm_fb_helper.h>
-#include <drm/ttm/ttm_bo_api.h>
-#include <drm/ttm/ttm_bo_driver.h>
-#include <drm/ttm/ttm_placement.h>
-#include <drm/ttm/ttm_memory.h>
-#include <drm/ttm/ttm_module.h>
 
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_vram_helper.h>
 
+#include <drm/drm_vram_mm_helper.h>
+
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
@@ -212,9 +209,7 @@ struct mga_device {
 
 	int fb_mtrr;
 
-	struct {
-		struct ttm_bo_device bdev;
-	} ttm;
+	struct drm_vram_mm vmm;
 
 	/* SE model number stored in reg 0x1e24 */
 	u32 unique_rev_id;
diff --git a/drivers/gpu/drm/mgag200/mgag200_main.c b/drivers/gpu/drm/mgag200/mgag200_main.c
index 59a4028a5c6c..571860d2df0f 100644
--- a/drivers/gpu/drm/mgag200/mgag200_main.c
+++ b/drivers/gpu/drm/mgag200/mgag200_main.c
@@ -230,10 +230,10 @@ int mgag200_driver_load(struct drm_device *dev, unsigned long flags)
 	}
 
 	/* Make small buffers to store a hardware cursor (double buffered icon updates) */
-	mdev->cursor.pixels_1 = drm_gem_vram_create(dev, &mdev->ttm.bdev,
+	mdev->cursor.pixels_1 = drm_gem_vram_create(dev, &mdev->vmm.bdev,
 						    roundup(48*64, PAGE_SIZE),
 						    0, 0);
-	mdev->cursor.pixels_2 = drm_gem_vram_create(dev, &mdev->ttm.bdev,
+	mdev->cursor.pixels_2 = drm_gem_vram_create(dev, &mdev->vmm.bdev,
 						    roundup(48*64, PAGE_SIZE),
 						    0, 0);
 	if (IS_ERR(mdev->cursor.pixels_2) || IS_ERR(mdev->cursor.pixels_1)) {
@@ -284,7 +284,7 @@ int mgag200_gem_create(struct drm_device *dev,
 	if (size == 0)
 		return -EINVAL;
 
-	gbo = drm_gem_vram_create(dev, &mdev->ttm.bdev, size, 0, false);
+	gbo = drm_gem_vram_create(dev, &mdev->vmm.bdev, size, 0, false);
 	if (IS_ERR(gbo)) {
 		ret = PTR_ERR(gbo);
 		if (ret != -ERESTARTSYS)
@@ -301,6 +301,6 @@ int mgag200_dumb_create(struct drm_file *file,
 {
 	struct mga_device *mdev = dev->dev_private;
 
-	return drm_gem_vram_fill_create_dumb(file, dev, &mdev->ttm.bdev, 0,
+	return drm_gem_vram_fill_create_dumb(file, dev, &mdev->vmm.bdev, 0,
 					    false, args);
 }
diff --git a/drivers/gpu/drm/mgag200/mgag200_ttm.c b/drivers/gpu/drm/mgag200/mgag200_ttm.c
index 2c0249086bf9..52c649382fa9 100644
--- a/drivers/gpu/drm/mgag200/mgag200_ttm.c
+++ b/drivers/gpu/drm/mgag200/mgag200_ttm.c
@@ -26,130 +26,25 @@
  * Authors: Dave Airlie <airlied@redhat.com>
  */
 #include <drm/drmP.h>
-#include <drm/ttm/ttm_page_alloc.h>
 
 #include "mgag200_drv.h"
 
-static inline struct mga_device *
-mgag200_bdev(struct ttm_bo_device *bd)
-{
-	return container_of(bd, struct mga_device, ttm.bdev);
-}
-
-static int
-mgag200_bo_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
-		     struct ttm_mem_type_manager *man)
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
-static int mgag200_ttm_io_mem_reserve(struct ttm_bo_device *bdev,
-				  struct ttm_mem_reg *mem)
-{
-	struct ttm_mem_type_manager *man = &bdev->man[mem->mem_type];
-	struct mga_device *mdev = mgag200_bdev(bdev);
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
-		mem->bus.base = pci_resource_start(mdev->dev->pdev, 0);
-		mem->bus.is_iomem = true;
-		break;
-	default:
-		return -EINVAL;
-		break;
-	}
-	return 0;
-}
-
-static void mgag200_ttm_io_mem_free(struct ttm_bo_device *bdev, struct ttm_mem_reg *mem)
-{
-}
-
-static void mgag200_ttm_backend_destroy(struct ttm_tt *tt)
-{
-	ttm_tt_fini(tt);
-	kfree(tt);
-}
-
-static struct ttm_backend_func mgag200_tt_backend_func = {
-	.destroy = &mgag200_ttm_backend_destroy,
-};
-
-
-static struct ttm_tt *mgag200_ttm_tt_create(struct ttm_buffer_object *bo,
-					    uint32_t page_flags)
-{
-	struct ttm_tt *tt;
-
-	tt = kzalloc(sizeof(struct ttm_tt), GFP_KERNEL);
-	if (tt == NULL)
-		return NULL;
-	tt->func = &mgag200_tt_backend_func;
-	if (ttm_tt_init(tt, bo, page_flags)) {
-		kfree(tt);
-		return NULL;
-	}
-	return tt;
-}
-
-struct ttm_bo_driver mgag200_bo_driver = {
-	.ttm_tt_create = mgag200_ttm_tt_create,
-	.init_mem_type = mgag200_bo_init_mem_type,
-	.eviction_valuable = ttm_bo_eviction_valuable,
+static const struct drm_vram_mm_funcs mgag200_vram_mm_funcs = {
 	.evict_flags = drm_gem_vram_bo_driver_evict_flags,
-	.move = NULL,
-	.verify_access = drm_gem_vram_bo_driver_verify_access,
-	.io_mem_reserve = &mgag200_ttm_io_mem_reserve,
-	.io_mem_free = &mgag200_ttm_io_mem_free,
+	.verify_access = drm_gem_vram_bo_driver_verify_access
 };
 
 int mgag200_mm_init(struct mga_device *mdev)
 {
 	int ret;
 	struct drm_device *dev = mdev->dev;
-	struct ttm_bo_device *bdev = &mdev->ttm.bdev;
-
-	ret = ttm_bo_device_init(&mdev->ttm.bdev,
-				 &mgag200_bo_driver,
-				 dev->anon_inode->i_mapping,
-				 true);
-	if (ret) {
-		DRM_ERROR("Error initialising bo driver; %d\n", ret);
-		return ret;
-	}
 
-	ret = ttm_bo_init_mm(bdev, TTM_PL_VRAM, mdev->mc.vram_size >> PAGE_SHIFT);
+	ret = drm_vram_mm_init(&mdev->vmm, dev,
+			       pci_resource_start(dev->pdev, 0),
+			       mdev->mc.vram_size,
+			       &mgag200_vram_mm_funcs);
 	if (ret) {
-		DRM_ERROR("Failed ttm VRAM init: %d\n", ret);
+		DRM_ERROR("Error initializing VRAM MM; %d\n", ret);
 		return ret;
 	}
 
@@ -166,7 +61,7 @@ void mgag200_mm_fini(struct mga_device *mdev)
 {
 	struct drm_device *dev = mdev->dev;
 
-	ttm_bo_device_release(&mdev->ttm.bdev);
+	drm_vram_mm_cleanup(&mdev->vmm);
 
 	arch_io_free_memtype_wc(pci_resource_start(dev->pdev, 0),
 				pci_resource_len(dev->pdev, 0));
@@ -179,5 +74,5 @@ int mgag200_mmap(struct file *filp, struct vm_area_struct *vma)
 	struct drm_file *file_priv = filp->private_data;
 	struct mga_device *mdev = file_priv->minor->dev->dev_private;
 
-	return ttm_bo_mmap(filp, vma, &mdev->ttm.bdev);
+	return drm_vram_mm_mmap(filp, vma, &mdev->vmm);
 }
-- 
2.21.0
