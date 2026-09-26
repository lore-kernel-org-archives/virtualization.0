Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0637E5F5
	for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 16:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790440301; cv=none; b=JqO/uhjjWHq4t35J/22VbSDffaCUGdRqPHrie62srkBiQ5DMPrTo9WG0hq9JRXB9SKWcodwFM5foPIgrjMRDD9wGkCqtaunzS+wzWnvXXokn52cEXkI6cwTNpXuRyJ6TLbu2/zJ5ttKGA9nZAZRhoQbF0Z0JgfKgAMnOBmufa1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790440301; c=relaxed/simple;
	bh=rlxFcGgeJPs1ww+AeSrKhOhmgDqoyNKGjcG5mzWZxKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjodOapQsz5a+FyqyrUDziQGq23sXY7xrAi0iNfvvvlvaNY7H4RzdoMwhr7vFNzuEgnnyvqwPoF6rcQjAJS8gkCmuGjAz+YsDJvVJKxZzrYHyxQSmfGAyqUfibVm1GBB35ZbEQC/sxDIwHBRKh3WesGpyiIJJGZHE0F2EqjqvoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUun/Ng6; arc=none smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUun/Ng6"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93bd580489dso169348885a.1
        for <virtualization@lists.linux.dev>; Sat, 26 Sep 2026 09:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790440294; x=1791045094; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKaiZuCWzgj/35GoC92DyRMuXF3uBWzJWZETTYPAMUo=;
        b=UUun/Ng6SsJA30Cjv7M50AOgBgoDpMH39gKimijnifrk0jgnFLAl2JFhQaM8yJ1kK3
         r5d0Wl1/jtytdv8ovmH7H3ief56dNLuD5MSbK5efS+moBLVrP8z01OiOMCbrFuAFMI4O
         Ybx3lPTHMwG0FUUSZhdbUelEXqj2dUb1QJW/e+lliUguZuYK8daxnK621E6dYrkTl5/F
         Eja0p+UV6G/5BX+YKE2veK6Un+JAA2urYq3AruBmZFOjmQyXJLPkMADYFjMdGkUWqy0A
         QmDQyGnv9S/5Hoj1o/iwYqyDdt68hxWpXQDHAfA1RG7YxYCFvM47k0YgNlckvSkSPFtv
         axLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790440294; x=1791045094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nKaiZuCWzgj/35GoC92DyRMuXF3uBWzJWZETTYPAMUo=;
        b=exbwqOfEzj349kCnVKCuI9X3Rl1PBffUQfu4si7nTUR2nqclTbYC610pfQY/KB5bc9
         4+5iDKFEAiVMj3OJ4kuwqiJ0NO0a2vPkdRbfmg2X/ku1Mgo4xGtlgdgQHjnlk8xN1qLD
         PXISF5gIVQW27bSabpfo5rdX6Iw2DGV/SkhxHWlr7Wf9D4iiSPjfMsnic4EzoMMQW0Wd
         NTM0XnL2IyMQAv26Xg8f2LU2VOx8spwSD2JkgE5HcuJ7ul2c+vwyT0c+MGn4ljg2HP29
         xUe4lWzRrAho+bjYGNn7MIaXZehpxxIarXFru0FOTTLxfXArkkBHz1XLxeZUNldtmxv9
         j7dQ==
X-Forwarded-Encrypted: i=1; AKwUvBwj60nzCnKIvkpWP9VMFiS9G4JwzIv4uJReECpklMKAAEjMUo9390VE2MFyN5K8SXkIYru8QdlnBfNa/hii7w==@lists.linux.dev
X-Gm-Message-State: AFuF++m5uZVy614QwxvzSs7CPbTZWa/wS0UdpNfiIrZrC1AeFYjgb+VS
	fC/Pz83+lW2amQ5qG9gcOMNIhjxeP1sTcI3bUO1nn0buy6NwlV6d8IkA
