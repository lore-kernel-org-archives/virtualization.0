Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5507433BC3
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562079; cv=none; b=VRkTTDVGOHtwIqYfSFIlc0vXF/mhCseyi1/uzCX/VMWdt9h7GCXYbcjLND+vlk7HE22hOhu3AJZ69nJre01G8rPlbHVRaNOuq5uGZet6K+MnA7hc7uca6ZodhbI7cTWYuEsQDjQokoVhCAyClWYQvlIJ7d/sU7AOZigdICaXEEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562079; c=relaxed/simple;
	bh=HdxpWSHVTZnagqWd9UGqEZtDSs8wJ971uoSLZwkj04A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ScmktSjpGbGgKHpKN59VLMJajrZDdoKZCNHw+wdIa1LHHW415rn0vDhjyvzcCsMm7YB4Me2mTBk7eeYUF0Qkok+RPru9keq48hzmAah96dq+JgGjPIQn/hK2nAWl+/nF3bn53GVLqv3Id9gi1Bz6PyLKTKoWYT3Dygww8FKHx0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G11FEt6u; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G11FEt6u"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so9022946f8f.1
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784562073; x=1785166873; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ATiv+bDbiK4r8/Ev/Mp3rnzRTm75IqK6z6i5srau5Es=;
        b=G11FEt6urO8tv7QY3iHuVKngZaB5myb43KQC62FsTpSn8Zwettm1rT3KA+T34lPtUQ
         bll7Nizakt883U1ZUTzmo/4j8/XrRLvKcCu3aZpuY+CmDQLOg8Yg8njpQiJeLYwQ4OJs
         o7BK+kZcP5r2RLSUcsJlORsub+pnyNuQT5jzMy4/Obv2YXua3KYoqeUEZ55L4+UqTRFt
         4DjW8lTlTWFlNiWmdpPnHLOu2onv8u/uNYrls5vhGKwWaX/UUVfHBokR1yCiIDEY58AN
         iFoopVmCDDcgqaFbHN46HZtTnBIEbqvLYQNVMVeJodpLllH9gzSuyvCQ1knaSQyxamfT
         aJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562073; x=1785166873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ATiv+bDbiK4r8/Ev/Mp3rnzRTm75IqK6z6i5srau5Es=;
        b=FiWPQ/4mKIa7VJUNW2NpWNO9Gw6MOryczlTdiW0SqerwZzXH+oEsmspJiLBVCvkvmd
         t6uOZHT5twavZktfiGU9II6tqOydpHmpUerYN8jTo+MffP2bby2xiauKLbLZEUqdUfQh
         tg3IUjD9uNLPij+B+epcDzNzlb1q2VDtvbrjNphr9TAMAnsAg+4qY42FQPpol7kYFv+4
         yjFpyyxSJZPvNyAmlhosfe+DSOKIdZBVO8AGn+mH+Pt8ZdyQ13eoGxdUkmn38NV3ow4F
         f8LD0dCOsMupaC639DLqtPQTrqi0CZtAzXkpyl+RqlNUK80aoMW+DygGLrySuGfSbuIW
         e7wg==
X-Forwarded-Encrypted: i=1; AHgh+RpvOm87OoxybRvtKNZkEWqUTNQIcTCNo+MyQxfFQ9p0ibgrrFt+GmmP2iqdn7YVi7l6MWYkm/4e+qLRw9S5cQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyw5ef6aBNnw5y188wH8Jkz5UgNPINuAIgJnmZUBiUVYwbcb6p5
	CbXoS2Or0otODfZCZbZMp7tZaSBri/ypVcdTQTRtz2hRE7w5TBdnrrg4
X-Gm-Gg: AR+sD118N+lw1YG3lKus0/RxU/Hsxic/sft/rHTYnL2vXDHKr+ZaJ5Ei1utoO6hWXL7
	rYQ2yV/3NiZS3iuEJViieW6SGHYpBNtOOuLkypIAlTFzBx3eoJsY8yQlFUmTkoKgP5CZtAXMq0O
	u9o+rOjHDYObUSdWhDrd08E10PY6qukQqJKy+n4rKY61f1NSOYNrFGoh9nCc1z5uhR/ks8Zej1D
	fEmXkr1M0dat9Yl1i0ORv6fA4fm+xUak1spzBDGP2NpoXkFKt+qu99gXRb4fOZn6hAwnvkZxeau
	uDxN11wdBpoFuYVdoHqHHnJWIYFwR4vnrGWDjz1ZhJ4wTY1M/UuFrl17biyQ1jedsI7haLsY9x1
	CkycCESYrqEDBlToPxUVKx4Er/boJvWnFooFFocSRLiB4iazcVsOhknw9MlDDDpgTd16ltb3YUu
	cFpalc4IfjOg==
X-Received: by 2002:a5d:5d0e:0:b0:47d:eedb:ee62 with SMTP id ffacd0b85a97d-47f6230389fmr18153184f8f.14.1784562072745;
        Mon, 20 Jul 2026 08:41:12 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:e9c1:2f80:10a9:c708])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f67466e09sm32667936f8f.21.2026.07.20.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:41:12 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:40:39 +0200
Subject: [PATCH v2 07/15] drm/tidss: remove dependency on DRM simple
 helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-drm_simple_encoder_init-v2-7-5020b630668a@gmail.com>
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
 drivers/gpu/drm/tidss/tidss_encoder.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_encoder.c b/drivers/gpu/drm/tidss/tidss_encoder.c
index 698f8d964ca0..10dbcc6cdf6a 100644
--- a/drivers/gpu/drm/tidss/tidss_encoder.c
+++ b/drivers/gpu/drm/tidss/tidss_encoder.c
@@ -9,11 +9,11 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_of.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "tidss_crtc.h"
 #include "tidss_drv.h"
@@ -81,6 +81,10 @@ static const struct drm_bridge_funcs tidss_bridge_funcs = {
 	.atomic_destroy_state		= drm_atomic_helper_bridge_destroy_state,
 };
 
+static const struct drm_encoder_funcs tidss_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 int tidss_encoder_create(struct tidss_device *tidss,
 			 struct drm_bridge *next_bridge,
 			 u32 encoder_type, u32 possible_crtcs)
@@ -95,8 +99,8 @@ int tidss_encoder_create(struct tidss_device *tidss,
 	if (IS_ERR(t_enc))
 		return PTR_ERR(t_enc);
 
-	ret = drm_simple_encoder_init(&tidss->ddev, &t_enc->encoder,
-				      encoder_type);
+	ret = drm_encoder_init(&tidss->ddev, &t_enc->encoder,
+			       &tidss_encoder_funcs, encoder_type, NULL);
 	if (ret)
 		return ret;
 

-- 
2.54.0

