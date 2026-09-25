Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E2381EBE
	for <virtualization@lists.linux.dev>; Fri, 25 Sep 2026 03:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790307026; cv=none; b=RZ+9dzkm4tpPL1kpiyUxZgzeBQ4M52f/DtRGYaT9/kLOPSNoIBRgFh2gmzX/zWudcMr0DUs00wdwcZ8jchMBMeXpPSy5MF0qsBeuPFPUWveHgxFwn6S5XAuphgnOg1uYtxtzQvuHv3eLa+4pB/Xakw+GiGOY9HlWpk1efiE+UFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790307026; c=relaxed/simple;
	bh=ivOFFdkTB6Ym1pL/aMVew2NF/YPxxP2wIZuNOXI+Mbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FrL4r8gZB22F6pHmc3Jf7qk+YZ9YyHmnZk9Rh0tZim85wmJWEgKkWu1OunvKnmbjTEms3ykE/TjF5WDv+Wc8SuTJW9HeC2tVX20wQF97XeNPrKlARXdbpasv1tfFae43pNvNG6R4htxUOLo2CV4998LxHYAR2YZ8k6d3ij91orE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSgKjkuh; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSgKjkuh"
Received: by mail-qk2-f42.google.com with SMTP id d75a77b69052e-52fb769ca17so4242351cf.2
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 20:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790307021; x=1790911821; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y1bT3lEzwlBoiYeaFeeWohd1A7XVi8JjrPv06TrtuZg=;
        b=KSgKjkuh9O05y/wUVRja5DXkEaucKJ66RoP4MfnHC6Fq0qH4pPiT32fQpQyNwdWpWa
         YSpWhDtOmZkhPXxHlo05AOEuneTM1ZJmq1VCBU9fELVnryLoHrqHVFSInSryaP0QMHAo
         ZeKcWFUDtwibakR0+eB9iCtvx0YcrzZUUZQ039dUIJn9aaSryqNIsadGtKhXVow6hlbe
         UDfPslNDCeUtgQ09rEqR+83RRakwCSicweUUJoLUEmozJZPx3rQEqZ0oPJOwtNHNdCz3
         09LwJ1z21Y9BiXnupNooxZyvHRWa6rGzQZr0PcEqAuhgdwScAnJuLOThd4BtAmCUB/ga
         0d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790307021; x=1790911821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y1bT3lEzwlBoiYeaFeeWohd1A7XVi8JjrPv06TrtuZg=;
        b=znx1cP456bNlfnHSk+7GZxSG1lphRk/uAv+DCaH13vMqU8j4jcitzO09g7kSwgJoJz
         Hv2mbSAEsKy321txqzkF7D/2MMw2dkTuTdZxfYbRoTEW2RMFZKnO8YyPwVJr21lX/Mmz
         PDkpZifHbP/Nm96NGNFpHsk+BByK/h5e/c9Jf9Mq41eNb0f0H9XKVm40KCqLYs08T/D3
         nn95dPz3FRzKQXL8NBmd905PULx8W1PcxwyvR2aEfA+GdGnqDTY5CJbziTU9h7Yjir+P
         3ErAgFnCBZf5xxaaHuQMFGPeG2VaTLNrQ7cQrwFrdOiRP/QC5W50BMZ29c5O4YpvxdZh
         MvHw==
X-Forwarded-Encrypted: i=1; AKwUvBxb2G/gn/FI9JQGxBRPxjQxrpmBf/sr9/gEnjn1QJ6nDOSDP/Xu5pq3xMxG74Nm2gml7vye5qkuQERegBDn6Q==@lists.linux.dev
X-Gm-Message-State: AFuF++keIkRRI4zKMx7VpRKp+S237n0z1TgFcC7kS6FhzD6PCkgzi5OR
	WHYq5KNbldpmKfpZ7k83WHrEKD0i6tVjZ9Trmx/zjnyt6NilL9nJ5Doy
X-Gm-Gg: AYBFou0VRwOXJYGgMP4Ulwtj+TDZsJDcMhKAI7ltdB2b10uZTAD9x1Z36T2x/K+yw2r
	wf1rR8RhWMvS0hi/UZGTgdbjl1eafmKoUK32ZHE2ME6ba8eI8NhuFfqkjXID+EMTlAPdvqLYFtE
	/HcRGtkJPkyIW8iyng813c1zDRAcMcTKiqFODKQm3ZgqS8q2ABo/4o/EVxr4NLJprzuJttZ+bLr
	LtMKkU5NqypIeR3z5qRAZ6VsD/xBPyLuMoj5TJWLRZp+6ZvvwVATZLJ0v9aJ2rZXSXnDu56QeLI
	ouEMYTtMTyHejj4dCmPSs3leR0ICgj1+BLx4z8Xu+gWDarZFfb3Cr7YLwrZ7CUaMKC+x+eKiLrO
	rhLqlSm1Hp1TtlvMUmHSCIkmKTm2cs5Th/D926+0t8epafQ6oDpp7gKXMAVlEHu0wz4SquMcHDb
	UYFK9XJnfmKrUDlDsvlO9ON+eavpWTOXefmU+KFV/jxRlQpmpg+9acBjjPuvtux5kVsBmq0UeO7
	+LTWeUm7uDwaFwxgSZPo3FltZjLgatpJq/0QS2FEXkREAl8fg/mXzo0J1Ka0wYr
