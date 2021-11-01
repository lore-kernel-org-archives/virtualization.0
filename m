Return-Path: <SRS0=TJKJ=PU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD82C433FE
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 14:15:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAB7560524
	for <virtualization@archiver.kernel.org>; Mon,  1 Nov 2021 14:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EAB7560524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A011A4025F;
	Mon,  1 Nov 2021 14:15:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zT9Vv6Mf181m; Mon,  1 Nov 2021 14:15:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B09E40230;
	Mon,  1 Nov 2021 14:15:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E5A4C0019;
	Mon,  1 Nov 2021 14:15:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5532C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C3CA7606D6
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="mLWwfKmp";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="8KhsvF+F"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8OkEPvdkmLUM
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9C7C960591
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Nov 2021 14:15:36 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 64A7521968;
 Mon,  1 Nov 2021 14:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1635776134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/seFr1pSoZVWTIFnRFMS/if3C+COfJP/xmAo3iraymA=;
 b=mLWwfKmplbbb5kHtx5ZBiF4CGoyNs1aIKoLlNxi1TV9ALRCNdCOTClN4yb5Y87MsAC5q9u
 QsTKS++peHMCqsvzmwqbTmHPkqk1+L9HXgVkvdGeNhXPJ9dsFOQSzl5Pa1z2eDZHLSPD11
 ayeP9K5oOgy4AeDi2PzvlVMSQO2HTuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1635776134;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/seFr1pSoZVWTIFnRFMS/if3C+COfJP/xmAo3iraymA=;
 b=8KhsvF+FeQz78jnPHl2Fep85FsZ/BlMeeJ70WDaVOCgrIKkZs5qKWZTg+PrRtyLYAaZCz1
 qfYY0olZ4hS9VxAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 015B8139FD;
 Mon,  1 Nov 2021 14:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GNrwOoX2f2GlHwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 01 Nov 2021 14:15:33 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, noralf@tronnes.org,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com,
 michael+lkml@stapelberg.ch, aros@gmx.com, joshua@stroblindustries.com,
 arnd@arndb.de
Subject: [PATCH v2 1/9] drm/format-helper: Export drm_fb_clip_offset()
Date: Mon,  1 Nov 2021 15:15:24 +0100
Message-Id: <20211101141532.26655-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211101141532.26655-1-tzimmermann@suse.de>
References: <20211101141532.26655-1-tzimmermann@suse.de>
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

Provide a function that computes the offset into a blit destination
buffer. This will allow to move destination-buffer clipping into the
format-helper callers.

v2:
	* provide documentation (Sam)
	* return 'unsigned int' (Sam, Noralf)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_format_helper.c | 19 +++++++++++++++++--
 include/drm/drm_format_helper.h     |  4 ++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 69fde60e36b3..677e62e39f72 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -17,12 +17,27 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_rect.h>
 
-static unsigned int clip_offset(struct drm_rect *clip,
-				unsigned int pitch, unsigned int cpp)
+static unsigned int clip_offset(const struct drm_rect *clip, unsigned int pitch, unsigned int cpp)
 {
 	return clip->y1 * pitch + clip->x1 * cpp;
 }
 
+/**
+ * drm_fb_clip_offset - Returns the clipping rectangles byte-offset in a frambuffer
+ * pitch: Frambuffer line pitch in byte
+ * format: Frambuffer format
+ * clip: Clip rectangle
+ *
+ * Returns:
+ * The byte offset of the clip rectangle's top-left corner within the framebuffer.
+ */
+unsigned int drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info *format,
+				const struct drm_rect *clip)
+{
+	return clip_offset(clip, pitch, format->cpp[0]);
+}
+EXPORT_SYMBOL(drm_fb_clip_offset);
+
 /**
  * drm_fb_memcpy - Copy clip buffer
  * @dst: Destination buffer
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index e86925cf07b9..f5a8b334b18d 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -6,9 +6,13 @@
 #ifndef __LINUX_DRM_FORMAT_HELPER_H
 #define __LINUX_DRM_FORMAT_HELPER_H
 
+struct drm_format_info;
 struct drm_framebuffer;
 struct drm_rect;
 
+unsigned int drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info *format,
+				const struct drm_rect *clip);
+
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip);
 void drm_fb_memcpy_dstclip(void __iomem *dst, unsigned int dst_pitch, void *vaddr,
-- 
2.33.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
