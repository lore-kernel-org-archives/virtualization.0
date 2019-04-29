From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 07/19] drm: Integrate VRAM MM into struct drm_device
Date: Mon, 29 Apr 2019 16:43:29 +0200
Message-ID: <20190429144341.12615-8-tzimmermann__20692.3741194018$1556549309$gmane$org@suse.de>
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

There's no a pointer to struct drm_vram_mm stored in struct drm_device.
DRM drivers that use VRAM MM should use this field to refer to their
instance of the data structure. Appropriate helpers are now provided as
well.

Adding struct drm_vram_mm to struct drm_device further avoids wrappers
and boilerplate code in drivers. This patch implements default functions
for callbacks in struct drm_driver and struct file_operations that use
the struct drm_vram_mm stored in struct drm_device. Drivers that need to
provide their own implementations can still do so.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 28 +++++++++++
 drivers/gpu/drm/drm_vram_mm_helper.c  | 68 +++++++++++++++++++++++++++
 include/drm/drm_device.h              |  4 ++
 include/drm/drm_gem_vram_helper.h     | 18 ++++++-
 include/drm/drm_vram_mm_helper.h      | 32 +++++++++++++
 5 files changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 37979fb3062b..001ed8e7bfae 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #include <drm/drm_gem_vram_helper.h>
+#include <drm/drm_device.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_vram_mm_helper.h>
 #include <drm/ttm/ttm_page_alloc.h>
@@ -551,6 +552,33 @@ void drm_gem_vram_driver_gem_free_object_unlocked(struct drm_gem_object *gem)
 }
 EXPORT_SYMBOL(drm_gem_vram_driver_gem_free_object_unlocked);
 
