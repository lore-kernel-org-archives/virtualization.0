From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 2/3] drm: switch drm_fb_xrgb8888_to_rgb565_dstclip to
	accept __iomem dst
Date: Wed, 10 Apr 2019 08:38:14 +0200
Message-ID: <20190410063815.17062-3-kraxel__12074.5994079456$1554878350$gmane$org@redhat.com>
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

This patch makes drm_fb_xrgb8888_to_rgb565_dstclip() accept a __iomem
dst pointer and use memcpy_toio() instead of memcpy().  The helper
function (drm_fb_xrgb8888_to_rgb565_line) has been changed to process
a single scanline.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_format_helper.h     |   2 +-
 drivers/gpu/drm/cirrus/cirrus.c     |   2 +-
 drivers/gpu/drm/drm_format_helper.c | 113 ++++++++++++++--------------
 3 files changed, 60 insertions(+), 57 deletions(-)

diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index bc2e1004e166..d1b8a9ea01b4 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -23,7 +23,7 @@ void drm_fb_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
 void drm_fb_xrgb8888_to_rgb565(void *dst, void *vaddr,
 			       struct drm_framebuffer *fb,
 			       struct drm_rect *clip, bool swap);
-void drm_fb_xrgb8888_to_rgb565_dstclip(void *dst, unsigned int dst_pitch,
+void drm_fb_xrgb8888_to_rgb565_dstclip(void __iomem *dst, unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
 				       struct drm_rect *clip, bool swap);
 void drm_fb_xrgb8888_to_rgb888_dstclip(void *dst, unsigned int dst_pitch,
diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index 0fc3aa31b5a4..ed2f2d8cfb6f 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -311,7 +311,7 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
 				      vmap, fb, rect);
 
 	else if (fb->format->cpp[0] == 4 && cirrus->cpp == 2)
-		drm_fb_xrgb8888_to_rgb565_dstclip(__io_virt(cirrus->vram),
+		drm_fb_xrgb8888_to_rgb565_dstclip(cirrus->vram,
 						  cirrus->pitch,
 						  vmap, fb, rect, false);
 
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index dace05638bc3..c9521af4e90b 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -113,42 +113,22 @@ void drm_fb_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
 }
 EXPORT_SYMBOL(drm_fb_swab16);
 
-static void drm_fb_xrgb8888_to_rgb565_lines(void *dst, unsigned int dst_pitch,
-					    void *src, unsigned int src_pitch,
-					    unsigned int src_linelength,
-					    unsigned int lines,
-					    bool swap)
+static void drm_fb_xrgb8888_to_rgb565_line(u16 *dbuf, u32 *sbuf,
+					   unsigned int pixels,
+					   bool swab)
 {
-	unsigned int linepixels = src_linelength / sizeof(u32);
-	unsigned int x, y;
-	u32 *sbuf;
-	u16 *dbuf, val16;
+	unsigned int x;
+	u16 val16;
 
-	/*
-	 * The cma memory is write-combined so reads are uncached.
-	 * Speed up by fetching one line at a time.
-	 */
-	sbuf = kmalloc(src_linelength, GFP_KERNEL);
-	if (!sbuf)
-		return;
-
-	for (y = 0; y < lines; y++) {
-		memcpy(sbuf, src, src_linelength);
-		dbuf = dst;
-		for (x = 0; x < linepixels; x++) {
-			val16 = ((sbuf[x] & 0x00F80000) >> 8) |
-				((sbuf[x] & 0x0000FC00) >> 5) |
-				((sbuf[x] & 0x000000F8) >> 3);
-			if (swap)
-				*dbuf++ = swab16(val16);
-			else
-				*dbuf++ = val16;
-		}
-		src += src_pitch;
-		dst += dst_pitch;
+	for (x = 0; x < pixels; x++) {
+		val16 = ((sbuf[x] & 0x00F80000) >> 8) |
+			((sbuf[x] & 0x0000FC00) >> 5) |
+			((sbuf[x] & 0x000000F8) >> 3);
+		if (swab)
+			dbuf[x] = swab16(val16);
+		else
+			dbuf[x] = val16;
 	}
-
-	kfree(sbuf);
 }
 
 /**
@@ -167,23 +147,37 @@ static void drm_fb_xrgb8888_to_rgb565_lines(void *dst, unsigned int dst_pitch,
  */
 void drm_fb_xrgb8888_to_rgb565(void *dst, void *vaddr,
 			       struct drm_framebuffer *fb,
-			       struct drm_rect *clip, bool swap)
+			       struct drm_rect *clip, bool swab)
 {
-	unsigned int src_offset = (clip->y1 * fb->pitches[0])
-		+ (clip->x1 * sizeof(u32));
-	size_t src_len = (clip->x2 - clip->x1) * sizeof(u32);
-	size_t dst_len = (clip->x2 - clip->x1) * sizeof(u16);
+	size_t linepixels = clip->x2 - clip->x1;
+	size_t src_len = linepixels * sizeof(u32);
+	size_t dst_len = linepixels * sizeof(u16);
+	unsigned y, lines = clip->y2 - clip->y1;
+	void *sbuf;
 
-	drm_fb_xrgb8888_to_rgb565_lines(dst, dst_len,
-					vaddr + src_offset, fb->pitches[0],
-					src_len, clip->y2 - clip->y1,
-					swap);
+	/*
+	 * The cma memory is write-combined so reads are uncached.
+	 * Speed up by fetching one line at a time.
+	 */
+	sbuf = kmalloc(src_len, GFP_KERNEL);
+	if (!sbuf)
+		return;
+
+	vaddr += clip_offset(clip, fb->pitches[0], sizeof(u32));
+	for (y = 0; y < lines; y++) {
+		memcpy(sbuf, vaddr, src_len);
+		drm_fb_xrgb8888_to_rgb565_line(dst, sbuf, linepixels, swab);
+		vaddr += fb->pitches[0];
+		dst += dst_len;
+	}
+
+	kfree(sbuf);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
 
 /**
  * drm_fb_xrgb8888_to_rgb565_dstclip - Convert XRGB8888 to RGB565 clip buffer
- * @dst: RGB565 destination buffer
+ * @dst: RGB565 destination buffer (iomem)
  * @dst_pitch: destination buffer pitch
  * @vaddr: XRGB8888 source buffer
  * @fb: DRM framebuffer
@@ -194,22 +188,31 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565);
  * support XRGB8888.
  *
  * This function applies clipping on dst, i.e. the destination is a
- * full framebuffer but only the clip rect content is copied over.
+ * full (iomem) framebuffer but only the clip rect content is copied over.
  */
-void drm_fb_xrgb8888_to_rgb565_dstclip(void *dst, unsigned int dst_pitch,
+void drm_fb_xrgb8888_to_rgb565_dstclip(void __iomem *dst, unsigned int dst_pitch,
 				       void *vaddr, struct drm_framebuffer *fb,
-				       struct drm_rect *clip, bool swap)
+				       struct drm_rect *clip, bool swab)
 {
-	unsigned int src_offset = (clip->y1 * fb->pitches[0])
-		+ (clip->x1 * sizeof(u32));
-	unsigned int dst_offset = (clip->y1 * dst_pitch)
-		+ (clip->x1 * sizeof(u16));
-	size_t src_len = (clip->x2 - clip->x1) * sizeof(u32);
+	size_t linepixels = clip->x2 - clip->x1;
+	size_t dst_len = linepixels * sizeof(u16);
+	unsigned y, lines = clip->y2 - clip->y1;
+	void *dbuf;
 
-	drm_fb_xrgb8888_to_rgb565_lines(dst + dst_offset, dst_pitch,
-					vaddr + src_offset, fb->pitches[0],
-					src_len, clip->y2 - clip->y1,
-					swap);
+	dbuf = kmalloc(dst_len, GFP_KERNEL);
+	if (!dbuf)
+		return;
+
+	vaddr += clip_offset(clip, fb->pitches[0], sizeof(u32));
+	dst += clip_offset(clip, dst_pitch, sizeof(u16));
+	for (y = 0; y < lines; y++) {
+		drm_fb_xrgb8888_to_rgb565_line(dbuf, vaddr, linepixels, swab);
+		memcpy_toio(dst, dbuf, dst_len);
+		vaddr += fb->pitches[0];
+		dst += dst_len;
+	}
+
+	kfree(dbuf);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb565_dstclip);
 
-- 
2.18.1
