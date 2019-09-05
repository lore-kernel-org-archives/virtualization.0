From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 1/8] drm/ttm: turn ttm_bo_device.vma_manager into a pointer
Date: Thu,  5 Sep 2019 09:05:02 +0200
Message-ID: <20190905070509.22407-2-kraxel__42550.8625734196$1576332913$gmane$org@redhat.com>
References: <20190905070509.22407-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190905070509.22407-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Thomas Hellstrom <thellstrom@vmware.com>, David Airlie <airlied@linux.ie>, "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" <nouveau@lists.freedesktop.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Huang Rui <ray.huang@amd.com>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

Rename the embedded struct vma_offset_manager, new name is _vma_manager.
ttm_bo_device.vma_manager changed to a pointer.

The ttm_bo_device_init() function gets an additional vma_manager
argument which allows to initialize ttm with a different vma manager.
When passing NULL the embedded _vma_manager is used.

All callers are updated to pass NULL, so the behavior doesn't change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/ttm/ttm_bo_driver.h         |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  1 +
 drivers/gpu/drm/drm_vram_mm_helper.c    |  1 +
 drivers/gpu/drm/nouveau/nouveau_ttm.c   |  1 +
 drivers/gpu/drm/qxl/qxl_ttm.c           |  1 +
 drivers/gpu/drm/radeon/radeon_ttm.c     |  1 +
 drivers/gpu/drm/ttm/ttm_bo.c            | 13 +++++++++----
 drivers/gpu/drm/ttm/ttm_bo_vm.c         |  6 +++---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c     |  1 +
 9 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index e88e00c6cbf2..e365434f92b3 100644
