From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 1/3] drm: switch drm_fb_memcpy_dstclip to accept __iomem dst
Date: Wed, 10 Apr 2019 08:38:13 +0200
Message-ID: <20190410063815.17062-2-kraxel__9682.9049450875$1554878336$gmane$org@redhat.com>
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

This patch makes drm_fb_memcpy_dstclip() accept a __iomem dst pointer
and use memcpy_toio() instead of memcpy().  With that separating out the
memcpy loop into the drm_fb_memcpy_lines() helper isn't useful any more,
so move the code back into the calling functins.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/drm/drm_format_helper.h     |  3 +-
 drivers/gpu/drm/cirrus/cirrus.c     |  2 +-
 drivers/gpu/drm/drm_format_helper.c | 45 +++++++++++++++--------------
 3 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 6f84380757ee..bc2e1004e166 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -15,7 +15,8 @@ struct drm_rect;
 
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip);
-void drm_fb_memcpy_dstclip(void *dst, void *vaddr, struct drm_framebuffer *fb,
+void drm_fb_memcpy_dstclip(void __iomem *dst, void *vaddr,
+			   struct drm_framebuffer *fb,
 			   struct drm_rect *clip);
 void drm_fb_swab16(u16 *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip);
diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index 5095b8ce52c2..0fc3aa31b5a4 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -307,7 +307,7 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
 		return -ENOMEM;
 
 	if (cirrus->cpp == fb->format->cpp[0])
-		drm_fb_memcpy_dstclip(__io_virt(cirrus->vram),
+		drm_fb_memcpy_dstclip(cirrus->vram,
 				      vmap, fb, rect);
 
 	else if (fb->format->cpp[0] == 4 && cirrus->cpp == 2)
diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 00d716f14173..dace05638bc3 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -10,23 +10,17 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 
 #include <drm/drm_format_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_rect.h>
 
-static void drm_fb_memcpy_lines(void *dst, unsigned int dst_pitch,
-				void *src, unsigned int src_pitch,
-				unsigned int linelength, unsigned int lines)
+static unsigned int clip_offset(struct drm_rect *clip,
+				unsigned int pitch, unsigned int cpp)
 {
-	int line;
-
-	for (line = 0; line < lines; line++) {
-		memcpy(dst, src, linelength);
-		src += src_pitch;
-		dst += dst_pitch;
-	}
+	return clip->y1 * pitch + clip->x1 * cpp;
 }
 
 /**
@@ -43,35 +37,44 @@ void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip)
 {
 	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
-	unsigned int offset = (clip->y1 * fb->pitches[0]) + (clip->x1 * cpp);
 	size_t len = (clip->x2 - clip->x1) * cpp;
+	unsigned int y, lines = clip->y2 - clip->y1;
 
-	drm_fb_memcpy_lines(dst, len,
-			    vaddr + offset, fb->pitches[0],
-			    len, clip->y2 - clip->y1);
+	vaddr += clip_offset(clip, fb->pitches[0], cpp);
+	for (y = 0; y < lines; y++) {
+		memcpy(dst, vaddr, len);
+		vaddr += fb->pitches[0];
+		dst += len;
+	}
 }
 EXPORT_SYMBOL(drm_fb_memcpy);
 
 /**
  * drm_fb_memcpy_dstclip - Copy clip buffer
- * @dst: Destination buffer
+ * @dst: Destination buffer (iomem)
  * @vaddr: Source buffer
  * @fb: DRM framebuffer
  * @clip: Clip rectangle area to copy
  *
  * This function applies clipping on dst, i.e. the destination is a
- * full framebuffer but only the clip rect content is copied over.
+ * full (iomem) framebuffer but only the clip rect content is copied over.
  */
-void drm_fb_memcpy_dstclip(void *dst, void *vaddr, struct drm_framebuffer *fb,
+void drm_fb_memcpy_dstclip(void __iomem *dst, void *vaddr,
+			   struct drm_framebuffer *fb,
 			   struct drm_rect *clip)
 {
 	unsigned int cpp = drm_format_plane_cpp(fb->format->format, 0);
-	unsigned int offset = (clip->y1 * fb->pitches[0]) + (clip->x1 * cpp);
+	unsigned int offset = clip_offset(clip, fb->pitches[0], cpp);
 	size_t len = (clip->x2 - clip->x1) * cpp;
+	unsigned int y, lines = clip->y2 - clip->y1;
 
-	drm_fb_memcpy_lines(dst + offset, fb->pitches[0],
-			    vaddr + offset, fb->pitches[0],
-			    len, clip->y2 - clip->y1);
+	vaddr += offset;
+	dst += offset;
+	for (y = 0; y < lines; y++) {
+		memcpy_toio(dst, vaddr, len);
+		vaddr += fb->pitches[0];
+		dst += fb->pitches[0];
+	}
 }
 EXPORT_SYMBOL(drm_fb_memcpy_dstclip);
 
-- 
2.18.1
