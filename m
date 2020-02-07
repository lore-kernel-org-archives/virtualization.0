From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/bochs: deinit bugfix
Date: Fri,  7 Feb 2020 13:43:48 +0100
Message-ID: <20200207124348.21641-1-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:DRM DRIVER FOR
        BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Check whenever mode_config was actually properly
initialized before trying to clean it up.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index cc93ff74fbd8..3a755c911342 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -164,6 +164,9 @@ int bochs_kms_init(struct bochs_device *bochs)
 
 void bochs_kms_fini(struct bochs_device *bochs)
 {
+	if (!bochs->dev->mode_config.num_connector)
+		return;
+
 	drm_atomic_helper_shutdown(bochs->dev);
 	drm_mode_config_cleanup(bochs->dev);
 }
-- 
2.18.1
