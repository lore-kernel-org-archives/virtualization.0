Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E622C433E6
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 13:11:01 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A1A464F99
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 13:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A1A464F99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9385B87117;
	Wed,  3 Feb 2021 13:11:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GSqPFZZ4-OtL; Wed,  3 Feb 2021 13:10:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 893E48711B;
	Wed,  3 Feb 2021 13:10:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74A50C1DA7;
	Wed,  3 Feb 2021 13:10:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B4ED7C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A3E2185F51
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NiyLKsnY1QWV
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AE65085F32
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:53 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 492E5B133;
 Wed,  3 Feb 2021 13:10:52 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kraxel@redhat.com, hdegoede@redhat.com,
 sean@poorly.run, sam@ravnborg.org, noralf@tronnes.org
Subject: [PATCH 6/6] drm/udl: Move vmap out of commit tail
Date: Wed,  3 Feb 2021 14:10:46 +0100
Message-Id: <20210203131046.22371-7-tzimmermann@suse.de>
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
 drivers/gpu/drm/udl/Kconfig       |  1 +
 drivers/gpu/drm/udl/udl_modeset.c | 36 +++++++++++++------------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/udl/Kconfig b/drivers/gpu/drm/udl/Kconfig
index 1f497d8f1ae5..1b46d93ca61c 100644
--- a/drivers/gpu/drm/udl/Kconfig
+++ b/drivers/gpu/drm/udl/Kconfig
@@ -5,6 +5,7 @@ config DRM_UDL
 	depends on USB
 	depends on USB_ARCH_HAS_HCD
 	select DRM_GEM_SHMEM_HELPER
+	select DRM_GEM_SHMEM_KMS_HELPER
 	select DRM_KMS_HELPER
 	help
 	  This is a KMS driver for the USB displaylink video adapters.
diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index 9d34ec9d03f6..974dffe86a44 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -17,6 +17,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_gem_shmem_kms_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_vblank.h>
 
@@ -266,18 +267,17 @@ static int udl_aligned_damage_clip(struct drm_rect *clip, int x, int y,
 	return 0;
 }
 
-static int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
-			     int width, int height)
+static int udl_handle_damage(struct drm_framebuffer *fb, const struct dma_buf_map *map,
+			     int x, int y, int width, int height)
 {
 	struct drm_device *dev = fb->dev;
 	struct dma_buf_attachment *import_attach = fb->obj[0]->import_attach;
+	void *vaddr = map->vaddr; /* TODO: Use mapping abstraction properly */
 	int i, ret, tmp_ret;
 	char *cmd;
 	struct urb *urb;
 	struct drm_rect clip;
 	int log_bpp;
-	struct dma_buf_map map;
-	void *vaddr;
 
 	ret = udl_log_cpp(fb->format->cpp[0]);
 	if (ret < 0)
@@ -297,17 +297,10 @@ static int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
 			return ret;
 	}
 
-	ret = drm_gem_shmem_vmap(fb->obj[0], &map);
-	if (ret) {
-		DRM_ERROR("failed to vmap fb\n");
-		goto out_dma_buf_end_cpu_access;
-	}
-	vaddr = map.vaddr; /* TODO: Use mapping abstraction properly */
-
 	urb = udl_get_urb(dev);
 	if (!urb) {
 		ret = -ENOMEM;
-		goto out_drm_gem_shmem_vunmap;
+		goto out_dma_buf_end_cpu_access;
 	}
 	cmd = urb->transfer_buffer;
 
@@ -320,7 +313,7 @@ static int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
 				       &cmd, byte_offset, dev_byte_offset,
 				       byte_width);
 		if (ret)
-			goto out_drm_gem_shmem_vunmap;
+			goto out_dma_buf_end_cpu_access;
 	}
 
 	if (cmd > (char *)urb->transfer_buffer) {
@@ -336,8 +329,6 @@ static int udl_handle_damage(struct drm_framebuffer *fb, int x, int y,
 
 	ret = 0;
 
-out_drm_gem_shmem_vunmap:
-	drm_gem_shmem_vunmap(fb->obj[0], &map);
 out_dma_buf_end_cpu_access:
 	if (import_attach) {
 		tmp_ret = dma_buf_end_cpu_access(import_attach->dmabuf,
@@ -375,6 +366,8 @@ udl_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 	struct drm_framebuffer *fb = plane_state->fb;
 	struct udl_device *udl = to_udl(dev);
 	struct drm_display_mode *mode = &crtc_state->mode;
+	struct drm_gem_shmem_shadow_plane_state *shadow_plane_state =
+		to_drm_gem_shmem_shadow_plane_state(plane_state);
 	char *buf;
 	char *wrptr;
 	int color_depth = UDL_COLOR_DEPTH_16BPP;
@@ -400,7 +393,7 @@ udl_simple_display_pipe_enable(struct drm_simple_display_pipe *pipe,
 
 	udl->mode_buf_len = wrptr - buf;
 
-	udl_handle_damage(fb, 0, 0, fb->width, fb->height);
+	udl_handle_damage(fb, &shadow_plane_state->map[0], 0, 0, fb->width, fb->height);
 
 	if (!crtc_state->mode_changed)
 		return;
@@ -435,6 +428,8 @@ udl_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
 			       struct drm_plane_state *old_plane_state)
 {
 	struct drm_plane_state *state = pipe->plane.state;
+	struct drm_gem_shmem_shadow_plane_state *shadow_plane_state =
+		to_drm_gem_shmem_shadow_plane_state(state);
 	struct drm_framebuffer *fb = state->fb;
 	struct drm_rect rect;
 
@@ -442,17 +437,16 @@ udl_simple_display_pipe_update(struct drm_simple_display_pipe *pipe,
 		return;
 
 	if (drm_atomic_helper_damage_merged(old_plane_state, state, &rect))
-		udl_handle_damage(fb, rect.x1, rect.y1, rect.x2 - rect.x1,
-				  rect.y2 - rect.y1);
+		udl_handle_damage(fb, &shadow_plane_state->map[0], rect.x1, rect.y1,
+				  rect.x2 - rect.x1, rect.y2 - rect.y1);
 }
 
-static const
-struct drm_simple_display_pipe_funcs udl_simple_display_pipe_funcs = {
+static const struct drm_simple_display_pipe_funcs udl_simple_display_pipe_funcs = {
 	.mode_valid = udl_simple_display_pipe_mode_valid,
 	.enable = udl_simple_display_pipe_enable,
 	.disable = udl_simple_display_pipe_disable,
 	.update = udl_simple_display_pipe_update,
-	.prepare_fb = drm_gem_fb_simple_display_pipe_prepare_fb,
+	DRM_GEM_SHMEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS,
 };
 
 /*
-- 
2.30.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