X-Received: by 2002:a05:622a:1392:b0:532:9f90:3f70 with SMTP id d75a77b69052e-5330b5a56d7mr23799041cf.10.1790307020648;
        Thu, 24 Sep 2026 20:30:20 -0700 (PDT)
Received: from localhost.localdomain ([2600:4040:29f7:9600:b44c:c4c:9e3:10a8])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5330c0e16easm7031841cf.29.2026.09.24.20.30.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Sep 2026 20:30:20 -0700 (PDT)
From: Dillon Amburgey <dillona@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com,
	airlied@gmail.com,
	kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm/qxl: size packed dumb heads from the plane source
Date: Thu, 24 Sep 2026 23:30:11 -0400
Message-ID: <20260925033011.12560-1-dillona@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260924025222.6077-1-dillona@gmail.com>
References: <20260924025222.6077-1-dillona@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

QXL packs per-CRTC dumb buffers into a single primary surface.
qxl_update_dumb_head() recorded each dumb BO allocation (bo->surf)
instead of the plane source rectangle. Scanning 1280x800 from a
2048x1024 dumb framebuffer beside a 1024x768 head therefore created
a 3072x1024 primary and placed head 1 at +2048, rather than 2304x800
with head 1 at +1280.

Use src_w/src_h when building the packed shadow, and copy only that
source rectangle into it. Place that rectangle at the packed origin:
crtc->x and crtc->y are the plane source position, so adding them to
the packed offset publishes the head past the end of the primary.
When the shadow is reallocated, copy the other active dumb heads from
their current framebuffers. DRM_IOCTL_MODE_DIRTYFB intersects each
clip with the plane source and uses that same origin, so a dirty
update of one head is not painted at (0, 0).

Fixes: 90adda2ce898 ("drm/qxl: cover all crtcs in shadow bo.")
Assisted-by: LLM sparse
Signed-off-by: Dillon Amburgey <dillona@gmail.com>
---
Changes in v2:
- Place each source rectangle at the packed origin. crtc->x and
  crtc->y are the plane source position, so adding them published
  head 1 at +2560 on a 2304-wide primary. A shadow primary now
  reports dumb_heads[i].x and .y. A shared framebuffer with head 1
  scanning at x=1280 now reports +1280.
- A non-zero source y is no longer the destination y. The copy reads
  at src_y and writes at dumb_heads[i].y. A 1280x800 source starting
  at y=200 is drawn at the top of the primary.
- Replacing the shadow recopies the other active dumb heads from
  their current framebuffers. The failure was stale pixels, not a
  cleared head: after recoloring head 0 and enabling head 1, head 0
  kept the old color until this recopy.
- DRM_IOCTL_MODE_DIRTYFB intersects the clip with the plane source
  and uses that same origin. A dirty update of head 1 no longer
  paints that buffer at (0, 0).

 drivers/gpu/drm/qxl/qxl_display.c | 132 ++++++++++++++++++++++++------
 drivers/gpu/drm/qxl/qxl_draw.c    |   6 +-
 drivers/gpu/drm/qxl/qxl_drv.h     |   3 +-
 3 files changed, 113 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 0719fc6a52d5..d01504332bc8 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -348,8 +348,10 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 		head.y = crtc->y;
 		if (qdev->monitors_config->count < i + 1)
 			qdev->monitors_config->count = i + 1;
-		if (qdev->primary_bo == qdev->dumb_shadow_bo)
-			head.x += qdev->dumb_heads[i].x;
+		if (qdev->primary_bo == qdev->dumb_shadow_bo) {
+			head.x = qdev->dumb_heads[i].x;
+			head.y = qdev->dumb_heads[i].y;
+		}
 	} else if (i > 0) {
 		head.width = 0;
 		head.height = 0;
@@ -458,8 +460,47 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 		inc = 2; /* skip source rects */
 	}
 
