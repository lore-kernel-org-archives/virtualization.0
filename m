Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D04EC433EF
	for <virtualization@archiver.kernel.org>; Fri, 17 Dec 2021 14:46:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BEC4F84C81;
	Fri, 17 Dec 2021 14:46:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gwHwvf4kz-u6; Fri, 17 Dec 2021 14:46:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 68FBF83EFF;
	Fri, 17 Dec 2021 14:46:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3764EC0039;
	Fri, 17 Dec 2021 14:46:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30EEEC0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 14:46:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 955AC61109
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 14:46:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="XVn1+Isk";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="SH7yGC9w"
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KB01wNQ0nHcY
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 14:46:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06B0E61107
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 14:46:20 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3543C1F395;
 Fri, 17 Dec 2021 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639752379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1DSi0+0OVR9Vtrdmllg42i0lUDxPdENlZnjRoabq2FI=;
 b=XVn1+IskgmRzLeqXI9PzWRAP20ibsDbXlzdc4Mn33/H3BwEVRZhLpMziEtgCVp5OAs0Hb3
 s+F6kDbsBNDBgoMhXfcEOSW7QCK7CoXbWKpQ/hhfHGB6nokzD2Dqz6iwOCHdnlntN7yGhW
 8+ibmWAepUr1SqdvzZvgyU5cY2unF+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639752379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1DSi0+0OVR9Vtrdmllg42i0lUDxPdENlZnjRoabq2FI=;
 b=SH7yGC9wnOegT2EuHEFy2B6DZ/81RBHQcVDUhJAyoxSOfP+M9JO7yDcdaIwBrEYFzQAYyJ
 kNmqHdW8SUliiEBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 028A713E1C;
 Fri, 17 Dec 2021 14:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IL1BO7qivGH9KwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Fri, 17 Dec 2021 14:46:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
Subject: [PATCH 06/10] drm/mgag200: Replace module-init boiler-plate code with
 DRM helpers
Date: Fri, 17 Dec 2021 15:46:11 +0100
Message-Id: <20211217144615.32733-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217144615.32733-1-tzimmermann@suse.de>
References: <20211217144615.32733-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: spice-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
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

Remove custom mgag200_init() and mgag200_exit() functions and initialize
the module with DRM_module helpers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/mgag200/mgag200_drv.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.c b/drivers/gpu/drm/mgag200/mgag200_drv.c
index 740108a006ba..217844d71ab5 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.c
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.c
@@ -14,6 +14,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
 #include <drm/drm_ioctl.h>
+#include <drm/drm_module.h>
 #include <drm/drm_pciids.h>
 
 #include "mgag200_drv.h"
@@ -375,24 +376,7 @@ static struct pci_driver mgag200_pci_driver = {
 	.remove = mgag200_pci_remove,
 };
 
-static int __init mgag200_init(void)
-{
-	if (drm_firmware_drivers_only() && mgag200_modeset == -1)
-		return -EINVAL;
-
-	if (mgag200_modeset == 0)
-		return -EINVAL;
-
-	return pci_register_driver(&mgag200_pci_driver);
-}
-
-static void __exit mgag200_exit(void)
-{
-	pci_unregister_driver(&mgag200_pci_driver);
-}
-
-module_init(mgag200_init);
-module_exit(mgag200_exit);
+drm_module_pci_driver_if_modeset(mgag200_pci_driver, mgag200_modeset);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
