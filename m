From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 3/5] drm/bochs: drop yres_virtual from struct bochs_device
Date: Thu, 27 Jun 2019 14:23:46 +0200
Message-ID: <20190627122348.5833-4-kraxel__3201.15220253996$1561638257$gmane$org@redhat.com>
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

Not needed, writing to VBE_DISPI_INDEX_VIRT_HEIGHT has no effect anyway.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/bochs/bochs.h    | 1 -
 drivers/gpu/drm/bochs/bochs_hw.c | 8 ++------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bochs/bochs.h b/drivers/gpu/drm/bochs/bochs.h
index 246f05f4a711..5c90b76708ef 100644
--- a/drivers/gpu/drm/bochs/bochs.h
+++ b/drivers/gpu/drm/bochs/bochs.h
@@ -64,7 +64,6 @@ struct bochs_device {
 	/* mode */
 	u16 xres;
 	u16 yres;
-	u16 yres_virtual;
 	u32 stride;
 	u32 bpp;
 	struct edid *edid;
diff --git a/drivers/gpu/drm/bochs/bochs_hw.c b/drivers/gpu/drm/bochs/bochs_hw.c
index 67101c85029c..9ab6ec269ef9 100644
--- a/drivers/gpu/drm/bochs/bochs_hw.c
+++ b/drivers/gpu/drm/bochs/bochs_hw.c
@@ -207,11 +207,9 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 	bochs->yres = mode->vdisplay;
 	bochs->bpp = 32;
 	bochs->stride = mode->hdisplay * (bochs->bpp / 8);
-	bochs->yres_virtual = bochs->fb_size / bochs->stride;
 
-	DRM_DEBUG_DRIVER("%dx%d @ %d bpp, vy %d\n",
-			 bochs->xres, bochs->yres, bochs->bpp,
-			 bochs->yres_virtual);
+	DRM_DEBUG_DRIVER("%dx%d @ %d bpp\n",
+			 bochs->xres, bochs->yres, bochs->bpp);
 
 	bochs_vga_writeb(bochs, 0x3c0, 0x20); /* unblank */
 
@@ -221,8 +219,6 @@ void bochs_hw_setmode(struct bochs_device *bochs,
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_YRES,        bochs->yres);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_BANK,        0);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_WIDTH,  bochs->xres);
-	bochs_dispi_write(bochs, VBE_DISPI_INDEX_VIRT_HEIGHT,
-			  bochs->yres_virtual);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_X_OFFSET,    0);
 	bochs_dispi_write(bochs, VBE_DISPI_INDEX_Y_OFFSET,    0);
 
-- 
2.18.1
