Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D851C65BA5
	for <virtualization@archiver.kernel.org>; Thu,  3 Nov 2022 15:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58CF161015;
	Thu,  3 Nov 2022 15:15:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 58CF161015
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qcoaEe5Y;
	dkim=fail reason="signature verification failed" header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vNkdqKAy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jd4bDouwDLXz; Thu,  3 Nov 2022 15:15:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2EA8561004;
	Thu,  3 Nov 2022 15:15:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2EA8561004
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6098C0033;
	Thu,  3 Nov 2022 15:15:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 193B3C0083
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 15:15:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AACD940304
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 15:15:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AACD940304
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=qcoaEe5Y; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=vNkdqKAy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HGlbEsd9g-wM
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 15:15:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7BFB24182A
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7BFB24182A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Nov 2022 15:15:03 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ADBCA21E0F;
 Thu,  3 Nov 2022 15:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667488501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKKDgnAGRekThl+Kef4OIp3bhWwiXQhMBkwOIt4sJLE=;
 b=qcoaEe5YDt/TSoDF9LlZD6Ng+7gD76PPx58VoLgyC2ai3047WiYzO6VG3UqAQIKy3YKHXg
 REz70h7mZR412dIJJPtt6KeG1I2HUyUb1PBRsZuXjXfuKD9CPq7uVKM+mBw35lKrclD5/3
 d/CmcLsUtt54A7ePpp2jBuYDLUuRSlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667488501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tKKDgnAGRekThl+Kef4OIp3bhWwiXQhMBkwOIt4sJLE=;
 b=vNkdqKAyelvn3nPdMe6vc+09jji6Lk7jXBt2wG5SEJu98SaBJt2CYv2mNsp1sZeqm7L53F
 HQNJ4nEa4KQxHwDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2463D13ADB;
 Thu,  3 Nov 2022 15:15:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sNoICPXaY2PBGgAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Thu, 03 Nov 2022 15:15:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@gmail.com, sam@ravnborg.org, javierm@redhat.com,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com
Subject: [PATCH v3 22/23] drm/fb-helper: Remove unnecessary include statements
Date: Thu,  3 Nov 2022 16:14:45 +0100
Message-Id: <20221103151446.2638-23-tzimmermann@suse.de>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221103151446.2638-1-tzimmermann@suse.de>
References: <20221103151446.2638-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linux-aspeed@lists.ozlabs.org, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-samsung-soc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 spice-devel@lists.freedesktop.org, linux-sunxi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 etnaviv@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org,
 linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 "linux-hyperv@vger.kernel.orglinux-hyperv"@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>, freedreno@lists.freedesktop.org
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

Remove include statements for <drm/drm_fb_helper.h> where it is not
required (i.e., most of them). In a few places include other header
files that are required by the source code.

v3:
	* fix amdgpu include statements
	* fix rockchip include statements

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c  | 1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c      | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c     | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c         | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h        | 1 -
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c          | 1 +
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c          | 1 +
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c           | 1 +
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c           | 1 +
 drivers/gpu/drm/arm/hdlcd_crtc.c                | 1 -
 drivers/gpu/drm/ast/ast_drv.h                   | 1 -
 drivers/gpu/drm/bridge/tc358762.c               | 2 +-
 drivers/gpu/drm/drm_crtc_helper.c               | 1 -
 drivers/gpu/drm/drm_gem_framebuffer_helper.c    | 1 -
 drivers/gpu/drm/drm_probe_helper.c              | 1 -
 drivers/gpu/drm/etnaviv/etnaviv_drv.h           | 3 ++-
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h | 1 -
 drivers/gpu/drm/hyperv/hyperv_drm_modeset.c     | 1 -
 drivers/gpu/drm/imx/imx-ldb.c                   | 2 +-
 drivers/gpu/drm/imx/imx-tve.c                   | 1 -
 drivers/gpu/drm/imx/parallel-display.c          | 2 +-
 drivers/gpu/drm/kmb/kmb_plane.c                 | 1 -
 drivers/gpu/drm/mgag200/mgag200_drv.h           | 1 -
 drivers/gpu/drm/qxl/qxl_drv.h                   | 1 -
 drivers/gpu/drm/rockchip/rockchip_drm_drv.h     | 2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c     | 1 +
 drivers/gpu/drm/tidss/tidss_kms.c               | 1 -
 drivers/gpu/drm/v3d/v3d_drv.c                   | 1 -
 drivers/gpu/drm/vboxvideo/vbox_main.c           | 1 -
 drivers/gpu/drm/virtio/virtgpu_drv.h            | 1 -
 drivers/gpu/drm/xen/xen_drm_front_gem.c         | 1 -
 31 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
