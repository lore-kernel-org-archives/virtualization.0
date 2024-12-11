Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382DF1EE7C5
	for <virtualization@lists.linux.dev>; Wed, 11 Dec 2024 21:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733953166; cv=none; b=kIk4mY5ItdW50wR3i6St33qnA469dZ3ggEcx0Hxo+NAoeRzI+ar+zvvxzBqfFh2owcTdoAYRM7oMQaPxu8/qYJYPfv4UZhir2+RR30pX5mn2qxGObhR8RPZ79UdNJjQS9eZwsD0Hs63ny0VC8c1Z1SKPWoqlwa3JLeZTgZsn6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733953166; c=relaxed/simple;
	bh=pkO0NUO4KcmCdWJAVRuetRjrcwB/yqLWaknBzus0A9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+eRUTBDgxl18EYGoSnT6ZyeSU0HneFLfJWZNL+qo/KxSirDGnGkNL8bapmTlWuQ1nTpD2OmNsvHhCGCsfI/IB7jFT8oaTyZtmWMsuUe6rl+VW8ttQhgiUuW080OzPmPVdrfWwphJsctUsjd34D5RWKoptNEBjncDi29J2dGihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T4XH++BT; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4XH++BT"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3023c51146cso12492621fa.1
        for <virtualization@lists.linux.dev>; Wed, 11 Dec 2024 13:39:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733953162; x=1734557962; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDpO8QRKSrhxInawg6iB7aAV8UI5ptwurUWyv3YKDbc=;
        b=T4XH++BTH6mJmd7NTOIxliyr8ybQBUoR2g80rmdQ3gLxoNiQCcWP8vydSI+0Mqf1rM
         m8sdpdAxLT82gvv/N5xB6cJV8S6nJY07PQeLvCoKASLxjn7/jmIYJCsj7DT4/caOMKwr
         NMQEG8nYvokaMS/7Chzv7tJJ2lv/lOmc3QkYgkGM62KCnAeIt2Bejh4pMDZBathA9fFM
         7Cqevwl14IFcpHpx+FoG3ThAZRumdbpQ4GMu4eCGbvcaMg4J6pHlCWBaCppLbYswlpuR
         vdLZ/g3EglUVHsYN8MhaiSLVfkTULomeFkmhyhzgD5pvLS+KBxU+svgmZqgTYYbBVLxB
         103w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733953162; x=1734557962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDpO8QRKSrhxInawg6iB7aAV8UI5ptwurUWyv3YKDbc=;
        b=cq4Wtq9isoII+tMuwmwsjsApKCe1TH3A6sXP79S8UGhegdM/uwXgOUa1wz2Zp7i+Y6
         3jZiBNeG4UJhYXe4gdApuFZYu4rFlPf1p/DU1EgWLHJ/Jmde/dFptlJIt0rcazHbmCQ+
         TT7ot/Bin+4HxyhXoHxtXjOjNpweL3nNgVxyce5p9c+ajjpw9WdYhSGKxJGZLVwnLUpA
         wxEy0qCuLsK6FDVFqoTTafk4+ICmiyOfVzGUYfzg994OZ2iBW5lqs09pebsMPX4XrI3l
         WT+UOMLdbgqN3o7n1ruTg8hKF33trMEt0Opxckiky4X1cfOnN4Ms6P+CyyMBMuhXh88t
         vTVg==
X-Forwarded-Encrypted: i=1; AJvYcCXMd383HCdmXoON+4NDYwf0BD4HbOoBNltf06TciXC8kwvngwJ6vuSmMtsz4WNVn7ytqlEBdpgduXnzidWEqQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmwejJnCzoMKAXJc/JgZ4qjxT+XDdZHeAsJy0yqTZQIzUxxQmi
	pT/gJ2zVf3jUH5h7guukhEfWAiHgt0KHMN3mnbN4XB3YqmgAKQ8pwcO+eH2xZzY=
