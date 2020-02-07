From: Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 6/6] drm/simple-pipe: Use simple encoder
Date: Fri,  7 Feb 2020 09:41:35 +0100
Message-ID: <20200207084135.4524-7-tzimmermann@suse.de>
References: <20200207084135.4524-1-tzimmermann@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200207084135.4524-1-tzimmermann@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, kraxel@redhat.com, noralf@tronnes.org, sam@ravnborg.org, alexander.deucher@amd.com, emil.velikov@collabora.com
Cc: spice-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The simple-pipe helpers use an empty implementation for the encoder.
Replace the code with the generic simple encoder.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 15fb516ae2d8..e16606b3ee20 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -28,10 +28,6 @@
  * encoder drivers.
  */
 
-static const struct drm_encoder_funcs drm_simple_kms_encoder_funcs = {
-	.destroy = drm_encoder_cleanup,
-};
-
 static enum drm_mode_status
 drm_simple_kms_crtc_mode_valid(struct drm_crtc *crtc,
 			       const struct drm_display_mode *mode)
@@ -288,8 +284,8 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
 		return ret;
 
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
-	ret = drm_encoder_init(dev, encoder, &drm_simple_kms_encoder_funcs,
-			       DRM_MODE_ENCODER_NONE, NULL);
+	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_NONE,
+				      NULL);
 	if (ret || !connector)
 		return ret;
 
-- 
2.25.0
