Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34675381B16
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 16:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440306; cv=none; b=szkIknyVXjTW53JIKwcq971seONgocPccF6BnbAQI3NzvZhROsCqBK3wAnJ4NTZoq3QCmg8qBKOuTuawmEjHAphTHBTPdhWTvEprduL5NlhzKd5l+oWODGElY0wREcw4PtGmJln/7SG5uos59U0ZNlgqDbwJvbz0tpG1Nb3khlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440306; c=relaxed/simple;
	bh=ysEVnUVhmQbvkTNS8ixJiIvNoHn6EF35TAnvlUWw1wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Shib2gYlrMOXPiP6H30e8mzKJqgf1m8YrcF9x0IQSHiMikkjXTbWs7BO98UXdFALEzMuFh/66OAnlxiBqWxCdf9ZxrhFtnmWOdbBgzScA8LW8zKr+8LuI6glqGZGgrEFJLjwScUaDgqR7w5Tp/74BzMRZCEFW8lekzGrBpj61rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2HYw1n/; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2HYw1n/"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-93c65bc4616so22429985a.1
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 09:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440298; x=1791045098; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=60WAUxziU7muSXLNkG9SMKlAL+mMs9W/WR/Iki3BFx0=;
        b=o2HYw1n/ArOwvorQIUoyB0X/UaIEvrtT3s5CNPE+CpeWay9Xr4lsq6/z4M5jgSG8tA
         Y97bansT9LGqlwf7lcU+Qk5ij2GkgmKThooZfAmOUKaQEsdO00TYCl0xq1crv4e21FFd
         e3LRKX4Lgp3llRxdEwwNXAl0WUzeCRWpoG7CCiuUG4DuGyLIZDhFcm8I8bhimVcUbl2k
         DPn/auJ3beNCpDiKHnu+x58QFsOyxwxMVJJaW9xxgkmIeVZ6b+FMR1EGC1798CO3ghQD
         NHspctLfT0ezDkaeVSuPzZEqRLioKYpOg62G7W9+SkiCJNQUkQzSAud68yOkP/2dwNZZ
         MNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440298; x=1791045098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=60WAUxziU7muSXLNkG9SMKlAL+mMs9W/WR/Iki3BFx0=;
        b=xy099+BAyPtU8xS51jAd+3bWe+F7XbjHnTia/toe/UfAluJ8Jwj0wF1RTzktvJC+WF
         CuJ29xfMQ5y3sDCZy1/hYIiJ2gwLQbQXpDiVHCOvLPv66ABxMuqvGR6YLUydb7yhtX6o
         lmWIScMb/+mEVt/Zfp4EHk+YjOgdkP56z6qmvWru2dqASYP0DxlEikUmImeDR/klT5Ak
         5ls7XrsCVd7a3heqDmHVI7296R4/cQf/QQmC+pa3EIfH8bZ0SiX5NTaqDgr71O7A6dE3
         837SW8IDlWq99e08uyERYgt2JxDBpCyPGKYYLdyGAbBw12/F4a9rLak1YRlPLpFlg8xu
         YRXw==
X-Forwarded-Encrypted: i=1; AKwUvBy32GeZhrsHXLkAUsDpC8JdWEB24/LZPaTG0knfbyK9Swqmk3UY7o9UL3NPG58fnNxUVgBAQcNZVbKk98qZXA==@lists.linux.dev
X-Gm-Message-State: AFuF++mAi6aXr7TsL0xMAmaeW0abp43oZRl1GmiOZ3zEfFjnHAwTrIfh
	ZcMaN8LWRxK1zGg8iniwgptfWWdonDAF8fF4TMTDroxzMDl08/IOP4Ii
