From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 8/8] drm/vram: drop DRM_VRAM_MM_FILE_OPERATIONS
Date: Fri, 13 Sep 2019 14:29:08 +0200
Message-ID: <20190913122908.784-9-kraxel__40577.406347596$1568377784$gmane$org@redhat.com>
References: <20190913122908.784-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190913122908.784-1-kraxel@redhat.com>
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
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Xinliang Liu <z.liuxinliang@hisilicon.com>, Hans de Goede <hdegoede@redhat.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Daniel Vetter <daniel@ffwll.ch>, Chen Feng <puck.chen@hisilicon.com>, Rongrong Zou <zourongrong@gmail.com>, Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

Not needed any more because we don't have vram specific fops
any more.  DEFINE_DRM_GEM_FOPS() can be used instead.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_gem_vram_helper.h             | 18 ----
 include/drm/drm_vram_mm_helper.h              | 82 +++++++++++++++++++
 drivers/gpu/drm/ast/ast_drv.c                 |  5 +-
 drivers/gpu/drm/bochs/bochs_drv.c             |  5 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  5 +-
 drivers/gpu/drm/mgag200/mgag200_drv.c         |  5 +-
 drivers/gpu/drm/vboxvideo/vbox_drv.c          |  5 +-
 7 files changed, 87 insertions(+), 38 deletions(-)
 create mode 100644 include/drm/drm_vram_mm_helper.h

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 9d5526650291..3503ff784803 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -180,22 +180,4 @@ struct drm_vram_mm *drm_vram_helper_alloc_mm(
 	struct drm_device *dev, uint64_t vram_base, size_t vram_size);
 void drm_vram_helper_release_mm(struct drm_device *dev);
 
-/**
- * define DRM_VRAM_MM_FILE_OPERATIONS - default callback functions for \
-	&struct file_operations
- *
- * Drivers that use VRAM MM can use this macro to initialize
- * &struct file_operations with default functions.
- */
-#define DRM_VRAM_MM_FILE_OPERATIONS \
-	.llseek		= no_llseek, \
-	.read		= drm_read, \
-	.poll		= drm_poll, \
-	.unlocked_ioctl = drm_ioctl, \
-	.compat_ioctl	= drm_compat_ioctl, \
-	.mmap		= drm_gem_mmap, \
-	.open		= drm_open, \
-	.release	= drm_release \
-
-
 #endif
