Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407DA1C3C05
	for <virtualization@lists.linux.dev>; Fri,  3 Jan 2025 10:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735900690; cv=none; b=pKHNxQvnm/JwG6PirnINDxrg45mTJrT7dEW8iM6AQK55mVXS/KZoga1axYueAkVvbIoxKtEp/r9AVkv6Jo8nLLK8yRtHg/McbB220xid/I6F+FNWgD+WKBoVVla4sNqXAe2LDqA+XbgqydKjLHPLMiAmWFLJxSrRuWlgvS+v0mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735900690; c=relaxed/simple;
	bh=zf1Qd/rdFgcCeMiMrMD2D9UGtnejpU6H0F32as4UNFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hemPd5zC2eCXeO4IrsjqoWxhqMQTBv3r5cQ7slrs44IHHqvMXMQGQAoHimqKepNNGZ9uwOTNc5Ln/kp1aty9GQHCy7eVmzfVtSMzNvKLX/iBsGaf+KqxSaTlc2gxORit+3EgeAMEVqb/Iy6cf60B7JWCWcr1LvOA04vOh6B/Hvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NbnIDU3h; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbnIDU3h"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30225b2586cso140659091fa.0
        for <virtualization@lists.linux.dev>; Fri, 03 Jan 2025 02:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735900686; x=1736505486; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/m618hW0R2m1nQFr2zn8iDxB4stTlPC9L/MKkQZd3FA=;
        b=NbnIDU3hroXE9/gheiozLZsq3Qvevo/3rbGsbeeRwbliaM05uZ1lPrh1aswZmCW4PI
         WBh/pLcuGAxN9pICy+48EqstiT2wFSk014/hpQEAQuK86txdN2fSPCPEZsqTUsTTK9c8
         ahnR7i3GxyfVA3JjEpgfpAaG4xUCNcN8f6RkoOsqr40mcBDcmtRAiqGlOS0P/xcrrMQV
         b6lFUME6TXHXQx/3lhVytZcxG4wVspULL0kFzb5wJeOmBNy6yoqq6xKhvri0Xm5yMS8M
         sJytpAV2ravpJmwUwzQgXSDjBxUoRSIpSQ7krrRQLqYR9q8nomLdby6bozaTvRLHqEMy
         MWOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735900686; x=1736505486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/m618hW0R2m1nQFr2zn8iDxB4stTlPC9L/MKkQZd3FA=;
        b=QGdHy6Prk6htwl7YPXz1h+5zk1Xn3U79xCFt+6Widnm+h3ThzBYuu8TK/uN9vcrnnX
         KirMi314UrMIkoZluhr9Iup/qLlMQNiTh9t2kvGmh30wWTwLVVAZdWFtddl7mhKdhe/S
         rm21i/33hE3JFREwYopJ4KiPsMoodC1RPSvbNXdmhbyUSpvoo+JhX1qNKtx+CHRNHWSi
         sspwu30VBpYifpr9JnEFNTKFy9ZrFP+K/iLkO6JvxDzv5e6u0fGDkKpssAjH4VwRKI/n
         QXYWwTgksNQQ+mbnF/F3VIqYwAcxyPqx2LPRJGPEo8KdEK9zgAQXjYaggQklZhCCoaVN
         d0PA==
X-Forwarded-Encrypted: i=1; AJvYcCVYlwQ4v7r1qHSUhAb9mIyMa3bn23YSoKAU8/+6VYYRYw6sL/k86nmH9+I4ILx45ZwBpbGSD4uopsPZKs4hBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJaPbx5e8PJNfUWIV5OclFV3Fcp2rBBDn4u3SvmzU7CROQ/JBh
	EZg9rLJWWz4aEWTyONDXmK4nn3y9DDT6NmzXxK/KcRfxoXFHfI1uy9IJn0lBuxE=
X-Gm-Gg: ASbGncv/1/P07bxZPK+mBWRFt+hduidLP/cSif60EK7/C9K4mXc2bJ7smFvI2dVJKdo
	CUJoCJwIKA8m4ISenCLMNIqsXzGrVC5UFYRYo6G9OF0BqEjPIkts/3IyMiSbG5wuQlHfjyXO8Vo
	ePN11iDvMhRomqpGtxJGR+dk7yu/2utDeFoQI9W1ythK3wWzOVHgTIdAAvHMV5IZ3aM43+nH3pO
	sotH1ECKREnM+YFWejSZMu59tyYLs7OllbdK42pOn6/C33Dz4aFkWkC/GWpKl/uff/aZCVg7JGa
	06spHfQpc41v2KmqHryKEBldtIsWQGPpiXKo
X-Google-Smtp-Source: AGHT+IHqyYKM0jK9B76DdsBNsu1ksVUKqjrNzWi2li/1a+VHxpUAgfWN/haMqHCMVuXOoMkqVNCF/Q==
X-Received: by 2002:a2e:bc1b:0:b0:302:215f:94ee with SMTP id 38308e7fff4ca-30458337550mr161864691fa.4.1735900686412;
        Fri, 03 Jan 2025 02:38:06 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045b096cafsm45400051fa.123.2025.01.03.02.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 02:38:05 -0800 (PST)