-	qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
-			  clips, num_clips, inc, 0);
+	if (qobj->shadow) {
+		struct drm_crtc *crtc;
+		unsigned int n;
+
+		drm_for_each_crtc(crtc, &qdev->ddev) {
+			struct drm_plane_state *st;
+			u32 sx, sy, sw, sh;
+
+			st = crtc->primary->state;
+			if (st->fb != fb ||
+			    !qdev->dumb_heads[crtc->index].width)
+				continue;
+			sx = st->src_x >> 16;
+			sy = st->src_y >> 16;
+			sw = st->src_w >> 16;
+			sh = st->src_h >> 16;
+			for (n = 0; n < num_clips; n++) {
+				struct drm_clip_rect *in = clips + n * inc;
+				struct drm_clip_rect c;
+				u32 x1 = max_t(u32, in->x1, sx);
+				u32 y1 = max_t(u32, in->y1, sy);
+				u32 x2 = min_t(u32, in->x2, sx + sw);
+				u32 y2 = min_t(u32, in->y2, sy + sh);
+
+				if (x1 >= x2 || y1 >= y2)
+					continue;
+				c.x1 = x1;
+				c.y1 = y1;
+				c.x2 = x2;
+				c.y2 = y2;
+				qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
+						  &c, 1, 1,
+						  qdev->dumb_heads[crtc->index].x - sx,
+						  (int)qdev->dumb_heads[crtc->index].y -
+						  (int)sy);
+			}
+		}
+	} else {
+		qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
+				  clips, num_clips, inc, 0, 0);
+	}
 
 out_lock_end:
 	DRM_MODESET_LOCK_ALL_END(fb->dev, ctx, ret);
@@ -662,6 +703,37 @@ static void qxl_free_cursor(struct qxl_bo *cursor_bo)
 	qxl_bo_unref(&cursor_bo);
 }
 
+static void qxl_redraw_other_dumb_heads(struct qxl_device *qdev, int skip)
+{
+	struct drm_crtc *crtc;
+
+	drm_for_each_crtc(crtc, &qdev->ddev) {
+		struct drm_plane_state *st;
+		struct qxl_bo *other;
+		struct drm_clip_rect clip;
+		u32 sx, sy;
+
+		if (crtc->index == skip ||
+		    !qdev->dumb_heads[crtc->index].width)
+			continue;
+		st = crtc->primary->state;
+		if (!st->fb)
+			continue;
+		other = gem_to_qxl_bo(st->fb->obj[0]);
+		if (!other->is_dumb)
+			continue;
+		sx = st->src_x >> 16;
+		sy = st->src_y >> 16;
+		clip.x1 = sx;
+		clip.y1 = sy;
+		clip.x2 = sx + (st->src_w >> 16);
+		clip.y2 = sy + (st->src_h >> 16);
+		qxl_draw_dirty_fb(qdev, st->fb, other, 0, 0, &clip, 1, 1,
+				  qdev->dumb_heads[crtc->index].x - sx,
+				  (int)qdev->dumb_heads[crtc->index].y - (int)sy);
+	}
+}
+
 static void qxl_primary_atomic_update(struct drm_plane *plane,
 				      struct drm_atomic_commit *state)
 {
@@ -670,13 +742,18 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 	struct qxl_device *qdev = to_qxl(plane->dev);
 	struct qxl_bo *bo = gem_to_qxl_bo(new_state->fb->obj[0]);
 	struct qxl_bo *primary;
-	struct drm_clip_rect norect = {
-	    .x1 = 0,
-	    .y1 = 0,
-	    .x2 = new_state->fb->width,
-	    .y2 = new_state->fb->height
-	};
+	struct drm_clip_rect norect;
 	uint32_t dumb_shadow_offset = 0;
+	int y_off = 0;
+	u32 src_x = new_state->src_x >> 16;
+	u32 src_y = new_state->src_y >> 16;
+	u32 src_w = new_state->src_w >> 16;
+	u32 src_h = new_state->src_h >> 16;
+
+	norect.x1 = src_x;
+	norect.y1 = src_y;
+	norect.x2 = src_x + src_w;
+	norect.y2 = src_y + src_h;
 
 	primary = bo->shadow ? bo->shadow : bo;
 
@@ -687,12 +764,19 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 		qxl_primary_apply_cursor(qdev, plane->state);
 	}
 
