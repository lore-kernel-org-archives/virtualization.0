From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 2/5] drm/bochs: pass framebuffer to bochs_hw_setbase
Date: Thu, 27 Jun 2019 14:23:45 +0200
Message-ID: <20190627122348.5833-3-kraxel__49944.3050635577$1561638269$gmane$org@redhat.com>
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

Also rename to bochs_hw_setfb, we have to set more
than just the base address.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     |  5 +++--
 drivers/gpu/drm/bochs/bochs_hw.c  | 10 +++++-----
 drivers/gpu/drm/bochs/bochs_kms.c | 10 +++-------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index cc35d492142c..246f05f4a711 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -85,8 +85,9 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 		      struct drm_display_mode *mode);
 void bochs_hw_setformat(struct bochs_device *bochs,
 			const struct drm_format_info *format);
-void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, u64 addr);
+void bochs_hw_setfb(struct bochs_device *bochs,
+		    struct drm_framebuffer *fb,
+		    int x, int y);
 int bochs_hw_load_edid(struct bochs_device *bochs);
 
 /* bochs_mm.c */
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 791ab2f79947..67101c85029c 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -254,17 +254,17 @@ void bochs_hw_setformat(struct bochs_device *bochs,
 	};
 }
 
-void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, u64 addr)
+void bochs_hw_setfb(struct bochs_device *bochs,
+		    struct drm_framebuffer *fb,
+		    int x, int y)
 {
-	unsigned long offset = (unsigned long)addr +
+	struct drm_gem_vram_object *bo = drm_gem_vram_of_gem(fb->obj[0]);
+	unsigned long offset = bo->bo.offset +
 		y * bochs->stride +
 		x * (bochs->bpp / 8);
 	int vy = offset / bochs->stride;
 	int vx = (offset % bochs->stride) * 8 / bochs->bpp;
 
-	DRM_DEBUG_DRIVER("x %d, y %d, addr %llx -> offset %lx, vx %d, vy %d\n",
-			 x, y, addr, offset, vx, vy);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
 }
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 5904eddc83a5..ddbf0802138d 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -27,16 +27,12 @@ static const uint32_t bochs_formats[] = {
 static void bochs_plane_update(struct bochs_device *bochs,
 			       struct drm_plane_state *state)
 {
-	struct drm_gem_vram_object *gbo;
-
 	if (!state->fb || !bochs->stride)
 		return;
 
-	gbo = drm_gem_vram_of_gem(state->fb->obj[0]);
-	bochs_hw_setbase(bochs,
-			 state->crtc_x,
-			 state->crtc_y,
-			 gbo->bo.offset);
+	bochs_hw_setfb(bochs, state->fb,
+		       state->crtc_x,
+		       state->crtc_y);
 	bochs_hw_setformat(bochs, state->fb->format);
 }
 
-- 
2.18.1