diff --git a/include/drm/drm_vram_mm_helper.h b/include/drm/drm_vram_mm_helper.h
new file mode 100644
index 000000000000..a47b49adba62
--- /dev/null
+++ b/include/drm/drm_vram_mm_helper.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef DRM_VRAM_MM_HELPER_H
+#define DRM_VRAM_MM_HELPER_H
+
+#include <drm/drm_file.h>
+#include <drm/drm_ioctl.h>
+#include <drm/ttm/ttm_bo_driver.h>
+
+struct drm_device;
+
+/**
+ * struct drm_vram_mm_funcs - Callback functions for &struct drm_vram_mm
+ * @evict_flags:	Provides an implementation for struct \
+	&ttm_bo_driver.evict_flags
+ * @move_notify:	Provides an implementation for
+ *			struct &ttm_bo_driver.move_notify
+ *
+ * These callback function integrate VRAM MM with TTM buffer objects. New
+ * functions can be added if necessary.
+ */
+struct drm_vram_mm_funcs {
+	void (*evict_flags)(struct ttm_buffer_object *bo,
+			    struct ttm_placement *placement);
+	void (*move_notify)(struct ttm_buffer_object *bo, bool evict,
+			    struct ttm_mem_reg *new_mem);
+};
+
+/**
+ * struct drm_vram_mm - An instance of VRAM MM
+ * @vram_base:	Base address of the managed video memory
+ * @vram_size:	Size of the managed video memory in bytes
+ * @bdev:	The TTM BO device.
+ * @funcs:	TTM BO functions
+ *
+ * The fields &struct drm_vram_mm.vram_base and
+ * &struct drm_vram_mm.vrm_size are managed by VRAM MM, but are
+ * available for public read access. Use the field
+ * &struct drm_vram_mm.bdev to access the TTM BO device.
+ */
+struct drm_vram_mm {
+	uint64_t vram_base;
+	size_t vram_size;
+
+	struct ttm_bo_device bdev;
+
+	const struct drm_vram_mm_funcs *funcs;
+};
+
+/**
+ * drm_vram_mm_of_bdev() - \
+	Returns the container of type &struct ttm_bo_device for field bdev.
+ * @bdev:	the TTM BO device
+ *
+ * Returns:
+ * The containing instance of &struct drm_vram_mm
+ */
+static inline struct drm_vram_mm *drm_vram_mm_of_bdev(
+	struct ttm_bo_device *bdev)
+{
+	return container_of(bdev, struct drm_vram_mm, bdev);
+}
+
+int drm_vram_mm_debugfs_init(struct drm_minor *minor);
+int drm_vram_mm_init(struct drm_vram_mm *vmm, struct drm_device *dev,
+		     uint64_t vram_base, size_t vram_size,
+		     const struct drm_vram_mm_funcs *funcs);
+void drm_vram_mm_cleanup(struct drm_vram_mm *vmm);
+
+int drm_vram_mm_mmap(struct file *filp, struct vm_area_struct *vma,
+		     struct drm_vram_mm *vmm);
+
+/*
+ * Helpers for integration with struct drm_device
+ */
+
+struct drm_vram_mm *drm_vram_helper_alloc_mm(
+	struct drm_device *dev, uint64_t vram_base, size_t vram_size,
+	const struct drm_vram_mm_funcs *funcs);
+void drm_vram_helper_release_mm(struct drm_device *dev);
+
+#endif
diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index e0e8770462bc..1f17794b0890 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -200,10 +200,7 @@ static struct pci_driver ast_pci_driver = {
 	.driver.pm = &ast_pm_ops,
 };
 
-static const struct file_operations ast_fops = {
-	.owner = THIS_MODULE,
-	DRM_VRAM_MM_FILE_OPERATIONS
-};
+DEFINE_DRM_GEM_FOPS(ast_fops);
 
 static struct drm_driver driver = {
 	.driver_features = DRIVER_MODESET | DRIVER_GEM,
diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 3b9b0d9bbc14..10460878414e 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -58,10 +58,7 @@ static int bochs_load(struct drm_device *dev)
 	return ret;
 }
 
-static const struct file_operations bochs_fops = {
-	.owner		= THIS_MODULE,
-	DRM_VRAM_MM_FILE_OPERATIONS
-};
+DEFINE_DRM_GEM_FOPS(bochs_fops);
 
 static struct drm_driver bochs_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index f5b35fdef6f3..b6fdac91e502 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -26,10 +26,7 @@
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
 
-static const struct file_operations hibmc_fops = {
-	.owner		= THIS_MODULE,
-	DRM_VRAM_MM_FILE_OPERATIONS
-};
+DEFINE_DRM_GEM_FOPS(hibmc_fops);
 
 static irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
 {
diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index 4f9df3b93598..397f8b0a9af8 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -58,10 +58,7 @@ static void mga_pci_remove(struct pci_dev *pdev)
 	drm_put_dev(dev);
 }
 
-static const struct file_operations mgag200_driver_fops = {
-	.owner = THIS_MODULE,
-	DRM_VRAM_MM_FILE_OPERATIONS
-};
+DEFINE_DRM_GEM_FOPS(mgag200_driver_fops);
 
 static struct drm_driver driver = {
 	.driver_features = DRIVER_GEM | DRIVER_MODESET,
diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.c b/drivers/gpu/drm/vboxvideo/vbox_drv.c
index 862db495d111..0c37032c8b65 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_drv.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_drv.c
@@ -189,10 +189,7 @@ static struct pci_driver vbox_pci_driver = {
 #endif
 };
 
-static const struct file_operations vbox_fops = {
-	.owner = THIS_MODULE,
-	DRM_VRAM_MM_FILE_OPERATIONS
-};
+DEFINE_DRM_GEM_FOPS(vbox_fops);
 
 static struct drm_driver driver = {
 	.driver_features =
-- 
2.18.1
