Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84078C28B2B
	for <virtualization@archiver.kernel.org>; Mon,  8 Aug 2022 12:54:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6B09C82E4C;
	Mon,  8 Aug 2022 12:54:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6B09C82E4C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Gs0Vn1Ji;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=itU14hIe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DD0WptTZD7Zs; Mon,  8 Aug 2022 12:54:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5B05182C04;
	Mon,  8 Aug 2022 12:54:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5B05182C04
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7401DC0083;
	Mon,  8 Aug 2022 12:54:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 253F4C0033
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:54:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 60A0E40189
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:54:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 60A0E40189
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Gs0Vn1Ji; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=itU14hIe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3B7Am2EvG8MX
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:54:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 29F8F41477
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 29F8F41477
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Aug 2022 12:54:14 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6353537ADD;
 Mon,  8 Aug 2022 12:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1659963252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WikFDhAqeKXaHThBblzddGqdNEDOonODN63dWMP+fg=;
 b=Gs0Vn1JilW1EMpNwU/oT1pyQdq+bb4WjMHnxkuyAM9C3ZIV9ADPXJwP+2bSgySmiL3Quw1
 uo8lf4YFxkx0YXpBDH430zo+F3PYTa0mh/4A7DTKLAsX3vHL6HEXLPiiZquWdDPN7n2b15
 J6NkC+DRaTRmlCY0vsNhscm3Jssg+LU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1659963252;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6WikFDhAqeKXaHThBblzddGqdNEDOonODN63dWMP+fg=;
 b=itU14hIeDHeQF29ioKuNn67VT/4oo7vnpX4f2U/lACFjWvE3BVlhBebSskc8m7J6YJR3Lt
 enz2I9grsmcxypCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F116B13ADE;
 Mon,  8 Aug 2022 12:54:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mFTtOXMH8WLHUgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 08 Aug 2022 12:54:11 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sam@ravnborg.org, jose.exposito89@gmail.com, javierm@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@linux.ie,
 daniel@ffwll.ch, noralf@tronnes.org, drawat.floss@gmail.com,
 lucas.demarchi@intel.com, david@lechnology.com, kraxel@redhat.com
Subject: [PATCH v2 10/14] drm/format-helper: Rework XRGB8888-to-XRGB2101010
 conversion
Date: Mon,  8 Aug 2022 14:54:02 +0200
Message-Id: <20220808125406.20752-11-tzimmermann@suse.de>
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

Update XRGB8888-to-XRGB2101010 conversion to support struct iosys_map
and convert all users. Although these are single-plane color formats,
the new interface supports multi-plane formats for consistency with
drm_fb_blit().

v2:
	* update documentation (Sam)
	* add TODO on vaddr location (Sam)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/drm_format_helper.c | 50 ++++++++++++++++++++---------
 include/drm/drm_format_helper.h     |  6 ++--
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 8083f5b85b3a..795d845c7e53 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -554,26 +554,45 @@ static void drm_fb_xrgb8888_to_xrgb2101010_line(void *dbuf, const void *sbuf, un
 }
 
 /**
- * drm_fb_xrgb8888_to_xrgb2101010_toio - Convert XRGB8888 to XRGB2101010 clip
- * buffer
- * @dst: XRGB2101010 destination buffer (iomem)
- * @dst_pitch: Number of bytes between two consecutive scanlines within dst
- * @vaddr: XRGB8888 source buffer
+ * drm_fb_xrgb8888_to_xrgb2101010 - Convert XRGB8888 to XRGB2101010 clip buffer
+ * @dst: Array of XRGB2101010 destination buffers
+ * @dst_pitch: Array of numbers of bytes between the start of two consecutive scanlines
+ *             within @dst; can be NULL if scanlines are stored next to each other.
+ * @vmap: Array of XRGB8888 source buffers
  * @fb: DRM framebuffer
  * @clip: Clip rectangle area to copy
  *
- * Drivers can use this function for XRGB2101010 devices that don't natively
- * support XRGB8888.
+ * This function copies parts of a framebuffer to display memory and converts the
+ * color format during the process. Destination and framebuffer formats must match. The
+ * parameters @dst, @dst_pitch and @vmap refer to arrays. Each array must have at
+ * least as many entries as there are planes in @fb's format. Each entry stores the
+ * value for the format's respective color plane at the same index.
+ *
+ * This function does not apply clipping on @dst (i.e. the destination is at the
+ * top-left corner).
+ *
+ * Drivers can use this function for XRGB2101010 devices that don't support XRGB8888
+ * natively.
  */
