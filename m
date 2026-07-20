Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEE742DA4C
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562061; cv=none; b=KRWYbeo/X4p5N49KScus1Yb5l6U+w09iSDtImB4tL+yY+FsbIHLPSCGCBLa7mpDsPDArHUvQZO7MM5CcB2WqExZq4v/jT1vkDsK2zPomihFvN9RHsjg/tVnWvRWPPXymkUHRYYb/LJLLYtLrn3qm/uJQF6dlfvPaKQ8Fzw04DzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562061; c=relaxed/simple;
	bh=X02XAkJ/qvwOROXqM6gNmWkrEK5vY8c0WEEa1+0hPmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wtjny/4stYcT7YtyXI6W2MRKZZRyNRfhUM3NKhGJgLpHd7nTDeC3vYAblc5QxsGhuu7bpAi29fOdMeLqHYU4eUVfOdVgugCwHzghfIb85rBD6ij/z1XiStxmSdRn/COCxZ/r7UQNwGwFg8rxAYNlXUOPwfGdMGAG7pELBu8wSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZstAtL0; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZstAtL0"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f7444576cso991289f8f.0
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784562057; x=1785166857; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O7zJzFQDZ2ba/zKljTx71fkG4BHmnEG0mOPFGgp16IY=;
        b=SZstAtL0/nDkqNrMR2gYn1STZLTyrkJDSvQ+X+6XOxBUO7HwFi0vA6yIelsr5rpbGy
         aWF7TFVWt69Qv6xFhx+QnWKQk3IV/XLb6FmESMUvN2XuqIFR+JWyDRMQl6n1pmOT/VyR
         V2g5//hbg1dvI0mlaAOhSp80lH3l0J5sQwAdA7hfcbuG97D/5+rWiqtjlduKHg+T3qz6
         rpAyAY8NkkjIb9vTk47BjtVLdsRuTqo9tBWEj/Nj+UkJTO6/2B7EC8B2Ly/TXXZwLJSM
         nnkKGNQdwDfDF0cQEgYkTQWTC0sbrAiudBFgF1ozKMEhw2vycuoxkq7v7MI64rohy+v6
         6gyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562057; x=1785166857;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O7zJzFQDZ2ba/zKljTx71fkG4BHmnEG0mOPFGgp16IY=;
        b=ZrdQB9smBy2a/keclcLYLos1mAvA1+qYGeWQ1Aa5RxxqOj0NeFyylRYsWEcu/Ml4Ho
         joQH3HtYfT0sjwbZAjqWqj7m2xmaLJZY9EQLLdl6B5EKKqlPQL/PlW05g53nGujVKC5s
         pB/Yh3mW2bjmypRlsyr0s7s56zS3eUJe3TgX9QrZG799WtyJ02GP6DkFDS6Af9qowl5X
         W6pBEHmgd0MM58wVKPFKUcl8QQCe002goTXzSawWsZZeuc/GCQNuHvH3UkX/xVWbpF1u
         zj7/5rUmkVZNGQTODPb3XNGUzHySEZAjf7fDR7ieZubb8bOvTq/NtWkrHO/CTAITQIre
         g88g==
X-Forwarded-Encrypted: i=1; AHgh+RoxNS/cU50HXyfQbM052xqHhe4qiBYTmQ64QqHs3vXVkVqjf5KcGg+Lm/OU21sdzgtaexJuibp9a7dH4Uj6TQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YygddMzPup0NfXxbt7qpETOYKZR8VdR2G4f6F8wTtZleJMlRcX1
	iz/VwHio8l+8r1SNA8n6oj24yHLFX6+DqKApjEZWNoBLuLz3HkvWyXLF
X-Gm-Gg: AR+sD10iiGjmXlxx6Cze79jiL7r+9jeZz7Nvu7He/vJXIAYnzuGWEqWr7UAogY8Sq/b
	1dXxBgJtc6UTvvkYgYLcRQuKsLtuv/kZyddmeqG5YEwwioNIOLoWEqk8uSt212iCSNfAQLXsQFw
	ieCu/Q//OO+wtUH++PWUT6DQ0Xn5NxDvxfpXAtLBFMQt/EK1uoTcgeBmez0rS8YTHQDzhS8dAjc
	JW4FYBScy9LdN/kv0Qg0EqeoJ/XDypWBUwyabw1c2znOT9z4dGIocN4X1q0mm1cAw8qgRL+5wPH
	78/QTTAh3SYnVavdgXI0Gk5cJzAgOkwm64jGVZBodSmapJ/W2OHrLwe56iEpfY4xzNG6HcX9Dt0
	XICnSrq6I22U3CA4N3S82ZvbS3ULRMcn/PTSbAQn7ayLJkkROhrYrVItc5A2vN7TCv2Mz993BkQ
	LEdncIAAhXlQ==
