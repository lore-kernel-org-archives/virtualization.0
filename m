Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AB9C433E0
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 13:11:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C93664F9A
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 13:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C93664F9A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9723F87121;
	Wed,  3 Feb 2021 13:11:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZzZd6k2CH4Wz; Wed,  3 Feb 2021 13:10:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1F86287126;
	Wed,  3 Feb 2021 13:10:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1321C1DA7;
	Wed,  3 Feb 2021 13:10:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A92AC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 72EA62045E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o-dBPbPL+cyq
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id 4FA882001A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 13:10:51 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id CE307B12B;
 Wed,  3 Feb 2021 13:10:49 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, kraxel@redhat.com, hdegoede@redhat.com,
 sean@poorly.run, sam@ravnborg.org, noralf@tronnes.org
Subject: [PATCH 2/6] drm/shmem-helper: Add additional KMS helpers
Date: Wed,  3 Feb 2021 14:10:42 +0100
Message-Id: <20210203131046.22371-3-tzimmermann@suse.de>
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

Several drivers use GEM SHMEM buffer objects as shadow buffers for
the actual framebuffer memory. Right now, drivers do these vmap
operations in their commit tail, which is actually not allowed by the
locking rules for the dma-buf reservation lock. The involved SHMEM
BO has to be vmapped in the plane's prepare_fb callback and vunmapped
in cleanup_fb.

This patch introduces a DRM library that implements KMS helpers for
GEM SHMEM buffer objects. The first set of helpers is the plane state
for shadow planes. The provided implementations for prepare_fb and
cleanup_fb vmap and vunmap all BOs of struct drm_plane_state.fb. The
mappings are afterwards available in the plane's commit-tail functions.

All rsp drivers use the simple KMS helpers, so we add the plane callbacks
and wrappers for simple KMS.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/Kconfig                    |   7 +
 drivers/gpu/drm/Makefile                   |   1 +
 drivers/gpu/drm/drm_gem_shmem_kms_helper.c | 159 +++++++++++++++++++++
 include/drm/drm_gem_shmem_kms_helper.h     |  56 ++++++++
 4 files changed, 223 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_gem_shmem_kms_helper.c
 create mode 100644 include/drm/drm_gem_shmem_kms_helper.h

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 8bf103de1594..b8d8b00ab5d4 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -214,6 +214,13 @@ config DRM_GEM_SHMEM_HELPER
 	help
 	  Choose this if you need the GEM shmem helper functions
 
+config DRM_GEM_SHMEM_KMS_HELPER
+	bool
+	depends on DRM_GEM_SHMEM_HELPER
+	help
+	help
+	  Choose this if you need the GEM SHMEM helper functions for KMS
+
 config DRM_SCHED
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 926adef289db..37a73dee5baf 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -53,6 +53,7 @@ drm_kms_helper-$(CONFIG_DRM_FBDEV_EMULATION) += drm_fb_helper.o
 drm_kms_helper-$(CONFIG_DRM_KMS_CMA_HELPER) += drm_fb_cma_helper.o
 drm_kms_helper-$(CONFIG_DRM_DP_AUX_CHARDEV) += drm_dp_aux_dev.o
 drm_kms_helper-$(CONFIG_DRM_DP_CEC) += drm_dp_cec.o
+drm_kms_helper-$(CONFIG_DRM_GEM_SHMEM_KMS_HELPER) += drm_gem_shmem_kms_helper.o
 
 obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 obj-$(CONFIG_DRM_DEBUG_SELFTEST) += selftests/
