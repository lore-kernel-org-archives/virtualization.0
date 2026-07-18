Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F523793BF
	for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784417779; cv=none; b=ggduAVrknNW1UQi7J7+Xo6gXKBJZLSMtcP4DZa+CEMLFSTzAAGZsVJ1fwT/ZRwdG/EACt0BhheqfC5iA4zSS9++hxC3xkModOKib+ie89vZXQLAGA0xrioGt6qoyj8tVTtITaRNJqWiDTDJlTwoTzp56WJvACnsLA/7To33zrpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784417779; c=relaxed/simple;
	bh=FzaaA8oyQ+zKZNM1VMh3E01ofgfkWOkBgZAPrI0ucuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cLfEa/7D2gYfyhOqKgGaxQQyqQg5tQneAmCFuM/7JV4ThhcbNQSJ1rjF2Risy6t2Gu55fCmK1nIjRb2t5Dp2gVA8s2xv56iLt5oTfABznVj9MrA92sZNnQre0P2Z+xHjPJ1Ut9+2jSaw+s5kAbX8HSTA+XBDRHoEz7m9a2F8roU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4qKZ0T3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4qKZ0T3"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493b966dd74so36649235e9.3
        for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784417776; x=1785022576; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vjd+2BbZ6IkIhW8JUSKZxdlN+XT2WH08r3urmJQpGFU=;
        b=h4qKZ0T3Td7+4wzxElLJNZVZEvWh3U32SVRbc/A8Fo2bUi/FsrBeoYUSRDaNdt3gEt
         RxrWQuiEF2Z/h0ylY+pZDacG5wUpeA6SNRF2i8WWkwEu9ljq+1WMdGE3GSBlbixMq5Sh
         FsWY4DhAFFcpDE+s0gjGP1TmAfFjYweO9VzJ0H8BqAVMo8sdKIKjlaX5ZV6cYcmSqX/R
         LSB5aVVLmjcKdl1wejDYLOE9L0YFqqa4xQDj7a6q7y2HRYJgbqZEWZj+mIL6NHW2qMXT
         NkEORj02TH+C0EQd06KS1ATG9CEduTG2zTMvYVOSkbeMgefPrDyUT2mc6lp4IMBkNL2D
         uq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784417776; x=1785022576;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vjd+2BbZ6IkIhW8JUSKZxdlN+XT2WH08r3urmJQpGFU=;
        b=iU9A9bmxLGsbi17tsOR5nY1Yk/yCJs6viLemIeouZsoPAOQt4Ge0smXoqgHXggTqJ2
         ycIgsZB/ZrNpiGuh/xwgRG9DI7RR10/wviiFewkFT76Q1XCneFj71NzqmBk8DY52c2lx
         KSDNkjUzLQ0q5CYg4Ff/5Mo++UAcJlp7PEP9/uN/RZtLyt13y11Xx26jU3PoRg9OQ4Gx
         IFOjW67k41L3xSkdJp1u21y5d8XON/8NqO7AScVc/BtpTnFHtZW47qwX/7A05eIPeR50
         gp0HToTy50nP34ye8w+gGd4Yt7U4EnGmD/VZqkkaON5q7N7JIYWxc+OunmjNcEVLSF1d
         sWnA==
X-Forwarded-Encrypted: i=1; AHgh+RrV5ORPQ9BrBdWwZ0q1+4hO7B9yt9s3cRCKszJb+nn2wYA0JsD9+knfauRgMOUFtnx5M4RT5Zz2DKyjv3ZdVw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yza2cR6+8sm5drsu8WmeMt4ELEmExwbEBFVBFQpBtwty1+iDgjC
	K1+0wB8rJHliJCrZVLUPewHeiwCTMy/sMzR9ic8KPSDRnCl+sWOlEqWw
X-Gm-Gg: AfdE7cmMAUv7r4Wj/FDWRcuY+CF/vUyeMfJbp8pnfMCYNdqlWtvhiPd8i+7JEnu64Dr
	9cy8xQ6nC9b3FHrmNuEaoNStkdv7W4MvdTupb3RnrVxGLJPJdjtwtn1sssSR+Cvc6iEC7M2OJ5q
	LV7hComESBlKCZhaTKdM+gKcoMA2zmVymRN7Fr/gu1IkPgFtPLO2eDtvkI3YuH63/gwLUJv94Oj
	aYjOBmO7mOdDYFvRXPFAPhsqqE/HfIjgwjl/fm2P8tbT8hsAAiHqqv3KBJd3E8MwhX/KsI25WIo
	+Y4Mk1cyFdkw7OCbadoyLLeQTENjhLuDzm9KO9UZz+f19caQFIEHQb4eOBnen/KDm80Ex3OKtjJ
	8XYC8lVr3EqPHEjCv8sHxjJ+OgEibmduzUnAaHYv7tiQT/PKHsdbcJ3504SwX16wA5qGR9PFe/K
	CrFvV3HM14rQ==
X-Received: by 2002:a05:600c:4585:b0:495:3eb2:b763 with SMTP id 5b1f17b1804b1-4954a50c51bmr85840985e9.21.1784417775709;
        Sat, 18 Jul 2026 16:36:15 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:645b:9e5c:7fe3:c09f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm160964675e9.3.2026.07.18.16.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:36:15 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sun, 19 Jul 2026 01:35:36 +0200
Subject: [PATCH 05/15] drm/kmb: remove dependency on DRM simple helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-drm_simple_encoder_init-v1-5-a78c509e3062@gmail.com>
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
 drivers/gpu/drm/kmb/kmb_dsi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/kmb/kmb_dsi.c b/drivers/gpu/drm/kmb/kmb_dsi.c
index 59d0e856392f..13adba96bc78 100644
--- a/drivers/gpu/drm/kmb/kmb_dsi.c
+++ b/drivers/gpu/drm/kmb/kmb_dsi.c
@@ -14,8 +14,8 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_mipi_dsi.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -1427,6 +1427,10 @@ struct kmb_dsi *kmb_dsi_init(struct platform_device *pdev)
 	return kmb_dsi;
 }
 
+static const struct drm_encoder_funcs kmb_dsi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 int kmb_dsi_encoder_init(struct drm_device *dev, struct kmb_dsi *kmb_dsi)
 {
 	struct drm_encoder *encoder;
@@ -1437,7 +1441,8 @@ int kmb_dsi_encoder_init(struct drm_device *dev, struct kmb_dsi *kmb_dsi)
 	encoder->possible_crtcs = 1;
 	encoder->possible_clones = 0;
 
-	ret = drm_simple_encoder_init(dev, encoder, DRM_MODE_ENCODER_DSI);
+	ret = drm_encoder_init(dev, encoder, &kmb_dsi_encoder_funcs,
+			       DRM_MODE_ENCODER_DSI, NULL);
 	if (ret) {
 		dev_err(kmb_dsi->dev, "Failed to init encoder %d\n", ret);
 		return ret;

-- 
2.54.0

