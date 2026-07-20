Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13AA43551C
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562091; cv=none; b=pNkN8p3V7wJBNyOtffNGKkd4qiQ/zgn97ejxCxjNUNK2+bPkxYkOeDi6IQy1crHZUffnhAhScabJulDi/qecmv+tPd+6WbpBtEtYASbRalwc/PI+JVE+UZMHpJpzgOfY0HXpFFCD2eedbMaOxgK0wOtirmAg2XGDjlzCBKrwX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562091; c=relaxed/simple;
	bh=b45v6y+LLUGyopM335rc2RHdtrcJI8ZwsczKTNDgp+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=onwZAFZMKgBZhOzkyWvIlyYesBDo34ciF99h35XxS0rzdN37vF0/0BCMtGUUDF6yqX40DVDrTKFDv432Ri1mnI946HET7JV9rguX1nH2HeTtEpgxK9zp0iR4WMCKdnkJO6dFyygxnAxUjBFU5hRO6QAlKXVUr5TkyCD+qZ0hGV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwO/oSK7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwO/oSK7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493b966dd74so43622145e9.3
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784562088; x=1785166888; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UCTzuFV7eFCGxIzO9ORcmzHtSM3Ggk/jrKBR0xDgYaA=;
        b=AwO/oSK7/J2gehH9hix2ybFHn5TIvV2BohEIvnCVPYrVNbVAWkiKdiHMV6R2LRztka
         RfIdMsWX3X2b/kTrEZqqhxGs6CB/D7nXb7UKvrGvA6OT/z+nfKNRv9b6cgvC7sm4HF08
         /1yfMtWB9oLgay0qcqsBZnY7aaMUxefGAgHNYCVi7ZdnOOsOmtWKVn54bPupbWaP0tPc
         ACf/8UAqIm/5o/hklHnMyXGLxAa20mfVeXou35pARoYm2yO3hpTgWUaw0kaipLvsqRld
         MYfKyj7OZ0sEkcKSBiSTX0sNiC6OIJEoc9kb4QgsEV2jrO2uf4p1T3wyI2bGHg1r6paw
         3iKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562088; x=1785166888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UCTzuFV7eFCGxIzO9ORcmzHtSM3Ggk/jrKBR0xDgYaA=;
        b=f4vwKWQnDYnsCxKHiqrz37SY0lTJqSUn8H3+bNQUaofL4L+t1SWDoiWwBcZo7aO6FR
         XBP4e/hv5mDkSsojJE87uHaguYlN8ushu0Aay78x5V9MRnznpf27DzVubvKA/MjnKnzJ
         ONOt5xWIbfQO375pGgrrJl4y6Nqntd9JugyfeOOoJh+bEJRx4MgFVlp6ktNY/AhL4O0u
         KbUXawCgSSbyX+UZPb2uMRbRZmu8wxG0jVx8S9C3ySIEPfeHdAoGxJDvjwdBFJQXToQA
         KtZMWM41Km2GMQMoU3VB/L6/+1EKEtakVuAg4kJBxwCcnFo5wwHYW/fKhKBpYMUhY0o/
         Mk0Q==
X-Forwarded-Encrypted: i=1; AHgh+RogT1BellPKrlS3Y/qA6NTD7vpcFzG8hIN50i6wO80cu5rfXFHAJgxMBN/vyGhuYWZPwuuPwsMDpgp/7Mi6Fw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkhJpVTER8Dkn9spWYB7ZH1Isc/2kEutpbx9QRtkv4ztmOyCVF
	6jmfermbYdM9+y65aZKTgNQqyOt1/z5xU2/7P0sXha5qgQ0cIHonzolZ
X-Gm-Gg: AfdE7cll7psY0EcEV83vniJZ7zidhj8VDEGSERVnC+xauS4bo9Dn0a/7076M4WVE9EG
	DjYtCbArwxOaX8jgua4SO5gYbid1pD9kWZbQyLhBp1PAM/V+rwEMaDQqcSjPCrDNMw6fmBpUJCp
	1D5DrXbiFlmdTo5UEg2j9iNl+YTdXr8qR/b3SqtsIkRGyCmMVSpkZLxAivdJRywdMq7j5w4Xp1Q
	QJPgTA7k2x7K2aGeRF0EP1nGlB1Tx3G/puA6SYtu7W/7WMuEbYgxye3/07ZeYsFlvGXesIrEnd8
	nsvFNAWdA0CemWdf929p9/omLPTbuljV8YJfy9ByoMd3GX41MAqOfYRN+yjZPZzKdb42NvaPtSc
	yUtV/VU+mltydxGRdDKBXicFij0j9WOT2dEojLfHLsYRr3gVQ3gbnCmmWAPwQHTqZy4HrDcX+U4
	6lUGXLtDK3JzJR8sf45m9C
X-Received: by 2002:a05:600c:1d1e:b0:493:b6ee:fcb7 with SMTP id 5b1f17b1804b1-4954a3f39ffmr153406895e9.14.1784562088052;
        Mon, 20 Jul 2026 08:41:28 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.41.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:41:27 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:40:43 +0200
Subject: [PATCH v2 11/15] drm/hisilicon/kirin: remove dependency on DRM
 simple helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-drm_simple_encoder_init-v2-11-5020b630668a@gmail.com>
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
In-Reply-To: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com>
To: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
 Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Michal Simek <michal.simek@amd.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Stefan Agner <stefan@agner.ch>, 
 Alison Wang <alison.wang@nxp.com>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Jyri Sarha <jyri.sarha@iki.fi>, 
 Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Xinliang Liu <xinliang.liu@linaro.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, virtualization@lists.linux.dev, 
 imx@lists.linux.dev, linux-mediatek@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-doc@vger.kernel.org, Diogo Silva <diogompaissilva@gmail.com>
X-Mailer: b4 0.15.2

The simple KMS helpers are deprecated because they only add an
intermediate layer between drivers and atomic modesetting.

Open-code drm_simple_encoder_init() by calling drm_encoder_init()
directly and providing driver-local drm_encoder_funcs.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index 15042365dec0..62c5bd3277da 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -20,11 +20,11 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_device.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "dw_dsi_reg.h"
 
@@ -687,6 +687,10 @@ static int dsi_encoder_atomic_check(struct drm_encoder *encoder,
 	return 0;
 }
 
+static const struct drm_encoder_funcs dw_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs dw_encoder_helper_funcs = {
 	.atomic_check	= dsi_encoder_atomic_check,
 	.mode_valid	= dsi_encoder_mode_valid,
@@ -708,7 +712,8 @@ static int dw_drm_encoder_init(struct device *dev,
 	}
 
 	encoder->possible_crtcs = crtc_mask;
-	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_DSI);
+	ret = drm_encoder_init(drm_dev, encoder, &dw_encoder_funcs,
+			       DRM_MODE_ENCODER_DSI, NULL);
 	if (ret) {
 		DRM_ERROR("failed to init dsi encoder\n");
 		return ret;

-- 
2.54.0

