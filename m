Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BACC19F29
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 11:33:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 387BC60BAD;
	Wed, 27 Jul 2022 11:33:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 387BC60BAD
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2BwEajnd;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bMh3ENmZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5tQ_SftQa07d; Wed, 27 Jul 2022 11:33:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 103ED60BD6;
	Wed, 27 Jul 2022 11:33:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 103ED60BD6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5D2CDC008C;
	Wed, 27 Jul 2022 11:33:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35BF6C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 11:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D81A410A1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 11:33:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D81A410A1
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=2BwEajnd; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=bMh3ENmZ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CgyQaaXJuz0n
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 11:33:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5AB5640977
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5AB5640977
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 11:33:42 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 92B99206EC;
 Wed, 27 Jul 2022 11:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658921620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3ye5YFE6FWCO34pPhwH7FYqvHHyopdPXCSXU7WfEcs=;
 b=2BwEajnd362zdO1WrVA9nT1hvMtEws3jfpXU93c0IuSHpXuWLQC9pCg72EK6ONjXzA9NmH
 TGQHFT6Yp+EIJCZ2ugN3C3x9SuUMZVE1q5RLZkXiPY662fRWhN5HY359i/uwGxWqhA68Hl
 2W+l193IZksKFbGR6sav9wLat3AUgv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658921620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3ye5YFE6FWCO34pPhwH7FYqvHHyopdPXCSXU7WfEcs=;
 b=bMh3ENmZn4MA5W9ZmJkwOKaOrb1mopxVh45GdA0RHQkpaySimczUYz7vJH+mT5hCyd68Ok
 oAZw4ZcpSuthdlCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44CE113AD7;
 Wed, 27 Jul 2022 11:33:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2Cv7D5Qi4WJmBAAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 27 Jul 2022 11:33:40 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sam@ravnborg.org, noralf@tronnes.org, daniel@ffwll.ch, airlied@linux.ie,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com, airlied@redhat.com,
 javierm@redhat.com, drawat.floss@gmail.com, kraxel@redhat.com,
 david@lechnology.com, jose.exposito89@gmail.com
Subject: [PATCH 11/12] drm/format-helper: Rework XRGB8888-to-MONO conversion
Date: Wed, 27 Jul 2022 13:33:11 +0200
Message-Id: <20220727113312.22407-12-tzimmermann@suse.de>
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

