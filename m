Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FA4369A
	for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683203; cv=pass; b=bTtZBUBDePv3B6stYqV5M4NM7JyC5wdBYOGLoqtOp1M1ffaxn3xdVAtGTBPfHsrVJ1AxA2e7RzdwdgtsdQbnRvvfBK6Hx5t2plitXZnAh8KlxoLwnI+pcVriDVFJdVSJBLveqhq+EeSz/x2aq9gMd0J2lJxa+N7Uz2uU9s3WyyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683203; c=relaxed/simple;
	bh=SSi+4NmtMxNkZmxsfuesKYnZ20ScCmyOkzMthR0BMj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sJRNvw1ta0SMid9Ow5nkcpcbodb7ySyCwVJDmvVMTMgUi3mR77r+3gPpKlSX+QYGEBENvCkoJL1GnuvTsgiuUL/Uej9p1vA++XodNBRnb774ZYPQeX6Spm5RkeQaKNgFR2u9LV+Ybf08cDPYqLpL35RUxwCxJ26fKZmLnuBskeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKmZ1buW; arc=pass smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKmZ1buW"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-45eb2e6402aso166186fac.0
        for <virtualization@lists.linux.dev>; Tue, 25 Aug 2026 11:40:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787683200; cv=none;
        d=google.com; s=arc-20260327;
        b=A2VoFAj/TzXtXUhWn4MUU0CwDbF0MneT9O0lSbnRhswAHyLmzdbR4bEwNl0GyCUWzb
         GMprNzLx2mz4+DiXp/CZmz90qwMJBGXYgJZsvbJZoF3WbD60Vg5FyrXOWBGFOeks9QTo
         8dy3sT8ieHaW/bcIXktwZpFGVFA5NZaeRQh0q1Qr9Pu6bOl7xC7FaKXokQy5bQMN6CeG
         2dq51EsbSayxbxwtQsV2ODuAy0Kkj2mrWssPZdhOcEYq7HGXcrniD8lYReJFzNOKuazg
         pgGYpoTKh6QceK9bPAxZrEcqOq4fKmc5zD+mp59ru9kSSpg4OglbtinqrHCuVepvRjm5
         NxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SSi+4NmtMxNkZmxsfuesKYnZ20ScCmyOkzMthR0BMj0=;
        fh=G6SholskF+A9kbBwokuoTjw6OKsJgG2MH1r397F4WZ4=;
        b=ZE2uvVWRZMohhC7gJWXuJ2FH48o4RyC9TDStIJgon5H0+CD0dxWpuCdavYwyuTPOBH
         Tn1BVcTXOunqotHlfGqLL/nnvwUWgpA5qCsbt4huGSEVKXARULXAuzNeM9cIOG/Mcxng
         l6gQAnoO2+6SdDFmxXZEnhVSFTGzzw4r9jZ/51pRtl/ykyIrAFlofbal9gIOE2xe6EiA
         AlmxAyFKZETCRb7lotJI8Z8TeCaD0JWzow7TpefbbfeRFAgGEQNWiUXlr/qJzNB67Yc6
         oU03bcgTOsewgafFdWph/0hjEobdXFU3YW2Xldr7Y8tWCEIItJvD3LQlDbxNc+ZlMdP1
         +wfA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787683200; x=1788288000; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SSi+4NmtMxNkZmxsfuesKYnZ20ScCmyOkzMthR0BMj0=;
        b=DKmZ1buWnr04B3CxxhZftQjZkWhSCD5gle9AjMdQPDoNUOj1GQm52ap7IiP3Um61i1
         rEoa8NhXwYoOOJthK/Fy3H6tr1+447WHxRb01vWa+7+pv7/uIXdg9odWObRfksWo/t0x
         vRGMY65pbThVSGx+7BsYm8re+gpGDypmYNL3zMxBzVsxk0srl9j1A1YUtbeShLZ/qxWg
         mFPCUiy1DZlPwSzUxq8eBEhs9Yuw9haBhamzKhoEGUK+ld9qkNfSjbNoxpMc0tIfrOc/
         Y7csbM4FLUkhICXOiR0twpJ+pl/xwtvpCIqWAIPUZAqpC3X9DAfOtZl/ee7Z4W6z9Ux0
         X+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683200; x=1788288000;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SSi+4NmtMxNkZmxsfuesKYnZ20ScCmyOkzMthR0BMj0=;
        b=EKTkNqj7p+12O8xZNGlsLlC06RVy1YG+jl13ZvosTEHFEgZtR17pKvPXPtMb3o9SsM
         4mfKTGzO97wewf8AgFWn2vZocxr8QcQdFx8UmUMK6p5axczSy+pstb5hTcYeEgKtj/OU
         f/VloHvFU52J2hQnjKl39ujDn+TCGeQpMHu1sP0xYNlnjdAeZBw86tudjBjVdEQU9EuP
         HEx6g22dsV3lLfC3ey5RRGSzBnAF6lu1LqhS8qtCRu4mENYO9i9tcFlfEvnNY14SU0Wy
         VIsJtJlCFFas7lFc9Ak28WpAdCdFRcFi5vlP+pN/5ju6V+8QrZxudAAU5XCcNvpjAxLd
         5/pA==
