Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A653932E3
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 21:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789854760; cv=none; b=Ggc3HzUgb4b0mAnaulVCdVzOBoiZi+mKFNgeM8mzZpLxkzvNEkX4rgCNDEwaTi9EGwVnF+ouRBtUWQnskNdPOqdXjHk6xNkob8RUGTn+ahKH+Y23SSv4xxhwCNdgQ13mtuO7GCFfkPeauz9jnjCGRjlGyZ4QUJk4FwTF1+BVBug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789854760; c=relaxed/simple;
	bh=U1jq3rVIXf2vsobUdSDWCpqO680/ab1TVPGCTkzaIrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZQ9ko5XMLqUxUfqr+6qG81qHY58uatvItz2nnYfwvFZgJfHiRT3nMsPEFZXYQT5BDrvNUbUhpqGJk5bd3vGvgELLDlCZHXq7hghrkyuoF1MlJAQdFXZ+0zGt4EgVuB1jNvhCnBM6RalSsvUTN139L/xDR7YFcyKXAbZCM93Q+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBo4e4+M; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBo4e4+M"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccdaea75so608530a91.1
        for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 14:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789854752; x=1790459552; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SFfjjVYuyX+ZWtIQTKnBoyatvatssXhZQujt0x3z3r0=;
        b=fBo4e4+MI9VfOgApn+xa7ldu60JWosO7sxXUSVhcGE/DgYmcuQmiPb3p0k+jLk7xi6
         6ylUH3S4+4c/MEFxz8KaTiUdnJGQlTGMs/ZS7mVr5Otbwj1jjSiu93DxMGu7xrsn6hST
         kLRZkQBuqBjmwQu36MRaeUwQBKXW9Y6ct0j4HxIeMoycoY+nXBuXeJK98v38UBdCAzr6
         SalN8+C3uFHE/eaFNt8q6w2YqXWJIC52hpn9rOvnJFExUsQgPGXwWDsx7faiXw0FntLI
         YDX4eYxpfBkse+7zLSswBnSdCXuyDBAI6HbhjA0ry29S6alFAuuIAls1/SF8+frG3nlO
         XnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789854752; x=1790459552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SFfjjVYuyX+ZWtIQTKnBoyatvatssXhZQujt0x3z3r0=;
        b=FttYGickEZ8IH0G89BtVvp5vqtixu4ZA7hSiK4ylxg19B9eTTNIr4+va4uN1zvUkVQ
         k2D7mWguaE8/VfmwehZaOioRLxgRo14C7HC5fyfnkGu/a5eIgQJiGkq/Fq04JR5UNUX6
         joe0Ng+0tL6LHGamfdyFEEPygyGWCF8m9c7OXUq9y1uAUovNMeJ7pqWXENa8kEH2tcJo
         qmRQd9Enoh1Zy9Lz38wqVUXF+x1d45M3gnROqIU4IOGzDVUEigV9kUB9KA17kzVTd6RN
         lzqLdh5wIxO+DikT9ZYh+4C+Jv/yzhDT2n1QU9N8XvdpnwDhT4LItZOHqWvlog3gBvK7
         GGwg==
X-Gm-Message-State: AFuF++ly6LK07l+cR/OOElRCgU9EetZ0OyyORCS3mNl9B0tWYCHbtURG
	isKgqEC0dPWoR2bz4EjoSP3n6pAP7GJIEqS586xYbyaHpzm9Piy8UQvm
X-Gm-Gg: AYBFou03DUriySRtOo447Yb4ZrcMkxXm3OvMN+FpgpEDw772+PGk1+oEeff7QyhpO9j
	O/IHU9eUiw1MsAt8Tf9UlGa461OSEDfD00z5g19tGJtTOJAiwqKOISk8PoMLI9OGFMCPm8PfS/r
	oBkMHTZeC+HQFE8bavbhaHUe6a48m1OJ1bC/KCoqtXjaTYFXczy4kosEbMko9N4gttgtCIoO5iQ
	2NZ8Jhv7JaRO8i3Kkkfyu1+b8Tmb5gsJeBSmhdLHThm40LsIeHeooULPBQNpVlOqcGeLYtcJEwU
	/EeoY4LzztEW++Y8835GWtFcV0tXLTCPREoeJJ9tbhlInp3kTp3wDRfzgcJTjoeBGO16eSpPEMv
	ITysNPx23BLQ6UBnFAHr81PN/7OgdgtSRgwF+55U088l3ecb3U+SKAqTKun4eNnITT87trE2DTH
	eNmkX4jJalk8JEyGOyjlKk/xfiAQaqFXFgsQtssg3UN6pP7Sz4kOKm6niLBSpvhtD9a76BB733Q
	rYK/sDls1KCQ3Dl8gqwck9qakpTddzy1Dz64CNH9Q70Xan+nfQ7BrobES3Jg0GF26oNNsMhkHYo
	8ldu7+5ZJ3SuhQpmIWE1
