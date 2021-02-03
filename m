Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C222C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 13:10:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C96464F95
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 13:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C96464F95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 15B598684A;
	Wed,  3 Feb 2021 13:10:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LoefutqLSMaG; Wed,  3 Feb 2021 13:10:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1147386691;
	Wed,  3 Feb 2021 13:10:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0466C0174;
	Wed,  3 Feb 2021 13:10:56 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6E690C0FA7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 630A285F32
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ap0wkr_6h1Kw
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 73EEF854B4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:52 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 12487B12F;
 Wed,  3 Feb 2021 13:10:51 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kraxel@redhat.com, hdegoede@redhat.com,
 sean@poorly.run, sam@ravnborg.org, noralf@tronnes.org
Subject: [PATCH 4/6] drm/cirrus: Move vmap out of commit tail
Date: Wed,  3 Feb 2021 14:10:44 +0100
Message-Id: <20210203131046.22371-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210203131046.22371-1-tzimmermann@suse.de>
References: <20210203131046.22371-1-tzimmermann@suse.de>
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

The mapping is provided as GEM SHMEM shadow plane. The enable and prepare
callbacks use the established mapping for damage handling.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/tiny/Kconfig  |  3 ++-
 drivers/gpu/drm/tiny/cirrus.c | 45 +++++++++++++++--------------------
 2 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
index 2b6414f0fa75..e0aef6cf8e26 100644
--- a/drivers/gpu/drm/tiny/Kconfig
+++ b/drivers/gpu/drm/tiny/Kconfig
@@ -3,8 +3,9 @@
 config DRM_CIRRUS_QEMU
 	tristate "Cirrus driver for QEMU emulated device"
 	depends on DRM && PCI && MMU
-	select DRM_KMS_HELPER
 	select DRM_GEM_SHMEM_HELPER
+	select DRM_GEM_SHMEM_KMS_HELPER
+	select DRM_KMS_HELPER
 	help
 	 This is a KMS driver for emulated cirrus device in qemu.
 	 It is *NOT* intended for real cirrus devices. This requires
diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
index a043e602199e..aac627615b2d 100644
--- a/drivers/gpu/drm/tiny/cirrus.c
+++ b/drivers/gpu/drm/tiny/cirrus.c
@@ -33,8 +33,9 @@
 #include <drm/drm_file.h>
 #include <drm/drm_format_helper.h>
 #include <drm/drm_fourcc.h>
-#include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_gem_shmem_kms_helper.h>
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
@@ -441,9 +431,11 @@ static void cirrus_pipe_enable(struct drm_simple_display_pipe *pipe,
 			       struct drm_plane_state *plane_state)
 {
 	struct cirrus_device *cirrus = to_cirrus(pipe->crtc.dev);
+	struct drm_gem_shmem_shadow_plane_state *shadow_plane_state =
+		to_drm_gem_shmem_shadow_plane_state(plane_state);
 
 	cirrus_mode_set(cirrus, &crtc_state->mode, plane_state->fb);
-	cirrus_fb_blit_fullscreen(plane_state->fb);
+	cirrus_fb_blit_fullscreen(plane_state->fb, &shadow_plane_state->map[0]);
 }
 
 static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
@@ -451,16 +443,16 @@ static void cirrus_pipe_update(struct drm_simple_display_pipe *pipe,
 {
 	struct cirrus_device *cirrus = to_cirrus(pipe->crtc.dev);
 	struct drm_plane_state *state = pipe->plane.state;
+	struct drm_gem_shmem_shadow_plane_state *shadow_plane_state =
+		to_drm_gem_shmem_shadow_plane_state(state);
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
@@ -468,6 +460,7 @@ static const struct drm_simple_display_pipe_funcs cirrus_pipe_funcs = {
 	.check	    = cirrus_pipe_check,
 	.enable	    = cirrus_pipe_enable,
 	.update	    = cirrus_pipe_update,
+	DRM_GEM_SHMEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
 };
 
 static const uint32_t cirrus_formats[] = {
-- 
2.30.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
