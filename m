From: Colin King <colin.king@canonical.com>
Subject: [PATCH] drm/virtgpu: remove redundant assignments to width and height
Date: Wed,  1 Jul 2020 14:41:54 +0100
Message-ID: <20200701134154.549112-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

From: Colin Ian King <colin.king@canonical.com>

Variables width and height are being assigned values that are never
read. The assignments are redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index f3ce49c5a34c..bf80d8c23da7 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -165,8 +165,6 @@ static int virtio_gpu_conn_get_modes(struct drm_connector *connector)
 	count = drm_add_modes_noedid(connector, XRES_MAX, YRES_MAX);
 
 	if (width == 0 || height == 0) {
-		width = XRES_DEF;
-		height = YRES_DEF;
 		drm_set_preferred_mode(connector, XRES_DEF, YRES_DEF);
 	} else {
 		DRM_DEBUG("add mode: %dx%d\n", width, height);
-- 
2.27.0
