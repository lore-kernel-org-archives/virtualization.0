Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 558E6C00140
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 12:54:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03E5D828DD;
	Mon,  8 Aug 2022 12:54:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03E5D828DD
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=klZh4Uh8;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L6zIzcuH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I9vkCx7Yxdb5; Mon,  8 Aug 2022 12:54:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3387D824CE;
	Mon,  8 Aug 2022 12:54:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3387D824CE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0A36AC0071;
	Mon,  8 Aug 2022 12:54:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22919C007F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:54:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4BE3360B4C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:54:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4BE3360B4C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=klZh4Uh8; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=L6zIzcuH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 33SVWXGt80o5
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:54:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F5E660B94
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F5E660B94
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:54:12 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 77A9D1FF91;
 Mon,  8 Aug 2022 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1659963250; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZIuxK0/aq0jANGBK/GfV2o7Z0nHEvrCLS8Q20mqqAg=;
 b=klZh4Uh8wJ7PdAcN7kUnhGufIc6nD1luR9E3pFAnlI7xvo85Q9ws7+HmyzypSxXxfPha4s
 cB0vxnZm1bo/oehul0UwEtoFvg4QwzHnKE598LPl1/lGbj++bVO5bxIdPQngiHqP0bwSXr
 vIO2kFbmVLb24pDrjDiGSpvu0++Qfww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1659963250;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nZIuxK0/aq0jANGBK/GfV2o7Z0nHEvrCLS8Q20mqqAg=;
 b=L6zIzcuH4skES5bU7sdZyn2DsbXCH66V6s5YF7fdeWmS3DaqGSrm+b/zggBGv/CR6YhvsA
 JR2JAsC/BkKuI/Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E9F613A7C;
 Mon,  8 Aug 2022 12:54:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UEmXBnIH8WLHUgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 08 Aug 2022 12:54:10 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sam@ravnborg.org, jose.exposito89@gmail.com, javierm@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@linux.ie,
 daniel@ffwll.ch, noralf@tronnes.org, drawat.floss@gmail.com,
 lucas.demarchi@intel.com, david@lechnology.com, kraxel@redhat.com
Subject: [PATCH v2 05/14] drm/format-helper: Rework XRGB8888-to-RGBG332
 conversion
Date: Mon,  8 Aug 2022 14:53:57 +0200
Message-Id: <20220808125406.20752-6-tzimmermann@suse.de>
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

Update XRGB8888-to-RGB332 conversion to support struct iosys_map
and convert all users. Although these are single-plane color formats,
the new interface supports multi-plane formats for consistency with
drm_fb_blit().

v2:
	* rebase onto refactored Kunit tests
	* update documentation (Sam)
	* add TODO on vaddr location (Sam)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/drm_format_helper.c           | 38 +++++++++++++++----
 drivers/gpu/drm/gud/gud_pipe.c                |  2 +-
 .../gpu/drm/tests/drm_format_helper_test.c    | 20 +++++-----
 include/drm/drm_format_helper.h               |  5 ++-
 4 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index b5ed058984ae..248fd87f0a36 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -281,18 +281,42 @@ static void drm_fb_xrgb8888_to_rgb332_line(void *dbuf, const void *sbuf, unsigne
 
 /**
  * drm_fb_xrgb8888_to_rgb332 - Convert XRGB8888 to RGB332 clip buffer
- * @dst: RGB332 destination buffer
- * @dst_pitch: Number of bytes between two consecutive scanlines within dst
- * @src: XRGB8888 source buffer
+ * @dst: Array of RGB332 destination buffers
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
+ * @vmap: Array of XRGB8888 source buffers
  * @fb: DRM framebuffer
  * @clip: Clip rectangle area to copy
  *
- * Drivers can use this function for RGB332 devices that don't natively support XRGB8888.
+ * This function copies parts of a framebuffer to display memory and converts the
+ * color format during the process. Destination and framebuffer formats must match. The
+ * parameters @dst, @dst_pitch and @vmap refer to arrays. Each array must have at
+ * least as many entries as there are planes in @fb's format. Each entry stores the
+ * value for the format's respective color plane at the same index.
+ *
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner).
+ *
+ * Drivers can use this function for RGB332 devices that don't support XRGB8888 natively.
  */
-void drm_fb_xrgb8888_to_rgb332(void *dst, unsigned int dst_pitch, const void *src,
-			       const struct drm_framebuffer *fb, const struct drm_rect *clip)
+void drm_fb_xrgb8888_to_rgb332(struct iosys_map *dst, const unsigned int *dst_pitch,
+			       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
+			       const struct drm_rect *clip)
 {
-	drm_fb_xfrm(dst, dst_pitch, 1, src, fb, clip, false, drm_fb_xrgb8888_to_rgb332_line);
+	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
+		0, 0, 0, 0
+	};
+
+	if (!dst_pitch)
+		dst_pitch = default_dst_pitch;
+
+	/* TODO: handle vmap in I/O memory here */
+	if (dst[0].is_iomem)
+		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 1, vmap[0].vaddr, fb, clip,
+				 false, drm_fb_xrgb8888_to_rgb332_line);
+	else
+		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 1, vmap[0].vaddr, fb, clip,
+			    false, drm_fb_xrgb8888_to_rgb332_line);
 }
 EXPORT_SYMBOL(drm_fb_xrgb8888_to_rgb332);
 
diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index a15cda9ba058..426a3ae6cc50 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -196,7 +196,7 @@ static int gud_prep_flush(struct gud_device *gdrm, struct drm_framebuffer *fb,
 		} else if (format->format == DRM_FORMAT_R8) {
 			drm_fb_xrgb8888_to_gray8(buf, 0, vaddr, fb, rect);
 		} else if (format->format == DRM_FORMAT_RGB332) {
-			drm_fb_xrgb8888_to_rgb332(buf, 0, vaddr, fb, rect);
+			drm_fb_xrgb8888_to_rgb332(&dst, NULL, map_data, fb, rect);
 		} else if (format->format == DRM_FORMAT_RGB565) {
 			drm_fb_xrgb8888_to_rgb565(buf, 0, vaddr, fb, rect, gud_is_big_endian());
 		} else if (format->format == DRM_FORMAT_RGB888) {
diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 26ecf3b4b137..7b14694ead59 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -197,8 +197,9 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)
 	const struct convert_xrgb8888_case *params = test->param_value;
 	const struct convert_to_rgb332_result *result = &params->rgb332_result;
 	size_t dst_size;
-	__u8 *dst = NULL;
-	__u32 *src = NULL;
+	__u8 *buf = NULL;
+	__u32 *xrgb8888 = NULL;
+	struct iosys_map dst, src;
 
 	struct drm_framebuffer fb = {
 		.format = drm_format_info(DRM_FORMAT_XRGB8888),
@@ -209,15 +210,16 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)
 				       &params->clip);
 	KUNIT_ASSERT_GT(test, dst_size, 0);
 
-	dst = kunit_kzalloc(test, dst_size, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dst);
+	buf = kunit_kzalloc(test, dst_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
+	iosys_map_set_vaddr(&dst, buf);
 
-	src = le32buf_to_cpu(test, params->xrgb8888, TEST_BUF_SIZE);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, src);
+	xrgb8888 = le32buf_to_cpu(test, params->xrgb8888, TEST_BUF_SIZE);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, xrgb8888);
+	iosys_map_set_vaddr(&src, xrgb8888);
 
-	drm_fb_xrgb8888_to_rgb332(dst, result->dst_pitch, src, &fb,
-				  &params->clip);
-	KUNIT_EXPECT_EQ(test, memcmp(dst, result->expected, dst_size), 0);
+	drm_fb_xrgb8888_to_rgb332(&dst, &result->dst_pitch, &src, &fb, &params->clip);
+	KUNIT_EXPECT_EQ(test, memcmp(buf, result->expected, dst_size), 0);
 }
 
 static void xrgb8888_to_rgb565_test(struct kunit *test)
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 60944feaa936..3c28f099e3ed 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -20,8 +20,9 @@ void drm_fb_memcpy(struct iosys_map *dst, const unsigned int *dst_pitch,
 void drm_fb_swab(struct iosys_map *dst, const unsigned int *dst_pitch,
 		 const struct iosys_map *vmap, const struct drm_framebuffer *fb,
 		 const struct drm_rect *clip, bool cached);
-void drm_fb_xrgb8888_to_rgb332(void *dst, unsigned int dst_pitch, const void *vaddr,
-			       const struct drm_framebuffer *fb, const struct drm_rect *clip);
+void drm_fb_xrgb8888_to_rgb332(struct iosys_map *dst, const unsigned int *dst_pitch,
+			       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
+			       const struct drm_rect *clip);
 void drm_fb_xrgb8888_to_rgb565(void *dst, unsigned int dst_pitch, const void *vaddr,
 			       const struct drm_framebuffer *fb, const struct drm_rect *clip,
 			       bool swab);
-- 
2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