Date: Fri, 3 Jan 2025 12:38:03 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/ci: uprev IGT
Message-ID: <gxrc6hqlmjl2pdylvi33wdukxgz6wqbhzgwk4ptyx3i55jshic@uu45kcjailxa>
References: <20241217160655.2371138-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217160655.2371138-1-vignesh.raman@collabora.com>

On Tue, Dec 17, 2024 at 09:36:52PM +0530, Vignesh Raman wrote:
> Uprev IGT to the latest version and update expectation files.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v1:
>   - Pipeline link - https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1327810
>     Will update the flake bug report link after v1 is reviewed.
> 
> v2:
>   - Pipeline link - https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1331363
>     Updated flake test bug report links.
> 
> ---
>  drivers/gpu/drm/ci/gitlab-ci.yml              |   2 +-
>  .../gpu/drm/ci/xfails/amdgpu-stoney-fails.txt |   8 +-
>  .../drm/ci/xfails/amdgpu-stoney-flakes.txt    |  21 +-
>  .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt |   5 +
>  drivers/gpu/drm/ci/xfails/i915-amly-fails.txt |  20 +-
>  .../gpu/drm/ci/xfails/i915-amly-flakes.txt    |  14 +
>  drivers/gpu/drm/ci/xfails/i915-amly-skips.txt |   1 +
>  drivers/gpu/drm/ci/xfails/i915-apl-fails.txt  |   8 +-
>  drivers/gpu/drm/ci/xfails/i915-cml-fails.txt  |  22 +-
>  drivers/gpu/drm/ci/xfails/i915-cml-flakes.txt |   7 +
>  drivers/gpu/drm/ci/xfails/i915-cml-skips.txt  |   1 +
>  drivers/gpu/drm/ci/xfails/i915-glk-fails.txt  |  31 +-
>  drivers/gpu/drm/ci/xfails/i915-glk-flakes.txt |   7 +
>  drivers/gpu/drm/ci/xfails/i915-glk-skips.txt  | 298 ++++++++++
>  drivers/gpu/drm/ci/xfails/i915-jsl-fails.txt  |  18 +-
>  drivers/gpu/drm/ci/xfails/i915-jsl-flakes.txt |  15 +-
>  drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt  | 112 ++++
>  drivers/gpu/drm/ci/xfails/i915-tgl-fails.txt  |  55 +-
>  drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt  |  13 +
>  drivers/gpu/drm/ci/xfails/i915-whl-fails.txt  |  15 +-
>  drivers/gpu/drm/ci/xfails/i915-whl-flakes.txt |   7 +
>  .../drm/ci/xfails/mediatek-mt8173-fails.txt   |   7 +-
>  .../drm/ci/xfails/mediatek-mt8173-flakes.txt  |   7 +
>  .../drm/ci/xfails/mediatek-mt8173-skips.txt   |   5 +
>  .../drm/ci/xfails/mediatek-mt8183-fails.txt   |  12 +-
>  .../drm/ci/xfails/mediatek-mt8183-skips.txt   |   5 +
>  .../gpu/drm/ci/xfails/msm-apq8016-fails.txt   |   3 +
>  .../msm-sc7180-trogdor-kingoftown-fails.txt   |   1 -
>  .../msm-sc7180-trogdor-kingoftown-flakes.txt  |  14 +
>  .../msm-sc7180-trogdor-kingoftown-skips.txt   |   5 +
>  ...sm-sc7180-trogdor-lazor-limozeen-fails.txt |   1 -
>  ...sm-sc7180-trogdor-lazor-limozeen-skips.txt |   5 +
>  .../gpu/drm/ci/xfails/msm-sdm845-fails.txt    |   2 -
>  .../gpu/drm/ci/xfails/msm-sdm845-skips.txt    |   5 +
>  .../drm/ci/xfails/msm-sm8350-hdk-fails.txt    |   5 -
>  .../drm/ci/xfails/rockchip-rk3288-fails.txt   |  26 +-
>  .../drm/ci/xfails/rockchip-rk3399-fails.txt   |  13 +-
>  .../drm/ci/xfails/rockchip-rk3399-flakes.txt  |  56 ++
>  .../drm/ci/xfails/rockchip-rk3399-skips.txt   |   5 +
>  .../drm/ci/xfails/virtio_gpu-none-skips.txt   |   5 +
>  drivers/gpu/drm/ci/xfails/vkms-none-fails.txt |   8 -
>  drivers/gpu/drm/ci/xfails/vkms-none-skips.txt | 543 +++++++++++++++++-
>  42 files changed, 1202 insertions(+), 211 deletions(-)
> 


> diff --git a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> index 066d24ee3e08..7752adff05c1 100644
> --- a/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/msm-apq8016-fails.txt
> @@ -1,4 +1,7 @@
>  kms_3d,Fail
> +kms_cursor_legacy@forked-bo,Fail
> +kms_cursor_legacy@forked-move,Fail
> +kms_cursor_legacy@single-bo,Fail
>  kms_cursor_legacy@torture-bo,Fail
>  kms_force_connector_basic@force-edid,Fail
>  kms_hdmi_inject@inject-4k,Fail

Interesting. Though this might by the platform legacy cursor code (it
doesn't use a plane for cursors).

Anyway,

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # msm

-- 
With best wishes
Dmitry