X-Gm-Gg: AYBFou2v8IgkEZr2quUllqYM+iKO9vVn/7VfSzUYHd60rYkzt88I0dhsW/vqqJSDpro
	cyEeLKs3I8PbPBKIBy/0aXIWCGN0Qor19DKdZwOdfr6+/lYZBc6ZfIvkadD1atDL8JG6wRjyUK4
	leJB2W7DRxqc7mVr87XAJCi63XLgb6bMLhQtWu/7ilO4vqLAKKUbmrBKAFDU+qTgG/N5mzE0uDU
	Dem7oJpnY4twcvaSJCMJ3J98bmlhLulC4zFvEdTRllblvtCgvJAVp3UMvBZynnMI5WwGUGEC1KL
	HP3Vh5TiztOdLZWxyv0IpmRB4Tkz2G8iy42xzDNVFRt5SOp7yVHgaR3n54x6NPC+/cXO2tIlT/i
	AkEq27/vIftLT8Iu0BtE+rR/7+Kr5bBRC/KbDJgd+Nh+Suolqu+QN4SRopeX8fDZQjavXWk8jyb
	Cwz7jAG3ZVThSo41UYSk3re06Ed+lKSQf8pTlVZDgKchSujGwQm6rJQtTTa/PcAJmSGyD7hLxAt
	3Ax4nXh8KHqE+y3l4GsArMoJw67+N2gDsiqRlh55XYqN66B6/R4Ahku7/yjqddU9Hc=
X-Received: by 2002:a05:620a:2887:b0:939:518d:7f6e with SMTP id af79cd13be357-93c43bba60bmr1065684085a.22.1790440297949;
        Sat, 26 Sep 2026 09:31:37 -0700 (PDT)
Received: from localhost.localdomain ([2600:4040:29f7:9600:f571:6178:b590:34a4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c4fe09037sm341332385a.27.2026.09.26.09.31.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 09:31:37 -0700 (PDT)
From: Dillon Amburgey <dillona@gmail.com>
To: Dave Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Cc: Dillon Amburgey <dillona@gmail.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	christian.koenig@amd.com,
	krisman@collabora.co.uk,
	noralf@tronnes.org
Subject: [PATCH v3 4/5] drm/qxl: own packed primary shadows in atomic plane state
Date: Sat, 26 Sep 2026 12:31:22 -0400
Message-ID: <20260926163123.39217-5-dillona@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260926163123.39217-1-dillona@gmail.com>
References: <20260926163123.39217-1-dillona@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparing a dumb framebuffer changes device-wide layout and BO shadow
bindings before the atomic commit succeeds. An aborted preparation can
redirect live framebuffers to an uncommitted shadow. Per-plane cleanup
can also remove a shadow binding still needed by another head using the
same framebuffer.

Give each prepared primary plane state a reference and pin to a shared
shadow. Compute the complete new layout and prepare one matching shadow
without changing the displayed states. Include all primary planes and
CRTCs so replacement and repacking redraw every head under the same
commit dependencies. Release each state's resources independently.

Keep the primary while any new primary plane remains active, and destroy
it when the last head turns off, including DPMS with retained framebuffer
bindings. Route DirtyFB clips through each matching active plane state
to its packed slot; copy clips before the draw helper translates them.

Retain allocation-based packing and full-framebuffer drawing here; plane
source geometry is handled separately.

Fixes: 90adda2ce898 ("drm/qxl: cover all crtcs in shadow bo.")
Assisted-by: LLM sparse
Signed-off-by: Dillon Amburgey <dillona@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 310 +++++++++++++++++-------------
 drivers/gpu/drm/qxl/qxl_drv.h     |   3 -
 2 files changed, 176 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 05de8dd3144d..af36d4d1ea57 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -45,6 +45,27 @@
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
+/* Each prepared primary state owns a pin and reference to its shadow. */
+struct qxl_plane_state {
+	struct drm_plane_state base;
+	struct qxl_bo *shadow;
+	u32 x;
+};
+
+#define to_qxl_plane_state(state) \
+	container_of(state, struct qxl_plane_state, base)
+
+static bool qxl_primary_active(struct drm_atomic_commit *state,
+			       struct drm_plane_state *ps)
+{
+	struct drm_crtc_state *cs;
+
+	if (!ps || !ps->fb || !ps->crtc)
+		return false;
+	cs = drm_atomic_get_new_crtc_state(state, ps->crtc);
+	return cs && cs->active;
+}
+
 static bool qxl_head_enabled(struct qxl_head *head)
 {
 	return head->width && head->height;
@@ -348,8 +369,8 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 		head.y = crtc->y;
 		if (qdev->monitors_config->count < i + 1)
 			qdev->monitors_config->count = i + 1;
-		if (qdev->primary_bo == qdev->dumb_shadow_bo)
-			head.x += qdev->dumb_heads[i].x;
+		if (to_qxl_plane_state(crtc->primary->state)->shadow)
+			head.x += to_qxl_plane_state(crtc->primary->state)->x;
 	} else {
 		head.width = 0;
 		head.height = 0;
@@ -428,12 +449,10 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 					 struct drm_clip_rect *clips,
 					 unsigned int num_clips)
 {
-	/* TODO: vmwgfx where this was cribbed from had locking. Why? */
 	struct qxl_device *qdev = to_qxl(fb->dev);
 	struct drm_clip_rect norect;
 	struct qxl_bo *qobj;
 	struct drm_modeset_acquire_ctx ctx;
-	bool is_primary;
 	struct drm_crtc *crtc;
 	int inc = 1, ret;
 
@@ -446,9 +465,7 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 	}
 
 	qobj = gem_to_qxl_bo(fb->obj[0]);
-	/* if we aren't primary surface ignore this */
-	is_primary = qobj->shadow ? qobj->shadow->is_primary : qobj->is_primary;
-	if (!is_primary)
+	if (!qobj->is_dumb && !qobj->is_primary)
 		goto out_lock_end;
 
 	if (!num_clips) {
@@ -462,8 +479,29 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 		inc = 2; /* skip source rects */
 	}
 
-	qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
-			  clips, num_clips, inc, 0);
+	if (qobj->is_dumb) {
+		unsigned int n;
+
+		drm_for_each_crtc(crtc, &qdev->ddev) {
+			struct drm_plane_state *st;
+
+			st = crtc->primary->state;
+			if (st->fb != fb || !crtc->state->active ||
+			    !to_qxl_plane_state(st)->shadow ||
+			    !to_qxl_plane_state(st)->shadow->is_primary)
+				continue;
+			for (n = 0; n < num_clips; n++) {
+				struct drm_clip_rect c = clips[n * inc];
+
+				qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
+						  &c, 1, 1,
+						  to_qxl_plane_state(st)->x);
+			}
+		}
+	} else {
+		qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
+				  clips, num_clips, inc, 0);
+	}
 
 out_lock_end:
 	DRM_MODESET_LOCK_ALL_END(fb->dev, ctx, ret);
