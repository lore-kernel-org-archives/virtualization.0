From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3] drm/cirrus: flip default from 24bpp to 16bpp
Date: Wed,  8 Aug 2018 13:13:11 +0200
Message-ID: <20180808111311.30311-1-kraxel__24808.67772033$1533726680$gmane$org@redhat.com>
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
To: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>, Dave Airlie <airlied@redhat.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

The problem with 24bpp is that it is a rather unusual depth these days,
cirrus is pretty much the only relevant device still using that, and it
is a endless source of issues.  Wayland doesn't support it at all.  Bugs
in Xorg keep showing up.

Typically either 32bpp or 16bpp are used.  Using 32bpp would limit the
resolution to 800x600 due to hardware constrains.  So lets go with 16bpp.

Also use the default depth for the framebuffer console and
mode_info->preferred_depth.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus_drv.c   | 4 ++--
 drivers/gpu/drm/cirrus/cirrus_fbdev.c | 3 +--
 drivers/gpu/drm/cirrus/cirrus_mode.c  | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.c b/drivers/gpu/drm/cirrus/cirrus_drv.c
index 69c4e352dd..b4f7be056c 100644
--- a/drivers/gpu/drm/cirrus/cirrus_drv.c
+++ b/drivers/gpu/drm/cirrus/cirrus_drv.c
@@ -16,11 +16,11 @@
 #include "cirrus_drv.h"
 
 int cirrus_modeset = -1;
-int cirrus_bpp = 24;
+int cirrus_bpp = 16;
 
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, cirrus_modeset, int, 0400);
-MODULE_PARM_DESC(bpp, "Max bits-per-pixel (default:24)");
+MODULE_PARM_DESC(bpp, "Max bits-per-pixel (default:16)");
 module_param_named(bpp, cirrus_bpp, int, 0400);
 
 /*
diff --git a/drivers/gpu/drm/cirrus/cirrus_fbdev.c b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
index 32fbfba2c6..b329a54290 100644
--- a/drivers/gpu/drm/cirrus/cirrus_fbdev.c
+++ b/drivers/gpu/drm/cirrus/cirrus_fbdev.c
@@ -271,7 +271,6 @@ int cirrus_fbdev_init(struct cirrus_device *cdev)
 {
 	struct cirrus_fbdev *gfbdev;
 	int ret;
-	int bpp_sel = 24;
 
 	/*bpp_sel = 8;*/
 	gfbdev = kzalloc(sizeof(struct cirrus_fbdev), GFP_KERNEL);
@@ -296,7 +295,7 @@ int cirrus_fbdev_init(struct cirrus_device *cdev)
 	/* disable all the possible outputs/crtcs before entering KMS mode */
 	drm_helper_disable_unused_functions(cdev->dev);
 
-	return drm_fb_helper_initial_config(&gfbdev->helper, bpp_sel);
+	return drm_fb_helper_initial_config(&gfbdev->helper, cirrus_bpp);
 }
 
 void cirrus_fbdev_fini(struct cirrus_device *cdev)
diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
index c91b9b054e..91128b1d8d 100644
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -518,7 +518,7 @@ int cirrus_modeset_init(struct cirrus_device *cdev)
 	cdev->dev->mode_config.max_height = CIRRUS_MAX_FB_HEIGHT;
 
 	cdev->dev->mode_config.fb_base = cdev->mc.vram_base;
-	cdev->dev->mode_config.preferred_depth = 24;
+	cdev->dev->mode_config.preferred_depth = cirrus_bpp;
 	/* don't prefer a shadow on virt GPU */
 	cdev->dev->mode_config.prefer_shadow = 0;
 
-- 
2.9.3