X-Forwarded-Encrypted: i=1; AHgh+RpikAI1j6YVLwNzEfB/lq0N4rLibAcA16UY5y36co0Fw/tEzeeHR3K34B5blzYmAuowl0g4DIp86DNU5zJ2yQ==@lists.linux.dev
X-Gm-Message-State: AFuF++msdXCN5AOaFUNB6H4S6AVaH3gecY/XcXmh99q8y9spBzL2mYiN
	+qor4zZyrO5hkOtWaIutR7+G6D7QdSRb6p0yKSl6Z2G/+DHfNfk4KcFJjRnyjj2M/EQBtUfY74T
	cb+kkIb6SEY4dodjIcKxwptcIyjrUKow=
X-Gm-Gg: AR+sD13qrVBwJzftyPJr4zb+iER0ZqmZPdKnbKjpVD5ftIKCK6NGo1QsNf/yu+tj75C
	MENeisKJIZcH4P68i1X0sHc6AWM14KdYW1aCP7OGMqQJw9o3uZh+2sBcdUvubLcPztawhJFVS5j
	upSpOIilB7Vhiv57tHql9HSKgbG04yijGNCorlNa9FEgG4qh6gGa7Jnrp/bJx35i2pTnxyaJpjW
	WoUjwP1C9Ys7SQ+29zJxndW8ufn6w+hZOeT4kB0e9k9nLqFGTSiQ82Qfns4aUc6T78mIGZljSeW
	NmNm6aMME5oQwLCahteHJKxgWxflgsIo98KQcBGJf+qKng==
X-Received: by 2002:a05:6870:f623:b0:435:16e9:f288 with SMTP id
 586e51a60fabf-4659bb24b93mr1602806fac.20.1787683200126; Tue, 25 Aug 2026
 11:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260720-drm_simple_encoder_init-v2-0-5020b630668a@gmail.com> <e393996a-3ef1-4c43-b762-af8cd0f2a4b6@suse.de>
In-Reply-To: <e393996a-3ef1-4c43-b762-af8cd0f2a4b6@suse.de>
From: Diogo Silva <diogompaissilva@gmail.com>
Date: Tue, 25 Aug 2026 20:39:49 +0200
X-Gm-Features: AcwNN1Va3aTr02pKhzBqoinFUkwxjfSbh2WQ-EpZwUvKwCIdS5rdnwq9NOj-ZWw
Message-ID: <CAJpoHp56yo+eQAYjvR3ez=HTSzapCd3dYppo=MdPx-Lm4J4DQg@mail.gmail.com>
Subject: Re: [PATCH v2 00/15] drm/drm_simple: remove drm_simple_encoder_init
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

> Diogo, do you want to send out another revision? Otherwise it's time to
> get these patches merged.

I would keep them as is, unless you see anything that should really be
improved before merging.

Best regards,
Diogo