diff --git a/drivers/gpu/drm/drm_gem_shmem_kms_helper.c b/drivers/gpu/drm/drm_gem_shmem_kms_helper.c
new file mode 100644
index 000000000000..8843c5837f98
--- /dev/null
+++ b/drivers/gpu/drm/drm_gem_shmem_kms_helper.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_gem_framebuffer_helper.h>
+#include <drm/drm_gem_shmem_helper.h>
+#include <drm/drm_gem_shmem_kms_helper.h>
+#include <drm/drm_simple_kms_helper.h>
+
+/*
+ * Helpers for struct drm_plane_funcs
+ *
+ */
+
+static struct drm_plane_state *
+drm_gem_shmem_duplicate_shadow_plane_state(struct drm_plane *plane,
+					   struct drm_plane_state *plane_state)
+{
+	struct drm_gem_shmem_shadow_plane_state *new_shadow_plane_state;
+
+	if (!plane_state)
+		return NULL;
+
+	new_shadow_plane_state = kzalloc(sizeof(*new_shadow_plane_state), GFP_KERNEL);
+	if (!new_shadow_plane_state)
+		return NULL;
+	__drm_atomic_helper_plane_duplicate_state(plane, &new_shadow_plane_state->base);
+
+	return &new_shadow_plane_state->base;
+}
+
+static void drm_gem_shmem_destroy_shadow_plane_state(struct drm_plane *plane,
+						     struct drm_plane_state *plane_state)
+{
+	struct drm_gem_shmem_shadow_plane_state *shadow_plane_state =
+		to_drm_gem_shmem_shadow_plane_state(plane_state);
+
+	__drm_atomic_helper_plane_destroy_state(&shadow_plane_state->base);
+	kfree(shadow_plane_state);
+}
+
+static void drm_gem_shmem_reset_shadow_plane(struct drm_plane *plane)
+{
+	struct drm_gem_shmem_shadow_plane_state *shadow_plane_state;
+
+	if (plane->state) {
+		drm_gem_shmem_destroy_shadow_plane_state(plane, plane->state);
+		plane->state = NULL; /* must be set to NULL here */
+	}
+
+	shadow_plane_state = kzalloc(sizeof(*shadow_plane_state), GFP_KERNEL);
+	if (!shadow_plane_state)
+		return;
+	__drm_atomic_helper_plane_reset(plane, &shadow_plane_state->base);
+}
+
+/*
+ * Helpers for struct drm_plane_helper_funcs
+ */
+
+static int drm_gem_shmem_prepare_shadow_fb(struct drm_plane *plane,
+					   struct drm_plane_state *plane_state)
+{
+	struct drm_gem_shmem_shadow_plane_state *shadow_plane_state =
+		to_drm_gem_shmem_shadow_plane_state(plane_state);
+	struct drm_framebuffer *fb = plane_state->fb;
+	struct drm_gem_object *obj;
+	struct dma_buf_map map;
+	int ret;
+	size_t i;
+
+	if (!fb)
+		return 0;
+
+	ret = drm_gem_fb_prepare_fb(plane, plane_state);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(shadow_plane_state->map); ++i) {
+		obj = drm_gem_fb_get_obj(fb, i);
+		if (!obj)
+			continue;
+		ret = drm_gem_shmem_vmap(obj, &map);
+		if (ret)
+			goto err_drm_gem_shmem_vunmap;
+		shadow_plane_state->map[i] = map;
+	}
+
+	return 0;
+
+err_drm_gem_shmem_vunmap:
+	while (i) {
+		--i;
+		obj = drm_gem_fb_get_obj(fb, i);
+		if (!obj)
+			continue;
+		drm_gem_shmem_vunmap(obj, &shadow_plane_state->map[i]);
+	}
+	return ret;
+}
+
+static void drm_gem_shmem_cleanup_shadow_fb(struct drm_plane *plane,
+					    struct drm_plane_state *plane_state)
+{
+	struct drm_gem_shmem_shadow_plane_state *shadow_plane_state =
+		to_drm_gem_shmem_shadow_plane_state(plane_state);
+	struct drm_framebuffer *fb = plane_state->fb;
+	size_t i = ARRAY_SIZE(shadow_plane_state->map);
+	struct drm_gem_object *obj;
+
+	if (!fb)
+		return;
+
+	while (i) {
+		--i;
+		obj = drm_gem_fb_get_obj(fb, i);
+		if (!obj)
+			continue;
+		drm_gem_shmem_vunmap(obj, &shadow_plane_state->map[i]);
+	}
+}
+
+/*
+ * Simple KMS helpers
+ */
+
+int drm_gem_shmem_simple_kms_prepare_shadow_fb(struct drm_simple_display_pipe *pipe,
+					       struct drm_plane_state *plane_state)
+{
+	return drm_gem_shmem_prepare_shadow_fb(&pipe->plane, plane_state);
+}
+EXPORT_SYMBOL(drm_gem_shmem_simple_kms_prepare_shadow_fb);
+
+void drm_gem_shmem_simple_kms_cleanup_shadow_fb(struct drm_simple_display_pipe *pipe,
+						struct drm_plane_state *plane_state)
+{
+	drm_gem_shmem_cleanup_shadow_fb(&pipe->plane, plane_state);
+}
+EXPORT_SYMBOL(drm_gem_shmem_simple_kms_cleanup_shadow_fb);
+
+void drm_gem_shmem_simple_kms_reset_shadow_plane(struct drm_simple_display_pipe *pipe)
+{
+	drm_gem_shmem_reset_shadow_plane(&pipe->plane);
+}
+EXPORT_SYMBOL(drm_gem_shmem_simple_kms_reset_shadow_plane);
+
+struct drm_plane_state *
+drm_gem_shmem_simple_kms_duplicate_shadow_plane_state(struct drm_simple_display_pipe *pipe,
+						      struct drm_plane_state *plane_state)
+{
+	return drm_gem_shmem_duplicate_shadow_plane_state(&pipe->plane, plane_state);
+}
+EXPORT_SYMBOL(drm_gem_shmem_simple_kms_duplicate_shadow_plane_state);
+
+void drm_gem_shmem_simple_kms_destroy_shadow_plane_state(struct drm_simple_display_pipe *pipe,
+							 struct drm_plane_state *plane_state)
+{
+	drm_gem_shmem_destroy_shadow_plane_state(&pipe->plane, plane_state);
+}
+EXPORT_SYMBOL(drm_gem_shmem_simple_kms_destroy_shadow_plane_state);
diff --git a/include/drm/drm_gem_shmem_kms_helper.h b/include/drm/drm_gem_shmem_kms_helper.h
new file mode 100644
index 000000000000..bd42c9c0a39e
--- /dev/null
+++ b/include/drm/drm_gem_shmem_kms_helper.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __DRM_GEM_SHMEM_KMS_HELPER_H__
+#define __DRM_GEM_SHMEM_KMS_HELPER_H__
+
+#include <linux/dma-buf-map.h>
+
+#include <drm/drm_plane.h>
+
+struct drm_simple_display_pipe;
+
+struct drm_gem_shmem_shadow_plane_state {
+	struct drm_plane_state base;
+
+	/* Transitional state - do not export or duplicate */
+
+	struct dma_buf_map map[4];
+};
+
+static inline struct drm_gem_shmem_shadow_plane_state *
+to_drm_gem_shmem_shadow_plane_state(struct drm_plane_state *state)
+{
+	return container_of(state, struct drm_gem_shmem_shadow_plane_state, base);
+}
+
+/*
+ * Simple KMS helpers
+ */
+
+int drm_gem_shmem_simple_kms_prepare_shadow_fb(struct drm_simple_display_pipe *pipe,
+					       struct drm_plane_state *plane_state);
+void drm_gem_shmem_simple_kms_cleanup_shadow_fb(struct drm_simple_display_pipe *pipe,
+						struct drm_plane_state *plane_state);
+void drm_gem_shmem_simple_kms_reset_shadow_plane(struct drm_simple_display_pipe *pipe);
+struct drm_plane_state *
+drm_gem_shmem_simple_kms_duplicate_shadow_plane_state(struct drm_simple_display_pipe *pipe,
+						      struct drm_plane_state *plane_state);
+void
+drm_gem_shmem_simple_kms_destroy_shadow_plane_state(struct drm_simple_display_pipe *pipe,
+						    struct drm_plane_state *plane_state);
+
+/**
+ * DRM_GEM_SHMEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS -
+ *	Initializes struct drm_simple_display_pipe_funcs for SHMEM shadow planes
+ *
+ * Drivers may use GEM SHMEM BOs as shadow buffers over the framebuffer memory. This
+ * macro initializes struct drm_simple_display_pipe_funcs to use the rsp helper functions.
+ */
+#define DRM_GEM_SHMEM_SIMPLE_DISPLAY_PIPE_SHADOW_PLANE_FUNCS \
+	.prepare_fb = drm_gem_shmem_simple_kms_prepare_shadow_fb, \
+	.cleanup_fb = drm_gem_shmem_simple_kms_cleanup_shadow_fb, \
+	.reset_plane = drm_gem_shmem_simple_kms_reset_shadow_plane, \
+	.duplicate_plane_state = drm_gem_shmem_simple_kms_duplicate_shadow_plane_state, \
+	.destroy_plane_state   = drm_gem_shmem_simple_kms_destroy_shadow_plane_state
+
+#endif /* __DRM_GEM_SHMEM_KMS_HELPER_H__ */
-- 
2.30.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
