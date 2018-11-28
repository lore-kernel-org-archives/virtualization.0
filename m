From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/6] drm/qxl: drop unused offset parameter from
	qxl_io_create_primary()
Date: Wed, 28 Nov 2018 11:34:14 +0100
Message-ID: <20181128103418.28023-3-kraxel__22746.0496280857$1543401154$gmane$org@redhat.com>
References: <20181128103418.28023-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181128103418.28023-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: David Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h     | 1 -
 drivers/gpu/drm/qxl/qxl_cmd.c     | 7 +++----
 drivers/gpu/drm/qxl/qxl_display.c | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 14d3fa8557..6b8d28a23f 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -395,7 +395,6 @@ void qxl_update_screen(struct qxl_device *qxl);
 /* qxl io operations (qxl_cmd.c) */
 
 void qxl_io_create_primary(struct qxl_device *qdev,
-			   unsigned int offset,
 			   struct qxl_bo *bo);
 void qxl_io_destroy_primary(struct qxl_device *qdev);
 void qxl_io_memslot_add(struct qxl_device *qdev, uint8_t id);
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index dffc5093ff..f263d83775 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -375,8 +375,7 @@ void qxl_io_destroy_primary(struct qxl_device *qdev)
 	qdev->primary_created = false;
 }
 
-void qxl_io_create_primary(struct qxl_device *qdev,
-			   unsigned int offset, struct qxl_bo *bo)
+void qxl_io_create_primary(struct qxl_device *qdev, struct qxl_bo *bo)
 {
 	struct qxl_surface_create *create;
 
@@ -387,9 +386,9 @@ void qxl_io_create_primary(struct qxl_device *qdev,
 	create->height = bo->surf.height;
 	create->stride = bo->surf.stride;
 	if (bo->shadow) {
-		create->mem = qxl_bo_physical_address(qdev, bo->shadow, offset);
+		create->mem = qxl_bo_physical_address(qdev, bo->shadow, 0);
 	} else {
-		create->mem = qxl_bo_physical_address(qdev, bo, offset);
+		create->mem = qxl_bo_physical_address(qdev, bo, 0);
 	}
 
 	DRM_DEBUG_DRIVER("mem = %llx, from %p\n", create->mem, bo->kptr);
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 58fb2c4308..d875cae02f 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -557,7 +557,7 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 
 	if (!bo->is_primary) {
 		if (!same_shadow) {
-			qxl_io_create_primary(qdev, 0, bo);
+			qxl_io_create_primary(qdev, bo);
 			qxl_primary_apply_cursor(plane);
 		}
 		bo->is_primary = true;
-- 
2.9.3
