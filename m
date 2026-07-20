Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982622D738F
	for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560530; cv=pass; b=bk4jqgmzQZ7S93NnnghRh0B7fjsmXdqTHnrfGDormCuBTeSMBnP+9H+gRRbARbNQRVZFeh4XObzVeVv0ihHZ9nP6Zao7aD2XowBIomyjLa0W5DnhyugFX3id653nyUWmtovZNcX0k7NYLZcMUdndnZn5590Y1pBwj8gdiyfnEdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560530; c=relaxed/simple;
	bh=6GA5/FZ0UEBjIo3jsFJRPrVNv7cnVsaH+IUEN70k1s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K+cF+Pxux/mzlrTu3EDEws1M8dopwGd8bR58Cy4VphtVTEDp/N2udVgJ3y/KNqJO24RSwylH/BAb7qdWXWTy8ywZ7W5jB/7HunwozD/ryjBfweqczJemmFdHxmay4D2pXqLzgFqwHdTv2qxgBwU9ujcEStD5bvUDx6f9KFEreY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diWsUKkg; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diWsUKkg"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-451fd21113cso3047124fac.1
        for <virtualization@lists.linux.dev>; Mon, 20 Jul 2026 08:15:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784560527; cv=none;
        d=google.com; s=arc-20260327;
        b=CVdq1Vg2g3TnlcyB4OAO9Imbo+Fl5nm2PNDOBl3cbtVO/PXJ5FwiuPRhl8bQCqZRa6
         3OnzUEaDikl01DMZ9T/eSIYB+N8u10dtMVXlz++3yXrgxSYDn8Fr9Yl5jS4Frb3Umn1h
         Zt8v4nzFTacw4q/XLZfHP4+pAfUYz5ijhIbTh7P5TRB1HydTYDvhDW5waduli3t/t5e0
         YBrdfgb+qyApYdgWKhM84YN9BLmj6XayyHTeSX5Okvf1kbmeXzcGpSqs+6utFdsZjeC0
         Muun1onY7EZeYAIUVdO5pbVX/wC6bLBtPlaQj2sFedG/gAVUoO+gySAaFbX1y6nZSWoa
         uP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6GA5/FZ0UEBjIo3jsFJRPrVNv7cnVsaH+IUEN70k1s4=;
        fh=yv7/+aETDbHO4rexqfUFfFE9ih2hGlH2QXfZAiiNgag=;
        b=slTprq0fjBMuGpiwusouzvrE52ObYjJVVoFmHkz6Rqt/9oVTIGiJRr7ywFOFhRB2Tu
         Vn8a33XcydRrzxs0a/9cXzm4Ep+qNqudjclq9i/yL2Hqsc38porPN9nGVBOpyXNkBMZL
         ECRt+zBRzzOrypQ3m/q/S4fPGv8DwuT2Y7inZcx2pOp9O7sbLmKgVIBbq1RurV1DReAG
         rqAYRLh3QT1Hpmikh4ElbukgOyimEsvPf4xOfJzWy7aRpkuawiJWfLiR6LoK1ij9g5F5
         CkevXgsnASoCtWmpNMSxYDvUpdovCR1FhXrWvsbmIg6cOnCNQJCJ+pAI27cIu0SB/zo3
         1Dbw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784560527; x=1785165327; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6GA5/FZ0UEBjIo3jsFJRPrVNv7cnVsaH+IUEN70k1s4=;
        b=diWsUKkgp50drBPSLhl8+vTiUz9rIa32Urjr7TT8fymBoG4wHQohE/k5Hgeye4xgTt
         rWIJY3/ylqqKIwDaK0SOANcGmxQALF/VRRj6wZxh/UnGfR9ABKLMBQHKNvilCfK9lELp
         iFPV63T3Rj/afIRKfGophmum6K9jwbnSxNvM43zNUBTRcrS079gYE72Weu0CFugoDUNA
         biVCPKXNItIpBv+iiE2++yUxdUhamEotAsyV7HmyMKoQ+PGkLOpxVCq9YNFuN4QJtRX1
         sd2BV0d9y2/OGwSVEX5b4ydvDMEWDdPPesQNELJp82FLJ0LOfrosuWB0bwA6HHaeubvu
         UGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784560527; x=1785165327;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6GA5/FZ0UEBjIo3jsFJRPrVNv7cnVsaH+IUEN70k1s4=;
        b=lAmHczhDZKaBQkJnxXk3ivzAMrRC4Rxy+GUBxova1bY+ZB4KEUtKtBVIbm5/3giD0v
         +uTu9ti2rca7QqWidiKGF58caSZ0ysYtWUty3fVqwsh2nC8QHvu79qyVx2ruMiPEcwPE
         28ZLD0b/4bdicyingpIdNe960tNN09uWG0816uVJSu5fHg834VBrbt0urPk5GlcldBP9
         NA06zQ6oLi9x7yCCzeIP55GE7+QFGA34EHU+UOuprTjzQAXLRKsYWVEx2IcTS1TULttt
         2TWaT8/xO2HqyRWISAC1oAl99Di4tTZuwANuEiHIR+/tHfnzMOMzeQSfEKrmLN7SBajw
         Dznw==
