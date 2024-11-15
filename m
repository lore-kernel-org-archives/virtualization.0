Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D661E630C
	for <virtualization@lists.linux.dev>; Fri, 15 Nov 2024 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704987; cv=none; b=Xl68aZCS0PJdVaBrLZOEOPexQBWHpNMS0N3VKgHoCj/yjDQzgzXR8rmgIXCR43u09HoUFXbKzTWK2DI1Apo70ipFbedCsDEo1ptOvh1Hjx6IlwYMGJixjvjoltqiF+kNU1GKVH0iKe6WxSLaef7D9ofxNezzeLVKfDMAo67GqL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704987; c=relaxed/simple;
	bh=7MG/OwsNfTmDVn/mH57oaixvVZgNtOEeYuE42na1NvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pFV3NaPrcxoaMCddpwHIVkqP7IdTzZQ18ewkfCn8IaQnQgG2QJhveba0nEITqQ/fuCNtpAOwLt0DotNC05Li7PZ3l0/2tx+T9RKlQJG2ANY5gzS7pzkF8buf2ycBK2P/fDt2m+Uk4TAber8UMBncnu5H9GQDMBxSBAh2eZuzRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=loM0moXc; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="loM0moXc"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so383441866b.0
        for <virtualization@lists.linux.dev>; Fri, 15 Nov 2024 13:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731704983; x=1732309783; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FriEhyugYOxuqzJsZUFAkaGrF7e8rD4Q/ahhoiQ1cKE=;
        b=loM0moXcIfKkjtENY7w06v/fWY2g1ht2wWjBtoS0h+1sv13HGhuN3JF85zVnYcmG+2
         p0Lc85q6B25ctc/LWvGeNypP3sMHDfY0USdLsf5aqWPyTU/AB92ev6v+v7G9//GpgSGa
         zmzbuN0nRWgSI8qDGmuICi/9awZYr0HSrPftllduEm/GINcsOAhAwN+1T6m6CPEzHh5p
         3Qa6EroFph/q4jq/7b9IW+AyDUw4knh3DtzxxWVWzKnpypGn5jrd83vZG/y/+A0pAaFn
         8tMZzUl74Ibyx8mZLYj8dHixZHG6ZY6fuImsQEghkCB+ALeerEMpwIQr50K2rWFbj+su
         C7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731704983; x=1732309783;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FriEhyugYOxuqzJsZUFAkaGrF7e8rD4Q/ahhoiQ1cKE=;
        b=wQsaMXXoPRBE++F1hhGv8zKDyXwvfLnNU1kG5ZD97pxfTJe9LRnM5vu/S8CXQJEv6G
         S5RtHlEfjZXvAzDLhSdMNr9466H0y7R87f0+jOvbQDtmL3UKN1kTGFs3ePtYe8ZdDsCe
         1PjAz9AV+LTar7MnaUQ8hTcOecOD1LHP4Cx3Uug+ylonUJwQl/OaFgmvjnCWi4MLfhPL
         K4XNwFQatm3vHcWtswtGBMWsoxwu/r0hnkBa+hSa08JixYQ4g1omKKDa2FaBJuJFZiQD
         G8Vz+LD1WoZuSXS86w/WZWagztdtmk63sZN+AhgC/6eW3WwWnJ/fNrapgb1nDlc9bBJg
         6cnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhAYEFpyYT1CiSy/rLNLGbDP8LifEZXE+jJGe9BKxQ7CXdsVR8ZhQ6eZq1gF4lYAK+1ujSt8ldrFhq4dlRtg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBNIpfcBGVsLHUPx12SlB/l0ZU34nTne8b7BL5hP08zir9phb9
	vc0JyW05Mn96Lc64kZwFsbPIUvIUnE/y0sz1ebg52h3lJLjYd8D3SToJOK9vP/M=