X-Received: by 2002:a17:90b:3908:b0:39e:3d38:7ef1 with SMTP id 98e67ed59e1d1-39e5565236dmr6546738a91.10.1789854751817;
        Sat, 19 Sep 2026 14:52:31 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a02526e27dsm1883481a91.0.2026.09.19.14.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:52:31 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/qxl: fix cursor OOB read, dirty-rect bounds, and monitors double-fetch
Date: Sat, 19 Sep 2026 21:52:30 +0000
Message-ID: <20260919215230.3469792-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix out-of-bounds accesses and missing bounds checks in the QXL display
and dirty-framebuffer drawing paths:

1. In qxl_create_cursor() and qxl_cursor_atomic_check(), verify that the
   cursor GEM BO is at least 64 * 64 * 4 bytes (16 KiB) before copying
   into the QXL cursor command, and zero-initialize the stack struct
   qxl_cursor header.
2. In qxl_draw_dirty_fb() and qxl_framebuffer_surface_dirty(), validate
   clip coordinates against the framebuffer dimensions and negative x/y
   offsets before computing pixel pointers, and handle odd clip counts
   when DRM_MODE_FB_DIRTY_ANNOTATE_COPY is set.
3. In qxl_display_copy_rom_client_monitors_config(), read
   qdev->rom->client_monitors_config.count once with READ_ONCE() and
   clamp num_monitors to ARRAY_SIZE(heads).
4. In qxl_prepare_shadow(), propagate qxl_bo_create() allocation failures
   to qxl_plane_prepare_fb().

Fixes: f64122c1f6ad ("drm: add new QXL driver. (v1.4)")
Fixes: b4b27f08f9f9 ("drm/qxl: rework cursor plane")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 0719fc6a52d5..0fc14312e027 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -82,7 +82,7 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 	uint32_t crc;
 	int status = MONITORS_CONFIG_UNCHANGED;
 
-	num_monitors = qdev->rom->client_monitors_config.count;
+	num_monitors = READ_ONCE(qdev->rom->client_monitors_config.count);
 	crc = crc32(0, (const uint8_t *)&qdev->rom->client_monitors_config,
 		  sizeof(qdev->rom->client_monitors_config));
 	if (crc != qdev->rom->client_monitors_config_crc)
@@ -95,9 +95,9 @@ static int qxl_display_copy_rom_client_monitors_config(struct qxl_device *qdev)
 		DRM_DEBUG_KMS("client monitors list will be truncated: %d < %d\n",
 			      qxl_num_crtc, num_monitors);
 		num_monitors = qxl_num_crtc;
-	} else {
-		num_monitors = qdev->rom->client_monitors_config.count;
 	}
+	if (num_monitors > ARRAY_SIZE(qdev->rom->client_monitors_config.heads))
+		num_monitors = ARRAY_SIZE(qdev->rom->client_monitors_config.heads);
 	if (qdev->client_monitors_config
 	      && (num_monitors != qdev->client_monitors_config->count)) {
 		status = MONITORS_CONFIG_MODIFIED;
@@ -454,6 +454,9 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 		norect.x2 = fb->width;
 		norect.y2 = fb->height;
 	} else if (flags & DRM_MODE_FB_DIRTY_ANNOTATE_COPY) {
+		if (num_clips < 2)
+			goto out_lock_end;
+		clips++;
 		num_clips /= 2;
 		inc = 2; /* skip source rects */
 	}
