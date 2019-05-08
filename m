From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v5 02/20] drm: Add |struct drm_gem_vram_object| callbacks for
	|struct ttm_bo_driver|
Date: Wed,  8 May 2019 10:26:12 +0200
Message-ID: <20190508082630.15116-3-tzimmermann__12733.6766499624$1557304069$gmane$org@suse.de>
References: <20190508082630.15116-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190508082630.15116-1-tzimmermann@suse.de>
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

The provided helpers can be used for the respective callback functions
in |struct ttm_bo_driver|.

v2:
	* drm_is_gem_vram() is now a private function
	* documentation fixes

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_gem_vram_helper.c | 50 +++++++++++++++++++++++++++
 include/drm/drm_gem_vram_helper.h     | 10 ++++++
 2 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/drm_gem_vram_helper.c b/drivers/gpu/drm/drm_gem_vram_helper.c
index 761a546412f8..d6c4e0d0a1c5 100644
--- a/drivers/gpu/drm/drm_gem_vram_helper.c
+++ b/drivers/gpu/drm/drm_gem_vram_helper.c
@@ -410,3 +410,53 @@ void drm_gem_vram_kunmap(struct drm_gem_vram_object *gbo)
 	drm_gem_vram_kunmap_at(gbo, &gbo->kmap);
 }
 EXPORT_SYMBOL(drm_gem_vram_kunmap);
+
+/*
+ * Helpers for struct ttm_bo_driver
+ */
+
+static bool drm_is_gem_vram(struct ttm_buffer_object *bo)
+{
+	return (bo->destroy == ttm_buffer_object_destroy);
+}
+
+/**
+ * drm_gem_vram_bo_driver_evict_flags() - \
+	Implements &struct ttm_bo_driver.evict_flags
+ * @bo:	TTM buffer object. Refers to &struct drm_gem_vram_object.bo
+ * @pl:	TTM placement information.
+ */
+void drm_gem_vram_bo_driver_evict_flags(struct ttm_buffer_object *bo,
+					struct ttm_placement *pl)
+{
+	struct drm_gem_vram_object *gbo;
+
+	/* TTM may pass BOs that are not GEM VRAM BOs. */
+	if (!drm_is_gem_vram(bo))
+		return;
+
+	gbo = drm_gem_vram_of_bo(bo);
+	drm_gem_vram_placement(gbo, TTM_PL_FLAG_SYSTEM);
+	*pl = gbo->placement;
+}
+EXPORT_SYMBOL(drm_gem_vram_bo_driver_evict_flags);
+
+/**
+ * drm_gem_vram_bo_driver_verify_access() - \
+	Implements &struct ttm_bo_driver.verify_access
+ * @bo:		TTM buffer object. Refers to &struct drm_gem_vram_object.bo
+ * @filp:	File pointer.
+ *
+ * Returns:
+ * 0 on success, or
+ * a negative errno code otherwise.
+ */
+int drm_gem_vram_bo_driver_verify_access(struct ttm_buffer_object *bo,
+					 struct file *filp)
+{
+	struct drm_gem_vram_object *gbo = drm_gem_vram_of_bo(bo);
+
+	return drm_vma_node_verify_access(&gbo->gem.vma_node,
+					  filp->private_data);
+}
+EXPORT_SYMBOL(drm_gem_vram_bo_driver_verify_access);
diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 5802dd694939..1915d3958304 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -89,4 +89,14 @@ void drm_gem_vram_kunmap_at(struct drm_gem_vram_object *gbo,
 			    struct ttm_bo_kmap_obj *kmap);
 void drm_gem_vram_kunmap(struct drm_gem_vram_object *gbo);
 
+/*
+ * Helpers for struct ttm_bo_driver
+ */
+
+void drm_gem_vram_bo_driver_evict_flags(struct ttm_buffer_object *bo,
+					struct ttm_placement *pl);
+
+int drm_gem_vram_bo_driver_verify_access(struct ttm_buffer_object *bo,
+					 struct file *filp);
+
 #endif
-- 
2.21.0
