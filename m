Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795003732;
	b=mMxXGJVote0a+cpXfQPc4F9Ya/Rg/xmnV3vKhfHMNk0N3xeozMowYxmEPOI5V1ALKjXm
	 Xm5yllLUqIkPnpA+D/Ycp50lYiR4AW60BAhAP1Iax7iw8JSsE9SVxjl2mrqe0cMBAN7Qb
	 xOeXGsuPZOF+gWGQFpP2ZvrnSwFyFdHOoWKRp8nYddmCfB9PYk68cDv9Ida/f5hoUCDTC
	 E1Y5YcWmoDNuW+MPRz15418E9Y2ewMVdLc90QCv7AwrHULkix+2KZoQAtf5gSw2WiQEM4
	 bBoKdEiF1Djs/BOUR5pWDHC1lShzyOqChOgO/vOlGw954f5JBqNaxv764HdOTi0nO9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795003732;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=eWl2HvTXjG8v7lun6xr7S9xfmEGNnTZc7kAe9l+ccgY=;
	b=2Tq+gWjhFg4lSvcy749yMY35B7zFR2w3gmu+lPiXZujVo82KNeXhgcofN7VvsFBGcAaX
	 DH0FQzprxuTvaUKpZWDcilOIwqk2b+gBDaxpyZBYbK+MGyx0jzMSF/IfQXK092L3BoO3g
	 8suUvLQspbq8vjBd7S2YCI3FPAE9SDBmM9JJdeURiVqBKLmU0UqirXjG1aNLun1r/I0Wr
	 W/Zst6yNHf8EWqN/ud5IXWuiVVDjKD2TRjiX3HIX1VpaqBSyto99Gfz0ZOk1wTX+HJxvq
	 8xQMlMOoXIRQmLlnR4tDTX7kZ0fZHaXTXFk5g+U9/zHhuDERS4ePkwcezAeyJXsmvHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nbyA4AV9;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712D3606A330
	for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 12:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 712D3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nbyA4AV9
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e47347279so493269f8f.1
        for <virtualization@lists.linux.dev>; Wed, 18 Nov 2026 04:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795003728; x=1795608528; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eWl2HvTXjG8v7lun6xr7S9xfmEGNnTZc7kAe9l+ccgY=;
        b=nbyA4AV93YRAfjw3wf0t8M3HhL8VXv/e1SxkB9YWIw70Jf10gtwxmtZGxAHnuPYLrd
         GIZ0cW9JcuuLpl83ibSrKrIIP/ciiTZl5uX1+10Mb02VqYryODHxX/Zr63JVDe2KOGBQ
         NcCAnztCnJ/+krGFKAMoPpctEeRRRTlttUlENY1NOFnfQJzeYyr+OqQc17apDa/aYfnT
         CSW2QbF9GHlIk6824x3TsEwZwrSFPrFyL/L4U/jtjdRLx9H1OnHW1xisP4LZVXydgRWY
         5/2UnKquePifnaBPeVTTqZELw7CTqlCwCtOrqCZUfeWRXT9r+APy5pXc6HVVAtk6mfCo
         sHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795003728; x=1795608528;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWl2HvTXjG8v7lun6xr7S9xfmEGNnTZc7kAe9l+ccgY=;
        b=ONZ6yjgNn2W6sQ9bxZHmF4AV6ylx+7GjKrCL6j8d61Df3S4y9mM08iAbgDUP9JjK0Y
         CbN8pdQclGSwde33IrZFddSy7lh7qTB/oGRSFlUI1BKrLTKEHAUaA18SGStRfq7pmODt
         ZESNBNs6RuJe2kqa6J8T5dBUvhmWaIRd7kehAg0h7PsaNx99EqPtkoHw2b+gGK4opCh/
         qwxgvfYSPjzKh44Msgqfyapv7i/8J8DY80NMQCxsBQqzDYTtUmluuwuhKmVF5AXGC8JA
         4U7eeChvpVF6Ggpdrh6K5EHf2z0OVEgO8/JcUrFMWSeKViKofU/77Q/KAKZISTiLzGRC
         Ab3A==
X-Forwarded-Encrypted: i=1; AL+hErHr/uZZ0kHfrx9C1q+xiNc4zp7R0G8dZhpMkZFCscqJAu0t3bSsFBvh01akE0mMhikEZP2NDChnr6IWF29Ggw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Koc8Ymiiy5KyQhHenSNX0ke5/a45aOlNG0JrhIZw6rVPUa8Sq
	WwRvjKSNpUX6i5DU46lzCKMjjL3ay1Esl7Y2213g4uBaKc48l1fCm/RDuEyk7i32IsY=
X-Gm-Gg: AZFdTZcvLfJsbTv8RvUzsPvGm3/H+ET6n+dX5xMsAEULxAOmlq5yRjrJ4Be5lcM+ewp
	qZlZit0tJKePMsuJ03TPlx4OLCbDSSxQ6I6wVr/5OrlTbyo7DYbFqIfmuK3xCMdqkZw5UuEgZnS
	YHjpUBOYMFMBvuWEfUIwRKAsOlOJ2BXx4fWZzbXjXTZoMfX8LdiwmvOcbd8vklgHWgOlvZer73Z
	kXYjYDkW560SBDSVYxD92X32qb82RdJRcAmX94fuciI0Rb9Dhr/lmkeFW+ry/xJ1Fb70UBaqsiy
	O0qOd1iRUnMora3DSJJgT81pPWMgK07yx1KeV/NZ8G0m2f+u9kLq5URT3Es/vm1ptqyouBPYghj
	UEDgOe/VrO9ZImzR5Nq6bRqsU5jCSD0lUZqNtYqYhHMWMb0JsC8nkMzdcR2d4pEAANuA7asnaFY
	1nlwM0qyUoaJk54XbsZFxOEfSbVMaJ0ksZy16dTkGHLACqiuOzmUrXJsw6OPR7kvakZ+Ba9yrAc
	okDZYHBTZMFk/M9++fT7YY8Tac6vWKjgER0qBxlgnVQjBSeIuqEQdIzwVZ8zXcugX1SSV+ApK2M
	8V6mQOnMFlg/+UHL+7hJSCv75Hmy+5SeSfpDltzKLn42JIR+yyVTU2BF/PvSBLm+fxbnfB6skj+
	LTrsB5EQxoW8Hun6FCUqwXn3zQkS+zTUmD7se
X-Received: by 2002:a05:6000:161f:b0:487:1662:cf4c with SMTP id ffacd0b85a97d-4a633a653a2mr3697517f8f.7.1795003726458;
        Wed, 18 Nov 2026 04:08:46 -0800 (PST)
Received: from localhost (p200300f65f19a904dea20c2220232395.dip0.t-ipconnect.de. [2003:f6:5f19:a904:dea2:c22:2023:2395])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4a65683d5a2sm4616022f8f.43.2026.11.18.04.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 04:08:45 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Sasha Finkelstein <k@chaosmail.tech>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	dri-devel@lists.freedesktop.org,
	asahi@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	etnaviv@lists.freedesktop.org,
	linux-samsung-soc@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	imagination@lists.freedesktop.org,
	linux-mips@vger.kernel.org,
	lima@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	virtualization@lists.linux.dev,
	spice-devel@lists.freedesktop.org,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: [PATCH v1 9/9] drm: Unify coding style for *_device_id arrays
Date: Wed, 18 Nov 2026 13:08:16 +0100
Message-ID:  <a2d5ce256b8ec150de4a6494c177b19693a33222.1795002467.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795002467.git.ukleinek@kernel.org>
References: <cover.1795002467.git.ukleinek@kernel.org>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=209321; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=In1JpXOI9z3dXIDBjX9pABaz9z8JP31MgLNN6ztmPVs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq/ZU9bbCoLjX2IGAcLEgTX1FsJipi4t83vG7yJ iJsuaGhQYuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCav2VPQAKCRCPgPtYfRL+ TpxSB/0T8wUokYSDUD98XXcqd47jBOqiR2fDRTm0mnNGQ01vB63I1VddXZ3YHbNInDsmPV5KmOP jz+3sSat9eOtQ7N+RBhhJxOUjKKm9+twk/sr5K2no73kRIHVd6siMLQzhVJvp+zTyjoo3zse7hV MgTyuhuV9upIgbMOKYLoPkw9UdeN0qtJyTCcdFO8BS7VV9Z3Ns4+HmpCDPvCQA/U87k/jENdmA9 AxgKCdZkxE0Xi7gjXjnL/608OW5Ej7hYhr/ylQdjc5pFK9awlpgUS//6wcznXphRN6QW1ZEV+pg Rh/daQzNO9rBzaEKC+sb6RVskHzmwgXeRrp0QBmPyeaZYgQo
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

These arrays already mostly match the most used and generally
recommended coding style. That is:

 - list terminators in a single line;
 - no comma after the list terminator;
 - a comma after an initializer if (and only if) the closing } is not
   directly following;
 - a space after an opening { and before a closing }, a single space in
   the list terminator (unless there is a comment);
 - proper tab indentation for multi-line initializers;

Adapt the offenders accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/adp/adp-mipi.c                |   4 +-
 drivers/gpu/drm/adp/adp_drv.c                 |   4 +-
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |   8 +-
 drivers/gpu/drm/arm/hdlcd_drv.c               |   4 +-
 drivers/gpu/drm/arm/malidp_drv.c              |   8 +-
 drivers/gpu/drm/armada/armada_crtc.c          |   2 +-
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c       |   2 +-
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  |   4 +-
 .../drm/bridge/analogix/analogix-anx6345.c    |   4 +-
 .../drm/bridge/analogix/analogix-anx78xx.c    |   2 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c     |   4 +-
 drivers/gpu/drm/bridge/chipone-icn6211.c      |   2 +-
 drivers/gpu/drm/bridge/chrontel-ch7033.c      |   2 +-
 drivers/gpu/drm/bridge/display-connector.c    |   2 +-
 drivers/gpu/drm/bridge/fsl-ldb.c              |  23 +-
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c  |   7 +-
 .../drm/bridge/imx/imx8qxp-pixel-combiner.c   |   4 +-
 .../gpu/drm/bridge/imx/imx8qxp-pixel-link.c   |   4 +-
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c  |   2 +-
 drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c   |   2 +-
 drivers/gpu/drm/bridge/imx/imx93-pdfc.c       |   4 +-
 drivers/gpu/drm/bridge/ite-it6263.c           |   2 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c      |   4 +-
 drivers/gpu/drm/bridge/lontium-lt9211.c       |   2 +-
 drivers/gpu/drm/bridge/lvds-codec.c           |   2 +-
 .../bridge/megachips-stdpxxxx-ge-b850v3-fw.c  |   4 +-
 drivers/gpu/drm/bridge/microchip-lvds.c       |   6 +-
 drivers/gpu/drm/bridge/nwl-dsi.c              |   2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c          |   2 +-
 drivers/gpu/drm/bridge/parade-ps8622.c        |   6 +-
 drivers/gpu/drm/bridge/sii902x.c              |   2 +-
 drivers/gpu/drm/bridge/sii9234.c              |   2 +-
 drivers/gpu/drm/bridge/sil-sii8620.c          |   2 +-
 drivers/gpu/drm/bridge/tc358767.c             |   2 +-
 drivers/gpu/drm/bridge/tc358768.c             |   4 +-
 drivers/gpu/drm/bridge/tc358775.c             |   4 +-
 drivers/gpu/drm/bridge/tda998x_drv.c          |   2 +-
 drivers/gpu/drm/bridge/th1520-dw-hdmi.c       |   2 +-
 drivers/gpu/drm/bridge/thc63lvd1024.c         |   4 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c         |   2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi86.c         |   4 +-
 drivers/gpu/drm/bridge/ti-tfp410.c            |   2 +-
 drivers/gpu/drm/bridge/ti-tpd12s015.c         |   4 +-
 drivers/gpu/drm/bridge/waveshare-dsi.c        |   4 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c         |   2 +-
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c |   6 +-
 drivers/gpu/drm/exynos/exynos7_drm_decon.c    |   2 +-
 drivers/gpu/drm/exynos/exynos_dp.c            |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_fimc.c      |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c      |  33 +-
 drivers/gpu/drm/exynos/exynos_drm_g2d.c       |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c       |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_rotator.c   |   2 +-
 drivers/gpu/drm/exynos/exynos_drm_scaler.c    |   2 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c          |   5 +-
 drivers/gpu/drm/exynos/exynos_mixer.c         |  15 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c     |   2 +-
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c  |   2 +-
 .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |   7 +-
 .../drm/i915/display/intel_display_device.c   |   2 +-
 .../gpu/drm/i915/display/intel_lpe_audio.c    |   6 +-
 drivers/gpu/drm/i915/i915_pci.c               |   2 +-
 drivers/gpu/drm/imagination/pvr_drv.c         |   2 +-
 drivers/gpu/drm/imx/dc/dc-drv.c               |   2 +-
 drivers/gpu/drm/imx/dc/dc-ic.c                |   2 +-
 drivers/gpu/drm/imx/dc/dc-pe.c                |   2 +-
 drivers/gpu/drm/imx/dcss/dcss-drv.c           |   4 +-
 drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c       |  11 +-
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c      |   4 +-
 drivers/gpu/drm/imx/ipuv3/imx-ldb.c           |   4 +-
 drivers/gpu/drm/imx/ipuv3/imx-tve.c           |   2 +-
 drivers/gpu/drm/imx/ipuv3/parallel-display.c  |   2 +-
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |   2 +-
 drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c     |   2 +-
 drivers/gpu/drm/ingenic/ingenic-ipu.c         |   2 +-
 drivers/gpu/drm/kmb/kmb_drv.c                 |   4 +-
 drivers/gpu/drm/lima/lima_drv.c               |   2 +-
 drivers/gpu/drm/logicvc/logicvc_drm.c         |   2 +-
 drivers/gpu/drm/mcde/mcde_drv.c               |   2 +-
 drivers/gpu/drm/mcde/mcde_dsi.c               |   2 +-
 drivers/gpu/drm/mediatek/mtk_cec.c            |   4 +-
 drivers/gpu/drm/mediatek/mtk_disp_ccorr.c     |  14 +-
 drivers/gpu/drm/mediatek/mtk_disp_color.c     |  20 +-
 drivers/gpu/drm/mediatek/mtk_disp_gamma.c     |  20 +-
 drivers/gpu/drm/mediatek/mtk_disp_merge.c     |   4 +-
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  50 ++-
 drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |  26 +-
 drivers/gpu/drm/mediatek/mtk_dp.c             |   2 +-
 drivers/gpu/drm/mediatek/mtk_dpi.c            |   2 +-
 drivers/gpu/drm/mediatek/mtk_drm_drv.c        | 395 +++++++++++-------
 drivers/gpu/drm/mediatek/mtk_ethdr.c          |   4 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c       |   4 +-
 drivers/gpu/drm/mediatek/mtk_mdp_rdma.c       |   4 +-
 drivers/gpu/drm/meson/meson_drv.c             |  28 +-
 drivers/gpu/drm/meson/meson_dw_hdmi.c         |  24 +-
 drivers/gpu/drm/meson/meson_dw_mipi_dsi.c     |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c    |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  70 ++--
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c      |   6 +-
 drivers/gpu/drm/msm/dp/dp_display.c           |   2 +-
 drivers/gpu/drm/msm/dsi/dsi.c                 |   2 +-
 drivers/gpu/drm/msm/hdmi/hdmi.c               |   2 +-
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c           |  38 +-
 drivers/gpu/drm/msm/msm_drv.c                 |   2 +-
 drivers/gpu/drm/msm/msm_mdss.c                |   2 +-
 drivers/gpu/drm/mxsfb/mxsfb_drv.c             |   6 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c         |   2 +-
 drivers/gpu/drm/omapdrm/dss/dispc.c           |   2 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c             |   8 +-
 drivers/gpu/drm/omapdrm/dss/dss.c             |   2 +-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c           |   4 +-
 drivers/gpu/drm/omapdrm/dss/hdmi5.c           |   6 +-
 drivers/gpu/drm/omapdrm/dss/venc.c            |   8 +-
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c      |   2 +-
 drivers/gpu/drm/panel/panel-arm-versatile.c   |   4 +-
 drivers/gpu/drm/panel/panel-boe-himax8279d.c  |   4 +-
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  |   4 +-
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  47 ++-
 drivers/gpu/drm/panel/panel-dsi-cm.c          |   2 +-
 drivers/gpu/drm/panel/panel-edp.c             |   5 +-
 .../gpu/drm/panel/panel-feixin-k101-im2ba02.c |   2 +-
 .../drm/panel/panel-feiyang-fy07024di26a30d.c |   2 +-
 .../gpu/drm/panel/panel-focaltech-ota7290b.c  |   4 +-
 drivers/gpu/drm/panel/panel-himax-hx83102.c   |  47 ++-
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c |  17 +-
 drivers/gpu/drm/panel/panel-innolux-p079zca.c |  11 +-
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  |  30 +-
 drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c |   2 +-
 .../gpu/drm/panel/panel-jdi-lt070me05000.c    |   2 +-
 drivers/gpu/drm/panel/panel-khadas-ts050.c    |   4 +-
 .../drm/panel/panel-kingdisplay-kd097d04.c    |   2 +-
 drivers/gpu/drm/panel/panel-lg-lb035q02.c     |   4 +-
 drivers/gpu/drm/panel/panel-lg-sw43408.c      |   4 +-
 .../gpu/drm/panel/panel-lincolntech-lcd197.c  |   2 +-
 drivers/gpu/drm/panel/panel-lvds.c            |   4 +-
 .../drm/panel/panel-magnachip-d53e6ea8966.c   |   2 +-
 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c  |   4 +-
 drivers/gpu/drm/panel/panel-novatek-nt35950.c |   2 +-
 drivers/gpu/drm/panel/panel-novatek-nt36523.c |   2 +-
 .../gpu/drm/panel/panel-novatek-nt36672a.c    |   2 +-
 drivers/gpu/drm/panel/panel-novatek-nt36850.c |   2 +-
 drivers/gpu/drm/panel/panel-novatek-nt37801.c |   2 +-
 .../drm/panel/panel-osd-osd101t2587-53ts.c    |   5 +-
 .../drm/panel/panel-panasonic-vvx10f034n00.c  |   2 +-
 drivers/gpu/drm/panel/panel-raydium-rm67191.c |   2 +-
 drivers/gpu/drm/panel/panel-renesas-r63419.c  |   2 +-
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c  |   2 +-
 .../gpu/drm/panel/panel-samsung-atna33xc20.c  |   2 +-
 drivers/gpu/drm/panel/panel-samsung-db7430.c  |   6 +-
 drivers/gpu/drm/panel/panel-samsung-s6d27a1.c |   4 +-
 drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c |   6 +-
 .../panel/panel-samsung-s6e88a0-ams427ap24.c  |   2 +-
 .../panel/panel-samsung-s6e88a0-ams452ef01.c  |   2 +-
 drivers/gpu/drm/panel/panel-seiko-43wvf1g.c   |   5 +-
 .../gpu/drm/panel/panel-sharp-lq101r1sx01.c   |   2 +-
 .../gpu/drm/panel/panel-sharp-ls037v7dw01.c   |   4 +-
 .../gpu/drm/panel/panel-sharp-ls043t1le01.c   |   2 +-
 drivers/gpu/drm/panel/panel-simple.c          |  70 ++--
 .../gpu/drm/panel/panel-sitronix-st7789v.c    |  18 +-
 drivers/gpu/drm/panel/panel-sony-acx565akm.c  |   4 +-
 .../drm/panel/panel-startek-kd070fhfid015.c   |   2 +-
 drivers/gpu/drm/panel/panel-summit.c          |   2 +-
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c  |   2 +-
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c  |   6 +-
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c  |   4 +-
 drivers/gpu/drm/panel/panel-tpo-tpg110.c      |   6 +-
 drivers/gpu/drm/panel/panel-visionox-r66451.c |   2 +-
 .../gpu/drm/panel/panel-visionox-rm69299.c    |  12 +-
 .../gpu/drm/panel/panel-widechips-ws2401.c    |   6 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c       |  36 +-
 drivers/gpu/drm/panthor/panthor_drv.c         |   4 +-
 drivers/gpu/drm/pl111/pl111_versatile.c       |   4 +-
 drivers/gpu/drm/qxl/qxl_drv.c                 |   6 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c    |   6 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c    |   2 +-
 .../gpu/drm/renesas/rcar-du/rcar_dw_hdmi.c    |   2 +-
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    |   6 +-
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  12 +-
 drivers/gpu/drm/rockchip/cdn-dp-core.c        |   8 +-
 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   |  32 +-
 .../gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c  |   2 +-
 drivers/gpu/drm/rockchip/dw_dp-rockchip.c     |   2 +-
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c   |  32 +-
 .../gpu/drm/rockchip/dw_hdmi_qp-rockchip.c    |   6 +-
 drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c |  12 +-
 drivers/gpu/drm/rockchip/rk3066_hdmi.c        |   2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_drv.c   |   4 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c      |   6 +-
 drivers/gpu/drm/rockchip/rockchip_vop2_reg.c  |   4 +-
 drivers/gpu/drm/rockchip/rockchip_vop_reg.c   |  92 ++--
 drivers/gpu/drm/sitronix/st7571-i2c.c         |   2 +-
 drivers/gpu/drm/sitronix/st7571-spi.c         |   2 +-
 drivers/gpu/drm/sitronix/st7586.c             |   4 +-
 drivers/gpu/drm/sitronix/st7735r.c            |   4 +-
 drivers/gpu/drm/sprd/sprd_dpu.c               |   2 +-
 drivers/gpu/drm/sprd/sprd_drm.c               |   4 +-
 drivers/gpu/drm/sprd/sprd_dsi.c               |   2 +-
 drivers/gpu/drm/sti/sti_compositor.c          |   5 +-
 drivers/gpu/drm/sti/sti_drv.c                 |   4 +-
 drivers/gpu/drm/sti/sti_dvo.c                 |   2 +-
 drivers/gpu/drm/sti/sti_hda.c                 |   4 +-
 drivers/gpu/drm/sti/sti_hdmi.c                |   5 +-
 drivers/gpu/drm/sti/sti_hqvdp.c               |   2 +-
 drivers/gpu/drm/sti/sti_tvout.c               |   2 +-
 drivers/gpu/drm/sti/sti_vtg.c                 |   2 +-
 drivers/gpu/drm/stm/drv.c                     |   8 +-
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c         |   4 +-
 drivers/gpu/drm/stm/lvds.c                    |   2 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.c        |   8 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c        |   6 +-
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c        |  12 +-
 drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c         |   2 +-
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c        |   6 +-
 drivers/gpu/drm/sysfb/ofdrm.c                 |   4 +-
 drivers/gpu/drm/sysfb/simpledrm.c             |   4 +-
 drivers/gpu/drm/tegra/dc.c                    |   5 +-
 drivers/gpu/drm/tegra/dpaux.c                 |   2 +-
 drivers/gpu/drm/tegra/drm.c                   |  84 ++--
 drivers/gpu/drm/tegra/dsi.c                   |   2 +-
 drivers/gpu/drm/tegra/gr2d.c                  |   2 +-
 drivers/gpu/drm/tegra/hdmi.c                  |   2 +-
 drivers/gpu/drm/tegra/hub.c                   |   9 +-
 drivers/gpu/drm/tegra/nvdec.c                 |   2 +-
 drivers/gpu/drm/tegra/nvjpg.c                 |   2 +-
 drivers/gpu/drm/tegra/sor.c                   |   2 +-
 drivers/gpu/drm/tegra/vic.c                   |   2 +-
 drivers/gpu/drm/tidss/tidss_drv.c             |  12 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           |   6 +-
 drivers/gpu/drm/tiny/arcpgu.c                 |   4 +-
 drivers/gpu/drm/tiny/ili9225.c                |   4 +-
 drivers/gpu/drm/tiny/ili9486.c                |   2 +-
 drivers/gpu/drm/tiny/mi0283qt.c               |   4 +-
 drivers/gpu/drm/tiny/panel-mipi-dbi.c         |   4 +-
 drivers/gpu/drm/tiny/pixpaper.c               |   2 +-
 drivers/gpu/drm/tiny/repaper.c                |   4 +-
 drivers/gpu/drm/tiny/sharp-memory.c           |   4 +-
 drivers/gpu/drm/tve200/tve200_drv.c           |   2 +-
 drivers/gpu/drm/v3d/v3d_drv.c                 |   2 +-
 drivers/gpu/drm/vc4/vc4_crtc.c                |   2 +-
 drivers/gpu/drm/vc4/vc4_dpi.c                 |   2 +-
 drivers/gpu/drm/vc4/vc4_drv.c                 |   2 +-
 drivers/gpu/drm/vc4/vc4_dsi.c                 |   2 +-
 drivers/gpu/drm/vc4/vc4_hdmi.c                |   2 +-
 drivers/gpu/drm/vc4/vc4_hvs.c                 |   2 +-
 drivers/gpu/drm/vc4/vc4_txp.c                 |   2 +-
 drivers/gpu/drm/vc4/vc4_v3d.c                 |   2 +-
 drivers/gpu/drm/vc4/vc4_vec.c                 |   2 +-
 drivers/gpu/drm/verisilicon/vs_dc.c           |   2 +-
 drivers/gpu/drm/xlnx/zynqmp_dpsub.c           |   4 +-
 drivers/gpu/host1x/dev.c                      |  20 +-
 drivers/gpu/host1x/tegra114-mipi.c            |   2 +-
 drivers/gpu/ipu-v3/ipu-common.c               |   8 +-
 drivers/gpu/ipu-v3/ipu-pre.c                  |   4 +-
 drivers/gpu/ipu-v3/ipu-prg.c                  |   4 +-
 254 files changed, 1155 insertions(+), 940 deletions(-)

