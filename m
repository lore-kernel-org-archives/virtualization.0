From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/bochs: add drm_driver.release callback.
Date: Fri,  7 Feb 2020 13:13:12 +0100
Message-ID: <20200207121312.25296-1-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: Gurchetan Singh <gurchetansingh@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

From: Gurchetan Singh <gurchetansingh@chromium.org>

Move bochs_unload call from bochs_remove() to the new bochs_release()
callback.  Also call drm_dev_unregister() first in bochs_remove().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
index 10460878414e..87ee1eb21a4d 100644
--- a/drivers/gpu/drm/bochs/bochs_drv.c
+++ b/drivers/gpu/drm/bochs/bochs_drv.c
@@ -60,6 +60,11 @@ static int bochs_load(struct drm_device *dev)
 
 DEFINE_DRM_GEM_FOPS(bochs_fops);
 
+static void bochs_release(struct drm_device *dev)
+{
+	bochs_unload(dev);
+}
+
 static struct drm_driver bochs_driver = {
 	.driver_features	= DRIVER_GEM | DRIVER_MODESET | DRIVER_ATOMIC,
 	.fops			= &bochs_fops,
@@ -69,6 +74,7 @@ static struct drm_driver bochs_driver = {
 	.major			= 1,
 	.minor			= 0,
 	DRM_GEM_VRAM_DRIVER,
+	.release                = bochs_release,
 };
 
 /* ---------------------------------------------------------------------- */
@@ -148,9 +154,8 @@ static void bochs_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
 
-	drm_atomic_helper_shutdown(dev);
 	drm_dev_unregister(dev);
-	bochs_unload(dev);
+	drm_atomic_helper_shutdown(dev);
 	drm_dev_put(dev);
 }
 
-- 
2.18.1
