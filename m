From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 02/11] drm/shmem: switch shmem helper to
	&drm_gem_object_funcs.mmap
Date: Wed, 16 Oct 2019 13:51:54 +0200
Message-ID: <20191016115203.20095-3-kraxel@redhat.com>
References: <20191016115203.20095-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20191016115203.20095-1-kraxel@redhat.com>
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
Cc: Rob Herring <robh@kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>, Steven Price <steven.price@arm.com>, Eric Anholt <eric@anholt.net>, Thomas Zimmermann <tzimmermann@suse.de>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, Sean Paul <sean@poorly.run>, Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

Switch gem shmem helper to the new mmap() workflow,
from &gem_driver.fops.mmap to &drm_gem_object_funcs.mmap.

v2: Fix vm_flags and vm_page_prot handling.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 include/drm/drm_gem_shmem_helper.h      |  6 ++----
 drivers/gpu/drm/drm_gem_shmem_helper.c  | 28 +++++++++----------------
 drivers/gpu/drm/panfrost/panfrost_gem.c |  2 +-
 drivers/gpu/drm/v3d/v3d_bo.c            |  2 +-
 drivers/gpu/drm/virtio/virtgpu_object.c |  2 +-
 5 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/include/drm/drm_gem_shmem_helper.h b/include/drm/drm_gem_shmem_helper.h
index 01f514521687..d89f2116c8ab 100644
--- a/include/drm/drm_gem_shmem_helper.h
+++ b/include/drm/drm_gem_shmem_helper.h
@@ -111,7 +111,7 @@ struct drm_gem_shmem_object {
 		.poll		= drm_poll,\
 		.read		= drm_read,\
 		.llseek		= noop_llseek,\
-		.mmap		= drm_gem_shmem_mmap, \
+		.mmap		= drm_gem_mmap, \
 	}
 
 struct drm_gem_shmem_object *drm_gem_shmem_create(struct drm_device *dev, size_t size);
@@ -143,9 +143,7 @@ drm_gem_shmem_create_with_handle(struct drm_file *file_priv,
 int drm_gem_shmem_dumb_create(struct drm_file *file, struct drm_device *dev,
 			      struct drm_mode_create_dumb *args);
 
-int drm_gem_shmem_mmap(struct file *filp, struct vm_area_struct *vma);
-
-extern const struct vm_operations_struct drm_gem_shmem_vm_ops;
+int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma);
 
 void drm_gem_shmem_print_info(struct drm_printer *p, unsigned int indent,
 			      const struct drm_gem_object *obj);
diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
index f5918707672f..a9a586630517 100644
--- a/drivers/gpu/drm/drm_gem_shmem_helper.c
+++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
@@ -32,7 +32,7 @@ static const struct drm_gem_object_funcs drm_gem_shmem_funcs = {
 	.get_sg_table = drm_gem_shmem_get_sg_table,
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
-	.vm_ops = &drm_gem_shmem_vm_ops,
+	.mmap = drm_gem_shmem_mmap,
 };
 
 /**
@@ -505,39 +505,30 @@ static void drm_gem_shmem_vm_close(struct vm_area_struct *vma)
 	drm_gem_vm_close(vma);
 }
 
-const struct vm_operations_struct drm_gem_shmem_vm_ops = {
+static const struct vm_operations_struct drm_gem_shmem_vm_ops = {
 	.fault = drm_gem_shmem_fault,
 	.open = drm_gem_shmem_vm_open,
 	.close = drm_gem_shmem_vm_close,
 };
-EXPORT_SYMBOL_GPL(drm_gem_shmem_vm_ops);
 
 /**
  * drm_gem_shmem_mmap - Memory-map a shmem GEM object
- * @filp: File object
+ * @obj: gem object
  * @vma: VMA for the area to be mapped
  *
  * This function implements an augmented version of the GEM DRM file mmap
  * operation for shmem objects. Drivers which employ the shmem helpers should
- * use this function as their &file_operations.mmap handler in the DRM device file's
- * file_operations structure.
- *
- * Instead of directly referencing this function, drivers should use the
- * DEFINE_DRM_GEM_SHMEM_FOPS() macro.
+ * use this function as their &drm_gem_object_funcs.mmap handler.
  *
  * Returns:
  * 0 on success or a negative error code on failure.
  */
