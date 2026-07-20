Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD4433BD8
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562080; cv=none; b=HdYGTx2zC953/0tuyMHyqD3ph5Ideqs5SkVIWrJsheTPXyoOyACvPga7JMv43GXQNHzhAXM1hpEhyXAfV/XCgrghYagb0t5dTTXLQSwh6EryU9Hjk5a9VW/vB1Sq64How0n0oWlSfKqOPqPYHTe5Fe2+ePlPI65hheoXzVJ5DyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562080; c=relaxed/simple;
	bh=BI9R2SvxdH2gwqK0B92kFqt0y5mZiDZk7s7kVtduUr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t6Z1JJbHdjdlnZFD1Cuu7GH/ClN0JGGrHiDYZRZkwvWB7XjVr65kjt81SXM6SG6VQdJvTYwiinHbvzK745X96j4cOrD9JKtbs3fn0mGYIpxW42HGAiiBXwR6lA69lKs4T8R4WiQ7z8PuenQFsZcGw4I07obJJ1/42KynM0UGo2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XT1O++46; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT1O++46"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49555a0e68bso9438895e9.2
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784562077; x=1785166877; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3qoMRiXvV6BHSei+lkJBYDW1cqZXXpht0BCmlOitIE4=;
        b=XT1O++46N5Nnkp+Zz8A8j2trpHzrBU3yMEf9Tb0KKD0JdzHfacnswkWnlmpCaHKhqr
         uVEYMMx6vHnonB1OGmyGd6lETy4TUzbzYE2xmPtUwop9CXwmyNafE43V+YGI2gvztytq
         m1n7GcLDAXsKsrmtTxGJAluZ2LSHbGlfUS+xIZXrFVhG3B31HsGyIgVqIZnt8KLmO2eE
         seAQzbQY3y5jYMMUY4BeJPaG2Cf7ZTM7gzw9PKicxGKwuGDJAWSylQmsXr8KVzG7Mk+6
         brnZnB5gBH2wIFnLY7fAB/iDhk22kUhjvQu3sobSe6qIDsWzdGACwv4g0IGFfzDbi+KJ
         g1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562077; x=1785166877;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3qoMRiXvV6BHSei+lkJBYDW1cqZXXpht0BCmlOitIE4=;
        b=eVO37x5QfFAafAq0HMStEU11eF+aGy2HFMFlug0ikGCM2wZjRnmMU2uUi1ppCNa7Kd
         /xCgTdmM2DxvLEo52Q3nPQRuf4DUSx04+5e8yJTfHE6sTEco408W/c4U8RSARYUgkjue
         Hd05lh2tgOjOwAZ4GoZNnb8h7T8S8CC6vU29btAwR1jUa20cbBlD8UiCqUqo7f22d+DG
         b5iuklKohoye56r9oxxlhhYRfhNXQR5k2FUpVZYBZR4OMIfbfFLs6qc3obPp9gBBRPS8
         tRzCMzW5GQdl1Qp+gPuoPGPk3uU+F16nVmxSS9iJP/nZj7XA7/v6rrXsRn9rkFyJaiXF
         bMFw==
X-Forwarded-Encrypted: i=1; AHgh+Rqv5dThacxYFPq0R0UriV/02zG3hGjHtsOW8whWGhFCHmJ8x9TlS6GBjb72kHiaHUSWgpmFUzRD7XuHZHsu9g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9pc+tj4BhVJUtRv4xchABgCLA0z2zql1ytduNrDWo2TEd9oa4
	6yNPx6mZN7fbjBNtnrpltEx8d7fQF0RSaVFyu9OORX6RMT9CdsZL/Mwq
X-Gm-Gg: AfdE7cnMW8RPYn2CZ+HwEn6m+64GvBkimWyu+xBTdvR1WUq6w0R2Jh7atQ8gqJPhBp5
	iMM/+mUzMrIh7pBI0U9BpnDLnT1mh1dBiDCVIMl4+fOgG40AhInL2Tzq2JZcFDDkdkF/YMgkeXZ
	86hcIMgW9Z1LGLJP/lz+MX+cLBUIcEads3MboDhki176y8m8BSLXHxMy+RtVB9cCEKcQpKQI7Lk
	b0FxJtAkfNzkEGFlrTV9AgY0D4t1c8WGF0oZ/GB2FC844oSUimddDDAip7EqZSFldH5d9BMYI88
	E45KFE4RRs6+Q13edz9tAyQ+96B9Qmx96qEUuO+i2Qtb428OM/agITJgedTuiBS5L7+xGP7XOtJ
	fT0IaAcc53ftGTM/SOXKYMmgLiHvXAGEV4E1P/mdw5ADqWK5wTQFoTQKf3bN4tqrQnzz4HE/rtC
	nEYdUlAdmopQ==
X-Received: by 2002:a05:600c:6b69:b0:493:e583:7053 with SMTP id 5b1f17b1804b1-4954a41431cmr113435805e9.35.1784562076586;
        Mon, 20 Jul 2026 08:41:16 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:41:16 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:40:40 +0200
Subject: [PATCH v2 08/15] drm/imx: remove dependency on DRM simple helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-drm_simple_encoder_init-v2-8-5020b630668a@gmail.com>
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

