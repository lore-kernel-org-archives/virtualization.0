Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439F8C433FE
	for <virtualization@archiver.kernel.org>; Wed, 16 Nov 2022 16:09:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4C3340BE8;
	Wed, 16 Nov 2022 16:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4C3340BE8
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BT48xsaq;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Hy7+yICy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tp-xFJSwG-Uf; Wed, 16 Nov 2022 16:09:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2203240BA1;
	Wed, 16 Nov 2022 16:09:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2203240BA1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9E4B3C008A;
	Wed, 16 Nov 2022 16:09:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5AF9DC0033
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 303B141704
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 303B141704
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=BT48xsaq; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=Hy7+yICy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4DwnbO5vkOXO
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3CBB041808
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CBB041808
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Nov 2022 16:09:22 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0EBFA21FB5;
 Wed, 16 Nov 2022 16:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668614959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vipZOzPoQPDQjgCFPl+oDJIgP90KYOCVcnA8zAJd68Q=;
 b=BT48xsaqswUVzixbLyHwgwiIGiazG+lCFd2AHmEM3en4+iONXiUWQ93KloqiJwrL6zbrwN
 gGgq5skJb3bARyS/iOpzbOq/T6ync1c4tp95zNC2dLCCUweoE1asPDVzunWGW7muW07f0e
 TSe7dZHSCSn4I6Mjjvy6mxozSdfjmT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668614959;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vipZOzPoQPDQjgCFPl+oDJIgP90KYOCVcnA8zAJd68Q=;
 b=Hy7+yICynZv5qj7ea8/zsrf8iPYHOoJOHeLTQVt3YqhTeWVY/NsH9lwtGzQsYzVroyGeXy
 9APgTWHcUUSmztAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9688134CE;
 Wed, 16 Nov 2022 16:09:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eQZaLC4LdWP/fwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 16 Nov 2022 16:09:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, xinliang.liu@linaro.org,
 tiantao6@hisilicon.com, jstultz@google.com, kong.kongxinwei@hisilicon.com,
 puck.chen@hisilicon.com, paul.kocialkowski@bootlin.com, javierm@redhat.com,
 airlied@redhat.com, kraxel@redhat.com
Subject: [PATCH 0/7] drm: Fix the color-depth/bpp confusion
Date: Wed, 16 Nov 2022 17:09:10 +0100
Message-Id: <20221116160917.26342-1-tzimmermann@suse.de>
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
 drivers/gpu/drm/logicvc/logicvc_drm.c           | 14 +++++++++++++-
 drivers/gpu/drm/solomon/ssd130x.c               |  4 ++--
 drivers/gpu/drm/tiny/cirrus.c                   |  2 +-
 drivers/gpu/drm/tiny/ofdrm.c                    | 13 +------------
 drivers/gpu/drm/tiny/simpledrm.c                |  4 ++--
 7 files changed, 30 insertions(+), 26 deletions(-)

-- 
2.38.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
