From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 3/3] drm/cirrus: add missing drm_helper_force_disable_all()
	call.
Date: Mon,  1 Apr 2019 16:03:06 +0200
Message-ID: <20190401140306.28063-4-kraxel__11945.2523345657$1554127429$gmane$org@redhat.com>
References: <20190401140306.28063-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190401140306.28063-1-kraxel@redhat.com>
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
 drivers/gpu/drm/cirrus/cirrus_mode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/cirrus/cirrus_mode.c b/drivers/gpu/drm/cirrus/cirrus_mode.c
index 7f9bc32af685..32ce2c1040b4 100644
--- a/drivers/gpu/drm/cirrus/cirrus_mode.c
+++ b/drivers/gpu/drm/cirrus/cirrus_mode.c
@@ -615,6 +615,7 @@ void cirrus_modeset_fini(struct cirrus_device *cdev)
 	cirrus_fbdev_fini(cdev);
 
 	if (cdev->mode_info.mode_config_initialized) {
+		drm_helper_force_disable_all(cdev->dev);
 		drm_mode_config_cleanup(cdev->dev);
 		cdev->mode_info.mode_config_initialized = false;
 	}
-- 
2.18.1