+/**
+ * drm_gem_vram_driver_create_dumb() - \
+	Implements &struct drm_driver.dumb_create
+ * @file:		the DRM file
+ * @dev:		the DRM device
+ * @args:		the arguments as provided to \
+				&struct drm_driver.dumb_create
+ *
+ * This function requires the driver to use @drm_device.vram_mm for its
+ * instance of VRAM MM.
+ *
+ * Returns:
+ * 0 on success, or
+ * a negative error code otherwise.
+ */
+int drm_gem_vram_driver_dumb_create(struct drm_file *file,
+				    struct drm_device *dev,
+				    struct drm_mode_create_dumb *args)
+{
+	if (WARN_ONCE(!dev->vram_mm, "VRAM MM not initialized"))
+		return -EINVAL;
+
+	return drm_gem_vram_fill_create_dumb(file, dev, &dev->vram_mm->bdev, 0,
+					     false, args);
+}
+EXPORT_SYMBOL(drm_gem_vram_driver_dumb_create);
+
 /**
  * drm_gem_vram_driver_dumb_mmap_offset() - \
 	Implements &struct drm_driver.dumb_mmap_offset
diff --git a/drivers/gpu/drm/drm_vram_mm_helper.c b/drivers/gpu/drm/drm_vram_mm_helper.c
index d19f46d7a4e7..62ce8d2cd4c1 100644
--- a/drivers/gpu/drm/drm_vram_mm_helper.c
+++ b/drivers/gpu/drm/drm_vram_mm_helper.c
@@ -208,3 +208,71 @@ int drm_vram_mm_mmap(struct file *filp, struct vm_area_struct *vma,
 	return ttm_bo_mmap(filp, vma, &vmm->bdev);
 }
 EXPORT_SYMBOL(drm_vram_mm_mmap);
+
+/*
+ * Helpers for integration with struct drm_device
+ */
+
+struct drm_vram_mm* drm_vram_helper_alloc_mm(
+	struct drm_device *dev, u64 vram_base, unsigned long vram_size,
+	const struct drm_vram_mm_funcs* funcs)
+{
+	int ret;
+
+	if (WARN_ON(dev->vram_mm))
+		return dev->vram_mm;
+
+	dev->vram_mm = kzalloc(sizeof(*dev->vram_mm), GFP_KERNEL);
+	if (!dev->vram_mm)
+		return ERR_PTR(-ENOMEM);
+
+	ret = drm_vram_mm_init(dev->vram_mm, dev, vram_base, vram_size, funcs);
+	if (ret)
+		goto err_kfree;
+
+	return dev->vram_mm;
+
+err_kfree:
+	kfree(dev->vram_mm);
+	dev->vram_mm = NULL;
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL(drm_vram_helper_alloc_mm);
+
+void drm_vram_helper_release_mm(struct drm_device *dev)
+{
+	if (!dev->vram_mm)
+		return;
+
+	drm_vram_mm_cleanup(dev->vram_mm);
+	kfree(dev->vram_mm);
+	dev->vram_mm = NULL;
+}
+EXPORT_SYMBOL(drm_vram_helper_release_mm);
+
+/*
+ * Helpers for &struct file_operations
+ */
+
+/**
+ * drm_vram_mm_file_operations_mmap() - \
+	Implements &struct file_operations.mmap()
+ * @filp:	the mapping's file structure
+ * @vma:	the mapping's memory area
+ *
+ * Returns:
+ * 0 on success, or
+ * a negative error code otherwise.
+ */
+int drm_vram_mm_file_operations_mmap(
+	struct file *filp, struct vm_area_struct *vma)
+{
+	struct drm_file *file_priv = filp->private_data;
+	struct drm_device *dev = file_priv->minor->dev;
+
+	if (WARN_ONCE(!dev->vram_mm, "VRAM MM not initialized"))
+		return -EINVAL;
+
+	return drm_vram_mm_mmap(filp, vma, dev->vram_mm);
+}
+EXPORT_SYMBOL(drm_vram_mm_file_operations_mmap);
diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
index 7f9ef709b2b6..1acfc3bbd3fb 100644
--- a/include/drm/drm_device.h
+++ b/include/drm/drm_device.h
@@ -17,6 +17,7 @@ struct drm_vblank_crtc;
 struct drm_sg_mem;
 struct drm_local_map;
 struct drm_vma_offset_manager;
+struct drm_vram_mm;
 struct drm_fb_helper;
 
 struct inode;
@@ -286,6 +287,9 @@ struct drm_device {
 	/** @vma_offset_manager: GEM information */
 	struct drm_vma_offset_manager *vma_offset_manager;
 
+	/** @vram_mm: VRAM MM memory manager */
+	struct drm_vram_mm *vram_mm;
+
 	/**
 	 * @switch_power_state:
 	 *
diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 3f250f59eaa5..0e3739943a16 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -11,6 +11,7 @@
 struct drm_mode_create_dumb;
 struct drm_vram_mm_funcs;
 struct filp;
+struct vm_area_struct;
 
 #define DRM_GEM_VRAM_PL_FLAG_VRAM	TTM_PL_FLAG_VRAM
 #define DRM_GEM_VRAM_PL_FLAG_SYSTEM	TTM_PL_FLAG_SYSTEM
@@ -115,9 +116,24 @@ extern const struct drm_vram_mm_funcs drm_gem_vram_mm_funcs;
  */
 
 void drm_gem_vram_driver_gem_free_object_unlocked(struct drm_gem_object *gem);
-
+int drm_gem_vram_driver_dumb_create(struct drm_file *file,
+				    struct drm_device *dev,
+				    struct drm_mode_create_dumb *args);
 int drm_gem_vram_driver_dumb_mmap_offset(struct drm_file *file,
 					 struct drm_device *dev,
 					 uint32_t handle, uint64_t *offset);
 
+/**
+ * define DRM_GEM_VRAM_DRIVER - default callback functions for \
+	&struct drm_driver
+ *
+ * Drivers that use VRAM MM and GEM VRAM can use this macro to initialize
+ * &struct drm_driver with default functions.
+ */
+#define DRM_GEM_VRAM_DRIVER \
+	.gem_free_object_unlocked = \
+		drm_gem_vram_driver_gem_free_object_unlocked, \
+	.dumb_create		  = drm_gem_vram_driver_dumb_create, \
+	.dumb_map_offset	  = drm_gem_vram_driver_dumb_mmap_offset
+
 #endif
diff --git a/include/drm/drm_vram_mm_helper.h b/include/drm/drm_vram_mm_helper.h
index 0ee060d271bd..3c5961b606fe 100644
--- a/include/drm/drm_vram_mm_helper.h
+++ b/include/drm/drm_vram_mm_helper.h
@@ -64,4 +64,36 @@ void drm_vram_mm_cleanup(struct drm_vram_mm *vmm);
 int drm_vram_mm_mmap(struct file *filp, struct vm_area_struct *vma,
 		     struct drm_vram_mm *vmm);
 
+/*
+ * Helpers for integration with struct drm_device
+ */
+
+struct drm_vram_mm* drm_vram_helper_alloc_mm(
+	struct drm_device *dev, u64 vram_base, unsigned long vram_size,
+	const struct drm_vram_mm_funcs* funcs);
+void drm_vram_helper_release_mm(struct drm_device *dev);
+
+/*
+ * Helpers for &struct file_operations
+ */
+
+int drm_vram_mm_file_operations_mmap(
+	struct file *filp, struct vm_area_struct *vma);
+
+/**
+ * define DRM_VRAM_MM_FILE_OPERATIONS - default callback functions for \
+	&struct file_operations
+ *
+ * Drivers that use VRAM MM can use this macro to initialize
+ * &struct file_operations with default functions.
+ */
+#define DRM_VRAM_MM_FILE_OPERATIONS \
+	.open		= drm_open, \
+	.release	= drm_release, \
+	.unlocked_ioctl = drm_ioctl, \
+	.mmap		= drm_vram_mm_file_operations_mmap, \
+	.poll		= drm_poll, \
+	.compat_ioctl	= drm_compat_ioctl, \
+	.read		= drm_read
+
 #endif
-- 
2.21.0
