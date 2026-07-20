Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50871434E38
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562084; cv=none; b=Us1SmDTFFT5DYzqwgs5IfmTCw5M22wWAZ5+nkcUSl94cWA7FVXsq/1UW2DF9371AqBzL2haZFDpe7ZLhEhkS1aIVZeoJVoHUInXEZUBnBUlZyceCxco3BdlDiZAOo2aev1/yJH5SQ7i4cclHcmk1RgjNch3xMsPeO1OoEWJ8x2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562084; c=relaxed/simple;
	bh=xtpstExKIgCbeQEE7Wf+l6VvB9HewQ24E1EuTt+0AL4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fEnBLnBDVjRWJdaDWHNQuEXx8TI+BarA2jP5xf3WZ7mZGowYhX/bLW6bU4MqviFn3vrDEWZNJ67XTG7EyTLvusIOzHRe9gz/Pe3EilCjZ/i0yetIy5ap2aBRI0o7ihGR91noUF5tRd3aIcI+wuUjAxte++y0Q8wqbVEYxMuCqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzYdJ1BU; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzYdJ1BU"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso13195835e9.3
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784562080; x=1785166880; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o8dh5aQckfiP03vdZ5nRuu+LA2oP+sZO4zs8QLavR/M=;
        b=bzYdJ1BUUAX2tYFVLmCux1jpf7jPY/VWciMIcSpFGm9Hu9k6AnGzG9zwoDRdsN66KC
         ZP0/VHl6J5onJFrHKXi8yxrciOULHwa6rOFq8LuvtHuGaziVBUWycOi2WzE7U7kBpxGH
         FRA+yLb9JA5WoYSYKqn5vQiqK8X3/g/i8Gwp7aLZl0z0N+rxf8hHr/oRT3xrI+Ke9cna
         0uaDm0BiftNBMR9CqrSiZNAu4RLs7TJklQsZS8KOSFhnjm3ArXL3GgO+iJsjBAxWGBSv
         IskBNyTsR/T/Y+3HRCQ9v93NZAr7jCQYZOladsJq4Hd3jBcg47gIBttYUcXAEk62cjlR
         YLgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562080; x=1785166880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o8dh5aQckfiP03vdZ5nRuu+LA2oP+sZO4zs8QLavR/M=;
        b=nbpl6f0Umb2aIqJ0C1/tITsHt4ie0V7hBH6ikfOkjjoZ09M5ytoh9ra/8v22+c2dbU
         JzSb1CLNv/SER28SsKXfclBVnfV1cTh6yrt/y3i1pQMrnMzh0iTG9qXBVrr+1lZRiVIT
         l9jadR2MDXlnHA8XFrg1iy1Au03xHLrqhsRrhrkUcpP5Xu2OLZ/cBdU8+HMEkoS+8kAC
         RFnz9ozMi8ZqA0l6XTTjIU26QBXZJZfG/d4xegb1AomUXHsj/N85Utpwz8CjMd8sSnr4
         hgdYTzpzv3XN3eBmFyAN5QCFqTFL4yONdBemzsb+UTlnpYPt56bucLe6qIS6cJv0fHvF
         ZJLw==
X-Forwarded-Encrypted: i=1; AHgh+RoQLv2Sx3y6RVNipRZS+lVTThrJBEIty2JWERdpt0M77zYkN6GgAvna/b9daf47enttwjJx+zJu17YAVnCj6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw/qi/hjJCaooB1ZFV3Pel3LOD0SJYKzY/lIK4ss/j40A7JdoTa
	L67KFuL+wL64xFnwILHVOzH9wa8OVyKGBLkod1pQLF+mFck2iH7ou/o7
X-Gm-Gg: AfdE7ckGcnxDTDkd2KAmzxZ/fd4xTOr1HH50CgLq4eZsd1WtiD5heTQrfNj5A0+oX2k
	r7/xn5bblH79yM3xUeQkz1EUV6LXJy57W7t+HgfjcqzuRYbvHdx4rG6NRnOGkRmB2ejhKrmRvRT
	bWpcoaeA+4YaLcvx5c957vRa8aExObq3WAsC2nhjJ3ZRzJI5CAuGpmDL/njL+EBAYaMhCz7eyM3
	MbrURb/3cHF91f0iSbaM+t4X2OFWxvfMFBbbswsA01n0pq1ILPrLWsOUhrEhSxGDZjwq9hLZXJU
	5LBe6nj27kwk19weaP7Y2EEVI9qJa127ucVBrXlVPXeeCGSba1q5MjqJSkDuasggOk6y9A5L0r4
	pAJEi1k834ON121Fvy0Qi1Up0Bcmaukwe7imBeycDgIVN3FhzkKHuqVn4I8Tt/NPX2D/7cApD2l
	Xthd7Mu0kFRw==
X-Received: by 2002:a05:600c:524c:b0:495:4e12:6ae5 with SMTP id 5b1f17b1804b1-4954e126afamr155928515e9.26.1784562080376;
        Mon, 20 Jul 2026 08:41:20 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:41:19 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:40:41 +0200
Subject: [PATCH v2 09/15] drm/mediatek: remove dependency on DRM simple
 helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-drm_simple_encoder_init-v2-9-5020b630668a@gmail.com>
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
 drivers/gpu/drm/mediatek/mtk_dsi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 3f3f56eed3f9..7cd136bd9605 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -21,12 +21,12 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "mtk_ddp_comp.h"
 #include "mtk_disp_drv.h"
@@ -913,12 +913,16 @@ void mtk_dsi_ddp_stop(struct device *dev)
 	mtk_dsi_poweroff(dsi);
 }
 
+static const struct drm_encoder_funcs mtk_dsi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int mtk_dsi_encoder_init(struct drm_device *drm, struct mtk_dsi *dsi)
 {
 	int ret;
 
-	ret = drm_simple_encoder_init(drm, &dsi->encoder,
-				      DRM_MODE_ENCODER_DSI);
+	ret = drm_encoder_init(drm, &dsi->encoder, &mtk_dsi_encoder_funcs,
+			       DRM_MODE_ENCODER_DSI, NULL);
 	if (ret) {
 		drm_err(drm, "Failed to encoder init to drm\n");
 		return ret;

-- 
2.54.0

