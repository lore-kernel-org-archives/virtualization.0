From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 1/3] drm/irq: Don't check for DRIVER_HAVE_IRQ in
	drm_irq_(un)install
Date: Tue, 29 Jan 2019 11:42:46 +0100
Message-ID: <20190129104248.26607-1-daniel.vetter__20991.5939530887$1548826438$gmane$org@ffwll.ch>
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
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel.vetter@intel.com>, linux-arm-msm@vger.kernel.org, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org, spice-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-amlogic@lists.infradead.org, freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, Emil Velikov <emil.velikov@collabora.com>
List-Id: virtualization@lists.linuxfoundation.org

If a non-legacy driver calls these it's valid to assume there is
interrupt support. The flag is really only needed for legacy drivers,
which control IRQ enabling/disabling through the DRM_IOCTL_CONTROL
legacy IOCTL.

Also remove all the flag usage from non-legacy drivers.

v2: Review from Emil:
- improve commit message
- I forgot hibmc, fix that

Cc: linux-arm-kernel@lists.infradead.org
Cc: intel-gfx@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: freedreno@lists.freedesktop.org
Cc: virtualization@lists.linux-foundation.org
Cc: spice-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c         | 2 +-
 drivers/gpu/drm/arm/hdlcd_drv.c                 | 2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c    | 2 +-
 drivers/gpu/drm/drm_irq.c                       | 6 ------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c       | 2 +-
 drivers/gpu/drm/gma500/psb_drv.c                | 2 +-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 3 +--
 drivers/gpu/drm/i915/i915_drv.c                 | 2 +-
 drivers/gpu/drm/meson/meson_drv.c               | 2 +-
 drivers/gpu/drm/msm/msm_drv.c                   | 3 +--
 drivers/gpu/drm/mxsfb/mxsfb_drv.c               | 3 +--
 drivers/gpu/drm/qxl/qxl_drv.c                   | 2 +-
 drivers/gpu/drm/radeon/radeon_drv.c             | 2 +-
 drivers/gpu/drm/shmobile/shmob_drm_drv.c        | 2 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c             | 2 +-
 drivers/gpu/drm/vc4/vc4_drv.c                   | 1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c             | 2 +-
 drivers/staging/vboxvideo/vbox_drv.c            | 2 +-
 18 files changed, 16 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0c22bae0c736..22502417c18c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1189,7 +1189,7 @@ amdgpu_get_crtc_scanout_position(struct drm_device *dev, unsigned int pipe,
 static struct drm_driver kms_driver = {
 	.driver_features =
 	    DRIVER_USE_AGP | DRIVER_ATOMIC |
-	    DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM |
+	    DRIVER_IRQ_SHARED | DRIVER_GEM |
 	    DRIVER_PRIME | DRIVER_RENDER | DRIVER_MODESET | DRIVER_SYNCOBJ,
 	.load = amdgpu_driver_load_kms,
 	.open = amdgpu_driver_open_kms,
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index e68935b80917..8fc0b884c428 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -229,7 +229,7 @@ static int hdlcd_debugfs_init(struct drm_minor *minor)
 DEFINE_DRM_GEM_CMA_FOPS(fops);
 
 static struct drm_driver hdlcd_driver = {
-	.driver_features = DRIVER_HAVE_IRQ | DRIVER_GEM |
+	.driver_features = DRIVER_GEM |
 			   DRIVER_MODESET | DRIVER_PRIME |
 			   DRIVER_ATOMIC,
 	.irq_handler = hdlcd_irq,
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 034a91112098..0be13eceedba 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -720,7 +720,7 @@ static void atmel_hlcdc_dc_irq_uninstall(struct drm_device *dev)
 DEFINE_DRM_GEM_CMA_FOPS(fops);
 
 static struct drm_driver atmel_hlcdc_dc_driver = {
-	.driver_features = DRIVER_HAVE_IRQ | DRIVER_GEM |
+	.driver_features = DRIVER_GEM |
 			   DRIVER_MODESET | DRIVER_PRIME |
 			   DRIVER_ATOMIC,
 	.irq_handler = atmel_hlcdc_dc_irq_handler,
diff --git a/drivers/gpu/drm/drm_irq.c b/drivers/gpu/drm/drm_irq.c
index 45a07652fa00..c5babb3e4752 100644
--- a/drivers/gpu/drm/drm_irq.c
+++ b/drivers/gpu/drm/drm_irq.c
@@ -103,9 +103,6 @@ int drm_irq_install(struct drm_device *dev, int irq)
 	int ret;
 	unsigned long sh_flags = 0;
 
-	if (!drm_core_check_feature(dev, DRIVER_HAVE_IRQ))
-		return -EOPNOTSUPP;
-
 	if (irq == 0)
 		return -EINVAL;
 
@@ -174,9 +171,6 @@ int drm_irq_uninstall(struct drm_device *dev)
 	bool irq_enabled;
 	int i;
 
-	if (!drm_core_check_feature(dev, DRIVER_HAVE_IRQ))
-		return -EOPNOTSUPP;
-
 	irq_enabled = dev->irq_enabled;
 	dev->irq_enabled = false;
 
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 54ace3436605..dfc73aade325 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -137,7 +137,7 @@ static irqreturn_t fsl_dcu_drm_irq(int irq, void *arg)
 DEFINE_DRM_GEM_CMA_FOPS(fsl_dcu_drm_fops);
 
 static struct drm_driver fsl_dcu_drm_driver = {
-	.driver_features	= DRIVER_HAVE_IRQ | DRIVER_GEM | DRIVER_MODESET
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET
 				| DRIVER_PRIME | DRIVER_ATOMIC,
 	.load			= fsl_dcu_load,
 	.unload			= fsl_dcu_unload,
diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
index ac32ab5aa002..7cf14aeb1c28 100644
--- a/drivers/gpu/drm/gma500/psb_drv.c
+++ b/drivers/gpu/drm/gma500/psb_drv.c
@@ -468,7 +468,7 @@ static const struct file_operations psb_gem_fops = {
 };
 
 static struct drm_driver driver = {
-	.driver_features = DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | \
+	.driver_features = DRIVER_IRQ_SHARED | \
 			   DRIVER_MODESET | DRIVER_GEM,
 	.load = psb_driver_load,
 	.unload = psb_driver_unload,
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 85a701af6530..8ed94fcd42a7 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -56,8 +56,7 @@ static irqreturn_t hibmc_drm_interrupt(int irq, void *arg)
 }
 
 static struct drm_driver hibmc_driver = {
-	.driver_features	= DRIVER_GEM | DRIVER_MODESET |
-				  DRIVER_ATOMIC | DRIVER_HAVE_IRQ,
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &hibmc_fops,
 	.name			= "hibmc",
 	.date			= "20160828",
diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 337ee650d2de..550cfb945942 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -3010,7 +3010,7 @@ static struct drm_driver driver = {
 	 * deal with them for Intel hardware.
 	 */
 	.driver_features =
-	    DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM | DRIVER_PRIME |
+	    DRIVER_IRQ_SHARED | DRIVER_GEM | DRIVER_PRIME |
 	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_SYNCOBJ,
 	.release = i915_driver_release,
 	.open = i915_driver_open,
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 2cbc6c7bb823..2281ed3eb774 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -94,7 +94,7 @@ static irqreturn_t meson_irq(int irq, void *arg)
 DEFINE_DRM_GEM_CMA_FOPS(fops);
 
 static struct drm_driver meson_driver = {
-	.driver_features	= DRIVER_HAVE_IRQ | DRIVER_GEM |
+	.driver_features	= DRIVER_GEM |
 				  DRIVER_MODESET | DRIVER_PRIME |
 				  DRIVER_ATOMIC,
 
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index d2cdc7b553fe..8747fb32a106 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1063,8 +1063,7 @@ static const struct file_operations fops = {
 };
 
 static struct drm_driver msm_driver = {
-	.driver_features    = DRIVER_HAVE_IRQ |
-				DRIVER_GEM |
+	.driver_features    = DRIVER_GEM |
 				DRIVER_PRIME |
 				DRIVER_RENDER |
 				DRIVER_ATOMIC |
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 54c8cdaeb576..967379f3f571 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -322,8 +322,7 @@ DEFINE_DRM_GEM_CMA_FOPS(fops);
 
 static struct drm_driver mxsfb_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET |
-				  DRIVER_PRIME | DRIVER_ATOMIC |
-				  DRIVER_HAVE_IRQ,
+				  DRIVER_PRIME | DRIVER_ATOMIC,
 	.irq_handler		= mxsfb_irq_handler,
 	.irq_preinstall		= mxsfb_irq_preinstall,
 	.irq_uninstall		= mxsfb_irq_preinstall,
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index a9d4c1ee12f3..1669d4b79253 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -245,7 +245,7 @@ static struct pci_driver qxl_pci_driver = {
 
 static struct drm_driver qxl_driver = {
 	.driver_features = DRIVER_GEM | DRIVER_MODESET | DRIVER_PRIME |
-			   DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED |
+			   DRIVER_IRQ_SHARED |
 			   DRIVER_ATOMIC,
 
 	.dumb_create = qxl_mode_dumb_create,
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 8897c3d18fbb..450a9d473c30 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -535,7 +535,7 @@ radeon_get_crtc_scanout_position(struct drm_device *dev, unsigned int pipe,
 static struct drm_driver kms_driver = {
 	.driver_features =
 	    DRIVER_USE_AGP |
-	    DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED | DRIVER_GEM |
+	    DRIVER_IRQ_SHARED | DRIVER_GEM |
 	    DRIVER_PRIME | DRIVER_RENDER,
 	.load = radeon_driver_load_kms,
 	.open = radeon_driver_open_kms,
diff --git a/drivers/gpu/drm/shmobile/shmob_drm_drv.c b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
index 2002e7c55e80..cb821adfc321 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_drv.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_drv.c
@@ -127,7 +127,7 @@ static irqreturn_t shmob_drm_irq(int irq, void *arg)
 DEFINE_DRM_GEM_CMA_FOPS(shmob_drm_fops);
 
 static struct drm_driver shmob_drm_driver = {
-	.driver_features	= DRIVER_HAVE_IRQ | DRIVER_GEM | DRIVER_MODESET
+	.driver_features	= DRIVER_GEM | DRIVER_MODESET
 				| DRIVER_PRIME,
 	.irq_handler		= shmob_drm_irq,
 	.gem_free_object_unlocked = drm_gem_cma_free_object,
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 13b11acd4a5e..3030af9e7b35 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -512,7 +512,7 @@ static int tilcdc_debugfs_init(struct drm_minor *minor)
 DEFINE_DRM_GEM_CMA_FOPS(fops);
 
 static struct drm_driver tilcdc_driver = {
-	.driver_features    = (DRIVER_HAVE_IRQ | DRIVER_GEM | DRIVER_MODESET |
+	.driver_features    = (DRIVER_GEM | DRIVER_MODESET |
 			       DRIVER_PRIME | DRIVER_ATOMIC),
 	.irq_handler        = tilcdc_irq,
 	.gem_free_object_unlocked = drm_gem_cma_free_object,
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index f6f5cd80c04d..5fcd2f0da7f7 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -175,7 +175,6 @@ static struct drm_driver vc4_drm_driver = {
 	.driver_features = (DRIVER_MODESET |
 			    DRIVER_ATOMIC |
 			    DRIVER_GEM |
-			    DRIVER_HAVE_IRQ |
 			    DRIVER_RENDER |
 			    DRIVER_PRIME |
 			    DRIVER_SYNCOBJ),
diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 25afb1d594e3..d159d0400013 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -1582,7 +1582,7 @@ static const struct file_operations vmwgfx_driver_fops = {
 };
 
 static struct drm_driver driver = {
-	.driver_features = DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED |
+	.driver_features = DRIVER_IRQ_SHARED |
 	DRIVER_MODESET | DRIVER_PRIME | DRIVER_RENDER | DRIVER_ATOMIC,
 	.load = vmw_driver_load,
 	.unload = vmw_driver_unload,
diff --git a/drivers/staging/vboxvideo/vbox_drv.c b/drivers/staging/vboxvideo/vbox_drv.c
index cc6532d8c2fa..78cbcd68d4f3 100644
--- a/drivers/staging/vboxvideo/vbox_drv.c
+++ b/drivers/staging/vboxvideo/vbox_drv.c
@@ -221,7 +221,7 @@ static void vbox_master_drop(struct drm_device *dev, struct drm_file *file_priv)
 
 static struct drm_driver driver = {
 	.driver_features =
-	    DRIVER_MODESET | DRIVER_GEM | DRIVER_HAVE_IRQ | DRIVER_IRQ_SHARED |
+	    DRIVER_MODESET | DRIVER_GEM | DRIVER_IRQ_SHARED |
 	    DRIVER_PRIME | DRIVER_ATOMIC,
 	.dev_priv_size = 0,
 
-- 
2.20.1
