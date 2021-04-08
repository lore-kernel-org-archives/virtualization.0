Return-Path: <SRS0=B6Di=JF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3B8C433B4
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 14:01:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E156610E5
	for <virtualization@archiver.kernel.org>; Thu,  8 Apr 2021 14:01:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E156610E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3EF0C405CB;
	Thu,  8 Apr 2021 14:01:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DmZOmtZPzhuX; Thu,  8 Apr 2021 14:01:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B6A5840100;
	Thu,  8 Apr 2021 14:01:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF4E2C001C;
	Thu,  8 Apr 2021 14:01:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EFE0C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 14:01:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6E63240100
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 14:01:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dj4zlIWONNw7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 14:01:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC57F40115
 for <virtualization@lists.linux-foundation.org>;
 Thu,  8 Apr 2021 14:01:44 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 5A06FB08C;
 Thu,  8 Apr 2021 14:01:43 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, bskeggs@redhat.com, kraxel@redhat.com
Subject: [PATCH v2 3/4] drm/nouveau: Use drm_gem_ttm_dumb_map_offset()
Date: Thu,  8 Apr 2021 16:01:38 +0200
Message-Id: <20210408140139.27731-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210408140139.27731-1-tzimmermann@suse.de>
References: <20210408140139.27731-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, Maxime Ripard <maxime@cerno.tech>,
 Thomas Zimmermann <tzimmermann@suse.de>, spice-devel@lists.freedesktop.org
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

Nouveau now uses drm_gem_ttm_dumb_map_offset() to implement
struct drm_driver.dumb_map_offset.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 18 ------------------
 drivers/gpu/drm/nouveau/nouveau_display.h |  2 --
 drivers/gpu/drm/nouveau/nouveau_drm.c     |  3 ++-
 3 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index dac02c7be54d..14101bd2a0ff 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -838,21 +838,3 @@ nouveau_display_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
 	drm_gem_object_put(&bo->bo.base);
 	return ret;
 }
-
-int
-nouveau_display_dumb_map_offset(struct drm_file *file_priv,
-				struct drm_device *dev,
-				uint32_t handle, uint64_t *poffset)
-{
-	struct drm_gem_object *gem;
-
-	gem = drm_gem_object_lookup(file_priv, handle);
-	if (gem) {
-		struct nouveau_bo *bo = nouveau_gem_object(gem);
-		*poffset = drm_vma_node_offset_addr(&bo->bo.base.vma_node);
-		drm_gem_object_put(gem);
-		return 0;
-	}
-
-	return -ENOENT;
-}
diff --git a/drivers/gpu/drm/nouveau/nouveau_display.h b/drivers/gpu/drm/nouveau/nouveau_display.h
index 616c43427059..2ab2ddb1eadf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.h
+++ b/drivers/gpu/drm/nouveau/nouveau_display.h
@@ -58,8 +58,6 @@ bool nouveau_display_scanoutpos(struct drm_crtc *crtc,
 
 int  nouveau_display_dumb_create(struct drm_file *, struct drm_device *,
 				 struct drm_mode_create_dumb *args);
-int  nouveau_display_dumb_map_offset(struct drm_file *, struct drm_device *,
-				     u32 handle, u64 *offset);
 
 void nouveau_hdmi_mode_set(struct drm_encoder *, struct drm_display_mode *);
 
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 885815ea917f..9766218a99ca 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -31,6 +31,7 @@
 #include <linux/mmu_notifier.h>
 
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_gem_ttm_helper.h>
 #include <drm/drm_ioctl.h>
 #include <drm/drm_vblank.h>
 
@@ -1212,7 +1213,7 @@ driver_stub = {
 	.gem_prime_import_sg_table = nouveau_gem_prime_import_sg_table,
 
 	.dumb_create = nouveau_display_dumb_create,
-	.dumb_map_offset = nouveau_display_dumb_map_offset,
+	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
 
 	.name = DRIVER_NAME,
 	.desc = DRIVER_DESC,
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
