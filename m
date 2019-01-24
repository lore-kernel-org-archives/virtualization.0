From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 19/26] drm/qxl: Use drm_fb_helper_fill_info
Date: Thu, 24 Jan 2019 17:58:24 +0100
Message-ID: <20190124165831.16427-20-daniel.vetter@ffwll.ch>
References: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190124165831.16427-1-daniel.vetter@ffwll.ch>
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
Cc: spice-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, virtualization@lists.linux-foundation.org, Daniel Vetter <daniel.vetter@intel.com>, Dave Airlie <airlied@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

This should not result in any changes.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: spice-devel@lists.freedesktop.org
---
 drivers/gpu/drm/qxl/qxl_fb.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_fb.c b/drivers/gpu/drm/qxl/qxl_fb.c
index d028471597ef..22dc9a7a643b 100644
--- a/drivers/gpu/drm/qxl/qxl_fb.c
+++ b/drivers/gpu/drm/qxl/qxl_fb.c
@@ -219,8 +219,6 @@ static int qxlfb_create(struct drm_fb_helper *helper,
 		goto out_unref;
 	}
 
-	info->par = helper;
-
 	fb = drm_gem_fbdev_fb_create(&qdev->ddev, sizes, 64, gobj,
 				     &qxlfb_fb_funcs);
 	if (IS_ERR(fb)) {
@@ -232,10 +230,6 @@ static int qxlfb_create(struct drm_fb_helper *helper,
 	/* setup helper with fb data */
 	qdev->fb_helper.fb = fb;
 
-	strcpy(info->fix.id, "qxldrmfb");
-
-	drm_fb_helper_fill_fix(info, fb->pitches[0], fb->format->depth);
-
 	info->fbops = &qxlfb_ops;
 
 	/*
@@ -247,8 +241,7 @@ static int qxlfb_create(struct drm_fb_helper *helper,
 	info->screen_base = shadow;
 	info->screen_size = gobj->size;
 
-	drm_fb_helper_fill_var(info, &qdev->fb_helper, sizes->fb_width,
-			       sizes->fb_height);
+	drm_fb_helper_fill_info(info, &qdev->fb_helper);
 
 	/* setup aperture base/size for vesafb takeover */
 	info->apertures->ranges[0].base = qdev->ddev.mode_config.fb_base;
-- 
2.20.1
