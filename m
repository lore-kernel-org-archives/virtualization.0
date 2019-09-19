From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 11/11] drm/vram: drop DRM_VRAM_MM_FILE_OPERATIONS
Date: Thu, 19 Sep 2019 12:02:23 +0200
Message-ID: <20190919100223.13309-12-kraxel@redhat.com>
References: <20190919100223.13309-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190919100223.13309-1-kraxel@redhat.com>
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
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/drm/drm_gem_vram_helper.h              | 18 ------------------
 drivers/gpu/drm/ast/ast_drv.c                  |  5 +----
 drivers/gpu/drm/bochs/bochs_drv.c              |  5 +----
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c    |  5 +----
 drivers/gpu/drm/mgag200/mgag200_drv.c          |  5 +----
 drivers/gpu/drm/vboxvideo/vbox_drv.c           |  5 +----
 6 files changed, 5 insertions(+), 38 deletions(-)

diff --git a/include/drm/drm_gem_vram_helper.h b/include/drm/drm_gem_vram_helper.h
index 05a762c87305..84b31373ddf5 100644
--- a/include/drm/drm_gem_vram_helper.h
+++ b/include/drm/drm_gem_vram_helper.h
@@ -183,22 +183,4 @@ struct drm_vram_mm *drm_vram_helper_alloc_mm(
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
