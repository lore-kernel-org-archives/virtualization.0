From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/2] drm/bochs: fix framebuffer setup.
Date: Wed, 26 Jun 2019 08:55:51 +0200
Message-ID: <20190626065551.12956-3-kraxel__42132.743883279$1561532169$gmane$org@redhat.com>
References: <20190626065551.12956-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190626065551.12956-1-kraxel@redhat.com>
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

If bo->width doesn't match fb->width the driver fails to configure
the display correctly, resulting in a scrambled display.  Fix it.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     |  2 +-
 drivers/gpu/drm/bochs/bochs_hw.c  | 13 +++++++++----
 drivers/gpu/drm/bochs/bochs_kms.c |  1 +
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index cc35d492142c..78c0283496cc 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -86,7 +86,7 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 void bochs_hw_setformat(struct bochs_device *bochs,
 			const struct drm_format_info *format);
 void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, u64 addr);
+		      int x, int y, int fbwidth, u64 addr);
 int bochs_hw_load_edid(struct bochs_device *bochs);
 
 /* bochs_mm.c */
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 791ab2f79947..141aa02962d3 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -255,16 +255,21 @@ void bochs_hw_setformat(struct bochs_device *bochs,
 }
 
 void bochs_hw_setbase(struct bochs_device *bochs,
-		      int x, int y, u64 addr)
+		      int x, int y, int fbwidth, u64 addr)
 {
-	unsigned long offset = (unsigned long)addr +
+	unsigned long offset;
+	unsigned int vx, vy;
+
+	bochs->stride = fbwidth * (bochs->bpp / 8);
+	offset = (unsigned long)addr +
 		y * bochs->stride +
 		x * (bochs->bpp / 8);
-	int vy = offset / bochs->stride;
-	int vx = (offset % bochs->stride) * 8 / bochs->bpp;
+	vy = offset / bochs->stride;
+	vx = (offset % bochs->stride) * 8 / bochs->bpp;
 
 	DRM_DEBUG_DRIVER("x %d, y %d, addr %llx -> offset %lx, vx %d, vy %d\n",
 			 x, y, addr, offset, vx, vy);
+	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, fbwidth);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
 }
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index 5904eddc83a5..1f6aa11a1dc9 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -36,6 +36,7 @@ static void bochs_plane_update(struct bochs_device *bochs,
 	bochs_hw_setbase(bochs,
 			 state->crtc_x,
 			 state->crtc_y,
+			 gbo->width,
 			 gbo->bo.offset);
 	bochs_hw_setformat(bochs, state->fb->format);
 }
-- 
2.18.1
