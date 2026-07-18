Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB08C377EB9
	for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 23:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784417790; cv=none; b=JceorkEGnFqBlxzqkkOm3Ayvgw9lV5j1XDIM6GjpikSWuJO/1/jZLxIBF4RD/IzVi9pCwQmtrB+08Iy/66PaXN/W1RlQM4izIMSXQbTQ2YqrUt7rp1SNM1LXDm6Srk2/TdPkQ7Y9TCNxDUIjt8ugsu1Jc6p36Vhnr0waB1Ued1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784417790; c=relaxed/simple;
	bh=BI9R2SvxdH2gwqK0B92kFqt0y5mZiDZk7s7kVtduUr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U6jgPDY+QNaxqbBENcqsMKG7kYzXuuLlhWhiJ8cElSXueYQ88tvcbWWcLEpeI85LhFf1/MrZBJapEivQa4afPc+KUVEMH/+wihQNQfGy76X01/JqsQxonOo02xu4/nfBNxnrDLsRMIUtmhBnLYo0wYxm8XJIlIk2znJcmjQGfl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOfItG68; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOfItG68"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso13190225e9.3
        for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 16:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784417787; x=1785022587; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3qoMRiXvV6BHSei+lkJBYDW1cqZXXpht0BCmlOitIE4=;
        b=YOfItG683yFWqxstjQN0A3W0UzX61klV5o+Qaoj19jb/2P2gk8DTS6vNMdrzB9s1pN
         NX93hS/rAzm5UU3RVR7/Bd3FM3No4sXx3sj4wpcahFFWSpoMbi2rrxdHjr1SUPQ0Rlno
         z1idOFfnC362Yw65b41zOTddKD/xjjYQi7E+PucayF73T/I1BHBAK6kp7sRvstXLmkFT
         yIuor8VPrZcx1enXez6CGnQHjYhAc3MPibrZSTfqtXK0PlJqTgU/y/bLgO/v4r0Frj7I
         uT4eRo95L9Asjnv9mIhzmSxWLwJ61MlEEsDq7q6l/aAgeTrVLHMcOBeCKo0Ly5oWJ0B3
         byyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784417787; x=1785022587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3qoMRiXvV6BHSei+lkJBYDW1cqZXXpht0BCmlOitIE4=;
        b=VHMZ8nGkj1jeG58tByXD8iU8jwTVAiaTROwuE9dU1tjOTcLrJggVKwyl5gmCG8wXjC
         xQM+ernG13qC3lEzsLUjaCbXA/ZHo4yQP83iDueaUWh2c/1RUOk57xmmhTxDpDR9dQPh
         xABsIEkiBxbYsZP8oZojS7ckQ6oRICE2heqXthvD1QLH+uMuTR+Ktizwxu8aorNNQtpo
         /JAp+M6YEFl+4mbnLyKdcE+RcE4HGT6pCNmcOSuR3pbKGgV197SHPoLppeQ/47IhUCcd
         i4MRLsFutwcvUHqaBQnBvlIwB5/p5QpT2pUpE9EtjWry6WnBp7rt+ZPUHgIpQBDHCvHK
         6MAA==
X-Forwarded-Encrypted: i=1; AHgh+RoP1SmEnnmDAc3OqLv4PgTnU2fmJSbnZDfB7k4YM7NDEpdR2q2qshuo0d8kSVJ9W94C5BB064nLpvcuIIA/Jw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzYYLyXY9t50OESwkZxNVv6HxbEysuttvvCp/QLwuP5mJG8FIGo
	4kSSWu6VJam24IIPIa7MAntEKtEtMPIbSKhX/N0JUORHxYFQvjZPYqae
X-Gm-Gg: AfdE7cmxZXmFcnzsNrs80IsBdhlcOD5rMx6wiqDKDG2ZfSYkIJR94djD/cRDsuvtibO
	nEGbo4Mh/X4g5CKU5Cn1/Ah/SRpvIfZN51PmV3v+PHC1rz6eaUpIxZDmYLwsQtIbFQZsxVGhJnU
	HedxAo0nC5hjXqAKgzbUYdl2TP2Lir29W6Se6a9+G9FmTPbmfWFUh0M9MTjGLH7GLH+bHOETGLn
	9kFuodVCHDZcloIPoBTgHjCAa8fxn+ImhHw3UH8ZDeyIPT8w/h2yAsYoV0AZU2ErmXstOXFh8Ae
	227FIeO2KZHtUsBy80CfCcjQdBGtahczhvo1S7hC6q4bMQ/me/Nz0EHZEZuCmu0AXviHxZO/LPz
	sW/1jBpNV6LJtx8AkFa/b5aT7ErmRIR17ZiMnxEa1TCgls9+onzYVCWH7E2DZFIF7yeJnY/iUjU
	H379Yb192W+JEfB27kaeBY
X-Received: by 2002:a05:600c:a42:b0:493:e983:806e with SMTP id 5b1f17b1804b1-4954a3ee98emr95800615e9.3.1784417786829;
        Sat, 18 Jul 2026 16:36:26 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:645b:9e5c:7fe3:c09f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm160964675e9.3.2026.07.18.16.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:36:26 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sun, 19 Jul 2026 01:35:39 +0200
Subject: [PATCH 08/15] drm/imx: remove dependency on DRM simple helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-drm_simple_encoder_init-v1-8-a78c509e3062@gmail.com>
References: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
In-Reply-To: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
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
 drivers/gpu/drm/imx/dc/dc-kms.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imx/dc/dc-kms.c b/drivers/gpu/drm/imx/dc/dc-kms.c
index 0f8cfaf4c4d1..a9adcfc68b84 100644
--- a/drivers/gpu/drm/imx/dc/dc-kms.c
+++ b/drivers/gpu/drm/imx/dc/dc-kms.c
@@ -17,7 +17,6 @@
 #include <drm/drm_mode_config.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 
 #include "dc-de.h"
@@ -30,6 +29,10 @@ static const struct drm_mode_config_funcs dc_drm_mode_config_funcs = {
 	.atomic_commit = drm_atomic_helper_commit,
 };
 
+static const struct drm_encoder_funcs dc_kms_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int dc_kms_init_encoder_per_crtc(struct dc_drm_device *dc_drm,
 					int crtc_index)
 {
@@ -55,7 +58,8 @@ static int dc_kms_init_encoder_per_crtc(struct dc_drm_device *dc_drm,
 	}
 
 	encoder = &dc_drm->encoder[crtc_index];
-	ret = drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_NONE);
+	ret = drm_encoder_init(drm, encoder, &dc_kms_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret) {
 		dev_err(dev, "failed to initialize encoder for CRTC%u: %d\n",
 			crtc->index, ret);

-- 
2.54.0