-void drm_fb_xrgb8888_to_xrgb2101010_toio(void __iomem *dst,
-					 unsigned int dst_pitch, const void *vaddr,
-					 const struct drm_framebuffer *fb,
-					 const struct drm_rect *clip)
+void drm_fb_xrgb8888_to_xrgb2101010(struct iosys_map *dst, const unsigned int *dst_pitch,
+				    const struct iosys_map *vmap, const struct drm_framebuffer *fb,
+				    const struct drm_rect *clip)
 {
-	drm_fb_xfrm_toio(dst, dst_pitch, 4, vaddr, fb, clip, false,
-			 drm_fb_xrgb8888_to_xrgb2101010_line);
+	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
+		0, 0, 0, 0
+	};
+
+	if (!dst_pitch)
+		dst_pitch = default_dst_pitch;
+
+	/* TODO: handle vmap in I/O memory here */
+	if (dst[0].is_iomem)
+		drm_fb_xfrm_toio(dst[0].vaddr_iomem, dst_pitch[0], 4, vmap[0].vaddr, fb,
+				 clip, false, drm_fb_xrgb8888_to_xrgb2101010_line);
+	else
+		drm_fb_xfrm(dst[0].vaddr, dst_pitch[0], 4, vmap[0].vaddr, fb,
+			    clip, false, drm_fb_xrgb8888_to_xrgb2101010_line);
 }
-EXPORT_SYMBOL(drm_fb_xrgb8888_to_xrgb2101010_toio);
 
 static void drm_fb_xrgb8888_to_gray8_line(void *dbuf, const void *sbuf, unsigned int pixels)
 {
@@ -681,8 +700,7 @@ int drm_fb_blit(struct iosys_map *dst, const unsigned int *dst_pitch, uint32_t d
 		}
 	} else if (dst_format == DRM_FORMAT_XRGB2101010) {
 		if (fb_format == DRM_FORMAT_XRGB8888) {
-			drm_fb_xrgb8888_to_xrgb2101010_toio(dst[0].vaddr_iomem, dst_pitch[0],
-							    vmap[0].vaddr, fb, clip);
+			drm_fb_xrgb8888_to_xrgb2101010(dst, dst_pitch, vmap, fb, clip);
 			return 0;
 		}
 	}
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 8c633dbab5d6..6807440ce29c 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -29,9 +29,9 @@ void drm_fb_xrgb8888_to_rgb565(struct iosys_map *dst, const unsigned int *dst_pi
 void drm_fb_xrgb8888_to_rgb888(struct iosys_map *dst, const unsigned int *dst_pitch,
 			       const struct iosys_map *vmap, const struct drm_framebuffer *fb,
 			       const struct drm_rect *clip);
-void drm_fb_xrgb8888_to_xrgb2101010_toio(void __iomem *dst, unsigned int dst_pitch,
-					 const void *vaddr, const struct drm_framebuffer *fb,
-					 const struct drm_rect *clip);
+void drm_fb_xrgb8888_to_xrgb2101010(struct iosys_map *dst, const unsigned int *dst_pitch,
+				    const struct iosys_map *vmap, const struct drm_framebuffer *fb,
+				    const struct drm_rect *clip);
 void drm_fb_xrgb8888_to_gray8(void *dst, unsigned int dst_pitch, const void *vaddr,
 			      const struct drm_framebuffer *fb, const struct drm_rect *clip);
 
-- 
2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
