From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 11/14] drm/bochs: add basic prime support
Date: Wed, 19 Dec 2018 12:51:24 +0100
Message-ID: <20181219115127.31359-12-kraxel__8651.61102633483$1545220244$gmane$org@redhat.com>
References: <20181219115127.31359-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181219115127.31359-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Generic framebuffer emulation needs this.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     | 11 +++++++
 drivers/gpu/drm/bochs/bochs_drv.c | 15 +++++++++-
 drivers/gpu/drm/bochs/bochs_mm.c  | 63 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index d0d474e06f..4236d5d811 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -145,6 +145,17 @@ int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 int bochs_bo_pin(struct bochs_bo *bo, u32 pl_flag);
 int bochs_bo_unpin(struct bochs_bo *bo);
 
+int bochs_gem_prime_pin(struct drm_gem_object *obj);
+void bochs_gem_prime_unpin(struct drm_gem_object *obj);
+struct sg_table *bochs_gem_prime_get_sg_table(struct drm_gem_object *obj);
+struct drm_gem_object *bochs_gem_prime_import_sg_table(
+        struct drm_device *dev, struct dma_buf_attachment *attach,
+        struct sg_table *sgt);
+void *bochs_gem_prime_vmap(struct drm_gem_object *obj);
+void bochs_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
+int bochs_gem_prime_mmap(struct drm_gem_object *obj,
+			 struct vm_area_struct *vma);
+
 /* bochs_kms.c */
 int bochs_kms_init(struct bochs_device *bochs);
 void bochs_kms_fini(struct bochs_device *bochs);
diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 278f9d2e7f..a9c7140e3b 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -81,7 +81,8 @@ static const struct file_operations bochs_fops = {
 };
 
 static struct drm_driver bochs_driver = {
-	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC |
+				  DRIVER_PRIME,
 	.fops			= &bochs_fops,
 	.name			= "bochs-drm",
 	.desc			= "bochs dispi vga interface (qemu stdvga)",
@@ -91,6 +92,18 @@ static struct drm_driver bochs_driver = {
 	.gem_free_object_unlocked = bochs_gem_free_object,
 	.dumb_create            = bochs_dumb_create,
 	.dumb_map_offset        = bochs_dumb_mmap_offset,
+
+	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
+	.gem_prime_export = drm_gem_prime_export,
+	.gem_prime_import = drm_gem_prime_import,
+	.gem_prime_pin = bochs_gem_prime_pin,
+	.gem_prime_unpin = bochs_gem_prime_unpin,
+	.gem_prime_get_sg_table = bochs_gem_prime_get_sg_table,
+	.gem_prime_import_sg_table = bochs_gem_prime_import_sg_table,
+	.gem_prime_vmap = bochs_gem_prime_vmap,
+	.gem_prime_vunmap = bochs_gem_prime_vunmap,
+	.gem_prime_mmap = bochs_gem_prime_mmap,
 };
 
 /* ---------------------------------------------------------------------- */
diff --git a/drivers/gpu/drm/bochs/bochs_mm.c b/drivers/gpu/drm/bochs/bochs_mm.c
index 5a0e092847..cfe061c25f 100644
--- a/drivers/gpu/drm/bochs/bochs_mm.c
+++ b/drivers/gpu/drm/bochs/bochs_mm.c
@@ -387,3 +387,66 @@ int bochs_dumb_mmap_offset(struct drm_file *file, struct drm_device *dev,
 	drm_gem_object_put_unlocked(obj);
 	return 0;
 }
+
+/* ---------------------------------------------------------------------- */
+
+int bochs_gem_prime_pin(struct drm_gem_object *obj)
+{
+	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+
+	return bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
+}
+
+void bochs_gem_prime_unpin(struct drm_gem_object *obj)
+{
+	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+
+	bochs_bo_unpin(bo);
+}
+
+struct sg_table *bochs_gem_prime_get_sg_table(struct drm_gem_object *obj)
+{
+	WARN_ONCE(1, "not implemented");
+	return ERR_PTR(-ENODEV);
+}
+
+struct drm_gem_object *bochs_gem_prime_import_sg_table(
+	struct drm_device *dev, struct dma_buf_attachment *attach,
+	struct sg_table *table)
+{
+	WARN_ONCE(1, "not implemented");
+	return ERR_PTR(-ENODEV);
+}
+
+void *bochs_gem_prime_vmap(struct drm_gem_object *obj)
+{
+	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+	bool is_iomem;
+	int ret;
+
+	ret = bochs_bo_pin(bo, TTM_PL_FLAG_VRAM);
+	if (ret)
+		return NULL;
+	ret = ttm_bo_kmap(&bo->bo, 0, bo->bo.num_pages, &bo->kmap);
+	if (ret) {
+		bochs_bo_unpin(bo);
+		return NULL;
+	}
+	return ttm_kmap_obj_virtual(&bo->kmap, &is_iomem);
+}
+
+void bochs_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
+{
+	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+
+	ttm_bo_kunmap(&bo->kmap);
+	bochs_bo_unpin(bo);
+}
+
+int bochs_gem_prime_mmap(struct drm_gem_object *obj,
+			 struct vm_area_struct *vma)
+{
+	struct bochs_bo *bo = gem_to_bochs_bo(obj);
+
+	return ttm_fbdev_mmap(vma, &bo->bo);
+}
-- 
2.9.3