index 491d4846fc02c..e1320edfc5274 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
@@ -26,7 +26,6 @@
 
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/amdgpu_drm.h>
 #include "amdgpu.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ddaecb2610c94..56a031a2e087e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -37,6 +37,7 @@
 #include <linux/pci-p2pdma.h>
 
 #include <drm/drm_atomic_helper.h>
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/amdgpu_drm.h>
 #include <linux/vgaarb.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index dd6f9ae6fbe9f..311a8ea6f0654 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -39,8 +39,8 @@
 #include <linux/pm_runtime.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fb_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_vblank.h>
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index bf1ff8f0e7120..e3a18f069ce5e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -29,6 +29,7 @@
 #include "amdgpu.h"
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_fb_helper.h>
 #include "amdgpu_uvd.h"
 #include "amdgpu_vce.h"
 #include "atom.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 37322550d7508..8a39300b1a845 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -36,7 +36,6 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_fixed.h>
 #include <drm/drm_crtc_helper.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_probe_helper.h>
 #include <linux/i2c.h>
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 05051d5d2ec31..90f87b2d985b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -21,6 +21,7 @@
  *
  */
 
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_vblank.h>
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
index c928bc9eb2026..0352de72c886a 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
@@ -21,6 +21,7 @@
  *
  */
 
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_vblank.h>
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 62315fd5a05f2..07bd16e820461 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -23,6 +23,7 @@
 
 #include <linux/pci.h>
 
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_vblank.h>
 
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index 87d5e4c21cb37..d73df100f2b3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -21,6 +21,7 @@
  *
  */
 
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_vblank.h>
 
diff --git a/drivers/gpu/drm/arm/hdlcd_crtc.c b/drivers/gpu/drm/arm/hdlcd_crtc.c
index 7030339fa2323..ddbe1dd2d44ef 100644
--- a/drivers/gpu/drm/arm/hdlcd_crtc.c
+++ b/drivers/gpu/drm/arm/hdlcd_crtc.c
@@ -19,7 +19,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_fb_dma_helper.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_of.h>
diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index 74f41282444f6..d51b81fea9c80 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -38,7 +38,6 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_mode.h>
 #include <drm/drm_framebuffer.h>
-#include <drm/drm_fb_helper.h>
 
 #define DRIVER_AUTHOR		"Dave Airlie"
 
diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 7f4fce1aa9988..0b6a284368859 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
@@ -19,7 +20,6 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_crtc.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index f5fb22e0d0337..a209659a996c7 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -43,7 +43,6 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
 #include <drm/drm_encoder.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_print.h>
diff --git a/drivers/gpu/drm/drm_gem_framebuffer_helper.c b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
index e35e224e6303a..e93533b86037f 100644
--- a/drivers/gpu/drm/drm_gem_framebuffer_helper.c
+++ b/drivers/gpu/drm/drm_gem_framebuffer_helper.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 
 #include <drm/drm_damage_helper.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem.h>
diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 2fc21df709bcb..bcd9611dabfd9 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -36,7 +36,6 @@
 #include <drm/drm_client.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index f32f4771dada7..2bb4c25565dcb 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -6,13 +6,14 @@
 #ifndef __ETNAVIV_DRV_H__
 #define __ETNAVIV_DRV_H__
 
+#include <linux/io.h>
 #include <linux/list.h>
 #include <linux/mm_types.h>
 #include <linux/sizes.h>
 #include <linux/time64.h>
 #include <linux/types.h>
 