X-Google-Smtp-Source: AGHT+IGKIQ3xiZstYvdstCjBR8aVG15Cn1mMCwtoW2X8A1GwZn6dftD3n4aChlS1ng3pveIgM00eUw==
X-Received: by 2002:a17:907:1c29:b0:a9e:df65:3a81 with SMTP id a640c23a62f3a-aa483554f81mr289025866b.59.1731704983120;
        Fri, 15 Nov 2024 13:09:43 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df51648sm219626366b.62.2024.11.15.13.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 13:09:42 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 15 Nov 2024 23:09:28 +0200
Subject: [PATCH 3/5] drm/sti: hda: pass const struct drm_display_mode* to
 hda_get_mode_idx()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-drm-connector-mode-valid-const-v1-3-b1b523156f71@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2152;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7MG/OwsNfTmDVn/mH57oaixvVZgNtOEeYuE42na1NvM=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ7r5jg5+cbXA1P3G+YHK+zSPn1YT5s95n2QvGvrowOXVb
 9iWBV7uZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEPKez/1PR33Ng1s+rcm9z
 bL6yZ2fqWfuGFpQ4u9z4GVuXumtWcOlGnSMB2qnnxJ4eF9XP/DLX5dEcPpvbW02qHPJYP081f1S
 R0eTwZ9vjD9tVdf4UhJ7l6Cvf6C+ga+Cju8q9ePq21HD1AwL+wQsaVH81cp99b2P6mWum9Kfbaa
 rNLEVT5yw5VD2l0TxiqkzHJI/o35q9/R91hRms7Tr10mJvaIdz/n0c56Ym/2BNh5/uMmkV3zy9m
 c8DtyodM1RMvpkaULjJfcJekUSGSQ3LZiws29kicizgVU7lO5XzB4+4h6u/SIyY4v5ghdNHLoP4
 +aG20Tznxdbs6GmO6jLMj3/wyWJ70bFLMao7uGWcf3ACAA==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Make hda_get_mode_idx() accept const struct drm_display_mode pointer
instead of just raw struct drm_display_mode.  This is a preparation to
converting the mode_valid() callback of drm_connector to accept const
struct drm_display_mode argument.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/sti/sti_hda.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index f18faad974aa2eda58c1e49537f8337db119d4b7..829dc4b034e8a79a908bda60485c2b94ef96890c 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -280,12 +280,12 @@ static void hda_write(struct sti_hda *hda, u32 val, int offset)
  *
  * Return true if mode is found
  */
-static bool hda_get_mode_idx(struct drm_display_mode mode, int *idx)
+static bool hda_get_mode_idx(const struct drm_display_mode *mode, int *idx)
 {
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(hda_supported_modes); i++)
-		if (drm_mode_equal(&hda_supported_modes[i].mode, &mode)) {
+		if (drm_mode_equal(&hda_supported_modes[i].mode, mode)) {
 			*idx = i;
 			return true;
 		}
@@ -443,7 +443,7 @@ static void sti_hda_pre_enable(struct drm_bridge *bridge)
 	if (clk_prepare_enable(hda->clk_hddac))
 		DRM_ERROR("Failed to prepare/enable hda_hddac clk\n");
 
-	if (!hda_get_mode_idx(hda->mode, &mode_idx)) {
+	if (!hda_get_mode_idx(&hda->mode, &mode_idx)) {
 		DRM_ERROR("Undefined mode\n");
 		return;
 	}
@@ -526,7 +526,7 @@ static void sti_hda_set_mode(struct drm_bridge *bridge,
 
 	drm_mode_copy(&hda->mode, mode);
 
-	if (!hda_get_mode_idx(hda->mode, &mode_idx)) {
+	if (!hda_get_mode_idx(&hda->mode, &mode_idx)) {
 		DRM_ERROR("Undefined mode\n");
 		return;
 	}
@@ -614,7 +614,7 @@ sti_hda_connector_mode_valid(struct drm_connector *connector,
 		= to_sti_hda_connector(connector);
 	struct sti_hda *hda = hda_connector->hda;
 
-	if (!hda_get_mode_idx(*mode, &idx)) {
+	if (!hda_get_mode_idx(mode, &idx)) {
 		return MODE_BAD;
 	} else {
 		result = clk_round_rate(hda->clk_pix, target);

-- 
2.39.5

