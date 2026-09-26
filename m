Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16713381EB4
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 16:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440309; cv=none; b=KMh0Lsn2lQ7PqkC+cMdIQSFEw5I7shoXXiNVh+zx2nH96vYnFiAcWiTOpHreTP8F6kLD0cWaXbS6nEM8BJib/XQP7Ii0JEJRjD37b8+bgzT+fjrmOvvcB3ypsjB5ugsBHAorTEuqRDxxp+zz3Yk/M2Y8dAh8XZGDZ/IEpjHNcK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440309; c=relaxed/simple;
	bh=nsAbYLcHbEoj3+e7SFiPExZFATMy5xdnXMd7+ZkPh9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AEM2kwDRTiuyZz6aHD5bh6DoKl5AY0+t47b5hbJjkKatpPIbs4l2gFN9cviP5Yyd0gEk87tUdTSDPSTVH8g8WfH9ND+U/6h2R6PcGYg9+gqiGBwVkbyZ1NS3YqkTNJqjEBU500FiIF6Vm5UpJ7KZwBV8OSdKz9/dKEjZAwfogxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PP+4uOQx; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PP+4uOQx"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-93c64c01c86so15118085a.1
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 09:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440299; x=1791045099; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/uUuNNBokGLygAKY9zbZYXBzLPYmKU+cQD1E+Ot4MHE=;
        b=PP+4uOQxXLjUPofkee5SiFTAlHGBXsjkNiGiXObZ5/lgzxxh9imr4kBYxm3Q7U4OST
         p11SPbfxxqEUFVGX7aQPeKNaDtFOTTnyAB96xmwnoiBkhf8IVtLZ8A1r9pDLgMWJNgE9
         tzmtSsDt1oBlHiMHtlWSK1bhMepuYeYai3WgFcQ+Eb0oaf5SgbY9bVs/WQGOoFMn6D8b
         2Pf111FIRo7L06DHVN7HvHLVM/n5XE7krcV1mgGeJtsYsl96dgcenu19oaR2FV4vB/6m
         0LywleMdB1pQgmYI9LDnBhYHaoWyzziIfnqhF+i11XIPwEtiMRoAiY6HJNzHtTW+DJh7
         zKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440299; x=1791045099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/uUuNNBokGLygAKY9zbZYXBzLPYmKU+cQD1E+Ot4MHE=;
        b=sywPZQ5Jea+MrtIoi4RWG/q1JIdimzueJIHStW5zn0jv9ZDS35waVPPMgs3sCoocDc
         j9tyxeruqd4CcIGIJAzD5Zt/Hb5lWgCwCfy8hXgTKrPFkYduxpQKdP2X3+42i3rSLBXA
         6uMk1DMyvop+An2xj7MiHgQywTXCGkfLiFVSgki+x3fFSkzekNLaB0Sw3V2fe8L8rQCp
         eorgvahdUIrvE+bJwGDcDO+pVcLRjTfW+y0yNSt4flpfSkmTaooIMwARR3tYPTLQVQIt
         2zZHk/pRzkoGQiC22Rj1RF+biY2wsOA6j28M3JCQjiVLr0uOHg76J4EyqjwGxUrAKwN7
         admQ==
X-Forwarded-Encrypted: i=1; AKwUvBzyCkD76KxndLl20gjW7jQ7y/P1s/2gItRYFvQFKTacQDoeBTzUD/7dJLCqjhsRdoYbcJtKoeyXKi7vozn8Ag==@lists.linux.dev
X-Gm-Message-State: AFuF++lgO3O7GHC/nfUACeVrvKIscKgn7Z9IyfX8M6JcN8T78jsN3H36
	UKLg2N0kBZvFeKLvm4dkeohkGWAzJHMxCPoKFYx04+rXL+nDvqmVgJsp