X-Gm-Gg: AYBFou0GHCUcvn5y6PCsltNkC4oz7ZgQ9Us+IGeuQZWF+lW7iaS8QDeqbmx7RoW0Elu
	Ci4lziD5F6YVXvsurHuiETmdun3dkIBQKd4l6hK04JEjDmTVu5bfM7iqHDQtgkGgniZ5tzVLeDn
	U+6craZYefsvENXuXIaqDPbE4Ubq1D+fKxHKieGW/Gki5p4M96sHT9DfegDKKLhNFWy8eggFkUS
	xsleTA8lElmjP3vnV92U4UqESpStRyzI73LdO7wW9cHZX3436vCKIaepzQWO8QEYnFnQmx78+PU
	vUeBvaakHgK+sGGkp/KIrfckN4Mic1W42WxzJnLNI6vHQ8BrFq4b7EWx9tcOOLbUe1abis0Qsif
	TtCncn5VYcJR3gFykMfId8j4VJEebYsPz2wwvvh1yChYhOLHEEJtzIindvCRxrPVeFGLhqAeH7f
	MoJDJTTta60NkLpb+11etSDJv+QXZ2wFCZKhYPztYBWYPV78FE82xx7BVd4DZRadskajXZVTir/
	iIdVUQ2j6MQ4wyMUk3Py44ha0IVRO9PAndDdqS2LfnCL44sPCb/V6tDZg8uos0qykY=
X-Received: by 2002:a05:620a:4686:b0:93a:2e8:5afa with SMTP id af79cd13be357-93c43ca5e78mr1028604385a.30.1790440294481;
        Sat, 26 Sep 2026 09:31:34 -0700 (PDT)
Received: from localhost.localdomain ([2600:4040:29f7:9600:f571:6178:b590:34a4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c4fe09037sm341332385a.27.2026.09.26.09.31.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 09:31:31 -0700 (PDT)
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
Subject: [PATCH v3 2/5] drm/qxl: wait for pending commits before applying DirtyFB
Date: Sat, 26 Sep 2026 12:31:20 -0400
Message-ID: <20260926163123.39217-3-dillona@gmail.com>
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

The modeset locks protect software state, but a nonblocking commit can
swap that state before its hardware updates finish. DirtyFB can then
race primary-surface replacement and draw into the preceding surface.

Wait for the current CRTC commits while holding the modeset locks before
checking the primary and issuing dirty updates. Return wait and lock
errors to the caller instead of reporting success.

Fixes: 9973c879cff7 ("drm: qxl: Atomic phase 3: Wire up atomic page_flip helper")
Assisted-by: LLM sparse
Signed-off-by: Dillon Amburgey <dillona@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_display.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_display.c b/drivers/gpu/drm/qxl/qxl_display.c
index 1f869734e14d..51087cacff74 100644
--- a/drivers/gpu/drm/qxl/qxl_display.c
+++ b/drivers/gpu/drm/qxl/qxl_display.c
@@ -437,10 +437,17 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 	struct qxl_bo *qobj;
 	struct drm_modeset_acquire_ctx ctx;
 	bool is_primary;
+	struct drm_crtc *crtc;
 	int inc = 1, ret;
 
 	DRM_MODESET_LOCK_ALL_BEGIN(fb->dev, ctx, DRM_MODESET_ACQUIRE_INTERRUPTIBLE, ret);
 
+	drm_for_each_crtc(crtc, &qdev->ddev) {
+		ret = drm_crtc_commit_wait(crtc->state->commit);
+		if (ret)
+			goto out_lock_end;
+	}
+
 	qobj = gem_to_qxl_bo(fb->obj[0]);
 	/* if we aren't primary surface ignore this */
 	is_primary = qobj->shadow ? qobj->shadow->is_primary : qobj->is_primary;
@@ -464,7 +471,7 @@ static int qxl_framebuffer_surface_dirty(struct drm_framebuffer *fb,
 out_lock_end:
 	DRM_MODESET_LOCK_ALL_END(fb->dev, ctx, ret);
 
-	return 0;
+	return ret;
 }
 
 static const struct drm_framebuffer_funcs qxl_fb_funcs = {