@@ -499,20 +537,31 @@ static const struct drm_crtc_helper_funcs qxl_crtc_helper_funcs = {
 	.atomic_disable = qxl_crtc_atomic_disable,
 };
 
+/* The primary surface is shared, so every primary update must serialize
+ * with, and redraw, the other heads, including heads whose packed x moves.
+ */
 static int qxl_primary_atomic_check(struct drm_plane *plane,
 				    struct drm_atomic_commit *state)
 {
-	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
-										 plane);
-	struct qxl_device *qdev = to_qxl(plane->dev);
-	struct qxl_bo *bo;
+	struct drm_plane_state *ps = drm_atomic_get_new_plane_state(state, plane);
+	struct drm_crtc *crtc;
 
-	if (!new_plane_state->crtc || !new_plane_state->fb)
-		return 0;
+	drm_for_each_crtc(crtc, plane->dev) {
+		struct drm_crtc_state *cs;
+		struct drm_plane_state *other;
 
-	bo = gem_to_qxl_bo(new_plane_state->fb->obj[0]);
+		cs = drm_atomic_get_crtc_state(state, crtc);
+		if (IS_ERR(cs))
+			return PTR_ERR(cs);
+		other = drm_atomic_get_plane_state(state, crtc->primary);
+		if (IS_ERR(other))
+			return PTR_ERR(other);
+	}
 
-	return qxl_check_framebuffer(qdev, bo);
+	if (!ps->fb || !ps->crtc)
+		return 0;
+	return qxl_check_framebuffer(to_qxl(plane->dev),
+				     gem_to_qxl_bo(ps->fb->obj[0]));
 }
 
 static int qxl_primary_apply_cursor(struct qxl_device *qdev,
@@ -666,6 +715,23 @@ static void qxl_free_cursor(struct qxl_bo *cursor_bo)
 	qxl_bo_unref(&cursor_bo);
 }
 
+static void qxl_primary_atomic_disable(struct drm_plane *plane,
+				       struct drm_atomic_commit *state)
+{
+	struct qxl_device *qdev = to_qxl(plane->dev);
+	struct drm_plane *other;
+	struct drm_plane_state *ps;
+	int i;
+
+	for_each_new_plane_in_state(state, other, ps, i) {
+		if (other->type == DRM_PLANE_TYPE_PRIMARY &&
+		    qxl_primary_active(state, ps))
+			return;
+	}
+	if (qdev->primary_bo)
+		qxl_io_destroy_primary(qdev);
+}
+
 static void qxl_primary_atomic_update(struct drm_plane *plane,
 				      struct drm_atomic_commit *state)
 {
@@ -682,7 +748,12 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 	};
 	uint32_t dumb_shadow_offset = 0;
 
