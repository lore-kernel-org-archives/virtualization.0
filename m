Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE01AB908
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 10:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720088161; cv=none; b=FBMaJr3RIsTV1LzWQpw8QhZ3+OIdhWo88WPeMwX2MSf5t3JqvuWox1ErUmrmT0JiO7yyg/RX9k+7zppG9hiF/Yv7WfcZKZE7HIvE6R7KbrChWjI6QLmNmFRgob8v9U7i7wU5nE+KH1xdePMduBcbEx+fSC16NeHm5wWVcMK2PKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720088161; c=relaxed/simple;
	bh=Vwgi1lg2CshzOJbmksugK2R0s08lIGSQYEuCi3ab+VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q51NQikKm/3q18sazSAolEK9gk1m3DvnTK3yGJHPcCHFqONjezNDNTOfh6repArlMPwFSaQKFv2tZ4R2hi3fffoWmbR/Pu51S3vOfB8StJePGurj/NVa8CFQp5BX9WorvDtQja/PQt8Yyi3JE0pEW1QXVPO/C+OwyXudDmr90lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XtU30mOT; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtU30mOT"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 647336085B
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 10:15:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Ywp2S0nsFFI for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Jul 2024 10:15:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B5B1060008
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5B1060008
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XtU30mOT
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B5B1060008
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 10:15:56 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2ec52fbb50cso4289921fa.2
        for <virtualization@lists.linux-foundation.org>; Thu, 04 Jul 2024 03:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720088154; x=1720692954; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1nvqcTE+d+I6/PYlZYlUrN3ZSE7/0dbyWuREcOgf8aA=;
        b=XtU30mOTn0LjpWwBok5oXt2GfaK7HHVbJSKpAyotnoosZhk8gIgvYEuHL+FFR9D/v3
         SmNvEQ5JznPzLNy7wzWdNhiX7ZnJHp+1gW0GjMHl9na92P+v3cQ3Hoitf9k6EDbtfg4q
         a6jjFTVHkEi6oOshK+UXZcdJokrJfcMi+g8NS29YcPvsh0hkcK4YFLb7tcIf1SPLJzMJ
         DPY4W5kWtJuhKuDM+uq2jdtLtPlEDzfF9lnGVOElWOhWA2h5aqBanbhiJ57ea8BiuWt0
         uQ0zb5Cu21Dl7nLj980LwrZ6xbmRrWGQ/euTjOwtC75jU+A+ZJ3pmyxoHXr7oZnzzVX8
         Gjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720088154; x=1720692954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nvqcTE+d+I6/PYlZYlUrN3ZSE7/0dbyWuREcOgf8aA=;
        b=N5IixFBzFAy3EloTlAAm7JLFuDsXxce6fQx5KVBvvJASsy0Ye4bBXJozGayXAlX6wu
         JkZ+393JaSinuI+f3cu40pbb2OJtFloYmuI8WVbSZlK1hSmNnxepzsgyjY/2xQlBu7Lw
         illvMqp64IXEXzdVi5N9nMEWDKYgfnM11WipmOzLxRJxeO8fbiuvGLcV7VdqGeZQpigB
         YUg2Z8erC3X7uiasLPvqiBFnG35ymVULs/mxH2BCVwtuEUYboQjpgTf6TBJXE1xzdnMu
         61r+xZSW01FkacjC43nSnjWUDAmdaUQ4Yv5zM+gpaCrWZ8xkBlVAoIjt6XByZZdwKxGq
         Fg0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZdyOqoM5L/D84ALjJ5yh6RABvv1repQVLWF2XRQCco6xt1dhOApeI3mPu9TvCTpkIfQ3oxQdOAkV3z+zzAUxRjOrxkxo1pS0DaMef+Bs8OCRv2UVfA+/Gmg==
X-Gm-Message-State: AOJu0Yz6XE+7JLEJ5e591MKIJFy1L8Je4Nf0B/miHzL7Qe1JdTtM7YxK
	RKbxnMLQ0U4JCTkKfXHSI7Pr20YyyPVwkjgdLS1v7vvDByTHofAuahDDFqfhobk=
X-Google-Smtp-Source: AGHT+IFjFbE6dWkiueh16FP2N9UOEw13MN12/uduae8Rfkcs3JR/7QPB7Yfqddj+KjB9xdjW8KZcuw==
X-Received: by 2002:a2e:98c3:0:b0:2ec:5200:a935 with SMTP id 38308e7fff4ca-2ee8edc2d45mr8049801fa.40.1720088154177;
        Thu, 04 Jul 2024 03:15:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee5168cf1fsm22523201fa.116.2024.07.04.03.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 03:15:53 -0700 (PDT)
Date: Thu, 4 Jul 2024 13:15:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, mcanal@igalia.com, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/ci: uprev IGT
Message-ID: <ojnz5hjfht6gwouphvmvizb2udlz2wvwnsj4vgosp3chrhsmcv@c7cxscdyxtsn>
References: <20240704092202.75551-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704092202.75551-1-vignesh.raman@collabora.com>

