From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 11/16] drm/bochs: drop unused gpu_addr arg from
	bochs_bo_pin()
Date: Fri, 11 Jan 2019 06:37:47 +0100
Message-ID: <20190111053752.4004-12-kraxel__5827.13096305287$1547693734$gmane$org@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
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
Cc: andr2000@gmail.com, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@linux.ie>, noralf@tronnes.org
List-Id: virtualization@lists.linuxfoundation.org

It's always NULL, so just remove it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs.h       |  2 +-
 drivers/gpu/drm/bochs/bochs_fbdev.c |  2 +-
 drivers/gpu/drm/bochs/bochs_kms.c   |  2 +-
 drivers/gpu/drm/bochs/bochs_mm.c    | 11 +----------
 4 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 4dc1b6384e..d0d474e06f 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -142,7 +142,7 @@ int bochs_dumb_create(struct drm_file *file, struct drm_device *dev,
 int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 			   uint32_t handle, uint64_t *offset);
 
-int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag, u64 *gpu_addr);
+int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag);
 int bochs_bo_unpin(struct bochs_bo *bo);
 
 /* bochs_kms.c */
diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index d9f3d42999..92feb817ff 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -81,7 +81,7 @@ static int bochsfb_create(struct drm_fb_helper *helper,
 	if (ret)
 		return ret;
 
-	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM, NULL);
+	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
 	if (ret) {
 		DRM_ERROR("failed to pin fbcon\n");
 		ttm_bo_unreserve(&bo->bo);
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 5b7e1a7c6b..f663c54185 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -101,7 +101,7 @@ static int bochs_plane_prepare_fb(struct drm_plane *plane,
 	ret = ttm_bo_reserve(&bo->bo, true, false, NULL);
 	if (ret)
 		return ret;
-	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM, NULL);
+	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
 	ttm_bo_unreserve(&bo->bo);
 	return ret;
 }
diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index 0980411e41..5a0e092847 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -210,20 +210,13 @@ static void bochs_ttm_placement(struct bochs_bo *bo, int domain)
 	bo->placement.num_busy_placement = c;
 }
 
-static inline u64 bochs_bo_gpu_offset(struct bochs_bo *bo)
-{
-	return bo->bo.offset;
-}
-
-int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag, u64 *gpu_addr)
+int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag)
 {
 	struct ttm_operation_ctx ctx = { false, false };
 	int i, ret;
 
 	if (bo->pin_count) {
 		bo->pin_count++;
-		if (gpu_addr)
-			*gpu_addr = bochs_bo_gpu_offset(bo);
 		return 0;
 	}
 
@@ -235,8 +228,6 @@ int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag, u64 *gpu_addr)
 		return ret;
 
 	bo->pin_count = 1;
-	if (gpu_addr)
-		*gpu_addr = bochs_bo_gpu_offset(bo);
 	return 0;
 }
 
-- 
2.9.3
