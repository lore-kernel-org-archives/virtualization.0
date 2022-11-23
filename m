Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B984C433FE
	for <virtualization@archiver.kernel.org>; Wed, 23 Nov 2022 11:53:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D54E081268;
	Wed, 23 Nov 2022 11:53:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D54E081268
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Fa+RGOou;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ncF3N2Gg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sSebK5VXymOf; Wed, 23 Nov 2022 11:53:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5AD6580FB2;
	Wed, 23 Nov 2022 11:53:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5AD6580FB2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2DFD3C0032;
	Wed, 23 Nov 2022 11:53:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03B13C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 11:53:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D26606060A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 11:53:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D26606060A
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=Fa+RGOou; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=ncF3N2Gg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 48hfND5KzMzO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 11:53:53 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 039B260011
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 039B260011
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Nov 2022 11:53:52 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D35611F8C6;
 Wed, 23 Nov 2022 11:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669204430; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2lVNhnyM3Y0Lhit9HnWwE5HyHFVdSkXnJ71T5p37umo=;
 b=Fa+RGOoumTIQ0N9UlHPCUdbU/YPcUnDEopE0IXfFN/scZ0F4RjcWtXc2TQDM21ET/7VpI6
 oqvzHeB2SS3OuRF9SeE4EvZXhVK4Bx9AxMMGDhR+PTy16dchCzwVnoO5G1kQF+e3vD34/j
 2PI6npDzKBLPJRoJqW/L1WjLuJ5eYek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669204430;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2lVNhnyM3Y0Lhit9HnWwE5HyHFVdSkXnJ71T5p37umo=;
 b=ncF3N2GgA21bYoG8J3IvVDZ8qc3wsVQGqRx6ipyEaOnO2+gqrkGsL/tZYSqg8RcUOQYSVF
 skPpaawaHsZ6zpDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7CEE513AE7;
 Wed, 23 Nov 2022 11:53:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pJvdHM4JfmMwVwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 23 Nov 2022 11:53:50 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, xinliang.liu@linaro.org,
 tiantao6@hisilicon.com, jstultz@google.com, kong.kongxinwei@hisilicon.com,
 puck.chen@hisilicon.com, paul.kocialkowski@bootlin.com, javierm@redhat.com,
 airlied@redhat.com, kraxel@redhat.com
Subject: [PATCH v2 0/7] drm: Fix the color-depth/bpp confusion
Date: Wed, 23 Nov 2022 12:53:41 +0100
Message-Id: <20221123115348.2521-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.38.1
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

A number of drivers mix up the meaning of bits-per-pixel and color
depth. For each of them, set the correct values. As a rule of thumb,
the color depth is the number of color and alpha bits that affect
image composition. The bpp value is the color depth in the pixel
plus the filler bits.

The color depth is exported to userspace, while the bpp value only
affects fbdev emulation. Currently, fbdev fails if it selects a color
format that is unsupported by the driver. The fix would be to fall
back to a driver default value for the bpp. Getting the default fixed
in drivers will then allow us to fix the fbdev format selection.

v2:
	* leave out 15-bit color in logicvc (Javier)
	* minor typos (Javier)

Thomas Zimmermann (7):
  drm/hisilicon/hibmc: Fix preferred depth and bpp
  drm/logicvc: Fix preferred fbdev cpp
  drm/cirrus: Decouple fbdev bpp value from color depth
  drm/ofdrm: Set preferred depth from format of scanout buffer
  drm/simpledrm: Set preferred depth from format of scanout buffer
  drm/solomon: Set preferred color depth and bpp to the correct values
  drm/fb-helper: Don't use the preferred depth for the BPP default

 drivers/gpu/drm/drm_fbdev_generic.c             | 15 +++++++++------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c |  4 ++--
 drivers/gpu/drm/logicvc/logicvc_drm.c           | 13 ++++++++++++-
 drivers/gpu/drm/solomon/ssd130x.c               |  4 ++--
 drivers/gpu/drm/tiny/cirrus.c                   |  2 +-
 drivers/gpu/drm/tiny/ofdrm.c                    | 13 +------------
 drivers/gpu/drm/tiny/simpledrm.c                |  4 ++--
 7 files changed, 29 insertions(+), 26 deletions(-)

-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
