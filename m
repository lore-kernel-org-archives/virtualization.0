Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F85443785A
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562103; cv=none; b=hJmKfrjsQhVD2GhImXmgl36ATCwAp89Bi1g3vqVNQgNXHyzOubWKk2XES8WE0MR2EV2reZ5EPR6Itize0gH7oK1Sy21kqlaeIB2C180GhpcBjD16Ub0HVr3ElPt8us5lr7gdMyQBYuWeMlzdYdvmzTBI0yszp7zjYe17Ljyr8tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562103; c=relaxed/simple;
	bh=bMs/03E/pLT09J4z4UiyyuHjtplBVReDGtgMdQzn3hE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cN1KNi3fVhyHV64i0Q8GjNwwhjAaRp+AWXWFLJEANckJHCTgmd+MeyVkwpogYjovqimlNwOOyRTHJPqF7x+Qm8xPHZ7mwtYz+GFowaGBDMbIr75ftZUtDzhmg1rO8XhmeXbIgCV+GBbrzEQ1kJJDNJNQTmuUJYZak1c5g1eGAec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djDneKvW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djDneKvW"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso509670f8f.0
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784562099; x=1785166899; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LYdVSEJYSxlpPRyHCi7r5tN2RJPa+UFv81a3Ufh1joM=;
        b=djDneKvWUaYWfrFqEPa2ArauCAD457OWTd2SmDaQ/LJb2bm4+L2rB6sKeDMwsncISk
         R1kKUiKPC+TltqBkJU2MsSScDkfNgIvvgGNxVppTYB5EkUx2W2mmMGRstO+WdY2up61i
         FC9Hmb0BmhzGJFn1mHIKEMy5wvHdjmcUg9HwqqwlKIGcH0/Ah0sxREVIbkhBqJUZhw4Z
         a1aKCk2Etq/+wpWTzK+NyB1IQRcoyACyZZNhWZxWLUm31+4QLFMSU7DCxcFtwe0q03vO
         0d/OiYm67rIz6fyEQOUIBspQRPPTUL7Qb3KCuvRpNurB/ThYxy1GKpZy5Aru73UI9Vuu
         jLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562099; x=1785166899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LYdVSEJYSxlpPRyHCi7r5tN2RJPa+UFv81a3Ufh1joM=;
        b=bOz/fWKkhQT3Fu2OL8tqmMHcnv1gRNMeIvVX0bQwRASI/XRAA5KYdflXzXYnU5QAqb
         lYHK/bMyyj/Fwk9XQSG8ZCGgeo+PgUoUd2uIEMRtpB6/qXuflzm/BQplmtY9VylLN2CA
         h1ZHER2XlOMDXWQBHG/Hemy39BpL9TMiIvKosYiU+QtdCaQinVMwdcroql0RnDzd8NM2
         GYLWmeiwJjys8URWtd3T0HZOo+ztpu2UAyPPp2AU/86Y1z6ZlMHcgEhBg7/a1VcHQTUz
         smRUCT7/uHJwBmkDXigGZ1cD93I98hCScg/hCnftVtrHGNnKKwPQuZZ29Txtan2GYciJ
         tJSA==
X-Forwarded-Encrypted: i=1; AHgh+Rp50AE8w0PA+eqtf8ydomXtEQ7ZrmSm8SvO/q06rvUZYdFegJuS8dafauJwCBHgn8DiMtcMokqoux/m+dj9lA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzd0OT07cg1lXhOk+chP/0A0i+G51Bb2kYHwh3KcAQgvsSAV89Q
	Xoa6KOFx46V6lHHVIuq3AlROU0s9SKYH68Y8ToNl6u9yRVuHwXJQ7opR
X-Gm-Gg: AR+sD11QyLodCHH/p93FJOxnyhP9rQki+Ka58IBLF3/LAP5JW55yJmvIQRW1YIa8Qfi
	dkNAIyC11aYHX8eYWUK9m3fKcsDjTs+n3DyePEdQiA7CcxePq3NGnoaSrA1IEf8bhggeLGbdq2G
	t7dicA6bXHyPaU9Hv7eR+XWEeqmlZd0/sD75rXT4Now/gnZuVBRVdQgi1qID7I3zKZalTzWAZgv
	euqXTGzRuz0XQs9SnPkP5NkPTfLomopcBLevPgoiRRXy09ukmHRi4kFPTpvBHFtRNv6Yvh1dxdo
	2fwimRNxCR7xSuj625FJ9j9xNPXSDgG41SGfAWoOnD50e81Pzi/Qqb48n9iYwjEsepMGgq9gwbx
	fAlWDsSuBhE1x/HdLoXlGRxUT4XPfn57Mpv60hBJ8CiiNBM1GWxxbuI1HKlS2pmPMXRXBPzczXc
	W2F/Sw7Am+FQ==
X-Received: by 2002:a5d:5f91:0:b0:46f:7d90:8121 with SMTP id ffacd0b85a97d-47f62305661mr18563371f8f.14.1784562099337;
        Mon, 20 Jul 2026 08:41:39 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:41:38 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:40:46 +0200
Subject: [PATCH v2 14/15] drm/drm_simple: remove deprecated
 drm_simple_encoder_init function
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-drm_simple_encoder_init-v2-14-5020b630668a@gmail.com>
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

All driver users of drm_simple_encoder_init() have been converted to
drm_encoder_init(). Drop the helper and open-code its remaining internal
use in drm_simple_display_pipe_init() to prevent new users.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/drm_simple_kms_helper.c | 13 ++-----------
 include/drm/drm_simple_kms_helper.h     |  4 ----
 2 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/drm_simple_kms_helper.c b/drivers/gpu/drm/drm_simple_kms_helper.c
index 8e1d07b9f1e3..7878b9d7d524 100644
--- a/drivers/gpu/drm/drm_simple_kms_helper.c
+++ b/drivers/gpu/drm/drm_simple_kms_helper.c
@@ -20,16 +20,6 @@ static const struct drm_encoder_funcs drm_simple_encoder_funcs_cleanup = {
 	.destroy = drm_encoder_cleanup,
 };
 
-int drm_simple_encoder_init(struct drm_device *dev,
-			    struct drm_encoder *encoder,
-			    int encoder_type)
-{
-	return drm_encoder_init(dev, encoder,
-				&drm_simple_encoder_funcs_cleanup,
-				encoder_type, NULL);
-}
-EXPORT_SYMBOL(drm_simple_encoder_init);
-
 void *__drmm_simple_encoder_alloc(struct drm_device *dev, size_t size,
 				  size_t offset, int encoder_type)
 {
@@ -363,7 +353,8 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
 		return ret;
 
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_NONE);
+	ret = drm_encoder_init(dev, encoder, &drm_simple_encoder_funcs_cleanup,
+			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret || !connector)
 		return ret;
 
diff --git a/include/drm/drm_simple_kms_helper.h b/include/drm/drm_simple_kms_helper.h
index cb672ce0e856..c95f86ff355f 100644
--- a/include/drm/drm_simple_kms_helper.h
+++ b/include/drm/drm_simple_kms_helper.h
@@ -68,10 +68,6 @@ int drm_simple_display_pipe_init(struct drm_device *dev,
 			const uint64_t *format_modifiers,
 			struct drm_connector *connector);
 
-int drm_simple_encoder_init(struct drm_device *dev,
-			    struct drm_encoder *encoder,
-			    int encoder_type);
-
 void *__drmm_simple_encoder_alloc(struct drm_device *dev, size_t size,
 				  size_t offset, int encoder_type);
 

-- 
2.54.0

