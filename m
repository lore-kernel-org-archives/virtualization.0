From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 16/16] drm/bochs: move remaining fb bits to kms
Date: Fri, 11 Jan 2019 06:37:52 +0100
Message-ID: <20190111053752.4004-17-kraxel__9771.91992938078$1547692851$gmane$org@redhat.com>
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

bochs_fbdev.c is almost empty now.  Move the remaining framebuffer bits
over to bochs_kms.c.  Pure code motion. No functional change.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_fbdev.c | 29 -----------------------------
 drivers/gpu/drm/bochs/bochs_kms.c   | 17 +++++++++++++++++
 drivers/gpu/drm/bochs/Makefile      |  2 +-
 3 files changed, 18 insertions(+), 30 deletions(-)
 delete mode 100644 drivers/gpu/drm/bochs/bochs_fbdev.c

diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
deleted file mode 100644
index 7cac3f5253..0000000000
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- */
-
-#include "bochs.h"
-#include <drm/drm_atomic_helper.h>
-#include <drm/drm_gem_framebuffer_helper.h>
-
-/* ---------------------------------------------------------------------- */
-
-static struct drm_framebuffer *
-bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
-		    const struct drm_mode_fb_cmd2 *mode_cmd)
-{
-	if (mode_cmd->pixel_format != DRM_FORMAT_XRGB8888 &&
-	    mode_cmd->pixel_format != DRM_FORMAT_BGRX8888)
-		return ERR_PTR(-EINVAL);
-
-	return drm_gem_fb_create(dev, file, mode_cmd);
-}
-
-const struct drm_mode_config_funcs bochs_mode_funcs = {
-	.fb_create = bochs_gem_fb_create,
-	.atomic_check = drm_atomic_helper_check,
-	.atomic_commit = drm_atomic_helper_commit,
-};
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index fc856a02a2..e9d5dbc346 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -9,6 +9,7 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_atomic_uapi.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 
 static int defx = 1024;
 static int defy = 768;
@@ -256,6 +257,22 @@ static void bochs_connector_init(struct drm_device *dev)
 	}
 }
 
+static struct drm_framebuffer *
+bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
+		    const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	if (mode_cmd->pixel_format != DRM_FORMAT_XRGB8888 &&
+	    mode_cmd->pixel_format != DRM_FORMAT_BGRX8888)
+		return ERR_PTR(-EINVAL);
+
+	return drm_gem_fb_create(dev, file, mode_cmd);
+}
+
+const struct drm_mode_config_funcs bochs_mode_funcs = {
+	.fb_create = bochs_gem_fb_create,
+	.atomic_check = drm_atomic_helper_check,
+	.atomic_commit = drm_atomic_helper_commit,
+};
 
 int bochs_kms_init(struct bochs_device *bochs)
 {
diff --git a/drivers/gpu/drm/bochs/Makefile b/drivers/gpu/drm/bochs/Makefile
index 98ef60a19e..e9e0f8f5eb 100644
--- a/drivers/gpu/drm/bochs/Makefile
+++ b/drivers/gpu/drm/bochs/Makefile
@@ -1,3 +1,3 @@
-bochs-drm-y := bochs_drv.o bochs_mm.o bochs_kms.o bochs_fbdev.o bochs_hw.o
+bochs-drm-y := bochs_drv.o bochs_mm.o bochs_kms.o bochs_hw.o
 
 obj-$(CONFIG_DRM_BOCHS)	+= bochs-drm.o
-- 
2.9.3
