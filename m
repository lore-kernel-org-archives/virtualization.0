From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/4] drm/vram: Unexport internal functions of VRAM MM
Date: Mon,  9 Sep 2019 15:04:52 +0200
Message-ID: <20190909130453.6718-4-tzimmermann@suse.de>
References: <20190909130453.6718-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190909130453.6718-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: daniel@ffwll.ch, kraxel@redhat.com, airlied@linux.ie, corbet@lwn.net, z.liuxinliang@hisilicon.com, zourongrong@gmail.com, kong.kongxinwei@hisilicon.com, puck.chen@hisilicon.com, hdegoede@redhat.com, sam@ravnborg.org, yc_chen@aspeedtech.com
Cc: virtualization@lists.linux-foundation.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

The init, cleanup and mmap functions of VRAM MM are only used internally.
Remove them from the public interface.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 38 ++++-----------------------
 include/drm/drm_gem_vram_helper.h     |  7 -----
 2 files changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index ed1ffbec5d02..73e81e3a8724 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -844,19 +844,8 @@ static struct ttm_bo_driver bo_driver = {
  * struct drm_vram_mm
  */
 
-/**
- * drm_vram_mm_init() - Initialize an instance of VRAM MM.
- * @vmm:	the VRAM MM instance to initialize
- * @dev:	the DRM device
- * @vram_base:	the base address of the video memory
- * @vram_size:	the size of the video memory in bytes
- *
- * Returns:
- * 0 on success, or
- * a negative error code otherwise.
- */
-int drm_vram_mm_init(struct drm_vram_mm *vmm, struct drm_device *dev,
-		     uint64_t vram_base, size_t vram_size)
+static int drm_vram_mm_init(struct drm_vram_mm *vmm, struct drm_device *dev,
+			    uint64_t vram_base, size_t vram_size)
 {
 	int ret;
 
@@ -875,34 +864,17 @@ int drm_vram_mm_init(struct drm_vram_mm *vmm, struct drm_device *dev,
 
 	return 0;
 }
-EXPORT_SYMBOL(drm_vram_mm_init);
 
-/**
- * drm_vram_mm_cleanup() - Cleans up an initialized instance of VRAM MM.
- * @vmm:	the VRAM MM instance to clean up
- */
-void drm_vram_mm_cleanup(struct drm_vram_mm *vmm)
+static void drm_vram_mm_cleanup(struct drm_vram_mm *vmm)
 {
 	ttm_bo_device_release(&vmm->bdev);
 }
-EXPORT_SYMBOL(drm_vram_mm_cleanup);
 
-/**
- * drm_vram_mm_mmap() - Helper for implementing &struct file_operations.mmap()
- * @filp:	the mapping's file structure
- * @vma:	the mapping's memory area
- * @vmm:	the VRAM MM instance
- *
- * Returns:
- * 0 on success, or
- * a negative error code otherwise.
- */
-int drm_vram_mm_mmap(struct file *filp, struct vm_area_struct *vma,
-		     struct drm_vram_mm *vmm)
+static int drm_vram_mm_mmap(struct file *filp, struct vm_area_struct *vma,
+			    struct drm_vram_mm *vmm)
 {
 	return ttm_bo_mmap(filp, vma, &vmm->bdev);
 }
-EXPORT_SYMBOL(drm_vram_mm_mmap);
 
 /*
  * Helpers for integration with struct drm_device
diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 52e3f2aff490..3c204f17a0b8 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -169,13 +169,6 @@ static inline struct drm_vram_mm *drm_vram_mm_of_bdev(
 	return container_of(bdev, struct drm_vram_mm, bdev);
 }
 
-int drm_vram_mm_init(struct drm_vram_mm *vmm, struct drm_device *dev,
-		     uint64_t vram_base, size_t vram_size);
-void drm_vram_mm_cleanup(struct drm_vram_mm *vmm);
-
-int drm_vram_mm_mmap(struct file *filp, struct vm_area_struct *vma,
-		     struct drm_vram_mm *vmm);
-
 /*
  * Helpers for integration with struct drm_device
  */
-- 
2.23.0
