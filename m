Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F5013BC36
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714472118; cv=none; b=MyNGFY6H1BEx3t7fsMesyCT3kY0O7xliX3wXA6e7uNtJSblwGBSpWzDVxN8OHlNhJJw8z5C/LQEjUIpHbDePtfhR4BnMk4KYL2AWST0aHQLxl/iQgu4TcvCt/PuGvEB+VYJKV8xKg0/zOC/9FU3DwNgMthdXvdlQy38uj5guvOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714472118; c=relaxed/simple;
	bh=EA/n+63aRQ+LX6Bo2tyrIJSDq4Fz8cHbko3pkS/8djE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdnLLFsHGnUajGQ5ApyM8jv9SNBTgnE9xWq/S74aVpPGm/xpzTjDg7qVsKgYQsvbW0rZ+C+ELCibYuc2d3HXAsKbp4TM+5Qjas2pdOZPk5SIioy2C0lmhiHk9jvLZpGMBB7hgNYBdgMPmCojoIEP9NCc8f9XTwy7ZsU1KTUa/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yFPdrxFM; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yFPdrxFM"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 15BE241193
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 10:15:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GjMjP-dGFMyu for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Apr 2024 10:15:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 894FC40492
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 894FC40492
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yFPdrxFM
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 894FC40492
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 10:15:12 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-51acb95b892so6762057e87.2
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 03:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714472110; x=1715076910; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dIx1dFfAcpeKO8TErHh7vGY1lorqPiA5UlnTCSzH2HY=;
        b=yFPdrxFMcog1C9tTqLZG6O80Ru0vBppU10yDEiFh2XKb/bytZ/YodZVLTY3WqwgXbp
         VCV3CRDAWG9sps2VEFiREQBTtYYH+wiJnrIlV3mrIlAQ699JnrctC/IaWnET1DoEdS/a
         ftxxXSZDk98+vQMR8Bie4qmmQDT/Ee44+moFjfIPeWzj2b5nYhsGePhDJT3VKxLrvSor
         Qlt4jMIzmeSMj+JRFzhiP9+bUvPe1GMnLGiFY9POG710tc4FzKbg0w/fDHfsg0ALPa/P
         TJU9WiFg0CsM01ez+1CfuysPAF3rtGsiIGWRUKYuyC7sEZvPskb/eflPcwqwZeJ0bAzv
         Z6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714472110; x=1715076910;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIx1dFfAcpeKO8TErHh7vGY1lorqPiA5UlnTCSzH2HY=;
        b=dWx9zlCPH9YqER61VGnOnHEFGGybDpGSC3a2Va3mTndyVJGZOmBQNnQkIG7yAS1MJM
         apFcp9P0OuqaHpC6IU9IGkTG1OMZ4bU3Bl1TSqR3RC9DnUtu9gh8A0rrw3hTdqCdYIbX
         xWHqPDV5yfJrORup9kh6YnvbqIv9Q6/sIs9FKKUPzueWnI93JDhHmqPb0Amcv/CyO0NO
         hsVH7Dh2maKesWeLKEQCzdrDfVSl0wrdfhmIbZMwzm0ctelkNBw/VOdUUvr1YpTrTpcU
         ORvZC2cAgWA4BhyURamuVCH3LYK1Yhd7EJDCxLL76eW5Z8nonSJ1TYynpg7jT/700AHC
         IiiA==
X-Forwarded-Encrypted: i=1; AJvYcCUNbwBXpkep2ClbWzBWNIsv4lekqk/vqvAnITWZwtlk1h+XOhLzGbSWq2McCFwKmIQxymYyDk1tFiS5xjhvfvvq4TwVYIFGZmhaYRJA2Pk+WxgkhHAQNQVnlA==
X-Gm-Message-State: AOJu0YyY3PRCL13wouk8FjXFM98kZOAlfBkQ+Lejr2MNGSTO3AT1/sNz
	+iS4eRFLHnGurppGvMybOx9AOKrdGoFTtcS+pC5bKXqWFuTNTdy/8vwi7u+9WWY=
X-Google-Smtp-Source: AGHT+IEeZGVbkW3UvagFGYDQZ5bMmN4VdL24N9F8cduZig7xQbulffwe9LBCfuUp6MPaqlZqlp0YPw==
X-Received: by 2002:ac2:4945:0:b0:516:cf23:588 with SMTP id o5-20020ac24945000000b00516cf230588mr10156881lfi.27.1714472109993;
        Tue, 30 Apr 2024 03:15:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id g29-20020a0565123b9d00b0051d807addd7sm884156lfv.60.2024.04.30.03.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 03:15:09 -0700 (PDT)
Date: Tue, 30 Apr 2024 13:15:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/5] drm/ci: update xfails for the new testlist
Message-ID: <hon4klkoaouuxhtvm3qb3qstsrdcibihksyrmvxkt3taijl6wb@ubitr6namryw>
References: <20240430091121.508099-1-vignesh.raman@collabora.com>
 <20240430091121.508099-6-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430091121.508099-6-vignesh.raman@collabora.com>

