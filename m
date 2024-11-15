Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46D1E32B5
	for <virtualization@lists.linux.dev>; Fri, 15 Nov 2024 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704980; cv=none; b=HwdPMZnhRSI56n7O3MmwPMIudYO4VAnS0fElAApdieW0CB/eSkfU7YZru9rM68DlrGeWFcNkZbv5MKT0VXYxtdMt6oEYLOccQB+jgOxYlaxtIpwsdXnvopJH+DoR30EeTvOLxJa+b5MoJqfvm1AeUonUEkNWYitRcrgaCkf+dYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704980; c=relaxed/simple;
	bh=p73O++3wotedHVxEc/OS0iEeK5HjHEeyRJw8kmUrclY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8dwrlN3+BQ8MVSfQHNIq6yIp+AfkVDh6yhyXiZYbwjE1aVprMJlMw272iXtEpqAhoiDojME+q/28sWhmxadTvUaqqKBR2oZ122PpqSDvnPKaADfUVG0ia7uWNFXIklV4rXDA7EZNQMI8yP/4vqjn6zCwrojsFpvhXH5IyKIDMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WeLOmGgQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WeLOmGgQ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1ecbso3108476a12.0
        for <virtualization@lists.linux.dev>; Fri, 15 Nov 2024 13:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731704976; x=1732309776; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MaDJsFjngdpTSC4UtZp0JvItJKL05hX1CQDURe5cIPs=;
        b=WeLOmGgQQcpOQyTUQf0Z9NeOczpsLaekzqzRVS5DpczVY8vtYoBpKy+fN/Grlz0wkt
         RKGHwr8n+FPxG+Mnkst19Wcy+zkCSRv2fIps5JJVzpnW2tTOGsSZvgX4RDL88bltWmVm
         KBArdlTc0f6evflwzIX8T65eHCBqlEjRjyRm+ujiO3q7dQXsDciWEyosW3U71lBfCY70
         QwS3dsAws+mAdpSIoPLjRXIqU+omoKy3ls7iYfQcfhgFme2/0P3LFyVYkhF6XzzOPyCN
         TuHMaFz9qhKYEbbpwLhfo2hFl+ZCMSpS3rqLMKws0xZFFiQO2gcWRlCv+H3mJvqkHIda
         Vp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731704976; x=1732309776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaDJsFjngdpTSC4UtZp0JvItJKL05hX1CQDURe5cIPs=;
        b=E9Pgu9JOhlx6MmFnJLzoWN6FB4foP476lqVfaeNfOqazLtHTLHr2qAwecXXTG8X0Cp
         mhXaDwpNBSI5FvsaBiXeEtNedkfuSRuomJ+/fu3AJp5MhydS1XKhf43nQSy/XBy422GI
         NHP/MNRntwL6vlNZI0NIu+mCcTw9TtsKRxTnY3RDyoGUWP0lYON4yXt26frrvqLaxxTR
         Td/HO8zV7N59x3fPNf7qHYMoG0QHvPwD1cDEhFZLLiiXLZRtN5kTLRVy1hRWhuml+b3L
         cPyMIwEGJEuwVT/s2upx5mEHO2GOuaA9LEYZkM9tuvp1vCVUZBwF342F1lOgkOl9auVg
         QDBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+eGTevDYA0GJ1gshR+fEO301NkGSDK46FA/LDPuz24+HNJRtfW7uU+wSTjCY0VKSh1yFPBOM6JS0G3s9AwA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzAcP58NF+IQ2oy0eAJBWnxRf7F5FlYXg/nX8wsxusp29bbnFAU
	S4BhkRmcZEOY1JgrZk8+TJpDyZhU2hXi1Vdnaz43Q7+6t9lFemexW/hJj2XJ6vY=
X-Google-Smtp-Source: AGHT+IFPY3knSoOjFOSw+FKqV/bCUh7TKMDj4KEvXFLpvr+Y8ELhi4rkKluEpzqZePJKQVtb4lya7g==
X-Received: by 2002:a17:907:2d91:b0:a99:43e5:ac37 with SMTP id a640c23a62f3a-aa483426214mr277344666b.15.1731704976085;
        Fri, 15 Nov 2024 13:09:36 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df51648sm219626366b.62.2024.11.15.13.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 13:09:35 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 15 Nov 2024 23:09:26 +0200
