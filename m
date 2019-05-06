From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 04/19] drm: Add drm_gem_vram_fill_create_dumb() to create
	dumb buffers
Date: Mon,  6 May 2019 10:26:34 +0200
Message-ID: <20190506082649.942-5-tzimmermann__25363.8055802853$1557131317$gmane$org@suse.de>
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

The helper function drm_gem_vram_fill_create_dumb() implements most of
struct drm_driver.dumb_create() for GEM-VRAM buffer objects. It's not a
full implementation of the callback, as several driver-specific parameters
are still required.

v4:
	* cleanups from checkpatch.pl
v2:
	* documentation fixes

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 62 +++++++++++++++++++++++++++
 include/drm/drm_gem_vram_helper.h     |  8 ++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 41f971908b78..461ed20b779b 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <drm/drm_gem_vram_helper.h>
+#include <drm/drm_mode.h>
 #include <drm/ttm/ttm_page_alloc.h>
 
 /**
@@ -411,6 +412,67 @@ void drm_gem_vram_kunmap(struct drm_gem_vram_object *gbo)
 }
 EXPORT_SYMBOL(drm_gem_vram_kunmap);
 
+/**
+ * drm_gem_vram_fill_create_dumb() - \
+	Helper for implementing &struct drm_driver.dumb_create
+ * @file:		the DRM file
+ * @dev:		the DRM device
+ * @bdev:		the TTM BO device managing the buffer object
+ * @pg_align:		the buffer's alignment in multiples of the page size
+ * @interruptible:	sleep interruptible if waiting for memory
+ * @args:		the arguments as provided to \
+				&struct drm_driver.dumb_create
+ *
+ * This helper function fills &struct drm_mode_create_dumb, which is used
+ * by &struct drm_driver.dumb_create. Implementations of this interface
+ * should forwards their arguments to this helper, plus the driver-specific
+ * parameters.
+ *
+ * Returns:
+ * 0 on success, or
+ * a negative error code otherwise.
+ */
+int drm_gem_vram_fill_create_dumb(struct drm_file *file,
+				  struct drm_device *dev,
+				  struct ttm_bo_device *bdev,
+				  unsigned long pg_align,
+				  bool interruptible,
+				  struct drm_mode_create_dumb *args)
+{
+	size_t pitch, size;
+	struct drm_gem_vram_object *gbo;
+	int ret;
+	u32 handle;
+
+	pitch = args->width * ((args->bpp + 7) / 8);
+	size = pitch * args->height;
+
+	size = roundup(size, PAGE_SIZE);
+	if (!size)
+		return -EINVAL;
+
+	gbo = drm_gem_vram_create(dev, bdev, size, pg_align, interruptible);
+	if (IS_ERR(gbo))
+		return PTR_ERR(gbo);
+
+	ret = drm_gem_handle_create(file, &gbo->gem, &handle);
+	if (ret)
+		goto err_drm_gem_object_put_unlocked;
+
+	drm_gem_object_put_unlocked(&gbo->gem);
+
+	args->pitch = pitch;
+	args->size = size;
+	args->handle = handle;
+
+	return 0;
+
+err_drm_gem_object_put_unlocked:
+	drm_gem_object_put_unlocked(&gbo->gem);
+	return ret;
+}
+EXPORT_SYMBOL(drm_gem_vram_fill_create_dumb);
+
 /*
  * Helpers for struct ttm_bo_driver
  */
diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index d6a75d860f4e..68edb28d4508 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -8,6 +8,7 @@
 #include <drm/ttm/ttm_placement.h>
 #include <linux/kernel.h> /* for container_of() */
 
+struct drm_mode_create_dumb;
 struct filp;
 
 #define DRM_GEM_VRAM_PL_FLAG_VRAM	TTM_PL_FLAG_VRAM
@@ -89,6 +90,13 @@ void drm_gem_vram_kunmap_at(struct drm_gem_vram_object *gbo,
 			    struct ttm_bo_kmap_obj *kmap);
 void drm_gem_vram_kunmap(struct drm_gem_vram_object *gbo);
 
+int drm_gem_vram_fill_create_dumb(struct drm_file *file,
+				  struct drm_device *dev,
+				  struct ttm_bo_device *bdev,
+				  unsigned long pg_align,
+				  bool interruptible,
+				  struct drm_mode_create_dumb *args);
+
 /*
  * Helpers for struct ttm_bo_driver
  */
-- 
2.21.0