X-Gm-Gg: AYBFou0xHmgcQRSl0UxK/0weLVrYiWGN0b//npsT6sSECTuPv+DWFy6jf610XbdPH9S
	fZHkJRhWJg/vhIoOEynPV+E77uPDvajm84fTQw0NVTgInef7hDCkvVy/PVKOLsARLuXqjwV1P5I
	UHVTc8Rr8B/Fq1n1S2kcKlqCfypavcIBeEFkURPbWLE9peYqtIO+eQpF2hqXYMsalQYPh65EP3d
	nnS9/9tm9+hvp1iOpZa+ZXCbFNeRsIt8yb/CKBAaGy36snmmN0x41/nN2+h+oRRvCDzHn4DzrHl
	uci0+nAaq5lyMVONJ99BLKNh3QyTfqpexxxgmT9Pfhsj0wNg9z1jBi0Ve7s+JYFpX6szBPOzdb8
	RYcXNj0xYI7Y2ox3/cfchVeouBeFCrkeMtapEeONhE1f2K/wXawcy0Srdy2eV/vyhfZoJ5VoOjO
	7JK0CDU2ha7sYf1q+RYOftKiqWLvQc/w4kgL49G7O9hKWmBaoFWIM0QPWMzz3RNxLzpFFzDyfgR
	l4tVMX5gFYi9S6l9/9dqNuVTqm04+Cnb+EirQQ0nRZN1I8TU+ixjrICiBVZr+4IF2Y=
X-Received: by 2002:a05:620a:2b85:b0:93b:2d06:c2cb with SMTP id af79cd13be357-93c43cb7511mr987029485a.37.1790440298993;
        Sat, 26 Sep 2026 09:31:38 -0700 (PDT)
Received: from localhost.localdomain ([2600:4040:29f7:9600:f571:6178:b590:34a4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c4fe09037sm341332385a.27.2026.09.26.09.31.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 09:31:38 -0700 (PDT)
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
Subject: [PATCH v3 5/5] drm/qxl: pack dumb heads from their plane source rectangles
Date: Sat, 26 Sep 2026 12:31:23 -0400
Message-ID: <20260926163123.39217-6-dillona@gmail.com>
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

Packing a 1280x800 source from a 2048x1024 dumb framebuffer beside a
1024x768 head creates a 3072x1024 primary instead of 2304x800. Copying
the full framebuffer also paints pixels outside the visible source.

Size packed heads from their plane source rectangles and copy only those
rectangles to their packed origins. Publish the same origins without
adding the framebuffer source position a second time.

Intersect DirtyFB clips with every matching plane source and translate
each intersection to its packed origin. Apply both horizontal and
vertical offsets so separate framebuffers, shared framebuffers and
nonzero source coordinates use the same mapping for modesets and dirty
updates.

Fixes: 90adda2ce898 ("drm/qxl: cover all crtcs in shadow bo.")

Assisted-by: LLM sparse
Signed-off-by: Dillon Amburgey <dillona@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 63 ++++++++++++++++++++++---------
 drivers/gpu/drm/qxl/qxl_draw.c    |  6 ++-
 drivers/gpu/drm/qxl/qxl_drv.h     |  2 +-
 3 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index af36d4d1ea57..1b12458ef7c9 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -369,8 +369,10 @@ static void qxl_crtc_update_monitors_config(struct drm_crtc *crtc,
 		head.y = crtc->y;
 		if (qdev->monitors_config->count < i + 1)
 			qdev->monitors_config->count = i + 1;
-		if (to_qxl_plane_state(crtc->primary->state)->shadow)
-			head.x += to_qxl_plane_state(crtc->primary->state)->x;
+		if (to_qxl_plane_state(crtc->primary->state)->shadow) {
+			head.x = to_qxl_plane_state(crtc->primary->state)->x;
+			head.y = 0;
+		}
 	} else {
 		head.width = 0;
 		head.height = 0;
@@ -484,23 +486,40 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 
 		drm_for_each_crtc(crtc, &qdev->ddev) {
 			struct drm_plane_state *st;
+			u32 sx, sy, sw, sh;
 
 			st = crtc->primary->state;
 			if (st->fb != fb || !crtc->state->active ||
 			    !to_qxl_plane_state(st)->shadow ||
 			    !to_qxl_plane_state(st)->shadow->is_primary)
 				continue;
+			sx = st->src_x >> 16;
+			sy = st->src_y >> 16;
+			sw = st->src_w >> 16;
+			sh = st->src_h >> 16;
 			for (n = 0; n < num_clips; n++) {
-				struct drm_clip_rect c = clips[n * inc];
-
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
 				qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
 						  &c, 1, 1,
-						  to_qxl_plane_state(st)->x);
+						  to_qxl_plane_state(st)->x - sx,
+						  -(int)sy);
 			}
 		}
 	} else {
 		qxl_draw_dirty_fb(qdev, fb, qobj, flags, color,
-				  clips, num_clips, inc, 0);
+				  clips, num_clips, inc, 0, 0);
 	}
 
 out_lock_end:
