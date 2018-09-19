From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 3/5] drm/bochs: fix DRM_FORMAT_* handling for big endian
	machines.
Date: Wed, 19 Sep 2018 13:12:50 +0200
Message-ID: <20180919111252.7932-4-kraxel__19468.2261361324$1537355470$gmane$org@redhat.com>
References: <20180919111252.7932-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180919111252.7932-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, michel@daenzer.net, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, imirkin@alum.mit.edu
List-Id: virtualization@lists.linuxfoundation.org

Use DRM_FORMAT_HOST_XRGB8888, so we are using the correct format code
on bigendian machines.  Also set the quirk_addfb_prefer_host_byte_order
mode_config bit so drm_mode_addfb() asks for the correct format code.

Create our own plane and use drm_crtc_init_with_planes() instead of
depending on the default created by drm_crtc_init().  That way the plane
format list is correct on bigendian machines.

Also re-add the framebuffer format check dropped by "df2052cc92 bochs:
convert to drm_fb_helper_fbdev_setup/teardown".

With this patch applied both ADDFB and ADDFB2 ioctls work correctly in
the bochs-drm.ko driver on big endian machines.  Without the patch only
ADDFB (which still seems to be used by the majority of userspace) works
correctly.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs_fbdev.c | 17 +++++++++++++----
 drivers/gpu/drm/bochs/bochs_kms.c   | 34 +++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_fbdev.c b/drivers/gpu/drm/bochs/bochs_fbdev.c
index 8f4d6c052f..c46fdae44e 100644
--- a/drivers/gpu/drm/bochs/bochs_fbdev.c
+++ b/drivers/gpu/drm/bochs/bochs_fbdev.c
@@ -63,9 +63,8 @@ static int bochsfb_create(struct drm_fb_helper *helper,
 
 	mode_cmd.width = sizes->surface_width;
 	mode_cmd.height = sizes->surface_height;
-	mode_cmd.pitches[0] = mode_cmd.width * ((sizes->surface_bpp + 7) / 8);
-	mode_cmd.pixel_format = drm_mode_legacy_fb_format(sizes->surface_bpp,
-							  sizes->surface_depth);
+	mode_cmd.pitches[0] = sizes->surface_width * 4;
+	mode_cmd.pixel_format = DRM_FORMAT_HOST_XRGB8888;
 	size = mode_cmd.pitches[0] * mode_cmd.height;
 
 	/* alloc, pin & map bo */
@@ -137,8 +136,18 @@ static const struct drm_fb_helper_funcs bochs_fb_helper_funcs = {
 	.fb_probe = bochsfb_create,
 };
 
+static struct drm_framebuffer *
+bochs_gem_fb_create(struct drm_device *dev, struct drm_file *file,
+		    const struct drm_mode_fb_cmd2 *mode_cmd)
+{
+	if (mode_cmd->pixel_format != DRM_FORMAT_HOST_XRGB8888)
+		return ERR_PTR(-EINVAL);
+
+	return drm_gem_fb_create(dev, file, mode_cmd);
+}
+
 const struct drm_mode_config_funcs bochs_mode_funcs = {
-	.fb_create = drm_gem_fb_create,
+	.fb_create = bochs_gem_fb_create,
 };
 
 int bochs_fbdev_init(struct bochs_device *bochs)
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index ea9a43d31b..f3fdaf9456 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -126,12 +126,43 @@ static const struct drm_crtc_helper_funcs bochs_helper_funcs = {
 	.commit = bochs_crtc_commit,
 };
 
+static const uint32_t bochs_formats[] = {
+	DRM_FORMAT_HOST_XRGB8888,
+};
+
+static struct drm_plane *bochs_primary_plane(struct drm_device *dev)
+{
+	struct drm_plane *primary;
+	int ret;
+
+	primary = kzalloc(sizeof(*primary), GFP_KERNEL);
+	if (primary == NULL) {
+		DRM_DEBUG_KMS("Failed to allocate primary plane\n");
+		return NULL;
+	}
+
+	ret = drm_universal_plane_init(dev, primary, 0,
+				       &drm_primary_helper_funcs,
+				       bochs_formats,
+				       ARRAY_SIZE(bochs_formats),
+				       NULL,
+				       DRM_PLANE_TYPE_PRIMARY, NULL);
+	if (ret) {
+		kfree(primary);
+		primary = NULL;
+	}
+
+	return primary;
+}
+
 static void bochs_crtc_init(struct drm_device *dev)
 {
 	struct bochs_device *bochs = dev->dev_private;
 	struct drm_crtc *crtc = &bochs->crtc;
+	struct drm_plane *primary = bochs_primary_plane(dev);
 
-	drm_crtc_init(dev, crtc, &bochs_crtc_funcs);
+	drm_crtc_init_with_planes(dev, crtc, primary, NULL,
+				  &bochs_crtc_funcs, NULL);
 	drm_crtc_helper_add(crtc, &bochs_helper_funcs);
 }
 
@@ -250,6 +281,7 @@ int bochs_kms_init(struct bochs_device *bochs)
 	bochs->dev->mode_config.fb_base = bochs->fb_base;
 	bochs->dev->mode_config.preferred_depth = 24;
 	bochs->dev->mode_config.prefer_shadow = 0;
+	bochs->dev->mode_config.quirk_addfb_prefer_host_byte_order = true;
 
 	bochs->dev->mode_config.funcs = &bochs_mode_funcs;
 
-- 
2.9.3
