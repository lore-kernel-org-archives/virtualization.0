From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 03/19] drm: Add |struct drm_gem_vram_object| callbacks for
	|struct drm_driver|
Date: Mon, 29 Apr 2019 16:43:25 +0200
Message-ID: <20190429144341.12615-4-tzimmermann__10002.9670445778$1556549225$gmane$org@suse.de>
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

The provided helpers can be used for the respective callback functions
in |struct drm_driver|.

v2:
	* documentation fixes

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 48 +++++++++++++++++++++++++++
 include/drm/drm_gem_vram_helper.h     | 10 ++++++
 2 files changed, 58 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index fcf6e78d92f7..31bf6c1079b0 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -458,3 +458,51 @@ int drm_gem_vram_bo_driver_verify_access(struct ttm_buffer_object *bo,
 					  filp->private_data);
 }
 EXPORT_SYMBOL(drm_gem_vram_bo_driver_verify_access);
+
+/*
+ * Helpers for struct drm_driver
+ */
+
+/**
+ * drm_gem_vram_driver_gem_free_object_unlocked() - \
+	Implements &struct drm_driver.gem_free_object_unlocked
+ * @gem:	GEM object. Refers to &struct drm_gem_vram_object.gem
+ */
+void drm_gem_vram_driver_gem_free_object_unlocked(struct drm_gem_object *gem)
+{
+	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(gem);
+	drm_gem_vram_put(gbo);
+}
+EXPORT_SYMBOL(drm_gem_vram_driver_gem_free_object_unlocked);
+
+/**
+ * drm_gem_vram_driver_dumb_mmap_offset() - \
+	Implements &struct drm_driver.dumb_mmap_offset
+ * @file:	DRM file pointer.
+ * @dev:	DRM device.
+ * @handle:	GEM handle
+ * @offset:	Returns the mapping's memory offset on success
+ *
+ * Returns:
+ * 0 on success, or
+ * a negative errno code otherwise.
+ */
+int drm_gem_vram_driver_dumb_mmap_offset(struct drm_file *file,
+					 struct drm_device *dev,
+					 uint32_t handle, uint64_t *offset)
+{
+	struct drm_gem_object *gem;
+	struct drm_gem_vram_object *gbo;
+
+	gem = drm_gem_object_lookup(file, handle);
+	if (!gem)
+		return -ENOENT;
+
+	gbo = drm_gem_vram_of_gem(gem);
+	*offset = drm_gem_vram_mmap_offset(gbo);
+
+	drm_gem_object_put_unlocked(gem);
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_gem_vram_driver_dumb_mmap_offset);
diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 4872edb09fe9..99982590e32a 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -99,4 +99,14 @@ void drm_gem_vram_bo_driver_evict_flags(struct ttm_buffer_object *bo,
 int drm_gem_vram_bo_driver_verify_access(struct ttm_buffer_object *bo,
 					 struct file *filp);
 
+/*
+ * Helpers for struct drm_driver
+ */
+
+void drm_gem_vram_driver_gem_free_object_unlocked(struct drm_gem_object *gem);
+
+int drm_gem_vram_driver_dumb_mmap_offset(struct drm_file *file,
+					 struct drm_device *dev,
+					 uint32_t handle, uint64_t *offset);
+
 #endif
-- 
2.21.0