@@ -741,12 +760,17 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 	struct qxl_bo *bo = gem_to_qxl_bo(new_state->fb->obj[0]);
 	struct qxl_bo *primary;
 	struct drm_clip_rect norect = {
-	    .x1 = 0,
-	    .y1 = 0,
-	    .x2 = new_state->fb->width,
-	    .y2 = new_state->fb->height
+		.x1 = 0,
+		.y1 = 0,
+		.x2 = new_state->fb->width,
+		.y2 = new_state->fb->height,
 	};
 	uint32_t dumb_shadow_offset = 0;
+	int y_off = 0;
+	u32 src_x = new_state->src_x >> 16;
+	u32 src_y = new_state->src_y >> 16;
+	u32 src_w = new_state->src_w >> 16;
+	u32 src_h = new_state->src_h >> 16;
 
 	if (!qxl_primary_active(state, new_state)) {
 		qxl_primary_atomic_disable(plane, state);
@@ -762,11 +786,18 @@ static void qxl_primary_atomic_update(struct drm_plane *plane,
 		qxl_primary_apply_cursor(qdev, plane->state);
 	}
 
-	if (bo->is_dumb)
-		dumb_shadow_offset = to_qxl_plane_state(new_state)->x;
+	if (bo->is_dumb) {
+		norect.x1 = src_x;
+		norect.y1 = src_y;
+		norect.x2 = src_x + src_w;
+		norect.y2 = src_y + src_h;
+		dumb_shadow_offset =
+			to_qxl_plane_state(new_state)->x - src_x;
+		y_off = -(int)src_y;
+	}
 
 	qxl_draw_dirty_fb(qdev, new_state->fb, bo, 0, 0, &norect, 1, 1,
-			  dumb_shadow_offset);
+			  dumb_shadow_offset, y_off);
 }
 
 static void qxl_cursor_atomic_update(struct drm_plane *plane,
@@ -838,7 +869,6 @@ static int qxl_prepare_shadow(struct drm_plane *plane,
 	drm_for_each_crtc(crtc, plane->dev) {
 		struct drm_plane_state *ps;
 		struct qxl_plane_state *other;
-		struct qxl_bo *bo;
 
 		ps = drm_atomic_get_new_plane_state(state, crtc->primary);
 		if (!qxl_primary_active(state, ps) ||
@@ -847,9 +877,8 @@ static int qxl_prepare_shadow(struct drm_plane *plane,
 		other = to_qxl_plane_state(ps);
 		if (ps == new_state)
 			qps->x = surf.width;
-		bo = gem_to_qxl_bo(ps->fb->obj[0]);
-		surf.width += bo->surf.width;
-		surf.height = max_t(u32, surf.height, bo->surf.height);
+		surf.width += ps->src_w >> 16;
+		surf.height = max_t(u32, surf.height, ps->src_h >> 16);
 		if (other->shadow)
 			shadow = other->shadow;
 	}
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
index f29ce77eef7b..24137f934fa1 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.h
+++ b/drivers/gpu/drm/qxl/qxl_drv.h
@@ -391,7 +391,7 @@ void qxl_draw_dirty_fb(struct qxl_device *qdev,
 		       unsigned int flags, unsigned int color,
 		       struct drm_clip_rect *clips,
 		       unsigned int num_clips, int inc,
-		       uint32_t dumb_shadow_offset);
+		       u32 dumb_shadow_offset, int y_off);
 
 void qxl_release_free(struct qxl_device *qdev,
 		      struct qxl_release *release);
