Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F99640D580
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562057; cv=none; b=rtQaRJJqHRPVAVplkrM+L89AwiVRth2EvtZI9+imXiBPOXjzj87H0U1JTZgT75kbMzyK+vBjpM5NDUrChWYLK0qfK+t7ZlFWh1wJP+JXvifZhGsQgfCAvN93RYq56ml9JEfM5+7leUbguDEgl299zuR1rdnBwZZFugj1zdrUP+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562057; c=relaxed/simple;
	bh=nIPzxyC7g+URQtzWP7eUGE6nO5tW3SAcscwh0lKy5F8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mtH/3sL+EydLM/Y3/XYaiMJqcj+2o96H0QCVNZpLz1A0/kFQ//BVDhZEcYJMcl96LS5MNQ/om8wiTaYXC426CaRdBdnQn+GCEgfl3iVBPpcyRdopH3xCQlp+sP0hQkZuXY6K+BdgRi+hZe9XwBT/5L73cNDIlP2BG7Wd0QTXo98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRV9fk8S; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRV9fk8S"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso509208f8f.0
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784562053; x=1785166853; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pvez7dBBgFzTEWul+X0zgtK0IubmPdgVdOv0lVVEMOs=;
        b=hRV9fk8Sx+sAvBNioVgjEzrcep46NQAdNtQfN8YRm57TwzrWnpSfEG+N5iGtwhYCSL
         bzeaBAgz+xbSSmh9PBNgnK4o/iBtDVKWnVOn7ms7NjvYx4gH9jaR9R97zvOJG8gY1TYy
         ZtUHJvQvVZzEtim4GQr1HD6+CsIA1oeP6xgxXZ0KROsvCoh0/r9h/N3XD+/hoOu/Ck8s
         AhikQa4LejTn0JFYrvKmJBygbacfD7WdFBhI6ezqEYCTMMItKZ0PetCBBmGp8SXhub9/
         mHGgM0txpyByZyuc/tmoFPKoz2pPy9NIt/xhTQCTWYaapqGFk5vMd1RCtKf/IwK7e+yf
         4Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562053; x=1785166853;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pvez7dBBgFzTEWul+X0zgtK0IubmPdgVdOv0lVVEMOs=;
        b=XBJmZ1Y/m3dn9DQ/92wtyZ8zRLGpX0m5hdReRY3k3w9Mnkac4T30FBVY39fHLn3fnx
         1d5szWZKgjmr5uE1a5juUJbsPLl+6K8CLJaXhuElMMqLMPcZRDpt1y78TY0rjT3FEJNs
         SX07AusUFG40CdaHEcFC/QPWuoMGD8AnZSmoxfILz41FFgYfhnpuZ1uP8qWlFpFZ/I0G
         bRfA8cDM8AmZSzOVTMGmQ8gaDyPV5IJzozQ6TdFjzNqpTFUxzuXQQujmF9Gwn+kkHtpc
         7UyMoUcRilwgQA143QbTxv8BmjPdNzbWXjAU7yKijpe2OuuiEsg1cIHo7aj/ti6O0ex3
         oWhw==
X-Forwarded-Encrypted: i=1; AHgh+RqjXJJtZrx8rm5OHvXcbhirW+NbYgW26zOaATd310o8bvk4GaXnbd71yzMuasyEt9v+lknNGdUCPhPqZ+UDcQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy8M3TNtI0nnrF1M+PZMPpk85yJ6rjBvKnsTyupcx1UfzUPc9hO
	6pYQ2V6KONh/e7MCj6d/SjPqh6hHPnsY1sYy5pQy9+TBn2MT+vXfekjH
X-Gm-Gg: AR+sD10DaCd5vxhkWdoKgiEm+0VHTH+QI7hW9zlUjZpUq+bVydHzc1QLHh31Hk8gGru
	0Bk0Zgh7AYnT1cPCndBxpTeLZSpry9dcudWG4c3Zk/57UAI6tkC+rV4ZboDb9Rl1bG4dI6IZ93J
	nfccGiVwuQhXFPMVjyUv1XycfBqJVtS460T1H0MuCrd1LWqRXsQVnKdUUazeu/7aoSR3frigvMD
	nIaYDowtGWLIPrz0cfOJTA53cQv3FshZCGLgVUNqSn/S5C+9l3O8RBpTC8BbW6yMv9HctZCsFuR
	i2hkakqYI6eZw4Rz/2PAwYfja1nPLfTchBqaDPOVfVlsPXuT/yKx83ogDoC/1C5g1TN+zDNKPXY
	kuA089HV/Q9iUH5c9MzJuDTJbCPiIWXfTjfWHk4iYwb/vqg1FggfWc3W6WCpvO+3q/Y1UKvmCz0
	LcOE+nnMoVWA==
X-Received: by 2002:adf:f604:0:b0:475:f0f0:9ef6 with SMTP id ffacd0b85a97d-47f6233f338mr13274205f8f.59.1784562053525;
        Mon, 20 Jul 2026 08:40:53 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:40:52 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:40:34 +0200
Subject: [PATCH v2 02/15] drm/xlnx/zynqmp_dpsub: remove dependency on DRM
 simple helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-drm_simple_encoder_init-v2-2-5020b630668a@gmail.com>
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
 drivers/gpu/drm/xlnx/zynqmp_kms.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_kms.c b/drivers/gpu/drm/xlnx/zynqmp_kms.c
index d5f922450565..ac9197e026af 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_kms.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_kms.c
@@ -29,8 +29,8 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_mode_config.h>
 #include <drm/drm_plane.h>
+#include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 
 #include <linux/clk.h>
@@ -417,6 +417,10 @@ static const struct drm_driver zynqmp_dpsub_drm_driver = {
 	.minor				= 0,
 };
 
+static const struct drm_encoder_funcs zynqmp_dpsub_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 static int zynqmp_dpsub_kms_init(struct zynqmp_dpsub *dpsub)
 {
 	struct drm_encoder *encoder = &dpsub->drm->encoder;
@@ -436,7 +440,13 @@ static int zynqmp_dpsub_kms_init(struct zynqmp_dpsub *dpsub)
 
 	/* Create the encoder and attach the bridge. */
 	encoder->possible_crtcs |= drm_crtc_mask(&dpsub->drm->crtc);
-	drm_simple_encoder_init(&dpsub->drm->dev, encoder, DRM_MODE_ENCODER_NONE);
+	ret = drm_encoder_init(&dpsub->drm->dev, encoder,
+			       &zynqmp_dpsub_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
+	if (ret) {
+		drm_err(&dpsub->drm->dev, "failed to initialize encoder\n");
+		return ret;
+	}
 
 	ret = drm_bridge_attach(encoder, dpsub->bridge, NULL,
 				DRM_BRIDGE_ATTACH_NO_CONNECTOR);

-- 
2.54.0

