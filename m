From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2] drm/qxl: use ttm_tt
Date: Tue, 29 Jan 2019 09:25:41 +0100
Message-ID: <20190129082541.1392-1-kraxel__32790.5417814449$1548826318$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

qxl device will not dma, so we don't need ttm_dma_tt.  Go use ttm_tt
instead, to avoid wasting resources (swiotlb bounce buffers for
example).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_ttm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 36ea993aac..92f5db5b29 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -204,7 +204,7 @@ static void qxl_ttm_io_mem_free(struct ttm_bo_device *bdev,
  * TTM backend functions.
  */
 struct qxl_ttm_tt {
-	struct ttm_dma_tt		ttm;
+	struct ttm_tt		        ttm;
 	struct qxl_device		*qdev;
 	u64				offset;
 };
@@ -233,7 +233,7 @@ static void qxl_ttm_backend_destroy(struct ttm_tt *ttm)
 {
 	struct qxl_ttm_tt *gtt = (void *)ttm;
 
-	ttm_dma_tt_fini(&gtt->ttm);
+	ttm_tt_fini(&gtt->ttm);
 	kfree(gtt);
 }
 
@@ -253,13 +253,13 @@ static struct ttm_tt *qxl_ttm_tt_create(struct ttm_buffer_object *bo,
 	gtt = kzalloc(sizeof(struct qxl_ttm_tt), GFP_KERNEL);
 	if (gtt == NULL)
 		return NULL;
-	gtt->ttm.ttm.func = &qxl_backend_func;
+	gtt->ttm.func = &qxl_backend_func;
 	gtt->qdev = qdev;
-	if (ttm_dma_tt_init(&gtt->ttm, bo, page_flags)) {
+	if (ttm_tt_init(&gtt->ttm, bo, page_flags)) {
 		kfree(gtt);
 		return NULL;
 	}
-	return &gtt->ttm.ttm;
+	return &gtt->ttm;
 }
 
 static void qxl_move_null(struct ttm_buffer_object *bo,
-- 
2.9.3
