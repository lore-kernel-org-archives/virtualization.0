From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 01/15] drm/bochs: encoder cleanup
Date: Thu, 10 Jan 2019 09:28:31 +0100
Message-ID: <20190110082845.3453-2-kraxel__38906.2497685247$1547108830$gmane$org@redhat.com>
References: <20190110082845.3453-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190110082845.3453-1-kraxel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>
Cc: andr2000@gmail.com, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Most unused callbacks can be NULL pointers these days.
Drop a bunch of empty encoder callbacks.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs_kms.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index f87c284dd9..c8ce54498d 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -170,31 +170,6 @@ static void bochs_crtc_init(struct drm_device *dev)
 	drm_crtc_helper_add(crtc, &bochs_helper_funcs);
 }
 
-static void bochs_encoder_mode_set(struct drm_encoder *encoder,
-				   struct drm_display_mode *mode,
-				   struct drm_display_mode *adjusted_mode)
-{
-}
-
-static void bochs_encoder_dpms(struct drm_encoder *encoder, int state)
-{
-}
-
-static void bochs_encoder_prepare(struct drm_encoder *encoder)
-{
-}
-
-static void bochs_encoder_commit(struct drm_encoder *encoder)
-{
-}
-
-static const struct drm_encoder_helper_funcs bochs_encoder_helper_funcs = {
-	.dpms = bochs_encoder_dpms,
-	.mode_set = bochs_encoder_mode_set,
-	.prepare = bochs_encoder_prepare,
-	.commit = bochs_encoder_commit,
-};
-
 static const struct drm_encoder_funcs bochs_encoder_encoder_funcs = {
 	.destroy = drm_encoder_cleanup,
 };
@@ -207,7 +182,6 @@ static void bochs_encoder_init(struct drm_device *dev)
 	encoder->possible_crtcs = 0x1;
 	drm_encoder_init(dev, encoder, &bochs_encoder_encoder_funcs,
 			 DRM_MODE_ENCODER_DAC, NULL);
-	drm_encoder_helper_add(encoder, &bochs_encoder_helper_funcs);
 }
 
 
-- 
2.9.3
