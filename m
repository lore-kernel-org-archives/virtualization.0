Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372D84C9005
	for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784646573; cv=none; b=E8MaYcGBFkiVx3h4uzL1mL6erIG61eM4ldfAh+vY7gKt8ZiOD1rzXYipFPAngBUv5ZCfStOuE38xHAFqWWqe3OqsxN8liZ46bYnFdlQNXIDrFwLb1XP7U83KxMMj10uTTx99eoCD2YX3JTyxv8qY70DmQLzIZrAR/jFuHsjdjbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784646573; c=relaxed/simple;
	bh=/oDdUEXgC8VT9M+jFY90rE1pUq4uMCvtxXZwa0u9XqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QE7gp7FvhpTff0eRrsc9J4NvH4TX/a1BovuPMzGLGu83/qJ9DeWM4NG1KBLcOGrY8o7/itPLTHRswYq8i1Ubrp1GljrEMICxx+uknpPRyT//1Af20eDA+1A3+8nn6TsTQbG36tTqb5hOKqEMNqoy0e3g1uqYRXTb63PXJq18Lis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KGh2PRwK; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGh2PRwK"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15f360851aso1236708066b.2
        for <virtualization@lists.linux.dev>; Tue, 21 Jul 2026 08:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784646570; x=1785251370; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4xJKLNUCU4zcgc7mgs3axG3RNflN5GNh8lQ7+FgeIh0=;
        b=KGh2PRwK/EpakBPGeCvvzeIx7xw8HutkuuaPwCUW+prdVTaXjpCFSo8B0NcPZpNIRC
         vFzMblr0TmBiq6IF7VJY0XNL93f7Kut8oYb8x+I+JLfP3+nZ9n7RNnMYHF/Yc4a9TSJ6
         aJmn8evD9KWWkE2fyLRlIzRsbMqDzB6x+juGjQ7sKMY1ysc/g4QgCWCZghkdEoDizK+6
         WmWOcvMxhy4dBRZ7BNzpTWLeOzn7CF/Srk6fKSssduzaandh3C+kNEemwng8u/PPYdNY
         pgyP17LIG86SYRnmB3Ohwm5dlvMMqtOciOoXAfX+sTUDSo6DQ8gur3Q8Z829kRHe21Ev
         VRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784646570; x=1785251370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4xJKLNUCU4zcgc7mgs3axG3RNflN5GNh8lQ7+FgeIh0=;
        b=l+fbkEg2yOfVaJ8NOoe9QT3U7JnVbxcHdX1iT4DYP/KnhJBn6+QWIONfi3U5+Bspob
         cnCOIWEHKUBpukYxgHPMqX7KwenuKeHswNknW3arB/MPA1TuZvuglpJHyBD/Rz8aBCn+
         ZmRfz5YJVk9FFSkuW84Etf+MNcYXNQwUE39+UYRrhySvZTivVgQU4EMmOcKYx3SkgbEf
         vuex6X3VH0TtWP+/ZG2xtzU/4t2TPNM2TWobz2wsNHayt26ps7vpSPg7G/M1flS5q6l4
         WT0wLaUz4GWhthlmmo8bAE0cElxCPArGeJc/DI3Zq8svdtu8j474/9dGgnKkVHjka+qv
         u3pg==
X-Forwarded-Encrypted: i=1; AHgh+RoJXZyRJwIqQf1uJ/L/i9dg9HzU4O/RzLEycZDlVHKSw+EAqc/XjXs+JT/zwrSgaZ2HY2teNDnhDzrryPiWUA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzip2FHJ5D2zPjYTDf4gJtDhvtOHyX0wUSxMimmUx+RI20jwEMK
	lkCEY2ND4HMrYsobdzCT9MBSWUT6eA6+AobUgjSLELSpA2DW+Ohe3N86
