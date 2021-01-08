Return-Path: <SRS0=LX6v=GL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA77C4332B
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:44:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55103233CF
	for <virtualization@archiver.kernel.org>; Fri,  8 Jan 2021 09:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55103233CF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E16A087341;
	Fri,  8 Jan 2021 09:43:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j6xntN36XXtz; Fri,  8 Jan 2021 09:43:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 16BE287327;
	Fri,  8 Jan 2021 09:43:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F4058C0893;
	Fri,  8 Jan 2021 09:43:54 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 90DC0C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8D63F875A4
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N24ufGv+DyWN
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CE7D58759A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 09:43:52 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6C39FAFBF;
 Fri,  8 Jan 2021 09:43:51 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: sumit.semwal@linaro.org, christian.koenig@amd.com, airlied@redhat.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 kraxel@redhat.com, hdegoede@redhat.com, sean@poorly.run, eric@anholt.net,
 sam@ravnborg.org
Subject: [PATCH v4 11/13] drm/vboxvideo: Use drm_gem_vram_vmap_local() in
 cursor update
Date: Fri,  8 Jan 2021 10:43:38 +0100
Message-Id: <20210108094340.15290-12-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108094340.15290-1-tzimmermann@suse.de>
References: <20210108094340.15290-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linaro-mm-sig@lists.linaro.org, virtualization@lists.linux-foundation.org,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org
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

Cursor updates in vboxvideo require a short-term mapping of the
source BO. Use drm_gem_vram_vmap_local() and avoid the pinning
operations.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/vboxvideo/vbox_mode.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vboxvideo/vbox_mode.c b/drivers/gpu/drm/vboxvideo/vbox_mode.c
index dbc0dd53c69e..215b37c78c10 100644
--- a/drivers/gpu/drm/vboxvideo/vbox_mode.c
+++ b/drivers/gpu/drm/vboxvideo/vbox_mode.c
@@ -381,7 +381,8 @@ static void vbox_cursor_atomic_update(struct drm_plane *plane,
 		container_of(plane->dev, struct vbox_private, ddev);
 	struct vbox_crtc *vbox_crtc = to_vbox_crtc(plane->state->crtc);
 	struct drm_framebuffer *fb = plane->state->fb;
-	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(fb->obj[0]);
+	struct drm_gem_object *obj = fb->obj[0];
+	struct drm_gem_vram_object *gbo = drm_gem_vram_of_gem(obj);
 	u32 width = plane->state->crtc_w;
 	u32 height = plane->state->crtc_h;
 	size_t data_size, mask_size;
@@ -401,11 +402,12 @@ static void vbox_cursor_atomic_update(struct drm_plane *plane,
 
 	vbox_crtc->cursor_enabled = true;
 
-	ret = drm_gem_vram_vmap(gbo, &map);
+	ret = dma_resv_lock(obj->resv, NULL);
+	if (ret)
+		return;
+	ret = drm_gem_vram_vmap_local(gbo, &map);
 	if (ret) {
-		/*
-		 * BUG: we should have pinned the BO in prepare_fb().
-		 */
+		dma_resv_unlock(obj->resv);
 		mutex_unlock(&vbox->hw_mutex);
 		DRM_WARN("Could not map cursor bo, skipping update\n");
 		return;
@@ -421,7 +423,8 @@ static void vbox_cursor_atomic_update(struct drm_plane *plane,
 	data_size = width * height * 4 + mask_size;
 
 	copy_cursor_image(src, vbox->cursor_data, width, height, mask_size);
-	drm_gem_vram_vunmap(gbo, &map);
+	drm_gem_vram_vunmap_local(gbo, &map);
+	dma_resv_unlock(obj->resv);
 
 	flags = VBOX_MOUSE_POINTER_VISIBLE | VBOX_MOUSE_POINTER_SHAPE |
 		VBOX_MOUSE_POINTER_ALPHA;
-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