X-Gm-Gg: ASbGncvAM4jY4inmoiUdiXU2OeFS8JvkDs/0JgyZlbA04r4tT+DvHQZKtxVxzLahZxs
	rkJg5kIRYcntR1fyLlkhQm9kcF+xZXw2NzHBsmXJJ8Zp+32vdkRfKK4FG2DrrA+xlTD32zZ5qFA
	rwCo9MFjjqRXI3otxr3EuuVrEuO5WJNqMrljo+l8+46lZ5Av50JOTa93Mzpb7eKYPtVNw0ab+PH
	eZ3YimHnV4NxBpt355NQAUqcCvB4jWRmgTrady0PONqMenJQudes8EKhlb2Xe7LM7i4J2OoRpre
	9QzcPJ7f4A3JE5Ji4hfsO5fbV9KhLxKrmQ==
X-Google-Smtp-Source: AGHT+IEOt4HIvzifdLCP3vt6tvdn0+DmYG+k9uGFplaWP19t7GtD1er9r2IS8lIHB30alIfkyzyt9Q==
X-Received: by 2002:a05:651c:54b:b0:302:49f7:1d72 with SMTP id 38308e7fff4ca-3024a5fa7d4mr2138761fa.9.1733953162278;
        Wed, 11 Dec 2024 13:39:22 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-300419ae090sm14289721fa.8.2024.12.11.13.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 13:39:20 -0800 (PST)
Date: Wed, 11 Dec 2024 23:39:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/ci: uprev IGT
Message-ID: <f2dac4eatkajw633ksnnb3nfq7zop2l4ux2euj6jqg4hg3soqt@sv7p2r6xk7fz>
References: <20241211142806.1824961-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211142806.1824961-1-vignesh.raman@collabora.com>

On Wed, Dec 11, 2024 at 07:58:05PM +0530, Vignesh Raman wrote:
> Uprev IGT to the latest version and update expectation files.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v1:
>   - Pipeline link - https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1327810
>     Will update the flake bug report link after v1 is reviewed.
> 
> ---
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

Interesting, DRM_MODE_CURSOR_BO tests fail

>  kms_force_connector_basic@force-edid,Fail
>  kms_hdmi_inject@inject-4k,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
> index 6dbc2080347d..581d0aa33b4f 100644
> --- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-fails.txt
> @@ -8,6 +8,8 @@ kms_color@ctm-red-to-blue,Fail
>  kms_color@ctm-signed,Fail
>  kms_cursor_legacy@cursor-vs-flip-toggle,Fail
>  kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
> +kms_display_modes@extended-mode-basic,Fail
> +kms_display_modes@mst-extended-mode-negative,Fail

