From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 16/18] drm/qxl: implement prime kmap/kunmap
Date: Wed, 12 Dec 2018 14:21:07 +0100
Message-ID: <20181212132109.8126-17-kraxel__22668.1373118938$1544620825$gmane$org@redhat.com>
References: <20181212132109.8126-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181212132109.8126-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, spice-devel@redhat.com, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Generic fbdev emulation needs this.  Also: We must keep track of the
number of mappings now, so we don't unmap early in case two users want a
kmap of the same bo.  Add a sanity check to destroy callback to make
sure kmap/kunmap is balanced.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h    |  1 +
 drivers/gpu/drm/qxl/qxl_object.c |  6 ++++++
 drivers/gpu/drm/qxl/qxl_prime.c  | 17 +++++++++++++----
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 43c6df9cf9..8c3af1cdbe 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -84,6 +84,7 @@ struct qxl_bo {
 	struct ttm_bo_kmap_obj		kmap;
 	unsigned int pin_count;
 	void				*kptr;
+	unsigned int                    map_count;
 	int                             type;
 
 	/* Constant after initialization */
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 024c8dd317..4928fa6029 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -36,6 +36,7 @@ static void qxl_ttm_bo_destroy(struct ttm_buffer_object *tbo)
 	qdev = (struct qxl_device *)bo->gem_base.dev->dev_private;
 
 	qxl_surface_evict(qdev, bo, false);
+	WARN_ON_ONCE(bo->map_count > 0);
 	mutex_lock(&qdev->gem.mutex);
 	list_del_init(&bo->list);
 	mutex_unlock(&qdev->gem.mutex);
@@ -131,6 +132,7 @@ int qxl_bo_kmap(struct qxl_bo *bo, void **ptr)
 	if (bo->kptr) {
 		if (ptr)
 			*ptr = bo->kptr;
+		bo->map_count++;
 		return 0;
 	}
 	r = ttm_bo_kmap(&bo->tbo, 0, bo->tbo.num_pages, &bo->kmap);
@@ -139,6 +141,7 @@ int qxl_bo_kmap(struct qxl_bo *bo, void **ptr)
 	bo->kptr = ttm_kmap_obj_virtual(&bo->kmap, &is_iomem);
 	if (ptr)
 		*ptr = bo->kptr;
+	bo->map_count = 1;
 	return 0;
 }
 
@@ -180,6 +183,9 @@ void qxl_bo_kunmap(struct qxl_bo *bo)
 {
 	if (bo->kptr == NULL)
 		return;
+	bo->map_count--;
+	if (bo->map_count > 0)
+		return;
 	bo->kptr = NULL;
 	ttm_bo_kunmap(&bo->kmap);
 }
diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
index a55dece118..708378844c 100644
--- a/drivers/gpu/drm/qxl/qxl_prime.c
+++ b/drivers/gpu/drm/qxl/qxl_prime.c
@@ -22,7 +22,7 @@
  * Authors: Andreas Pokorny
  */
 
-#include "qxl_drv.h"
+#include "qxl_object.h"
 
 /* Empty Implementations as there should not be any other driver for a virtual
  * device that might share buffers with qxl */
@@ -54,13 +54,22 @@ struct drm_gem_object *qxl_gem_prime_import_sg_table(
 
 void *qxl_gem_prime_vmap(struct drm_gem_object *obj)
 {
-	WARN_ONCE(1, "not implemented");
-	return ERR_PTR(-ENOSYS);
+	struct qxl_bo *bo = gem_to_qxl_bo(obj);
+	void *ptr;
+	int ret;
+
+	ret = qxl_bo_kmap(bo, &ptr);
+	if (ret < 0)
+		return ERR_PTR(ret);
+
+	return ptr;
 }
 
 void qxl_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
 {
-	WARN_ONCE(1, "not implemented");
+	struct qxl_bo *bo = gem_to_qxl_bo(obj);
+
+	qxl_bo_kunmap(bo);
 }
 
 int qxl_gem_prime_mmap(struct drm_gem_object *obj,
-- 
2.9.3
