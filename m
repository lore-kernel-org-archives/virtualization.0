Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7BC154425
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 02:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790218438; cv=none; b=dTWtlyR6+PopxsVdTTpt8P7CVUW/lePk0DNerOAt0UnElKqxn3IaWuN1sKA4A9PfIp0A9qzi/xI1YCcpmQqo9Wvai9riDGGQlwrYvbyxeNwGAqKVKCnVQtpuaymXKoCdzzgbOIK5DnyVv9lsYiyv6dlzYpDNJJdjISdfkpPKL+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790218438; c=relaxed/simple;
	bh=fzX1cfbz6MAAL80A76Ukul0oqV8t/2jqBPiqBFH4Fsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZAwcZKMN6O7aL33e+haen7sAyb617vjSctKh4jgoiuxWKguTbhz6pQTYdJfn0qx6xMRcQEGyHNLiBJ+hHH3gg8cri/eNZu0GEgj4EQk2qNd5bK1Z7LlCHQO1CJfaSvf1weuCjue6oGt2HksgdHyaHoDasWQP4u6KAjxsO2h5m+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hn1r0WVa; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn1r0WVa"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76bcb1fso14862431cf.0
        for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 19:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790218432; x=1790823232; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wvc7ihS48CMwaqQEEFS304xLksjJ1u/xnvvm0QQvd88=;
        b=hn1r0WVaOI+jjuwOjVfwOmSx/y00vSpwBab/a/9vXDJGEPh3KP1M3ttPSJ6DzEx8r2
         hmIRpTBalD9w0+JyYi9y2wMaIorQeScYqpNKpYTzhtIcITd0T8oFs3vocPy9FiZ0akhK
         VfefoYQANoM2qu7iRFGsqOQy+aY8bCnlcFSQkTUR1TnOwxv8SrasOo5kBTppscc2fy9f
         DG5khHWk2L828iP3xUuSPV36cB2GPlkK8v+GMr6aSProg1lWBCfXfQnj5lUTmBA1zvKF
         T5dL393h/FXKizHlwPgspwmaZYPn8oxTivytp2r2ZH8avFZxcoVUCMfwyzg1c/rUQLFy
         iiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790218432; x=1790823232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wvc7ihS48CMwaqQEEFS304xLksjJ1u/xnvvm0QQvd88=;
        b=HRTnR4eypUfaVP1104SAI1A8qFIWxF8J0iPSIiAEeX9zdE/Zmf/lQHtgLMn2qrp+fu
         rzKQImbHc5Z+5xEKVSRfE4d5foNDKxzcodVcAdKKFE9+oxlk5Tq0B3SP5M4JseBesTIH
         p8H6+2tVhe4cFuP7Zg9qCp7r2IOqxOQTCj3rJ/BK8/NhIAs7V1ew0lrcdm5Ji5OXXpPv
         lN1h7YkZJRxQ1uk1673/rIJGtLXAmarnoyBkHp5SQ8pWKclmvMj4gGottqGxBvIMiV8U
         dt4O/KbieXwvZ9uGveE7/qbJuPVCxBAt4/8X4lKLWko4L6WNTf07znEvRVMTAbHI4aXA
         KxrQ==
X-Forwarded-Encrypted: i=1; AKwUvByc1K0+vt0Q1HY7X7iM5Gx1VQCOT3QsnP42dTTBjq2YKv46kf9zn6AqPw6bBs8Wy1Cme1H9+Iamlr9+KKj4OQ==@lists.linux.dev
X-Gm-Message-State: AFuF++m0aK0HmDcsS4f8GUExzDAtY1gSsXwdoXA5kfI2w76j+3NzL2bG
	O1+LF9UePMbeiO3VmQNxL3PHzyY9T2OR99yQN+vRoLaRyTCOWYFwQR5H
