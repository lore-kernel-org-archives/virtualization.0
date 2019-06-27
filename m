From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 5/5] drm/bochs: move bochs_hw_setformat() call
Date: Thu, 27 Jun 2019 14:23:48 +0200
Message-ID: <20190627122348.5833-6-kraxel__42251.8682711356$1561638276$gmane$org@redhat.com>
References: <20190627122348.5833-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190627122348.5833-1-kraxel@redhat.com>
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
Cc: tzimmermann@suse.de, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" <virtualization@lists.linux-foundation.org>, Daniel Vetter <daniel@ffwll.ch>
List-Id: virtualization@lists.linuxfoundation.org

Call it from bochs_hw_setfb().
This also allows to make bochs_hw_setformat static.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     | 2 --
 drivers/gpu/drm/bochs/bochs_hw.c  | 5 +++--
 drivers/gpu/drm/bochs/bochs_kms.c | 1 -
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 4081b3aba28d..528b8e8dde40 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -80,8 +80,6 @@ void bochs_hw_fini(struct drm_device *dev);
 
 void bochs_hw_setmode(struct bochs_device *bochs,
 		      struct drm_display_mode *mode);
-void bochs_hw_setformat(struct bochs_device *bochs,
-			const struct drm_format_info *format);
 void bochs_hw_setfb(struct bochs_device *bochs,
 		    struct drm_framebuffer *fb,
 		    int x, int y);
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 178715c6755d..daa4fda3d322 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -224,8 +224,8 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 			  VBE_DISPI_ENABLED | VBE_DISPI_LFB_ENABLED);
 }
 
-void bochs_hw_setformat(struct bochs_device *bochs,
-			const struct drm_format_info *format)
+static void bochs_hw_setformat(struct bochs_device *bochs,
+			       const struct drm_format_info *format)
 {
 	DRM_DEBUG_DRIVER("format %c%c%c%c\n",
 			 (format->format >>  0) & 0xff,
@@ -263,4 +263,5 @@ void bochs_hw_setfb(struct bochs_device *bochs,
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, vw);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
+	bochs_hw_setformat(bochs, fb->format);
 }
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 28edfb2772ff..368803bd12e5 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -33,7 +33,6 @@ static void bochs_plane_update(struct bochs_device *bochs,
 	bochs_hw_setfb(bochs, state->fb,
 		       state->crtc_x,
 		       state->crtc_y);
-	bochs_hw_setformat(bochs, state->fb->format);
 }
 
 static void bochs_pipe_enable(struct drm_simple_display_pipe *pipe,
-- 
2.18.1
