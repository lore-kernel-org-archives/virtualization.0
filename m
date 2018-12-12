From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 11/18] drm/qxl: drop unused offset parameter from
	qxl_io_create_primary()
Date: Wed, 12 Dec 2018 14:21:02 +0100
Message-ID: <20181212132109.8126-12-kraxel__25342.6362913617$1544620814$gmane$org@redhat.com>
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h     | 1 -
 drivers/gpu/drm/qxl/qxl_cmd.c     | 7 +++----
 drivers/gpu/drm/qxl/qxl_display.c | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 27e0a3fc08..cb767aaef6 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -385,7 +385,6 @@ void qxl_update_screen(struct qxl_device *qxl);
 /* qxl io operations (qxl_cmd.c) */
 
 void qxl_io_create_primary(struct qxl_device *qdev,
-			   unsigned int offset,
 			   struct qxl_bo *bo);
 void qxl_io_destroy_primary(struct qxl_device *qdev);
 void qxl_io_memslot_add(struct qxl_device *qdev, uint8_t id);
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index 73ef41ac5f..626e803f60 100644
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
index a4bdcca715..79dc8a1fa3 100644
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
