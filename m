From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 15/15] drm/bochs: reserve bo for pin/unpin
Date: Tue,  8 Jan 2019 12:25:19 +0100
Message-ID: <20190108112519.27473-16-kraxel__46527.2670299329$1546946655$gmane$org@redhat.com>
References: <20190108112519.27473-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190108112519.27473-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc: andr2000@gmail.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The buffer object must be reserved before calling
ttm_bo_validate for pinning/unpinning.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_mm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index cfe061c25f..970a591908 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -223,7 +223,11 @@ int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag)
 	bochs_ttm_placement(bo, pl_flag);
 	for (i = 0; i < bo->placement.num_placement; i++)
 		bo->placements[i].flags |= TTM_PL_FLAG_NO_EVICT;
+	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
+	if (ret)
+		return ret;
 	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
+	ttm_bo_unreserve(&bo->bo);
 	if (ret)
 		return ret;
 
@@ -247,7 +251,11 @@ int bochs_bo_unpin(struct bochs_bo *bo)
 
 	for (i = 0; i < bo->placement.num_placement; i++)
 		bo->placements[i].flags &= ~TTM_PL_FLAG_NO_EVICT;
+	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
+	if (ret)
+		return ret;
 	ret = ttm_bo_validate(&bo->bo, &bo->placement, &ctx);
+	ttm_bo_unreserve(&bo->bo);
 	if (ret)
 		return ret;
 
-- 
2.9.3