X-Forwarded-Encrypted: i=1; AHgh+RprGervq8TmkH4KJhDwo89CKog5RXDSWrYrNGt5JCanH2f3VZwVldE551MQWN8cOK3g4Y2cyhJG3x9FZl8adw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yww6iQlLwTL+q0wJf3dO4BizKyBA2ptnkorcWkB+bVewiogAcrr
	P5IEo0/3hVA9DuqsNOW0SDRvtCiW9OM/gvrJBVgL6DRA23WSyPdjVhtW1UbGkwRF2inW7pYo4Hx
	bq/3zbRnRWVydErvyv9JZjX0aLYhc0mY=
X-Gm-Gg: AfdE7cnmzUo+b4/IupcJ3Sau1QCKeVvDLlMF/k/Nj6L2gG+XacOG2sLaOHP5gDRAOop
	WIXW8+VEn+Uq7tpi60vV2m9RtWQoetwpsxA/6pvGBLuPMHin8ozV1gsk0TN/8eYwMzCC25twBzu
	kPhbbZM8ZNg8cCAgvJXtWz7QI5W/vElXTmAKAdAvYjEBfKcTNIorxh1OKd5ufvNV7q8ey5ValaJ
	AGk/JncC6yRDHzXzS+PaPXiMQIs7lazKzy2xx9VTZvuvwgWT85nqmcNEYhxmhaLefk1fFc8EMbG
	YcrOcNnnamWRmwWnPVxgAR8C55M=
X-Received: by 2002:a05:687c:260d:b0:435:bfb7:695d with SMTP id
 586e51a60fabf-45661144d55mr7411947fac.27.1784560527422; Mon, 20 Jul 2026
 08:15:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260719-drm_simple_encoder_init-v1-0-a78c509e3062@gmail.com>
 <20260719-drm_simple_encoder_init-v1-1-a78c509e3062@gmail.com> <4af254a4-beb7-4f77-830f-42d5bacb10a4@suse.de>
In-Reply-To: <4af254a4-beb7-4f77-830f-42d5bacb10a4@suse.de>
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Mon, 20 Jul 2026 17:15:13 +0200
X-Gm-Features: AUfX_mw73hUQoweWxVmRQ0kaDeRwypjcxis2alI1xmtq6INWQD6CfuNjqz3kn5o
Message-ID: <CAJpoHp73S2_cavgV3aVwC5PS8H1GRqTdDV-Xu8n6nXavBnV2=g@mail.gmail.com>
Subject: Re: [PATCH 01/15] drm/exynos: remove dependency on DRM simple helpers
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jingoo Han <jingoohan1@gmail.com>, Inki Dae <inki.dae@samsung.com>, 
	Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Thierry Reding <thierry.reding@kernel.org>, 
	Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Stefan Agner <stefan@agner.ch>, Alison Wang <alison.wang@nxp.com>, 
	Anitha Chrisanthus <anitha.chrisanthus@intel.com>, David Airlie <airlied@redhat.com>, 
	Gerd Hoffmann <kraxel@redhat.com>, Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
	Jyri Sarha <jyri.sarha@iki.fi>, Liu Ying <victor.liu@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Xinliang Liu <xinliang.liu@linaro.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Yongqin Liu <yongqin.liu@linaro.org>, 
	John Stultz <jstultz@google.com>, Liviu Dudau <liviu.dudau@arm.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
	virtualization@lists.linux.dev, imx@lists.linux.dev, 
	linux-mediatek@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey,

> Again, you rather want drm_err() with drm_dev here.
>
> I've briefly looked over the series and many patches seem affected.
> Please prefer drm_ logging functions and DRM devices over the plain
> device equivalents.

Thanks. I will submit a v2 with consistent usage of drm_err().

Also, is there any ongoing task or would it be useful to submit patches
changing the usage of DRM_DEV_* functions with drm_* equivalents?
Or from dev_* to drm_* when possible ?

BR,
Diogo
