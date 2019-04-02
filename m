From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/2] drm/cirrus: drop mode_info.mode_config_initialized
Date: Tue,  2 Apr 2019 11:04:59 +0200
Message-ID: <20190402090459.12126-3-kraxel__12279.3327247322$1554195926$gmane$org@redhat.com>
References: <20190402090459.12126-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190402090459.12126-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus_drv.h  | 1 -
 drivers/gpu/drm/cirrus/cirrus_mode.c | 9 ++-------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus_drv.h b/drivers/gpu/drm/cirrus/cirrus_drv.h
index 915709739257..828b150cdb20 100644
--- a/drivers/gpu/drm/cirrus/cirrus_drv.h
+++ b/drivers/gpu/drm/cirrus/cirrus_drv.h
@@ -101,7 +101,6 @@ struct cirrus_crtc {
 
 struct cirrus_fbdev;
 struct cirrus_mode_info {
-	bool				mode_config_initialized;
 	struct cirrus_crtc		*crtc;
 	/* pointer to fbdev info structure */
 	struct cirrus_fbdev		*gfbdev;
diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
index 32ce2c1040b4..b109cd71426f 100644
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -575,7 +575,6 @@ int cirrus_modeset_init(struct cirrus_device *cdev)
 	int ret;
 
 	drm_mode_config_init(cdev->dev);
-	cdev->mode_info.mode_config_initialized = true;
 
 	cdev->dev->mode_config.max_width = CIRRUS_MAX_FB_WIDTH;
 	cdev->dev->mode_config.max_height = CIRRUS_MAX_FB_HEIGHT;
@@ -613,10 +612,6 @@ int cirrus_modeset_init(struct cirrus_device *cdev)
 void cirrus_modeset_fini(struct cirrus_device *cdev)
 {
 	cirrus_fbdev_fini(cdev);
-
-	if (cdev->mode_info.mode_config_initialized) {
-		drm_helper_force_disable_all(cdev->dev);
-		drm_mode_config_cleanup(cdev->dev);
-		cdev->mode_info.mode_config_initialized = false;
-	}
+	drm_helper_force_disable_all(cdev->dev);
+	drm_mode_config_cleanup(cdev->dev);
 }
-- 
2.18.1