X-Gm-Gg: AR+sD10AWbUui4Rd+8Frtvc5PbTTgLbIEQ0SCzfuiaqLu0GNb5pR6PDKh5T8dYeleu9
	us/lbTToLGpEB0SNqWRsZPqQAKnT7px9Y9MxDDIMgIrl5QQagnzaooFBUH/BzlTXA/obqCRwzxk
	yN6iHI+EH3pMTLRaxMP/MfpnPGqZvdutOimGsGCI8JYsGOL/SCLzJxPaXwrOLQ47OxbgAYua1Y1
	laylIMNtZPSo8hRRZW44vzZAwUBf0yBaXJ+WB46FrXh/ZY87h/xyA2GLBU6ZqBRiWVqVT6abP5q
	7/Eib2eW/K/XVfHlWe0JnJ87lSHyQTDnci6Ect1JGqoM44E8FCdZyf7z2L7FqjrVK/8ckU6EJZL
	j+l4tmJ9O2dF2SSFL0N3Hmqf90IzNM8yZPiVMtmCW9LFoQ3wa4NydWza48ZjpVJs1BEhRNTEhCu
	1eV5YhboW51pLETy6YEey1T3wvdHruepdauI27A2Uhi05fchH9n8vyXZLhUBuCTN5R15FJxEKAG
	kBBKTK6yFfH1aSFgnnzFe/v87KLWRnNQCpIkfxipTI=
X-Received: by 2002:a17:907:6d11:b0:c15:dcc6:d06d with SMTP id a640c23a62f3a-c16b434f631mr862277666b.0.1784646570150;
        Tue, 21 Jul 2026 08:09:30 -0700 (PDT)
Received: from tliu-ThinkPad-P15v-Gen-3.eur.gad.schneider-electric.com (2a02-8440-5508-b816-6d82-3352-4e38-f737.rev.sfr.net. [2a02:8440:5508:b816:6d82:3352:4e38:f737])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1705afebe0sm599102166b.23.2026.07.21.08.09.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 08:09:28 -0700 (PDT)
From: liutianyi2211@gmail.com
To: David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org (open list:VIRTIO GPU DRIVER),
	virtualization@lists.linux.dev (open list:VIRTIO GPU DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Tianyi Liu <liutianyi2211@gmail.com>
Subject: [PATCH] drm/virtio: Remove usage of drm_simple_encoder_init()
Date: Tue, 21 Jul 2026 18:21:14 +0200
Message-ID: <20260721162114.471692-1-liutianyi2211@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tianyi Liu <liutianyi2211@gmail.com>

Remove the deprecated trivial helper drm_simple_encoder_init(). Inline
the call to drm_encoder_init and add instance of
drm_encoder_funcs.

Signed-off-by: Tianyi Liu <liutianyi2211@gmail.com>
---
 drivers/gpu/drm/virtio/virtgpu_display.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 44ffffec550f..048c19543218 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -32,7 +32,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_vblank_helper.h>
 
@@ -67,6 +67,10 @@ static const struct drm_framebuffer_funcs virtio_gpu_fb_funcs = {
 	.dirty = drm_atomic_helper_dirtyfb,
 };
 
+static const struct drm_encoder_funcs virtio_gpu_encoder_funcs_cleanup = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int
 virtio_gpu_framebuffer_init(struct drm_device *dev,
 			    struct virtio_gpu_framebuffer *vgfb,
@@ -306,7 +310,8 @@ static int vgdev_output_init(struct virtio_gpu_device *vgdev, int index)
 	if (vgdev->has_edid)
 		drm_connector_attach_edid_property(connector);
 
-	drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_VIRTUAL);
+	drm_encoder_init(dev, encoder, &virtio_gpu_encoder_funcs_cleanup,
+				DRM_MODE_ENCODER_VIRTUAL, NULL);
 	drm_encoder_helper_add(encoder, &virtio_gpu_enc_helper_funcs);
 	encoder->possible_crtcs = 1 << index;
 
-- 
2.43.0