On Tue, Apr 30, 2024 at 02:41:21PM +0530, Vignesh Raman wrote:
> Now the testlist is used from IGT build, so update
> xfails with the new testlist.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt | 47 +++++++----
>  .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |  8 +-
>  .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt | 15 ++++
>  drivers/gpu/drm/ci/xfails/i915-amly-fails.txt | 22 ++++-
>  .../gpu/drm/ci/xfails/i915-amly-flakes.txt    |  8 ++
>  drivers/gpu/drm/ci/xfails/i915-amly-skips.txt |  8 ++
>  drivers/gpu/drm/ci/xfails/i915-apl-fails.txt  | 45 +++++-----
>  drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt |  5 ++
>  drivers/gpu/drm/ci/xfails/i915-apl-skips.txt  | 12 +++
>  drivers/gpu/drm/ci/xfails/i915-cml-fails.txt  | 26 +++++-
>  drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt |  6 ++
>  drivers/gpu/drm/ci/xfails/i915-cml-skips.txt  |  8 ++
>  drivers/gpu/drm/ci/xfails/i915-glk-fails.txt  | 28 +++++--
>  drivers/gpu/drm/ci/xfails/i915-glk-skips.txt  | 12 +++
>  drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt  | 39 ++++-----
>  drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt | 10 ++-
>  drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt  | 21 +++++
>  drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt  | 75 +++++++++--------
>  drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt  | 13 +++
>  drivers/gpu/drm/ci/xfails/i915-whl-fails.txt  | 46 +++++------
>  drivers/gpu/drm/ci/xfails/i915-whl-skips.txt  |  8 ++
>  .../drm/ci/xfails/mediatek-mt8173-fails.txt   | 47 +++--------
>  .../drm/ci/xfails/mediatek-mt8183-fails.txt   | 17 +---
>  .../drm/ci/xfails/mediatek-mt8183-flakes.txt  |  5 ++
>  .../gpu/drm/ci/xfails/meson-g12b-fails.txt    | 20 +----
>  .../gpu/drm/ci/xfails/meson-g12b-flakes.txt   |  5 ++
>  .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   | 26 ++----
>  .../gpu/drm/ci/xfails/msm-apq8016-flakes.txt  |  5 ++
>  .../gpu/drm/ci/xfails/msm-apq8096-fails.txt   |  5 +-
>  .../gpu/drm/ci/xfails/msm-apq8096-flakes.txt  |  5 ++
>  .../gpu/drm/ci/xfails/msm-apq8096-skips.txt   | 67 +++++++++++++++
>  .../msm-sc7180-trogdor-kingoftown-fails.txt   | 34 ++++----
>  .../msm-sc7180-trogdor-kingoftown-flakes.txt  |  5 ++
>  ...sm-sc7180-trogdor-lazor-limozeen-fails.txt | 34 ++++----
>  ...m-sc7180-trogdor-lazor-limozeen-flakes.txt |  5 ++
>  .../gpu/drm/ci/xfails/msm-sdm845-fails.txt    | 75 ++++-------------
>  .../gpu/drm/ci/xfails/msm-sdm845-flakes.txt   | 26 ++----
>  .../drm/ci/xfails/rockchip-rk3288-fails.txt   | 54 ------------
>  .../drm/ci/xfails/rockchip-rk3399-fails.txt   | 80 ++----------------
>  .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |  7 --
>  .../drm/ci/xfails/virtio_gpu-none-fails.txt   | 82 +++++++++++++------
>  .../drm/ci/xfails/virtio_gpu-none-skips.txt   |  3 +
>  42 files changed, 574 insertions(+), 495 deletions(-)
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-amly-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8096-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-flakes.txt
>  delete mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3288-fails.txt
>  delete mode 100644 drivers/gpu/drm/ci/xfails/rockchip-rk3399-flakes.txt
> 

[skipped]

> diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> index 44a5c62dedad..96e9faf0e607 100644
> --- a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> @@ -1,19 +1,9 @@
> +core_setmaster_vs_auth,Fail
> +device_reset,Fail
> +dumb_buffer,Fail

This doesn't look correct, core tests should be passing.

>  kms_3d,Fail
> -kms_addfb_basic@addfb25-bad-modifier,Fail
> -kms_cursor_legacy@all-pipes-forked-bo,Fail
> -kms_cursor_legacy@all-pipes-forked-move,Fail
> -kms_cursor_legacy@all-pipes-single-bo,Fail
> -kms_cursor_legacy@all-pipes-single-move,Fail
> -kms_cursor_legacy@all-pipes-torture-bo,Fail
> -kms_cursor_legacy@all-pipes-torture-move,Fail
> -kms_cursor_legacy@pipe-A-forked-bo,Fail
> -kms_cursor_legacy@pipe-A-forked-move,Fail
> -kms_cursor_legacy@pipe-A-single-bo,Fail
> -kms_cursor_legacy@pipe-A-single-move,Fail
> -kms_cursor_legacy@pipe-A-torture-bo,Fail
> -kms_cursor_legacy@pipe-A-torture-move,Fail
> -kms_force_connector_basic@force-edid,Fail
> -kms_hdmi_inject@inject-4k,Fail
> -kms_selftest@drm_format,Timeout
> -kms_selftest@drm_format_helper,Timeout

Fine, kms_cursor_legacy tests were migrated to -flakes. But what
happened with the rest of the failures?

> -msm_mapping@ring,Fail
> +kms_force_connector_basic,Fail
> +kms_lease,Fail
> +msm_mapping,Fail
> +msm_submit,Fail
> +tools_test,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt b/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
> new file mode 100644
> index 000000000000..3cc361b3d3b3
> --- /dev/null
> +++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-flakes.txt
> @@ -0,0 +1,5 @@
> +# Board Name: apq8016-sbc-usb-host
> +# Bug Report: TBD
> +# IGT Version: 1.28-gd2af13d9f
> +# Linux Version: 6.9.0-rc4
> +kms_cursor_legacy

It looks like one of the scripts has lost subtest granularity. It should
be fixed before the patchset can be merged.

-- 
With best wishes
Dmitry
