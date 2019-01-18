From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 12/23] drm/qxl: track primary bo
Date: Fri, 18 Jan 2019 13:20:09 +0100
Message-ID: <20190118122020.27596-13-kraxel__14780.012300662$1547814196$gmane$org@redhat.com>
References: <20190118122020.27596-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190118122020.27596-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Track which bo is used as primary surface.  With that in place we don't
need the primary_created flag any more, we can just check the primary bo
pointer instead.

Also verify we don't already have a primary surface in
qxl_io_create_primary().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h     | 2 +-
 drivers/gpu/drm/qxl/qxl_cmd.c     | 7 +++++--
 drivers/gpu/drm/qxl/qxl_display.c | 2 +-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index cb767aaef6..150b1a4f66 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -229,7 +229,7 @@ struct qxl_device {
 
 	struct qxl_ram_header *ram_header;
 
-	unsigned int primary_created:1;
+	struct qxl_bo *primary_bo;
 
 	struct qxl_memslot main_slot;
 	struct qxl_memslot surfaces_slot;
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index bc13539249..8e64127259 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -374,13 +374,16 @@ void qxl_io_flush_surfaces(struct qxl_device *qdev)
 void qxl_io_destroy_primary(struct qxl_device *qdev)
 {
 	wait_for_io_cmd(qdev, 0, QXL_IO_DESTROY_PRIMARY_ASYNC);
-	qdev->primary_created = false;
+	qdev->primary_bo = NULL;
 }
 
 void qxl_io_create_primary(struct qxl_device *qdev, struct qxl_bo *bo)
 {
 	struct qxl_surface_create *create;
 
+	if (WARN_ON(qdev->primary_bo))
+		return;
+
 	DRM_DEBUG_DRIVER("qdev %p, ram_header %p\n", qdev, qdev->ram_header);
 	create = &qdev->ram_header->create_surface;
 	create->format = bo->surf.format;
@@ -399,7 +402,7 @@ void qxl_io_create_primary(struct qxl_device *qdev, struct qxl_bo *bo)
 	create->type = QXL_SURF_TYPE_PRIMARY;
 
 	wait_for_io_cmd(qdev, 0, QXL_IO_CREATE_PRIMARY_ASYNC);
-	qdev->primary_created = true;
+	qdev->primary_bo = bo;
 }
 
 void qxl_io_memslot_add(struct qxl_device *qdev, uint8_t id)
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 21165ab514..d3215eac9b 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -302,7 +302,7 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 	struct qxl_head head;
 	int oldcount, i = qcrtc->index;
 
-	if (!qdev->primary_created) {
+	if (!qdev->primary_bo) {
 		DRM_DEBUG_KMS("no primary surface, skip (%s)\n", reason);
 		return;
 	}
-- 
2.9.3