--- a/include/drm/ttm/ttm_bo_driver.h
+++ b/include/drm/ttm/ttm_bo_driver.h
@@ -441,7 +441,8 @@ extern struct ttm_bo_global {
  *
  * @driver: Pointer to a struct ttm_bo_driver struct setup by the driver.
  * @man: An array of mem_type_managers.
- * @vma_manager: Address space manager
+ * @vma_manager: Address space manager (pointer)
+ * @_vma_manager: Address space manager (enbedded)
  * lru_lock: Spinlock that protects the buffer+device lru lists and
  * ddestroy lists.
  * @dev_mapping: A pointer to the struct address_space representing the
@@ -464,7 +465,8 @@ struct ttm_bo_device {
 	/*
 	 * Protected by internal locks.
 	 */
-	struct drm_vma_offset_manager vma_manager;
+	struct drm_vma_offset_manager *vma_manager;
+	struct drm_vma_offset_manager _vma_manager;
 
 	/*
 	 * Protected by the global:lru lock.
@@ -585,6 +587,7 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev);
  * @glob: A pointer to an initialized struct ttm_bo_global.
  * @driver: A pointer to a struct ttm_bo_driver set up by the caller.
  * @mapping: The address space to use for this bo.
+ * @vma_manager: A pointer to a vma manager or NULL.
  * @file_page_offset: Offset into the device address space that is available
  * for buffer data. This ensures compatibility with other users of the
  * address space.
@@ -596,6 +599,7 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev);
 int ttm_bo_device_init(struct ttm_bo_device *bdev,
 		       struct ttm_bo_driver *driver,
 		       struct address_space *mapping,
+		       struct drm_vma_offset_manager *vma_manager,
 		       bool need_dma32);
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index fb09314bcfd4..34ee5d725faf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1728,6 +1728,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	r = ttm_bo_device_init(&adev->mman.bdev,
 			       &amdgpu_bo_driver,
 			       adev->ddev->anon_inode->i_mapping,
+			       NULL,
 			       adev->need_dma32);
 	if (r) {
 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
diff --git a/drivers/gpu/drm/drm_vram_mm_helper.c b/drivers/gpu/drm/drm_vram_mm_helper.c
index c911781d6728..56fd1519eb35 100644
--- a/drivers/gpu/drm/drm_vram_mm_helper.c
+++ b/drivers/gpu/drm/drm_vram_mm_helper.c
@@ -172,6 +172,7 @@ int drm_vram_mm_init(struct drm_vram_mm *vmm, struct drm_device *dev,
 
 	ret = ttm_bo_device_init(&vmm->bdev, &bo_driver,
 				 dev->anon_inode->i_mapping,
+				 NULL,
 				 true);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
index f0daf958e03a..e67eb10843d1 100644
--- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
@@ -236,6 +236,7 @@ nouveau_ttm_init(struct nouveau_drm *drm)
 	ret = ttm_bo_device_init(&drm->ttm.bdev,
 				  &nouveau_bo_driver,
 				  dev->anon_inode->i_mapping,
+				 NULL,
 				  drm->client.mmu.dmabits <= 32 ? true : false);
 	if (ret) {
 		NV_ERROR(drm, "error initialising bo driver, %d\n", ret);
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 9b24514c75aa..69da0eea6e4c 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -325,6 +325,7 @@ int qxl_ttm_init(struct qxl_device *qdev)
 	r = ttm_bo_device_init(&qdev->mman.bdev,
 			       &qxl_bo_driver,
 			       qdev->ddev.anon_inode->i_mapping,
+			       NULL,
 			       false);
 	if (r) {
 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 35ac75a11d38..e2c12e59704d 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -794,6 +794,7 @@ int radeon_ttm_init(struct radeon_device *rdev)
 	r = ttm_bo_device_init(&rdev->mman.bdev,
 			       &radeon_bo_driver,
 			       rdev->ddev->anon_inode->i_mapping,
+			       NULL,
 			       rdev->need_dma32);
 	if (r) {
 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 58d1f2b28132..8dc26babc5cb 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -672,7 +672,7 @@ static void ttm_bo_release(struct kref *kref)
 	struct ttm_bo_device *bdev = bo->bdev;
 	struct ttm_mem_type_manager *man = &bdev->man[bo->mem.mem_type];
 
-	drm_vma_offset_remove(&bdev->vma_manager, &bo->base.vma_node);
+	drm_vma_offset_remove(bdev->vma_manager, &bo->base.vma_node);
 	ttm_mem_io_lock(man, false);
 	ttm_mem_io_free_vm(bo);
 	ttm_mem_io_unlock(man);
@@ -1353,7 +1353,7 @@ int ttm_bo_init_reserved(struct ttm_bo_device *bdev,
 	 */
 	if (bo->type == ttm_bo_type_device ||
 	    bo->type == ttm_bo_type_sg)
-		ret = drm_vma_offset_add(&bdev->vma_manager, &bo->base.vma_node,
+		ret = drm_vma_offset_add(bdev->vma_manager, &bo->base.vma_node,
 					 bo->mem.num_pages);
 
 	/* passed reservation objects should already be locked,
@@ -1704,7 +1704,7 @@ int ttm_bo_device_release(struct ttm_bo_device *bdev)
 			pr_debug("Swap list %d was clean\n", i);
 	spin_unlock(&glob->lru_lock);
 
-	drm_vma_offset_manager_destroy(&bdev->vma_manager);
+	drm_vma_offset_manager_destroy(&bdev->_vma_manager);
 
 	if (!ret)
 		ttm_bo_global_release();
@@ -1716,11 +1716,15 @@ EXPORT_SYMBOL(ttm_bo_device_release);
 int ttm_bo_device_init(struct ttm_bo_device *bdev,
 		       struct ttm_bo_driver *driver,
 		       struct address_space *mapping,
+		       struct drm_vma_offset_manager *vma_manager,
 		       bool need_dma32)
 {
 	struct ttm_bo_global *glob = &ttm_bo_glob;
 	int ret;
 
+	if (!vma_manager)
+		vma_manager = &bdev->_vma_manager;
+
 	ret = ttm_bo_global_init();
 	if (ret)
 		return ret;
@@ -1737,7 +1741,8 @@ int ttm_bo_device_init(struct ttm_bo_device *bdev,
 	if (unlikely(ret != 0))
 		goto out_no_sys;
 
-	drm_vma_offset_manager_init(&bdev->vma_manager,
+	bdev->vma_manager = vma_manager;
+	drm_vma_offset_manager_init(&bdev->_vma_manager,
 				    DRM_FILE_PAGE_OFFSET_START,
 				    DRM_FILE_PAGE_OFFSET_SIZE);
 	INIT_DELAYED_WORK(&bdev->wq, ttm_bo_delayed_workqueue);
diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 76eedb963693..4aa007edffb0 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -409,16 +409,16 @@ static struct ttm_buffer_object *ttm_bo_vm_lookup(struct ttm_bo_device *bdev,
 	struct drm_vma_offset_node *node;
 	struct ttm_buffer_object *bo = NULL;
 
-	drm_vma_offset_lock_lookup(&bdev->vma_manager);
+	drm_vma_offset_lock_lookup(bdev->vma_manager);
 
-	node = drm_vma_offset_lookup_locked(&bdev->vma_manager, offset, pages);
+	node = drm_vma_offset_lookup_locked(bdev->vma_manager, offset, pages);
 	if (likely(node)) {
 		bo = container_of(node, struct ttm_buffer_object,
 				  base.vma_node);
 		bo = ttm_bo_get_unless_zero(bo);
 	}
 
-	drm_vma_offset_unlock_lookup(&bdev->vma_manager);
+	drm_vma_offset_unlock_lookup(bdev->vma_manager);
 
 	if (!bo)
 		pr_err("Could not find buffer object to map\n");
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index cd0d49d8a8da..20bc91214e75 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -830,6 +830,7 @@ static int vmw_driver_load(struct drm_device *dev, unsigned long chipset)
 	ret = ttm_bo_device_init(&dev_priv->bdev,
 				 &vmw_bo_driver,
 				 dev->anon_inode->i_mapping,
+				 NULL,
 				 false);
 	if (unlikely(ret != 0)) {
 		DRM_ERROR("Failed initializing TTM buffer object driver.\n");
-- 
2.18.1