X-Received: by 2002:a5d:6f02:0:b0:47f:7154:ab20 with SMTP id ffacd0b85a97d-47f7154ae17mr8536055f8f.37.1784562057410;
        Mon, 20 Jul 2026 08:40:57 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:40:56 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:40:35 +0200
Subject: [PATCH v2 03/15] drm/tegra: remove dependency on DRM simple
 helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-drm_simple_encoder_init-v2-3-5020b630668a@gmail.com>
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
Also check the return value from drm_encoder_init() to avoid silent
failures.

Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
---
 drivers/gpu/drm/tegra/dsi.c | 16 +++++++++++++---
 drivers/gpu/drm/tegra/rgb.c | 15 +++++++++++++--
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index e7fdd8c7ac12..3f818c195e9a 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -20,11 +20,11 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_debugfs.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_file.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "dc.h"
 #include "drm.h"
@@ -1055,6 +1055,10 @@ tegra_dsi_encoder_atomic_check(struct drm_encoder *encoder,
 	return err;
 }
 
+static const struct drm_encoder_funcs tegra_dsi_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs tegra_dsi_encoder_helper_funcs = {
 	.disable = tegra_dsi_encoder_disable,
 	.enable = tegra_dsi_encoder_enable,
@@ -1078,8 +1082,14 @@ static int tegra_dsi_init(struct host1x_client *client)
 					 &tegra_dsi_connector_helper_funcs);
 		dsi->output.connector.dpms = DRM_MODE_DPMS_OFF;
 
-		drm_simple_encoder_init(drm, &dsi->output.encoder,
-					DRM_MODE_ENCODER_DSI);
+		err = drm_encoder_init(drm, &dsi->output.encoder,
+				       &tegra_dsi_encoder_funcs,
+				       DRM_MODE_ENCODER_DSI, NULL);
+		if (err) {
+			drm_err(drm, "failed to initialize encoder: %d\n", err);
+			return err;
+		}
+
 		drm_encoder_helper_add(&dsi->output.encoder,
 				       &tegra_dsi_encoder_helper_funcs);
 
diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
index e67fbb2362e6..bc1c93c7554c 100644
--- a/drivers/gpu/drm/tegra/rgb.c
+++ b/drivers/gpu/drm/tegra/rgb.c
@@ -9,7 +9,8 @@
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge_connector.h>
-#include <drm/drm_simple_kms_helper.h>
+#include <drm/drm_encoder.h>
+#include <drm/drm_print.h>
 
 #include "drm.h"
 #include "dc.h"
@@ -194,6 +195,10 @@ tegra_rgb_encoder_atomic_check(struct drm_encoder *encoder,
 	return err;
 }
 
+static const struct drm_encoder_funcs tegra_rgb_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static const struct drm_encoder_helper_funcs tegra_rgb_encoder_helper_funcs = {
 	.disable = tegra_rgb_encoder_disable,
 	.enable = tegra_rgb_encoder_enable,
@@ -305,7 +310,13 @@ int tegra_dc_rgb_init(struct drm_device *drm, struct tegra_dc *dc)
 	if (!dc->rgb)
 		return -ENODEV;
 
-	drm_simple_encoder_init(drm, &output->encoder, DRM_MODE_ENCODER_LVDS);
+	err = drm_encoder_init(drm, &output->encoder, &tegra_rgb_encoder_funcs,
+			       DRM_MODE_ENCODER_LVDS, NULL);
+	if (err) {
+		drm_err(drm, "failed to initialize encoder: %d\n", err);
+		return err;
+	}
+
 	drm_encoder_helper_add(&output->encoder,
 			       &tegra_rgb_encoder_helper_funcs);
 

-- 
2.54.0

