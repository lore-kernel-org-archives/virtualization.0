Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D73C433F5
	for <virtualization@archiver.kernel.org>; Fri, 17 Dec 2021 14:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9AC0741ED7;
	Fri, 17 Dec 2021 14:46:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Dj-Y-vsDws5; Fri, 17 Dec 2021 14:46:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4117141EC4;
	Fri, 17 Dec 2021 14:46:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB49CC001E;
	Fri, 17 Dec 2021 14:46:29 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10404C0039
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 14:46:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1275B41E88
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 14:46:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u-TOgztmsJfi
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 14:46:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7291E41CAD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Dec 2021 14:46:22 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A78481F398;
 Fri, 17 Dec 2021 14:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1639752379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUKlfJLsL/iuH6T6aa7UqmTOgMwhQaKobcpTFyq65wQ=;
 b=qaCq0ECVpjQsmb7scwSxXPKgZ6VpCNBwX8q7m7aEaEo/KAsFo41pphBWvOSGJHVY1zaW4C
 dKlIoZ+dvdRJUghsTrIK+cLVeFFVU/2CKBi6A3BO8TPteGOPsnVLeB2ilMpk/27aQDwSYj
 CJRlx6RgxZs/5Y+kmb4tAts5rL4lCkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1639752379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XUKlfJLsL/iuH6T6aa7UqmTOgMwhQaKobcpTFyq65wQ=;
 b=RXm9fkI1cQ4qvSpLm4MGHWAGUnouVlf6MlHTv4l2iIPLGCXRWbhIO+7q73QvpZxNQXvXcH
 jgHwiZIe7WNw3mAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 746FD13E4E;
 Fri, 17 Dec 2021 14:46:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4Pd1G7uivGH9KwAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Fri, 17 Dec 2021 14:46:19 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com
Subject: [PATCH 08/10] drm/qxl: Replace module-init boiler-plate code with DRM
 helpers
Date: Fri, 17 Dec 2021 15:46:13 +0100
Message-Id: <20211217144615.32733-9-tzimmermann@suse.de>
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

Remove custom qxl_init() and qxl_exit() functions and initialize
the module with DRM module helpers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/qxl/qxl_drv.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 323671e9cfc8..1cb6f0c224bb 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -39,6 +39,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_file.h>
 #include <drm/drm_gem_ttm_helper.h>
+#include <drm/drm_module.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_prime.h>
 #include <drm/drm_probe_helper.h>
@@ -303,23 +304,7 @@ static struct drm_driver qxl_driver = {
 	.release = qxl_drm_release,
 };
 
-static int __init qxl_init(void)
-{
-	if (drm_firmware_drivers_only() && qxl_modeset == -1)
-		return -EINVAL;
-
-	if (qxl_modeset == 0)
-		return -EINVAL;
-	return pci_register_driver(&qxl_pci_driver);
-}
-
-static void __exit qxl_exit(void)
-{
-	pci_unregister_driver(&qxl_pci_driver);
-}
-
-module_init(qxl_init);
-module_exit(qxl_exit);
+drm_module_pci_driver_if_modeset(qxl_pci_driver, qxl_modeset);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
-- 
2.34.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