-int drm_gem_shmem_mmap(struct file *filp, struct vm_area_struct *vma)
+int drm_gem_shmem_mmap(struct drm_gem_object *obj, struct vm_area_struct *vma)
 {
 	struct drm_gem_shmem_object *shmem;
 	int ret;
 
-	ret = drm_gem_mmap(filp, vma);
-	if (ret)
-		return ret;
-
-	shmem = to_drm_gem_shmem_obj(vma->vm_private_data);
+	shmem = to_drm_gem_shmem_obj(obj);
 
 	ret = drm_gem_shmem_get_pages(shmem);
 	if (ret) {
@@ -545,9 +536,10 @@ int drm_gem_shmem_mmap(struct file *filp, struct vm_area_struct *vma)
 		return ret;
 	}
 
-	/* VM_PFNMAP was set by drm_gem_mmap() */
-	vma->vm_flags &= ~VM_PFNMAP;
-	vma->vm_flags |= VM_MIXEDMAP;
+	vma->vm_flags |= VM_IO | VM_MIXEDMAP | VM_DONTEXPAND | VM_DONTDUMP;
+	vma->vm_page_prot = pgprot_writecombine(vm_get_page_prot(vma->vm_flags));
+	vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
+	vma->vm_ops = &drm_gem_shmem_vm_ops;
 
 	/* Remove the fake offset */
 	vma->vm_pgoff -= drm_vma_node_start(&shmem->base.vma_node);
diff --git a/drivers/gpu/drm/panfrost/panfrost_gem.c b/drivers/gpu/drm/panfrost/panfrost_gem.c
index acb07fe06580..deca0c30bbd4 100644
--- a/drivers/gpu/drm/panfrost/panfrost_gem.c
+++ b/drivers/gpu/drm/panfrost/panfrost_gem.c
@@ -112,7 +112,7 @@ static const struct drm_gem_object_funcs panfrost_gem_funcs = {
 	.get_sg_table = drm_gem_shmem_get_sg_table,
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
-	.vm_ops = &drm_gem_shmem_vm_ops,
+	.mmap = drm_gem_shmem_mmap,
 };
 
 /**
diff --git a/drivers/gpu/drm/v3d/v3d_bo.c b/drivers/gpu/drm/v3d/v3d_bo.c
index a22b75a3a533..edd299ab53d8 100644
--- a/drivers/gpu/drm/v3d/v3d_bo.c
+++ b/drivers/gpu/drm/v3d/v3d_bo.c
@@ -58,7 +58,7 @@ static const struct drm_gem_object_funcs v3d_gem_funcs = {
 	.get_sg_table = drm_gem_shmem_get_sg_table,
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
-	.vm_ops = &drm_gem_shmem_vm_ops,
+	.mmap = drm_gem_shmem_mmap,
 };
 
 /* gem_create_object function for allocating a BO struct and doing
diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 69a3d310ff70..017a9e0fc3bb 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -86,7 +86,7 @@ static const struct drm_gem_object_funcs virtio_gpu_gem_funcs = {
 	.get_sg_table = drm_gem_shmem_get_sg_table,
 	.vmap = drm_gem_shmem_vmap,
 	.vunmap = drm_gem_shmem_vunmap,
-	.vm_ops = &drm_gem_shmem_vm_ops,
+	.mmap = &drm_gem_shmem_mmap,
 };
 
 struct drm_gem_object *virtio_gpu_create_object(struct drm_device *dev,
-- 
2.18.1
