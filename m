From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2] drm/bochs: fix framebuffer setup.
Date: Thu, 27 Jun 2019 10:12:06 +0200
Message-ID: <20190627081206.23135-1-kraxel__37483.6568882287$1561623154$gmane$org@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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

The driver doesn't consider framebuffer pitch and offset, leading to a
wrong display in case offset != 0 or pitch != width * bpp.  Fix it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     |  2 +-
 drivers/gpu/drm/bochs/bochs_hw.c  | 14 ++++++++++----
 drivers/gpu/drm/bochs/bochs_kms.c |  3 ++-
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index cc35d492142c..2a65434500ee 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -86,7 +86,7 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 void bochs_hw_setformat(struct bochs_device *bochs,
 			const struct drm_format_info *format);
 void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, u64 addr);
+		      int x, int y, int stride, u64 addr);
 int bochs_hw_load_edid(struct bochs_device *bochs);
 
 /* bochs_mm.c */
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 791ab2f79947..ebfea8744fe6 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -255,16 +255,22 @@ void bochs_hw_setformat(struct bochs_device *bochs,
 }
 
 void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, u64 addr)
+		      int x, int y, int stride, u64 addr)
 {
-	unsigned long offset = (unsigned long)addr +
+	unsigned long offset;
+	unsigned int vx, vy, vwidth;
+
+	bochs->stride = stride;
+	offset = (unsigned long)addr +
 		y * bochs->stride +
 		x * (bochs->bpp / 8);
-	int vy = offset / bochs->stride;
-	int vx = (offset % bochs->stride) * 8 / bochs->bpp;
+	vy = offset / bochs->stride;
+	vx = (offset % bochs->stride) * 8 / bochs->bpp;
+	vwidth = stride * 8 / bochs->bpp;
 
 	DRM_DEBUG_DRIVER("x %d, y %d, addr %llx -> offset %lx, vx %d, vy %d\n",
 			 x, y, addr, offset, vx, vy);
+	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, vwidth);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
 }
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 5904eddc83a5..bc19dbd531ef 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -36,7 +36,8 @@ static void bochs_plane_update(struct bochs_device *bochs,
 	bochs_hw_setbase(bochs,
 			 state->crtc_x,
 			 state->crtc_y,
-			 gbo->bo.offset);
+			 state->fb->pitches[0],
+			 state->fb->offsets[0] + gbo->bo.offset);
 	bochs_hw_setformat(bochs, state->fb->format);
 }
 
-- 
2.18.1
