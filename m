From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v4 02/16] drm/bochs: split bochs_hw_setmode
Date: Fri, 11 Jan 2019 06:37:38 +0100
Message-ID: <20190111053752.4004-3-kraxel__21637.4044226997$1547692751$gmane$org@redhat.com>
References: <20190111053752.4004-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190111053752.4004-1-kraxel@redhat.com>
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
Cc: andr2000@gmail.com, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, David Airlie <airlied@linux.ie>, noralf@tronnes.org
List-Id: virtualization@lists.linuxfoundation.org

Create a separate bochs_hw_setformat function to configure
the framebuffer format (actually just the byteorder).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/bochs/bochs.h     |  5 +++--
 drivers/gpu/drm/bochs/bochs_hw.c  | 19 ++++++++++++-------
 drivers/gpu/drm/bochs/bochs_kms.c |  3 ++-
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index fb38c8b857..4dc1b6384e 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -121,8 +121,9 @@ int bochs_hw_init(struct drm_device *dev);
 void bochs_hw_fini(struct drm_device *dev);
 
 void bochs_hw_setmode(struct bochs_device *bochs,
-		      struct drm_display_mode *mode,
-		      const struct drm_format_info *format);
+		      struct drm_display_mode *mode);
+void bochs_hw_setformat(struct bochs_device *bochs,
+			const struct drm_format_info *format);
 void bochs_hw_setbase(struct bochs_device *bochs,
 		      int x, int y, u64 addr);
 int bochs_hw_load_edid(struct bochs_device *bochs);
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index d0b4e1cee8..3e04b2f0ec 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -204,8 +204,7 @@ void bochs_hw_fini(struct drm_device *dev)
 }
 
 void bochs_hw_setmode(struct bochs_device *bochs,
-		      struct drm_display_mode *mode,
-		      const struct drm_format_info *format)
+		      struct drm_display_mode *mode)
 {
 	bochs->xres = mode->hdisplay;
 	bochs->yres = mode->vdisplay;
@@ -213,12 +212,8 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 	bochs->stride = mode->hdisplay * (bochs->bpp / 8);
 	bochs->yres_virtual = bochs->fb_size / bochs->stride;
 
-	DRM_DEBUG_DRIVER("%dx%d @ %d bpp, format %c%c%c%c, vy %d\n",
+	DRM_DEBUG_DRIVER("%dx%d @ %d bpp, vy %d\n",
 			 bochs->xres, bochs->yres, bochs->bpp,
-			 (format->format >>  0) & 0xff,
-			 (format->format >>  8) & 0xff,
-			 (format->format >> 16) & 0xff,
-			 (format->format >> 24) & 0xff,
 			 bochs->yres_virtual);
 
 	bochs_vga_writeb(bochs, 0x3c0, 0x20); /* unblank */
@@ -236,6 +231,16 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_ENABLE,
 			  VBE_DISPI_ENABLED | VBE_DISPI_LFB_ENABLED);
+}
+
+void bochs_hw_setformat(struct bochs_device *bochs,
+			const struct drm_format_info *format)
+{
+	DRM_DEBUG_DRIVER("format %c%c%c%c\n",
+			 (format->format >>  0) & 0xff,
+			 (format->format >>  8) & 0xff,
+			 (format->format >> 16) & 0xff,
+			 (format->format >> 24) & 0xff);
 
 	switch (format->format) {
 	case DRM_FORMAT_XRGB8888:
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index c8ce54498d..f7e6d1a9b3 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -80,7 +80,8 @@ static int bochs_crtc_mode_set(struct drm_crtc *crtc,
 	if (WARN_ON(crtc->primary->fb == NULL))
 		return -EINVAL;
 
-	bochs_hw_setmode(bochs, mode, crtc->primary->fb->format);
+	bochs_hw_setmode(bochs, mode);
+	bochs_hw_setformat(bochs, crtc->primary->fb->format);
 	bochs_crtc_mode_set_base(crtc, x, y, old_fb);
 	return 0;
 }
-- 
2.9.3
