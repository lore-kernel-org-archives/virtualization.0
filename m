From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 4/4] drm/udl: Don't set struct drm_crtc_state.no_vblank
 explictly
Date: Mon, 20 Jan 2020 13:20:51 +0100
Message-ID: <20200120122051.25178-5-tzimmermann@suse.de>
References: <20200120122051.25178-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200120122051.25178-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: airlied@linux.ie, daniel@ffwll.ch, kraxel@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, hdegoede@redhat.com, david@lechnology.com, noralf@tronnes.org, sean@poorly.run, oleksandr_andrushchenko@epam.com, sam@ravnborg.org, laurent.pinchart@ideasonboard.com, emil.velikov@collabora.com
Cc: xen-devel@lists.xenproject.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

As udl does not initialize vblanking, atomic helpers initialize the
value of struct drm_crtc_state.no_vblank to be true. No need to set
it from within the driver.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/udl/udl_modeset.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 22af17959053..d59ebac70b15 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -375,8 +375,6 @@ udl_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 	char *wrptr;
 	int color_depth = UDL_COLOR_DEPTH_16BPP;
 
-	crtc_state->no_vblank = true;
-
 	buf = (char *)udl->mode_buf;
 
 	/* This first section has to do with setting the base address on the
@@ -428,14 +426,6 @@ udl_simple_display_pipe_disable(struct drm_simple_display_pipe *pipe)
 	udl_submit_urb(dev, urb, buf - (char *)urb->transfer_buffer);
 }
 
-static int
-udl_simple_display_pipe_check(struct drm_simple_display_pipe *pipe,
-			      struct drm_plane_state *plane_state,
-			      struct drm_crtc_state *crtc_state)
-{
-	return 0;
-}
-
 static void
 udl_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
 			       struct drm_plane_state *old_plane_state)
@@ -457,7 +447,6 @@ struct drm_simple_display_pipe_funcs udl_simple_display_pipe_funcs = {
 	.mode_valid = udl_simple_display_pipe_mode_valid,
 	.enable = udl_simple_display_pipe_enable,
 	.disable = udl_simple_display_pipe_disable,
-	.check = udl_simple_display_pipe_check,
 	.update = udl_simple_display_pipe_update,
 	.prepare_fb = drm_gem_fb_simple_display_pipe_prepare_fb,
 };
-- 
2.24.1