-#include <drm/drm_fb_helper.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_gem.h>
 #include <drm/etnaviv_drm.h>
 #include <drm/gpu_scheduler.h>
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 4a0cd22c10e21..f957552c6c507 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -19,7 +19,6 @@
 #include <linux/i2c.h>
 
 #include <drm/drm_edid.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_framebuffer.h>
 
 struct hibmc_connector {
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
index 28e732f94bf2f..6c6b572987973 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
@@ -8,7 +8,6 @@
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_format_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
diff --git a/drivers/gpu/drm/imx/imx-ldb.c b/drivers/gpu/drm/imx/imx-ldb.c
index 41799011f73b6..c45fc8f4744d0 100644
--- a/drivers/gpu/drm/imx/imx-ldb.c
+++ b/drivers/gpu/drm/imx/imx-ldb.c
@@ -7,6 +7,7 @@
 
 #include <linux/clk.h>
 #include <linux/component.h>
+#include <linux/i2c.h>
 #include <linux/media-bus-format.h>
 #include <linux/mfd/syscon.h>
 #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
@@ -23,7 +24,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
diff --git a/drivers/gpu/drm/imx/imx-tve.c b/drivers/gpu/drm/imx/imx-tve.c
index 6b34fac3f73a0..d64ebd2cf15e8 100644
--- a/drivers/gpu/drm/imx/imx-tve.c
+++ b/drivers/gpu/drm/imx/imx-tve.c
@@ -19,7 +19,6 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
index 06723b2e9b847..0fa0b590830b6 100644
--- a/drivers/gpu/drm/imx/parallel-display.c
+++ b/drivers/gpu/drm/imx/parallel-display.c
@@ -8,6 +8,7 @@
 #include <linux/component.h>
 #include <linux/media-bus-format.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/videodev2.h>
 
@@ -16,7 +17,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
diff --git a/drivers/gpu/drm/kmb/kmb_plane.c b/drivers/gpu/drm/kmb/kmb_plane.c
index a42f63f6f9573..d172a302f9024 100644
--- a/drivers/gpu/drm/kmb/kmb_plane.c
+++ b/drivers/gpu/drm/kmb/kmb_plane.c
@@ -9,7 +9,6 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_fb_dma_helper.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_dma_helper.h>
diff --git a/drivers/gpu/drm/mgag200/mgag200_drv.h b/drivers/gpu/drm/mgag200/mgag200_drv.h
index f0c2349404b46..9e604dbb8e448 100644
--- a/drivers/gpu/drm/mgag200/mgag200_drv.h
+++ b/drivers/gpu/drm/mgag200/mgag200_drv.h
@@ -18,7 +18,6 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_plane.h>
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index 432758ad39a35..76f060810f634 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -38,7 +38,6 @@
 
 #include <drm/drm_crtc.h>
 #include <drm/drm_encoder.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_ioctl.h>
 #include <drm/drm_gem.h>
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
index 1641440837af5..aeb03a57240fd 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
@@ -9,10 +9,10 @@
 #ifndef _ROCKCHIP_DRM_DRV_H
 #define _ROCKCHIP_DRM_DRV_H
 
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_gem.h>
 
+#include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/component.h>
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
index da8a69953706d..6edb7c52cb3dc 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_gem.c
@@ -9,6 +9,7 @@
 #include <linux/vmalloc.h>
 
 #include <drm/drm.h>
+#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_gem_dma_helper.h>
 #include <drm/drm_prime.h>
diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index afb2879980c6c..345bcc3011e4f 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -10,7 +10,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_crtc_helper.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index e8c975b815859..478f1f0f60dec 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -22,7 +22,6 @@
 #include <linux/reset.h>
 
 #include <drm/drm_drv.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_managed.h>
 #include <uapi/drm/v3d_drm.h>
 
diff --git a/drivers/gpu/drm/vboxvideo/vbox_main.c b/drivers/gpu/drm/vboxvideo/vbox_main.c
index c9e8b3a63c621..3b83e550f4df5 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_main.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_main.c
@@ -11,7 +11,6 @@
 #include <linux/pci.h>
 #include <linux/vbox_err.h>
 
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_damage_helper.h>
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 9b98470593b06..b7a64c7dcc2c9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -35,7 +35,6 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_encoder.h>
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem.h>
diff --git a/drivers/gpu/drm/xen/xen_drm_front_gem.c b/drivers/gpu/drm/xen/xen_drm_front_gem.c
index e31554d7139f1..4c95ebcdcc2d3 100644
--- a/drivers/gpu/drm/xen/xen_drm_front_gem.c
+++ b/drivers/gpu/drm/xen/xen_drm_front_gem.c
@@ -12,7 +12,6 @@
 #include <linux/scatterlist.h>
 #include <linux/shmem_fs.h>
 
-#include <drm/drm_fb_helper.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_prime.h>
 #include <drm/drm_probe_helper.h>
-- 
2.38.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