Update XRGB8888-to-MONO conversion to support struct iosys_map
and convert all users. Although these are single-plane color formats,
the new interface supports multi-plane formats for consistency with
drm_fb_blit().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_format_helper.c | 28 +++++++++++++++++++---------
 drivers/gpu/drm/solomon/ssd130x.c   |  7 ++++---
 drivers/gpu/drm/tiny/repaper.c      |  6 +++++-
 include/drm/drm_format_helper.h     |  5 +++--
 4 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 521932fac491..d296d181659d 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -680,9 +680,9 @@ static void drm_fb_gray8_to_mono_line(void *dbuf, const void *sbuf, unsigned int
 
 /**
  * drm_fb_xrgb8888_to_mono - Convert XRGB8888 to monochrome
- * @dst: monochrome destination buffer (0=black, 1=white)
- * @dst_pitch: Number of bytes between two consecutive scanlines within dst
- * @vaddr: XRGB8888 source buffer
+ * @dst: Array of monochrome destination buffers (0=black, 1=white)
+ * @dst_pitch: Array of numbers of bytes between two consecutive scanlines within dst
+ * @vmap: Array of XRGB8888 source buffers
  * @fb: DRM framebuffer
  * @clip: Clip rectangle area to copy
  *
@@ -700,26 +700,36 @@ static void drm_fb_gray8_to_mono_line(void *dbuf, const void *sbuf, unsigned int
  * x-coordinate that is a multiple of 8, then the caller must take care itself
  * of supplying a suitable clip rectangle.
  */
-void drm_fb_xrgb8888_to_mono(void *dst, unsigned int dst_pitch, const void *vaddr,
-			     const struct drm_framebuffer *fb, const struct drm_rect *clip)
+void drm_fb_xrgb8888_to_mono(struct iosys_map *dst, const unsigned int *dst_pitch,
+			     const struct iosys_map *vmap, const struct drm_framebuffer *fb,
+			     const struct drm_rect *clip)
 {
+	static const unsigned int default_dst_pitch[DRM_FORMAT_MAX_PLANES] = {
+		0, 0, 0, 0
+	};
 	unsigned int linepixels = drm_rect_width(clip);
 	unsigned int lines = drm_rect_height(clip);
 	unsigned int cpp = fb->format->cpp[0];
 	unsigned int len_src32 = linepixels * cpp;
 	struct drm_device *dev = fb->dev;
+	void *vaddr = vmap[0].vaddr;
+	unsigned int dst_pitch_0;
 	unsigned int y;
-	u8 *mono = dst, *gray8;
+	u8 *mono = dst[0].vaddr, *gray8;
 	u32 *src32;
 
 	if (drm_WARN_ON(dev, fb->format->format != DRM_FORMAT_XRGB8888))
 		return;
 
+	if (!dst_pitch)
+		dst_pitch = default_dst_pitch;
+	dst_pitch_0 = dst_pitch[0];
+
 	/*
 	 * The mono destination buffer contains 1 bit per pixel
 	 */
-	if (!dst_pitch)
-		dst_pitch = DIV_ROUND_UP(linepixels, 8);
+	if (!dst_pitch_0)
+		dst_pitch_0 = DIV_ROUND_UP(linepixels, 8);
 
 	/*
 	 * The cma memory is write-combined so reads are uncached.
@@ -744,7 +754,7 @@ void drm_fb_xrgb8888_to_mono(void *dst, unsigned int dst_pitch, const void *vadd
 		drm_fb_xrgb8888_to_gray8_line(gray8, src32, linepixels);
 		drm_fb_gray8_to_mono_line(mono, gray8, linepixels);
 		vaddr += fb->pitches[0];
-		mono += dst_pitch;
+		mono += dst_pitch_0;
 	}
 
 	kfree(src32);
diff --git a/drivers/gpu/drm/solomon/ssd130x.c b/drivers/gpu/drm/solomon/ssd130x.c
index 5a3e3b78cd9e..aa7329a65c98 100644
--- a/drivers/gpu/drm/solomon/ssd130x.c
+++ b/drivers/gpu/drm/solomon/ssd130x.c
@@ -537,11 +537,11 @@ static void ssd130x_clear_screen(struct ssd130x_device *ssd130x)
 	kfree(buf);
 }
 
-static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_map *map,
+static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_map *vmap,
 				struct drm_rect *rect)
 {
 	struct ssd130x_device *ssd130x = drm_to_ssd130x(fb->dev);
-	void *vmap = map->vaddr; /* TODO: Use mapping abstraction properly */
+	struct iosys_map dst;
 	unsigned int dst_pitch;
 	int ret = 0;
 	u8 *buf = NULL;
@@ -555,7 +555,8 @@ static int ssd130x_fb_blit_rect(struct drm_framebuffer *fb, const struct iosys_m
 	if (!buf)
 		return -ENOMEM;
 
-	drm_fb_xrgb8888_to_mono(buf, dst_pitch, vmap, fb, rect);
+	iosys_map_set_vaddr(&dst, buf);
+	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect);
 
 	ssd130x_update_rect(ssd130x, buf, rect);
 
diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 013790c45d0a..0cdf6ab8fcc5 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -513,6 +513,8 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb)
 {
 	struct drm_gem_cma_object *cma_obj = drm_fb_cma_get_gem_obj(fb, 0);
 	struct repaper_epd *epd = drm_to_epd(fb->dev);
+	unsigned int dst_pitch = 0;
+	struct iosys_map dst, vmap;
 	struct drm_rect clip;
 	int idx, ret = 0;
 	u8 *buf = NULL;
@@ -541,7 +543,9 @@ static int repaper_fb_dirty(struct drm_framebuffer *fb)
 	if (ret)
 		goto out_free;
 
-	drm_fb_xrgb8888_to_mono(buf, 0, cma_obj->vaddr, fb, &clip);
+	iosys_map_set_vaddr(&dst, buf);
+	iosys_map_set_vaddr(&vmap, cma_obj->vaddr);
+	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, &vmap, fb, &clip);
 
 	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
 
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index 68087c982497..1e1d8f356cc1 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -40,7 +40,8 @@ int drm_fb_blit(struct iosys_map *dst, const unsigned int *dst_pitch, uint32_t d
 		const struct iosys_map *vmap, const struct drm_framebuffer *fb,
 		const struct drm_rect *rect);
 
-void drm_fb_xrgb8888_to_mono(void *dst, unsigned int dst_pitch, const void *src,
-			     const struct drm_framebuffer *fb, const struct drm_rect *clip);
+void drm_fb_xrgb8888_to_mono(struct iosys_map *dst, const unsigned int *dst_pitch,
+			     const struct iosys_map *vmap, const struct drm_framebuffer *fb,
+			     const struct drm_rect *clip);
 
 #endif /* __LINUX_DRM_FORMAT_HELPER_H */
-- 
2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
