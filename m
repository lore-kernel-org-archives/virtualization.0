From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 5/7] virtio-gpu: add basic prime support
Date: Fri,  2 Oct 2015 13:58:22 +0200
Message-ID: <1443787104-24243-6-git-send-email-kraxel__24561.9562258527$1443787182$gmane$org@redhat.com>
References: <1443787104-24243-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1443787104-24243-1-git-send-email-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

From: Dave Airlie <airlied@redhat.com>

This is enough to enable DRI3.

Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/virtio/Makefile        |  2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.c   | 13 ++++++-
 drivers/gpu/drm/virtio/virtgpu_drv.h   | 12 ++++++
 drivers/gpu/drm/virtio/virtgpu_prime.c | 71 ++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_prime.c

diff --git a/drivers/gpu/drm/virtio/Makefile b/drivers/gpu/drm/virtio/Makefile
index da7bf19..3fb8eac 100644
--- a/drivers/gpu/drm/virtio/Makefile
+++ b/drivers/gpu/drm/virtio/Makefile
@@ -7,6 +7,6 @@ ccflags-y := -Iinclude/drm
 virtio-gpu-y := virtgpu_drv.o virtgpu_kms.o virtgpu_drm_bus.o virtgpu_gem.o \
 	virtgpu_fb.o virtgpu_display.o virtgpu_vq.o virtgpu_ttm.o \
 	virtgpu_fence.o virtgpu_object.o virtgpu_debugfs.o virtgpu_plane.o \
-	virtgpu_ioctl.o
+	virtgpu_ioctl.o virtgpu_prime.o
 
 obj-$(CONFIG_DRM_VIRTIO_GPU) += virtio-gpu.o
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.c b/drivers/gpu/drm/virtio/virtgpu_drv.c
index c27d3a3..1f15ef8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.c
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.c
@@ -118,7 +118,7 @@ static const struct file_operations virtio_gpu_driver_fops = {
 
 
 static struct drm_driver driver = {
-	.driver_features = DRIVER_MODESET | DRIVER_GEM,
+	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_PRIME,
 	.set_busid = drm_virtio_set_busid,
 	.load = virtio_gpu_driver_load,
 	.unload = virtio_gpu_driver_unload,
@@ -133,6 +133,17 @@ static struct drm_driver driver = {
 	.debugfs_init = virtio_gpu_debugfs_init,
 	.debugfs_cleanup = virtio_gpu_debugfs_takedown,
 #endif
+	.prime_handle_to_fd = drm_gem_prime_handle_to_fd,
+	.prime_fd_to_handle = drm_gem_prime_fd_to_handle,
+	.gem_prime_export = drm_gem_prime_export,
+	.gem_prime_import = drm_gem_prime_import,
+	.gem_prime_pin = virtgpu_gem_prime_pin,
+	.gem_prime_unpin = virtgpu_gem_prime_unpin,
+	.gem_prime_get_sg_table = virtgpu_gem_prime_get_sg_table,
+	.gem_prime_import_sg_table = virtgpu_gem_prime_import_sg_table,
+	.gem_prime_vmap = virtgpu_gem_prime_vmap,
+	.gem_prime_vunmap = virtgpu_gem_prime_vunmap,
+	.gem_prime_mmap = virtgpu_gem_prime_mmap,
 
 	.gem_free_object = virtio_gpu_gem_free_object,
 	.gem_open_object = virtio_gpu_gem_object_open,
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 2719108..79f0abe 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -359,6 +359,18 @@ int virtio_gpu_object_get_sg_table(struct virtio_gpu_device *qdev,
 void virtio_gpu_object_free_sg_table(struct virtio_gpu_object *bo);
 int virtio_gpu_object_wait(struct virtio_gpu_object *bo, bool no_wait);
 
+/* virtgpu_prime.c */
+int virtgpu_gem_prime_pin(struct drm_gem_object *obj);
+void virtgpu_gem_prime_unpin(struct drm_gem_object *obj);
+struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj);
+struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
+        struct drm_device *dev, struct dma_buf_attachment *attach,
+        struct sg_table *sgt);
+void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj);
+void virtgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
+int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
+                                struct vm_area_struct *vma);
+
 static inline struct virtio_gpu_object*
 virtio_gpu_object_ref(struct virtio_gpu_object *bo)
 {
diff --git a/drivers/gpu/drm/virtio/virtgpu_prime.c b/drivers/gpu/drm/virtio/virtgpu_prime.c
new file mode 100644
index 0000000..385e0eb
--- /dev/null
+++ b/drivers/gpu/drm/virtio/virtgpu_prime.c
@@ -0,0 +1,71 @@
+/*
+ * Copyright 2014 Canonical
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Andreas Pokorny
+ */
+
+#include "virtgpu_drv.h"
+
+/* Empty Implementations as there should not be any other driver for a virtual
+ * device that might share buffers with virtgpu */
+
+int virtgpu_gem_prime_pin(struct drm_gem_object *obj)
+{
+	WARN_ONCE(1, "not implemented");
+	return -ENODEV;
+}
+
+void virtgpu_gem_prime_unpin(struct drm_gem_object *obj)
+{
+	WARN_ONCE(1, "not implemented");
+}
+
+
+struct sg_table *virtgpu_gem_prime_get_sg_table(struct drm_gem_object *obj)
+{
+	WARN_ONCE(1, "not implemented");
+	return ERR_PTR(-ENODEV);
+}
+
+struct drm_gem_object *virtgpu_gem_prime_import_sg_table(
+	struct drm_device *dev, struct dma_buf_attachment *attach,
+	struct sg_table *table)
+{
+	WARN_ONCE(1, "not implemented");
+	return ERR_PTR(-ENODEV);
+}
+
+void *virtgpu_gem_prime_vmap(struct drm_gem_object *obj)
+{
+	WARN_ONCE(1, "not implemented");
+	return ERR_PTR(-ENODEV);
+}
+
+void virtgpu_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr)
+{
+	WARN_ONCE(1, "not implemented");
+}
+
+int virtgpu_gem_prime_mmap(struct drm_gem_object *obj,
+		       struct vm_area_struct *area)
+{
+	return -ENODEV;
+}
-- 
1.8.3.1
