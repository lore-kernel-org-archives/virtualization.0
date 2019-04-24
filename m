From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 04/17] drm: Add drm_gem_vram_fill_create_dumb() to create
	dumb buffers
Date: Wed, 24 Apr 2019 13:48:29 +0200
Message-ID: <20190424114842.4723-5-tzimmermann__14864.0536399157$1556106571$gmane$org@suse.de>
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

The helper function drm_gem_vram_fill_create_dumb() implements most of
struct drm_driver.dumb_create() for GEM-VRAM buffer objects. It's not a
full implemenation of the callback, as several driver-specific parameters
are still required.

v2:
	* documentation fixes

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 62 +++++++++++++++++++++++++++
 include/drm/drm_gem_vram_helper.h     |  8 ++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 31bf6c1079b0..e5a0dcf97ba8 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #include <drm/drm_gem_vram_helper.h>
+#include <drm/drm_mode.h>
 #include <drm/ttm/ttm_page_alloc.h>
 
 /**
@@ -409,6 +410,67 @@ void drm_gem_vram_kunmap(struct drm_gem_vram_object *gbo)
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
+				  uint32_t pg_align,
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
index 99982590e32a..1eb42919b9fb 100644
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
+				  uint32_t pg_align,
+				  bool interruptible,
+				  struct drm_mode_create_dumb *args);
+
 /*
  * Helpers for struct ttm_bo_driver
  */
-- 
2.21.0
