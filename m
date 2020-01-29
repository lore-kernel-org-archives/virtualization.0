From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v5 15/15] drm/xen: Explicitly disable automatic sending of
 vblank event
Date: Wed, 29 Jan 2020 13:05:31 +0100
Message-ID: <20200129120531.6891-16-tzimmermann@suse.de>
References: <20200129120531.6891-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200129120531.6891-1-tzimmermann@suse.de>
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
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, xen-devel@lists.xenproject.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The atomic helpers automatically send out fake VBLANK events if no
vblanking has been initialized. This would apply to xen, but xen has
its own vblank logic. To avoid interfering with the atomic helpers,
disable automatic vblank events explicitly.

v5:
	* update comment
v4:
	* separate commit from core vblank changes

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/xen/xen_drm_front_kms.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xen/xen_drm_front_kms.c
index 4f34c5208180..78096bbcd226 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
@@ -220,6 +220,24 @@ static bool display_send_page_flip(struct drm_simple_display_pipe *pipe,
 	return false;
 }
 
+static int display_check(struct drm_simple_display_pipe *pipe,
+			 struct drm_plane_state *plane_state,
+			 struct drm_crtc_state *crtc_state)
+{
+	/*
+	 * Xen doesn't initialize vblanking via drm_vblank_init(), so
+	 * DRM helpers assume that it doesn't handle vblanking and start
+	 * sending out fake VBLANK events automatically.
+	 *
+	 * As xen contains it's own logic for sending out VBLANK events
+	 * in send_pending_event(), disable no_vblank (i.e., the xen
+	 * driver has vblanking support).
+	 */
+	crtc_state->no_vblank = false;
+
+	return 0;
+}
+
 static void display_update(struct drm_simple_display_pipe *pipe,
 			   struct drm_plane_state *old_plane_state)
 {
@@ -284,6 +302,7 @@ static const struct drm_simple_display_pipe_funcs display_funcs = {
 	.enable = display_enable,
 	.disable = display_disable,
 	.prepare_fb = drm_gem_fb_simple_display_pipe_prepare_fb,
+	.check = display_check,
 	.update = display_update,
 };
 
-- 
2.25.0
