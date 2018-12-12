From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 01/18] drm/qxl: drop ttm_mem_reg arg from
	qxl_hw_surface_alloc()
Date: Wed, 12 Dec 2018 14:20:52 +0100
Message-ID: <20181212132109.8126-2-kraxel__40163.2052301013$1544620851$gmane$org@redhat.com>
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

Not used, is always NULL.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_drv.h    |  3 +--
 drivers/gpu/drm/qxl/qxl_cmd.c    | 14 ++------------
 drivers/gpu/drm/qxl/qxl_object.c |  2 +-
 3 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 13a0254b59..38c5a8b1df 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -497,8 +497,7 @@ int qxl_surface_id_alloc(struct qxl_device *qdev,
 void qxl_surface_id_dealloc(struct qxl_device *qdev,
 			    uint32_t surface_id);
 int qxl_hw_surface_alloc(struct qxl_device *qdev,
-			 struct qxl_bo *surf,
-			 struct ttm_mem_reg *mem);
+			 struct qxl_bo *surf);
 int qxl_hw_surface_dealloc(struct qxl_device *qdev,
 			   struct qxl_bo *surf);
 
diff --git a/drivers/gpu/drm/qxl/qxl_cmd.c b/drivers/gpu/drm/qxl/qxl_cmd.c
index dffc5093ff..73ef41ac5f 100644
--- a/drivers/gpu/drm/qxl/qxl_cmd.c
+++ b/drivers/gpu/drm/qxl/qxl_cmd.c
@@ -458,8 +458,7 @@ void qxl_surface_id_dealloc(struct qxl_device *qdev,
 }
 
 int qxl_hw_surface_alloc(struct qxl_device *qdev,
-			 struct qxl_bo *surf,
-			 struct ttm_mem_reg *new_mem)
+			 struct qxl_bo *surf)
 {
 	struct qxl_surface_cmd *cmd;
 	struct qxl_release *release;
@@ -485,16 +484,7 @@ int qxl_hw_surface_alloc(struct qxl_device *qdev,
 	cmd->u.surface_create.width = surf->surf.width;
 	cmd->u.surface_create.height = surf->surf.height;
 	cmd->u.surface_create.stride = surf->surf.stride;
-	if (new_mem) {
-		int slot_id = surf->type == QXL_GEM_DOMAIN_VRAM ? qdev->main_mem_slot : qdev->surfaces_mem_slot;
-		struct qxl_memslot *slot = &(qdev->mem_slots[slot_id]);
-
-		/* TODO - need to hold one of the locks to read tbo.offset */
-		cmd->u.surface_create.data = slot->high_bits;
-
-		cmd->u.surface_create.data |= (new_mem->start << PAGE_SHIFT) + surf->tbo.bdev->man[new_mem->mem_type].gpu_offset;
-	} else
-		cmd->u.surface_create.data = qxl_bo_physical_address(qdev, surf, 0);
+	cmd->u.surface_create.data = qxl_bo_physical_address(qdev, surf, 0);
 	cmd->surface_id = surf->surface_id;
 	qxl_release_unmap(qdev, release, &cmd->release_info);
 
diff --git a/drivers/gpu/drm/qxl/qxl_object.c b/drivers/gpu/drm/qxl/qxl_object.c
index 91f3bbc73e..34eff8b21e 100644
--- a/drivers/gpu/drm/qxl/qxl_object.c
+++ b/drivers/gpu/drm/qxl/qxl_object.c
@@ -332,7 +332,7 @@ int qxl_bo_check_id(struct qxl_device *qdev, struct qxl_bo *bo)
 		if (ret)
 			return ret;
 
-		ret = qxl_hw_surface_alloc(qdev, bo, NULL);
+		ret = qxl_hw_surface_alloc(qdev, bo);
 		if (ret)
 			return ret;
 	}
-- 
2.9.3
