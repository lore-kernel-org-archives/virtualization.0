From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/qxl: use ttm_tt
Date: Wed,  7 Nov 2018 08:05:39 +0100
Message-ID: <20181107070539.20168-1-kraxel__42123.7144306817$1541574221$gmane$org@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QXL VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

qxl device will not dma, so we don't need ttm_dma_tt.  Go use ttm_tt
instead, to avoid wasting resources (swiotlb bounce buffers for
example).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_ttm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 559a101138..7a778a46a2 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -252,7 +252,7 @@ static void qxl_ttm_io_mem_free(struct ttm_bo_device *bdev,
  * TTM backend functions.
  */
 struct qxl_ttm_tt {
-	struct ttm_dma_tt		ttm;
+	struct ttm_tt		        ttm;
 	struct qxl_device		*qdev;
 	u64				offset;
 };
@@ -281,7 +281,7 @@ static void qxl_ttm_backend_destroy(struct ttm_tt *ttm)
 {
 	struct qxl_ttm_tt *gtt = (void *)ttm;
 
-	ttm_dma_tt_fini(&gtt->ttm);
+	ttm_tt_fini(&gtt->ttm);
 	kfree(gtt);
 }
 
@@ -301,13 +301,13 @@ static struct ttm_tt *qxl_ttm_tt_create(struct ttm_buffer_object *bo,
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