-	primary = bo->shadow ? bo->shadow : bo;
+	if (!qxl_primary_active(state, new_state)) {
+		qxl_primary_atomic_disable(plane, state);
+		return;
+	}
+
+	primary = bo->is_dumb ? to_qxl_plane_state(new_state)->shadow : bo;
 
 	if (!primary->is_primary) {
 		if (qdev->primary_bo)
@@ -692,30 +763,12 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 	}
 
 	if (bo->is_dumb)
-		dumb_shadow_offset =
-			qdev->dumb_heads[new_state->crtc->index].x;
+		dumb_shadow_offset = to_qxl_plane_state(new_state)->x;
 
 	qxl_draw_dirty_fb(qdev, new_state->fb, bo, 0, 0, &norect, 1, 1,
 			  dumb_shadow_offset);
 }
 
-static void qxl_primary_atomic_disable(struct drm_plane *plane,
-				       struct drm_atomic_commit *state)
-{
-	struct drm_plane_state *old_state = drm_atomic_get_old_plane_state(state,
-									   plane);
-	struct qxl_device *qdev = to_qxl(plane->dev);
-
-	if (old_state->fb) {
-		struct qxl_bo *bo = gem_to_qxl_bo(old_state->fb->obj[0]);
-
-		if (bo->shadow)
-			bo = bo->shadow;
-		if (bo->is_primary)
-			qxl_io_destroy_primary(qdev);
-	}
-}
-
 static void qxl_cursor_atomic_update(struct drm_plane *plane,
 				     struct drm_atomic_commit *state)
 {
@@ -768,93 +821,98 @@ static void qxl_cursor_atomic_disable(struct drm_plane *plane,
 	qcrtc->cursor_bo = NULL;
 }
 
-static void qxl_update_dumb_head(struct qxl_device *qdev,
-				 int index, struct qxl_bo *bo)
+static int qxl_prepare_shadow(struct drm_plane *plane,
+			      struct drm_plane_state *new_state)
 {
-	uint32_t width, height;
+	struct qxl_plane_state *qps = to_qxl_plane_state(new_state);
+	struct drm_atomic_commit *state = new_state->state;
+	struct qxl_device *qdev = to_qxl(plane->dev);
+	struct qxl_surface surf = { 0 };
+	struct qxl_bo *shadow = NULL;
+	struct drm_crtc *crtc;
+	int ret;
 
-	if (index >= qdev->monitors_config->max_allowed)
-		return;
+	if (!qxl_primary_active(state, new_state))
+		return 0;
 
-	if (bo && bo->is_dumb) {
-		width = bo->surf.width;
-		height = bo->surf.height;
-	} else {
-		width = 0;
-		height = 0;
+	drm_for_each_crtc(crtc, plane->dev) {
+		struct drm_plane_state *ps;
+		struct qxl_plane_state *other;
+		struct qxl_bo *bo;
+
+		ps = drm_atomic_get_new_plane_state(state, crtc->primary);
+		if (!qxl_primary_active(state, ps) ||
+		    !gem_to_qxl_bo(ps->fb->obj[0])->is_dumb)
+			continue;
+		other = to_qxl_plane_state(ps);
+		if (ps == new_state)
+			qps->x = surf.width;
+		bo = gem_to_qxl_bo(ps->fb->obj[0]);
+		surf.width += bo->surf.width;
+		surf.height = max_t(u32, surf.height, bo->surf.height);
+		if (other->shadow)
+			shadow = other->shadow;
 	}
+	surf.width = max_t(u32, surf.width, 64);
+	surf.height = max_t(u32, surf.height, 64);
+	surf.format = SPICE_SURFACE_FMT_32_xRGB;
+	surf.stride = surf.width * 4;
+
+	if (!shadow) {
+		shadow = to_qxl_plane_state(plane->state)->shadow;
+		if (shadow && (shadow->surf.width != surf.width ||
+			       shadow->surf.height != surf.height))
+			shadow = NULL;
+	}
+	if (!shadow)
+		return qxl_bo_create(qdev, surf.height * surf.stride,
+				     true, true, QXL_GEM_DOMAIN_SURFACE, 0,
+				     &surf, &qps->shadow);
 
-	if (qdev->dumb_heads[index].width == width &&
-	    qdev->dumb_heads[index].height == height)
-		return;
-
-	DRM_DEBUG("#%d: %dx%d -> %dx%d\n", index,
-		  qdev->dumb_heads[index].width,
-		  qdev->dumb_heads[index].height,
-		  width, height);
-	qdev->dumb_heads[index].width = width;
-	qdev->dumb_heads[index].height = height;
+	ret = qxl_bo_pin(shadow);
+	if (ret)
+		return ret;
+	drm_gem_object_get(&shadow->tbo.base);
+	qps->shadow = shadow;
+	return 0;
 }
 
-static void qxl_calc_dumb_shadow(struct qxl_device *qdev,
-				 struct qxl_surface *surf)
+static void qxl_primary_destroy_state(struct drm_plane *plane,
+				      struct drm_plane_state *state)
 {
-	struct qxl_head *head;
-	int i;
+	struct qxl_plane_state *qps = to_qxl_plane_state(state);
 
-	memset(surf, 0, sizeof(*surf));
-	for (i = 0; i < qdev->monitors_config->max_allowed; i++) {
-		head = qdev->dumb_heads + i;
-		head->x = surf->width;
-		surf->width += head->width;
-		if (surf->height < head->height)
-			surf->height = head->height;
+	if (qps->shadow) {
+		ttm_bo_reserve(&qps->shadow->tbo, false, false, NULL);
+		qxl_bo_unpin_locked(qps->shadow);
+		qxl_bo_unreserve(qps->shadow);
+		drm_gem_object_put(&qps->shadow->tbo.base);
 	}
-	if (surf->width < 64)
-		surf->width = 64;
-	if (surf->height < 64)
-		surf->height = 64;
-	surf->format = SPICE_SURFACE_FMT_32_xRGB;
-	surf->stride = surf->width * 4;
-
-	if (!qdev->dumb_shadow_bo ||
-	    qdev->dumb_shadow_bo->surf.width != surf->width ||
-	    qdev->dumb_shadow_bo->surf.height != surf->height)
-		DRM_DEBUG("%dx%d\n", surf->width, surf->height);
+	__drm_atomic_helper_plane_destroy_state(state);
+	kfree(qps);
 }
 
-static void qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
-			       int crtc_index)
+static void qxl_primary_reset(struct drm_plane *plane)
 {
-	struct qxl_surface surf;
-
-	qxl_update_dumb_head(qdev, crtc_index,
-			     user_bo);
-	qxl_calc_dumb_shadow(qdev, &surf);
-	if (!qdev->dumb_shadow_bo ||
-	    qdev->dumb_shadow_bo->surf.width  != surf.width ||
-	    qdev->dumb_shadow_bo->surf.height != surf.height) {
-		if (qdev->dumb_shadow_bo) {
-			qxl_bo_unpin(qdev->dumb_shadow_bo);
-			drm_gem_object_put
-				(&qdev->dumb_shadow_bo->tbo.base);
-			qdev->dumb_shadow_bo = NULL;
-		}
-		qxl_bo_create(qdev, surf.height * surf.stride,
-			      true, true, QXL_GEM_DOMAIN_SURFACE, 0,
-			      &surf, &qdev->dumb_shadow_bo);
-	}
-	if (user_bo->shadow != qdev->dumb_shadow_bo) {
-		if (user_bo->shadow) {
-			qxl_bo_unpin(user_bo->shadow);
-			drm_gem_object_put
-				(&user_bo->shadow->tbo.base);
-			user_bo->shadow = NULL;
-		}
-		drm_gem_object_get(&qdev->dumb_shadow_bo->tbo.base);
-		user_bo->shadow = qdev->dumb_shadow_bo;
-		qxl_bo_pin(user_bo->shadow);
-	}
+	struct qxl_plane_state *qps;
+
+	if (plane->state)
+		qxl_primary_destroy_state(plane, plane->state);
+	qps = kzalloc_obj(*qps);
+	__drm_atomic_helper_plane_reset(plane, qps ? &qps->base : NULL);
+}
+
+static struct drm_plane_state *qxl_primary_duplicate_state(struct drm_plane *plane)
+{
+	struct qxl_plane_state *qps;
+
+	if (WARN_ON(!plane->state))
+		return NULL;
+	qps = kzalloc_obj(*qps);
+	if (!qps)
+		return NULL;
+	__drm_atomic_helper_plane_duplicate_state(plane, &qps->base);
+	return &qps->base;
 }
 
 static int qxl_plane_prepare_fb(struct drm_plane *plane,
@@ -873,7 +931,9 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
 	    user_bo->is_dumb) {
-		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index);
+		ret = qxl_prepare_shadow(plane, new_state);
+		if (ret)
+			return ret;
 	}
 
 	if (plane->type == DRM_PLANE_TYPE_CURSOR &&
@@ -914,12 +974,6 @@ static void qxl_plane_cleanup_fb(struct drm_plane *plane,
 	obj = old_state->fb->obj[0];
 	user_bo = gem_to_qxl_bo(obj);
 	qxl_bo_unpin(user_bo);
-
-	if (old_state->fb != plane->state->fb && user_bo->shadow) {
-		qxl_bo_unpin(user_bo->shadow);
-		drm_gem_object_put(&user_bo->shadow->tbo.base);
-		user_bo->shadow = NULL;
-	}
 }
 
 static const uint32_t qxl_cursor_plane_formats[] = {
@@ -959,9 +1013,9 @@ static const struct drm_plane_funcs qxl_primary_plane_funcs = {
 	.update_plane	= drm_atomic_helper_update_plane,
 	.disable_plane	= drm_atomic_helper_disable_plane,
 	.destroy	= drm_plane_helper_destroy,
-	.reset		= drm_atomic_helper_plane_reset,
-	.atomic_duplicate_state = drm_atomic_helper_plane_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_plane_destroy_state,
+	.reset		= qxl_primary_reset,
+	.atomic_duplicate_state = qxl_primary_duplicate_state,
+	.atomic_destroy_state = qxl_primary_destroy_state,
 };
 
 static struct drm_plane *qxl_create_plane(struct qxl_device *qdev,
@@ -1255,11 +1309,7 @@ int qxl_create_monitors_object(struct qxl_device *qdev)
 		qxl_bo_physical_address(qdev, qdev->monitors_config_bo, 0);
 
 	memset(qdev->monitors_config, 0, monitors_config_size);
-	qdev->dumb_heads = kzalloc_objs(qdev->dumb_heads[0], qxl_num_crtc);
-	if (!qdev->dumb_heads) {
-		qxl_destroy_monitors_object(qdev);
-		return -ENOMEM;
-	}
+
 	return 0;
 }
 
@@ -1270,9 +1320,6 @@ int qxl_destroy_monitors_object(struct qxl_device *qdev)
 	if (!qdev->monitors_config_bo)
 		return 0;
 
-	kfree(qdev->dumb_heads);
-	qdev->dumb_heads = NULL;
-
 	qdev->monitors_config = NULL;
 	qdev->ram_header->monitors_config = 0;
 
@@ -1325,10 +1372,5 @@ int qxl_modeset_init(struct qxl_device *qdev)
 
 void qxl_modeset_fini(struct qxl_device *qdev)
 {
-	if (qdev->dumb_shadow_bo) {
-		qxl_bo_unpin(qdev->dumb_shadow_bo);
-		drm_gem_object_put(&qdev->dumb_shadow_bo->tbo.base);
-		qdev->dumb_shadow_bo = NULL;
-	}
 	qxl_destroy_monitors_object(qdev);
 }
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index cc02b5f10ad9..f29ce77eef7b 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -85,7 +85,6 @@ struct qxl_bo {
 	/* Constant after initialization */
 	unsigned int is_primary:1; /* is this now a primary surface */
 	unsigned int is_dumb:1;
-	struct qxl_bo *shadow;
 	unsigned int hw_surf_alloc:1;
 	struct qxl_surface surf;
 	uint32_t surface_id;
@@ -201,8 +200,6 @@ struct qxl_device {
 	struct qxl_ram_header *ram_header;
 
 	struct qxl_bo *primary_bo;
-	struct qxl_bo *dumb_shadow_bo;
-	struct qxl_head *dumb_heads;
 
 	struct qxl_memslot main_slot;
 	struct qxl_memslot surfaces_slot;
