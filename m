Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF211C7618D
	for <virtualization@archiver.kernel.org>; Mon, 20 Mar 2023 15:08:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 14E1341778;
	Mon, 20 Mar 2023 15:08:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 14E1341778
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=gbzEeQ5v;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=QisLF+tD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pA-CNFxrC92b; Mon, 20 Mar 2023 15:08:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 43FD84167E;
	Mon, 20 Mar 2023 15:07:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 43FD84167E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA9CEC0035;
	Mon, 20 Mar 2023 15:07:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CF46C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:07:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69E02403AE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:07:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 69E02403AE
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=gbzEeQ5v; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=QisLF+tD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v6jkMv6iCTvW
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:07:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13D1C40184
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 13D1C40184
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Mar 2023 15:07:55 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7A5641F88F;
 Mon, 20 Mar 2023 15:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1679324873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/F3Uv+gDIJaQ28jjNA4mJ3c4Lr8XCJ5cTNG7r+OmCu0=;
 b=gbzEeQ5v14FqgVm1HEPPWosuLRuJSkL0wAelyZ+0LVzJefDQJMl/Wj0hPL+FRas8ZRiuWv
 k2ha10IOh4Ce0I3/ijDt2q7zEglcrj2j/fnDmG/VWG3UV0QoBS5pHFLxBqFGY3Rmsoc9gb
 zQlULcrVcMGgMJpARDgMHs70k8A4SI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1679324873;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/F3Uv+gDIJaQ28jjNA4mJ3c4Lr8XCJ5cTNG7r+OmCu0=;
 b=QisLF+tDZ9Skilm0JjkO5y3wOQ9h8e5opDbdLDzNxayB6pw4XnT4646MlQohtc4Ujq+7jn
 UneD23GV0HU9mJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CDA513A00;
 Mon, 20 Mar 2023 15:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id B+/hDcl2GGTXOgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Mon, 20 Mar 2023 15:07:53 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, zackr@vmware.com, kraxel@redhat.com,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-graphics-maintainer@vmware.com
Subject: [PATCH v2 0/8] drm/fbdev-generic: Mandatory shadow buffering
Date: Mon, 20 Mar 2023 16:07:43 +0100
Message-Id: <20230320150751.20399-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
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

v2:
	* handle screen_size in separate patches (Javier)

Thomas Zimmermann (8):
  drm/fbdev-generic: Always use shadow buffering
  drm/fbdev-generic: Remove unused prefer_shadow_fbdev flag
  drm/fb-helper: Export drm_fb_helper_release_info()
  drm/fb-helper: Support smem_len in deferred I/O
  drm/fbdev-generic: Set screen size to size of GEM buffer
  drm/fbdev-generic: Clean up after failed probing
  drm/fb-helper: Consolidate CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM
  drm/fbdev-generic: Rename symbols

 drivers/gpu/drm/drm_fb_helper.c     |  63 ++++---
 drivers/gpu/drm/drm_fbdev_dma.c     |   9 +-
 drivers/gpu/drm/drm_fbdev_generic.c | 279 +++++++++-------------------
 drivers/gpu/drm/tiny/bochs.c        |   1 -
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c |   1 -
 include/drm/drm_fb_helper.h         |  14 +-
 include/drm/drm_mode_config.h       |   7 -
 7 files changed, 130 insertions(+), 244 deletions(-)


base-commit: 3333280906872bb8c2dff02666c7a8e46f085b24
-- 
2.40.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
