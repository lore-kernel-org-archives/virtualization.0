Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD706C25B08
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 12:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D29B40189;
	Mon,  8 Aug 2022 12:54:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3D29B40189
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Im4TRukd;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=34v0P8tg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jIlhqcEb0Exh; Mon,  8 Aug 2022 12:54:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 398E840876;
	Mon,  8 Aug 2022 12:54:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 398E840876
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD3E1C0033;
	Mon,  8 Aug 2022 12:54:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B072EC007B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:54:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A703405AE
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:54:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6A703405AE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Im4TRukd; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=34v0P8tg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0vRVFpwKE3I8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:54:11 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5F6A540121
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5F6A540121
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:54:11 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4DD0D37AD0;
 Mon,  8 Aug 2022 12:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1659963249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5vBmryZjktjV2WukKQUSyD2WrIndWIrOYkr/yHtn1c=;
 b=Im4TRukdXFXoqI0bNSGqYeOy/mhPYWqvQtv+RCIpd9pYwnuGnrOVoWTVliOtz8cPsXcN3A
 1tNS8Rr8bp2Tv/Facw7rGKSwniPZOohdT3idDjvY/+uTVjAUdIVqJx0Gndm+rtP3RA/CVh
 X5Co54umeL3vyBXVkuRyNyZP/dQ0VGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1659963249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R5vBmryZjktjV2WukKQUSyD2WrIndWIrOYkr/yHtn1c=;
 b=34v0P8tgkUViSBvUVjLvL5MaCoPOWawzqfRmqmYSG/n/d1Yw1J7duDeoKXDutPdAZJaSEp
 QuF5zG1dOvbzSfAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6DF513A7C;
 Mon,  8 Aug 2022 12:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SFZwN3AH8WLHUgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 08 Aug 2022 12:54:08 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sam@ravnborg.org, jose.exposito89@gmail.com, javierm@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@linux.ie,
 daniel@ffwll.ch, noralf@tronnes.org, drawat.floss@gmail.com,
 lucas.demarchi@intel.com, david@lechnology.com, kraxel@redhat.com
Subject: [PATCH v2 02/14] drm/format-helper: Provide drm_fb_blit()
Date: Mon,  8 Aug 2022 14:53:54 +0200
Message-Id: <20220808125406.20752-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808125406.20752-1-tzimmermann@suse.de>
References: <20220808125406.20752-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Provide drm_fb_blit() that works with struct iosys_map. Update all
users of drm_fb_blit_toio(), which required a destination buffer in
I/O memory.

This patch only updates the function's interface. The implementation
still relies on the destination buffer to be located in  I/O memory.
See the follow-up patches for implementational changes. The new
function's interface works with multi-plane color formats, but again
implementation only supports a single plane for now.

v2:
	* rebase onto refactored simpledrm
	* use IOSYS_MAP_INIT_VADDR() (Sam)
	* update the commit message on the use of I/O memory (Sam)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/drm_format_helper.c | 44 ++++++++++++++++++-----------
 drivers/gpu/drm/tiny/simpledrm.c    |  8 +++---
 include/drm/drm_format_helper.h     |  7 +++--
 3 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 400b16d9147d..07f329f607a3 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -8,9 +8,10 @@
  * (at your option) any later version.
  */
 
+#include <linux/io.h>
+#include <linux/iosys-map.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/io.h>
 
 #include <drm/drm_device.h>
 #include <drm/drm_format_helper.h>
@@ -545,9 +546,10 @@ void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vad
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_gray8);
 
 /**
- * drm_fb_blit_toio - Copy parts of a framebuffer to display memory
- * @dst:	The display memory to copy to
- * @dst_pitch:	Number of bytes between two consecutive scanlines within dst
+ * drm_fb_blit - Copy parts of a framebuffer to display memory
+ * @dst:	Array of display-memory addresses to copy to
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
  * @dst_format:	FOURCC code of the display's color format
  * @vmap:	The framebuffer memory to copy from
  * @fb:		The framebuffer to copy from
@@ -555,16 +557,22 @@ EXPORT_SYMBOL(drm_fb_xrgb8888_to_gray8);
  *
  * This function copies parts of a framebuffer to display memory. If the
  * formats of the display and the framebuffer mismatch, the blit function
- * will attempt to convert between them.
+ * will attempt to convert between them during the process. The parameters @dst,
+ * @dst_pitch and @vmap refer to arrays. Each array must have at least as many
+ * entries as there are planes in @dst_format's format. Each entry stores the
+ * value for the format's respective color plane at the same index.
+ *
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner).
  *
  * Returns:
  * 0 on success, or
  * -EINVAL if the color-format conversion failed, or
  * a negative error code otherwise.
  */
