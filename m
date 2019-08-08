From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 8/8] gem/qxl: use drm_gem_ttm_bo_driver_verify_access()
Date: Thu,  8 Aug 2019 11:37:02 +0200
Message-ID: <20190808093702.29512-9-kraxel__5612.67126338265$1565257065$gmane$org@redhat.com>
References: <20190808093702.29512-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190808093702.29512-1-kraxel@redhat.com>
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
Cc: tzimmermann@suse.de, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <spice-devel@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_ttm.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 3a24145dd516..bcf48b062a85 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -151,14 +151,6 @@ static void qxl_evict_flags(struct ttm_buffer_object *bo,
 	*placement = qbo->placement;
 }
 
-static int qxl_verify_access(struct ttm_buffer_object *bo, struct file *filp)
-{
-	struct qxl_bo *qbo = to_qxl_bo(bo);
-
-	return drm_vma_node_verify_access(&qbo->tbo.base.vma_node,
-					  filp->private_data);
-}
-
 static int qxl_ttm_io_mem_reserve(struct ttm_bo_device *bdev,
 				  struct ttm_mem_reg *mem)
 {
@@ -310,7 +302,7 @@ static struct ttm_bo_driver qxl_bo_driver = {
 	.eviction_valuable = ttm_bo_eviction_valuable,
 	.evict_flags = &qxl_evict_flags,
 	.move = &qxl_bo_move,
-	.verify_access = &qxl_verify_access,
+	.verify_access = drm_gem_ttm_bo_driver_verify_access,
 	.io_mem_reserve = &qxl_ttm_io_mem_reserve,
 	.io_mem_free = &qxl_ttm_io_mem_free,
 	.move_notify = &qxl_bo_move_notify,
-- 
2.18.1
