From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH] ttm/drm: constify ttm_backend_func structures
Date: Fri, 11 Dec 2015 14:37:47 +0100
Message-ID: <1449841067-3718-1-git-send-email-Julia.Lawall__35523.8337921493$1449841844$gmane$org@lip6.fr>
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
Cc: David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Alex Deucher <alexander.deucher@amd.com>
List-Id: virtualization@lists.linuxfoundation.org

The ttm_backend_func structures are never modified, so declare them as
const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |    2 +-
 drivers/gpu/drm/ast/ast_ttm.c           |    2 +-
 drivers/gpu/drm/bochs/bochs_mm.c        |    2 +-
 drivers/gpu/drm/cirrus/cirrus_ttm.c     |    2 +-
 drivers/gpu/drm/mgag200/mgag200_ttm.c   |    2 +-
 drivers/gpu/drm/nouveau/nouveau_sgdma.c |    4 ++--
 drivers/gpu/drm/qxl/qxl_ttm.c           |    2 +-
 drivers/gpu/drm/radeon/radeon_ttm.c     |    2 +-
 drivers/gpu/drm/ttm/ttm_agp_backend.c   |    2 +-
 drivers/gpu/drm/virtio/virtgpu_ttm.c    |    2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c  |    2 +-
 include/drm/ttm/ttm_bo_driver.h         |    2 +-
 12 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
index 9fd924c..a323422 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
@@ -319,7 +319,7 @@ static void virtio_gpu_ttm_backend_destroy(struct ttm_tt *ttm)
 	kfree(gtt);
 }
 
