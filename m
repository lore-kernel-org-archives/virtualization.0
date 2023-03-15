Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9042C6FD1D
	for <virtualization@archiver.kernel.org>; Wed, 15 Mar 2023 16:14:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 827AD60F6C;
	Wed, 15 Mar 2023 16:14:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 827AD60F6C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FSStY76U;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=lup7F//R
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x4Lw240kyPQ0; Wed, 15 Mar 2023 16:14:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 205A760F71;
	Wed, 15 Mar 2023 16:14:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 205A760F71
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 91C3BC009F;
	Wed, 15 Mar 2023 16:14:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F170C008C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C03C160F0F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C03C160F0F
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a1J4gYjrw8n7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7EEB860B97
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7EEB860B97
 for <virtualization@lists.linux-foundation.org>;
 Wed, 15 Mar 2023 16:14:46 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B0A281FD80;
 Wed, 15 Mar 2023 16:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678896883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/s20+U9lqKe8TkL0+NybCexAELZRyFRoTsa7CKljr7E=;
 b=FSStY76U4lO/wtb8cfNG42ryAcS+jPmRs0zgoUYf3Me116SMKDLykcSNor9Fs7PhDTlnN5
 6rAh+X+hT32jUSqHXo+P7rq6nA+J/bXHik00fgBlK42Z1WAmmYEKtxxAB9m0CX3+en2Mn5
 KHTTprB0/GCt/KtFPieLUpalqtlsxQ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678896883;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/s20+U9lqKe8TkL0+NybCexAELZRyFRoTsa7CKljr7E=;
 b=lup7F//RMBsu0ZKErzyEVOlBVGeOr0wEUM6kxmhGRC//Wx5sSA2I4/UTFYonIeG2O69yjQ
 AxbgaudWdezbuTCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7538113A2F;
 Wed, 15 Mar 2023 16:14:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mB6dG/PuEWTrAwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Mar 2023 16:14:43 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, zackr@vmware.com, kraxel@redhat.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-graphics-maintainer@vmware.com
Subject: [PATCH 0/6] drm/fbdev-generic: Mandatory shadow buffering
Date: Wed, 15 Mar 2023 17:14:36 +0100
Message-Id: <20230315161442.27318-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Cc: Thomas Zimmermann <tzimmermann@suse.de>
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

After adding fbdev-dma and converting drivers, all users of
fbdev-generic require shadow buffering. Make it mandatory and
remove all other codepaths. This change greatly simplifies the
code for generic fbdev emulation. It will work with any driver
that supports GEM's vmap and vunmap.

The change further allows for a number of cleanups and fixes. The
flag prefer_shadow_fbdev is unused and to be removed. Probing in
fbdev-generic is now simple enough to roll back if it fails. Further
simplify the code for exporting the framebuffer's physical address.
Finally rename the symbols to follow other fbdev emulation.

Thomas Zimmermann (6):
  drm/fbdev-generic: Always use shadow buffering
  drm/fbdev-generic: Remove unused prefer_shadow_fbdev flag
  drm/fb-helper: Export drm_fb_helper_release_info()
  drm/fbdev-generic: Clean up after failed probing
  drm/fb-helper: Consolidate CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM
  drm/fbdev-generic: Rename symbols

 drivers/gpu/drm/drm_fb_helper.c     |  55 +++---
 drivers/gpu/drm/drm_fbdev_dma.c     |   9 +-
 drivers/gpu/drm/drm_fbdev_generic.c | 280 +++++++++-------------------
 drivers/gpu/drm/tiny/bochs.c        |   1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c |   1 -
 include/drm/drm_fb_helper.h         |  14 +-
 include/drm/drm_mode_config.h       |   7 -
 7 files changed, 125 insertions(+), 242 deletions(-)


base-commit: ec0708e846b819c8d5b642de42448a87d7526564
-- 
2.39.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
