From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 06/19] drm: Add default instance for VRAM MM callback
	functions
Date: Mon,  6 May 2019 10:26:36 +0200
Message-ID: <20190506082649.942-7-tzimmermann__31742.7044430346$1557131338$gmane$org@suse.de>
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

VRAM MM is most likely be used with GEM VRAM. The latter now provides the
required instance of struct drm_vram_mm_funcs for drivers to use.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 14 ++++++++++++++
 include/drm/drm_gem_vram_helper.h     |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 461ed20b779b..33321291475a 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -2,6 +2,7 @@
 
 #include <drm/drm_gem_vram_helper.h>
 #include <drm/drm_mode.h>
+#include <drm/drm_vram_mm_helper.h>
 #include <drm/ttm/ttm_page_alloc.h>
 
 /**
@@ -523,6 +524,19 @@ int drm_gem_vram_bo_driver_verify_access(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(drm_gem_vram_bo_driver_verify_access);
 
+/**
+ * drm_gem_vram_mm_funcs - Functions for &struct drm_vram_mm
+ *
+ * Most users of @struct drm_gem_vram_object will also use
+ * @struct drm_vram_mm. This instance of &struct drm_vram_mm_funcs
+ * can be used to connect both.
+ */
+const struct drm_vram_mm_funcs drm_gem_vram_mm_funcs = {
+	.evict_flags = drm_gem_vram_bo_driver_evict_flags,
+	.verify_access = drm_gem_vram_bo_driver_verify_access
+};
+EXPORT_SYMBOL(drm_gem_vram_mm_funcs);
+
 /*
  * Helpers for struct drm_driver
  */
diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 68edb28d4508..f09f1594b4f8 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -9,6 +9,7 @@
 #include <linux/kernel.h> /* for container_of() */
 
 struct drm_mode_create_dumb;
+struct drm_vram_mm_funcs;
 struct filp;
 
 #define DRM_GEM_VRAM_PL_FLAG_VRAM	TTM_PL_FLAG_VRAM
@@ -107,6 +108,8 @@ void drm_gem_vram_bo_driver_evict_flags(struct ttm_buffer_object *bo,
 int drm_gem_vram_bo_driver_verify_access(struct ttm_buffer_object *bo,
 					 struct file *filp);
 
+extern const struct drm_vram_mm_funcs drm_gem_vram_mm_funcs;
+
 /*
  * Helpers for struct drm_driver
  */
-- 
2.21.0
