Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC73C433E6
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 15:06:41 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B6406509A
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 15:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B6406509A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4567786B3B;
	Fri,  5 Feb 2021 15:06:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Uh9NrwbRZuiR; Fri,  5 Feb 2021 15:06:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E881986B47;
	Fri,  5 Feb 2021 15:06:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA46BC1DA9;
	Fri,  5 Feb 2021 15:06:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0F67C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B0F2D87074
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OSBvqvChRs5c
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:06:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D50C387035
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 15:06:34 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6BA62AF85;
 Fri,  5 Feb 2021 15:06:33 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kraxel@redhat.com, hdegoede@redhat.com,
 sean@poorly.run, sam@ravnborg.org, noralf@tronnes.org
Subject: [PATCH v2 5/7] drm/cirrus: Move vmap out of commit tail
Date: Fri,  5 Feb 2021 16:06:26 +0100
Message-Id: <20210205150628.28072-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205150628.28072-1-tzimmermann@suse.de>
References: <20210205150628.28072-1-tzimmermann@suse.de>
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
 drivers/gpu/drm/tiny/cirrus.c | 43 ++++++++++++++---------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index a043e602199e..ad922c3ec681 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -33,8 +33,9 @@
 #include <drm/drm_file.h>
 #include <drm/drm_format_helper.h>
 #include <drm/drm_fourcc.h>
-#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_ioctl.h>
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper_vtables.h>
@@ -311,22 +312,15 @@ static int cirrus_mode_set(struct cirrus_device *cirrus,
 	return 0;
 }
 
-static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
+static int cirrus_fb_blit_rect(struct drm_framebuffer *fb, const struct dma_buf_map *map,
 			       struct drm_rect *rect)
 {
 	struct cirrus_device *cirrus = to_cirrus(fb->dev);
-	struct dma_buf_map map;
-	void *vmap;
-	int idx, ret;
+	void *vmap = map->vaddr; /* TODO: Use mapping abstraction properly */
+	int idx;
 
-	ret = -ENODEV;
 	if (!drm_dev_enter(&cirrus->dev, &idx))
-		goto out;
-
-	ret = drm_gem_shmem_vmap(fb->obj[0], &map);
-	if (ret)
-		goto out_dev_exit;
-	vmap = map.vaddr; /* TODO: Use mapping abstraction properly */
+		return -ENODEV;
 
 	if (cirrus->cpp == fb->format->cpp[0])
 		drm_fb_memcpy_dstclip(cirrus->vram,
@@ -345,16 +339,12 @@ static int cirrus_fb_blit_rect(struct drm_framebuffer *fb,
 	else
 		WARN_ON_ONCE("cpp mismatch");
 
-	drm_gem_shmem_vunmap(fb->obj[0], &map);
-	ret = 0;
-
-out_dev_exit:
 	drm_dev_exit(idx);
-out:
-	return ret;
+
+	return 0;
 }
 
-static int cirrus_fb_blit_fullscreen(struct drm_framebuffer *fb)
+static int cirrus_fb_blit_fullscreen(struct drm_framebuffer *fb, const struct dma_buf_map *map)
 {
 	struct drm_rect fullscreen = {
 		.x1 = 0,
@@ -362,7 +352,7 @@ static int cirrus_fb_blit_fullscreen(struct drm_framebuffer *fb)
 		.y1 = 0,
 		.y2 = fb->height,
 	};
-	return cirrus_fb_blit_rect(fb, &fullscreen);
+	return cirrus_fb_blit_rect(fb, map, &fullscreen);
 }
 
 static int cirrus_check_size(int width, int height,
@@ -441,9 +431,10 @@ static void cirrus_pipe_enable(struct drm_simple_display_pipe *pipe,
 			       struct drm_plane_state *plane_state)
 {
 	struct cirrus_device *cirrus = to_cirrus(pipe->crtc.dev);
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(plane_state);
 
 	cirrus_mode_set(cirrus, &crtc_state->mode, plane_state->fb);
-	cirrus_fb_blit_fullscreen(plane_state->fb);
+	cirrus_fb_blit_fullscreen(plane_state->fb, &shadow_plane_state->map[0]);
 }
 
 static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
@@ -451,16 +442,15 @@ static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
 {
 	struct cirrus_device *cirrus = to_cirrus(pipe->crtc.dev);
 	struct drm_plane_state *state = pipe->plane.state;
+	struct drm_shadow_plane_state *shadow_plane_state = to_drm_shadow_plane_state(state);
 	struct drm_crtc *crtc = &pipe->crtc;
 	struct drm_rect rect;
 
-	if (pipe->plane.state->fb &&
-	    cirrus->cpp != cirrus_cpp(pipe->plane.state->fb))
-		cirrus_mode_set(cirrus, &crtc->mode,
-				pipe->plane.state->fb);
+	if (state->fb && cirrus->cpp != cirrus_cpp(state->fb))
+		cirrus_mode_set(cirrus, &crtc->mode, state->fb);
 
 	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
-		cirrus_fb_blit_rect(pipe->plane.state->fb, &rect);
+		cirrus_fb_blit_rect(state->fb, &shadow_plane_state->map[0], &rect);
 }
 
 static const struct drm_simple_display_pipe_funcs cirrus_pipe_funcs = {
@@ -468,6 +458,7 @@ static const struct drm_simple_display_pipe_funcs cirrus_pipe_funcs = {
 	.check	    = cirrus_pipe_check,
 	.enable	    = cirrus_pipe_enable,
 	.update	    = cirrus_pipe_update,
+	DRM_GEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
 };
 
 static const uint32_t cirrus_formats[] = {
-- 
2.30.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
