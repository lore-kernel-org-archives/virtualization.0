Return-Path: <SRS0=KYCx=IQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9DAC433E6
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 10:29:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42C6C64F40
	for <virtualization@archiver.kernel.org>; Thu, 18 Mar 2021 10:29:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42C6C64F40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C3B743293;
	Thu, 18 Mar 2021 10:29:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n2Wa2IQWbq_B; Thu, 18 Mar 2021 10:29:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 07F3F43289;
	Thu, 18 Mar 2021 10:29:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B09EC0012;
	Thu, 18 Mar 2021 10:29:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B5B5C0017
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:29:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6266D60633
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:29:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AowpKYymkuPN
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:29:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B3E96068A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Mar 2021 10:29:27 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 814CCAD77;
 Thu, 18 Mar 2021 10:29:25 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kraxel@redhat.com, corbet@lwn.net, lgirdwood@gmail.com,
 broonie@kernel.org, sam@ravnborg.org, robh@kernel.org,
 emil.l.velikov@gmail.com, geert+renesas@glider.be, hdegoede@redhat.com,
 bluescreen_avenger@verizon.net
Subject: [PATCH v2 02/10] drm/format-helper: Add blitter functions
Date: Thu, 18 Mar 2021 11:29:13 +0100
Message-Id: <20210318102921.21536-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210318102921.21536-1-tzimmermann@suse.de>
References: <20210318102921.21536-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 virtualization@lists.linux-foundation.org,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
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

The blitter functions copy a framebuffer to I/O memory using one of
the existing conversion functions.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Tested-by: nerdopolis <bluescreen_avenger@verizon.net>
---
 drivers/gpu/drm/drm_format_helper.c | 87 +++++++++++++++++++++++++++++
 include/drm/drm_format_helper.h     |  8 +++
 2 files changed, 95 insertions(+)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 8d5a683afea7..0e885cd34107 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -344,3 +344,90 @@ void drm_fb_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_gray8);
 
+/**
+ * drm_fb_blit_rect_dstclip - Copy parts of a framebuffer to display memory
+ * @dst:	The display memory to copy to
+ * @dst_pitch:	Number of bytes between two consecutive scanlines within dst
+ * @dst_format:	FOURCC code of the display's color format
+ * @vmap:	The framebuffer memory to copy from
+ * @fb:		The framebuffer to copy from
+ * @clip:	Clip rectangle area to copy
+ *
+ * This function copies parts of a framebuffer to display memory. If the
+ * formats of the display and the framebuffer mismatch, the blit function
+ * will attempt to convert between them.
+ *
+ * Use drm_fb_blit_dstclip() to copy the full framebuffer.
+ *
+ * Returns:
+ * 0 on success, or
+ * -EINVAL if the color-format conversion failed, or
+ * a negative error code otherwise.
+ */
+int drm_fb_blit_rect_dstclip(void __iomem *dst, unsigned int dst_pitch,
+			     uint32_t dst_format, void *vmap,
+			     struct drm_framebuffer *fb,
+			     struct drm_rect *clip)
+{
+	uint32_t fb_format = fb->format->format;
+
+	/* treat alpha channel like filler bits */
+	if (fb_format == DRM_FORMAT_ARGB8888)
+		fb_format = DRM_FORMAT_XRGB8888;
+	if (dst_format == DRM_FORMAT_ARGB8888)
+		dst_format = DRM_FORMAT_XRGB8888;
+
+	if (dst_format == fb_format) {
+		drm_fb_memcpy_dstclip(dst, dst_pitch, vmap, fb, clip);
+		return 0;
+
+	} else if (dst_format == DRM_FORMAT_RGB565) {
+		if (fb_format == DRM_FORMAT_XRGB8888) {
+			drm_fb_xrgb8888_to_rgb565_dstclip(dst, dst_pitch,
+							  vmap, fb, clip,
+							  false);
+			return 0;
+		}
+	} else if (dst_format == DRM_FORMAT_RGB888) {
+		if (fb_format == DRM_FORMAT_XRGB8888) {
+			drm_fb_xrgb8888_to_rgb888_dstclip(dst, dst_pitch,
+							  vmap, fb, clip);
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(drm_fb_blit_rect_dstclip);
+
+/**
+ * drm_fb_blit_dstclip - Copy framebuffer to display memory
+ * @dst:	The display memory to copy to
+ * @dst_pitch:	Number of bytes between two consecutive scanlines within dst
+ * @dst_format:	FOURCC code of the display's color format
+ * @vmap:	The framebuffer memory to copy from
+ * @fb:		The framebuffer to copy from
+ *
+ * This function copies a full framebuffer to display memory. If the formats
+ * of the display and the framebuffer mismatch, the copy function will
+ * attempt to convert between them.
+ *
+ * See drm_fb_blit_rect_dstclip() for more inforamtion.
+ *
+ * Returns:
+ * 0 on success, or a negative error code otherwise.
+ */
+int drm_fb_blit_dstclip(void __iomem *dst, unsigned int dst_pitch,
+			uint32_t dst_format, void *vmap,
+			struct drm_framebuffer *fb)
+{
+	struct drm_rect fullscreen = {
+		.x1 = 0,
+		.x2 = fb->width,
+		.y1 = 0,
+		.y2 = fb->height,
+	};
+	return drm_fb_blit_rect_dstclip(dst, dst_pitch, dst_format, vmap, fb,
+					&fullscreen);
+}
+EXPORT_SYMBOL(drm_fb_blit_dstclip);
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 2b5036a5fbe7..4e0258a61311 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -28,4 +28,12 @@ void drm_fb_xrgb8888_to_rgb888_dstclip(void __iomem *dst, unsigned int dst_pitch
 void drm_fb_xrgb8888_to_gray8(u8 *dst, void *vaddr, struct drm_framebuffer *fb,
 			      struct drm_rect *clip);
 
+int drm_fb_blit_rect_dstclip(void __iomem *dst, unsigned int dst_pitch,
+			     uint32_t dst_format, void *vmap,
+			     struct drm_framebuffer *fb,
+			     struct drm_rect *rect);
+int drm_fb_blit_dstclip(void __iomem *dst, unsigned int dst_pitch,
+			uint32_t dst_format, void *vmap,
+			struct drm_framebuffer *fb);
+
 #endif /* __LINUX_DRM_FORMAT_HELPER_H */
-- 
2.30.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
