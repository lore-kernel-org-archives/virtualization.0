Return-Path: <SRS0=fSyG=FF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B76CC83013
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 10:36:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7AB2080A
	for <virtualization@archiver.kernel.org>; Tue,  1 Dec 2020 10:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7AB2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B45748752B;
	Tue,  1 Dec 2020 10:36:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uq7j8EqBIRiF; Tue,  1 Dec 2020 10:36:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 757888750F;
	Tue,  1 Dec 2020 10:36:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 601BEC163C;
	Tue,  1 Dec 2020 10:36:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 033FBC0052
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F2C99880A9
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:35:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5yhJSscuUyv1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:35:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A25888808B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Dec 2020 10:35:54 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4712CAD4A;
 Tue,  1 Dec 2020 10:35:53 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@linux.ie,
	daniel@ffwll.ch
Subject: [PATCH v2 06/20] drm/gma500: Fix trailing whitespaces
Date: Tue,  1 Dec 2020 11:35:28 +0100
Message-Id: <20201201103542.2182-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201103542.2182-1-tzimmermann@suse.de>
References: <20201201103542.2182-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, nouveau@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, amd-gfx@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, spice-devel@lists.freedesktop.org,
 intel-gvt-dev@lists.freedesktop.org
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

Adhere to kernel coding style.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
---
 drivers/gpu/drm/gma500/cdv_device.c      | 8 ++++----
 drivers/gpu/drm/gma500/intel_bios.c      | 4 ++--
 drivers/gpu/drm/gma500/oaktrail_device.c | 2 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c  | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500/cdv_device.c
index e75293e4a52f..e0b728f246fb 100644
--- a/drivers/gpu/drm/gma500/cdv_device.c
+++ b/drivers/gpu/drm/gma500/cdv_device.c
@@ -421,16 +421,16 @@ static int cdv_power_up(struct drm_device *dev)
 static void cdv_hotplug_work_func(struct work_struct *work)
 {
         struct drm_psb_private *dev_priv = container_of(work, struct drm_psb_private,
-							hotplug_work);                 
+							hotplug_work);
         struct drm_device *dev = dev_priv->dev;
 
         /* Just fire off a uevent and let userspace tell us what to do */
         drm_helper_hpd_irq_event(dev);
-}                       
+}
 
 /* The core driver has received a hotplug IRQ. We are in IRQ context
    so extract the needed information and kick off queued processing */
-   
+
 static int cdv_hotplug_event(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv = dev->dev_private;
@@ -449,7 +449,7 @@ static void cdv_hotplug_enable(struct drm_device *dev, bool on)
 	}  else {
 		REG_WRITE(PORT_HOTPLUG_EN, 0);
 		REG_WRITE(PORT_HOTPLUG_STAT, REG_READ(PORT_HOTPLUG_STAT));
-	}	
+	}
 }
 
 static const char *force_audio_names[] = {
diff --git a/drivers/gpu/drm/gma500/intel_bios.c b/drivers/gpu/drm/gma500/intel_bios.c
index 8ad6337eeba3..08e1dacbdbc8 100644
--- a/drivers/gpu/drm/gma500/intel_bios.c
+++ b/drivers/gpu/drm/gma500/intel_bios.c
@@ -50,7 +50,7 @@ parse_edp(struct drm_psb_private *dev_priv, struct bdb_header *bdb)
 	uint8_t	panel_type;
 
 	edp = find_section(bdb, BDB_EDP);
-	
+
 	dev_priv->edp.bpp = 18;
 	if (!edp) {
 		if (dev_priv->edp.support) {
@@ -80,7 +80,7 @@ parse_edp(struct drm_psb_private *dev_priv, struct bdb_header *bdb)
 	dev_priv->edp.pps = *edp_pps;
 
 	DRM_DEBUG_KMS("EDP timing in vbt t1_t3 %d t8 %d t9 %d t10 %d t11_t12 %d\n",
-				dev_priv->edp.pps.t1_t3, dev_priv->edp.pps.t8, 
+				dev_priv->edp.pps.t1_t3, dev_priv->edp.pps.t8,
 				dev_priv->edp.pps.t9, dev_priv->edp.pps.t10,
 				dev_priv->edp.pps.t11_t12);
 
diff --git a/drivers/gpu/drm/gma500/oaktrail_device.c b/drivers/gpu/drm/gma500/oaktrail_device.c
index 8754290b0e23..d9f8324f7c58 100644
--- a/drivers/gpu/drm/gma500/oaktrail_device.c
+++ b/drivers/gpu/drm/gma500/oaktrail_device.c
@@ -505,7 +505,7 @@ static int oaktrail_chip_setup(struct drm_device *dev)
 {
 	struct drm_psb_private *dev_priv = dev->dev_private;
 	int ret;
-	
+
 	if (pci_enable_msi(dev->pdev))
 		dev_warn(dev->dev, "Enabling MSI failed!\n");
 
diff --git a/drivers/gpu/drm/gma500/psb_intel_lvds.c b/drivers/gpu/drm/gma500/psb_intel_lvds.c
index 063c66bb946d..49228e2cf480 100644
--- a/drivers/gpu/drm/gma500/psb_intel_lvds.c
+++ b/drivers/gpu/drm/gma500/psb_intel_lvds.c
@@ -216,7 +216,7 @@ static void psb_intel_lvds_set_power(struct drm_device *dev, bool on)
 	        dev_err(dev->dev, "set power, chip off!\n");
 		return;
         }
-        
+
 	if (on) {
 		REG_WRITE(PP_CONTROL, REG_READ(PP_CONTROL) |
 			  POWER_TARGET_ON);
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
