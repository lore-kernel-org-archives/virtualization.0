Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3905AC43381
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 11:55:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8667364E8A
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 11:55:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8667364E8A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2E6FC8708D;
	Mon,  8 Feb 2021 11:55:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WdeIYg8hVBab; Mon,  8 Feb 2021 11:55:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 93F6E8702B;
	Mon,  8 Feb 2021 11:55:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7DA34C0174;
	Mon,  8 Feb 2021 11:55:48 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B916C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 11:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7CE898707A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 11:55:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n-JpUjBy19ih
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 11:55:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9EC278702B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 11:55:44 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 37B36AF00;
 Mon,  8 Feb 2021 11:55:43 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kraxel@redhat.com, hdegoede@redhat.com,
 sean@poorly.run, sam@ravnborg.org, noralf@tronnes.org
Subject: [PATCH v3 4/7] drm/mgag200: Move vmap out of commit tail
Date: Mon,  8 Feb 2021 12:55:35 +0100
Message-Id: <20210208115538.6430-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210208115538.6430-1-tzimmermann@suse.de>
References: <20210208115538.6430-1-tzimmermann@suse.de>
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

Vmap operations may acquire the dmabuf reservation lock, which is not
allowed within atomic commit-tail functions. Therefore move vmap and
vunmap from the damage handler into prepare_fb and cleanup_fb callbacks.

The mapping is provided as GEM shadow-buffered plane. The functions in
the commit tail use the pre-established mapping for damage handling.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Tested-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index c3dfde8cad25..cece3e57fb27 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -17,6 +17,7 @@
 #include <drm/drm_damage_helper.h>
 #include <drm/drm_format_helper.h>
 #include <drm/drm_fourcc.h>
+#include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_plane_helper.h>
 #include <drm/drm_print.h>
@@ -1549,22 +1550,12 @@ mgag200_simple_display_pipe_mode_valid(struct drm_simple_display_pipe *pipe,
 
 static void
 mgag200_handle_damage(struct mga_device *mdev, struct drm_framebuffer *fb,
-		      struct drm_rect *clip)
+		      struct drm_rect *clip, const struct dma_buf_map *map)
 {
-	struct drm_device *dev = &mdev->base;
-	struct dma_buf_map map;
-	void *vmap;
-	int ret;
-
-	ret = drm_gem_shmem_vmap(fb->obj[0], &map);
-	if (drm_WARN_ON(dev, ret))
-		return; /* BUG: SHMEM BO should always be vmapped */
-	vmap = map.vaddr; /* TODO: Use mapping abstraction properly */
+	void *vmap = map->vaddr; /* TODO: Use mapping abstraction properly */
 
 	drm_fb_memcpy_dstclip(mdev->vram, vmap, fb, clip);
 
-	drm_gem_shmem_vunmap(fb->obj[0], &map);
-
 	/* Always scanout image at VRAM offset 0 */
 	mgag200_set_startadd(mdev, (u32)0);
 	mgag200_set_offset(mdev, fb);
@@ -1580,6 +1571,7 @@ mgag200_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 	struct mga_device *mdev = to_mga_device(dev);
 	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
 	struct drm_framebuffer *fb = plane_state->fb;
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 	struct drm_rect fullscreen = {
 		.x1 = 0,
 		.x2 = fb->width,
@@ -1608,7 +1600,7 @@ mgag200_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 	mga_crtc_load_lut(crtc);
 	mgag200_enable_display(mdev);
 
-	mgag200_handle_damage(mdev, fb, &fullscreen);
+	mgag200_handle_damage(mdev, fb, &fullscreen, &shadow_plane_state->map[0]);
 }
 
 static void
@@ -1649,6 +1641,7 @@ mgag200_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
 	struct drm_device *dev = plane->dev;
 	struct mga_device *mdev = to_mga_device(dev);
 	struct drm_plane_state *state = plane->state;
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
 	struct drm_framebuffer *fb = state->fb;
 	struct drm_rect damage;
 
@@ -1656,7 +1649,7 @@ mgag200_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
 		return;
 
 	if (drm_atomic_helper_damage_merged(old_state, state, &damage))
-		mgag200_handle_damage(mdev, fb, &damage);
+		mgag200_handle_damage(mdev, fb, &damage, &shadow_plane_state->map[0]);
 }
 
 static const struct drm_simple_display_pipe_funcs
@@ -1666,7 +1659,7 @@ mgag200_simple_display_pipe_funcs = {
 	.disable    = mgag200_simple_display_pipe_disable,
 	.check	    = mgag200_simple_display_pipe_check,
 	.update	    = mgag200_simple_display_pipe_update,
-	.prepare_fb = drm_gem_fb_simple_display_pipe_prepare_fb,
+	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
 };
 
 static const uint32_t mgag200_simple_display_pipe_formats[] = {
-- 
2.30.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