This is a bug in 5f7cde6a9878 ("tests/kms_display_modes: Skip test if
joiner display is connected"), the driver unconditionally calls
is_joiner_mode(), or in 88abc2d2c646 ("lib/igt_kms: Add is_joiner_mode
function"), the is_joiner_mode() should return false for non-Intel
hardware. Please fix it in the IGT instead.

>  kms_flip@flip-vs-modeset-vs-hang,Fail
>  kms_flip@flip-vs-panning-vs-hang,Fail
>  kms_lease@lease-uevent,Fail
> @@ -15,4 +17,3 @@ kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
>  kms_plane_alpha_blend@alpha-7efc,Fail
>  kms_plane_alpha_blend@coverage-7efc,Fail
>  kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
> -kms_rmfb@close-fd,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-flakes.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-flakes.txt
> index d74e04405e65..5122233b9941 100644
> --- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-flakes.txt
> +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-kingoftown-flakes.txt
> @@ -18,3 +18,10 @@ msm/msm_shrink@copy-gpu-oom-32
>  # IGT Version: 1.28-g0df7b9b97
>  # Linux Version: 6.9.0-rc7
>  msm/msm_shrink@copy-gpu-oom-8
> +
> +# Board Name: sc7180-trogdor-kingoftown
> +# Bug Report:
> +# Failure Rate: 50
> +# IGT Version: 1.29-g33adea9eb
> +# Linux Version: 6.13.0-rc2
> +kms_lease@page-flip-implicit-plane

Do you have a failure log?

> diff --git a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
> index 6dbc2080347d..581d0aa33b4f 100644
> --- a/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/msm-sc7180-trogdor-lazor-limozeen-fails.txt
> @@ -8,6 +8,8 @@ kms_color@ctm-red-to-blue,Fail
>  kms_color@ctm-signed,Fail
>  kms_cursor_legacy@cursor-vs-flip-toggle,Fail
>  kms_cursor_legacy@cursor-vs-flip-varying-size,Fail
> +kms_display_modes@extended-mode-basic,Fail
> +kms_display_modes@mst-extended-mode-negative,Fail

Again, the same IGT issue.

>  kms_flip@flip-vs-modeset-vs-hang,Fail
>  kms_flip@flip-vs-panning-vs-hang,Fail
>  kms_lease@lease-uevent,Fail
> @@ -15,4 +17,3 @@ kms_pipe_crc_basic@compare-crc-sanitycheck-nv12,Fail
>  kms_plane_alpha_blend@alpha-7efc,Fail
>  kms_plane_alpha_blend@coverage-7efc,Fail
>  kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
> -kms_rmfb@close-fd,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt
> index fa8c7e663858..69076751af24 100644
> --- a/drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/msm-sdm845-fails.txt
> @@ -1,4 +1,3 @@
> -drm_read@invalid-buffer,Fail
>  kms_color@ctm-0-25,Fail
>  kms_color@ctm-0-50,Fail
>  kms_color@ctm-0-75,Fail
> @@ -19,6 +18,8 @@ kms_cursor_legacy@flip-vs-cursor-atomic,Fail
>  kms_cursor_legacy@flip-vs-cursor-crc-atomic,Fail
>  kms_cursor_legacy@flip-vs-cursor-crc-legacy,Fail
>  kms_cursor_legacy@flip-vs-cursor-legacy,Fail
> +kms_display_modes@extended-mode-basic,Fail
> +kms_display_modes@mst-extended-mode-negative,Fail

The same IGT error

>  kms_flip@flip-vs-modeset-vs-hang,Fail
>  kms_flip@flip-vs-panning-vs-hang,Fail
>  kms_lease@lease-uevent,Fail
> @@ -28,4 +29,3 @@ kms_plane_alpha_blend@coverage-7efc,Fail
>  kms_plane_alpha_blend@coverage-vs-premult-vs-constant,Fail
>  kms_plane_cursor@overlay,Fail
>  kms_plane_cursor@viewport,Fail
> -kms_rmfb@close-fd,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt b/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt
> index 4892c0c70a6d..8d26b23133aa 100644
> --- a/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt
> +++ b/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt
> @@ -7,9 +7,4 @@ kms_cursor_legacy@torture-bo,Fail
>  kms_cursor_legacy@torture-move,Fail
>  kms_hdmi_inject@inject-4k,Fail
>  kms_lease@lease-uevent,Fail
> -kms_plane_alpha_blend@alpha-7efc,Fail
> -kms_plane_alpha_blend@alpha-basic,Fail
> -kms_plane_alpha_blend@alpha-opaque-fb,Fail
> -kms_plane_alpha_blend@alpha-transparent-fb,Fail
> -kms_plane_alpha_blend@constant-alpha-max,Fail
>  msm/msm_recovery@gpu-fault-parallel,Fail
> diff --git a/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-flakes.txt b/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-flakes.txt
> deleted file mode 100644
> index c1859d9b165f..000000000000
> --- a/drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-flakes.txt
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -# Board Name: sm8350-hdk
> -# Bug Report: https://gitlab.freedesktop.org/drm/msm/-/issues/65
> -# Failure Rate: 100
> -# IGT Version: 1.28-ga73311079
> -# Linux Version: 6.12.0-rc1
> -msm/msm_recovery@gpu-fault

-- 
With best wishes
Dmitry