-	if (bo->is_dumb)
+	if (bo->is_dumb) {
 		dumb_shadow_offset =
-			qdev->dumb_heads[new_state->crtc->index].x;
+			qdev->dumb_heads[new_state->crtc->index].x - src_x;
+		y_off = (int)qdev->dumb_heads[new_state->crtc->index].y -
+			(int)src_y;
+	}
 
 	qxl_draw_dirty_fb(qdev, new_state->fb, bo, 0, 0, &norect, 1, 1,
-			  dumb_shadow_offset);
+			  dumb_shadow_offset, y_off);
+	if (qdev->dumb_shadow_needs_redraw) {
+		qdev->dumb_shadow_needs_redraw = false;
+		qxl_redraw_other_dumb_heads(qdev, new_state->crtc->index);
+	}
 }
 
 static void qxl_primary_atomic_disable(struct drm_plane *plane,
@@ -764,18 +848,14 @@ static void qxl_cursor_atomic_disable(struct drm_plane *plane,
 	qcrtc->cursor_bo = NULL;
 }
 
-static void qxl_update_dumb_head(struct qxl_device *qdev,
-				 int index, struct qxl_bo *bo)
+static void qxl_update_dumb_head(struct qxl_device *qdev, int index,
+				 struct qxl_bo *bo, uint32_t width,
+				 uint32_t height)
 {
-	uint32_t width, height;
-
 	if (index >= qdev->monitors_config->max_allowed)
 		return;
 
-	if (bo && bo->is_dumb) {
-		width = bo->surf.width;
-		height = bo->surf.height;
-	} else {
+	if (!bo || !bo->is_dumb) {
 		width = 0;
 		height = 0;
 	}
@@ -820,12 +900,11 @@ static void qxl_calc_dumb_shadow(struct qxl_device *qdev,
 }
 
 static void qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
-			       int crtc_index)
+			       int crtc_index, uint32_t width, uint32_t height)
 {
 	struct qxl_surface surf;
 
-	qxl_update_dumb_head(qdev, crtc_index,
-			     user_bo);
+	qxl_update_dumb_head(qdev, crtc_index, user_bo, width, height);
 	qxl_calc_dumb_shadow(qdev, &surf);
 	if (!qdev->dumb_shadow_bo ||
 	    qdev->dumb_shadow_bo->surf.width  != surf.width ||
@@ -839,6 +918,7 @@ static void qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
 		qxl_bo_create(qdev, surf.height * surf.stride,
 			      true, true, QXL_GEM_DOMAIN_SURFACE, 0,
 			      &surf, &qdev->dumb_shadow_bo);
+		qdev->dumb_shadow_needs_redraw = true;
 	}
 	if (user_bo->shadow != qdev->dumb_shadow_bo) {
 		if (user_bo->shadow) {
@@ -869,7 +949,9 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
 	    user_bo->is_dumb) {
-		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index);
+		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index,
+				   new_state->src_w >> 16,
+				   new_state->src_h >> 16);
 	}
 
 	if (plane->type == DRM_PLANE_TYPE_CURSOR &&
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index 3a3e127ce297..f99f4afa46d9 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -129,7 +129,7 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		       unsigned int flags, unsigned int color,
 		       struct drm_clip_rect *clips,
 		       unsigned int num_clips, int inc,
-		       uint32_t dumb_shadow_offset)
+		       u32 dumb_shadow_offset, int y_off)
 {
 	/*
 	 * TODO: if flags & DRM_MODE_FB_DIRTY_ANNOTATE_FILL then we should
@@ -160,6 +160,8 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 
 	clips->x1 += dumb_shadow_offset;
 	clips->x2 += dumb_shadow_offset;
+	clips->y1 += y_off;
+	clips->y2 += y_off;
 
 	left = clips->x1;
 	right = clips->x2;
@@ -210,7 +212,7 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 
 	ret = qxl_image_init(qdev, release, dimage, surface_base,
 			     left - dumb_shadow_offset,
-			     top, width, height, depth, stride);
+			     top - y_off, width, height, depth, stride);
 	qxl_bo_vunmap_locked(bo);
 	if (ret)
 		goto out_release_backoff;
diff --git a/drivers/gpu/drm/qxl/qxl_drv.h b/drivers/gpu/drm/qxl/qxl_drv.h
index cc02b5f10ad9..f7edb620d4d7 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -202,6 +202,7 @@ struct qxl_device {
 
 	struct qxl_bo *primary_bo;
 	struct qxl_bo *dumb_shadow_bo;
+	bool dumb_shadow_needs_redraw;
 	struct qxl_head *dumb_heads;
 
 	struct qxl_memslot main_slot;
@@ -394,7 +395,7 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		       unsigned int flags, unsigned int color,
 		       struct drm_clip_rect *clips,
 		       unsigned int num_clips, int inc,
-		       uint32_t dumb_shadow_offset);
+		       u32 dumb_shadow_offset, int y_off);
 
 void qxl_release_free(struct qxl_device *qdev,
 		      struct qxl_release *release);

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.43.0

