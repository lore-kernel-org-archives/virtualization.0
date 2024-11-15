Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585BF1E3DCE
	for <virtualization@lists.linux.dev>; Fri, 15 Nov 2024 21:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731704984; cv=none; b=QmhcUTzAOn0Tk/dTqA+WgPGH2P2ALxP6mUMDXtkXMmtdI48LPWeWPHRe4qRPRLZtFugDgpHOxKa1VsT787F0gtFeKqTsmuRT60V/Z/lbYYUC97dPAY0JSEuc9i63Dg888+NL0kJkps5WETNy0E45eaVAWLDbPpJ8JGXEtfaYVO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731704984; c=relaxed/simple;
	bh=8PHqNvYNhd077+yMZGdRVPVQtJwqcuP4Sa84pHByMBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hNIErgiDsVAYAS2t1FTCYJbhLqqcqaDUkarahi/usiV+SsI1Htz2/Z/yLpIvn+21TPALC2P458llN0xGDBP/jEDk2Nsoe4D8horczqE2Zsi8eQjvznSEhcPOOUI8VDSQI1gHj4uTm5pqPBtuwWLPXXcGmqzkp41qa3RrThY9gdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ey/fny+0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ey/fny+0"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a850270e2so8326666b.0
        for <virtualization@lists.linux.dev>; Fri, 15 Nov 2024 13:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731704980; x=1732309780; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uHMCkPLDPF5XZhqTYsDkYOtTqtnVR38dCpXI61ABZc=;
        b=ey/fny+0DpQzplGj8ioKXKgciL6UwijpgQP8t1/SfTckMqErLyJsD5Et+i++NSg+HT
         I1SonODeju3kYPe5Dxxy8mi4VVxPDdawznn5G4V1fibBm4thLmtoxAm6dyNvoBNNfAfJ
         dHrCWexeyORk9+0X9uF8nNGbW0mX3M3sSAC8VdF8k0AqzhyqnYQ10LP2xheWgdn/9sKx
         Xx4oAHTR9gELHclkeUyQ6Z1nmXXYkyaqDej5CpHnD21/3spdDP1pnn8JHxeMNx3AfseF
         geTPkZ8ATx4BdTj+oAz2elaEwZQQ2LDyTHM5S3BifhXo5ivNq5Yf9Dgk86Eooc6XteX8
         nzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731704980; x=1732309780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uHMCkPLDPF5XZhqTYsDkYOtTqtnVR38dCpXI61ABZc=;
        b=XANEswluKgwBmFLlradxkxGUUu7POh0o/zXfamFX2/TUZ8eutmD9OCv4kIWEBLaEAf
         JRxfM6JyPIlpOVtrshXIeZDyk6pZfAZC2nA8EKcUhlOraKVknvjjTRDLgctpBEhmK2D/
         69dSb0d4oUG0MhWwtXLqD8YQz1RmtHSYkTNbyjbXSnDkW3jxY3paxYtvdUX+bwm4SZxB
         IA83y6uwSrpOF/niW0SNcVmvmYeaYHOjDbGphZSIkk+E9IMx2IgOQvpZjaK1Ko8AQLzt
         YVYFa0gOsAuFDD5nMhuh2iWrmeXHd+7kESXIQK08E+4kf+H3kgQagLeJa67JmEFBpauL
         z/tw==
X-Forwarded-Encrypted: i=1; AJvYcCXtmPUMtFrVd7yBGZ39AXAtrVnJpL+D2nHny+zCxz4ei+I2IVIPJGmn4Xb6PAlEueDlcfUEUl3epX1q3WR4QQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2BkaLc545BUfklc9xio9JtHrRVaYn45qv9cOttRGkLzIXux1r
	WTAy6RpX+25uPryz9r3t8ewjaVywP38va4b841Cs7J82Cr3MWL4ZaUvZUHhodVg=
X-Google-Smtp-Source: AGHT+IGxHaf9fcl9XH3Yy4K6OzfNJb+yIGPjb6McxskUEb9IogL1YLwYggNBzkIhim2sOLfufDW+VA==
X-Received: by 2002:a17:906:ef08:b0:a99:3c32:b538 with SMTP id a640c23a62f3a-aa483528a6fmr360455366b.42.1731704979697;
        Fri, 15 Nov 2024 13:09:39 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df51648sm219626366b.62.2024.11.15.13.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 13:09:39 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 15 Nov 2024 23:09:27 +0200
Subject: [PATCH 2/5] drm/amdgpu: don't change mode in
 amdgpu_dm_connector_mode_valid()
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-drm-connector-mode-valid-const-v1-2-b1b523156f71@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=8PHqNvYNhd077+yMZGdRVPVQtJwqcuP4Sa84pHByMBM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnN7iIkCEBV+I5bR4TS78RU0e2MvivZF+Q9IyXw
 EixhTur0JyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZze4iAAKCRCLPIo+Aiko
 1RrDCACt21MZrMiNUMyxvhABQ0cPHvM9U/AgIbDDO7KsAj2vwEdyLShml6B1R559Jq8voETjEL9
 +078yb1nu6CV+kEVMsCLyWFw6UxeB+cYhzNHLNY0XaEijGUK9+P7bqa1vk5P0ciW3yNlxIBE4bG
 Pbi3ypuJJQOMFd2qx/gt5R3ZNRVS0e/OjOmoRuxABzzNp/GA862gAioxCBoETiqKvawiyBMRFOi
 2ofeAeyKDJWD0PfvL2vatCO6Dh4kmfG8TJG7CkGnJtYNGqCMpr+WoR8TW/0eoaN+Rs47pTYqp9X
 88uGqYaDw6lWG+6NGKvhI0epp0XANid8bh3EOloIMBAU71W4
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Make amdgpu_dm_connector_mode_valid() duplicate the mode during the
test rather than modifying the passed mode. This is a preparation to
converting the mode_valid() callback of drm_connector to accept const
struct drm_display_mode argument.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 75d6b90104f8fe196df06383b20ee88196a700bf..d0ca905e91eafe6c53f3f2ebdf3f2ae9589d7f89 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7381,6 +7381,7 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 {
 	int result = MODE_ERROR;
 	struct dc_sink *dc_sink;
+	struct drm_display_mode *test_mode;
 	/* TODO: Unhardcode stream count */
 	struct dc_stream_state *stream;
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
@@ -7405,11 +7406,16 @@ enum drm_mode_status amdgpu_dm_connector_mode_valid(struct drm_connector *connec
 		goto fail;
 	}
 
-	drm_mode_set_crtcinfo(mode, 0);
+	test_mode = drm_mode_duplicate(connector->dev, mode);
+	if (!test_mode)
+		goto fail;
+
+	drm_mode_set_crtcinfo(test_mode, 0);
 
-	stream = create_validate_stream_for_sink(aconnector, mode,
+	stream = create_validate_stream_for_sink(aconnector, test_mode,
 						 to_dm_connector_state(connector->state),
 						 NULL);
+	drm_mode_destroy(connector->dev, test_mode);
 	if (stream) {
 		dc_stream_release(stream);
 		result = MODE_OK;

-- 
2.39.5

