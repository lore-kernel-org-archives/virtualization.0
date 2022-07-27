Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F96C25B07
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 11:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1EE9A404E9;
	Wed, 27 Jul 2022 11:33:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1EE9A404E9
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qHfStlrh;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kuKkBx9b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C_YOfA19npt3; Wed, 27 Jul 2022 11:33:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1127840503;
	Wed, 27 Jul 2022 11:33:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1127840503
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4DA2BC007C;
	Wed, 27 Jul 2022 11:33:49 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28CBAC0084
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 11:33:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2D90660B96
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 11:33:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D90660B96
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=qHfStlrh; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=kuKkBx9b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CwsYJcUHvS09
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 11:33:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1F80F60B5C
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1F80F60B5C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 11:33:39 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A9FF385B9;
 Wed, 27 Jul 2022 11:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658921618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OigcqnSpr2TxdiklEdzoujtdIWfSDoPDzJk0AYbiKYE=;
 b=qHfStlrhnh+LwL7nVCExQYqgsia4pRn34OYj2UUb93Q+a0CRmaO83Q2q6+9WGdL/aX3zAJ
 a0PDpWIbCFLWbDf6sQCTFasJ9H07Th5u+nWWreE6rj2Jj44iCE/yy8vkYqe70TtCJhng8Y
 aGDHxat4HpfZtuEQ2mr9Dn7j+iQ2R2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658921618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OigcqnSpr2TxdiklEdzoujtdIWfSDoPDzJk0AYbiKYE=;
 b=kuKkBx9biEvYl49N7mpe4XeFhgQjtFYvkufgKVPq8otg5yiuX2cQstQTrdP7fuqesvPXhC
 xE8IXmYumT+ILLAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D146713A8E;
 Wed, 27 Jul 2022 11:33:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8ME5MpEi4WJmBAAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 27 Jul 2022 11:33:37 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sam@ravnborg.org, noralf@tronnes.org, daniel@ffwll.ch, airlied@linux.ie,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, airlied@redhat.com,
 javierm@redhat.com, drawat.floss@gmail.com, kraxel@redhat.com,
 david@lechnology.com, jose.exposito89@gmail.com
Subject: [PATCH 04/12] drm/format-helper: Rework XRGB8888-to-RGBG332 conversion
Date: Wed, 27 Jul 2022 13:33:04 +0200
Message-Id: <20220727113312.22407-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220727113312.22407-1-tzimmermann@suse.de>
References: <20220727113312.22407-1-tzimmermann@suse.de>
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

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_format_helper.c           | 25 ++++++++++++++-----
 drivers/gpu/drm/gud/gud_pipe.c                |  2 +-
 .../gpu/drm/tests/drm_format_helper_test.c    | 14 ++++++-----
 include/drm/drm_format_helper.h               |  5 ++--
 4 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index fa22d3cb11e8..2b5c3746ff4a 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -265,18 +265,31 @@ static void drm_fb_xrgb8888_to_rgb332_line(void *dbuf, const void *sbuf, unsigne
 
 /**
  * drm_fb_xrgb8888_to_rgb332 - Convert XRGB8888 to RGB332 clip buffer
- * @dst: RGB332 destination buffer
- * @dst_pitch: Number of bytes between two consecutive scanlines within dst
- * @src: XRGB8888 source buffer
+ * @dst: Array of RGB332 destination buffers
+ * @dst_pitch: Array of numbers of bytes between two consecutive scanlines within dst
+ * @vmap: Array of XRGB8888 source buffers
  * @fb: DRM framebuffer
  * @clip: Clip rectangle area to copy
  *
  * Drivers can use this function for RGB332 devices that don't natively support XRGB8888.
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
index 98583bf56044..b74dba06f704 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -124,7 +124,8 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)
 {
 	const struct xrgb8888_to_rgb332_case *params = test->param_value;
 	size_t dst_size;
-	__u8 *dst = NULL;
+	struct iosys_map dst, xrgb8888;
+	__u8 *buf = NULL;
 
 	struct drm_framebuffer fb = {
 		.format = drm_format_info(DRM_FORMAT_XRGB8888),
@@ -135,12 +136,13 @@ static void xrgb8888_to_rgb332_test(struct kunit *test)
 				       &params->clip);
 	KUNIT_ASSERT_GT(test, dst_size, 0);
 
-	dst = kunit_kzalloc(test, dst_size, GFP_KERNEL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dst);
+	buf = kunit_kzalloc(test, dst_size, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
 
-	drm_fb_xrgb8888_to_rgb332(dst, params->dst_pitch, params->xrgb8888,
-				  &fb, &params->clip);
-	KUNIT_EXPECT_EQ(test, memcmp(dst, params->expected, dst_size), 0);
+	iosys_map_set_vaddr(&dst, buf);
+	iosys_map_set_vaddr(&xrgb8888, (void __force *)params->xrgb8888);
+	drm_fb_xrgb8888_to_rgb332(&dst, &params->dst_pitch, &xrgb8888, &fb, &params->clip);
+	KUNIT_EXPECT_EQ(test, memcmp(buf, params->expected, dst_size), 0);
 }
 
 static struct kunit_case drm_format_helper_test_cases[] = {
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