diff --git a/drivers/gpu/drm/adp/adp-mipi.c b/drivers/gpu/drm/adp/adp-mipi.c
index 956533870781..499c6b59c91d 100644
--- a/drivers/gpu/drm/adp/adp-mipi.c
+++ b/drivers/gpu/drm/adp/adp-mipi.c
@@ -262,8 +262,8 @@ static void adp_mipi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id adp_mipi_of_match[] = {
-	{ .compatible = "apple,h7-display-pipe-mipi", },
-	{ },
+	{ .compatible = "apple,h7-display-pipe-mipi" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adp_mipi_of_match);
 
diff --git a/drivers/gpu/drm/adp/adp_drv.c b/drivers/gpu/drm/adp/adp_drv.c
index fdf0e6316175..6231d3320980 100644
--- a/drivers/gpu/drm/adp/adp_drv.c
+++ b/drivers/gpu/drm/adp/adp_drv.c
@@ -592,8 +592,8 @@ static void adp_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id adp_of_match[] = {
-	{ .compatible = "apple,h7-display-pipe", },
-	{ },
+	{ .compatible = "apple,h7-display-pipe" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, adp_of_match);
 
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
index 703ff7827835..95636f37f058 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -105,10 +105,10 @@ static int komeda_platform_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id komeda_of_match[] = {
-	{ .compatible = "arm,mali-d71", .data = d71_identify, },
-	{ .compatible = "arm,mali-d32", .data = d71_identify, },
-	{ .compatible = "armchina,linlon-d6", .data = d71_identify, },
-	{},
+	{ .compatible = "arm,mali-d71", .data = d71_identify },
+	{ .compatible = "arm,mali-d32", .data = d71_identify },
+	{ .compatible = "armchina,linlon-d6", .data = d71_identify },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, komeda_of_match);
diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
index 340b1bb38bf9..2be29d182558 100644
--- a/drivers/gpu/drm/arm/hdlcd_drv.c
+++ b/drivers/gpu/drm/arm/hdlcd_drv.c
@@ -371,8 +371,8 @@ static void hdlcd_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id  hdlcd_of_match[] = {
-	{ .compatible	= "arm,hdlcd" },
-	{},
+	{ .compatible = "arm,hdlcd" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, hdlcd_of_match);
 
diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index b4e38eba5957..a02f0ff06a78 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -578,17 +578,17 @@ static const struct drm_driver malidp_driver = {
 static const struct of_device_id  malidp_drm_of_match[] = {
 	{
 		.compatible = "arm,mali-dp500",
-		.data = &malidp_device[MALIDP_500]
+		.data = &malidp_device[MALIDP_500],
 	},
 	{
 		.compatible = "arm,mali-dp550",
-		.data = &malidp_device[MALIDP_550]
+		.data = &malidp_device[MALIDP_550],
 	},
 	{
 		.compatible = "arm,mali-dp650",
-		.data = &malidp_device[MALIDP_650]
+		.data = &malidp_device[MALIDP_650],
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, malidp_drm_of_match);
 
diff --git a/drivers/gpu/drm/armada/armada_crtc.c b/drivers/gpu/drm/armada/armada_crtc.c
index d349beaa2990..9a295771f90a 100644
--- a/drivers/gpu/drm/armada/armada_crtc.c
+++ b/drivers/gpu/drm/armada/armada_crtc.c
@@ -1067,7 +1067,7 @@ static const struct of_device_id armada_lcd_of_match[] = {
 		.compatible	= "marvell,dove-lcd",
 		.data		= &armada510_ops,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, armada_lcd_of_match);
 
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 3822b2723ba6..d594147f4da5 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -92,7 +92,7 @@ static const struct of_device_id aspeed_gfx_match[] = {
 	{ .compatible = "aspeed,ast2400-gfx", .data = &ast2400_config },
 	{ .compatible = "aspeed,ast2500-gfx", .data = &ast2500_config },
 	{ .compatible = "aspeed,ast2600-gfx", .data = &ast2600_config },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, aspeed_gfx_match);
 
diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
index 453c37de9bee..cf8bea1cc8f6 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c
@@ -676,7 +676,7 @@ static const struct of_device_id atmel_hlcdc_of_match[] = {
 		.compatible = "microchip,sama7d65-xlcdc",
 		.data = &atmel_xlcdc_dc_sama7d65,
 	},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, atmel_hlcdc_of_match);
 
@@ -1017,7 +1017,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(atmel_hlcdc_dc_drm_pm_ops,
 
 static const struct of_device_id atmel_hlcdc_dc_of_match[] = {
 	{ .compatible = "atmel,hlcdc-display-controller" },
-	{ },
+	{ }
 };
 
 static struct platform_driver atmel_hlcdc_dc_platform_driver = {
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index 0cff9ff0265a..200f9292e56d 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -789,8 +789,8 @@ static const struct i2c_device_id anx6345_id[] = {
 MODULE_DEVICE_TABLE(i2c, anx6345_id);
 
 static const struct of_device_id anx6345_match_table[] = {
-	{ .compatible = "analogix,anx6345", },
-	{ /* sentinel */ },
+	{ .compatible = "analogix,anx6345" },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, anx6345_match_table);
 
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
index 94f07a2317e1..0662b145d289 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -1345,7 +1345,7 @@ static const struct of_device_id anx78xx_match_table[] = {
 	{ .compatible = "analogix,anx7814", .data = anx781x_i2c_addresses },
 	{ .compatible = "analogix,anx7816", .data = anx781x_i2c_addresses },
 	{ .compatible = "analogix,anx7818", .data = anx781x_i2c_addresses },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, anx78xx_match_table);
 
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index c3af88e14f8b..5a246129364c 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -3000,8 +3000,8 @@ static const struct i2c_device_id anx7625_id[] = {
 MODULE_DEVICE_TABLE(i2c, anx7625_id);
 
 static const struct of_device_id anx_match_table[] = {
-	{.compatible = "analogix,anx7625",},
-	{},
+	{ .compatible = "analogix,anx7625" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, anx_match_table);
 
diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 14eaae07455c..7a8a3dc0be0d 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -763,7 +763,7 @@ static int chipone_i2c_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id chipone_of_match[] = {
-	{ .compatible = "chipone,icn6211", },
+	{ .compatible = "chipone,icn6211" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, chipone_of_match);
diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index 3d48b42c38a0..1218a4dd723a 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -595,7 +595,7 @@ static void ch7033_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id ch7033_dt_ids[] = {
-	{ .compatible = "chrontel,ch7033", },
+	{ .compatible = "chrontel,ch7033" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ch7033_dt_ids);
diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index eb3412ec30a0..84dc3c1c690e 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -469,7 +469,7 @@ static const struct of_device_id display_connector_match[] = {
 		.compatible = "dp-connector",
 		.data = (void *)DRM_MODE_CONNECTOR_DisplayPort,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, display_connector_match);
 
diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 3ac9fbc46343..8e148cc59e97 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -382,15 +382,20 @@ static void fsl_ldb_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id fsl_ldb_match[] = {
-	{ .compatible = "fsl,imx6sx-ldb",
-	  .data = &fsl_ldb_devdata[IMX6SX_LDB], },
-	{ .compatible = "fsl,imx8mp-ldb",
-	  .data = &fsl_ldb_devdata[IMX8MP_LDB], },
-	{ .compatible = "fsl,imx93-ldb",
-	  .data = &fsl_ldb_devdata[IMX93_LDB], },
-	{ .compatible = "fsl,imx94-ldb",
-	  .data = &fsl_ldb_devdata[IMX94_LDB], },
-	{ /* sentinel */ },
+	{
+		.compatible = "fsl,imx6sx-ldb",
+		.data = &fsl_ldb_devdata[IMX6SX_LDB],
+	}, {
+		.compatible = "fsl,imx8mp-ldb",
+		.data = &fsl_ldb_devdata[IMX8MP_LDB],
+	}, {
+		.compatible = "fsl,imx93-ldb",
+		.data = &fsl_ldb_devdata[IMX93_LDB],
+	}, {
+		.compatible = "fsl,imx94-ldb",
+		.data = &fsl_ldb_devdata[IMX94_LDB],
+	},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, fsl_ldb_match);
 
diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
index a31d4fc76f35..312d2b4d6892 100644
--- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
@@ -184,11 +184,8 @@ static void imx8mp_hdmi_pvi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx8mp_hdmi_pvi_match[] = {
-	{
-		.compatible = "fsl,imx8mp-hdmi-pvi",
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "fsl,imx8mp-hdmi-pvi" },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx8mp_hdmi_pvi_match);
 
diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
index cb399434374e..09316e2f36e1 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
@@ -416,8 +416,8 @@ static const struct dev_pm_ops imx8qxp_pc_pm_ops = {
 };
 
 static const struct of_device_id imx8qxp_pc_dt_ids[] = {
-	{ .compatible = "fsl,imx8qm-pixel-combiner", },
-	{ .compatible = "fsl,imx8qxp-pixel-combiner", },
+	{ .compatible = "fsl,imx8qm-pixel-combiner" },
+	{ .compatible = "fsl,imx8qxp-pixel-combiner" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx8qxp_pc_dt_ids);
diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
index 56ce6aa76181..69dc0b5f7617 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
@@ -389,8 +389,8 @@ static void imx8qxp_pixel_link_bridge_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx8qxp_pixel_link_dt_ids[] = {
-	{ .compatible = "fsl,imx8qm-dc-pixel-link", },
-	{ .compatible = "fsl,imx8qxp-dc-pixel-link", },
+	{ .compatible = "fsl,imx8qm-dc-pixel-link" },
+	{ .compatible = "fsl,imx8qxp-dc-pixel-link" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx8qxp_pixel_link_dt_ids);
diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
index dce1a5b36024..a42d62a262b8 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
@@ -454,7 +454,7 @@ static void imx8qxp_pxl2dpi_bridge_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx8qxp_pxl2dpi_dt_ids[] = {
-	{ .compatible = "fsl,imx8qxp-pxl2dpi", },
+	{ .compatible = "fsl,imx8qxp-pxl2dpi" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx8qxp_pxl2dpi_dt_ids);
diff --git a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
index 6453ea779606..4129fa0faa68 100644
--- a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
@@ -895,7 +895,7 @@ static void imx93_dsi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx93_dsi_dt_ids[] = {
-	{ .compatible = "fsl,imx93-mipi-dsi", },
+	{ .compatible = "fsl,imx93-mipi-dsi" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx93_dsi_dt_ids);
diff --git a/drivers/gpu/drm/bridge/imx/imx93-pdfc.c b/drivers/gpu/drm/bridge/imx/imx93-pdfc.c
index 2e5019ed951a..ac2f6be30664 100644
--- a/drivers/gpu/drm/bridge/imx/imx93-pdfc.c
+++ b/drivers/gpu/drm/bridge/imx/imx93-pdfc.c
@@ -203,8 +203,8 @@ static int imx93_pdfc_bridge_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx93_pdfc_dt_ids[] = {
-	{ .compatible = "nxp,imx91-pdfc", },
-	{ .compatible = "nxp,imx93-pdfc", },
+	{ .compatible = "nxp,imx91-pdfc" },
+	{ .compatible = "nxp,imx93-pdfc" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx93_pdfc_dt_ids);
diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index e8e0197171e1..7498766fc73a 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -875,7 +875,7 @@ static int it6263_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id it6263_of_match[] = {
-	{ .compatible = "ite,it6263", },
+	{ .compatible = "ite,it6263" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, it6263_of_match);
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index a4d05dcba9e0..c9d54be43e66 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -814,8 +814,8 @@ static void lt8912_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id lt8912_dt_match[] = {
-	{.compatible = "lontium,lt8912b"},
-	{}
+	{ .compatible = "lontium,lt8912b" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, lt8912_dt_match);
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index b165fba0a1c0..c01f9260c098 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -779,7 +779,7 @@ MODULE_DEVICE_TABLE(i2c, lt9211_id);
 
 static const struct of_device_id lt9211_match_table[] = {
 	{ .compatible = "lontium,lt9211" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, lt9211_match_table);
 
diff --git a/drivers/gpu/drm/bridge/lvds-codec.c b/drivers/gpu/drm/bridge/lvds-codec.c
index 7ce633a74860..a1621be0e81d 100644
--- a/drivers/gpu/drm/bridge/lvds-codec.c
+++ b/drivers/gpu/drm/bridge/lvds-codec.c
@@ -232,7 +232,7 @@ static const struct of_device_id lvds_codec_match[] = {
 		.compatible = "thine,thc63lvdm83d",
 		.data = (void *)DRM_MODE_CONNECTOR_LVDS,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, lvds_codec_match);
 
diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index 9153bf629fd1..fe2d5aebbf74 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -324,7 +324,7 @@ MODULE_DEVICE_TABLE(i2c, stdp4028_ge_b850v3_fw_i2c_table);
 
 static const struct of_device_id stdp4028_ge_b850v3_fw_match[] = {
 	{ .compatible = "megachips,stdp4028-ge-b850v3-fw" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stdp4028_ge_b850v3_fw_match);
 
@@ -371,7 +371,7 @@ MODULE_DEVICE_TABLE(i2c, stdp2690_ge_b850v3_fw_i2c_table);
 
 static const struct of_device_id stdp2690_ge_b850v3_fw_match[] = {
 	{ .compatible = "megachips,stdp2690-ge-b850v3-fw" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, stdp2690_ge_b850v3_fw_match);
 
diff --git a/drivers/gpu/drm/bridge/microchip-lvds.c b/drivers/gpu/drm/bridge/microchip-lvds.c
index 39d5ec051627..f138c4f0f104 100644
--- a/drivers/gpu/drm/bridge/microchip-lvds.c
+++ b/drivers/gpu/drm/bridge/microchip-lvds.c
@@ -220,10 +220,8 @@ static int mchp_lvds_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id mchp_lvds_dt_ids[] = {
-	{
-		.compatible = "microchip,sam9x75-lvds",
-	},
-	{},
+	{ .compatible = "microchip,sam9x75-lvds" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mchp_lvds_dt_ids);
 
diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index f748908d09e0..89d82d205ffa 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -1136,7 +1136,7 @@ static const struct drm_bridge_timings nwl_dsi_timings = {
 };
 
 static const struct of_device_id nwl_dsi_dt_ids[] = {
-	{ .compatible = "fsl,imx8mq-nwl-dsi", },
+	{ .compatible = "fsl,imx8mq-nwl-dsi" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, nwl_dsi_dt_ids);
diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index be6a06130ba9..4b15e1ec68eb 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -330,7 +330,7 @@ MODULE_DEVICE_TABLE(i2c, ptn3460_i2c_table);
 
 static const struct of_device_id ptn3460_match[] = {
 	{ .compatible = "nxp,ptn3460" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ptn3460_match);
 
diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 3a2ec482037d..209d05e9e30a 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -441,9 +441,9 @@ static const struct drm_bridge_funcs ps8622_bridge_funcs = {
 };
 
 static const struct of_device_id ps8622_devices[] = {
-	{.compatible = "parade,ps8622",},
-	{.compatible = "parade,ps8625",},
-	{}
+	{ .compatible = "parade,ps8622" },
+	{ .compatible = "parade,ps8625" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ps8622_devices);
 
diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 0f7cdf0ea148..edef2851a23e 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -1243,7 +1243,7 @@ static void sii902x_remove(struct i2c_client *client)
 }
 
 static const struct of_device_id sii902x_dt_ids[] = {
-	{ .compatible = "sil,sii9022", },
+	{ .compatible = "sil,sii9022" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sii902x_dt_ids);
diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index 9fef332db248..4bff4a0d1b84 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -939,7 +939,7 @@ static void sii9234_remove(struct i2c_client *client)
 
 static const struct of_device_id sii9234_dt_match[] = {
 	{ .compatible = "sil,sii9234" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sii9234_dt_match);
 
diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 88f9cd9ba6db..0615b8833160 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2368,7 +2368,7 @@ static void sii8620_remove(struct i2c_client *client)
 
 static const struct of_device_id sii8620_dt_match[] = {
 	{ .compatible = "sil,sii8620" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sii8620_dt_match);
 
diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index f61c619fb305..eb95a61dadb5 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2591,7 +2591,7 @@ static const struct i2c_device_id tc358767_i2c_ids[] = {
 MODULE_DEVICE_TABLE(i2c, tc358767_i2c_ids);
 
 static const struct of_device_id tc358767_of_ids[] = {
-	{ .compatible = "toshiba,tc358767", },
+	{ .compatible = "toshiba,tc358767" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tc358767_of_ids);
diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 9dbc66a3531c..b1e6c6336c50 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -1360,8 +1360,8 @@ static const struct i2c_device_id tc358768_i2c_ids[] = {
 MODULE_DEVICE_TABLE(i2c, tc358768_i2c_ids);
 
 static const struct of_device_id tc358768_of_ids[] = {
-	{ .compatible = "toshiba,tc358768", },
-	{ .compatible = "toshiba,tc358778", },
+	{ .compatible = "toshiba,tc358768" },
+	{ .compatible = "toshiba,tc358778" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tc358768_of_ids);
diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 203dc738ecef..b0ef0ad34987 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -734,8 +734,8 @@ static const struct i2c_device_id tc358775_i2c_ids[] = {
 MODULE_DEVICE_TABLE(i2c, tc358775_i2c_ids);
 
 static const struct of_device_id tc358775_of_ids[] = {
-	{ .compatible = "toshiba,tc358765", .data = (void *)TC358765, },
-	{ .compatible = "toshiba,tc358775", .data = (void *)TC358775, },
+	{ .compatible = "toshiba,tc358765", .data = (void *)TC358765 },
+	{ .compatible = "toshiba,tc358775", .data = (void *)TC358775 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tc358775_of_ids);
diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index 54ef526a1133..e5c48fbc9ffc 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -2056,7 +2056,7 @@ static void tda998x_remove(struct i2c_client *client)
 
 #ifdef CONFIG_OF
 static const struct of_device_id tda998x_dt_ids[] = {
-	{ .compatible = "nxp,tda998x", },
+	{ .compatible = "nxp,tda998x" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tda998x_dt_ids);
diff --git a/drivers/gpu/drm/bridge/th1520-dw-hdmi.c b/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
index ff01e8865f8e..b6eb24bc2603 100644
--- a/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/th1520-dw-hdmi.c
@@ -152,7 +152,7 @@ static void th1520_dw_hdmi_remove(struct platform_device *pdev)
 
 static const struct of_device_id th1520_dw_hdmi_of_table[] = {
 	{ .compatible = "thead,th1520-dw-hdmi" },
-	{ /* Sentinel */ },
+	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, th1520_dw_hdmi_of_table);
 
diff --git a/drivers/gpu/drm/bridge/thc63lvd1024.c b/drivers/gpu/drm/bridge/thc63lvd1024.c
index 679b424ba0c3..475f5e5f6375 100644
--- a/drivers/gpu/drm/bridge/thc63lvd1024.c
+++ b/drivers/gpu/drm/bridge/thc63lvd1024.c
@@ -229,8 +229,8 @@ static void thc63_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id thc63_match[] = {
-	{ .compatible = "thine,thc63lvd1024", },
-	{ },
+	{ .compatible = "thine,thc63lvd1024" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, thc63_match);
 
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 77ef1613c5f5..43e1aadca164 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -1077,7 +1077,7 @@ MODULE_DEVICE_TABLE(i2c, sn65dsi83_id);
 static const struct of_device_id sn65dsi83_match_table[] = {
 	{ .compatible = "ti,sn65dsi83", .data = (void *)MODEL_SN65DSI83 },
 	{ .compatible = "ti,sn65dsi84", .data = (void *)MODEL_SN65DSI84 },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sn65dsi83_match_table);
 
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 48b83df9aed6..86bbc03a50bb 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -2122,8 +2122,8 @@ static const struct i2c_device_id ti_sn65dsi86_id[] = {
 MODULE_DEVICE_TABLE(i2c, ti_sn65dsi86_id);
 
 static const struct of_device_id ti_sn65dsi86_match_table[] = {
-	{.compatible = "ti,sn65dsi86"},
-	{},
+	{ .compatible = "ti,sn65dsi86" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ti_sn65dsi86_match_table);
 
diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 64a3d64e1f7b..3a4699bc89ea 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -402,7 +402,7 @@ static void tfp410_remove(struct platform_device *pdev)
 
 static const struct of_device_id tfp410_match[] = {
 	{ .compatible = "ti,tfp410" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tfp410_match);
 
diff --git a/drivers/gpu/drm/bridge/ti-tpd12s015.c b/drivers/gpu/drm/bridge/ti-tpd12s015.c
index e7b172ab7f55..e4e0cde1d7a4 100644
--- a/drivers/gpu/drm/bridge/ti-tpd12s015.c
+++ b/drivers/gpu/drm/bridge/ti-tpd12s015.c
@@ -196,8 +196,8 @@ static void tpd12s015_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id tpd12s015_of_match[] = {
-	{ .compatible = "ti,tpd12s015", },
-	{},
+	{ .compatible = "ti,tpd12s015" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, tpd12s015_of_match);
diff --git a/drivers/gpu/drm/bridge/waveshare-dsi.c b/drivers/gpu/drm/bridge/waveshare-dsi.c
index 2c40bfef2b45..f3c7186746c6 100644
--- a/drivers/gpu/drm/bridge/waveshare-dsi.c
+++ b/drivers/gpu/drm/bridge/waveshare-dsi.c
@@ -185,8 +185,8 @@ static int ws_bridge_probe(struct i2c_client *i2c)
 }
 
 static const struct of_device_id ws_bridge_of_ids[] = {
-	{.compatible = "waveshare,dsi2dpi", .data = (void *)DRM_MODE_CONNECTOR_DPI, },
-	{.compatible = "waveshare,dsi2lvds", .data = (void *)DRM_MODE_CONNECTOR_LVDS, },
+	{ .compatible = "waveshare,dsi2dpi", .data = (void *)DRM_MODE_CONNECTOR_DPI },
+	{ .compatible = "waveshare,dsi2lvds", .data = (void *)DRM_MODE_CONNECTOR_LVDS },
 	{ }
 };
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 28d29d53e15a..91af13af7cf8 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1888,7 +1888,7 @@ static const struct component_ops gpu_ops = {
 
 static const struct of_device_id etnaviv_gpu_match[] = {
 	{
-		.compatible = "vivante,gc"
+		.compatible = "vivante,gc",
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
index 4393ed768996..3063d7db20ce 100644
--- a/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos5433_drm_decon.c
@@ -749,13 +749,13 @@ static DEFINE_RUNTIME_DEV_PM_OPS(exynos5433_decon_pm_ops,
 static const struct of_device_id exynos5433_decon_driver_dt_match[] = {
 	{
 		.compatible = "samsung,exynos5433-decon",
-		.data = (void *)I80_HW_TRG
+		.data = (void *)I80_HW_TRG,
 	},
 	{
 		.compatible = "samsung,exynos5433-decon-tv",
-		.data = (void *)(I80_HW_TRG | IFTYPE_HDMI)
+		.data = (void *)(I80_HW_TRG | IFTYPE_HDMI),
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, exynos5433_decon_driver_dt_match);
 
diff --git a/drivers/gpu/drm/exynos/exynos7_drm_decon.c b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
index 3ab5d3586792..88fb38861bb3 100644
--- a/drivers/gpu/drm/exynos/exynos7_drm_decon.c
+++ b/drivers/gpu/drm/exynos/exynos7_drm_decon.c
@@ -86,7 +86,7 @@ static const struct of_device_id decon_driver_dt_match[] = {
 		.compatible = "samsung,exynos7870-decon",
 		.data = &exynos7870_decon_data,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, decon_driver_dt_match);
 
diff --git a/drivers/gpu/drm/exynos/exynos_dp.c b/drivers/gpu/drm/exynos/exynos_dp.c
index 4db7400c8a23..b97ccc438992 100644
--- a/drivers/gpu/drm/exynos/exynos_dp.c
+++ b/drivers/gpu/drm/exynos/exynos_dp.c
@@ -208,7 +208,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(exynos_dp_pm_ops, exynos_dp_suspend,
 
 static const struct of_device_id exynos_dp_match[] = {
 	{ .compatible = "samsung,exynos5-dp" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, exynos_dp_match);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
index 9c2ad95799ee..6cc290f6ff3c 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
@@ -1401,7 +1401,7 @@ static DEFINE_RUNTIME_DEV_PM_OPS(fimc_pm_ops, fimc_runtime_suspend,
 static const struct of_device_id fimc_of_match[] = {
 	{ .compatible = "samsung,exynos4210-fimc" },
 	{ .compatible = "samsung,exynos4212-fimc" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, fimc_of_match);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimd.c b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
index 60af868ac214..13fee4d5846a 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimd.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimd.c
@@ -201,19 +201,26 @@ struct fimd_context {
 };
 
 static const struct of_device_id fimd_driver_dt_match[] = {
-	{ .compatible = "samsung,s3c6400-fimd",
-	  .data = &s3c64xx_fimd_driver_data },
-	{ .compatible = "samsung,s5pv210-fimd",
-	  .data = &s5pv210_fimd_driver_data },
-	{ .compatible = "samsung,exynos3250-fimd",
-	  .data = &exynos3_fimd_driver_data },
-	{ .compatible = "samsung,exynos4210-fimd",
-	  .data = &exynos4_fimd_driver_data },
-	{ .compatible = "samsung,exynos5250-fimd",
-	  .data = &exynos5_fimd_driver_data },
-	{ .compatible = "samsung,exynos5420-fimd",
-	  .data = &exynos5420_fimd_driver_data },
-	{},
+	{
+		.compatible = "samsung,s3c6400-fimd",
+		.data = &s3c64xx_fimd_driver_data,
+	}, {
+		.compatible = "samsung,s5pv210-fimd",
+		.data = &s5pv210_fimd_driver_data,
+	}, {
+		.compatible = "samsung,exynos3250-fimd",
+		.data = &exynos3_fimd_driver_data,
+	}, {
+		.compatible = "samsung,exynos4210-fimd",
+		.data = &exynos4_fimd_driver_data,
+	}, {
+		.compatible = "samsung,exynos5250-fimd",
+		.data = &exynos5_fimd_driver_data,
+	}, {
+		.compatible = "samsung,exynos5420-fimd",
+		.data = &exynos5420_fimd_driver_data,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, fimd_driver_dt_match);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index 280c1a41342a..b7c2527f8c99 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1602,7 +1602,7 @@ static const struct dev_pm_ops g2d_pm_ops = {
 static const struct of_device_id exynos_g2d_match[] = {
 	{ .compatible = "samsung,exynos5250-g2d" },
 	{ .compatible = "samsung,exynos4212-g2d" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, exynos_g2d_match);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_gsc.c b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
index 4a07deeb382b..03a77ea19836 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gsc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gsc.c
@@ -1412,8 +1412,8 @@ static const struct of_device_id exynos_drm_gsc_of_match[] = {
 	}, {
 		.compatible = "samsung,exynos5433-gsc",
 		.data = &gsc_exynos5433_drvdata,
-	}, {
 	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, exynos_drm_gsc_of_match);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_rotator.c b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
index 955ea0cb87b6..21bad17b92a3 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_rotator.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_rotator.c
@@ -441,8 +441,8 @@ static const struct of_device_id exynos_rotator_match[] = {
 	}, {
 		.compatible = "samsung,exynos5250-rotator",
 		.data = &rotator_5250_data,
-	}, {
 	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, exynos_rotator_match);
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_scaler.c b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
index 2bfbafd5c414..8504c69b34c2 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_scaler.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_scaler.c
@@ -712,8 +712,8 @@ static const struct of_device_id exynos_scaler_match[] = {
 	}, {
 		.compatible = "samsung,exynos5433-scaler",
 		.data = &exynos5433_data,
-	}, {
 	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, exynos_scaler_match);
 
diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index d703038e9b91..99e9abdda2be 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1848,9 +1848,8 @@ static const struct of_device_id hdmi_match_types[] = {
 	}, {
 		.compatible = "samsung,exynos5433-hdmi",
 		.data = &exynos5433_hdmi_driver_data,
-	}, {
-		/* end node */
-	}
+	},
+	{ /* end node */ }
 };
 MODULE_DEVICE_TABLE (of, hdmi_match_types);
 
diff --git a/drivers/gpu/drm/exynos/exynos_mixer.c b/drivers/gpu/drm/exynos/exynos_mixer.c
index 9b210ff7449f..9eacf3814aa3 100644
--- a/drivers/gpu/drm/exynos/exynos_mixer.c
+++ b/drivers/gpu/drm/exynos/exynos_mixer.c
@@ -1154,22 +1154,21 @@ static const struct mixer_drv_data exynos4210_mxr_drv_data = {
 static const struct of_device_id mixer_match_types[] = {
 	{
 		.compatible = "samsung,exynos4210-mixer",
-		.data	= &exynos4210_mxr_drv_data,
+		.data = &exynos4210_mxr_drv_data,
 	}, {
 		.compatible = "samsung,exynos4212-mixer",
-		.data	= &exynos4212_mxr_drv_data,
+		.data = &exynos4212_mxr_drv_data,
 	}, {
 		.compatible = "samsung,exynos5-mixer",
-		.data	= &exynos5250_mxr_drv_data,
+		.data = &exynos5250_mxr_drv_data,
 	}, {
 		.compatible = "samsung,exynos5250-mixer",
-		.data	= &exynos5250_mxr_drv_data,
+		.data = &exynos5250_mxr_drv_data,
 	}, {
 		.compatible = "samsung,exynos5420-mixer",
-		.data	= &exynos5420_mxr_drv_data,
-	}, {
-		/* end node */
-	}
+		.data = &exynos5420_mxr_drv_data,
+	},
+	{ /* end node */ }
 };
 MODULE_DEVICE_TABLE(of, mixer_match_types);
 
diff --git a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
index 6709b3b1a3ea..f8e47166e16c 100644
--- a/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
+++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
@@ -250,8 +250,8 @@ static const struct of_device_id fsl_dcu_of_match[] = {
 	}, {
 		.compatible = "fsl,vf610-dcu",
 		.data = &fsl_dcu_vf610_data,
-	}, {
 	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, fsl_dcu_of_match);
 
diff --git a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
index df89a8f18c8f..33061b8d4395 100644
--- a/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
+++ b/drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c
@@ -883,7 +883,7 @@ static void dsi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id dsi_of_match[] = {
-	{.compatible = "hisilicon,hi6220-dsi"},
+	{ .compatible = "hisilicon,hi6220-dsi" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, dsi_of_match);
diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
index 9c154a259153..4e640f05a550 100644
--- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
@@ -296,10 +296,11 @@ static void kirin_drm_platform_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id kirin_drm_dt_ids[] = {
-	{ .compatible = "hisilicon,hi6220-ade",
-	  .data = &ade_driver_data,
+	{
+		.compatible = "hisilicon,hi6220-ade",
+		.data = &ade_driver_data,
 	},
-	{ /* end node */ },
+	{ /* end node */ }
 };
 MODULE_DEVICE_TABLE(of, kirin_drm_dt_ids);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index 055396f85e4a..6b51a5102201 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -1442,7 +1442,7 @@ static bool has_no_display(struct pci_dev *pdev)
 {
 	static const struct pci_device_id ids[] = {
 		INTEL_IVB_Q_IDS(INTEL_VGA_DEVICE, 0),
-		{}
+		{ }
 	};
 
 	return pci_match_id(ids, pdev);
diff --git a/drivers/gpu/drm/i915/display/intel_lpe_audio.c b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
index ff2cf479d8e1..3d92cb307251 100644
--- a/drivers/gpu/drm/i915/display/intel_lpe_audio.c
+++ b/drivers/gpu/drm/i915/display/intel_lpe_audio.c
@@ -185,10 +185,10 @@ static bool lpe_audio_detect(struct intel_display *display)
 	if (display->platform.valleyview || display->platform.cherryview) {
 		static const struct pci_device_id atom_hdaudio_ids[] = {
 			/* Baytrail */
-			{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0f04)},
+			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0f04) },
 			/* Braswell */
-			{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2284)},
-			{}
+			{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2284) },
+			{ }
 		};
 
 		if (!pci_dev_present(atom_hdaudio_ids)) {
diff --git a/drivers/gpu/drm/i915/i915_pci.c b/drivers/gpu/drm/i915/i915_pci.c
index 84a7dc6ab5db..faceb3de4fa3 100644
--- a/drivers/gpu/drm/i915/i915_pci.c
+++ b/drivers/gpu/drm/i915/i915_pci.c
@@ -870,7 +870,7 @@ static const struct pci_device_id pciidlist[] = {
 	INTEL_ATS_M_IDS(INTEL_VGA_DEVICE, &ats_m_info),
 	INTEL_ARL_IDS(INTEL_VGA_DEVICE, &mtl_info),
 	INTEL_MTL_IDS(INTEL_VGA_DEVICE, &mtl_info),
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pciidlist);
 
diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 2d522a8e46ad..e32dc8f5fa19 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1516,7 +1516,7 @@ static const struct of_device_id dt_match[] = {
 		.compatible = "img,img-axe",
 		.data = &pvr_device_data_manual,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dt_match);
 
diff --git a/drivers/gpu/drm/imx/dc/dc-drv.c b/drivers/gpu/drm/imx/dc/dc-drv.c
index 30e2545280e0..55d3016b659f 100644
--- a/drivers/gpu/drm/imx/dc/dc-drv.c
+++ b/drivers/gpu/drm/imx/dc/dc-drv.c
@@ -244,7 +244,7 @@ static const struct dev_pm_ops dc_pm_ops = {
 };
 
 static const struct of_device_id dc_dt_ids[] = {
-	{ .compatible = "fsl,imx8qxp-dc", },
+	{ .compatible = "fsl,imx8qxp-dc" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dc_dt_ids);
diff --git a/drivers/gpu/drm/imx/dc/dc-ic.c b/drivers/gpu/drm/imx/dc/dc-ic.c
index 64f058a466e4..3586d26befab 100644
--- a/drivers/gpu/drm/imx/dc/dc-ic.c
+++ b/drivers/gpu/drm/imx/dc/dc-ic.c
@@ -268,7 +268,7 @@ static const struct dev_pm_ops dc_ic_pm_ops = {
 };
 
 static const struct of_device_id dc_ic_dt_ids[] = {
-	{ .compatible = "fsl,imx8qxp-dc-intc", },
+	{ .compatible = "fsl,imx8qxp-dc-intc" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/imx/dc/dc-pe.c b/drivers/gpu/drm/imx/dc/dc-pe.c
index 718426ccff52..d0ee202b21e9 100644
--- a/drivers/gpu/drm/imx/dc/dc-pe.c
+++ b/drivers/gpu/drm/imx/dc/dc-pe.c
@@ -140,7 +140,7 @@ static const struct dev_pm_ops dc_pe_pm_ops = {
 };
 
 static const struct of_device_id dc_pe_dt_ids[] = {
-	{ .compatible = "fsl,imx8qxp-dc-pixel-engine", },
+	{ .compatible = "fsl,imx8qxp-dc-pixel-engine" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dc_pe_dt_ids);
diff --git a/drivers/gpu/drm/imx/dcss/dcss-drv.c b/drivers/gpu/drm/imx/dcss/dcss-drv.c
index 19c618f6423e..630712992029 100644
--- a/drivers/gpu/drm/imx/dcss/dcss-drv.c
+++ b/drivers/gpu/drm/imx/dcss/dcss-drv.c
@@ -104,8 +104,8 @@ static struct dcss_type_data dcss_types[] = {
 };
 
 static const struct of_device_id dcss_of_match[] = {
-	{ .compatible = "nxp,imx8mq-dcss", .data = &dcss_types[DCSS_IMX8MQ], },
-	{},
+	{ .compatible = "nxp,imx8mq-dcss", .data = &dcss_types[DCSS_IMX8MQ] },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, dcss_of_match);
diff --git a/drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c b/drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c
index 09babdcf3289..893d06b4c965 100644
--- a/drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c
+++ b/drivers/gpu/drm/imx/ipuv3/dw_hdmi-imx.c
@@ -178,13 +178,14 @@ static struct dw_hdmi_plat_data imx6dl_hdmi_drv_data = {
 };
 
 static const struct of_device_id dw_hdmi_imx_dt_ids[] = {
-	{ .compatible = "fsl,imx6q-hdmi",
-	  .data = &imx6q_hdmi_drv_data
+	{
+		.compatible = "fsl,imx6q-hdmi",
+		.data = &imx6q_hdmi_drv_data,
 	}, {
-	  .compatible = "fsl,imx6dl-hdmi",
-	  .data = &imx6dl_hdmi_drv_data
+		.compatible = "fsl,imx6dl-hdmi",
+		.data = &imx6dl_hdmi_drv_data,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dw_hdmi_imx_dt_ids);
 
diff --git a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
index 51a0ec043248..34369626e1ec 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
@@ -336,8 +336,8 @@ static int imx_drm_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(imx_drm_pm_ops, imx_drm_suspend, imx_drm_resume);
 
 static const struct of_device_id imx_drm_dt_ids[] = {
-	{ .compatible = "fsl,imx-display-subsystem", },
-	{ /* sentinel */ },
+	{ .compatible = "fsl,imx-display-subsystem" },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_drm_dt_ids);
 
diff --git a/drivers/gpu/drm/imx/ipuv3/imx-ldb.c b/drivers/gpu/drm/imx/ipuv3/imx-ldb.c
index 523c184aafd4..508f392f5782 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-ldb.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-ldb.c
@@ -464,8 +464,8 @@ static struct bus_mux imx6q_lvds_mux[2] = {
  * entries (in this case fsl,imx53-ldb) need to be ordered last.
  */
 static const struct of_device_id imx_ldb_dt_ids[] = {
-	{ .compatible = "fsl,imx6q-ldb", .data = imx6q_lvds_mux, },
-	{ .compatible = "fsl,imx53-ldb", .data = NULL, },
+	{ .compatible = "fsl,imx6q-ldb", .data = imx6q_lvds_mux },
+	{ .compatible = "fsl,imx53-ldb", .data = NULL },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, imx_ldb_dt_ids);
diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
index a55e1cdd3344..8a15fd8afd65 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
@@ -671,7 +671,7 @@ static void imx_tve_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_tve_dt_ids[] = {
-	{ .compatible = "fsl,imx53-tve", },
+	{ .compatible = "fsl,imx53-tve" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_tve_dt_ids);
diff --git a/drivers/gpu/drm/imx/ipuv3/parallel-display.c b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
index eb75827394f8..354393a16f46 100644
--- a/drivers/gpu/drm/imx/ipuv3/parallel-display.c
+++ b/drivers/gpu/drm/imx/ipuv3/parallel-display.c
@@ -277,7 +277,7 @@ static void imx_pd_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id imx_pd_dt_ids[] = {
-	{ .compatible = "fsl,imx-parallel-display", },
+	{ .compatible = "fsl,imx-parallel-display" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_pd_dt_ids);
diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index 625ec76cf04d..b6916f6fac91 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -1633,7 +1633,7 @@ static const struct of_device_id ingenic_drm_of_match[] = {
 	{ .compatible = "ingenic,jz4760b-lcd", .data = &jz4760b_soc_info },
 	{ .compatible = "ingenic,jz4770-lcd", .data = &jz4770_soc_info },
 	{ .compatible = "ingenic,jz4780-lcd", .data = &jz4780_soc_info },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ingenic_drm_of_match);
 
diff --git a/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c b/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
index 72f8b44998a5..76ca7b9e0165 100644
--- a/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
+++ b/drivers/gpu/drm/ingenic/ingenic-dw-hdmi.c
@@ -67,7 +67,7 @@ static struct dw_hdmi_plat_data ingenic_dw_hdmi_plat_data = {
 
 static const struct of_device_id ingenic_dw_hdmi_dt_ids[] = {
 	{ .compatible = "ingenic,jz4780-dw-hdmi" },
-	{ /* Sentinel */ },
+	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ingenic_dw_hdmi_dt_ids);
 
diff --git a/drivers/gpu/drm/ingenic/ingenic-ipu.c b/drivers/gpu/drm/ingenic/ingenic-ipu.c
index 7f3cc8a75898..81bd2e5ebe22 100644
--- a/drivers/gpu/drm/ingenic/ingenic-ipu.c
+++ b/drivers/gpu/drm/ingenic/ingenic-ipu.c
@@ -985,7 +985,7 @@ static const struct soc_info jz4760_soc_info = {
 static const struct of_device_id ingenic_ipu_of_match[] = {
 	{ .compatible = "ingenic,jz4725b-ipu", .data = &jz4725b_soc_info },
 	{ .compatible = "ingenic,jz4760-ipu", .data = &jz4760_soc_info },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ingenic_ipu_of_match);
 
diff --git a/drivers/gpu/drm/kmb/kmb_drv.c b/drivers/gpu/drm/kmb/kmb_drv.c
index 7c2eb1152fc2..0c306b027e74 100644
--- a/drivers/gpu/drm/kmb/kmb_drv.c
+++ b/drivers/gpu/drm/kmb/kmb_drv.c
@@ -582,8 +582,8 @@ static int kmb_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id kmb_of_match[] = {
-	{.compatible = "intel,keembay-display"},
-	{},
+	{ .compatible = "intel,keembay-display" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, kmb_of_match);
diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 5113d9512464..56fe7b7c411b 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -476,7 +476,7 @@ static const struct lima_compatible lima_mali450_data = {
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "arm,mali-400", .data = &lima_mali400_data },
 	{ .compatible = "arm,mali-450", .data = &lima_mali450_data },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dt_match);
 
diff --git a/drivers/gpu/drm/logicvc/logicvc_drm.c b/drivers/gpu/drm/logicvc/logicvc_drm.c
index bbebf4fc7f51..4dde98f7fe75 100644
--- a/drivers/gpu/drm/logicvc/logicvc_drm.c
+++ b/drivers/gpu/drm/logicvc/logicvc_drm.c
@@ -484,7 +484,7 @@ static void logicvc_drm_shutdown(struct platform_device *pdev)
 static const struct of_device_id logicvc_drm_of_table[] = {
 	{ .compatible = "xylon,logicvc-3.02.a-display" },
 	{ .compatible = "xylon,logicvc-4.01.a-display" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, logicvc_drm_of_table);
 
diff --git a/drivers/gpu/drm/mcde/mcde_drv.c b/drivers/gpu/drm/mcde/mcde_drv.c
index 52c4d2641a14..7dd2b40dcefd 100644
--- a/drivers/gpu/drm/mcde/mcde_drv.c
+++ b/drivers/gpu/drm/mcde/mcde_drv.c
@@ -474,7 +474,7 @@ static const struct of_device_id mcde_of_match[] = {
 	{
 		.compatible = "ste,mcde",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mcde_of_match);
 
diff --git a/drivers/gpu/drm/mcde/mcde_dsi.c b/drivers/gpu/drm/mcde/mcde_dsi.c
index daac8d67913d..b491174c0f25 100644
--- a/drivers/gpu/drm/mcde/mcde_dsi.c
+++ b/drivers/gpu/drm/mcde/mcde_dsi.c
@@ -1200,7 +1200,7 @@ static const struct of_device_id mcde_dsi_of_match[] = {
 	{
 		.compatible = "ste,mcde-dsi",
 	},
-	{},
+	{ }
 };
 
 struct platform_driver mcde_dsi_driver = {
diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
index 0a5856d80f6d..8c48f11f17d5 100644
--- a/drivers/gpu/drm/mediatek/mtk_cec.c
+++ b/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -234,8 +234,8 @@ static void mtk_cec_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_cec_of_ids[] = {
-	{ .compatible = "mediatek,mt8173-cec", },
-	{}
+	{ .compatible = "mediatek,mt8173-cec" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_cec_of_ids);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
index 5f64a0a6e1b2..62151117af40 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
@@ -178,11 +178,15 @@ static const struct mtk_disp_ccorr_data mt8192_ccorr_driver_data = {
 };
 
 static const struct of_device_id mtk_disp_ccorr_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8183-disp-ccorr",
-	  .data = &mt8183_ccorr_driver_data},
-	{ .compatible = "mediatek,mt8192-disp-ccorr",
-	  .data = &mt8192_ccorr_driver_data},
-	{},
+	{
+		.compatible = "mediatek,mt8183-disp-ccorr",
+		.data = &mt8183_ccorr_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8192-disp-ccorr",
+		.data = &mt8192_ccorr_driver_data,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_ccorr_driver_dt_match);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
index 7af9966c036d..64ac0e820c2e 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
@@ -145,13 +145,19 @@ static const struct mtk_disp_color_data mt8173_color_driver_data = {
 };
 
 static const struct of_device_id mtk_disp_color_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt2701-disp-color",
-	  .data = &mt2701_color_driver_data},
-	{ .compatible = "mediatek,mt8167-disp-color",
-	  .data = &mt8167_color_driver_data},
-	{ .compatible = "mediatek,mt8173-disp-color",
-	  .data = &mt8173_color_driver_data},
-	{},
+	{
+		.compatible = "mediatek,mt2701-disp-color",
+		.data = &mt2701_color_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8167-disp-color",
+		.data = &mt8167_color_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8173-disp-color",
+		.data = &mt8173_color_driver_data,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_color_driver_dt_match);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
index 787f68e7d189..c51e087937a6 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
@@ -315,13 +315,19 @@ static const struct mtk_disp_gamma_data mt8195_gamma_driver_data = {
 };
 
 static const struct of_device_id mtk_disp_gamma_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8173-disp-gamma",
-	  .data = &mt8173_gamma_driver_data},
-	{ .compatible = "mediatek,mt8183-disp-gamma",
-	  .data = &mt8183_gamma_driver_data},
-	{ .compatible = "mediatek,mt8195-disp-gamma",
-	  .data = &mt8195_gamma_driver_data},
-	{},
+	{
+		.compatible = "mediatek,mt8173-disp-gamma",
+		.data = &mt8173_gamma_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8183-disp-gamma",
+		.data = &mt8183_gamma_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8195-disp-gamma",
+		.data = &mt8195_gamma_driver_data,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_gamma_driver_dt_match);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_merge.c b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
index 6f00e8cd1b5c..1472f94afccd 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_merge.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_merge.c
@@ -360,8 +360,8 @@ static void mtk_disp_merge_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_disp_merge_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8195-disp-merge", },
-	{},
+	{ .compatible = "mediatek,mt8195-disp-merge" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, mtk_disp_merge_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index 5445870716f9..4e994c25d50d 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -750,23 +750,39 @@ static const struct mtk_disp_ovl_data mt8195_ovl_driver_data = {
 };
 
 static const struct of_device_id mtk_disp_ovl_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt2701-disp-ovl",
-	  .data = &mt2701_ovl_driver_data},
-	{ .compatible = "mediatek,mt8167-disp-ovl",
-	  .data = &mt8167_ovl_driver_data},
-	{ .compatible = "mediatek,mt8173-disp-ovl",
-	  .data = &mt8173_ovl_driver_data},
-	{ .compatible = "mediatek,mt8183-disp-ovl",
-	  .data = &mt8183_ovl_driver_data},
-	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
-	  .data = &mt8183_ovl_2l_driver_data},
-	{ .compatible = "mediatek,mt8192-disp-ovl",
-	  .data = &mt8192_ovl_driver_data},
-	{ .compatible = "mediatek,mt8192-disp-ovl-2l",
-	  .data = &mt8192_ovl_2l_driver_data},
-	{ .compatible = "mediatek,mt8195-disp-ovl",
-	  .data = &mt8195_ovl_driver_data},
-	{},
+	{
+		.compatible = "mediatek,mt2701-disp-ovl",
+		.data = &mt2701_ovl_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8167-disp-ovl",
+		.data = &mt8167_ovl_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8173-disp-ovl",
+		.data = &mt8173_ovl_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8183-disp-ovl",
+		.data = &mt8183_ovl_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8183-disp-ovl-2l",
+		.data = &mt8183_ovl_2l_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8192-disp-ovl",
+		.data = &mt8192_ovl_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8192-disp-ovl-2l",
+		.data = &mt8192_ovl_2l_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8195-disp-ovl",
+		.data = &mt8195_ovl_driver_data,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_ovl_driver_dt_match);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
index 67bd9e1cad59..d27f07e3d537 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
@@ -401,15 +401,23 @@ static const struct mtk_disp_rdma_data mt8195_rdma_driver_data = {
 };
 
 static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt2701-disp-rdma",
-	  .data = &mt2701_rdma_driver_data},
-	{ .compatible = "mediatek,mt8173-disp-rdma",
-	  .data = &mt8173_rdma_driver_data},
-	{ .compatible = "mediatek,mt8183-disp-rdma",
-	  .data = &mt8183_rdma_driver_data},
-	{ .compatible = "mediatek,mt8195-disp-rdma",
-	  .data = &mt8195_rdma_driver_data},
-	{},
+	{
+		.compatible = "mediatek,mt2701-disp-rdma",
+		.data = &mt2701_rdma_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8173-disp-rdma",
+		.data = &mt8173_rdma_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8183-disp-rdma",
+		.data = &mt8183_rdma_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8195-disp-rdma",
+		.data = &mt8195_rdma_driver_data,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_disp_rdma_driver_dt_match);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 974c4fff6fd3..287ba15c9019 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -2945,7 +2945,7 @@ static const struct of_device_id mtk_dp_of_match[] = {
 		.compatible = "mediatek,mt8195-dp-tx",
 		.data = &mt8195_dp_data,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_dp_of_match);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 1bc569dc01a3..1d111b8068e6 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -1347,7 +1347,7 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
 	{ .compatible = "mediatek,mt8192-dpi", .data = &mt8192_conf },
 	{ .compatible = "mediatek,mt8195-dp-intf", .data = &mt8195_dpintf_conf },
 	{ .compatible = "mediatek,mt8195-dpi", .data = &mt8195_conf },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mtk_dpi_of_ids);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index a8bf0690756a..be82708a486b 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -332,34 +332,62 @@ static const struct mtk_mmsys_driver_data mt8365_mmsys_driver_data = {
 };
 
 static const struct of_device_id mtk_drm_of_ids[] = {
-	{ .compatible = "mediatek,mt2701-mmsys",
-	  .data = &mt2701_mmsys_driver_data},
-	{ .compatible = "mediatek,mt7623-mmsys",
-	  .data = &mt7623_mmsys_driver_data},
-	{ .compatible = "mediatek,mt2712-mmsys",
-	  .data = &mt2712_mmsys_driver_data},
-	{ .compatible = "mediatek,mt8167-mmsys",
-	  .data = &mt8167_mmsys_driver_data},
-	{ .compatible = "mediatek,mt8173-mmsys",
-	  .data = &mt8173_mmsys_driver_data},
-	{ .compatible = "mediatek,mt8183-mmsys",
-	  .data = &mt8183_mmsys_driver_data},
-	{ .compatible = "mediatek,mt8186-mmsys",
-	  .data = &mt8186_mmsys_driver_data},
-	{ .compatible = "mediatek,mt8188-vdosys0",
-	  .data = &mt8188_vdosys0_driver_data},
-	{ .compatible = "mediatek,mt8188-vdosys1",
-	  .data = &mt8195_vdosys1_driver_data},
-	{ .compatible = "mediatek,mt8192-mmsys",
-	  .data = &mt8192_mmsys_driver_data},
-	{ .compatible = "mediatek,mt8195-mmsys",
-	  .data = &mt8195_vdosys0_driver_data},
-	{ .compatible = "mediatek,mt8195-vdosys0",
-	  .data = &mt8195_vdosys0_driver_data},
-	{ .compatible = "mediatek,mt8195-vdosys1",
-	  .data = &mt8195_vdosys1_driver_data},
-	{ .compatible = "mediatek,mt8365-mmsys",
-	  .data = &mt8365_mmsys_driver_data},
+	{
+		.compatible = "mediatek,mt2701-mmsys",
+		.data = &mt2701_mmsys_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt7623-mmsys",
+		.data = &mt7623_mmsys_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt2712-mmsys",
+		.data = &mt2712_mmsys_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8167-mmsys",
+		.data = &mt8167_mmsys_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8173-mmsys",
+		.data = &mt8173_mmsys_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8183-mmsys",
+		.data = &mt8183_mmsys_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8186-mmsys",
+		.data = &mt8186_mmsys_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8188-vdosys0",
+		.data = &mt8188_vdosys0_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8188-vdosys1",
+		.data = &mt8195_vdosys1_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8192-mmsys",
+		.data = &mt8192_mmsys_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8195-mmsys",
+		.data = &mt8195_vdosys0_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8195-vdosys0",
+		.data = &mt8195_vdosys0_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8195-vdosys1",
+		.data = &mt8195_vdosys1_driver_data,
+	},
+	{
+		.compatible = "mediatek,mt8365-mmsys",
+		.data = &mt8365_mmsys_driver_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_drm_of_ids);
@@ -704,130 +732,193 @@ static const struct component_master_ops mtk_drm_ops = {
 };
 
 static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
-	{ .compatible = "mediatek,mt8167-disp-aal",
-	  .data = (void *)MTK_DISP_AAL},
-	{ .compatible = "mediatek,mt8173-disp-aal",
-	  .data = (void *)MTK_DISP_AAL},
-	{ .compatible = "mediatek,mt8183-disp-aal",
-	  .data = (void *)MTK_DISP_AAL},
-	{ .compatible = "mediatek,mt8192-disp-aal",
-	  .data = (void *)MTK_DISP_AAL},
-	{ .compatible = "mediatek,mt8167-disp-ccorr",
-	  .data = (void *)MTK_DISP_CCORR },
-	{ .compatible = "mediatek,mt8183-disp-ccorr",
-	  .data = (void *)MTK_DISP_CCORR },
-	{ .compatible = "mediatek,mt8192-disp-ccorr",
-	  .data = (void *)MTK_DISP_CCORR },
-	{ .compatible = "mediatek,mt2701-disp-color",
-	  .data = (void *)MTK_DISP_COLOR },
-	{ .compatible = "mediatek,mt8167-disp-color",
-	  .data = (void *)MTK_DISP_COLOR },
-	{ .compatible = "mediatek,mt8173-disp-color",
-	  .data = (void *)MTK_DISP_COLOR },
-	{ .compatible = "mediatek,mt8167-disp-dither",
-	  .data = (void *)MTK_DISP_DITHER },
-	{ .compatible = "mediatek,mt8183-disp-dither",
-	  .data = (void *)MTK_DISP_DITHER },
-	{ .compatible = "mediatek,mt8195-disp-dsc",
-	  .data = (void *)MTK_DISP_DSC },
-	{ .compatible = "mediatek,mt8167-disp-gamma",
-	  .data = (void *)MTK_DISP_GAMMA, },
-	{ .compatible = "mediatek,mt8173-disp-gamma",
-	  .data = (void *)MTK_DISP_GAMMA, },
-	{ .compatible = "mediatek,mt8183-disp-gamma",
-	  .data = (void *)MTK_DISP_GAMMA, },
-	{ .compatible = "mediatek,mt8195-disp-gamma",
-	  .data = (void *)MTK_DISP_GAMMA, },
-	{ .compatible = "mediatek,mt8195-disp-merge",
-	  .data = (void *)MTK_DISP_MERGE },
-	{ .compatible = "mediatek,mt2701-disp-mutex",
-	  .data = (void *)MTK_DISP_MUTEX },
-	{ .compatible = "mediatek,mt2712-disp-mutex",
-	  .data = (void *)MTK_DISP_MUTEX },
-	{ .compatible = "mediatek,mt8167-disp-mutex",
-	  .data = (void *)MTK_DISP_MUTEX },
-	{ .compatible = "mediatek,mt8173-disp-mutex",
-	  .data = (void *)MTK_DISP_MUTEX },
-	{ .compatible = "mediatek,mt8183-disp-mutex",
-	  .data = (void *)MTK_DISP_MUTEX },
-	{ .compatible = "mediatek,mt8186-disp-mutex",
-	  .data = (void *)MTK_DISP_MUTEX },
-	{ .compatible = "mediatek,mt8188-disp-mutex",
-	  .data = (void *)MTK_DISP_MUTEX },
-	{ .compatible = "mediatek,mt8192-disp-mutex",
-	  .data = (void *)MTK_DISP_MUTEX },
-	{ .compatible = "mediatek,mt8195-disp-mutex",
-	  .data = (void *)MTK_DISP_MUTEX },
-	{ .compatible = "mediatek,mt8365-disp-mutex",
-	  .data = (void *)MTK_DISP_MUTEX },
-	{ .compatible = "mediatek,mt8173-disp-od",
-	  .data = (void *)MTK_DISP_OD },
-	{ .compatible = "mediatek,mt2701-disp-ovl",
-	  .data = (void *)MTK_DISP_OVL },
-	{ .compatible = "mediatek,mt8167-disp-ovl",
-	  .data = (void *)MTK_DISP_OVL },
-	{ .compatible = "mediatek,mt8173-disp-ovl",
-	  .data = (void *)MTK_DISP_OVL },
-	{ .compatible = "mediatek,mt8183-disp-ovl",
-	  .data = (void *)MTK_DISP_OVL },
-	{ .compatible = "mediatek,mt8192-disp-ovl",
-	  .data = (void *)MTK_DISP_OVL },
-	{ .compatible = "mediatek,mt8195-disp-ovl",
-	  .data = (void *)MTK_DISP_OVL },
-	{ .compatible = "mediatek,mt8183-disp-ovl-2l",
-	  .data = (void *)MTK_DISP_OVL_2L },
-	{ .compatible = "mediatek,mt8192-disp-ovl-2l",
-	  .data = (void *)MTK_DISP_OVL_2L },
-	{ .compatible = "mediatek,mt8192-disp-postmask",
-	  .data = (void *)MTK_DISP_POSTMASK },
-	{ .compatible = "mediatek,mt2701-disp-pwm",
-	  .data = (void *)MTK_DISP_BLS },
-	{ .compatible = "mediatek,mt8167-disp-pwm",
-	  .data = (void *)MTK_DISP_PWM },
-	{ .compatible = "mediatek,mt8173-disp-pwm",
-	  .data = (void *)MTK_DISP_PWM },
-	{ .compatible = "mediatek,mt2701-disp-rdma",
-	  .data = (void *)MTK_DISP_RDMA },
-	{ .compatible = "mediatek,mt8167-disp-rdma",
-	  .data = (void *)MTK_DISP_RDMA },
-	{ .compatible = "mediatek,mt8173-disp-rdma",
-	  .data = (void *)MTK_DISP_RDMA },
-	{ .compatible = "mediatek,mt8183-disp-rdma",
-	  .data = (void *)MTK_DISP_RDMA },
-	{ .compatible = "mediatek,mt8195-disp-rdma",
-	  .data = (void *)MTK_DISP_RDMA },
-	{ .compatible = "mediatek,mt8173-disp-ufoe",
-	  .data = (void *)MTK_DISP_UFOE },
-	{ .compatible = "mediatek,mt8173-disp-wdma",
-	  .data = (void *)MTK_DISP_WDMA },
-	{ .compatible = "mediatek,mt2701-dpi",
-	  .data = (void *)MTK_DPI },
-	{ .compatible = "mediatek,mt8167-dsi",
-	  .data = (void *)MTK_DSI },
-	{ .compatible = "mediatek,mt8173-dpi",
-	  .data = (void *)MTK_DPI },
-	{ .compatible = "mediatek,mt8183-dpi",
-	  .data = (void *)MTK_DPI },
-	{ .compatible = "mediatek,mt8186-dpi",
-	  .data = (void *)MTK_DPI },
-	{ .compatible = "mediatek,mt8188-dp-intf",
-	  .data = (void *)MTK_DP_INTF },
-	{ .compatible = "mediatek,mt8192-dpi",
-	  .data = (void *)MTK_DPI },
-	{ .compatible = "mediatek,mt8195-dp-intf",
-	  .data = (void *)MTK_DP_INTF },
-	{ .compatible = "mediatek,mt8195-dpi",
-	  .data = (void *)MTK_DPI },
-	{ .compatible = "mediatek,mt2701-dsi",
-	  .data = (void *)MTK_DSI },
-	{ .compatible = "mediatek,mt8173-dsi",
-	  .data = (void *)MTK_DSI },
-	{ .compatible = "mediatek,mt8183-dsi",
-	  .data = (void *)MTK_DSI },
-	{ .compatible = "mediatek,mt8186-dsi",
-	  .data = (void *)MTK_DSI },
-	{ .compatible = "mediatek,mt8188-dsi",
-	  .data = (void *)MTK_DSI },
+	{
+		.compatible = "mediatek,mt8167-disp-aal",
+		.data = (void *)MTK_DISP_AAL,
+	}, {
+		.compatible = "mediatek,mt8173-disp-aal",
+		.data = (void *)MTK_DISP_AAL,
+	}, {
+		.compatible = "mediatek,mt8183-disp-aal",
+		.data = (void *)MTK_DISP_AAL,
+	}, {
+		.compatible = "mediatek,mt8192-disp-aal",
+		.data = (void *)MTK_DISP_AAL,
+	}, {
+		.compatible = "mediatek,mt8167-disp-ccorr",
+		.data = (void *)MTK_DISP_CCORR,
+	}, {
+		.compatible = "mediatek,mt8183-disp-ccorr",
+		.data = (void *)MTK_DISP_CCORR,
+	}, {
+		.compatible = "mediatek,mt8192-disp-ccorr",
+		.data = (void *)MTK_DISP_CCORR,
+	}, {
+		.compatible = "mediatek,mt2701-disp-color",
+		.data = (void *)MTK_DISP_COLOR,
+	}, {
+		.compatible = "mediatek,mt8167-disp-color",
+		.data = (void *)MTK_DISP_COLOR,
+	}, {
+		.compatible = "mediatek,mt8173-disp-color",
+		.data = (void *)MTK_DISP_COLOR,
+	}, {
+		.compatible = "mediatek,mt8167-disp-dither",
+		.data = (void *)MTK_DISP_DITHER,
+	}, {
+		.compatible = "mediatek,mt8183-disp-dither",
+		.data = (void *)MTK_DISP_DITHER,
+	}, {
+		.compatible = "mediatek,mt8195-disp-dsc",
+		.data = (void *)MTK_DISP_DSC,
+	}, {
+		.compatible = "mediatek,mt8167-disp-gamma",
+		.data = (void *)MTK_DISP_GAMMA,
+	}, {
+		.compatible = "mediatek,mt8173-disp-gamma",
+		.data = (void *)MTK_DISP_GAMMA,
+	}, {
+		.compatible = "mediatek,mt8183-disp-gamma",
+		.data = (void *)MTK_DISP_GAMMA,
+	}, {
+		.compatible = "mediatek,mt8195-disp-gamma",
+		.data = (void *)MTK_DISP_GAMMA,
+	}, {
+		.compatible = "mediatek,mt8195-disp-merge",
+		.data = (void *)MTK_DISP_MERGE,
+	}, {
+		.compatible = "mediatek,mt2701-disp-mutex",
+		.data = (void *)MTK_DISP_MUTEX,
+	}, {
+		.compatible = "mediatek,mt2712-disp-mutex",
+		.data = (void *)MTK_DISP_MUTEX,
+	}, {
+		.compatible = "mediatek,mt8167-disp-mutex",
+		.data = (void *)MTK_DISP_MUTEX,
+	}, {
+		.compatible = "mediatek,mt8173-disp-mutex",
+		.data = (void *)MTK_DISP_MUTEX,
+	}, {
+		.compatible = "mediatek,mt8183-disp-mutex",
+		.data = (void *)MTK_DISP_MUTEX,
+	}, {
+		.compatible = "mediatek,mt8186-disp-mutex",
+		.data = (void *)MTK_DISP_MUTEX,
+	}, {
+		.compatible = "mediatek,mt8188-disp-mutex",
+		.data = (void *)MTK_DISP_MUTEX,
+	}, {
+		.compatible = "mediatek,mt8192-disp-mutex",
+		.data = (void *)MTK_DISP_MUTEX,
+	}, {
+		.compatible = "mediatek,mt8195-disp-mutex",
+		.data = (void *)MTK_DISP_MUTEX,
+	}, {
+		.compatible = "mediatek,mt8365-disp-mutex",
+		.data = (void *)MTK_DISP_MUTEX,
+	}, {
+		.compatible = "mediatek,mt8173-disp-od",
+		.data = (void *)MTK_DISP_OD,
+	}, {
+		.compatible = "mediatek,mt2701-disp-ovl",
+		.data = (void *)MTK_DISP_OVL,
+	}, {
+		.compatible = "mediatek,mt8167-disp-ovl",
+		.data = (void *)MTK_DISP_OVL,
+	}, {
+		.compatible = "mediatek,mt8173-disp-ovl",
+		.data = (void *)MTK_DISP_OVL,
+	}, {
+		.compatible = "mediatek,mt8183-disp-ovl",
+		.data = (void *)MTK_DISP_OVL,
+	}, {
+		.compatible = "mediatek,mt8192-disp-ovl",
+		.data = (void *)MTK_DISP_OVL,
+	}, {
+		.compatible = "mediatek,mt8195-disp-ovl",
+		.data = (void *)MTK_DISP_OVL,
+	}, {
+		.compatible = "mediatek,mt8183-disp-ovl-2l",
+		.data = (void *)MTK_DISP_OVL_2L,
+	}, {
+		.compatible = "mediatek,mt8192-disp-ovl-2l",
+		.data = (void *)MTK_DISP_OVL_2L,
+	}, {
+		.compatible = "mediatek,mt8192-disp-postmask",
+		.data = (void *)MTK_DISP_POSTMASK,
+	}, {
+		.compatible = "mediatek,mt2701-disp-pwm",
+		.data = (void *)MTK_DISP_BLS,
+	}, {
+		.compatible = "mediatek,mt8167-disp-pwm",
+		.data = (void *)MTK_DISP_PWM,
+	}, {
+		.compatible = "mediatek,mt8173-disp-pwm",
+		.data = (void *)MTK_DISP_PWM,
+	}, {
+		.compatible = "mediatek,mt2701-disp-rdma",
+		.data = (void *)MTK_DISP_RDMA,
+	}, {
+		.compatible = "mediatek,mt8167-disp-rdma",
+		.data = (void *)MTK_DISP_RDMA,
+	}, {
+		.compatible = "mediatek,mt8173-disp-rdma",
+		.data = (void *)MTK_DISP_RDMA,
+	}, {
+		.compatible = "mediatek,mt8183-disp-rdma",
+		.data = (void *)MTK_DISP_RDMA,
+	}, {
+		.compatible = "mediatek,mt8195-disp-rdma",
+		.data = (void *)MTK_DISP_RDMA,
+	}, {
+		.compatible = "mediatek,mt8173-disp-ufoe",
+		.data = (void *)MTK_DISP_UFOE,
+	}, {
+		.compatible = "mediatek,mt8173-disp-wdma",
+		.data = (void *)MTK_DISP_WDMA,
+	}, {
+		.compatible = "mediatek,mt2701-dpi",
+		.data = (void *)MTK_DPI,
+	}, {
+		.compatible = "mediatek,mt8167-dsi",
+		.data = (void *)MTK_DSI,
+	}, {
+		.compatible = "mediatek,mt8173-dpi",
+		.data = (void *)MTK_DPI,
+	}, {
+		.compatible = "mediatek,mt8183-dpi",
+		.data = (void *)MTK_DPI,
+	}, {
+		.compatible = "mediatek,mt8186-dpi",
+		.data = (void *)MTK_DPI,
+	}, {
+		.compatible = "mediatek,mt8188-dp-intf",
+		.data = (void *)MTK_DP_INTF,
+	}, {
+		.compatible = "mediatek,mt8192-dpi",
+		.data = (void *)MTK_DPI,
+	}, {
+		.compatible = "mediatek,mt8195-dp-intf",
+		.data = (void *)MTK_DP_INTF,
+	}, {
+		.compatible = "mediatek,mt8195-dpi",
+		.data = (void *)MTK_DPI,
+	}, {
+		.compatible = "mediatek,mt2701-dsi",
+		.data = (void *)MTK_DSI,
+	}, {
+		.compatible = "mediatek,mt8173-dsi",
+		.data = (void *)MTK_DSI,
+	}, {
+		.compatible = "mediatek,mt8183-dsi",
+		.data = (void *)MTK_DSI,
+	}, {
+		.compatible = "mediatek,mt8186-dsi",
+		.data = (void *)MTK_DSI,
+	}, {
+		.compatible = "mediatek,mt8188-dsi",
+		.data = (void *)MTK_DSI,
+	},
 	{ }
 };
 
diff --git a/drivers/gpu/drm/mediatek/mtk_ethdr.c b/drivers/gpu/drm/mediatek/mtk_ethdr.c
index 4ba3b7b4b110..4085e9d82dbb 100644
--- a/drivers/gpu/drm/mediatek/mtk_ethdr.c
+++ b/drivers/gpu/drm/mediatek/mtk_ethdr.c
@@ -380,8 +380,8 @@ static void mtk_ethdr_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_ethdr_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8195-disp-ethdr"},
-	{},
+	{ .compatible = "mediatek,mt8195-disp-ethdr" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, mtk_ethdr_driver_dt_match);
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
index c4fb4e209461..8b32dcfd9e29 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
@@ -323,8 +323,8 @@ static void mtk_hdmi_ddc_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_hdmi_ddc_match[] = {
-	{ .compatible = "mediatek,mt8173-hdmi-ddc", },
-	{},
+	{ .compatible = "mediatek,mt8173-hdmi-ddc" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_hdmi_ddc_match);
 
diff --git a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
index fa53511f461d..6009eef57df6 100644
--- a/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
+++ b/drivers/gpu/drm/mediatek/mtk_mdp_rdma.c
@@ -331,8 +331,8 @@ static void mtk_mdp_rdma_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_mdp_rdma_driver_dt_match[] = {
-	{ .compatible = "mediatek,mt8195-vdo1-rdma", },
-	{},
+	{ .compatible = "mediatek,mt8195-vdo1-rdma" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mtk_mdp_rdma_driver_dt_match);
 
diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 920e43b93d09..28b390489f58 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -473,7 +473,7 @@ static const struct of_device_id components_dev_match[] = {
 	{ .compatible = "amlogic,meson-gxl-dw-hdmi" },
 	{ .compatible = "amlogic,meson-gxm-dw-hdmi" },
 	{ .compatible = "amlogic,meson-g12a-dw-hdmi" },
-	{}
+	{ }
 };
 
 static int meson_drv_probe(struct platform_device *pdev)
@@ -542,15 +542,23 @@ static struct meson_drm_match_data meson_drm_g12a_data = {
 };
 
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "amlogic,meson-gxbb-vpu",
-	  .data       = (void *)&meson_drm_gxbb_data },
-	{ .compatible = "amlogic,meson-gxl-vpu",
-	  .data       = (void *)&meson_drm_gxl_data },
-	{ .compatible = "amlogic,meson-gxm-vpu",
-	  .data       = (void *)&meson_drm_gxm_data },
-	{ .compatible = "amlogic,meson-g12a-vpu",
-	  .data       = (void *)&meson_drm_g12a_data },
-	{}
+	{
+		.compatible = "amlogic,meson-gxbb-vpu",
+		.data = (void *)&meson_drm_gxbb_data,
+	},
+	{
+		.compatible = "amlogic,meson-gxl-vpu",
+		.data = (void *)&meson_drm_gxl_data,
+	},
+	{
+		.compatible = "amlogic,meson-gxm-vpu",
+		.data = (void *)&meson_drm_gxm_data,
+	},
+	{
+		.compatible = "amlogic,meson-g12a-vpu",
+		.data = (void *)&meson_drm_g12a_data,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dt_match);
 
diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index eb33c70f29c3..e49404ae9132 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -845,14 +845,22 @@ static const struct dev_pm_ops meson_dw_hdmi_pm_ops = {
 };
 
 static const struct of_device_id meson_dw_hdmi_of_table[] = {
-	{ .compatible = "amlogic,meson-gxbb-dw-hdmi",
-	  .data = &meson_dw_hdmi_gxbb_data },
-	{ .compatible = "amlogic,meson-gxl-dw-hdmi",
-	  .data = &meson_dw_hdmi_gxl_data },
-	{ .compatible = "amlogic,meson-gxm-dw-hdmi",
-	  .data = &meson_dw_hdmi_gxl_data },
-	{ .compatible = "amlogic,meson-g12a-dw-hdmi",
-	  .data = &meson_dw_hdmi_g12a_data },
+	{
+		.compatible = "amlogic,meson-gxbb-dw-hdmi",
+		.data = &meson_dw_hdmi_gxbb_data,
+	},
+	{
+		.compatible = "amlogic,meson-gxl-dw-hdmi",
+		.data = &meson_dw_hdmi_gxl_data,
+	},
+	{
+		.compatible = "amlogic,meson-gxm-dw-hdmi",
+		.data = &meson_dw_hdmi_gxl_data,
+	},
+	{
+		.compatible = "amlogic,meson-g12a-dw-hdmi",
+		.data = &meson_dw_hdmi_g12a_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, meson_dw_hdmi_of_table);
diff --git a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
index c27a64bd1529..9f037a5bd7f3 100644
--- a/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
+++ b/drivers/gpu/drm/meson/meson_dw_mipi_dsi.c
@@ -335,7 +335,7 @@ static void meson_dw_mipi_dsi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id meson_dw_mipi_dsi_of_table[] = {
-	{ .compatible = "amlogic,meson-g12a-dw-mipi-dsi", },
+	{ .compatible = "amlogic,meson-g12a-dw-mipi-dsi" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, meson_dw_mipi_dsi_of_table);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7108d4aa59b5..1899835a0e5c 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -302,7 +302,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "amd,imageon" },
 	/* for backwards compat w/ downstream kgsl DT files: */
 	{ .compatible = "qcom,kgsl-3d0" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dt_match);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 1b6286dccfc0..0da88ba8fcf5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -1480,41 +1480,41 @@ static const struct dev_pm_ops dpu_pm_ops = {
 };
 
 static const struct of_device_id dpu_dt_match[] = {
-	{ .compatible = "qcom,eliza-dpu", .data = &dpu_eliza_cfg, },
-	{ .compatible = "qcom,glymur-dpu", .data = &dpu_glymur_cfg, },
-	{ .compatible = "qcom,kaanapali-dpu", .data = &dpu_kaanapali_cfg, },
-	{ .compatible = "qcom,milos-dpu", .data = &dpu_milos_cfg, },
-	{ .compatible = "qcom,msm8917-mdp5", .data = &dpu_msm8917_cfg, },
-	{ .compatible = "qcom,msm8937-mdp5", .data = &dpu_msm8937_cfg, },
-	{ .compatible = "qcom,msm8953-mdp5", .data = &dpu_msm8953_cfg, },
-	{ .compatible = "qcom,msm8996-mdp5", .data = &dpu_msm8996_cfg, },
-	{ .compatible = "qcom,msm8998-dpu", .data = &dpu_msm8998_cfg, },
-	{ .compatible = "qcom,qcm2290-dpu", .data = &dpu_qcm2290_cfg, },
-	{ .compatible = "qcom,sa8775p-dpu", .data = &dpu_sa8775p_cfg, },
-	{ .compatible = "qcom,sar2130p-dpu", .data = &dpu_sar2130p_cfg, },
-	{ .compatible = "qcom,sdm630-mdp5", .data = &dpu_sdm630_cfg, },
-	{ .compatible = "qcom,sdm660-mdp5", .data = &dpu_sdm660_cfg, },
-	{ .compatible = "qcom,sdm670-dpu", .data = &dpu_sdm670_cfg, },
-	{ .compatible = "qcom,sdm845-dpu", .data = &dpu_sdm845_cfg, },
-	{ .compatible = "qcom,sc7180-dpu", .data = &dpu_sc7180_cfg, },
-	{ .compatible = "qcom,sc7280-dpu", .data = &dpu_sc7280_cfg, },
-	{ .compatible = "qcom,sc8180x-dpu", .data = &dpu_sc8180x_cfg, },
-	{ .compatible = "qcom,sc8280xp-dpu", .data = &dpu_sc8280xp_cfg, },
-	{ .compatible = "qcom,sm6115-dpu", .data = &dpu_sm6115_cfg, },
-	{ .compatible = "qcom,sm6125-dpu", .data = &dpu_sm6125_cfg, },
-	{ .compatible = "qcom,sm6150-dpu", .data = &dpu_sm6150_cfg, },
-	{ .compatible = "qcom,sm6350-dpu", .data = &dpu_sm6350_cfg, },
-	{ .compatible = "qcom,sm6375-dpu", .data = &dpu_sm6375_cfg, },
-	{ .compatible = "qcom,sm7150-dpu", .data = &dpu_sm7150_cfg, },
-	{ .compatible = "qcom,sm8150-dpu", .data = &dpu_sm8150_cfg, },
-	{ .compatible = "qcom,sm8250-dpu", .data = &dpu_sm8250_cfg, },
-	{ .compatible = "qcom,sm8350-dpu", .data = &dpu_sm8350_cfg, },
-	{ .compatible = "qcom,sm8450-dpu", .data = &dpu_sm8450_cfg, },
-	{ .compatible = "qcom,sm8550-dpu", .data = &dpu_sm8550_cfg, },
-	{ .compatible = "qcom,sm8650-dpu", .data = &dpu_sm8650_cfg, },
-	{ .compatible = "qcom,sm8750-dpu", .data = &dpu_sm8750_cfg, },
-	{ .compatible = "qcom,x1e80100-dpu", .data = &dpu_x1e80100_cfg, },
-	{}
+	{ .compatible = "qcom,eliza-dpu", .data = &dpu_eliza_cfg },
+	{ .compatible = "qcom,glymur-dpu", .data = &dpu_glymur_cfg },
+	{ .compatible = "qcom,kaanapali-dpu", .data = &dpu_kaanapali_cfg },
+	{ .compatible = "qcom,milos-dpu", .data = &dpu_milos_cfg },
+	{ .compatible = "qcom,msm8917-mdp5", .data = &dpu_msm8917_cfg },
+	{ .compatible = "qcom,msm8937-mdp5", .data = &dpu_msm8937_cfg },
+	{ .compatible = "qcom,msm8953-mdp5", .data = &dpu_msm8953_cfg },
+	{ .compatible = "qcom,msm8996-mdp5", .data = &dpu_msm8996_cfg },
+	{ .compatible = "qcom,msm8998-dpu", .data = &dpu_msm8998_cfg },
+	{ .compatible = "qcom,qcm2290-dpu", .data = &dpu_qcm2290_cfg },
+	{ .compatible = "qcom,sa8775p-dpu", .data = &dpu_sa8775p_cfg },
+	{ .compatible = "qcom,sar2130p-dpu", .data = &dpu_sar2130p_cfg },
+	{ .compatible = "qcom,sdm630-mdp5", .data = &dpu_sdm630_cfg },
+	{ .compatible = "qcom,sdm660-mdp5", .data = &dpu_sdm660_cfg },
+	{ .compatible = "qcom,sdm670-dpu", .data = &dpu_sdm670_cfg },
+	{ .compatible = "qcom,sdm845-dpu", .data = &dpu_sdm845_cfg },
+	{ .compatible = "qcom,sc7180-dpu", .data = &dpu_sc7180_cfg },
+	{ .compatible = "qcom,sc7280-dpu", .data = &dpu_sc7280_cfg },
+	{ .compatible = "qcom,sc8180x-dpu", .data = &dpu_sc8180x_cfg },
+	{ .compatible = "qcom,sc8280xp-dpu", .data = &dpu_sc8280xp_cfg },
+	{ .compatible = "qcom,sm6115-dpu", .data = &dpu_sm6115_cfg },
+	{ .compatible = "qcom,sm6125-dpu", .data = &dpu_sm6125_cfg },
+	{ .compatible = "qcom,sm6150-dpu", .data = &dpu_sm6150_cfg },
+	{ .compatible = "qcom,sm6350-dpu", .data = &dpu_sm6350_cfg },
+	{ .compatible = "qcom,sm6375-dpu", .data = &dpu_sm6375_cfg },
+	{ .compatible = "qcom,sm7150-dpu", .data = &dpu_sm7150_cfg },
+	{ .compatible = "qcom,sm8150-dpu", .data = &dpu_sm8150_cfg },
+	{ .compatible = "qcom,sm8250-dpu", .data = &dpu_sm8250_cfg },
+	{ .compatible = "qcom,sm8350-dpu", .data = &dpu_sm8350_cfg },
+	{ .compatible = "qcom,sm8450-dpu", .data = &dpu_sm8450_cfg },
+	{ .compatible = "qcom,sm8550-dpu", .data = &dpu_sm8550_cfg },
+	{ .compatible = "qcom,sm8650-dpu", .data = &dpu_sm8650_cfg },
+	{ .compatible = "qcom,sm8750-dpu", .data = &dpu_sm8750_cfg },
+	{ .compatible = "qcom,x1e80100-dpu", .data = &dpu_x1e80100_cfg },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dpu_dt_match);
 
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index ff6751b2ae62..b2012cfe0528 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -896,10 +896,10 @@ static const struct dev_pm_ops mdp5_pm_ops = {
 };
 
 static const struct of_device_id mdp5_dt_match[] = {
-	{ .compatible = "qcom,mdp5", },
+	{ .compatible = "qcom,mdp5" },
 	/* to support downstream DT files */
-	{ .compatible = "qcom,mdss_mdp", },
-	{}
+	{ .compatible = "qcom,mdss_mdp" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mdp5_dt_match);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c0c150e2c575..f54c8ea6b9eb 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -180,7 +180,7 @@ static const struct of_device_id msm_dp_dt_match[] = {
 	{ .compatible = "qcom,sm8350-dp", .data = &msm_dp_desc_sc7180 },
 	{ .compatible = "qcom,sm8650-dp", .data = &msm_dp_desc_sm8650 },
 	{ .compatible = "qcom,x1e80100-dp", .data = &msm_dp_desc_x1e80100 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, msm_dp_dt_match);
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 090726be5061..c9d9c297b8ef 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -198,7 +198,7 @@ static const struct of_device_id dt_match[] = {
 
 	/* Deprecated, don't use */
 	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dt_match);
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 133b4b1f17ab..e23d7ad452b1 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -455,7 +455,7 @@ static const struct of_device_id msm_hdmi_dt_match[] = {
 	{ .compatible = "qcom,hdmi-tx-8974", .data = &hdmi_tx_8974_config },
 	{ .compatible = "qcom,hdmi-tx-8960", .data = &hdmi_tx_8960_config },
 	{ .compatible = "qcom,hdmi-tx-8660", .data = &hdmi_tx_8960_config },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, msm_hdmi_dt_match);
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index c805724dfda7..b2872890c21b 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -204,19 +204,31 @@ static void msm_hdmi_phy_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id msm_hdmi_phy_dt_match[] = {
-	{ .compatible = "qcom,hdmi-phy-8660",
-	  .data = &msm_hdmi_phy_8x60_cfg },
-	{ .compatible = "qcom,hdmi-phy-8960",
-	  .data = &msm_hdmi_phy_8960_cfg },
-	{ .compatible = "qcom,hdmi-phy-8974",
-	  .data = &msm_hdmi_phy_8x74_cfg },
-	{ .compatible = "qcom,hdmi-phy-8084",
-	  .data = &msm_hdmi_phy_8x74_cfg },
-	{ .compatible = "qcom,hdmi-phy-8996",
-	  .data = &msm_hdmi_phy_8996_cfg },
-	{ .compatible = "qcom,hdmi-phy-8998",
-	  .data = &msm_hdmi_phy_8998_cfg },
-	{}
+	{
+		.compatible = "qcom,hdmi-phy-8660",
+		.data = &msm_hdmi_phy_8x60_cfg,
+	},
+	{
+		.compatible = "qcom,hdmi-phy-8960",
+		.data = &msm_hdmi_phy_8960_cfg,
+	},
+	{
+		.compatible = "qcom,hdmi-phy-8974",
+		.data = &msm_hdmi_phy_8x74_cfg,
+	},
+	{
+		.compatible = "qcom,hdmi-phy-8084",
+		.data = &msm_hdmi_phy_8x74_cfg,
+	},
+	{
+		.compatible = "qcom,hdmi-phy-8996",
+		.data = &msm_hdmi_phy_8996_cfg,
+	},
+	{
+		.compatible = "qcom,hdmi-phy-8998",
+		.data = &msm_hdmi_phy_8998_cfg,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, msm_hdmi_phy_dt_match);
 
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 3675df277f6a..51c4753cd852 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -1091,7 +1091,7 @@ static const struct of_device_id msm_gpu_match[] = {
 	{ .compatible = "qcom,adreno-3xx" },
 	{ .compatible = "amd,imageon" },
 	{ .compatible = "qcom,kgsl-3d0" },
-	{ },
+	{ }
 };
 
 static int add_gpu_components(struct device *dev,
diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 259d362475c8..5dc7b670b8ad 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -572,7 +572,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,sm8750-mdss", .data = &data_57k },
 	/* TODO: x1e8: Add reg_bus_bw with real value */
 	{ .compatible = "qcom,x1e80100-mdss", .data = &data_153k6 },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mdss_dt_match);
 
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 66dca07d090f..cd5f556a24f3 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -381,9 +381,9 @@ static const struct drm_driver mxsfb_driver = {
 };
 
 static const struct of_device_id mxsfb_dt_ids[] = {
-	{ .compatible = "fsl,imx23-lcdif", .data = &mxsfb_devdata[MXSFB_V3], },
-	{ .compatible = "fsl,imx28-lcdif", .data = &mxsfb_devdata[MXSFB_V4], },
-	{ .compatible = "fsl,imx6sx-lcdif", .data = &mxsfb_devdata[MXSFB_V6], },
+	{ .compatible = "fsl,imx23-lcdif", .data = &mxsfb_devdata[MXSFB_V3] },
+	{ .compatible = "fsl,imx28-lcdif", .data = &mxsfb_devdata[MXSFB_V4] },
+	{ .compatible = "fsl,imx6sx-lcdif", .data = &mxsfb_devdata[MXSFB_V6] },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, mxsfb_dt_ids);
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 30311688618c..9bcf37a81584 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -1447,7 +1447,7 @@ nouveau_drm_pci_table[] = {
 		.class = PCI_BASE_CLASS_DISPLAY << 16,
 		.class_mask  = 0xff << 16,
 	},
-	{}
+	{ }
 };
 
 static void nouveau_display_options(void)
diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
index 2a23b4c59c29..b96d1c1c76c4 100644
--- a/drivers/gpu/drm/omapdrm/dss/dispc.c
+++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
@@ -4580,7 +4580,7 @@ static const struct of_device_id dispc_of_match[] = {
 	{ .compatible = "ti,omap4-dispc", .data = &omap44xx_dispc_feats },
 	{ .compatible = "ti,omap5-dispc", .data = &omap54xx_dispc_feats },
 	{ .compatible = "ti,dra7-dispc",  .data = &omap54xx_dispc_feats },
-	{},
+	{ }
 };
 
 static const struct soc_device_attribute dispc_soc_devices[] = {
diff --git a/drivers/gpu/drm/omapdrm/dss/dsi.c b/drivers/gpu/drm/omapdrm/dss/dsi.c
index 838b34ea7e31..fa915343c45f 100644
--- a/drivers/gpu/drm/omapdrm/dss/dsi.c
+++ b/drivers/gpu/drm/omapdrm/dss/dsi.c
@@ -4853,10 +4853,10 @@ static const struct dsi_of_data dsi_of_data_omap5 = {
 };
 
 static const struct of_device_id dsi_of_match[] = {
-	{ .compatible = "ti,omap3-dsi", .data = &dsi_of_data_omap36xx, },
-	{ .compatible = "ti,omap4-dsi", .data = &dsi_of_data_omap4, },
-	{ .compatible = "ti,omap5-dsi", .data = &dsi_of_data_omap5, },
-	{},
+	{ .compatible = "ti,omap3-dsi", .data = &dsi_of_data_omap36xx },
+	{ .compatible = "ti,omap4-dsi", .data = &dsi_of_data_omap4 },
+	{ .compatible = "ti,omap5-dsi", .data = &dsi_of_data_omap5 },
+	{ }
 };
 
 static const struct soc_device_attribute dsi_soc_devices[] = {
diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
index 53b7938a3d05..fbefb2cd0b52 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss.c
@@ -1291,7 +1291,7 @@ static const struct of_device_id dss_of_match[] = {
 	{ .compatible = "ti,omap4-dss", .data = &omap44xx_dss_feats },
 	{ .compatible = "ti,omap5-dss", .data = &omap54xx_dss_feats },
 	{ .compatible = "ti,dra7-dss",  .data = &dra7xx_dss_feats },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dss_of_match);
 
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index ea0d749265d1..5516a3efc266 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -861,8 +861,8 @@ static void hdmi4_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id hdmi_of_match[] = {
-	{ .compatible = "ti,omap4-hdmi", },
-	{},
+	{ .compatible = "ti,omap4-hdmi" },
+	{ }
 };
 
 struct platform_driver omapdss_hdmi4hw_driver = {
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi5.c b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
index 216281a884bd..e328e6715694 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi5.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi5.c
@@ -830,9 +830,9 @@ static void hdmi5_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id hdmi_of_match[] = {
-	{ .compatible = "ti,omap5-hdmi", },
-	{ .compatible = "ti,dra7-hdmi", },
-	{},
+	{ .compatible = "ti,omap5-hdmi" },
+	{ .compatible = "ti,dra7-hdmi" },
+	{ }
 };
 
 struct platform_driver omapdss_hdmi5hw_driver = {
diff --git a/drivers/gpu/drm/omapdrm/dss/venc.c b/drivers/gpu/drm/omapdrm/dss/venc.c
index 5416c668a205..a68a12a613f5 100644
--- a/drivers/gpu/drm/omapdrm/dss/venc.c
+++ b/drivers/gpu/drm/omapdrm/dss/venc.c
@@ -904,10 +904,10 @@ static const struct dev_pm_ops venc_pm_ops = {
 };
 
 static const struct of_device_id venc_of_match[] = {
-	{ .compatible = "ti,omap2-venc", },
-	{ .compatible = "ti,omap3-venc", },
-	{ .compatible = "ti,omap4-venc", },
-	{},
+	{ .compatible = "ti,omap2-venc" },
+	{ .compatible = "ti,omap3-venc" },
+	{ .compatible = "ti,omap4-venc" },
+	{ }
 };
 
 struct platform_driver omap_venchw_driver = {
diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index ee940a6833ff..011ae8aff3ec 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -1205,7 +1205,7 @@ static const struct of_device_id dmm_of_match[] = {
 		.compatible = "ti,omap5-dmm",
 		.data = &dmm_omap5_platform_data,
 	},
-	{},
+	{ }
 };
 #endif
 
diff --git a/drivers/gpu/drm/panel/panel-arm-versatile.c b/drivers/gpu/drm/panel/panel-arm-versatile.c
index cffee9838324..69646e70740d 100644
--- a/drivers/gpu/drm/panel/panel-arm-versatile.c
+++ b/drivers/gpu/drm/panel/panel-arm-versatile.c
@@ -355,8 +355,8 @@ static int versatile_panel_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id versatile_panel_match[] = {
-	{ .compatible = "arm,versatile-tft-panel", },
-	{},
+	{ .compatible = "arm,versatile-tft-panel" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, versatile_panel_match);
 
diff --git a/drivers/gpu/drm/panel/panel-boe-himax8279d.c b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
index facf37bd1c14..f96ad0f3816f 100644
--- a/drivers/gpu/drm/panel/panel-boe-himax8279d.c
+++ b/drivers/gpu/drm/panel/panel-boe-himax8279d.c
@@ -818,9 +818,7 @@ static const struct of_device_id panel_of_match[] = {
 		.compatible = "boe,himax8279d10p",
 		.data = &boe_himax8279d10p_panel_desc,
 	},
-	{
-		/* sentinel */
-	}
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, panel_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index c5f18e310b43..445ee59507eb 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -406,11 +406,11 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
 static const struct of_device_id boe_th101mb31ig002_of_match[] = {
 	{
 		.compatible = "boe,th101mb31ig002-28a",
-		.data = &boe_th101mb31ig002_desc
+		.data = &boe_th101mb31ig002_desc,
 	},
 	{
 		.compatible = "starry,er88577",
-		.data = &starry_er88577_desc
+		.data = &starry_er88577_desc,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index cf9f15fae272..2cf213e551e7 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1767,29 +1767,30 @@ static int boe_panel_probe(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id boe_of_match[] = {
-	{ .compatible = "boe,tv101wum-nl6",
-	  .data = &boe_tv101wum_nl6_desc
-	},
-	{ .compatible = "auo,kd101n80-45na",
-	  .data = &auo_kd101n80_45na_desc
-	},
-	{ .compatible = "boe,tv101wum-n53",
-	  .data = &boe_tv101wum_n53_desc
-	},
-	{ .compatible = "auo,b101uan08.3",
-	  .data = &auo_b101uan08_3_desc
-	},
-	{ .compatible = "boe,tv105wum-nw0",
-	  .data = &boe_tv105wum_nw0_desc
-	},
-	{ .compatible = "boe,tv110c9m-ll3",
-	  .data = &boe_tv110c9m_desc
-	},
-	{ .compatible = "innolux,hj110iz-01a",
-	  .data = &inx_hj110iz_desc
-	},
-	{ .compatible = "starry,2081101qfh032011-53g",
-	  .data = &starry_qfh032011_53g_desc
+	{
+		.compatible = "boe,tv101wum-nl6",
+		.data = &boe_tv101wum_nl6_desc,
+	}, {
+		.compatible = "auo,kd101n80-45na",
+		.data = &auo_kd101n80_45na_desc,
+	}, {
+		.compatible = "boe,tv101wum-n53",
+		.data = &boe_tv101wum_n53_desc,
+	}, {
+		.compatible = "auo,b101uan08.3",
+		.data = &auo_b101uan08_3_desc,
+	}, {
+		.compatible = "boe,tv105wum-nw0",
+		.data = &boe_tv105wum_nw0_desc,
+	}, {
+		.compatible = "boe,tv110c9m-ll3",
+		.data = &boe_tv110c9m_desc,
+	}, {
+		.compatible = "innolux,hj110iz-01a",
+		.data = &inx_hj110iz_desc,
+	}, {
+		.compatible = "starry,2081101qfh032011-53g",
+		.data = &starry_qfh032011_53g_desc,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/gpu/drm/panel/panel-dsi-cm.c b/drivers/gpu/drm/panel/panel-dsi-cm.c
index 99ccf3badde7..2747821a2241 100644
--- a/drivers/gpu/drm/panel/panel-dsi-cm.c
+++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
@@ -630,7 +630,7 @@ static const struct of_device_id dsicm_of_match[] = {
 	{ .compatible = "tpo,taal", .data = &taal_data },
 	{ .compatible = "nokia,himalaya", .data = &himalaya_data },
 	{ .compatible = "motorola,droid4-panel", .data = &droid4_data },
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, dsicm_of_match);
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 3e0bdae8e272..02796ce22b88 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1753,9 +1753,8 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "sharp,lq123p1jx31",
 		.data = &sharp_lq123p1jx31,
-	}, {
-		/* sentinel */
-	}
+	},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, platform_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c b/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
index c58d8fe0c384..b99b679219bc 100644
--- a/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
+++ b/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
@@ -484,7 +484,7 @@ static int k101_im2ba02_dsi_probe(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id k101_im2ba02_of_match[] = {
-	{ .compatible = "feixin,k101-im2ba02", },
+	{ .compatible = "feixin,k101-im2ba02" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, k101_im2ba02_of_match);
diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
index af63441d194e..9a1d8b8828c4 100644
--- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -238,7 +238,7 @@ static int feiyang_dsi_probe(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id feiyang_of_match[] = {
-	{ .compatible = "feiyang,fy07024di26a30d", },
+	{ .compatible = "feiyang,fy07024di26a30d" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, feiyang_of_match);
diff --git a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
index bbc870b8fda8..2a2d148fb74a 100644
--- a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
+++ b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
@@ -208,8 +208,8 @@ static int ota7290b_probe(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id ota7290b_of_match[] = {
-	{ .compatible = "waveshare,8.8-dsi-touch-a", },
-	{}
+	{ .compatible = "waveshare,8.8-dsi-touch-a" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ota7290b_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 3ef052571ce0..6f63bdeca724 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -1320,29 +1320,30 @@ static int hx83102_probe(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id hx83102_of_match[] = {
-	{ .compatible = "boe,nv110wum-l60",
-	.data = &boe_nv110wum_desc
-	},
-	{ .compatible = "csot,pna957qt1-1",
-	  .data = &csot_pna957qt1_1_desc
-	},
-	{ .compatible = "ivo,t109nw41",
-	  .data = &ivo_t109nw41_desc
-	},
-	{ .compatible = "kingdisplay,kd110n11-51ie",
-	  .data = &kingdisplay_kd110n11_51ie_desc
-	},
-	{ .compatible = "starry,2082109qfh040022-50e",
-	  .data = &starry_2082109qfh040022_50e_desc
-	},
-	{ .compatible = "starry,himax83102-j02",
-	  .data = &starry_desc
-	},
-	{ .compatible = "holitech,htf065h045",
-	  .data = &holitech_htf065h045_desc
-	},
-	{ .compatible = "waveshare,12.3-dsi-touch-a",
-	  .data = &waveshare_12_3_inch_a_desc
+	{
+		.compatible = "boe,nv110wum-l60",
+		.data = &boe_nv110wum_desc,
+	}, {
+		.compatible = "csot,pna957qt1-1",
+		.data = &csot_pna957qt1_1_desc,
+	}, {
+		.compatible = "ivo,t109nw41",
+		.data = &ivo_t109nw41_desc,
+	}, {
+		.compatible = "kingdisplay,kd110n11-51ie",
+		.data = &kingdisplay_kd110n11_51ie_desc,
+	}, {
+		.compatible = "starry,2082109qfh040022-50e",
+		.data = &starry_2082109qfh040022_50e_desc,
+	}, {
+		.compatible = "starry,himax83102-j02",
+		.data = &starry_desc,
+	}, {
+		.compatible = "holitech,htf065h045",
+		.data = &holitech_htf065h045_desc,
+	}, {
+		.compatible = "waveshare,12.3-dsi-touch-a",
+		.data = &waveshare_12_3_inch_a_desc,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index bea5ca70c775..3dd62bc17156 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -1075,14 +1075,15 @@ static int ili9882t_probe(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id ili9882t_of_match[] = {
-	{ .compatible = "raspberrypi,dsi-10inch",
-	  .data = &rpi_10inch_desc
-	},
-	{ .compatible = "starry,ili9882t",
-	  .data = &starry_ili9882t_desc
-	},
-	{ .compatible = "tianma,tl121bvms07-00",
-	  .data = &tianma_tl121bvms07_desc
+	{
+		.compatible = "raspberrypi,dsi-10inch",
+		.data = &rpi_10inch_desc,
+	}, {
+		.compatible = "starry,ili9882t",
+		.data = &starry_ili9882t_desc,
+	}, {
+		.compatible = "tianma,tl121bvms07-00",
+		.data = &tianma_tl121bvms07_desc,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 2b3a90984d24..575f7a8515b3 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -354,11 +354,12 @@ static const struct drm_panel_funcs innolux_panel_funcs = {
 };
 
 static const struct of_device_id innolux_of_match[] = {
-	{ .compatible = "innolux,p079zca",
-	  .data = &innolux_p079zca_panel_desc
-	},
-	{ .compatible = "innolux,p097pfg",
-	  .data = &innolux_p097pfg_panel_desc
+	{
+		.compatible = "innolux,p079zca",
+		.data = &innolux_p079zca_panel_desc,
+	}, {
+		.compatible = "innolux,p097pfg",
+		.data = &innolux_p097pfg_panel_desc,
 	},
 	{ }
 };
diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index b6fadab7cfec..49e7947459b2 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -3259,63 +3259,63 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 static const struct of_device_id jadard_of_match[] = {
 	{
 		.compatible = "anbernic,rg-ds-display-bottom",
-		.data = &anbernic_rgds_display_desc
+		.data = &anbernic_rgds_display_desc,
 	},
 	{
 		.compatible = "anbernic,rg-ds-display-top",
-		.data = &anbernic_rgds_display_desc
+		.data = &anbernic_rgds_display_desc,
 	},
 	{
 		.compatible = "chongzhou,cz101b4001",
-		.data = &cz101b4001_desc
+		.data = &cz101b4001_desc,
 	},
 	{
 		.compatible = "dcltek,dt300250",
-		.data = &dcltek_dt300250_desc
+		.data = &dcltek_dt300250_desc,
 	},
 	{
 		.compatible = "kingdisplay,kd101ne3-40ti",
-		.data = &kingdisplay_kd101ne3_40ti_desc
+		.data = &kingdisplay_kd101ne3_40ti_desc,
 	},
 	{
 		.compatible = "melfas,lmfbx101117480",
-		.data = &melfas_lmfbx101117480_desc
+		.data = &melfas_lmfbx101117480_desc,
 	},
 	{
 		.compatible = "radxa,display-10hd-ad001",
-		.data = &cz101b4001_desc
+		.data = &cz101b4001_desc,
 	},
 	{
 		.compatible = "radxa,display-8hd-ad002",
-		.data = &radxa_display_8hd_ad002_desc
+		.data = &radxa_display_8hd_ad002_desc,
 	},
 	{
 		.compatible = "taiguanck,xti05101-01a",
-		.data = &taiguan_xti05101_01a_desc
+		.data = &taiguan_xti05101_01a_desc,
 	},
 	{
 		.compatible = "waveshare,3.4-dsi-touch-c",
-		.data = &waveshare_3_4_inch_c_desc
+		.data = &waveshare_3_4_inch_c_desc,
 	},
 	{
 		.compatible = "waveshare,4.0-dsi-touch-c",
-		.data = &waveshare_4_0_inch_c_desc
+		.data = &waveshare_4_0_inch_c_desc,
 	},
 	{
 		.compatible = "waveshare,8.0-dsi-touch-a",
-		.data = &waveshare_8_0_inch_a_desc
+		.data = &waveshare_8_0_inch_a_desc,
 	},
 	{
 		.compatible = "waveshare,9.0-dsi-touch-b",
-		.data = &waveshare_9_0_inch_b_desc
+		.data = &waveshare_9_0_inch_b_desc,
 	},
 	{
 		.compatible = "waveshare,10.1-dsi-touch-a",
-		.data = &waveshare_10_1_inch_a_desc
+		.data = &waveshare_10_1_inch_a_desc,
 	},
 	{
 		.compatible = "waveshare,10.1-dsi-touch-b",
-		.data = &waveshare_10_1_inch_b_desc
+		.data = &waveshare_10_1_inch_b_desc,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
index ea975170faff..29da7b9f63ac 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lpm102a188a.c
@@ -319,7 +319,7 @@ static const struct drm_panel_funcs jdi_panel_funcs = {
 };
 
 static const struct of_device_id jdi_of_match[] = {
-	{ .compatible = "jdi,lpm102a188a", },
+	{ .compatible = "jdi,lpm102a188a" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, jdi_of_match);
diff --git a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
index e91b41743bec..62c9deb83903 100644
--- a/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
+++ b/drivers/gpu/drm/panel/panel-jdi-lt070me05000.c
@@ -302,7 +302,7 @@ static const struct drm_panel_funcs jdi_panel_funcs = {
 };
 
 static const struct of_device_id jdi_of_match[] = {
-	{ .compatible = "jdi,lt070me05000", },
+	{ .compatible = "jdi,lt070me05000" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, jdi_of_match);
diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm/panel/panel-khadas-ts050.c
index b3c56ed4589e..363fb02310ee 100644
--- a/drivers/gpu/drm/panel/panel-khadas-ts050.c
+++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
@@ -793,8 +793,8 @@ static const struct drm_panel_funcs khadas_ts050_panel_funcs = {
 };
 
 static const struct of_device_id khadas_ts050_of_match[] = {
-	{ .compatible = "khadas,ts050",    .data = &ts050_panel_data, },
-	{ .compatible = "khadas,ts050v2",  .data = &ts050v2_panel_data, },
+	{ .compatible = "khadas,ts050",    .data = &ts050_panel_data },
+	{ .compatible = "khadas,ts050v2",  .data = &ts050v2_panel_data },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, khadas_ts050_of_match);
diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
index 6a3ecdcc1795..55fa8580ca0e 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
@@ -298,7 +298,7 @@ static const struct drm_panel_funcs kingdisplay_panel_funcs = {
 };
 
 static const struct of_device_id kingdisplay_of_match[] = {
-	{ .compatible = "kingdisplay,kd097d04", },
+	{ .compatible = "kingdisplay,kd097d04" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kingdisplay_of_match);
diff --git a/drivers/gpu/drm/panel/panel-lg-lb035q02.c b/drivers/gpu/drm/panel/panel-lg-lb035q02.c
index 30590aabd9d3..921d464ffbb1 100644
--- a/drivers/gpu/drm/panel/panel-lg-lb035q02.c
+++ b/drivers/gpu/drm/panel/panel-lg-lb035q02.c
@@ -210,8 +210,8 @@ static void lb035q02_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id lb035q02_of_match[] = {
-	{ .compatible = "lgphilips,lb035q02", },
-	{ /* sentinel */ },
+	{ .compatible = "lgphilips,lb035q02" },
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, lb035q02_of_match);
diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 822318f546ef..aa3e52d0ea12 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -224,8 +224,8 @@ static const struct drm_panel_funcs sw43408_funcs = {
 };
 
 static const struct of_device_id sw43408_of_match[] = {
-	{ .compatible = "lg,sw43408", }, /* legacy */
-	{ .compatible = "lg,sw43408-lh546wf1-ed01", },
+	{ .compatible = "lg,sw43408" }, /* legacy */
+	{ .compatible = "lg,sw43408-lh546wf1-ed01" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sw43408_of_match);
diff --git a/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c b/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c
index 677e86fe9d9d..dc9655bb4908 100644
--- a/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c
+++ b/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c
@@ -228,7 +228,7 @@ static int lincoln_lcd197_panel_probe(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id lincoln_lcd197_of_match[] = {
-	{ .compatible = "lincolntech,lcd197", },
+	{ .compatible = "lincolntech,lcd197" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, lincoln_lcd197_of_match);
diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 37f7498449ec..7339f34648c2 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -234,8 +234,8 @@ static void panel_lvds_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id panel_lvds_of_table[] = {
-	{ .compatible = "panel-lvds", },
-	{ /* Sentinel */ },
+	{ .compatible = "panel-lvds" },
+	{ /* Sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, panel_lvds_of_table);
diff --git a/drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c b/drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c
index e332ec685484..2ffc2170dfda 100644
--- a/drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c
+++ b/drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c
@@ -494,7 +494,7 @@ static const struct d53e6ea8966_panel_info ams495qa01_info = {
 
 static const struct of_device_id d53e6ea8966_match[] = {
 	{ .compatible = "samsung,ams495qa01", .data = &ams495qa01_info },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, d53e6ea8966_match);
 
diff --git a/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c b/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
index bbd70572fe0c..b1b8ab4780c2 100644
--- a/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
+++ b/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
@@ -220,8 +220,8 @@ static void nl8048_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id nl8048_of_match[] = {
-	{ .compatible = "nec,nl8048hl11", },
-	{ /* sentinel */ },
+	{ .compatible = "nec,nl8048hl11" },
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, nl8048_of_match);
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt35950.c b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
index 94aa6489d99f..a8bfac03c081 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt35950.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt35950.c
@@ -589,7 +589,7 @@ static const struct nt35950_panel_desc sharp_ls055d1sx04 = {
 
 static const struct of_device_id nt35950_of_match[] = {
 	{ .compatible = "sharp,ls055d1sx04", .data = &sharp_ls055d1sx04 },
-	{  }
+	{ }
 };
 MODULE_DEVICE_TABLE(of, nt35950_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index 34b9123d3fd7..c86bf9ff5265 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -1254,7 +1254,7 @@ static const struct of_device_id nt36523_of_match[] = {
 		.compatible = "xiaomi,elish-csot-nt36523",
 		.data = &elish_csot_desc,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, nt36523_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
index a5c1b1b8113b..d9b80c44d0c9 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
@@ -950,7 +950,7 @@ static const struct of_device_id panel_nt36672a_match[] = {
 	{ .compatible = "tianma,tl063fvmc43-02", .data = &tianmaplus_e7t_tulip_panel_desc },
 	{ .compatible = "tianma,tl063fvmca01-00", .data = &tianma_lavender_panel_desc },
 	{ .compatible = "txdkj,txdi600yanpa-43v3", .data = &txd_x00td_panel_desc },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, panel_nt36672a_match);
 
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36850.c b/drivers/gpu/drm/panel/panel-novatek-nt36850.c
index 0d1eeba539db..a04b2835fd01 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36850.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36850.c
@@ -332,7 +332,7 @@ static const struct of_device_id nt36850_of_match[] = {
 		.compatible = "truly,wqhd60-nt36850",
 		.data = &truly_wqhd_desc,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, nt36850_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt37801.c b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
index 4db560b66f4d..3720c66e97c1 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt37801.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt37801.c
@@ -294,7 +294,7 @@ static int novatek_nt37801_probe(struct mipi_dsi_device *dsi)
 
 static const struct of_device_id novatek_nt37801_of_match[] = {
 	{ .compatible = "novatek,nt37801" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, novatek_nt37801_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
index ae6b3ae5a120..a9c43e908d8d 100644
--- a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
+++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
@@ -115,9 +115,8 @@ static const struct of_device_id osd101t2587_of_match[] = {
 	{
 		.compatible = "osddisplays,osd101t2587-53ts",
 		.data = &default_mode_osd101t2587,
-	}, {
-		/* sentinel */
-	}
+	},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, osd101t2587_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
index c00b1c44611a..98127e52462c 100644
--- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
+++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
@@ -152,7 +152,7 @@ static const struct drm_panel_funcs wuxga_nt_panel_funcs = {
 };
 
 static const struct of_device_id wuxga_nt_of_match[] = {
-	{ .compatible = "panasonic,vvx10f034n00", },
+	{ .compatible = "panasonic,vvx10f034n00" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, wuxga_nt_of_match);
diff --git a/drivers/gpu/drm/panel/panel-raydium-rm67191.c b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
index 8564cb3984bb..07968506c4a6 100644
--- a/drivers/gpu/drm/panel/panel-raydium-rm67191.c
+++ b/drivers/gpu/drm/panel/panel-raydium-rm67191.c
@@ -598,7 +598,7 @@ static int rad_panel_probe(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id rad_of_match[] = {
-	{ .compatible = "raydium,rm67191", },
+	{ .compatible = "raydium,rm67191" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rad_of_match);
diff --git a/drivers/gpu/drm/panel/panel-renesas-r63419.c b/drivers/gpu/drm/panel/panel-renesas-r63419.c
index ff3846d574e5..2e5881b93d77 100644
--- a/drivers/gpu/drm/panel/panel-renesas-r63419.c
+++ b/drivers/gpu/drm/panel/panel-renesas-r63419.c
@@ -332,7 +332,7 @@ static const struct of_device_id renesas_r63419_of_match[] = {
 		.compatible = "ayaneo,wt0630-2k",
 		.data = &wt0630_desc,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, renesas_r63419_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
index 6ff7985b4337..518a8e75e19a 100644
--- a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
+++ b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
@@ -219,7 +219,7 @@ static int rb070d30_panel_dsi_probe(struct mipi_dsi_device *dsi)
 
 static const struct of_device_id rb070d30_panel_of_match[] = {
 	{ .compatible = "ronbo,rb070d30" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rb070d30_panel_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
index 20ec27d2d6c2..1269cdcaeece 100644
--- a/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
+++ b/drivers/gpu/drm/panel/panel-samsung-atna33xc20.c
@@ -333,7 +333,7 @@ static void atana33xc20_remove(struct dp_aux_ep_device *aux_ep)
 }
 
 static const struct of_device_id atana33xc20_dt_match[] = {
-	{ .compatible = "samsung,atna33xc20", },
+	{ .compatible = "samsung,atna33xc20" },
 	{ /* sentinal */ }
 };
 MODULE_DEVICE_TABLE(of, atana33xc20_dt_match);
diff --git a/drivers/gpu/drm/panel/panel-samsung-db7430.c b/drivers/gpu/drm/panel/panel-samsung-db7430.c
index 2a1fd9eb4698..258dd495e877 100644
--- a/drivers/gpu/drm/panel/panel-samsung-db7430.c
+++ b/drivers/gpu/drm/panel/panel-samsung-db7430.c
@@ -321,14 +321,14 @@ static void db7430_remove(struct spi_device *spi)
  * so list the different variants here and add per-variant data if needed.
  */
 static const struct of_device_id db7430_match[] = {
-	{ .compatible = "samsung,lms397kf04", },
-	{},
+	{ .compatible = "samsung,lms397kf04" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, db7430_match);
 
 static const struct spi_device_id db7430_ids[] = {
 	{ .name = "lms397kf04" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, db7430_ids);
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d27a1.c b/drivers/gpu/drm/panel/panel-samsung-s6d27a1.c
index 300dc19bd9d1..d21fc70ff4f8 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d27a1.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d27a1.c
@@ -298,8 +298,8 @@ static void s6d27a1_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id s6d27a1_match[] = {
-	{ .compatible = "samsung,s6d27a1", },
-	{ /* sentinel */ },
+	{ .compatible = "samsung,s6d27a1" },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, s6d27a1_match);
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
index 5a4cfb21e2fd..a673304fa265 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
@@ -452,15 +452,15 @@ static int s6d7aa0_probe(struct mipi_dsi_device *dsi)
 static const struct of_device_id s6d7aa0_of_match[] = {
 	{
 		.compatible = "samsung,lsl080al02",
-		.data = &s6d7aa0_lsl080al02_desc
+		.data = &s6d7aa0_lsl080al02_desc,
 	},
 	{
 		.compatible = "samsung,lsl080al03",
-		.data = &s6d7aa0_lsl080al03_desc
+		.data = &s6d7aa0_lsl080al03_desc,
 	},
 	{
 		.compatible = "samsung,ltl101at01",
-		.data = &s6d7aa0_ltl101at01_desc
+		.data = &s6d7aa0_ltl101at01_desc,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
index b48a2f9578e7..139beae3efbc 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c
@@ -737,7 +737,7 @@ static int s6e88a0_ams427ap24_probe(struct mipi_dsi_device *dsi)
 
 static const struct of_device_id s6e88a0_ams427ap24_of_match[] = {
 	{ .compatible = "samsung,s6e88a0-ams427ap24" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, s6e88a0_ams427ap24_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
index 2178e03e4772..bafa3dcbc92d 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams452ef01.c
@@ -211,7 +211,7 @@ static int s6e88a0_ams452ef01_probe(struct mipi_dsi_device *dsi)
 
 static const struct of_device_id s6e88a0_ams452ef01_of_match[] = {
 	{ .compatible = "samsung,s6e88a0-ams452ef01" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, s6e88a0_ams452ef01_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
index 0935d83ee2db..ac0cd2c01dca 100644
--- a/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
+++ b/drivers/gpu/drm/panel/panel-seiko-43wvf1g.c
@@ -273,9 +273,8 @@ static const struct of_device_id platform_of_match[] = {
 	{
 		.compatible = "sii,43wvf1g",
 		.data = &seiko_43wvf1g,
-	}, {
-		/* sentinel */
-	}
+	},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, platform_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
index d159b0e4fdb6..173812707d6d 100644
--- a/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.c
@@ -264,7 +264,7 @@ static const struct drm_panel_funcs sharp_panel_funcs = {
 };
 
 static const struct of_device_id sharp_of_match[] = {
-	{ .compatible = "sharp,lq101r1sx01", },
+	{ .compatible = "sharp,lq101r1sx01" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sharp_of_match);
diff --git a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
index 938beac4655d..30df80fcae80 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls037v7dw01.c
@@ -197,8 +197,8 @@ static void ls037v7dw01_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ls037v7dw01_of_match[] = {
-	{ .compatible = "sharp,ls037v7dw01", },
-	{ /* sentinel */ },
+	{ .compatible = "sharp,ls037v7dw01" },
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, ls037v7dw01_of_match);
diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index 5077893dab7c..8a27afe5f58c 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -240,7 +240,7 @@ static int sharp_nt_panel_probe(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id sharp_nt_of_match[] = {
-	{ .compatible = "sharp,ls043t1le01-qhd", },
+	{ .compatible = "sharp,ls043t1le01-qhd" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sharp_nt_of_match);
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 33a8bb170fe2..6be01cd345e8 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -5815,7 +5815,7 @@ static const struct of_device_id platform_of_match[] = {
 		.data = &boe_ev121wxm_n10_1850,
 	}, {
 		.compatible = "boe,hv070wsa-100",
-		.data = &boe_hv070wsa
+		.data = &boe_hv070wsa,
 	}, {
 		.compatible = "cct,cmt430b19n00",
 		.data = &cct_cmt430b19n00,
@@ -5839,10 +5839,10 @@ static const struct of_device_id platform_of_match[] = {
 		.data = &chunghwa_claa070wp03xg,
 	}, {
 		.compatible = "chunghwa,claa101wa01a",
-		.data = &chunghwa_claa101wa01a
+		.data = &chunghwa_claa101wa01a,
 	}, {
 		.compatible = "chunghwa,claa101wb01",
-		.data = &chunghwa_claa101wb01
+		.data = &chunghwa_claa101wb01,
 	}, {
 		.compatible = "dataimage,fg040346dsswbg04",
 		.data = &dataimage_fg040346dsswbg04,
@@ -5917,7 +5917,7 @@ static const struct of_device_id platform_of_match[] = {
 		.data = &frida_frd350h54004,
 	}, {
 		.compatible = "giantplus,gpg482739qs5",
-		.data = &giantplus_gpg482739qs5
+		.data = &giantplus_gpg482739qs5,
 	}, {
 		.compatible = "giantplus,gpm940b0",
 		.data = &giantplus_gpm940b0,
@@ -5935,7 +5935,7 @@ static const struct of_device_id platform_of_match[] = {
 		.data = &hannstar_hsd156juw2,
 	}, {
 		.compatible = "hit,tx23d38vm0caa",
-		.data = &hitachi_tx23d38vm0caa
+		.data = &hitachi_tx23d38vm0caa,
 	}, {
 		.compatible = "innolux,at043tn24",
 		.data = &innolux_at043tn24,
@@ -5956,10 +5956,10 @@ static const struct of_device_id platform_of_match[] = {
 		.data = &innolux_g070y2_t02,
 	}, {
 		.compatible = "innolux,g101ice-l01",
-		.data = &innolux_g101ice_l01
+		.data = &innolux_g101ice_l01,
 	}, {
 		.compatible = "innolux,g121i1-l01",
-		.data = &innolux_g121i1_l01
+		.data = &innolux_g121i1_l01,
 	}, {
 		.compatible = "innolux,g121x1-l03",
 		.data = &innolux_g121x1_l03,
@@ -6247,49 +6247,49 @@ static const struct of_device_id platform_of_match[] = {
 		.data = &vl050_8048nt_c01,
 	}, {
 		.compatible = "waveshare,2.8inch-panel",
-		.data = &waveshare_28_lcd_panel
+		.data = &waveshare_28_lcd_panel,
 	}, {
 		.compatible = "waveshare,3.4inch-c-panel",
-		.data = &waveshare_34_lcd_c_panel
+		.data = &waveshare_34_lcd_c_panel,
 	}, {
 		.compatible = "waveshare,4.0inch-panel",
-		.data = &waveshare_40_lcd_panel
+		.data = &waveshare_40_lcd_panel,
 	}, {
 		.compatible = "waveshare,4.0inch-c-panel",
-		.data = &waveshare_40_lcd_c_panel
+		.data = &waveshare_40_lcd_c_panel,
 	}, {
 		.compatible = "waveshare,5.0inch-c-panel",
-		.data = &waveshare_50_lcd_c_panel
+		.data = &waveshare_50_lcd_c_panel,
 	}, {
 		.compatible = "waveshare,5.0inch-d-panel",
-		.data = &waveshare_50_lcd_d_panel
+		.data = &waveshare_50_lcd_d_panel,
 	}, {
 		.compatible = "waveshare,6.25inch-panel",
-		.data = &waveshare_625_lcd_panel
+		.data = &waveshare_625_lcd_panel,
 	}, {
 		.compatible = "waveshare,7.0inch-c-panel",
-		.data = &waveshare_70_lcd_c_panel
+		.data = &waveshare_70_lcd_c_panel,
 	}, {
 		.compatible = "waveshare,7.0inch-e-panel",
-		.data = &waveshare_70_lcd_e_panel
+		.data = &waveshare_70_lcd_e_panel,
 	}, {
 		.compatible = "waveshare,7.0inch-h-panel",
-		.data = &waveshare_70_lcd_h_panel
+		.data = &waveshare_70_lcd_h_panel,
 	}, {
 		.compatible = "waveshare,7.9inch-panel",
-		.data = &waveshare_79_lcd_panel
+		.data = &waveshare_79_lcd_panel,
 	}, {
 		.compatible = "waveshare,8.0inch-c-panel",
-		.data = &waveshare_80_lcd_c_panel
+		.data = &waveshare_80_lcd_c_panel,
 	}, {
 		.compatible = "waveshare,8.8inch-panel",
-		.data = &waveshare_88_lcd_panel
+		.data = &waveshare_88_lcd_panel,
 	}, {
 		.compatible = "waveshare,10.1inch-c-panel",
-		.data = &waveshare_101_lcd_c_panel
+		.data = &waveshare_101_lcd_c_panel,
 	}, {
 		.compatible = "waveshare,11.9inch-panel",
-		.data = &waveshare_119_lcd_panel
+		.data = &waveshare_119_lcd_panel,
 	}, {
 		.compatible = "waveshare,13.3inch-panel",
 		.data = &waveshare_133inch,
@@ -6311,9 +6311,8 @@ static const struct of_device_id platform_of_match[] = {
 		 * allocated by panel_dpi_probe().
 		 */
 		.data = NULL,
-	}, {
-		/* sentinel */
-	}
+	},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, platform_of_match);
 
@@ -6594,31 +6593,30 @@ static const struct panel_desc_dsi tsd_tst070wsbe_196c = {
 static const struct of_device_id dsi_of_match[] = {
 	{
 		.compatible = "auo,b080uan01",
-		.data = &auo_b080uan01
+		.data = &auo_b080uan01,
 	}, {
 		.compatible = "auo,b101uan01",
-		.data = &auo_b101uan01
+		.data = &auo_b101uan01,
 	}, {
 		.compatible = "boe,tv080wum-nl0",
-		.data = &boe_tv080wum_nl0
+		.data = &boe_tv080wum_nl0,
 	}, {
 		.compatible = "lg,lh500wx1-sd03",
-		.data = &lg_lh500wx1_sd03
+		.data = &lg_lh500wx1_sd03,
 	}, {
 		.compatible = "panasonic,vvx10f004b00",
-		.data = &panasonic_vvx10f004b00
+		.data = &panasonic_vvx10f004b00,
 	}, {
 		.compatible = "lg,acx467akm-7",
-		.data = &lg_acx467akm_7
+		.data = &lg_acx467akm_7,
 	}, {
 		.compatible = "osddisplays,osd101t2045-53ts",
-		.data = &osd101t2045_53ts
+		.data = &osd101t2045_53ts,
 	}, {
 		.compatible = "team-source-display,tst070wsbe-196c",
-		.data = &tsd_tst070wsbe_196c
-	}, {
-		/* sentinel */
-	}
+		.data = &tsd_tst070wsbe_196c,
+	},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dsi_of_match);
 
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index fb6cd9081d3c..8ad5b8ee1d84 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -673,11 +673,19 @@ static const struct spi_device_id st7789v_spi_id[] = {
 MODULE_DEVICE_TABLE(spi, st7789v_spi_id);
 
 static const struct of_device_id st7789v_of_match[] = {
-	{ .compatible = "sitronix,st7789v", .data = &default_panel },
-	{ .compatible = "inanbo,t28cp45tn89-v17", .data = &t28cp45tn89_panel },
-	{ .compatible = "edt,et028013dma", .data = &et028013dma_panel },
-	{ .compatible = "jasonic,jt240mhqs-hwt-ek-e3",
-	  .data = &jt240mhqs_hwt_ek_e3_panel },
+	{
+		.compatible = "sitronix,st7789v",
+		.data = &default_panel },
+	{
+		.compatible = "inanbo,t28cp45tn89-v17",
+		.data = &t28cp45tn89_panel },
+	{
+		.compatible = "edt,et028013dma",
+		.data = &et028013dma_panel },
+	{
+		.compatible = "jasonic,jt240mhqs-hwt-ek-e3",
+		.data = &jt240mhqs_hwt_ek_e3_panel,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, st7789v_of_match);
diff --git a/drivers/gpu/drm/panel/panel-sony-acx565akm.c b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
index 7e5e69cc9f6e..e7f6dd17b5e6 100644
--- a/drivers/gpu/drm/panel/panel-sony-acx565akm.c
+++ b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
@@ -652,8 +652,8 @@ static void acx565akm_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id acx565akm_of_match[] = {
-	{ .compatible = "sony,acx565akm", },
-	{ /* sentinel */ },
+	{ .compatible = "sony,acx565akm" },
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, acx565akm_of_match);
diff --git a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
index fe42bee14134..ec0eb6450fec 100644
--- a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
+++ b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
@@ -245,7 +245,7 @@ static const struct drm_panel_funcs stk_panel_funcs = {
 };
 
 static const struct of_device_id stk_of_match[] = {
-	{ .compatible = "startek,kd070fhfid015", },
+	{ .compatible = "startek,kd070fhfid015" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, stk_of_match);
diff --git a/drivers/gpu/drm/panel/panel-summit.c b/drivers/gpu/drm/panel/panel-summit.c
index 8c5523d9793d..8589ed91d043 100644
--- a/drivers/gpu/drm/panel/panel-summit.c
+++ b/drivers/gpu/drm/panel/panel-summit.c
@@ -107,7 +107,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(summit_pm_ops, summit_suspend,
 
 static const struct of_device_id summit_of_match[] = {
 	{ .compatible = "apple,summit" },
-	{},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, summit_of_match);
diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index 6f975acc0431..9b0ca4268fd2 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -124,7 +124,7 @@ static const struct drm_panel_funcs tdo_tl070wsh30_panel_funcs = {
 };
 
 static const struct of_device_id tdo_tl070wsh30_of_match[] = {
-	{ .compatible = "tdo,tl070wsh30", },
+	{ .compatible = "tdo,tl070wsh30" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, tdo_tl070wsh30_of_match);
diff --git a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
index 48c4cb68da44..625660b93e58 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
@@ -355,10 +355,10 @@ static void td028ttec1_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id td028ttec1_of_match[] = {
-	{ .compatible = "tpo,td028ttec1", },
+	{ .compatible = "tpo,td028ttec1" },
 	/* DT backward compatibility. */
-	{ .compatible = "toppoly,td028ttec1", },
-	{ /* sentinel */ },
+	{ .compatible = "toppoly,td028ttec1" },
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, td028ttec1_of_match);
diff --git a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
index 77c5ea2954b8..4ef4ad2a1e1e 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
@@ -473,8 +473,8 @@ static void td043mtea1_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id td043mtea1_of_match[] = {
-	{ .compatible = "tpo,td043mtea1", },
-	{ /* sentinel */ },
+	{ .compatible = "tpo,td043mtea1" },
+	{ /* sentinel */ }
 };
 
 MODULE_DEVICE_TABLE(of, td043mtea1_of_match);
diff --git a/drivers/gpu/drm/panel/panel-tpo-tpg110.c b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
index 8fb3a94f6cd9..9d24f69a4a8f 100644
--- a/drivers/gpu/drm/panel/panel-tpo-tpg110.c
+++ b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
@@ -459,14 +459,14 @@ static void tpg110_remove(struct spi_device *spi)
 }
 
 static const struct of_device_id tpg110_match[] = {
-	{ .compatible = "tpo,tpg110", },
-	{},
+	{ .compatible = "tpo,tpg110" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tpg110_match);
 
 static const struct spi_device_id tpg110_ids[] = {
 	{ .name = "tpg110" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, tpg110_ids);
 
diff --git a/drivers/gpu/drm/panel/panel-visionox-r66451.c b/drivers/gpu/drm/panel/panel-visionox-r66451.c
index db8137b5fe5b..a75b268b1d60 100644
--- a/drivers/gpu/drm/panel/panel-visionox-r66451.c
+++ b/drivers/gpu/drm/panel/panel-visionox-r66451.c
@@ -316,7 +316,7 @@ static int visionox_r66451_probe(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id visionox_r66451_of_match[] = {
-	{.compatible = "visionox,r66451"},
+	{ .compatible = "visionox,r66451" },
 	{ /*sentinel*/ }
 };
 MODULE_DEVICE_TABLE(of, visionox_r66451_of_match);
diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
index 4309e04c35c4..630001619676 100644
--- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
+++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
@@ -414,10 +414,14 @@ const struct visionox_rm69299_panel_desc visionox_rm69299_shift_desc = {
 };
 
 static const struct of_device_id visionox_rm69299_of_match[] = {
-	{ .compatible = "visionox,rm69299-1080p-display",
-	  .data = &visionox_rm69299_1080p_display_desc },
-	{ .compatible = "visionox,rm69299-shift",
-	  .data = &visionox_rm69299_shift_desc },
+	{
+		.compatible = "visionox,rm69299-1080p-display",
+		.data = &visionox_rm69299_1080p_display_desc,
+	},
+	{
+		.compatible = "visionox,rm69299-shift",
+		.data = &visionox_rm69299_shift_desc,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, visionox_rm69299_of_match);
diff --git a/drivers/gpu/drm/panel/panel-widechips-ws2401.c b/drivers/gpu/drm/panel/panel-widechips-ws2401.c
index 4430c71feb88..f8989c67648b 100644
--- a/drivers/gpu/drm/panel/panel-widechips-ws2401.c
+++ b/drivers/gpu/drm/panel/panel-widechips-ws2401.c
@@ -419,14 +419,14 @@ static void ws2401_remove(struct spi_device *spi)
  * here and used for other configurations.
  */
 static const struct of_device_id ws2401_match[] = {
-	{ .compatible = "samsung,lms380kf01", },
-	{},
+	{ .compatible = "samsung,lms380kf01" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ws2401_match);
 
 static const struct spi_device_id ws2401_ids[] = {
 	{ .name = "lms380kf01" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ws2401_ids);
 
diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index eeda113037fe..b4e94b2f41a0 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -977,23 +977,27 @@ static const struct panfrost_compatible mediatek_mt8370_data = {
 
 static const struct of_device_id dt_match[] = {
 	/* Set first to probe before the generic compatibles */
-	{ .compatible = "amlogic,meson-gxm-mali",
-	  .data = &amlogic_data, },
-	{ .compatible = "amlogic,meson-g12a-mali",
-	  .data = &amlogic_data, },
+	{
+		.compatible = "amlogic,meson-gxm-mali",
+		.data = &amlogic_data,
+	},
+	{
+		.compatible = "amlogic,meson-g12a-mali",
+		.data = &amlogic_data,
+	},
 	{ .compatible = "renesas,r9a08g046-mali", .data = &default_pm_rt_data },
 	{ .compatible = "renesas,r9a09g047-mali", .data = &default_pm_rt_data },
-	{ .compatible = "arm,mali-t604", .data = &default_data, },
-	{ .compatible = "arm,mali-t624", .data = &default_data, },
-	{ .compatible = "arm,mali-t628", .data = &default_data, },
-	{ .compatible = "arm,mali-t720", .data = &default_data, },
-	{ .compatible = "arm,mali-t760", .data = &default_data, },
-	{ .compatible = "arm,mali-t820", .data = &default_data, },
-	{ .compatible = "arm,mali-t830", .data = &default_data, },
-	{ .compatible = "arm,mali-t860", .data = &default_data, },
-	{ .compatible = "arm,mali-t880", .data = &default_data, },
-	{ .compatible = "arm,mali-bifrost", .data = &default_data, },
-	{ .compatible = "arm,mali-valhall-jm", .data = &default_data, },
+	{ .compatible = "arm,mali-t604", .data = &default_data },
+	{ .compatible = "arm,mali-t624", .data = &default_data },
+	{ .compatible = "arm,mali-t628", .data = &default_data },
+	{ .compatible = "arm,mali-t720", .data = &default_data },
+	{ .compatible = "arm,mali-t760", .data = &default_data },
+	{ .compatible = "arm,mali-t820", .data = &default_data },
+	{ .compatible = "arm,mali-t830", .data = &default_data },
+	{ .compatible = "arm,mali-t860", .data = &default_data },
+	{ .compatible = "arm,mali-t880", .data = &default_data },
+	{ .compatible = "arm,mali-bifrost", .data = &default_data },
+	{ .compatible = "arm,mali-valhall-jm", .data = &default_data },
 	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
 	{ .compatible = "mediatek,mt8183b-mali", .data = &mediatek_mt8183_b_data },
 	{ .compatible = "mediatek,mt8186-mali", .data = &mediatek_mt8186_data },
@@ -1001,7 +1005,7 @@ static const struct of_device_id dt_match[] = {
 	{ .compatible = "mediatek,mt8192-mali", .data = &mediatek_mt8192_data },
 	{ .compatible = "mediatek,mt8370-mali", .data = &mediatek_mt8370_data },
 	{ .compatible = "allwinner,sun50i-h616-mali", .data = &default_pm_rt_data },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dt_match);
 
diff --git a/drivers/gpu/drm/panthor/panthor_drv.c b/drivers/gpu/drm/panthor/panthor_drv.c
index dc8d0191aef4..9504c0ad34fd 100644
--- a/drivers/gpu/drm/panthor/panthor_drv.c
+++ b/drivers/gpu/drm/panthor/panthor_drv.c
@@ -1878,10 +1878,10 @@ static const struct panthor_soc_data soc_data_mediatek_mt8196 = {
 };
 
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196, },
+	{ .compatible = "mediatek,mt8196-mali", .data = &soc_data_mediatek_mt8196 },
 	{ .compatible = "rockchip,rk3588-mali" },
 	{ .compatible = "arm,mali-valhall-csf" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dt_match);
 
diff --git a/drivers/gpu/drm/pl111/pl111_versatile.c b/drivers/gpu/drm/pl111/pl111_versatile.c
index 9a60f10231b1..52b45511dc72 100644
--- a/drivers/gpu/drm/pl111/pl111_versatile.c
+++ b/drivers/gpu/drm/pl111/pl111_versatile.c
@@ -75,7 +75,7 @@ static const struct of_device_id versatile_clcd_of_match[] = {
 		.compatible = "arm,vexpress-muxfpga",
 		.data = (void *)VEXPRESS_CLCD_V2M,
 	},
-	{},
+	{ }
 };
 
 static const struct of_device_id impd1_clcd_of_match[] = {
@@ -83,7 +83,7 @@ static const struct of_device_id impd1_clcd_of_match[] = {
 		.compatible = "arm,im-pd1-syscon",
 		.data = (void *)INTEGRATOR_IMPD1,
 	},
-	{},
+	{ }
 };
 
 /*
diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
index 97df9d3d6957..8f34f2d8cdbe 100644
--- a/drivers/gpu/drm/qxl/qxl_drv.c
+++ b/drivers/gpu/drm/qxl/qxl_drv.c
@@ -53,13 +53,13 @@ static const struct pci_device_id pciidlist[] = {
 	{
 		PCI_DEVICE(0x1b36, 0x0100),
 		.class = PCI_CLASS_DISPLAY_VGA << 8,
-		.class_mask = 0xffff00
+		.class_mask = 0xffff00,
 	}, {
 		PCI_DEVICE(0x1b36, 0x0100),
 		.class = PCI_CLASS_DISPLAY_OTHER << 8,
-		.class_mask = 0xffff00
+		.class_mask = 0xffff00,
 	},
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(pci, pciidlist);
 
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c b/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c
index 36762ec172d1..a66a42be812b 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_cmm.c
@@ -188,9 +188,9 @@ static void rcar_cmm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id rcar_cmm_of_table[] = {
-	{ .compatible = "renesas,rcar-gen3-cmm", },
-	{ .compatible = "renesas,rcar-gen2-cmm", },
-	{ },
+	{ .compatible = "renesas,rcar-gen3-cmm" },
+	{ .compatible = "renesas,rcar-gen2-cmm" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rcar_cmm_of_table);
 
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c b/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c
index 1882ae34ce8f..dba39478efab 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c
@@ -133,7 +133,7 @@ static void rcar_dsc_remove(struct platform_device *pdev)
 
 static const struct of_device_id rcar_dsc_of_table[] = {
 	{ .compatible = "renesas,r8a779g0-dsc" },
-	{}
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, rcar_dsc_of_table);
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_dw_hdmi.c b/drivers/gpu/drm/renesas/rcar-du/rcar_dw_hdmi.c
index 8e7fac7a893b..41b4d60371d4 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_dw_hdmi.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_dw_hdmi.c
@@ -101,7 +101,7 @@ static void rcar_dw_hdmi_remove(struct platform_device *pdev)
 
 static const struct of_device_id rcar_dw_hdmi_of_table[] = {
 	{ .compatible = "renesas,rcar-gen3-hdmi" },
-	{ /* Sentinel */ },
+	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rcar_dw_hdmi_of_table);
 
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
index 5b257f5adf06..38c74309ca9a 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c
@@ -1685,9 +1685,9 @@ static const struct rzg2l_mipi_dsi_hw_info rzg3l_mipi_dsi_info = {
 };
 
 static const struct of_device_id rzg2l_mipi_dsi_of_table[] = {
-	{ .compatible = "renesas,r9a08g046-mipi-dsi", .data = &rzg3l_mipi_dsi_info, },
-	{ .compatible = "renesas,r9a09g057-mipi-dsi", .data = &rzv2h_mipi_dsi_info, },
-	{ .compatible = "renesas,rzg2l-mipi-dsi", .data = &rzg2l_mipi_dsi_info, },
+	{ .compatible = "renesas,r9a08g046-mipi-dsi", .data = &rzg3l_mipi_dsi_info },
+	{ .compatible = "renesas,r9a09g057-mipi-dsi", .data = &rzv2h_mipi_dsi_info },
+	{ .compatible = "renesas,rzg2l-mipi-dsi", .data = &rzg2l_mipi_dsi_info },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
index 635146746b42..a1c0de087bee 100644
--- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
@@ -574,12 +574,12 @@ static const struct rockchip_dp_chip_data rk3588_edp[] = {
 };
 
 static const struct of_device_id rockchip_dp_dt_ids[] = {
-	{.compatible = "rockchip,rk3288-dp", .data = &rk3288_dp },
-	{.compatible = "rockchip,rk3399-edp", .data = &rk3399_edp },
-	{.compatible = "rockchip,rk3568-edp", .data = &rk3568_edp },
-	{.compatible = "rockchip,rk3576-edp", .data = &rk3576_edp },
-	{.compatible = "rockchip,rk3588-edp", .data = &rk3588_edp },
-	{}
+	{ .compatible = "rockchip,rk3288-dp", .data = &rk3288_dp },
+	{ .compatible = "rockchip,rk3399-edp", .data = &rk3399_edp },
+	{ .compatible = "rockchip,rk3568-edp", .data = &rk3568_edp },
+	{ .compatible = "rockchip,rk3576-edp", .data = &rk3576_edp },
+	{ .compatible = "rockchip,rk3588-edp", .data = &rk3588_edp },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rockchip_dp_dt_ids);
 
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 335177aacdef..8a2c22909b9c 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -60,9 +60,11 @@ static struct cdn_dp_data rk3399_cdn_dp = {
 };
 
 static const struct of_device_id cdn_dp_dt_ids[] = {
-	{ .compatible = "rockchip,rk3399-cdn-dp",
-		.data = (void *)&rk3399_cdn_dp },
-	{}
+	{
+		.compatible = "rockchip,rk3399-cdn-dp",
+		.data = (void *)&rk3399_cdn_dp,
+	},
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, cdn_dp_dt_ids);
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 30d6f83cd5da..8ad19ad94d3d 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -1777,29 +1777,29 @@ static const struct rockchip_dw_dsi_chip_data rv1126_chip_data[] = {
 
 static const struct of_device_id dw_mipi_dsi_rockchip_dt_ids[] = {
 	{
-	 .compatible = "rockchip,px30-mipi-dsi",
-	 .data = &px30_chip_data,
+		.compatible = "rockchip,px30-mipi-dsi",
+		.data = &px30_chip_data,
 	}, {
-	 .compatible = "rockchip,rk3128-mipi-dsi",
-	 .data = &rk3128_chip_data,
+		.compatible = "rockchip,rk3128-mipi-dsi",
+		.data = &rk3128_chip_data,
 	}, {
-	 .compatible = "rockchip,rk3288-mipi-dsi",
-	 .data = &rk3288_chip_data,
+		.compatible = "rockchip,rk3288-mipi-dsi",
+		.data = &rk3288_chip_data,
 	}, {
-	 .compatible = "rockchip,rk3368-mipi-dsi",
-	 .data = &rk3368_chip_data,
+		.compatible = "rockchip,rk3368-mipi-dsi",
+		.data = &rk3368_chip_data,
 	}, {
-	 .compatible = "rockchip,rk3399-mipi-dsi",
-	 .data = &rk3399_chip_data,
+		.compatible = "rockchip,rk3399-mipi-dsi",
+		.data = &rk3399_chip_data,
 	}, {
-	 .compatible = "rockchip,rk3506-mipi-dsi",
-	 .data = &rk3506_chip_data,
+		.compatible = "rockchip,rk3506-mipi-dsi",
+		.data = &rk3506_chip_data,
 	}, {
-	 .compatible = "rockchip,rk3568-mipi-dsi",
-	 .data = &rk3568_chip_data,
+		.compatible = "rockchip,rk3568-mipi-dsi",
+		.data = &rk3568_chip_data,
 	}, {
-	 .compatible = "rockchip,rv1126-mipi-dsi",
-	 .data = &rv1126_chip_data,
+		.compatible = "rockchip,rv1126-mipi-dsi",
+		.data = &rv1126_chip_data,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
index 3609ac34b911..51aaab7c4989 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c
@@ -497,7 +497,7 @@ static const struct of_device_id dw_mipi_dsi2_rockchip_dt_ids[] = {
 		.compatible = "rockchip,rk3588-mipi-dsi2",
 		.data = &rk3588_chip_data,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dw_mipi_dsi2_rockchip_dt_ids);
 
diff --git a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
index b23efb153c9e..762129369cf5 100644
--- a/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_dp-rockchip.c
@@ -156,7 +156,7 @@ static const struct of_device_id dw_dp_of_match[] = {
 		.compatible = "rockchip,rk3576-dp",
 		.data = &rk3576_dp_plat_data,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dw_dp_of_match);
 
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index b6e154c35e7c..932245da8fc0 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -525,25 +525,31 @@ static const struct dw_hdmi_plat_data rk3568_hdmi_drv_data = {
 };
 
 static const struct of_device_id dw_hdmi_rockchip_dt_ids[] = {
-	{ .compatible = "rockchip,rk3228-dw-hdmi",
-	  .data = &rk3228_hdmi_drv_data
+	{
+		.compatible = "rockchip,rk3228-dw-hdmi",
+		.data = &rk3228_hdmi_drv_data,
 	},
-	{ .compatible = "rockchip,rk3288-dw-hdmi",
-	  .data = &rk3288_hdmi_drv_data
+	{
+		.compatible = "rockchip,rk3288-dw-hdmi",
+		.data = &rk3288_hdmi_drv_data,
 	},
-	{ .compatible = "rockchip,rk3328-dw-hdmi",
-	  .data = &rk3328_hdmi_drv_data
+	{
+		.compatible = "rockchip,rk3328-dw-hdmi",
+		.data = &rk3328_hdmi_drv_data,
 	},
-	{ .compatible = "rockchip,rk3368-dw-hdmi",
-	 .data = &rk3368_hdmi_drv_data
+	{
+		.compatible = "rockchip,rk3368-dw-hdmi",
+		.data = &rk3368_hdmi_drv_data,
 	},
-	{ .compatible = "rockchip,rk3399-dw-hdmi",
-	  .data = &rk3399_hdmi_drv_data
+	{
+		.compatible = "rockchip,rk3399-dw-hdmi",
+		.data = &rk3399_hdmi_drv_data,
 	},
-	{ .compatible = "rockchip,rk3568-dw-hdmi",
-	  .data = &rk3568_hdmi_drv_data
+	{
+		.compatible = "rockchip,rk3568-dw-hdmi",
+		.data = &rk3568_hdmi_drv_data,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dw_hdmi_rockchip_dt_ids);
 
diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 8ce991a5275c..51d5b72962a2 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -596,12 +596,12 @@ static const struct rockchip_hdmi_qp_cfg rk3588_hdmi_cfg = {
 static const struct of_device_id dw_hdmi_qp_rockchip_dt_ids[] = {
 	{
 		.compatible = "rockchip,rk3576-dw-hdmi-qp",
-		.data = &rk3576_hdmi_cfg
+		.data = &rk3576_hdmi_cfg,
 	}, {
 		.compatible = "rockchip,rk3588-dw-hdmi-qp",
-		.data = &rk3588_hdmi_cfg
+		.data = &rk3588_hdmi_cfg,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dw_hdmi_qp_rockchip_dt_ids);
 
diff --git a/drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
index 33ff195bd2e6..2f531bfb7e66 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi-rockchip.c
@@ -169,13 +169,15 @@ static const struct inno_hdmi_plat_data rk3128_inno_hdmi_plat_data = {
 };
 
 static const struct of_device_id inno_hdmi_rockchip_dt_ids[] = {
-	{ .compatible = "rockchip,rk3036-inno-hdmi",
-	  .data = &rk3036_inno_hdmi_plat_data,
+	{
+		.compatible = "rockchip,rk3036-inno-hdmi",
+		.data = &rk3036_inno_hdmi_plat_data,
 	},
-	{ .compatible = "rockchip,rk3128-inno-hdmi",
-	  .data = &rk3128_inno_hdmi_plat_data,
+	{
+		.compatible = "rockchip,rk3128-inno-hdmi",
+		.data = &rk3128_inno_hdmi_plat_data,
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, inno_hdmi_rockchip_dt_ids);
 
diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index d24f4832293e..f4fe6269dd20 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -845,7 +845,7 @@ static void rk3066_hdmi_remove(struct platform_device *pdev)
 
 static const struct of_device_id rk3066_hdmi_dt_ids[] = {
 	{ .compatible = "rockchip,rk3066-hdmi" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rk3066_hdmi_dt_ids);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 350fc18106ec..b161644155aa 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -498,8 +498,8 @@ static void rockchip_drm_platform_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id rockchip_drm_dt_ids[] = {
-	{ .compatible = "rockchip,display-subsystem", },
-	{ /* sentinel */ },
+	{ .compatible = "rockchip,display-subsystem" },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rockchip_drm_dt_ids);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 9cd437dc8c93..8c253790eb2f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -519,13 +519,13 @@ static const struct rockchip_lvds_soc_data px30_lvds_data = {
 static const struct of_device_id rockchip_lvds_dt_ids[] = {
 	{
 		.compatible = "rockchip,rk3288-lvds",
-		.data = &rk3288_lvds_data
+		.data = &rk3288_lvds_data,
 	},
 	{
 		.compatible = "rockchip,px30-lvds",
-		.data = &px30_lvds_data
+		.data = &px30_lvds_data,
 	},
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, rockchip_lvds_dt_ids);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
index c44648e1bc0d..a4ea672c404c 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop2_reg.c
@@ -2590,9 +2590,9 @@ static const struct of_device_id vop2_dt_match[] = {
 		.data = &rk3576_vop,
 	}, {
 		.compatible = "rockchip,rk3588-vop",
-		.data = &rk3588_vop
-	}, {
+		.data = &rk3588_vop,
 	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, vop2_dt_match);
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
index 72301e0a3e0a..7aebc6fd507d 100644
--- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
+++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
@@ -1288,37 +1288,67 @@ static const struct vop_data rv1126_vop = {
 };
 
 static const struct of_device_id vop_driver_dt_match[] = {
-	{ .compatible = "rockchip,rk3036-vop",
-	  .data = &rk3036_vop },
-	{ .compatible = "rockchip,rk3126-vop",
-	  .data = &rk3126_vop },
-	{ .compatible = "rockchip,px30-vop-big",
-	  .data = &px30_vop_big },
-	{ .compatible = "rockchip,px30-vop-lit",
-	  .data = &px30_vop_lit },
-	{ .compatible = "rockchip,rk3066-vop",
-	  .data = &rk3066_vop },
-	{ .compatible = "rockchip,rk3188-vop",
-	  .data = &rk3188_vop },
-	{ .compatible = "rockchip,rk3288-vop",
-	  .data = &rk3288_vop },
-	{ .compatible = "rockchip,rk3368-vop",
-	  .data = &rk3368_vop },
-	{ .compatible = "rockchip,rk3366-vop",
-	  .data = &rk3366_vop },
-	{ .compatible = "rockchip,rk3399-vop-big",
-	  .data = &rk3399_vop_big },
-	{ .compatible = "rockchip,rk3399-vop-lit",
-	  .data = &rk3399_vop_lit },
-	{ .compatible = "rockchip,rk3228-vop",
-	  .data = &rk3228_vop },
-	{ .compatible = "rockchip,rk3328-vop",
-	  .data = &rk3328_vop },
-	{ .compatible = "rockchip,rk3506-vop",
-	  .data = &rk3506_vop },
-	{ .compatible = "rockchip,rv1126-vop",
-	  .data = &rv1126_vop },
-	{},
+	{
+		.compatible = "rockchip,rk3036-vop",
+		.data = &rk3036_vop,
+	},
+	{
+		.compatible = "rockchip,rk3126-vop",
+		.data = &rk3126_vop,
+	},
+	{
+		.compatible = "rockchip,px30-vop-big",
+		.data = &px30_vop_big,
+	},
+	{
+		.compatible = "rockchip,px30-vop-lit",
+		.data = &px30_vop_lit,
+	},
+	{
+		.compatible = "rockchip,rk3066-vop",
+		.data = &rk3066_vop,
+	},
+	{
+		.compatible = "rockchip,rk3188-vop",
+		.data = &rk3188_vop,
+	},
+	{
+		.compatible = "rockchip,rk3288-vop",
+		.data = &rk3288_vop,
+	},
+	{
+		.compatible = "rockchip,rk3368-vop",
+		.data = &rk3368_vop,
+	},
+	{
+		.compatible = "rockchip,rk3366-vop",
+		.data = &rk3366_vop,
+	},
+	{
+		.compatible = "rockchip,rk3399-vop-big",
+		.data = &rk3399_vop_big,
+	},
+	{
+		.compatible = "rockchip,rk3399-vop-lit",
+		.data = &rk3399_vop_lit,
+	},
+	{
+		.compatible = "rockchip,rk3228-vop",
+		.data = &rk3228_vop,
+	},
+	{
+		.compatible = "rockchip,rk3328-vop",
+		.data = &rk3328_vop,
+	},
+	{
+		.compatible = "rockchip,rk3506-vop",
+		.data = &rk3506_vop,
+	},
+	{
+		.compatible = "rockchip,rv1126-vop",
+		.data = &rv1126_vop,
+	},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, vop_driver_dt_match);
 
diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index e66eaa059439..066e2320bc17 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -129,7 +129,7 @@ static void st7571_i2c_remove(struct i2c_client *client)
 static const struct of_device_id st7571_of_match[] = {
 	{ .compatible = "sitronix,st7567", .data = &st7567_config },
 	{ .compatible = "sitronix,st7571", .data = &st7571_config },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st7571_of_match);
 
diff --git a/drivers/gpu/drm/sitronix/st7571-spi.c b/drivers/gpu/drm/sitronix/st7571-spi.c
index 2db85ad78721..ca06a979c644 100644
--- a/drivers/gpu/drm/sitronix/st7571-spi.c
+++ b/drivers/gpu/drm/sitronix/st7571-spi.c
@@ -47,7 +47,7 @@ static void st7571_spi_remove(struct spi_device *spi)
 static const struct of_device_id st7571_of_match[] = {
 	{ .compatible = "sitronix,st7567", .data = &st7567_config },
 	{ .compatible = "sitronix,st7571", .data = &st7571_config },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st7571_of_match);
 
diff --git a/drivers/gpu/drm/sitronix/st7586.c b/drivers/gpu/drm/sitronix/st7586.c
index 0760f771163a..415d7e2bb428 100644
--- a/drivers/gpu/drm/sitronix/st7586.c
+++ b/drivers/gpu/drm/sitronix/st7586.c
@@ -347,13 +347,13 @@ static const struct drm_driver st7586_driver = {
 
 static const struct of_device_id st7586_of_match[] = {
 	{ .compatible = "lego,ev3-lcd" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st7586_of_match);
 
 static const struct spi_device_id st7586_id[] = {
 	{ .name = "ev3-lcd" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, st7586_id);
 
diff --git a/drivers/gpu/drm/sitronix/st7735r.c b/drivers/gpu/drm/sitronix/st7735r.c
index f45bca9f3bc2..459f57ffaa40 100644
--- a/drivers/gpu/drm/sitronix/st7735r.c
+++ b/drivers/gpu/drm/sitronix/st7735r.c
@@ -221,14 +221,14 @@ static const struct drm_driver st7735r_driver = {
 static const struct of_device_id st7735r_of_match[] = {
 	{ .compatible = "jianda,jd-t18003-t01", .data = &jd_t18003_t01_cfg },
 	{ .compatible = "okaya,rh128128t", .data = &rh128128t_cfg },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, st7735r_of_match);
 
 static const struct spi_device_id st7735r_id[] = {
 	{ .name = "jd-t18003-t01", .driver_data = (uintptr_t)&jd_t18003_t01_cfg },
 	{ .name = "rh128128t", .driver_data = (uintptr_t)&rh128128t_cfg },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, st7735r_id);
 
diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index 8fa3c733cc4f..045dc4cc7892 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -843,7 +843,7 @@ static const struct component_ops dpu_component_ops = {
 
 static const struct of_device_id dpu_match_table[] = {
 	{ .compatible = "sprd,sharkl3-dpu" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dpu_match_table);
 
diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index c2fd5380a834..b0619fc54cab 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -153,8 +153,8 @@ static void sprd_drm_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id drm_match_table[] = {
-	{ .compatible = "sprd,display-subsystem", },
-	{ /* sentinel */ },
+	{ .compatible = "sprd,display-subsystem" },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, drm_match_table);
 
diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_dsi.c
index 48bf1ba035f7..1f5ee62744bf 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.c
+++ b/drivers/gpu/drm/sprd/sprd_dsi.c
@@ -1024,7 +1024,7 @@ static const struct mipi_dsi_host_ops sprd_dsi_host_ops = {
 
 static const struct of_device_id dsi_match_table[] = {
 	{ .compatible = "sprd,sharkl3-dsi-host" },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int sprd_dsi_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/sti/sti_compositor.c b/drivers/gpu/drm/sti/sti_compositor.c
index b6ca9361532c..21823263ea80 100644
--- a/drivers/gpu/drm/sti/sti_compositor.c
+++ b/drivers/gpu/drm/sti/sti_compositor.c
@@ -165,9 +165,8 @@ static const struct of_device_id compositor_of_match[] = {
 	{
 		.compatible = "st,stih407-compositor",
 		.data = &stih407_compositor_data,
-	}, {
-		/* end node */
-	}
+	},
+	{ /* end node */ }
 };
 MODULE_DEVICE_TABLE(of, compositor_of_match);
 
diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
index 0ca6c6b41f18..065b1ea63f80 100644
--- a/drivers/gpu/drm/sti/sti_drv.c
+++ b/drivers/gpu/drm/sti/sti_drv.c
@@ -258,8 +258,8 @@ static void sti_platform_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id sti_dt_ids[] = {
-	{ .compatible = "st,sti-display-subsystem", },
-	{ /* end node */ },
+	{ .compatible = "st,sti-display-subsystem" },
+	{ /* end node */ }
 };
 MODULE_DEVICE_TABLE(of, sti_dt_ids);
 
diff --git a/drivers/gpu/drm/sti/sti_dvo.c b/drivers/gpu/drm/sti/sti_dvo.c
index bb305c3739f1..a85f0d5fe214 100644
--- a/drivers/gpu/drm/sti/sti_dvo.c
+++ b/drivers/gpu/drm/sti/sti_dvo.c
@@ -568,7 +568,7 @@ static void sti_dvo_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id dvo_of_match[] = {
-	{ .compatible = "st,stih407-dvo", },
+	{ .compatible = "st,stih407-dvo" },
 	{ /* end node */ }
 };
 MODULE_DEVICE_TABLE(of, dvo_of_match);
diff --git a/drivers/gpu/drm/sti/sti_hda.c b/drivers/gpu/drm/sti/sti_hda.c
index 5175f4f5d1cf..8e358ea64c91 100644
--- a/drivers/gpu/drm/sti/sti_hda.c
+++ b/drivers/gpu/drm/sti/sti_hda.c
@@ -800,8 +800,8 @@ static void sti_hda_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id hda_of_match[] = {
-	{ .compatible = "st,stih416-hda", },
-	{ .compatible = "st,stih407-hda", },
+	{ .compatible = "st,stih416-hda" },
+	{ .compatible = "st,stih407-hda" },
 	{ /* end node */ }
 };
 MODULE_DEVICE_TABLE(of, hda_of_match);
diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index a34365bf1490..39bcc0597f0a 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1373,9 +1373,8 @@ static const struct of_device_id hdmi_of_match[] = {
 	{
 		.compatible = "st,stih407-hdmi",
 		.data = &tx3g4c28phy_ops,
-	}, {
-		/* end node */
-	}
+	},
+	{ /* end node */ }
 };
 MODULE_DEVICE_TABLE(of, hdmi_of_match);
 
diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index 360d213f2094..461650f2caaa 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -1402,7 +1402,7 @@ static void sti_hqvdp_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id hqvdp_of_match[] = {
-	{ .compatible = "st,stih407-hqvdp", },
+	{ .compatible = "st,stih407-hqvdp" },
 	{ /* end node */ }
 };
 MODULE_DEVICE_TABLE(of, hqvdp_of_match);
diff --git a/drivers/gpu/drm/sti/sti_tvout.c b/drivers/gpu/drm/sti/sti_tvout.c
index 2f5ef863e8ff..83923365e1bb 100644
--- a/drivers/gpu/drm/sti/sti_tvout.c
+++ b/drivers/gpu/drm/sti/sti_tvout.c
@@ -870,7 +870,7 @@ static void sti_tvout_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id tvout_of_match[] = {
-	{ .compatible = "st,stih407-tvout", },
+	{ .compatible = "st,stih407-tvout" },
 	{ /* end node */ }
 };
 MODULE_DEVICE_TABLE(of, tvout_of_match);
diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/sti_vtg.c
index 7d80cd8279c3..905f13c085bb 100644
--- a/drivers/gpu/drm/sti/sti_vtg.c
+++ b/drivers/gpu/drm/sti/sti_vtg.c
@@ -420,7 +420,7 @@ static int vtg_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id vtg_of_match[] = {
-	{ .compatible = "st,vtg", },
+	{ .compatible = "st,vtg" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, vtg_of_match);
diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 0967b9b3451d..bb68c3ea65ae 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -245,10 +245,10 @@ static struct ltdc_plat_data stm_drm_plat_data_mp25 = {
 };
 
 static const struct of_device_id drv_dt_ids[] = {
-	{ .compatible = "st,stm32-ltdc", .data = &stm_drm_plat_data, },
-	{ .compatible = "st,stm32mp251-ltdc", .data = &stm_drm_plat_data_mp25, },
-	{ .compatible = "st,stm32mp255-ltdc", .data = &stm_drm_plat_data_mp25, },
-	{ /* end node */ },
+	{ .compatible = "st,stm32-ltdc", .data = &stm_drm_plat_data },
+	{ .compatible = "st,stm32mp251-ltdc", .data = &stm_drm_plat_data_mp25 },
+	{ .compatible = "st,stm32mp255-ltdc", .data = &stm_drm_plat_data_mp25 },
+	{ /* end node */ }
 };
 MODULE_DEVICE_TABLE(of, drv_dt_ids);
 
diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index c9bd2c2e87ff..205b92adeabf 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -597,8 +597,8 @@ static struct dw_mipi_dsi_plat_data dw_mipi_dsi_stm_plat_data = {
 };
 
 static const struct of_device_id dw_mipi_dsi_stm_dt_ids[] = {
-	{ .compatible = "st,stm32-dsi", .data = &dw_mipi_dsi_stm_plat_data, },
-	{ },
+	{ .compatible = "st,stm32-dsi", .data = &dw_mipi_dsi_stm_plat_data },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, dw_mipi_dsi_stm_dt_ids);
 
diff --git a/drivers/gpu/drm/stm/lvds.c b/drivers/gpu/drm/stm/lvds.c
index e72a64f14f47..363bf6fe1e37 100644
--- a/drivers/gpu/drm/stm/lvds.c
+++ b/drivers/gpu/drm/stm/lvds.c
@@ -1203,7 +1203,7 @@ static void lvds_remove(struct platform_device *pdev)
 static const struct of_device_id lvds_dt_ids[] = {
 	{
 		.compatible = "st,stm32mp25-lvds",
-		.data = NULL
+		.data = NULL,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index 7dc0a09bb3c5..1aac371ce697 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -697,19 +697,19 @@ static const struct sun4i_frontend_data sun8i_a33_frontend = {
 const struct of_device_id sun4i_frontend_of_table[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-display-frontend",
-		.data = &sun4i_a10_frontend
+		.data = &sun4i_a10_frontend,
 	},
 	{
 		.compatible = "allwinner,sun7i-a20-display-frontend",
-		.data = &sun4i_a10_frontend
+		.data = &sun4i_a10_frontend,
 	},
 	{
 		.compatible = "allwinner,sun8i-a23-display-frontend",
-		.data = &sun8i_a33_frontend
+		.data = &sun8i_a33_frontend,
 	},
 	{
 		.compatible = "allwinner,sun8i-a33-display-frontend",
-		.data = &sun8i_a33_frontend
+		.data = &sun8i_a33_frontend,
 	},
 	{ }
 };
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 83bd273560a8..d15a69329cb0 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -736,9 +736,9 @@ static void sun4i_hdmi_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id sun4i_hdmi_of_table[] = {
-	{ .compatible = "allwinner,sun4i-a10-hdmi", .data = &sun4i_variant, },
-	{ .compatible = "allwinner,sun5i-a10s-hdmi", .data = &sun5i_variant, },
-	{ .compatible = "allwinner,sun6i-a31-hdmi", .data = &sun6i_variant, },
+	{ .compatible = "allwinner,sun4i-a10-hdmi", .data = &sun4i_variant },
+	{ .compatible = "allwinner,sun5i-a10s-hdmi", .data = &sun5i_variant },
+	{ .compatible = "allwinner,sun6i-a31-hdmi", .data = &sun6i_variant },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun4i_hdmi_of_table);
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index 94c24fffd204..49d5c4ccc3d0 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -1235,16 +1235,16 @@ static const struct sun6i_dsi_variant sun50i_a100_mipi_dsi_variant = {
 
 static const struct of_device_id sun6i_dsi_of_table[] = {
 	{
-		.compatible	= "allwinner,sun6i-a31-mipi-dsi",
-		.data		= &sun6i_a31_mipi_dsi_variant,
+		.compatible = "allwinner,sun6i-a31-mipi-dsi",
+		.data = &sun6i_a31_mipi_dsi_variant,
 	},
 	{
-		.compatible	= "allwinner,sun50i-a64-mipi-dsi",
-		.data		= &sun50i_a64_mipi_dsi_variant,
+		.compatible = "allwinner,sun50i-a64-mipi-dsi",
+		.data = &sun50i_a64_mipi_dsi_variant,
 	},
 	{
-		.compatible	= "allwinner,sun50i-a100-mipi-dsi",
-		.data		= &sun50i_a100_mipi_dsi_variant,
+		.compatible = "allwinner,sun50i-a100-mipi-dsi",
+		.data = &sun50i_a100_mipi_dsi_variant,
 	},
 	{ }
 };
diff --git a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
index e554cd577af9..61118461ce28 100644
--- a/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
+++ b/drivers/gpu/drm/sun4i/sun8i_dw_hdmi.c
@@ -265,7 +265,7 @@ static const struct of_device_id sun8i_dw_hdmi_dt_ids[] = {
 		.compatible = "allwinner,sun50i-h6-dw-hdmi",
 		.data = &sun50i_h6_quirks,
 	},
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_dw_hdmi_dt_ids);
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 86e1e8fed03a..391dc26a8e7c 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -328,15 +328,15 @@ static const struct sun8i_tcon_top_quirks sun50i_h6_tcon_top_quirks = {
 const struct of_device_id sun8i_tcon_top_of_table[] = {
 	{
 		.compatible = "allwinner,sun8i-r40-tcon-top",
-		.data = &sun8i_r40_tcon_top_quirks
+		.data = &sun8i_r40_tcon_top_quirks,
 	},
 	{
 		.compatible = "allwinner,sun20i-d1-tcon-top",
-		.data = &sun20i_d1_tcon_top_quirks
+		.data = &sun20i_d1_tcon_top_quirks,
 	},
 	{
 		.compatible = "allwinner,sun50i-h6-tcon-top",
-		.data = &sun50i_h6_tcon_top_quirks
+		.data = &sun50i_h6_tcon_top_quirks,
 	},
 	{ /* sentinel */ }
 };
diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
index ce9a937b3cd7..025175d23af6 100644
--- a/drivers/gpu/drm/sysfb/ofdrm.c
+++ b/drivers/gpu/drm/sysfb/ofdrm.c
@@ -1165,8 +1165,8 @@ static void ofdrm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ofdrm_of_match_display[] = {
-	{ .compatible = "display", },
-	{ },
+	{ .compatible = "display" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ofdrm_of_match_display);
 
diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 168c5cf8329a..6b1eee362a88 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -951,8 +951,8 @@ static void simpledrm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id simpledrm_of_match_table[] = {
-	{ .compatible = "simple-framebuffer", },
-	{ },
+	{ .compatible = "simple-framebuffer" },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, simpledrm_of_match_table);
 
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index c9df14544ced..9c195e6f731d 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -3184,9 +3184,8 @@ static const struct of_device_id tegra_dc_of_match[] = {
 	}, {
 		.compatible = "nvidia,tegra20-dc",
 		.data = &tegra20_dc_soc_info,
-	}, {
-		/* sentinel */
-	}
+	},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, tegra_dc_of_match);
 
diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index a61d153312f9..f6576146bb89 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -681,7 +681,7 @@ static const struct of_device_id tegra_dpaux_of_match[] = {
 	{ .compatible = "nvidia,tegra186-dpaux", .data = &tegra210_dpaux_soc },
 	{ .compatible = "nvidia,tegra210-dpaux", .data = &tegra210_dpaux_soc },
 	{ .compatible = "nvidia,tegra124-dpaux", .data = &tegra124_dpaux_soc },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_dpaux_of_match);
 
diff --git a/drivers/gpu/drm/tegra/drm.c b/drivers/gpu/drm/tegra/drm.c
index 324480c87fb1..50b8aba4ac4c 100644
--- a/drivers/gpu/drm/tegra/drm.c
+++ b/drivers/gpu/drm/tegra/drm.c
@@ -1357,48 +1357,48 @@ static SIMPLE_DEV_PM_OPS(host1x_drm_pm_ops, host1x_drm_suspend,
 			 host1x_drm_resume);
 
 static const struct of_device_id host1x_drm_subdevs[] = {
-	{ .compatible = "nvidia,tegra20-dc", },
-	{ .compatible = "nvidia,tegra20-dsi", },
-	{ .compatible = "nvidia,tegra20-hdmi", },
-	{ .compatible = "nvidia,tegra20-gr2d", },
-	{ .compatible = "nvidia,tegra20-gr3d", },
-	{ .compatible = "nvidia,tegra30-dc", },
-	{ .compatible = "nvidia,tegra30-dsi", },
-	{ .compatible = "nvidia,tegra30-hdmi", },
-	{ .compatible = "nvidia,tegra30-gr2d", },
-	{ .compatible = "nvidia,tegra30-gr3d", },
-	{ .compatible = "nvidia,tegra114-dc", },
-	{ .compatible = "nvidia,tegra114-dsi", },
-	{ .compatible = "nvidia,tegra114-hdmi", },
-	{ .compatible = "nvidia,tegra114-gr2d", },
-	{ .compatible = "nvidia,tegra114-gr3d", },
-	{ .compatible = "nvidia,tegra124-dc", },
-	{ .compatible = "nvidia,tegra124-sor", },
-	{ .compatible = "nvidia,tegra124-hdmi", },
-	{ .compatible = "nvidia,tegra124-dsi", },
-	{ .compatible = "nvidia,tegra124-vic", },
-	{ .compatible = "nvidia,tegra132-dsi", },
-	{ .compatible = "nvidia,tegra210-dc", },
-	{ .compatible = "nvidia,tegra210-dsi", },
-	{ .compatible = "nvidia,tegra210-sor", },
-	{ .compatible = "nvidia,tegra210-sor1", },
-	{ .compatible = "nvidia,tegra210-vic", },
-	{ .compatible = "nvidia,tegra210-nvdec", },
-	{ .compatible = "nvidia,tegra210-nvjpg", },
-	{ .compatible = "nvidia,tegra186-display", },
-	{ .compatible = "nvidia,tegra186-dc", },
-	{ .compatible = "nvidia,tegra186-sor", },
-	{ .compatible = "nvidia,tegra186-sor1", },
-	{ .compatible = "nvidia,tegra186-vic", },
-	{ .compatible = "nvidia,tegra186-nvdec", },
-	{ .compatible = "nvidia,tegra194-display", },
-	{ .compatible = "nvidia,tegra194-dc", },
-	{ .compatible = "nvidia,tegra194-sor", },
-	{ .compatible = "nvidia,tegra194-vic", },
-	{ .compatible = "nvidia,tegra194-nvdec", },
-	{ .compatible = "nvidia,tegra234-vic", },
-	{ .compatible = "nvidia,tegra234-nvdec", },
-	{ .compatible = "nvidia,tegra264-vic", },
+	{ .compatible = "nvidia,tegra20-dc" },
+	{ .compatible = "nvidia,tegra20-dsi" },
+	{ .compatible = "nvidia,tegra20-hdmi" },
+	{ .compatible = "nvidia,tegra20-gr2d" },
+	{ .compatible = "nvidia,tegra20-gr3d" },
+	{ .compatible = "nvidia,tegra30-dc" },
+	{ .compatible = "nvidia,tegra30-dsi" },
+	{ .compatible = "nvidia,tegra30-hdmi" },
+	{ .compatible = "nvidia,tegra30-gr2d" },
+	{ .compatible = "nvidia,tegra30-gr3d" },
+	{ .compatible = "nvidia,tegra114-dc" },
+	{ .compatible = "nvidia,tegra114-dsi" },
+	{ .compatible = "nvidia,tegra114-hdmi" },
+	{ .compatible = "nvidia,tegra114-gr2d" },
+	{ .compatible = "nvidia,tegra114-gr3d" },
+	{ .compatible = "nvidia,tegra124-dc" },
+	{ .compatible = "nvidia,tegra124-sor" },
+	{ .compatible = "nvidia,tegra124-hdmi" },
+	{ .compatible = "nvidia,tegra124-dsi" },
+	{ .compatible = "nvidia,tegra124-vic" },
+	{ .compatible = "nvidia,tegra132-dsi" },
+	{ .compatible = "nvidia,tegra210-dc" },
+	{ .compatible = "nvidia,tegra210-dsi" },
+	{ .compatible = "nvidia,tegra210-sor" },
+	{ .compatible = "nvidia,tegra210-sor1" },
+	{ .compatible = "nvidia,tegra210-vic" },
+	{ .compatible = "nvidia,tegra210-nvdec" },
+	{ .compatible = "nvidia,tegra210-nvjpg" },
+	{ .compatible = "nvidia,tegra186-display" },
+	{ .compatible = "nvidia,tegra186-dc" },
+	{ .compatible = "nvidia,tegra186-sor" },
+	{ .compatible = "nvidia,tegra186-sor1" },
+	{ .compatible = "nvidia,tegra186-vic" },
+	{ .compatible = "nvidia,tegra186-nvdec" },
+	{ .compatible = "nvidia,tegra194-display" },
+	{ .compatible = "nvidia,tegra194-dc" },
+	{ .compatible = "nvidia,tegra194-sor" },
+	{ .compatible = "nvidia,tegra194-vic" },
+	{ .compatible = "nvidia,tegra194-nvdec" },
+	{ .compatible = "nvidia,tegra234-vic" },
+	{ .compatible = "nvidia,tegra234-nvdec" },
+	{ .compatible = "nvidia,tegra264-vic" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
index b5806a53e75a..e68d630ef7cb 100644
--- a/drivers/gpu/drm/tegra/dsi.c
+++ b/drivers/gpu/drm/tegra/dsi.c
@@ -1771,7 +1771,7 @@ static const struct of_device_id tegra_dsi_of_match[] = {
 	{ .compatible = "nvidia,tegra114-dsi", .data = &tegra114_dsi_config },
 	{ .compatible = "nvidia,tegra30-dsi", .data = &tegra30_dsi_config },
 	{ .compatible = "nvidia,tegra20-dsi", .data = &tegra20_dsi_config },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_dsi_of_match);
 
diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index a190add03b08..a5ad34b0d1cd 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -186,7 +186,7 @@ static const struct of_device_id gr2d_match[] = {
 	{ .compatible = "nvidia,tegra114-gr2d", .data = &tegra114_gr2d_soc },
 	{ .compatible = "nvidia,tegra30-gr2d", .data = &tegra30_gr2d_soc },
 	{ .compatible = "nvidia,tegra20-gr2d", .data = &tegra20_gr2d_soc },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, gr2d_match);
 
diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 3a94968bd983..a7e1749ec19b 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1763,7 +1763,7 @@ static const struct of_device_id tegra_hdmi_of_match[] = {
 	{ .compatible = "nvidia,tegra114-hdmi", .data = &tegra114_hdmi_config },
 	{ .compatible = "nvidia,tegra30-hdmi", .data = &tegra30_hdmi_config },
 	{ .compatible = "nvidia,tegra20-hdmi", .data = &tegra20_hdmi_config },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_hdmi_of_match);
 
diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
index 12429ca53ead..f5e069fa807f 100644
--- a/drivers/gpu/drm/tegra/hub.c
+++ b/drivers/gpu/drm/tegra/hub.c
@@ -1214,13 +1214,12 @@ static const struct tegra_display_hub_soc tegra194_display_hub = {
 static const struct of_device_id tegra_display_hub_of_match[] = {
 	{
 		.compatible = "nvidia,tegra194-display",
-		.data = &tegra194_display_hub
+		.data = &tegra194_display_hub,
 	}, {
 		.compatible = "nvidia,tegra186-display",
-		.data = &tegra186_display_hub
-	}, {
-		/* sentinel */
-	}
+		.data = &tegra186_display_hub,
+	},
+	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, tegra_display_hub_of_match);
 
diff --git a/drivers/gpu/drm/tegra/nvdec.c b/drivers/gpu/drm/tegra/nvdec.c
index 18a8f6e4ced0..139fb60cc35f 100644
--- a/drivers/gpu/drm/tegra/nvdec.c
+++ b/drivers/gpu/drm/tegra/nvdec.c
@@ -415,7 +415,7 @@ static const struct of_device_id tegra_nvdec_of_match[] = {
 	{ .compatible = "nvidia,tegra186-nvdec", .data = &nvdec_t186_config },
 	{ .compatible = "nvidia,tegra194-nvdec", .data = &nvdec_t194_config },
 	{ .compatible = "nvidia,tegra234-nvdec", .data = &nvdec_t234_config },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_nvdec_of_match);
 
diff --git a/drivers/gpu/drm/tegra/nvjpg.c b/drivers/gpu/drm/tegra/nvjpg.c
index e302a8d1f6e7..d96b346298cd 100644
--- a/drivers/gpu/drm/tegra/nvjpg.c
+++ b/drivers/gpu/drm/tegra/nvjpg.c
@@ -226,7 +226,7 @@ static const struct nvjpg_config tegra210_nvjpg_config = {
 
 static const struct of_device_id tegra_nvjpg_of_match[] = {
 	{ .compatible = "nvidia,tegra210-nvjpg", .data = &tegra210_nvjpg_config },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_nvjpg_of_match);
 
diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 061c5dbb738b..590cd48c5f77 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -3664,7 +3664,7 @@ static const struct of_device_id tegra_sor_of_match[] = {
 	{ .compatible = "nvidia,tegra210-sor", .data = &tegra210_sor },
 	{ .compatible = "nvidia,tegra132-sor", .data = &tegra132_sor },
 	{ .compatible = "nvidia,tegra124-sor", .data = &tegra124_sor },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_sor_of_match);
 
diff --git a/drivers/gpu/drm/tegra/vic.c b/drivers/gpu/drm/tegra/vic.c
index 3c2b1ff55deb..ba9abe50b097 100644
--- a/drivers/gpu/drm/tegra/vic.c
+++ b/drivers/gpu/drm/tegra/vic.c
@@ -484,7 +484,7 @@ static const struct of_device_id tegra_vic_of_match[] = {
 	{ .compatible = "nvidia,tegra194-vic", .data = &vic_t194_config },
 	{ .compatible = "nvidia,tegra234-vic", .data = &vic_t234_config },
 	{ .compatible = "nvidia,tegra264-vic", .data = &vic_t264_config },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tegra_vic_of_match);
 
diff --git a/drivers/gpu/drm/tidss/tidss_drv.c b/drivers/gpu/drm/tidss/tidss_drv.c
index 7e7f2ba6ae82..a5b497a120fe 100644
--- a/drivers/gpu/drm/tidss/tidss_drv.c
+++ b/drivers/gpu/drm/tidss/tidss_drv.c
@@ -236,12 +236,12 @@ static void tidss_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id tidss_of_table[] = {
-	{ .compatible = "ti,k2g-dss", .data = &dispc_k2g_feats, },
-	{ .compatible = "ti,am625-dss", .data = &dispc_am625_feats, },
-	{ .compatible = "ti,am62a7-dss", .data = &dispc_am625_feats, },
-	{ .compatible = "ti,am62l-dss", .data = &dispc_am62l_feats, },
-	{ .compatible = "ti,am65x-dss", .data = &dispc_am65x_feats, },
-	{ .compatible = "ti,j721e-dss", .data = &dispc_j721e_feats, },
+	{ .compatible = "ti,k2g-dss", .data = &dispc_k2g_feats },
+	{ .compatible = "ti,am625-dss", .data = &dispc_am625_feats },
+	{ .compatible = "ti,am62a7-dss", .data = &dispc_am625_feats },
+	{ .compatible = "ti,am62l-dss", .data = &dispc_am62l_feats },
+	{ .compatible = "ti,am65x-dss", .data = &dispc_am65x_feats },
+	{ .compatible = "ti,j721e-dss", .data = &dispc_j721e_feats },
 	{ }
 };
 
diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index e82cb2686c5f..d93bff1758ae 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -479,9 +479,9 @@ static void tilcdc_pdev_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id tilcdc_of_match[] = {
-		{ .compatible = "ti,am33xx-tilcdc", .data = (void *)AM33XX_TILCDC},
-		{ .compatible = "ti,da850-tilcdc", .data = (void *)DA850_TILCDC},
-		{ },
+		{ .compatible = "ti,am33xx-tilcdc", .data = (void *)AM33XX_TILCDC },
+		{ .compatible = "ti,da850-tilcdc", .data = (void *)DA850_TILCDC },
+		{ }
 };
 MODULE_DEVICE_TABLE(of, tilcdc_of_match);
 
diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
index 32f6e98ba9c5..375a050ae316 100644
--- a/drivers/gpu/drm/tiny/arcpgu.c
+++ b/drivers/gpu/drm/tiny/arcpgu.c
@@ -516,8 +516,8 @@ static void arcpgu_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id arcpgu_of_table[] = {
-	{.compatible = "snps,arcpgu"},
-	{}
+	{ .compatible = "snps,arcpgu" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(of, arcpgu_of_table);
diff --git a/drivers/gpu/drm/tiny/ili9225.c b/drivers/gpu/drm/tiny/ili9225.c
index 970abe1e9096..6ee8e01a54ae 100644
--- a/drivers/gpu/drm/tiny/ili9225.c
+++ b/drivers/gpu/drm/tiny/ili9225.c
@@ -419,13 +419,13 @@ static const struct drm_driver ili9225_driver = {
 
 static const struct of_device_id ili9225_of_match[] = {
 	{ .compatible = "vot,v220hf01a-t" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ili9225_of_match);
 
 static const struct spi_device_id ili9225_id[] = {
 	{ .name = "v220hf01a-t" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, ili9225_id);
 
diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index a4b82bbf98f8..43f85e976955 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -245,7 +245,7 @@ static const struct drm_driver ili9486_driver = {
 static const struct of_device_id ili9486_of_match[] = {
 	{ .compatible = "waveshare,rpi-lcd-35" },
 	{ .compatible = "ozzmaker,piscreen" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, ili9486_of_match);
 
diff --git a/drivers/gpu/drm/tiny/mi0283qt.c b/drivers/gpu/drm/tiny/mi0283qt.c
index 072326ef2e1e..9f574fe64021 100644
--- a/drivers/gpu/drm/tiny/mi0283qt.c
+++ b/drivers/gpu/drm/tiny/mi0283qt.c
@@ -226,13 +226,13 @@ static const struct drm_driver mi0283qt_driver = {
 
 static const struct of_device_id mi0283qt_of_match[] = {
 	{ .compatible = "multi-inno,mi0283qt" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, mi0283qt_of_match);
 
 static const struct spi_device_id mi0283qt_id[] = {
 	{ .name = "mi0283qt" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, mi0283qt_id);
 
diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index ffff6acf7dea..fea28f7075f2 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -537,13 +537,13 @@ static const struct dev_pm_ops panel_mipi_dbi_pm_ops = {
 
 static const struct of_device_id panel_mipi_dbi_spi_of_match[] = {
 	{ .compatible = "panel-mipi-dbi-spi" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, panel_mipi_dbi_spi_of_match);
 
 static const struct spi_device_id panel_mipi_dbi_spi_id[] = {
 	{ .name = "panel-mipi-dbi-spi" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, panel_mipi_dbi_spi_id);
 
diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
index 456887546034..e724c1815db2 100644
--- a/drivers/gpu/drm/tiny/pixpaper.c
+++ b/drivers/gpu/drm/tiny/pixpaper.c
@@ -1148,7 +1148,7 @@ MODULE_DEVICE_TABLE(spi, pixpaper_ids);
 
 static const struct of_device_id pixpaper_dt_ids[] = {
 	{ .compatible = "mayqueen,pixpaper" },
-	{}
+	{ }
 };
 MODULE_DEVICE_TABLE(of, pixpaper_dt_ids);
 
diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index cebd48addc40..86c43f38c422 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -989,7 +989,7 @@ static const struct of_device_id repaper_of_match[] = {
 	{ .compatible = "pervasive,e1190cs021", .data = (void *)E1190CS021 },
 	{ .compatible = "pervasive,e2200cs021", .data = (void *)E2200CS021 },
 	{ .compatible = "pervasive,e2271cs021", .data = (void *)E2271CS021 },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, repaper_of_match);
 
@@ -998,7 +998,7 @@ static const struct spi_device_id repaper_id[] = {
 	{ .name = "e1190cs021", .driver_data = E1190CS021 },
 	{ .name = "e2200cs021", .driver_data = E2200CS021 },
 	{ .name = "e2271cs021", .driver_data = E2271CS021 },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, repaper_id);
 
diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index e3367e433a2e..1113d2089152 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -430,7 +430,7 @@ static const struct spi_device_id sharp_memory_ids[] = {
 	{ .name = "ls027b7dh01a", .driver_data = (kernel_ulong_t)&sharp_memory_ls027b7dh01_mode },
 	{ .name = "ls032b7dd02", .driver_data = (kernel_ulong_t)&sharp_memory_ls032b7dd02_mode },
 	{ .name = "ls044q7dh01", .driver_data = (kernel_ulong_t)&sharp_memory_ls044q7dh01_mode },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(spi, sharp_memory_ids);
 
@@ -445,7 +445,7 @@ static const struct of_device_id sharp_memory_of_match[] = {
 	{ .compatible = "sharp,ls027b7dh01a", .data = &sharp_memory_ls027b7dh01_mode },
 	{ .compatible = "sharp,ls032b7dd02", .data = &sharp_memory_ls032b7dd02_mode },
 	{ .compatible = "sharp,ls044q7dh01", .data = &sharp_memory_ls044q7dh01_mode },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, sharp_memory_of_match);
 
diff --git a/drivers/gpu/drm/tve200/tve200_drv.c b/drivers/gpu/drm/tve200/tve200_drv.c
index 3786129e2231..346fdd1a817c 100644
--- a/drivers/gpu/drm/tve200/tve200_drv.c
+++ b/drivers/gpu/drm/tve200/tve200_drv.c
@@ -251,7 +251,7 @@ static const struct of_device_id tve200_of_match[] = {
 	{
 		.compatible = "faraday,tve200",
 	},
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, tve200_of_match);
 
diff --git a/drivers/gpu/drm/v3d/v3d_drv.c b/drivers/gpu/drm/v3d/v3d_drv.c
index b790be8a7fac..750027d4ca79 100644
--- a/drivers/gpu/drm/v3d/v3d_drv.c
+++ b/drivers/gpu/drm/v3d/v3d_drv.c
@@ -301,7 +301,7 @@ static const struct of_device_id v3d_of_match[] = {
 	{ .compatible = "brcm,2712-v3d", .data = (void *)V3D_GEN_71 },
 	{ .compatible = "brcm,7268-v3d", .data = (void *)V3D_GEN_33 },
 	{ .compatible = "brcm,7278-v3d", .data = (void *)V3D_GEN_41 },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, v3d_of_match);
 
diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index f42cd5353230..f1a520e238dd 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -1341,7 +1341,7 @@ static const struct of_device_id vc4_crtc_dt_match[] = {
 	{ .compatible = "brcm,bcm2711-pixelvalve4", .data = &bcm2711_pv4_data },
 	{ .compatible = "brcm,bcm2712-pixelvalve0", .data = &bcm2712_pv0_data },
 	{ .compatible = "brcm,bcm2712-pixelvalve1", .data = &bcm2712_pv1_data },
-	{}
+	{ }
 };
 
 static void vc4_set_crtc_possible_masks(struct drm_device *drm,
diff --git a/drivers/gpu/drm/vc4/vc4_dpi.c b/drivers/gpu/drm/vc4/vc4_dpi.c
index e0d565de42b5..598d3fa62734 100644
--- a/drivers/gpu/drm/vc4/vc4_dpi.c
+++ b/drivers/gpu/drm/vc4/vc4_dpi.c
@@ -274,7 +274,7 @@ static const struct drm_encoder_funcs vc4_dpi_encoder_funcs = {
 
 static const struct of_device_id vc4_dpi_dt_match[] = {
 	{ .compatible = "brcm,bcm2835-dpi", .data = NULL },
-	{}
+	{ }
 };
 
 /* Sets up the next link in the display chain */
diff --git a/drivers/gpu/drm/vc4/vc4_drv.c b/drivers/gpu/drm/vc4/vc4_drv.c
index 6072b4e1ffed..c117c2a9b1bd 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.c
+++ b/drivers/gpu/drm/vc4/vc4_drv.c
@@ -440,7 +440,7 @@ static const struct of_device_id vc4_of_match[] = {
 	{ .compatible = "brcm,bcm2712-vc6", .data = (void *)VC4_GEN_6_C },
 	{ .compatible = "brcm,bcm2835-vc4", .data = (void *)VC4_GEN_4 },
 	{ .compatible = "brcm,cygnus-vc4", .data = (void *)VC4_GEN_4 },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, vc4_of_match);
 
diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index 3e231f875725..317c76580ad3 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1453,7 +1453,7 @@ static const struct of_device_id vc4_dsi_dt_match[] = {
 	{ .compatible = "brcm,bcm2711-dsi1", .data = &bcm2711_dsi1_variant },
 	{ .compatible = "brcm,bcm2835-dsi0", .data = &bcm2835_dsi0_variant },
 	{ .compatible = "brcm,bcm2835-dsi1", .data = &bcm2835_dsi1_variant },
-	{}
+	{ }
 };
 
 static void dsi_handle_error(struct vc4_dsi *dsi,
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index f3ec65d86078..78e75e3b69d2 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -3328,7 +3328,7 @@ static const struct of_device_id vc4_hdmi_dt_match[] = {
 	{ .compatible = "brcm,bcm2711-hdmi1", .data = &bcm2711_hdmi1_variant },
 	{ .compatible = "brcm,bcm2712-hdmi0", .data = &bcm2712_hdmi0_variant },
 	{ .compatible = "brcm,bcm2712-hdmi1", .data = &bcm2712_hdmi1_variant },
-	{}
+	{ }
 };
 
 static const struct dev_pm_ops vc4_hdmi_pm_ops = {
diff --git a/drivers/gpu/drm/vc4/vc4_hvs.c b/drivers/gpu/drm/vc4/vc4_hvs.c
index 537aaa992129..c00bc70ee68a 100644
--- a/drivers/gpu/drm/vc4/vc4_hvs.c
+++ b/drivers/gpu/drm/vc4/vc4_hvs.c
@@ -1804,7 +1804,7 @@ static const struct of_device_id vc4_hvs_dt_match[] = {
 	{ .compatible = "brcm,bcm2711-hvs" },
 	{ .compatible = "brcm,bcm2712-hvs" },
 	{ .compatible = "brcm,bcm2835-hvs" },
-	{}
+	{ }
 };
 
 struct platform_driver vc4_hvs_driver = {
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 642953cba25f..c96b3e198c9c 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -645,7 +645,7 @@ static const struct of_device_id vc4_txp_dt_match[] = {
 	{ .compatible = "brcm,bcm2712-mop", .data = &bcm2712_mop_data },
 	{ .compatible = "brcm,bcm2712-moplet", .data = &bcm2712_moplet_data },
 	{ .compatible = "brcm,bcm2835-txp", .data = &bcm2835_txp_data },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 struct platform_driver vc4_txp_driver = {
diff --git a/drivers/gpu/drm/vc4/vc4_v3d.c b/drivers/gpu/drm/vc4/vc4_v3d.c
index b60614a820eb..1edb1a0a0a64 100644
--- a/drivers/gpu/drm/vc4/vc4_v3d.c
+++ b/drivers/gpu/drm/vc4/vc4_v3d.c
@@ -535,7 +535,7 @@ static void vc4_v3d_dev_remove(struct platform_device *pdev)
 const struct of_device_id vc4_v3d_dt_match[] = {
 	{ .compatible = "brcm,bcm2835-v3d" },
 	{ .compatible = "brcm,cygnus-v3d" },
-	{}
+	{ }
 };
 
 struct platform_driver vc4_v3d_driver = {
diff --git a/drivers/gpu/drm/vc4/vc4_vec.c b/drivers/gpu/drm/vc4/vc4_vec.c
index d46c164c4393..0decbb69f2a7 100644
--- a/drivers/gpu/drm/vc4/vc4_vec.c
+++ b/drivers/gpu/drm/vc4/vc4_vec.c
@@ -765,7 +765,7 @@ static const struct vc4_vec_variant bcm2711_vec_variant = {
 static const struct of_device_id vc4_vec_dt_match[] = {
 	{ .compatible = "brcm,bcm2835-vec", .data = &bcm2835_vec_variant },
 	{ .compatible = "brcm,bcm2711-vec", .data = &bcm2711_vec_variant },
-	{ /* sentinel */ },
+	{ /* sentinel */ }
 };
 
 static int vc4_vec_bind(struct device *dev, struct device *master, void *data)
diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c b/drivers/gpu/drm/verisilicon/vs_dc.c
index f912da60575c..fb5af86d466f 100644
--- a/drivers/gpu/drm/verisilicon/vs_dc.c
+++ b/drivers/gpu/drm/verisilicon/vs_dc.c
@@ -24,7 +24,7 @@ static const struct regmap_config vs_dc_regmap_cfg = {
 
 static const struct of_device_id vs_dc_driver_dt_match[] = {
 	{ .compatible = "verisilicon,dc" },
-	{},
+	{ }
 };
 MODULE_DEVICE_TABLE(of, vs_dc_driver_dt_match);
 
diff --git a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
index 53ab1a2a5aaf..6733e3ef3213 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_dpsub.c
@@ -293,8 +293,8 @@ static void zynqmp_dpsub_shutdown(struct platform_device *pdev)
 }
 
 static const struct of_device_id zynqmp_dpsub_of_match[] = {
-	{ .compatible = "xlnx,zynqmp-dpsub-1.7", },
-	{ /* end of table */ },
+	{ .compatible = "xlnx,zynqmp-dpsub-1.7" },
+	{ /* end of table */ }
 };
 MODULE_DEVICE_TABLE(of, zynqmp_dpsub_of_match);
 
diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index faaab789ccdb..4fb5c16c1501 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -328,16 +328,16 @@ static const struct host1x_info host1x10_info = {
 };
 
 static const struct of_device_id host1x_of_match[] = {
-	{ .compatible = "nvidia,tegra264-host1x", .data = &host1x10_info, },
-	{ .compatible = "nvidia,tegra234-host1x", .data = &host1x08_info, },
-	{ .compatible = "nvidia,tegra194-host1x", .data = &host1x07_info, },
-	{ .compatible = "nvidia,tegra186-host1x", .data = &host1x06_info, },
-	{ .compatible = "nvidia,tegra210-host1x", .data = &host1x05_info, },
-	{ .compatible = "nvidia,tegra124-host1x", .data = &host1x04_info, },
-	{ .compatible = "nvidia,tegra114-host1x", .data = &host1x02_info, },
-	{ .compatible = "nvidia,tegra30-host1x", .data = &host1x01_info, },
-	{ .compatible = "nvidia,tegra20-host1x", .data = &host1x01_info, },
-	{ },
+	{ .compatible = "nvidia,tegra264-host1x", .data = &host1x10_info },
+	{ .compatible = "nvidia,tegra234-host1x", .data = &host1x08_info },
+	{ .compatible = "nvidia,tegra194-host1x", .data = &host1x07_info },
+	{ .compatible = "nvidia,tegra186-host1x", .data = &host1x06_info },
+	{ .compatible = "nvidia,tegra210-host1x", .data = &host1x05_info },
+	{ .compatible = "nvidia,tegra124-host1x", .data = &host1x04_info },
+	{ .compatible = "nvidia,tegra114-host1x", .data = &host1x02_info },
+	{ .compatible = "nvidia,tegra30-host1x", .data = &host1x01_info },
+	{ .compatible = "nvidia,tegra20-host1x", .data = &host1x01_info },
+	{ }
 };
 MODULE_DEVICE_TABLE(of, host1x_of_match);
 
diff --git a/drivers/gpu/host1x/tegra114-mipi.c b/drivers/gpu/host1x/tegra114-mipi.c
index 49ed05d1a623..bf2b245268b0 100644
--- a/drivers/gpu/host1x/tegra114-mipi.c
+++ b/drivers/gpu/host1x/tegra114-mipi.c
@@ -437,7 +437,7 @@ static const struct of_device_id tegra_mipi_of_match[] = {
 	{ .compatible = "nvidia,tegra124-mipi", .data = &tegra124_mipi_soc },
 	{ .compatible = "nvidia,tegra132-mipi", .data = &tegra132_mipi_soc },
 	{ .compatible = "nvidia,tegra210-mipi", .data = &tegra210_mipi_soc },
-	{ },
+	{ }
 };
 
 static int tegra_mipi_probe(struct platform_device *pdev)
diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index d18c68e2a555..7dbe2a8f39e8 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -833,10 +833,10 @@ static struct ipu_devtype ipu_type_imx6q = {
 };
 
 static const struct of_device_id imx_ipu_dt_ids[] = {
-	{ .compatible = "fsl,imx51-ipu", .data = &ipu_type_imx51, },
-	{ .compatible = "fsl,imx53-ipu", .data = &ipu_type_imx53, },
-	{ .compatible = "fsl,imx6q-ipu", .data = &ipu_type_imx6q, },
-	{ .compatible = "fsl,imx6qp-ipu", .data = &ipu_type_imx6q, },
+	{ .compatible = "fsl,imx51-ipu", .data = &ipu_type_imx51 },
+	{ .compatible = "fsl,imx53-ipu", .data = &ipu_type_imx53 },
+	{ .compatible = "fsl,imx6q-ipu", .data = &ipu_type_imx6q },
+	{ .compatible = "fsl,imx6qp-ipu", .data = &ipu_type_imx6q },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_ipu_dt_ids);
diff --git a/drivers/gpu/ipu-v3/ipu-pre.c b/drivers/gpu/ipu-v3/ipu-pre.c
index 394081114faa..a562fa199a75 100644
--- a/drivers/gpu/ipu-v3/ipu-pre.c
+++ b/drivers/gpu/ipu-v3/ipu-pre.c
@@ -368,8 +368,8 @@ static void ipu_pre_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id ipu_pre_dt_ids[] = {
-	{ .compatible = "fsl,imx6qp-pre", },
-	{ /* sentinel */ },
+	{ .compatible = "fsl,imx6qp-pre" },
+	{ /* sentinel */ }
 };
 
 struct platform_driver ipu_pre_drv = {
diff --git a/drivers/gpu/ipu-v3/ipu-prg.c b/drivers/gpu/ipu-v3/ipu-prg.c
index 9fd5c7092319..5a1905fa1cd4 100644
--- a/drivers/gpu/ipu-v3/ipu-prg.c
+++ b/drivers/gpu/ipu-v3/ipu-prg.c
@@ -463,8 +463,8 @@ static const struct dev_pm_ops prg_pm_ops = {
 };
 
 static const struct of_device_id ipu_prg_dt_ids[] = {
-	{ .compatible = "fsl,imx6qp-prg", },
-	{ /* sentinel */ },
+	{ .compatible = "fsl,imx6qp-prg" },
+	{ /* sentinel */ }
 };
 
 struct platform_driver ipu_prg_drv = {
-- 
2.56.0.rc1