X-Gm-Gg: AYBFou07d2DRi8RFK2xdUzuvENHe1rkBS7ed72JlcCLGDvMz7utGMf6AwsnK70bZRVT
	4mfSuITUoaRREFMdPjIifbFZhKBJvJxiFl7g8u7hxUZPZqbggdDsSTT/x2Py7GEWHDCRP0K18SC
	mbWfou2X5Frq8tyjxwmTNhQZlylwv10PnnIqCSCULgGPtmPuKKA3CtYNqPJVNpmWjAjBx5w4D8R
	ZMsc++Ev0K8dGwvKwUL45J2sINSQ8cmFNRd4Mm+OdnXSCYaCIfarWhq+0pm/ysCWrWwAlHS3AtW
	Aa8H9SClWDwv/hF9sqsPOXvMrGNAxPT15GWKMver8VES1mvKHLdvbHjyPE/oaYQQ3S0cYoh1xBt
	e/LrEuNKza63JqWYn9wc04BMlUTJXDKNGcDZOtOWQ2abFD/YzKI8Lue+zmOsHNtOoEFpL6We+TF
	e0NoHLr2YoYASoHbt1wZxJiHS0olV71o3FTS4ldO7mKKoVQ7PtHMDQDwzUV+j3v1A8ayWse9wgt
	ctfFRWG3H+wpo8qzSF460H3aOI2Y/93v6dtU4nGpA9ca/3ox0rTpyYLfu5vQLNGJyY=
X-Received: by 2002:a05:622a:250b:b0:530:e335:58b3 with SMTP id d75a77b69052e-532feb571afmr5037371cf.57.1790218431820;
        Wed, 23 Sep 2026 19:53:51 -0700 (PDT)
Received: from localhost.localdomain ([2600:4040:29f7:9600:11c6:662b:adfc:7c99])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532f501100asm18940981cf.24.2026.09.23.19.53.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 19:53:51 -0700 (PDT)
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
Subject: [PATCH] drm/qxl: size packed dumb heads from the plane source
Date: Wed, 23 Sep 2026 22:52:22 -0400
Message-ID: <20260924025222.6077-1-dillona@gmail.com>
X-Mailer: git-send-email 2.50.1
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
source rectangle into it.

Fixes: 90adda2ce898 ("drm/qxl: cover all crtcs in shadow bo.")
Assisted-by: LLM sparse
Signed-off-by: Dillon Amburgey <dillona@gmail.com>
---
Tested on torvalds/linux 62f4c998b297. A DRM client (not Xorg, not
SPICE) programmed one QXL device with max_outputs=2. CRTC 0 scans a
1280x800 rectangle from a 2048x1024 dumb framebuffer (the allocation
is larger than the scanout). CRTC 1 scans a separate 1024x768 dumb
framebuffer. Unpatched, qxl_update_dumb_head() sizes packed heads
from bo->surf, so QEMU's qxl_create_guest_primary is 3072x1024
(2048+1024 by max height) and monitors_config places head 1 at +2048.
With this patch, the primary is 2304x800 (1280+1024) and head 1 is at
+1280.

Content outside CRTC 0's 1280x800 source rectangle did not appear in
the packed primary, and both heads' source rectangles did.

checkpatch.pl --strict: 0 errors, 0 warnings, 0 checks. W=1 and Sparse
on drivers/gpu/drm/qxl/qxl_display.c added no warnings.

 drivers/gpu/drm/qxl/qxl_display.c | 39 ++++++++++++++++---------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 0719fc6a52d5..e57aeeb97f84 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -670,13 +670,17 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
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
 
@@ -689,7 +693,7 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 
 	if (bo->is_dumb)
 		dumb_shadow_offset =
-			qdev->dumb_heads[new_state->crtc->index].x;
+			qdev->dumb_heads[new_state->crtc->index].x - src_x;
 
 	qxl_draw_dirty_fb(qdev, new_state->fb, bo, 0, 0, &norect, 1, 1,
 			  dumb_shadow_offset);
@@ -764,18 +768,14 @@ static void qxl_cursor_atomic_disable(struct drm_plane *plane,
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
@@ -820,12 +820,11 @@ static void qxl_calc_dumb_shadow(struct qxl_device *qdev,
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
@@ -869,7 +868,9 @@ static int qxl_plane_prepare_fb(struct drm_plane *plane,
 
 	if (plane->type == DRM_PLANE_TYPE_PRIMARY &&
 	    user_bo->is_dumb) {
-		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index);
+		qxl_prepare_shadow(qdev, user_bo, new_state->crtc->index,
+				   new_state->src_w >> 16,
+				   new_state->src_h >> 16);
 	}
 
 	if (plane->type == DRM_PLANE_TYPE_CURSOR &&

base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
-- 
2.43.0

