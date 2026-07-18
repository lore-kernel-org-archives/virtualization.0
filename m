Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64B137C910
	for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 23:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784417796; cv=none; b=rwK9LE334AUlnF+JXtdyf/cGKrDkCNnvyTdDBEhy7J8PdvjaF6Jarbu9Da2XWnppFFzhWOXvhsUtqHA33xlApQm1wXvyGXXkRKbADqX1LjXeyA3s9kh/EBglW6RWNSgVHbE7g+3oC0eRUV3EeWc7oY4cHY1CG7O+y85FSWjiFbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784417796; c=relaxed/simple;
	bh=l+SJq54PDPW0D7z8ZwWtaXQW066KSgEiZsyj7f7pch8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ozRphVp9w5Xovt+fCR3qBvpj0FbaP4Gst8wDWEsDhevtCfgE5cbJ5Okcg6jVvKO5D0CldLwiDlN+l8zd/0h0dC+c8zZ6SDfUmTEtlgie6o4hOKmdLAl2f7VZi6qs7bsv+vgosStdWzT5Iyj2h02viN/XMdCh1vnGMCdI4UesBDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa1Ne45p; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa1Ne45p"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47c2b362ee2so7853255f8f.1
        for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 16:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784417793; x=1785022593; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=46qE/+7MkuQ3i6sxWImy8gxRhDtZKExvMlDvjet5bv4=;
        b=Oa1Ne45pngsHth0hYJK5YngKO87RRPb2uePYRz+tHLt7U0DPrhjwMfuOHAyInCXyBz
         ramTlQPU+fiBHfXmLQRt9mvSvJip8R/mBmeiZA+Um8ZcImDodlU2vPZluTzyiibDtgkx
         powqPteuGomsbk2Nok/eCU6PehNcELH4lsHAbsHP0/O3D+iM12cZZd6y5Ggy0uoPL69S
         2yoO1ZaZZC9P89FwV+OQyUO+JAgTzpysVkxV6Asxy5ybheMeh9A5597erOaIbHExtScR
         6rhSSzX1q8F9kU/ofnWWVibEI7NvPTBmUOyK3wOEOLewrftNxJ+0MaKaOIIHpSQZUnX4
         5CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784417793; x=1785022593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=46qE/+7MkuQ3i6sxWImy8gxRhDtZKExvMlDvjet5bv4=;
        b=bnx7NdksHQOhNd3hQWTxXJXfl4hBtCuRGix6b9l6+ZWAbu9EoeoyyE+2q7Kvm6l7jc
         mXu3vKX4g3kC8jSBLyz1j1OKg2/D6QvEEje8hoShd1N7miBP+9eSaurQZm8AvHJigjK3
         60lS6W2r7SlJ7pLvNFvhcFjWGVxF0vdAD2RX9TBzg46I0yUOxgS9wVJfa5a/9wqAYCQz
         Hoz9Dx+PN+toNAhPF6CS5CFzuAzq17w5VQwE0NBsGg1oPVHayVP/xzki/+CVO9RONm56
         aIXAL/HAgjzMGPs2j9qIA7zl2FUyvUnoj77FCuABoLfhfHTguMn3g/WjVX0UDcPTZgkl
         wGJg==
X-Forwarded-Encrypted: i=1; AHgh+RpInZ4k1qI0/hzuCdQzX6aeo4bkRq7v6GaWvtlpfr8PaMxISi1//iW1HzM0SbM1ZQ2X2/bcfbKiTRpi368hsA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzVnmWYZi8AXw8iBcUyIRZHtE/X1l2t+eVj3LvoCkeOwrI8C69Z
	lbgO66g+HIoWx96bMdq95uxCecG2AhAh1t1JDJ474oQLeISWWkKqnbmV
X-Gm-Gg: AfdE7cnXAs4hdg0MSY/nrjqVT/D4N1dgAU7ux20Ge8+tcoYqw881GKhbE20LvA9aMHm
	cYmTjW5ywa9O18ZHfz3C2j4Ok8AD/S7QDdv4I9QuTp+ajE6pvyID29/0+im1SzNMxl9j2vWoGAg
	+woQ4B/nARyNhmKHSaTS0ze4OfiLC0FWDfXDxwJXMcxpDLDr3ly+7TnKiEeeJQ2fRHtHDgQbL/k
	HiS9GOPeR/fepBYnZxNyFjl008g6W02wvZa7eN5bmfAEpbsmw52t+VirG36Hu5hbEMZGv5TWyKF
	oyqG9TfBbWNwz3Q7Qe2z3gvGE/vvPlmnEsu60TJ540B/+CIkV/UzJP27q2A4yspEHf3VrNgjElN
	kBR1F6InHbrFhkJmPEtnqM1uSL9QR+QVAM1N7TJir0gUCgd9hq8uzAtBpLQ6AhlUfd0wdH1x05r
	7gahiovOAQng==
X-Received: by 2002:a05:600c:6287:b0:493:e79e:da63 with SMTP id 5b1f17b1804b1-4954a51319dmr90732155e9.34.1784417793083;
        Sat, 18 Jul 2026 16:36:33 -0700 (PDT)
Received: from [127.0.0.2] ([2a01:14:111:ccf0:645b:9e5c:7fe3:c09f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a24b6sm160964675e9.3.2026.07.18.16.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 16:36:32 -0700 (PDT)
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Sun, 19 Jul 2026 01:35:41 +0200
Subject: [PATCH 10/15] drm/renesas/shmobile: remove dependency on DRM
 simple helpers
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-drm_simple_encoder_init-v1-10-a78c509e3062@gmail.com>
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
 drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
index 1a2b9b68af6f..2dc477c7eda6 100644
--- a/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
+++ b/drivers/gpu/drm/renesas/shmobile/shmob_drm_crtc.c
@@ -21,6 +21,7 @@
 #include <drm/drm_bridge_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_fb_dma_helper.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -29,7 +30,6 @@
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 #include <drm/drm_vblank.h>
 
 #include <video/videomode.h>
@@ -436,6 +436,10 @@ static const struct drm_encoder_helper_funcs encoder_helper_funcs = {
 	.mode_fixup = shmob_drm_encoder_mode_fixup,
 };
 
+static const struct drm_encoder_funcs shmob_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 /* -----------------------------------------------------------------------------
  * Encoder
  */
@@ -448,8 +452,8 @@ int shmob_drm_encoder_create(struct shmob_drm_device *sdev)
 
 	encoder->possible_crtcs = 1;
 
-	ret = drm_simple_encoder_init(&sdev->ddev, encoder,
-				      DRM_MODE_ENCODER_DPI);
+	ret = drm_encoder_init(&sdev->ddev, encoder, &shmob_encoder_funcs,
+			       DRM_MODE_ENCODER_DPI, NULL);
 	if (ret < 0)
 		return ret;
 

-- 
2.54.0

