From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 3/3] drm: switch drm_fb_xrgb8888_to_rgb888_dstclip to
	accept __iomem dst
Date: Wed, 10 Apr 2019 08:38:15 +0200
Message-ID: <20190410063815.17062-4-kraxel__16923.7348179863$1554878327$gmane$org@redhat.com>
References: <20190410063815.17062-1-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190410063815.17062-1-kraxel@redhat.com>
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
Cc: David Airlie <airlied@linux.ie>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, open list <linux-kernel@vger.kernel.org>, "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" <virtualization@lists.linux-foundation.org>, Maxime Ripard <maxime.ripard@bootlin.com>, Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Sean Paul <sean@poorly.run>
List-Id: virtualization@lists.linuxfoundation.org

Not all archs have the __io_virt() macro, so cirrus can't simply convert
pointers that way.  The drm format helpers have to use memcpy_toio()
instead.

This patch makes drm_fb_xrgb8888_to_rgb888_dstclip() accept a __iomem
dst pointer and use memcpy_toio() instead of memcpy().  The helper
function (drm_fb_xrgb8888_to_rgb888_line) has been changed to process a
single scanline.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_format_helper.h     |  2 +-
 drivers/gpu/drm/cirrus/cirrus.c     |  2 +-
 drivers/gpu/drm/drm_format_helper.c | 57 +++++++++++++----------------
 3 files changed, 27 insertions(+), 34 deletions(-)

diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index d1b8a9ea01b4..1594a1f967ad 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -26,7 +26,7 @@ void drm_fb_xrgb8888_to_rgb565(void *dst, void *vaddr,
 void drm_fb_xrgb8888_to_rgb565_dstclip(void __iomem *dst, unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip, bool swap);
-void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
+void drm_fb_xrgb8888_to_rgb888_dstclip(void __iomem *dst, unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip);
 void drm_fb_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index ed2f2d8cfb6f..be4ea370ba31 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -316,7 +316,7 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
 						  vmap, fb, rect, false);
 
 	else if (fb->format->cpp[0] == 4 && cirrus->cpp == 3)
-		drm_fb_xrgb8888_to_rgb888_dstclip(__io_virt(cirrus->vram),
+		drm_fb_xrgb8888_to_rgb888_dstclip(cirrus->vram,
 						  cirrus->pitch,
 						  vmap, fb, rect);
 
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index c9521af4e90b..dd9823e3a723 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -216,33 +216,16 @@ void drm_fb_xrgb8888_to_rgb565_dstclip(void __iomem *dst, unsigned int dst_pitch
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565_dstclip);
 
-static void drm_fb_xrgb8888_to_rgb888_lines(void *dst, unsigned int dst_pitch,
-					    void *src, unsigned int src_pitch,
-					    unsigned int src_linelength,
-					    unsigned int lines)
+static void drm_fb_xrgb8888_to_rgb888_line(u8 *dbuf, u32 *sbuf,
+					   unsigned int pixels)
 {
-	unsigned int linepixels = src_linelength / 3;
-	unsigned int x, y;
-	u32 *sbuf;
-	u8 *dbuf;
+	unsigned int x;
 
-	sbuf = kmalloc(src_linelength, GFP_KERNEL);
-	if (!sbuf)
-		return;
-
-	for (y = 0; y < lines; y++) {
-		memcpy(sbuf, src, src_linelength);
-		dbuf = dst;
-		for (x = 0; x < linepixels; x++) {
-			*dbuf++ = (sbuf[x] & 0x000000FF) >>  0;
-			*dbuf++ = (sbuf[x] & 0x0000FF00) >>  8;
-			*dbuf++ = (sbuf[x] & 0x00FF0000) >> 16;
-		}
-		src += src_pitch;
-		dst += dst_pitch;
+	for (x = 0; x < pixels; x++) {
+		*dbuf++ = (sbuf[x] & 0x000000FF) >>  0;
+		*dbuf++ = (sbuf[x] & 0x0000FF00) >>  8;
+		*dbuf++ = (sbuf[x] & 0x00FF0000) >> 16;
 	}
-
-	kfree(sbuf);
 }
 
 /**
@@ -264,15 +247,25 @@ void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip)
 {
-	unsigned int src_offset = (clip->y1 * fb->pitches[0])
-		+ (clip->x1 * sizeof(u32));
-	unsigned int dst_offset = (clip->y1 * dst_pitch)
-		+ (clip->x1 * 3);
-	size_t src_len = (clip->x2 - clip->x1) * sizeof(u32);
+	size_t linepixels = clip->x2 - clip->x1;
+	size_t dst_len = linepixels * 3;
+	unsigned y, lines = clip->y2 - clip->y1;
+	void *dbuf;
 
-	drm_fb_xrgb8888_to_rgb888_lines(dst + dst_offset, dst_pitch,
-					vaddr + src_offset, fb->pitches[0],
-					src_len, clip->y2 - clip->y1);
+	dbuf = kmalloc(dst_len, GFP_KERNEL);
+	if (!dbuf)
+		return;
+
+	vaddr += clip_offset(clip, fb->pitches[0], sizeof(u32));
+	dst += clip_offset(clip, dst_pitch, sizeof(u16));
+	for (y = 0; y < lines; y++) {
+		drm_fb_xrgb8888_to_rgb888_line(dbuf, vaddr, linepixels);
+		memcpy_toio(dst, dbuf, dst_len);
+		vaddr += fb->pitches[0];
+		dst += dst_len;
+	}
+
+	kfree(dbuf);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb888_dstclip);
 
-- 
2.18.1