Subject: [PATCH 1/5] drm/encoder_slave: make mode_valid accept const struct
 drm_display_mode
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-drm-connector-mode-valid-const-v1-1-b1b523156f71@linaro.org>
References: <20241115-drm-connector-mode-valid-const-v1-0-b1b523156f71@linaro.org>
In-Reply-To: <20241115-drm-connector-mode-valid-const-v1-0-b1b523156f71@linaro.org>
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>, 
 Danilo Krummrich <dakr@redhat.com>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Peter Senna Tschudin <peter.senna@gmail.com>, Ian Ray <ian.ray@ge.com>, 
 Martyn Welch <martyn.welch@collabora.co.uk>, 
 Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Stefan Agner <stefan@agner.ch>, 
 Alison Wang <alison.wang@nxp.com>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Chen-Yu Tsai <wens@csie.org>, 
 Samuel Holland <samuel@sholland.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Gurchetan Singh <gurchetansingh@chromium.org>, 
 Chia-I Wu <olvaffe@gmail.com>, Zack Rusin <zack.rusin@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, virtualization@lists.linux.dev, 
 spice-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2918;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=p73O++3wotedHVxEc/OS0iEeK5HjHEeyRJw8kmUrclY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnN7iHg3HP+UcGCGKYRySmptq7KP9Ng42lKX9lx
 EK9A+ybXVWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZze4hwAKCRCLPIo+Aiko
 1VmgB/9rxQm+iAzl+wi6vwGpdl+HNgPJZFXzu5cOtg8Q8IyEKfG0Mk/5Adwoa3BqRSDtrUZaI3X
 KiEQo8V0xPwWrJFzEmGzfoN72i6nWFebnQbjfIXt70HZPw6Gu7ufcvJsS3Duq/b/Th8/f3taLfo
 LJj+f+TWV1lC+9ObG14v3/4i6FFKkzzncn8HnS22OpAQ2AxdzLXYGSy7+E4Y7P2T1gDNumfgOHE
 juevCTvhN61ldGGOZFeCPby6Jjgp0M25sRRQkSL6SPQwau7HwCMbjckQexv5lAB9H+6+C6D8p9d
 nSe3+Sp7FKCb/pi71OeXv3z1csTh2P2cNnmAWuGLZ/zAdpir
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The mode_valid() callbacks of drm_encoder, drm_crtc and drm_bridge
accept const struct drm_display_mode argument. Change the mode_valid
callback of drm_encoder_slave to also accept const argument.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/i2c/ch7006_drv.c          | 2 +-
 drivers/gpu/drm/i2c/sil164_drv.c          | 2 +-
 drivers/gpu/drm/nouveau/dispnv04/tvnv17.c | 2 +-
 include/drm/drm_encoder_slave.h           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i2c/ch7006_drv.c b/drivers/gpu/drm/i2c/ch7006_drv.c
index 131512a5f3bd996ad1e2eb869ffa09837daba0c7..a57f0a41c1a9e2006142fe0bad2914b0c344c82a 100644
--- a/drivers/gpu/drm/i2c/ch7006_drv.c
+++ b/drivers/gpu/drm/i2c/ch7006_drv.c
@@ -104,7 +104,7 @@ static bool ch7006_encoder_mode_fixup(struct drm_encoder *encoder,
 }
 
 static int ch7006_encoder_mode_valid(struct drm_encoder *encoder,
-				     struct drm_display_mode *mode)
+				     const struct drm_display_mode *mode)
 {
 	if (ch7006_lookup_mode(encoder, mode))
 		return MODE_OK;
diff --git a/drivers/gpu/drm/i2c/sil164_drv.c b/drivers/gpu/drm/i2c/sil164_drv.c
index ff23422727fce290a188e495d343e32bc2c373ec..708e119072fcb50c31b5596b75dc341429b93697 100644
--- a/drivers/gpu/drm/i2c/sil164_drv.c
+++ b/drivers/gpu/drm/i2c/sil164_drv.c
@@ -255,7 +255,7 @@ sil164_encoder_restore(struct drm_encoder *encoder)
 
 static int
 sil164_encoder_mode_valid(struct drm_encoder *encoder,
-			  struct drm_display_mode *mode)
+			  const struct drm_display_mode *mode)
 {
 	struct sil164_priv *priv = to_sil164_priv(encoder);
 
diff --git a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
index 3ecb101d23e949b753b873d24eec01ad6fe7f5d6..35ad4e10d27323c87704a3ff35b7dc26462c82bd 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/tvnv17.c
@@ -308,7 +308,7 @@ static int nv17_tv_get_modes(struct drm_encoder *encoder,
 }
 
 static int nv17_tv_mode_valid(struct drm_encoder *encoder,
-			      struct drm_display_mode *mode)
+			      const struct drm_display_mode *mode)
 {
 	struct nv17_tv_norm_params *tv_norm = get_tv_norm(encoder);
 
diff --git a/include/drm/drm_encoder_slave.h b/include/drm/drm_encoder_slave.h
index 49172166a164474f43e4afb2eeeb3cde8ae7c61a..b526643833dcf78bae29f9fbbe27de3f730b55d8 100644
--- a/include/drm/drm_encoder_slave.h
+++ b/include/drm/drm_encoder_slave.h
@@ -85,7 +85,7 @@ struct drm_encoder_slave_funcs {
 	 * @mode_valid: Analogous to &drm_encoder_helper_funcs @mode_valid.
 	 */
 	int (*mode_valid)(struct drm_encoder *encoder,
-			  struct drm_display_mode *mode);
+			  const struct drm_display_mode *mode);
 	/**
 	 * @mode_set: Analogous to &drm_encoder_helper_funcs @mode_set
 	 * callback. Wrapped by drm_i2c_encoder_mode_set().

-- 
2.39.5