-static struct ttm_backend_func virtio_gpu_backend_func = {
+static const struct ttm_backend_func virtio_gpu_backend_func = {
 	.bind = &virtio_gpu_ttm_backend_bind,
 	.unbind = &virtio_gpu_ttm_backend_unbind,
 	.destroy = &virtio_gpu_ttm_backend_destroy,
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index e343074..9fa758c 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -666,7 +666,7 @@ static void radeon_ttm_backend_destroy(struct ttm_tt *ttm)
 	kfree(gtt);
 }
 
-static struct ttm_backend_func radeon_backend_func = {
+static const struct ttm_backend_func radeon_backend_func = {
 	.bind = &radeon_ttm_backend_bind,
 	.unbind = &radeon_ttm_backend_unbind,
 	.destroy = &radeon_ttm_backend_destroy,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d4bac5f..befa9c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -634,7 +634,7 @@ static void amdgpu_ttm_backend_destroy(struct ttm_tt *ttm)
 	kfree(gtt);
 }
 
-static struct ttm_backend_func amdgpu_backend_func = {
+static const struct ttm_backend_func amdgpu_backend_func = {
 	.bind = &amdgpu_ttm_backend_bind,
 	.unbind = &amdgpu_ttm_backend_unbind,
 	.destroy = &amdgpu_ttm_backend_destroy,
diff --git a/drivers/gpu/drm/ast/ast_ttm.c b/drivers/gpu/drm/ast/ast_ttm.c
index 08f82ea..5840785 100644
--- a/drivers/gpu/drm/ast/ast_ttm.c
+++ b/drivers/gpu/drm/ast/ast_ttm.c
@@ -203,7 +203,7 @@ static void ast_ttm_backend_destroy(struct ttm_tt *tt)
 	kfree(tt);
 }
 
-static struct ttm_backend_func ast_tt_backend_func = {
+static const struct ttm_backend_func ast_tt_backend_func = {
 	.destroy = &ast_ttm_backend_destroy,
 };
 
diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index d812ad0..b5b782d 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -180,7 +180,7 @@ static void bochs_ttm_backend_destroy(struct ttm_tt *tt)
 	kfree(tt);
 }
 
-static struct ttm_backend_func bochs_tt_backend_func = {
+static const struct ttm_backend_func bochs_tt_backend_func = {
 	.destroy = &bochs_ttm_backend_destroy,
 };
 
diff --git a/drivers/gpu/drm/cirrus/cirrus_ttm.c b/drivers/gpu/drm/cirrus/cirrus_ttm.c
index dfffd52..da88541 100644
--- a/drivers/gpu/drm/cirrus/cirrus_ttm.c
+++ b/drivers/gpu/drm/cirrus/cirrus_ttm.c
@@ -203,7 +203,7 @@ static void cirrus_ttm_backend_destroy(struct ttm_tt *tt)
 	kfree(tt);
 }
 
-static struct ttm_backend_func cirrus_tt_backend_func = {
+static const struct ttm_backend_func cirrus_tt_backend_func = {
 	.destroy = &cirrus_ttm_backend_destroy,
 };
 
diff --git a/drivers/gpu/drm/mgag200/mgag200_ttm.c b/drivers/gpu/drm/mgag200/mgag200_ttm.c
index 05108b5..e368562 100644
--- a/drivers/gpu/drm/mgag200/mgag200_ttm.c
+++ b/drivers/gpu/drm/mgag200/mgag200_ttm.c
@@ -203,7 +203,7 @@ static void mgag200_ttm_backend_destroy(struct ttm_tt *tt)
 	kfree(tt);
 }
 
-static struct ttm_backend_func mgag200_tt_backend_func = {
+static const struct ttm_backend_func mgag200_tt_backend_func = {
 	.destroy = &mgag200_ttm_backend_destroy,
 };
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_sgdma.c b/drivers/gpu/drm/nouveau/nouveau_sgdma.c
index 8c3053a..3b8f556 100644
--- a/drivers/gpu/drm/nouveau/nouveau_sgdma.c
+++ b/drivers/gpu/drm/nouveau/nouveau_sgdma.c
@@ -51,7 +51,7 @@ nv04_sgdma_unbind(struct ttm_tt *ttm)
 	return 0;
 }
 
-static struct ttm_backend_func nv04_sgdma_backend = {
+static const struct ttm_backend_func nv04_sgdma_backend = {
 	.bind			= nv04_sgdma_bind,
 	.unbind			= nv04_sgdma_unbind,
 	.destroy		= nouveau_sgdma_destroy
@@ -82,7 +82,7 @@ nv50_sgdma_unbind(struct ttm_tt *ttm)
 	return 0;
 }
 
-static struct ttm_backend_func nv50_sgdma_backend = {
+static const struct ttm_backend_func nv50_sgdma_backend = {
 	.bind			= nv50_sgdma_bind,
 	.unbind			= nv50_sgdma_unbind,
 	.destroy		= nouveau_sgdma_destroy
diff --git a/drivers/gpu/drm/qxl/qxl_ttm.c b/drivers/gpu/drm/qxl/qxl_ttm.c
index 0cbc4c9..93dc45d 100644
--- a/drivers/gpu/drm/qxl/qxl_ttm.c
+++ b/drivers/gpu/drm/qxl/qxl_ttm.c
@@ -288,7 +288,7 @@ static void qxl_ttm_backend_destroy(struct ttm_tt *ttm)
 	kfree(gtt);
 }
 
-static struct ttm_backend_func qxl_backend_func = {
+static const struct ttm_backend_func qxl_backend_func = {
 	.bind = &qxl_ttm_backend_bind,
 	.unbind = &qxl_ttm_backend_unbind,
 	.destroy = &qxl_ttm_backend_destroy,
diff --git a/drivers/gpu/drm/ttm/ttm_agp_backend.c b/drivers/gpu/drm/ttm/ttm_agp_backend.c
index 764be36..5fdaba5 100644
--- a/drivers/gpu/drm/ttm/ttm_agp_backend.c
+++ b/drivers/gpu/drm/ttm/ttm_agp_backend.c
@@ -104,7 +104,7 @@ static void ttm_agp_destroy(struct ttm_tt *ttm)
 	kfree(agp_be);
 }
 
-static struct ttm_backend_func ttm_agp_func = {
+static const struct ttm_backend_func ttm_agp_func = {
 	.bind = ttm_agp_bind,
 	.unbind = ttm_agp_unbind,
 	.destroy = ttm_agp_destroy,
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c b/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
index 3329f62..d59572a 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_buffer.c
@@ -683,7 +683,7 @@ static void vmw_ttm_unpopulate(struct ttm_tt *ttm)
 		ttm_pool_unpopulate(ttm);
 }
 
-static struct ttm_backend_func vmw_ttm_func = {
+static const struct ttm_backend_func vmw_ttm_func = {
 	.bind = vmw_ttm_bind,
 	.unbind = vmw_ttm_unbind,
 	.destroy = vmw_ttm_destroy,
diff --git a/include/drm/ttm/ttm_bo_driver.h b/include/drm/ttm/ttm_bo_driver.h
index 813042c..c43efa4 100644
--- a/include/drm/ttm/ttm_bo_driver.h
+++ b/include/drm/ttm/ttm_bo_driver.h
@@ -113,7 +113,7 @@ enum ttm_caching_state {
 
 struct ttm_tt {
 	struct ttm_bo_device *bdev;
-	struct ttm_backend_func *func;
+	const struct ttm_backend_func *func;
 	struct page *dummy_read_page;
 	struct page **pages;
 	uint32_t page_flags;
