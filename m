Received: from mail.romanilin.is (mail.romanilin.is [146.185.235.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1EF3612F1
	for <virtualization@lists.linux.dev>; Thu,  2 Jul 2026 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.185.235.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783015835; cv=none; b=ciZcA2+E/jaeDnr2nbbAHfYtezP2Ht/kpsn9Vb1apLSyZXuMJM59NSnBfBOYnvFtBoxASmGkWfqiVVlX3dxWCtRHO9PCuyFCtpsASwRcVm3iDr+d95GkbmH900uorqQdFCj+pAn0Be93st0HF2EutATL7LRp+aPXwzwnHZ651kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783015835; c=relaxed/simple;
	bh=DU8kqfFsSKzZpPdBRYOMkNUqANwEcYQY3pfJgHUVIpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgo7QUr2z5EsHLXzOx0nFjOKglchZn9Dy9FNxLjST/VScOOHUvQtiGUC3fZ+GeoZdyOWOY47b6Axm4l1LLQKsn/caSys6HDGnbvipFvyUaqlzojdKX/qW4Xkla5tGI92ofmcMwB7hxbh6vd6bvS/8Wyiws0Aw1eeEaQv8OHKI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=romanilin.is; spf=pass smtp.mailfrom=romanilin.is; dkim=pass (2048-bit key) header.d=romanilin.is header.i=@romanilin.is header.b=Kuz+1ZyD; arc=none smtp.client-ip=146.185.235.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=romanilin.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanilin.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=romanilin.is header.i=@romanilin.is header.b="Kuz+1ZyD"
Received: from macbook-pro (unknown [188.134.85.196])
	by mail.romanilin.is (Postfix) with ESMTPSA id C83F1600D0;
	Thu,  2 Jul 2026 21:10:26 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=romanilin.is;
	s=default; t=1783015827;
	bh=9FN54EmwwuoPwiOawcB9H2v5qyvCGO25BsDKSreP3x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kuz+1ZyDKYRyKAzCNASUhw3eEwedkAxt73T11aCDPm24pdKGp5iqaVc4GEGUo0lK3
	 PMHVMDkambDkIqiRVzhQa5Y8DjLyfr+ZiTXo4iNDsORD5ti3ff+HkDAyGkSW5oT86w
	 2bSMMiMFGignEvQf7loa3g3s4E2YiBlIWgS8wcPRjGZe5AWj48dHtQe8P6GiLzraIw
	 vLLVVDLm+eJRMHSf/MO+WC1NRyFhCP41KToNkg5B8i6KGifbeSeez13qNb0rl+GD7m
	 HzpUG0W41ZrEgl6tArCpkEnC5G/XIqTbMCODu3Q2qCq5HCKGe1kGKmdwMpnVhpOMZl
	 7iAc9UsS00DYg==
From: Roman Ilin <me@romanilin.is>
To: Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	dri-devel@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Peter Arnesen <peter.m.arnesen@gmail.com>,
	Roman Ilin <me@romanilin.is>
Subject: [PATCH v3] drm/vblank: Don't arm vblank timer with invalid frame duration
Date: Thu,  2 Jul 2026 21:10:27 +0300
Message-ID: <20260702181027.98526-1-me@romanilin.is>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613224434.96501-1-me@romanilin.is>
References: <20260613224434.96501-1-me@romanilin.is>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a CRTC's display mode carries a too small pixel clock,
drm_calc_timestamping_constants() computes a frame duration that
exceeds INT_MAX. drm_vblank_crtc.framedur_ns becomes negative.
drm_crtc_vblank_start_timer() then arms the vblank hrtimer with this
interval, after which vblank events are no longer delivered. Pending
page flips never complete and the display appears frozen.

This could be triggered on virtio-gpu guests that have dynamic resolution
enabled: when the SPICE agent or the X server resizes the output, it
submits a mode whose pixel clock is off by a factor of 1000, e.g.:

    clock = 406 kHz, htotal = 3152, vtotal = 2148

    framedur_ns = 3152 * 2148 * 1000000 / 406 = 16675852216 ns (~16.7 s)

16675852216 does not fit into an int and wraps to roughly -504000000.
ns_to_ktime() then yields a negative interval and the timer stops working.

Found by bisection, which pointed at commit a036f5fceedb ("drm/virtgpu:
Use vblank timer"). That commit merely made virtio-gpu use the vblank
timer and thereby exposed the pre-existing problem in the timer setup
added by commit 74afeb812850 ("drm/vblank: Add vblank timer").

To fix this, modify drm_calc_timestamping_constants() to use u64 for
calculations, check for INT_MAX overflows, and return an error code.
drm_crtc_vblank_start_timer() will then propagate the error, enabling
the driver to fall back to immediate vblank events. Valid modes are
unaffected, and the timer self-heals on the next mode with a sane clock.

Fixes: 74afeb812850 ("drm/vblank: Add vblank timer")
Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Roman Ilin <me@romanilin.is>
---
Changes in v3:

- Changed the WARN_ON_ONCE to drm_err_once

Notes:



 drivers/gpu/drm/drm_vblank.c | 71 +++++++++++++++++++++++-------------
 include/drm/drm_vblank.h     |  4 +-
 2 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index f90fb2d13..629b9fcc7 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -631,42 +631,51 @@ EXPORT_SYMBOL(drm_crtc_vblank_waitqueue);
  * drm_crtc_vblank_helper_get_vblank_timestamp(). They are derived from
  * CRTC's true scanout timing, so they take things like panel scaling or
  * other adjustments into account.
+ *
+ * Returns:
+ * 0 on success, or a negative errno code otherwise.
  */
-void drm_calc_timestamping_constants(struct drm_crtc *crtc,
-				     const struct drm_display_mode *mode)
+int drm_calc_timestamping_constants(struct drm_crtc *crtc,
+				    const struct drm_display_mode *mode)
 {
 	struct drm_device *dev = crtc->dev;
 	unsigned int pipe = drm_crtc_index(crtc);
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
-	int linedur_ns = 0, framedur_ns = 0;
+	u64 linedur_ns, framedur_ns;
 	int dotclock = mode->crtc_clock;
+	unsigned int frame_size;
 
 	if (!drm_dev_has_vblank(dev))
-		return;
+		return 0;
 
 	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
-		return;
+		return -EINVAL;
 
-	/* Valid dotclock? */
-	if (dotclock > 0) {
-		int frame_size = mode->crtc_htotal * mode->crtc_vtotal;
+	if (dotclock <= 0) {
+		drm_err(dev, "crtc %u: Can't calculate constants, dotclock = %d!\n",
+			crtc->base.id, dotclock);
+		goto error;
+	}
 
-		/*
-		 * Convert scanline length in pixels and video
-		 * dot clock to line duration and frame duration
-		 * in nanoseconds:
-		 */
-		linedur_ns  = div_u64((u64) mode->crtc_htotal * 1000000, dotclock);
-		framedur_ns = div_u64((u64) frame_size * 1000000, dotclock);
+	frame_size = (unsigned int)mode->crtc_htotal * (unsigned int)mode->crtc_vtotal;
 
-		/*
-		 * Fields of interlaced scanout modes are only half a frame duration.
-		 */
-		if (mode->flags & DRM_MODE_FLAG_INTERLACE)
-			framedur_ns /= 2;
-	} else {
-		drm_err(dev, "crtc %u: Can't calculate constants, dotclock = 0!\n",
-			crtc->base.id);
+	/*
+	 * Convert scanline length in pixels and video dot clock to line duration
+	 * and frame duration in nanoseconds.
+	 */
+	linedur_ns  = div_u64((u64)mode->crtc_htotal * 1000000, dotclock);
+	framedur_ns = div_u64((u64)frame_size * 1000000, dotclock);
+
+	/*
+	 * Fields of interlaced scanout modes are only half a frame duration.
+	 */
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		framedur_ns /= 2;
+
+	if (linedur_ns > INT_MAX || framedur_ns > INT_MAX) {
+		drm_dbg_kms(dev, "crtc %u: Can't calculate constants, mode clock too small!\n",
+			    crtc->base.id);
+		goto error;
 	}
 
 	vblank->linedur_ns  = linedur_ns;
@@ -678,7 +687,16 @@ void drm_calc_timestamping_constants(struct drm_crtc *crtc,
 		     crtc->base.id, mode->crtc_htotal,
 		     mode->crtc_vtotal, mode->crtc_vdisplay);
 	drm_dbg_core(dev, "crtc %u: clock %d kHz framedur %d linedur %d\n",
-		     crtc->base.id, dotclock, framedur_ns, linedur_ns);
+		     crtc->base.id, dotclock,
+		     vblank->framedur_ns, vblank->linedur_ns);
+
+	return 0;
+
+error:
+	vblank->linedur_ns  = 0;
+	vblank->framedur_ns = 0;
+	drm_mode_copy(&vblank->hwmode, mode);
+	return -EINVAL;
 }
 EXPORT_SYMBOL(drm_calc_timestamping_constants);
 
@@ -2221,6 +2239,7 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
 	struct drm_vblank_crtc_timer *vtimer = &vblank->vblank_timer;
 	unsigned long flags;
+	int ret;
 
 	if (!vtimer->crtc) {
 		/*
@@ -2239,7 +2258,9 @@ int drm_crtc_vblank_start_timer(struct drm_crtc *crtc)
 			hrtimer_try_to_cancel(&vtimer->timer);
 	}
 
-	drm_calc_timestamping_constants(crtc, &crtc->mode);
+	ret = drm_calc_timestamping_constants(crtc, &crtc->mode);
+	if (ret)
+		return ret;
 
 	spin_lock_irqsave(&vtimer->interval_lock, flags);
 	vtimer->interval = ns_to_ktime(vblank->framedur_ns);
diff --git a/include/drm/drm_vblank.h b/include/drm/drm_vblank.h
index 2fcef9c0f..d99772dfa 100644
--- a/include/drm/drm_vblank.h
+++ b/include/drm/drm_vblank.h
@@ -311,8 +311,8 @@ void drm_crtc_vblank_on(struct drm_crtc *crtc);
 u64 drm_crtc_accurate_vblank_count(struct drm_crtc *crtc);
 void drm_crtc_vblank_restore(struct drm_crtc *crtc);
 
-void drm_calc_timestamping_constants(struct drm_crtc *crtc,
-				     const struct drm_display_mode *mode);
+int drm_calc_timestamping_constants(struct drm_crtc *crtc,
+				    const struct drm_display_mode *mode);
 wait_queue_head_t *drm_crtc_vblank_waitqueue(struct drm_crtc *crtc);
 void drm_crtc_set_max_vblank_count(struct drm_crtc *crtc,
 				   u32 max_vblank_count);
-- 
2.54.0