On Thu, Jul 04, 2024 at 02:52:02PM GMT, Vignesh Raman wrote:
> Uprev IGT to the latest version, which includes a fix for the
> writeback tests issue on MSM devices. Enable debugging for
> igt-runner to log output such as 'Begin test' and 'End test'.
> This will help identify which test causes system freeze or hangs.
> Update xfails and add metadata header for each flake test.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v1:
>   - https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1216850
> 
> ---
>  drivers/gpu/drm/ci/gitlab-ci.yml              |   2 +-
>  drivers/gpu/drm/ci/igt_runner.sh              |   1 +
>  .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |   1 +
>  .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |  14 +-
>  .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt |   4 +-
>  drivers/gpu/drm/ci/xfails/i915-amly-fails.txt |  12 +-
>  .../gpu/drm/ci/xfails/i915-amly-flakes.txt    |  41 ++++-
>  drivers/gpu/drm/ci/xfails/i915-amly-skips.txt |   5 +-
>  drivers/gpu/drm/ci/xfails/i915-apl-flakes.txt |   2 +-
>  drivers/gpu/drm/ci/xfails/i915-apl-skips.txt  |   4 +-
>  drivers/gpu/drm/ci/xfails/i915-cml-fails.txt  |  14 +-
>  drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt |   9 +-
>  drivers/gpu/drm/ci/xfails/i915-cml-skips.txt  |   5 +-
>  drivers/gpu/drm/ci/xfails/i915-glk-fails.txt  |  24 +--
>  drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt |   8 +-
>  drivers/gpu/drm/ci/xfails/i915-glk-skips.txt  |   4 +-
>  drivers/gpu/drm/ci/xfails/i915-kbl-fails.txt  |   2 +
>  drivers/gpu/drm/ci/xfails/i915-kbl-flakes.txt |   2 +-
>  drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt  |   4 +-
>  drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt  |  25 +--
>  drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt  |   4 +-
>  drivers/gpu/drm/ci/xfails/i915-whl-fails.txt  |  17 +-
>  drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt |   2 +-
>  drivers/gpu/drm/ci/xfails/i915-whl-skips.txt  |   5 +-
>  .../drm/ci/xfails/mediatek-mt8173-fails.txt   |   9 +-
>  .../drm/ci/xfails/mediatek-mt8173-flakes.txt  |  32 +++-
>  .../drm/ci/xfails/mediatek-mt8173-skips.txt   |   4 +-
>  .../drm/ci/xfails/mediatek-mt8183-fails.txt   |   2 +-
>  .../drm/ci/xfails/mediatek-mt8183-skips.txt   |   2 +-
>  .../gpu/drm/ci/xfails/meson-g12b-fails.txt    |   2 +-
>  .../gpu/drm/ci/xfails/meson-g12b-skips.txt    |   2 +-
>  .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |   5 +-
>  .../gpu/drm/ci/xfails/msm-apq8016-skips.txt   |   2 +-
>  .../gpu/drm/ci/xfails/msm-apq8096-flakes.txt  |   2 +-
>  .../gpu/drm/ci/xfails/msm-apq8096-skips.txt   |   4 +-

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # msm tests


>  .../msm-sc7180-trogdor-kingoftown-fails.txt   | 145 ------------------
>  .../msm-sc7180-trogdor-kingoftown-flakes.txt  |  18 ++-
>  .../msm-sc7180-trogdor-kingoftown-skips.txt   |   5 +-
>  ...sm-sc7180-trogdor-lazor-limozeen-fails.txt | 145 ------------------
>  ...m-sc7180-trogdor-lazor-limozeen-flakes.txt |  11 +-
>  ...sm-sc7180-trogdor-lazor-limozeen-skips.txt |   2 +-
>  .../gpu/drm/ci/xfails/msm-sdm845-flakes.txt   | 105 ++++++++++++-
>  .../gpu/drm/ci/xfails/msm-sdm845-skips.txt    |   4 +-
>  .../drm/ci/xfails/rockchip-rk3288-fails.txt   |   2 +-
>  .../drm/ci/xfails/rockchip-rk3288-skips.txt   |   2 +-
>  .../drm/ci/xfails/rockchip-rk3399-fails.txt   |   2 +-
>  .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |   4 +-
>  .../drm/ci/xfails/rockchip-rk3399-skips.txt   |   2 +-
>  .../drm/ci/xfails/virtio_gpu-none-fails.txt   |  64 ++++++++
>  .../drm/ci/xfails/virtio_gpu-none-skips.txt   |   4 +-
>  drivers/gpu/drm/ci/xfails/vkms-none-fails.txt |   4 -
>  .../gpu/drm/ci/xfails/vkms-none-flakes.txt    |  21 +++
>  drivers/gpu/drm/ci/xfails/vkms-none-skips.txt | 105 ++++++++++++-
>  53 files changed, 527 insertions(+), 395 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
> index 80fb0f57ae46..b09976c3d2c2 100644
> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
> @@ -5,7 +5,7 @@ variables:
>    UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
>    TARGET_BRANCH: drm-next
>  
> -  IGT_VERSION: 0df7b9b97f9da0e364f5ee30fe331004b8c86b56
> +  IGT_VERSION: f13702b8e4e847c56da3ef6f0969065d686049c5
>  
>    DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/anholt/deqp-runner.git
>    DEQP_RUNNER_GIT_TAG: v0.15.0


-- 
With best wishes
Dmitry
