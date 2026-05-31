Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FED37700A
	for <virtualization@lists.linux.dev>; Sun, 31 May 2026 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780213000; cv=none; b=Wt0WwxnGIgyi4XvHnXnzaXXJSLanV9b/xretkOvFM/HzYCKArJQQOJtSnfHwxpj8XaOp/0OgajgKjL3pcTrUZPF99b+Qai5jpxRWdD2Owe5wKtQ1U8d8hAlEFpL23eKN2nsfaVKxO22RtBcjqr1KqyIvUGFidDQkJLNm4ndyGRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780213000; c=relaxed/simple;
	bh=ebKI7dfQEJh47/K4AATE4arzGNHHlSJ98haph6AoQ6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eEwU/MOA3Gv3V3TvrIzEjAYEbJKPjYlBY96hoeGJ48SXx1U56ig2TWPti49E19LjwM4j2seFmiuCsdH5eqjlROdtHjG9qIdlkf10STe3SBo1cF7HLIbPbOkYf7n85T1f3/GbKHybMleVbT1iXuV1tkIVErAe36FN1Ap9rFujLXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xy367K4v; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy367K4v"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-842358aaf36so153083b3a.2
        for <virtualization@lists.linux.dev>; Sun, 31 May 2026 00:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780212999; x=1780817799; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jKPe1TO+FoogghrC8LGLLeXq7GSJc49agxpkGaHZqpM=;
        b=Xy367K4vtLr+tFs73vLnS/8/e67WGQ/4U8iimxHWWZfiu6Wbx++7guO5Hnj52iL4Tb
         fxqoTrQgO8PZWDk2F75yr5wvqxU16Jc/9qxCqtovUA19mqmm9iXNwoRBB2Co9cKu0H/5
         dkGeBdvmotfan2zPkKAV72tTVkrg7jk9jnrDHSQaWvNeIrvzsTrtFf91Rq1pkSbrLe0x
         QND/DTFr1fodUCgoQZMhS8bxziQethjYIq9Wgyz8w3xHxbdYslzjV90n7BujgfzA8P7W
         01GHB+LrhKxt2KwBVcaUCXugAJ8GpUvKSOlzIZ34fb3aEygpPqjUF/tl7SG28vkr2QFd
         a0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780212999; x=1780817799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jKPe1TO+FoogghrC8LGLLeXq7GSJc49agxpkGaHZqpM=;
        b=hcfd4/rdLo2v74Gkfo1cqFZbIVN04kxUP1xuSrf+3vKp+qs9ZCXnXc9OuhlRP+r30F
         pGUk1OMkMO6H8Ec3qGULIjIJIViJ/jbyAlDvlH4iAKnHyzMZcOfPprmZh0mhUzJl3Qwb
         4qRfi7bERX7GRaJwgrvXD1ZUZIAhV0pVexVGZjtLDjEYdZc/4ItpoLhZD9V520D56Ijo
         dS4biwImpORhwWCXGY3ql74cWKBp76mIRNchsM4ejOE7CN3XP+n7g9vuy7ji9Rr9Skgd
         t4kXBRujNfWp51zbpCWo+2rVgS75Scr8k39F2biJskasdwZOtChQaigSne7Pv4//dRYZ
         X79w==
X-Forwarded-Encrypted: i=1; AFNElJ9EMQrzEmRVkk9DWJMfAI0+08SnT0YkVkC3i4U+M8UhyiudgSVlqWxcvPwdN2Z42BUtVr3tkZ5eFMtwKFBu1A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/Ke/VVWix+qtuiYzuPbMkY6j6JCEY98VkTsaEIu28NJd+taEl
	XmLpkoxUgBYTlzIkerjJV2BiYuDEUH59+mNCVt5bC6xAC4TOqsgv9g2J
X-Gm-Gg: Acq92OH6aPE5QvJqC7CMCZfdDKl0fGr9BlUmL9i+e4i6cfE5LW15kV2AmNe0l+7ZkRY
	N5VQCaEu3VnBBrldXxDVVJfKXGUj+HpRFR9batPOFU64ZRl7K/DL3KBiNrnGQVRoeo7BDIqYZsH
	Xbhb2SFFDVnBt1zyq2CDfI2x/NkcCQXnfUjL1atDKYN1MBE5gxKO0c4dqMEG5tao/1AOLHSSxOi
	f+4R7owEUkCGJUm/39wvYYh4IsH9iGSgeLjRjjBJsqpfILSr+cxSVCVrmvmqgA02sl7yPlclvHW
	go9qbE4tV6YWRQKx4t5PBcnqDrai6BaCXF/mvfxBj5a29AvD+LIQ6yZlOA3H3oZUzxttGMsajeq
	bV9zvUlM6e/CLJIG41zLltiztUiypMNB2FjUHUEnQwSw6nvoqsXUKkGuo6r3VuV5iEYGWdWSEN9
	fxo39szLPXXmNV1jx7Hu/YqpmDnOY6L8pf9GUfk0WCRQ==
X-Received: by 2002:a05:6a00:1a05:b0:842:3373:f662 with SMTP id d2e1a72fcca58-8423374104dmr2845469b3a.11.1780212998783;
        Sun, 31 May 2026 00:36:38 -0700 (PDT)
Received: from Naman.Naman ([2401:4900:1f39:4c4a:1e56:d301:ce43:ac25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8422e712309sm3760709b3a.59.2026.05.31.00.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 00:36:38 -0700 (PDT)
From: Naman Arora <namanarora029@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: tzimmermann@suse.de,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	stefan@agner.ch,
	alison.wang@nxp.com,
	jyri.sarha@iki.fi,
	tomi.valkeinen@ideasonboard.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Naman Arora <namanarora029@gmail.com>
Subject: [PATCH 1/6] drm/fsl-dcu: Open-code drm_simple_encoder_init()
Date: Sun, 31 May 2026 13:05:27 +0530
Message-Id: <20260531073532.8609-2-namanarora029@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260531073532.8609-1-namanarora029@gmail.com>
References: <20260531073532.8609-1-namanarora029@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The helper drm_simple_encoder_init() is a thin wrapper around
drm_encoder_init() with a simple destroy-only encoder funcs struct.
Remove the dependency on drm_simple_kms_helper by open-coding the
encoder initialization directly in the driver.

Signed-off-by: Naman Arora <namanarora029@gmail.com>
---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
index 84eff7519..a16c6013e 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c
@@ -14,11 +14,14 @@
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "fsl_dcu_drm_drv.h"
 #include "fsl_tcon.h"
 
+static const struct drm_encoder_funcs fsl_dcu_drm_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev,
 			       struct drm_crtc *crtc)
 {
@@ -31,8 +34,9 @@ int fsl_dcu_drm_encoder_create(struct fsl_dcu_drm_device *fsl_dev,
 	if (fsl_dev->tcon)
 		fsl_tcon_bypass_enable(fsl_dev->tcon);
 
-	ret = drm_simple_encoder_init(fsl_dev->drm, encoder,
-				      DRM_MODE_ENCODER_LVDS);
+	ret = drm_encoder_init(fsl_dev->drm, encoder,
+			       &fsl_dcu_drm_encoder_funcs,
+			       DRM_MODE_ENCODER_LVDS, NULL);
 	if (ret < 0)
 		return ret;
 
-- 
2.20.1

