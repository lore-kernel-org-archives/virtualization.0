Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D926C3A59F
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 11:54:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1A5C160B1E;
	Wed, 23 Nov 2022 11:54:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1A5C160B1E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SH9gwwI1;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gYzSBpOf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MQ5qvlbFZqKC; Wed, 23 Nov 2022 11:54:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9DF4160D51;
	Wed, 23 Nov 2022 11:54:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DF4160D51
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 794D4C0032;
	Wed, 23 Nov 2022 11:54:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44AC0C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 11:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1641040934
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 11:53:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1641040934
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=SH9gwwI1; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=gYzSBpOf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JgA1VpqAGGRq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 11:53:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A65640903
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0A65640903
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 11:53:54 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 25FEF1F8CD;
 Wed, 23 Nov 2022 11:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669204433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qg1OO1dCgTd++OsRQ6Rdbd/OePW6Ri6kDHag9UTxeg=;
 b=SH9gwwI1HIa31jksvUazw6VRrntrL1Ie3Vv+sealryxydSvW6LEryWIHuwCxlbdtq/gpjC
 OCpWcLRjvSjuvaN0ctMwf7x7nmJw4fjvnpuUXGrKf2di0rqGKOXNRuHQabIMxMVLhvEOxn
 VGyTK3jayby16DPMV2pzbmXz8jn3awg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669204433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qg1OO1dCgTd++OsRQ6Rdbd/OePW6Ri6kDHag9UTxeg=;
 b=gYzSBpOfeECOs92xA0LMg104uN0FWGOgjI2hPA7RElln7XOWXjm5KS5LSFItSise9E+bz6
 +nAMVbsOLnQK3fBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C059013B03;
 Wed, 23 Nov 2022 11:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wC3uLdAJfmMwVwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 23 Nov 2022 11:53:52 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, xinliang.liu@linaro.org,
 tiantao6@hisilicon.com, jstultz@google.com, kong.kongxinwei@hisilicon.com,
 puck.chen@hisilicon.com, paul.kocialkowski@bootlin.com, javierm@redhat.com,
 airlied@redhat.com, kraxel@redhat.com
Subject: [PATCH v2 7/7] drm/fb-helper: Don't use the preferred depth for the
 BPP default
Date: Wed, 23 Nov 2022 12:53:48 +0100
Message-Id: <20221123115348.2521-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123115348.2521-1-tzimmermann@suse.de>
References: <20221123115348.2521-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
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

Picking a bpp of 32 will later on result in a default depth of 24
and the format XRGB8888. As XRGB8888 is the default format for most
of the current and legacy graphics stack, all drivers must support
it. So it is the safe choice.

v2:
	* fix commit-message typo (Javier)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
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
