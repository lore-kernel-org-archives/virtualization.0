From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 3/4] drm/vram: Unexport internal functions of VRAM MM
Date: Wed, 11 Sep 2019 13:09:09 +0200
Message-ID: <20190911110910.30698-4-tzimmermann__42942.3216309928$1568200199$gmane$org@suse.de>
References: <20190911110910.30698-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190911110910.30698-1-tzimmermann@suse.de>
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

v2:
	* update for debugfs support

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 38 ++++-----------------------
 include/drm/drm_gem_vram_helper.h     |  6 -----
 2 files changed, 5 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index c87fed608ffa..1a05e2a97b93 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -889,19 +889,8 @@ int drm_vram_mm_debugfs_init(struct drm_minor *minor)
 }
 EXPORT_SYMBOL(drm_vram_mm_debugfs_init);
 
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
 
@@ -920,34 +909,17 @@ int drm_vram_mm_init(struct drm_vram_mm *vmm, struct drm_device *dev,
 
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
index fd978e0c9542..9aaef4f8c327 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -171,12 +171,6 @@ static inline struct drm_vram_mm *drm_vram_mm_of_bdev(
 }
 
 int drm_vram_mm_debugfs_init(struct drm_minor *minor);
-int drm_vram_mm_init(struct drm_vram_mm *vmm, struct drm_device *dev,
-		     uint64_t vram_base, size_t vram_size);
-void drm_vram_mm_cleanup(struct drm_vram_mm *vmm);
-
-int drm_vram_mm_mmap(struct file *filp, struct vm_area_struct *vma,
-		     struct drm_vram_mm *vmm);
 
 /*
  * Helpers for integration with struct drm_device
-- 
2.23.0
