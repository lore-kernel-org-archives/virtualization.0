Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B66C43219
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 13:28:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CBE61163
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 13:28:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90CBE61163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F9A160675;
	Fri, 22 Oct 2021 13:28:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pNbYZhjK2FVL; Fri, 22 Oct 2021 13:28:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BD86960852;
	Fri, 22 Oct 2021 13:28:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 074E8C0040;
	Fri, 22 Oct 2021 13:28:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2F6FEC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 13:28:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B6604018A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 13:28:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="wMVK1J3P";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="N8cDxRDI"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Rj-9g0uWpCaS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 13:28:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 256894025F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 13:28:33 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 39F3A21982;
 Fri, 22 Oct 2021 13:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634909312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54UuCEyIozo+qptfH2cq+hpA85QQ7QvF2nVzUEltC6c=;
 b=wMVK1J3PEGIqEHbYNT7e3eT3IqLUbZDqXFE2B9uwzFzMLB05fml7qvlybnykVlii2CfpKr
 mOel5RaZ7zDPEYLslEd0e4oYN9XMuwuDYvt7VVHhaaMEGO2r4Nc4k+mKEE9ZUNUkFJyNLb
 D0PhZvT8MEiIExKrt2sUGJ3tOUqvuu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634909312;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=54UuCEyIozo+qptfH2cq+hpA85QQ7QvF2nVzUEltC6c=;
 b=N8cDxRDIgNRUU2W+WQrI3nEPT6H1byRuvjB5qVYDTA4OeW8//gxpfVYN+Gn30G8lvTv4De
 0ieswMFDQox09BBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB1E713E7E;
 Fri, 22 Oct 2021 13:28:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +PGeMH+8cmEwXgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Fri, 22 Oct 2021 13:28:31 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, noralf@tronnes.org,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com,
 michael+lkml@stapelberg.ch, aros@gmx.com, joshua@stroblindustries.com,
 arnd@arndb.de
Subject: [PATCH 3/9] drm/format-helper: Add destination-buffer pitch to
 drm_fb_swab()
Date: Fri, 22 Oct 2021 15:28:23 +0200
Message-Id: <20211022132829.7697-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211022132829.7697-1-tzimmermann@suse.de>
References: <20211022132829.7697-1-tzimmermann@suse.de>
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

Add destination-buffer pitch as argument to drm_fb_swab(). Done for
consistency with the rest of the interface.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_format_helper.c | 19 +++++++++++++++----
 drivers/gpu/drm/drm_mipi_dbi.c      |  2 +-
 drivers/gpu/drm/gud/gud_pipe.c      |  2 +-
 include/drm/drm_format_helper.h     |  5 +++--
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 38c8055f6fa8..79869ed553d9 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -92,6 +92,7 @@ EXPORT_SYMBOL(drm_fb_memcpy_toio);
 /**
  * drm_fb_swab - Swap bytes into clip buffer
  * @dst: Destination buffer
+ * @dst_pitch: Number of bytes between two consecutive scanlines within dst
  * @src: Source buffer
  * @fb: DRM framebuffer
  * @clip: Clip rectangle area to copy
@@ -103,19 +104,25 @@ EXPORT_SYMBOL(drm_fb_memcpy_toio);
  * This function does not apply clipping on dst, i.e. the destination
  * is a small buffer containing the clip rect only.
  */
-void drm_fb_swab(void *dst, void *src, struct drm_framebuffer *fb,
-		 struct drm_rect *clip, bool cached)
+void drm_fb_swab(void *dst, unsigned int dst_pitch, const void *src,
+		 const struct drm_framebuffer *fb, const struct drm_rect *clip,
+		 bool cached)
 {
 	u8 cpp = fb->format->cpp[0];
 	size_t len = drm_rect_width(clip) * cpp;
-	u16 *src16, *dst16 = dst;
-	u32 *src32, *dst32 = dst;
+	const u16 *src16;
+	const u32 *src32;
+	u16 *dst16;
+	u32 *dst32;
 	unsigned int x, y;
 	void *buf = NULL;
 
 	if (WARN_ON_ONCE(cpp != 2 && cpp != 4))
 		return;
 
+	if (!dst_pitch)
+		dst_pitch = len;
+
 	if (!cached)
 		buf = kmalloc(len, GFP_KERNEL);
 
@@ -131,6 +138,9 @@ void drm_fb_swab(void *dst, void *src, struct drm_framebuffer *fb,
 			src32 = src;
 		}
 
+		dst16 = dst;
+		dst32 = dst;
+
 		for (x = clip->x1; x < clip->x2; x++) {
 			if (cpp == 4)
 				*dst32++ = swab32(*src32++);
@@ -139,6 +149,7 @@ void drm_fb_swab(void *dst, void *src, struct drm_framebuffer *fb,
 		}
 
 		src += fb->pitches[0];
+		dst += dst_pitch;
 	}
 
 	kfree(buf);
diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index c09df8b06c7a..7ce89917d761 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -211,7 +211,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffer *fb,
 	switch (fb->format->format) {
 	case DRM_FORMAT_RGB565:
 		if (swap)
-			drm_fb_swab(dst, src, fb, clip, !gem->import_attach);
+			drm_fb_swab(dst, 0, src, fb, clip, !gem->import_attach);
 		else
 			drm_fb_memcpy(dst, 0, src, fb, clip);
 		break;
diff --git a/drivers/gpu/drm/gud/gud_pipe.c b/drivers/gpu/drm/gud/gud_pipe.c
index a92112ffd37a..e0b117b2559f 100644
--- a/drivers/gpu/drm/gud/gud_pipe.c
+++ b/drivers/gpu/drm/gud/gud_pipe.c
@@ -201,7 +201,7 @@ static int gud_prep_flush(struct gud_device *gdrm, struct drm_framebuffer *fb,
 			len = gud_xrgb8888_to_color(buf, format, vaddr, fb, rect);
 		}
 	} else if (gud_is_big_endian() && format->cpp[0] > 1) {
-		drm_fb_swab(buf, vaddr, fb, rect, !import_attach);
+		drm_fb_swab(buf, 0, vaddr, fb, rect, !import_attach);
 	} else if (compression && !import_attach && pitch == fb->pitches[0]) {
 		/* can compress directly from the framebuffer */
 		buf = vaddr + rect->y1 * pitch;
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 8d72f6fd27e9..c4c3c845e119 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -17,8 +17,9 @@ void drm_fb_memcpy(void *dst, unsigned int dst_pitch, const void *vaddr,
 		   const struct drm_framebuffer *fb, const struct drm_rect *clip);
 void drm_fb_memcpy_toio(void __iomem *dst, unsigned int dst_pitch, const void *vaddr,
 			const struct drm_framebuffer *fb, const struct drm_rect *clip);
-void drm_fb_swab(void *dst, void *src, struct drm_framebuffer *fb,
-		 struct drm_rect *clip, bool cached);
+void drm_fb_swab(void *dst, unsigned int dst_pitch, const void *src,
+		 const struct drm_framebuffer *fb, const struct drm_rect *clip,
+		 bool cached);
 void drm_fb_xrgb8888_to_rgb332(void *dst, void *vaddr, struct drm_framebuffer *fb,
 			       struct drm_rect *clip);
 void drm_fb_xrgb8888_to_rgb565(void *dst, void *vaddr,
-- 
2.33.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
