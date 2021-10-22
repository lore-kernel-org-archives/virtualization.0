Return-Path: <SRS0=+kt1=PK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31936C433F5
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 13:28:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFCC2610EA
	for <virtualization@archiver.kernel.org>; Fri, 22 Oct 2021 13:28:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFCC2610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79CC56084C;
	Fri, 22 Oct 2021 13:28:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DCDLHSeiU6u5; Fri, 22 Oct 2021 13:28:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1FB6460821;
	Fri, 22 Oct 2021 13:28:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 051B3C001F;
	Fri, 22 Oct 2021 13:28:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD75FC001E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 13:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 90B0683B1B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 13:28:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="jdlj80Ia";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="NuoFacvH"
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gWjK27BJZi9O
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 13:28:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA36483B20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Oct 2021 13:28:33 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5C3E82197C;
 Fri, 22 Oct 2021 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634909311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rE48KuvIr0Z40dG14w+FVdTBhZyIJzox7nceTdSqCgU=;
 b=jdlj80Ia3bn3pIcCkQqDV1l+NtlaQTsbWrrjZListg8vCGmWQG/fi6nom4upIGuqBzkaWT
 OQjPuOmntSsLXLuj4+63b7apR5AKGewQbAQed10tgx1u1ahA/GfA0Oo6tbLl3c5tXfzKgM
 O2oREFUUjIAkWagpDY+8EbDCgEJ2+QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634909311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rE48KuvIr0Z40dG14w+FVdTBhZyIJzox7nceTdSqCgU=;
 b=NuoFacvHeA39C5SYK8o3DiXSujXGaZM7N6KTNioeaKI3j+irDi+qIVuVn9Fn0Fu6XujZ8v
 c1Mdgf5U5I4mJDDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB6DF13E7E;
 Fri, 22 Oct 2021 13:28:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uK9fOH68cmEwXgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Fri, 22 Oct 2021 13:28:30 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, noralf@tronnes.org,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com,
 michael+lkml@stapelberg.ch, aros@gmx.com, joshua@stroblindustries.com,
 arnd@arndb.de
Subject: [PATCH 1/9] drm/format-helper: Export drm_fb_clip_offset()
Date: Fri, 22 Oct 2021 15:28:21 +0200
Message-Id: <20211022132829.7697-2-tzimmermann@suse.de>
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

Provide a function that computes the offset into a blit destination
buffer. This will allow to move destination-buffer clipping into the
format-helper callers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_format_helper.c | 10 ++++++++--
 include/drm/drm_format_helper.h     |  4 ++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_format_helper.c b/drivers/gpu/drm/drm_format_helper.c
index 69fde60e36b3..28e9d0d89270 100644
--- a/drivers/gpu/drm/drm_format_helper.c
+++ b/drivers/gpu/drm/drm_format_helper.c
@@ -17,12 +17,18 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_rect.h>
 
-static unsigned int clip_offset(struct drm_rect *clip,
-				unsigned int pitch, unsigned int cpp)
+static unsigned int clip_offset(const struct drm_rect *clip, unsigned int pitch, unsigned int cpp)
 {
 	return clip->y1 * pitch + clip->x1 * cpp;
 }
 
+unsigned long drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info *format,
+				 const struct drm_rect *clip)
+{
+	return clip_offset(clip, pitch, format->cpp[0]);
+}
+EXPORT_SYMBOL(drm_fb_clip_offset);
+
 /**
  * drm_fb_memcpy - Copy clip buffer
  * @dst: Destination buffer
diff --git a/include/drm/drm_format_helper.h b/include/drm/drm_format_helper.h
index e86925cf07b9..90b9bd9ecb83 100644
--- a/include/drm/drm_format_helper.h
+++ b/include/drm/drm_format_helper.h
@@ -6,9 +6,13 @@
 #ifndef __LINUX_DRM_FORMAT_HELPER_H
 #define __LINUX_DRM_FORMAT_HELPER_H
 
+struct drm_format_info;
 struct drm_framebuffer;
 struct drm_rect;
 
+unsigned long drm_fb_clip_offset(unsigned int pitch, const struct drm_format_info *format,
+				 const struct drm_rect *clip);
+
 void drm_fb_memcpy(void *dst, void *vaddr, struct drm_framebuffer *fb,
 		   struct drm_rect *clip);
 void drm_fb_memcpy_dstclip(void __iomem *dst, unsigned int dst_pitch, void *vaddr,
-- 
2.33.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