@@ -601,7 +604,7 @@ static struct qxl_bo *qxl_create_cursor(struct qxl_device *qdev,
 	struct qxl_cursor cursor;
 	int ret;
 
-	if (!user_bo)
+	if (!user_bo || user_bo->tbo.base.size < size)
 		return NULL;
 
 	ret = qxl_bo_create(qdev, sizeof(struct qxl_cursor) + size,
@@ -618,6 +621,7 @@ static struct qxl_bo *qxl_create_cursor(struct qxl_device *qdev,
 	if (ret)
 		goto err_unmap;
 
+	memset(&cursor, 0, sizeof(cursor));
 	cursor.header.unique = 0;
 	cursor.header.type = SPICE_CURSOR_TYPE_ALPHA;
 	cursor.header.width = 64;
@@ -819,10 +823,11 @@ static void qxl_calc_dumb_shadow(struct qxl_device *qdev,
 		DRM_DEBUG("%dx%d\n", surf->width, surf->height);
 }
 
-static void qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
-			       int crtc_index)
+static int qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
+			      int crtc_index)
 {
 	struct qxl_surface surf;
+	int ret;
 
 	qxl_update_dumb_head(qdev, crtc_index,
 			     user_bo);
@@ -836,9 +841,11 @@ static void qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
 				(&qdev->dumb_shadow_bo->tbo.base);
 			qdev->dumb_shadow_bo = NULL;
 		}
-		qxl_bo_create(qdev, surf.height * surf.stride,
-			      true, true, QXL_GEM_DOMAIN_SURFACE, 0,
-			      &surf, &qdev->dumb_shadow_bo);
+		ret = qxl_bo_create(qdev, surf.height * surf.stride,
+				    true, true, QXL_GEM_DOMAIN_SURFACE, 0,
+				    &surf, &qdev->dumb_shadow_bo);
+		if (ret)
+			return ret;
 	}
 	if (user_bo->shadow != qdev->dumb_shadow_bo) {
 		if (user_bo->shadow) {
@@ -851,6 +858,7 @@ static void qxl_prepare_shadow(struct qxl_device *qdev, struct qxl_bo *user_bo,
 		user_bo->shadow = qdev->dumb_shadow_bo;
 		qxl_bo_pin(user_bo->shadow);
 	}
+	return 0;
 }
 
 static int qxl_plane_prepare_fb(struct drm_plane *plane,
@@ -869,7 +877,9 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
 	    user_bo->is_dumb) {
-		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index);
+		ret = qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index);
+		if (ret)
+			return ret;
 	}
 
 	if (plane->type == DRM_PLANE_TYPE_CURSOR &&
@@ -919,7 +929,25 @@ static const uint32_t qxl_cursor_plane_formats[] = {
 	DRM_FORMAT_ARGB8888,
 };
 
+static int qxl_cursor_atomic_check(struct drm_plane *plane,
+				   struct drm_atomic_commit *state)
+{
+	struct drm_plane_state *new_plane_state = drm_atomic_get_new_plane_state(state,
+										 plane);
+	struct drm_framebuffer *fb = new_plane_state->fb;
+
+	if (!fb)
+		return 0;
+
+	if (fb->width != 64 || fb->height != 64 ||
+	    !fb->obj[0] || fb->obj[0]->size < 64 * 64 * 4)
+		return -EINVAL;
+
+	return 0;
+}
+
 static const struct drm_plane_helper_funcs qxl_cursor_helper_funcs = {
+	.atomic_check = qxl_cursor_atomic_check,
 	.atomic_update = qxl_cursor_atomic_update,
 	.atomic_disable = qxl_cursor_atomic_disable,
 	.prepare_fb = qxl_plane_prepare_fb,
diff --git a/drivers/gpu/drm/qxl/qxl_draw.c b/drivers/gpu/drm/qxl/qxl_draw.c
index 3a3e127ce297..302c17d87d1c 100644
--- a/drivers/gpu/drm/qxl/qxl_draw.c
+++ b/drivers/gpu/drm/qxl/qxl_draw.c
@@ -154,27 +154,40 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 	struct qxl_drm_image *dimage;
 	int ret;
 
-	ret = alloc_drawable(qdev, &release);
-	if (ret)
-		return;
-
-	clips->x1 += dumb_shadow_offset;
-	clips->x2 += dumb_shadow_offset;
-
-	left = clips->x1;
-	right = clips->x2;
+	left = clips->x1 + dumb_shadow_offset;
+	right = clips->x2 + dumb_shadow_offset;
 	top = clips->y1;
 	bottom = clips->y2;
 
 	/* skip the first clip rect */
 	for (i = 1, clips_ptr = clips + inc;
 	     i < num_clips; i++, clips_ptr += inc) {
-		left = min_t(int, left, (int)clips_ptr->x1);
-		right = max_t(int, right, (int)clips_ptr->x2);
+		left = min_t(int, left, (int)clips_ptr->x1 + dumb_shadow_offset);
+		right = max_t(int, right, (int)clips_ptr->x2 + dumb_shadow_offset);
 		top = min_t(int, top, (int)clips_ptr->y1);
 		bottom = max_t(int, bottom, (int)clips_ptr->y2);
 	}
 
+	if (dumb_shadow_offset < 0 || dumb_shadow_offset > INT_MAX - fb->width)
+		return;
+
+	left = clamp_t(int, left, dumb_shadow_offset,
+		       dumb_shadow_offset + fb->width);
+	right = clamp_t(int, right, dumb_shadow_offset,
+			dumb_shadow_offset + fb->width);
+	top = clamp_t(int, top, 0, fb->height);
+	bottom = clamp_t(int, bottom, 0, fb->height);
+
+	if (left >= right || top >= bottom)
+		return;
+
+	if ((size_t)bottom * stride > fb->obj[0]->size)
+		return;
+
+	ret = alloc_drawable(qdev, &release);
+	if (ret)
+		return;
+
 	width = right - left;
 	height = bottom - top;
 
