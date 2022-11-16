Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50BB3C4332F
	for <virtualization@archiver.kernel.org>; Wed, 16 Nov 2022 16:09:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E9A0F813C1;
	Wed, 16 Nov 2022 16:09:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E9A0F813C1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IkQpaKYZ;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OS1QIQuj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WisHjuqHD4Ah; Wed, 16 Nov 2022 16:09:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 71E56813C2;
	Wed, 16 Nov 2022 16:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71E56813C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 496B4C0080;
	Wed, 16 Nov 2022 16:09:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7920AC0088
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C18F0812D3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C18F0812D3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CzXs1F1g47yx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:23 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 10A37812DB
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 10A37812DB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:22 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 39AA61F956;
 Wed, 16 Nov 2022 16:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668614961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6hgtxI+2HsmrlPFC80G0bZQ/s9HsOj9OF44Gk56AZwA=;
 b=IkQpaKYZ7KDolvPnrncc55qoGdhaXqiNKkzz4MPE/ycEpLh9xwicFGLRA/XjCWhm9UC/jp
 iTnvVSl+4OdKjt2NZnZrhnILKPb4RvfEKbZcBdCE5/0azIWi1u9BU7fiI/vRNshoOlOWji
 tEO6WD2xeHzmCmRe7BjUdCm45JsfVY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668614961;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6hgtxI+2HsmrlPFC80G0bZQ/s9HsOj9OF44Gk56AZwA=;
 b=OS1QIQujCaRqoNpgpGcWm9Ha8Sw3PRl+qBviL/4HvcUM3cshQykdBUqLj86rgMqNJWKpjH
 O2fSR1E7KbGUK4DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E831D13AC7;
 Wed, 16 Nov 2022 16:09:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6MXdNzALdWP/fwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 16 Nov 2022 16:09:20 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, xinliang.liu@linaro.org,
 tiantao6@hisilicon.com, jstultz@google.com, kong.kongxinwei@hisilicon.com,
 puck.chen@hisilicon.com, paul.kocialkowski@bootlin.com, javierm@redhat.com,
 airlied@redhat.com, kraxel@redhat.com
Subject: [PATCH 7/7] drm/fb-helper: Don't use the preferred depth for the BPP
 default
Date: Wed, 16 Nov 2022 17:09:17 +0100
Message-Id: <20221116160917.26342-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116160917.26342-1-tzimmermann@suse.de>
References: <20221116160917.26342-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
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

If no preferred value for bits-per-pixel has been given, fall back
to 32. Never use the preferred depth. The color depth is the number
of color/alpha bits per pixel, while bpp is the overall number of
bits in most cases.

Most noteworthy, XRGB8888 has a depth of 24 and a bpp value of 32.
Using depth for bpp would make the value 24 as well and format
selection in fbdev helpers fails. Unfortunately XRGB8888 is the most
common format and the old heuristic therefore fails for most of
the drivers (unless they implement the 24-bit RGB888 format).

Picking a bpp of 32 will lateron result in a default depth of 24
and the format XRGB8888. As XRGB8888 is the default format for most
of the current and legacy graphics stack, all drivers must support
it. So it is the safe choice.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/drm_fbdev_generic.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_fbdev_generic.c b/drivers/gpu/drm/drm_fbdev_generic.c
index ab86956692795..0a4c160e0e58a 100644
--- a/drivers/gpu/drm/drm_fbdev_generic.c
+++ b/drivers/gpu/drm/drm_fbdev_generic.c
@@ -431,7 +431,6 @@ static const struct drm_client_funcs drm_fbdev_client_funcs = {
  * drm_fbdev_generic_setup() - Setup generic fbdev emulation
  * @dev: DRM device
  * @preferred_bpp: Preferred bits per pixel for the device.
- *                 @dev->mode_config.preferred_depth is used if this is zero.
  *
  * This function sets up generic fbdev emulation for drivers that supports
  * dumb buffers with a virtual address and that can be mmap'ed.
@@ -475,12 +474,16 @@ void drm_fbdev_generic_setup(struct drm_device *dev,
 	}
 
 	/*
-	 * FIXME: This mixes up depth with bpp, which results in a glorious
-	 * mess, resulting in some drivers picking wrong fbdev defaults and
-	 * others wrong preferred_depth defaults.
+	 * Pick a preferred bpp of 32 if no value has been given. This
+	 * will select XRGB8888 for the framebuffer formats. All drivers
+	 * have to support XRGB8888 for backwards compatibility with legacy
+	 * userspace, so it's the safe choice here.
+	 *
+	 * TODO: Replace struct drm_mode_config.preferred_depth and this
+	 *       bpp value with a preferred format that is given as struct
+	 *       drm_format_info. Then derive all other values from the
+	 *       format.
 	 */
-	if (!preferred_bpp)
-		preferred_bpp = dev->mode_config.preferred_depth;
 	if (!preferred_bpp)
 		preferred_bpp = 32;
 	fb_helper->preferred_bpp = preferred_bpp;
-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
