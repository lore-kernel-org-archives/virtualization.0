From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 11/15] drm/bochs: move ttm_bo_(un)reserve calls into
	bochs_bo_{pin, unpin}
Date: Thu, 10 Jan 2019 09:28:41 +0100
Message-ID: <20190110082845.3453-12-kraxel__45098.0239701041$1547108939$gmane$org@redhat.com>
References: <20190110082845.3453-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190110082845.3453-1-kraxel@redhat.com>
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

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_fbdev.c |  8 --------
 drivers/gpu/drm/bochs/bochs_kms.c   | 14 +-------------
 drivers/gpu/drm/bochs/bochs_mm.c    |  8 ++++++++
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index 92feb817ff..ccf783b038 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -77,14 +77,9 @@ static int bochsfb_create(struct drm_fb_helper *helper,
 
 	bo = gem_to_bochs_bo(gobj);
 
-	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
-	if (ret)
-		return ret;
-
 	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
 	if (ret) {
 		DRM_ERROR("failed to pin fbcon\n");
-		ttm_bo_unreserve(&bo->bo);
 		return ret;
 	}
 
@@ -92,12 +87,9 @@ static int bochsfb_create(struct drm_fb_helper *helper,
 			  &bo->kmap);
 	if (ret) {
 		DRM_ERROR("failed to kmap fbcon\n");
-		ttm_bo_unreserve(&bo->bo);
 		return ret;
 	}
 
-	ttm_bo_unreserve(&bo->bo);
-
 	/* init fb device */
 	info = drm_fb_helper_alloc_fbi(helper);
 	if (IS_ERR(info)) {
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index f663c54185..fc856a02a2 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -92,34 +92,22 @@ static int bochs_plane_prepare_fb(struct drm_plane *plane,
 				struct drm_plane_state *new_state)
 {
 	struct bochs_bo *bo;
-	int ret;
 
 	if (!new_state->fb)
 		return 0;
 	bo = gem_to_bochs_bo(new_state->fb->obj[0]);
-
-	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
-	if (ret)
-		return ret;
-	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
-	ttm_bo_unreserve(&bo->bo);
-	return ret;
+	return bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
 }
 
 static void bochs_plane_cleanup_fb(struct drm_plane *plane,
 				   struct drm_plane_state *old_state)
 {
 	struct bochs_bo *bo;
-	int ret;
 
 	if (!old_state->fb)
 		return;
 	bo = gem_to_bochs_bo(old_state->fb->obj[0]);
-	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
-	if (ret)
-		return;
 	bochs_bo_unpin(bo);
-	ttm_bo_unreserve(&bo->bo);
 }
 
 static const struct drm_plane_helper_funcs bochs_plane_helper_funcs = {
diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index 5a0e092847..fcbf35456d 100644
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
