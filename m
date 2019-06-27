From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 4/5] drm/bochs: drop stride and bpp from struct bochs_device
Date: Thu, 27 Jun 2019 14:23:47 +0200
Message-ID: <20190627122348.5833-5-kraxel__36612.8260780656$1561638260$gmane$org@redhat.com>
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

No need to store that, struct drm_framebuffer has all we need.

Also update VBE_DISPI_INDEX_VIRT_WIDTH register, otherwise we'll
have a fixes broken display in case pitch != width * cpp.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h     |  2 --
 drivers/gpu/drm/bochs/bochs_hw.c  | 18 +++++++++---------
 drivers/gpu/drm/bochs/bochs_kms.c |  2 +-
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 5c90b76708ef..4081b3aba28d 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -64,8 +64,6 @@ struct bochs_device {
 	/* mode */
 	u16 xres;
 	u16 yres;
-	u32 stride;
-	u32 bpp;
 	struct edid *edid;
 
 	/* drm */
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 9ab6ec269ef9..178715c6755d 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -205,16 +205,14 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 {
 	bochs->xres = mode->hdisplay;
 	bochs->yres = mode->vdisplay;
-	bochs->bpp = 32;
-	bochs->stride = mode->hdisplay * (bochs->bpp / 8);
 
-	DRM_DEBUG_DRIVER("%dx%d @ %d bpp\n",
-			 bochs->xres, bochs->yres, bochs->bpp);
+	DRM_DEBUG_DRIVER("%dx%d\n",
+			 bochs->xres, bochs->yres);
 
 	bochs_vga_writeb(bochs, 0x3c0, 0x20); /* unblank */
 
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_ENABLE,      0);
-	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BPP,         bochs->bpp);
+	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BPP,         32);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_XRES,        bochs->xres);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_YRES,        bochs->yres);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BANK,        0);
@@ -256,11 +254,13 @@ void bochs_hw_setfb(struct bochs_device *bochs,
 {
 	struct drm_gem_vram_object *bo = drm_gem_vram_of_gem(fb->obj[0]);
 	unsigned long offset = bo->bo.offset +
-		y * bochs->stride +
-		x * (bochs->bpp / 8);
-	int vy = offset / bochs->stride;
-	int vx = (offset % bochs->stride) * 8 / bochs->bpp;
+		y * fb->pitches[0] +
+		x * fb->format->cpp[0];
+	int vy = offset / fb->pitches[0];
+	int vx = (offset % fb->pitches[0]) / fb->format->cpp[0];
+	int vw = fb->pitches[0] / fb->format->cpp[0];
 
+	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH, vw);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET, vx);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET, vy);
 }
diff --git a/drivers/gpu/drm/bochs/bochs_kms.c b/drivers/gpu/drm/bochs/bochs_kms.c
index ddbf0802138d..28edfb2772ff 100644
--- a/drivers/gpu/drm/bochs/bochs_kms.c
+++ b/drivers/gpu/drm/bochs/bochs_kms.c
@@ -27,7 +27,7 @@ static const uint32_t bochs_formats[] = {
 static void bochs_plane_update(struct bochs_device *bochs,
 			       struct drm_plane_state *state)
 {
-	if (!state->fb || !bochs->stride)
+	if (!state->fb)
 		return;
 
 	bochs_hw_setfb(bochs, state->fb,
-- 
2.18.1