-int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_format,
-		     const void *vmap, const struct drm_framebuffer *fb,
-		     const struct drm_rect *clip)
+int drm_fb_blit(struct iosys_map *dst, const unsigned int *dst_pitch, uint32_t dst_format,
+		const struct iosys_map *vmap, const struct drm_framebuffer *fb,
+		const struct drm_rect *clip)
 {
 	uint32_t fb_format = fb->format->format;
 
@@ -579,30 +587,35 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 		dst_format = DRM_FORMAT_XRGB2101010;
 
 	if (dst_format == fb_format) {
-		drm_fb_memcpy_toio(dst, dst_pitch, vmap, fb, clip);
+		drm_fb_memcpy_toio(dst[0].vaddr_iomem, dst_pitch[0], vmap[0].vaddr, fb, clip);
 		return 0;
 
 	} else if (dst_format == DRM_FORMAT_RGB565) {
 		if (fb_format == DRM_FORMAT_XRGB8888) {
-			drm_fb_xrgb8888_to_rgb565_toio(dst, dst_pitch, vmap, fb, clip, false);
+			drm_fb_xrgb8888_to_rgb565_toio(dst[0].vaddr_iomem, dst_pitch[0],
+						       vmap[0].vaddr, fb, clip, false);
 			return 0;
 		}
 	} else if (dst_format == DRM_FORMAT_RGB888) {
 		if (fb_format == DRM_FORMAT_XRGB8888) {
-			drm_fb_xrgb8888_to_rgb888_toio(dst, dst_pitch, vmap, fb, clip);
+			drm_fb_xrgb8888_to_rgb888_toio(dst[0].vaddr_iomem, dst_pitch[0],
+						       vmap[0].vaddr, fb, clip);
 			return 0;
 		}
 	} else if (dst_format == DRM_FORMAT_XRGB8888) {
 		if (fb_format == DRM_FORMAT_RGB888) {
-			drm_fb_rgb888_to_xrgb8888_toio(dst, dst_pitch, vmap, fb, clip);
+			drm_fb_rgb888_to_xrgb8888_toio(dst[0].vaddr_iomem, dst_pitch[0],
+						       vmap[0].vaddr, fb, clip);
 			return 0;
 		} else if (fb_format == DRM_FORMAT_RGB565) {
-			drm_fb_rgb565_to_xrgb8888_toio(dst, dst_pitch, vmap, fb, clip);
+			drm_fb_rgb565_to_xrgb8888_toio(dst[0].vaddr_iomem, dst_pitch[0],
+						       vmap[0].vaddr, fb, clip);
 			return 0;
 		}
 	} else if (dst_format == DRM_FORMAT_XRGB2101010) {
 		if (fb_format == DRM_FORMAT_XRGB8888) {
-			drm_fb_xrgb8888_to_xrgb2101010_toio(dst, dst_pitch, vmap, fb, clip);
+			drm_fb_xrgb8888_to_xrgb2101010_toio(dst[0].vaddr_iomem, dst_pitch[0],
+							    vmap[0].vaddr, fb, clip);
 			return 0;
 		}
 	}
@@ -612,8 +625,7 @@ int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_for
 
 	return -EINVAL;
 }
-EXPORT_SYMBOL(drm_fb_blit_toio);
-
+EXPORT_SYMBOL(drm_fb_blit);
 
 static void drm_fb_gray8_to_mono_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
diff --git a/drivers/gpu/drm/tiny/simpledrm.c b/drivers/gpu/drm/tiny/simpledrm.c
index 82fd98f77981..a81f91814595 100644
--- a/drivers/gpu/drm/tiny/simpledrm.c
+++ b/drivers/gpu/drm/tiny/simpledrm.c
@@ -508,11 +508,10 @@ static void simpledrm_primary_plane_helper_atomic_update(struct drm_plane *plane
 	struct drm_plane_state *plane_state = plane->state;
 	struct drm_plane_state *old_plane_state = drm_atomic_get_old_plane_state(old_state, plane);
 	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
-	void *vmap = shadow_plane_state->data[0].vaddr; /* TODO: Use mapping abstraction */
 	struct drm_framebuffer *fb = plane_state->fb;
 	struct drm_device *dev = plane->dev;
 	struct simpledrm_device *sdev = simpledrm_device_of_dev(dev);
-	void __iomem *dst = sdev->screen_base;
+	struct iosys_map dst = IOSYS_MAP_INIT_VADDR(sdev->screen_base);
 	struct drm_rect src_clip, dst_clip;
 	int idx;
 
@@ -529,8 +528,9 @@ static void simpledrm_primary_plane_helper_atomic_update(struct drm_plane *plane
 	if (!drm_dev_enter(dev, &idx))
 		return;
 
-	dst += drm_fb_clip_offset(sdev->pitch, sdev->format, &dst_clip);
-	drm_fb_blit_toio(dst, sdev->pitch, sdev->format->format, vmap, fb, &src_clip);
+	iosys_map_incr(&dst, drm_fb_clip_offset(sdev->pitch, sdev->format, &dst_clip));
+	drm_fb_blit(&dst, &sdev->pitch, sdev->format->format, shadow_plane_state->data, fb,
+		    &src_clip);
 
 	drm_dev_exit(idx);
 }
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 55145eca0782..21daea7fda99 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -6,6 +6,7 @@
 #ifndef __LINUX_DRM_FORMAT_HELPER_H
 #define __LINUX_DRM_FORMAT_HELPER_H
 
+struct iosys_map;
 struct drm_format_info;
 struct drm_framebuffer;
 struct drm_rect;
@@ -39,9 +40,9 @@ void drm_fb_xrgb8888_to_xrgb2101010_toio(void __iomem *dst, unsigned int dst_pit
 void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vaddr,
 			      const struct drm_framebuffer *fb, const struct drm_rect *clip);
 
-int drm_fb_blit_toio(void __iomem *dst, unsigned int dst_pitch, uint32_t dst_format,
-		     const void *vmap, const struct drm_framebuffer *fb,
-		     const struct drm_rect *rect);
+int drm_fb_blit(struct iosys_map *dst, const unsigned int *dst_pitch, uint32_t dst_format,
+		const struct iosys_map *vmap, const struct drm_framebuffer *fb,
+		const struct drm_rect *rect);
 
 void drm_fb_xrgb8888_to_mono(void *dst, unsigned int dst_pitch, const void *src,
 			     const struct drm_framebuffer *fb, const struct drm_rect *clip);
-- 
2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
