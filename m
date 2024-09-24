Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363545005
	for <virtualization@lists.linux.dev>; Tue, 24 Sep 2024 06:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158577; cv=none; b=sVh32Ujs1Ib1QfG72/2snSDj/+GZTVGDjawTQI9OMM5J/9aT3TNA9c6X3cMZ3Dg6A7P1XpOvjCjGCvxKMpHQU/Y1WQhvR2HAnonzN17x1bqcxnZvnSSi74g98XSHG9YRE2Xle8VsLh/RbiIfpjvsZitG2uB1PCi/FbFVltozbBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158577; c=relaxed/simple;
	bh=UWkBmgjGskvL8GNtm+Gp4JAUuWrilvjBC9MJ9j+d30Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CwRL+akV+VsGbVRghBDn+jNAQLPlKUcCt9BkDmlatkWMkoA1fKeLdl3q+COEI1wbPAsUt3yp1TGDc87DLY/uiFSR7r33cFB6rWEQAkjT/QGs7LZTyNwDX6VnPSttZ9tIs1WdhMMEMya/DEqQEk7o3Txqh5UjXeq7nieS4jpJKpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ou0drouW; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ou0drouW"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e1a7e54b898so4154046276.2
        for <virtualization@lists.linux.dev>; Mon, 23 Sep 2024 23:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727158575; x=1727763375; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcweUFHFW/KJCW3gKD065UQS3lsmUsHAhy70Femt8O8=;
        b=ou0drouWVB3JnY1pjg/PEDMJwQLpaDr2W/xFlzX5o92LX6TNx/R5YthP8+YhOYZ33e
         F7GpJQ4U2sYcBX38BCvHl/cZWrgOPavrb1DFmj739GYElectEPljV3xcldj+jDoZtxuJ
         bUedp9p/AJCGFsXSKeUd9vuMZnlA5g6NvrI60xJxjrZ5cScp7M8iQRE+RWiRnUNogddZ
         8JhxVx8BbPxDiWSxw7YSoUCZqYxUG0hhUqFQTnq/Txhf4xkgDwKhW6AJQ6BQnfJVVfzw
         WNrzoLbd3hu06K61I1U7bPdGbmXOF0WN5Lkizb8ma/tkPEOUUwWO+KcanOlUSLaJZOBn
         kNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727158575; x=1727763375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZcweUFHFW/KJCW3gKD065UQS3lsmUsHAhy70Femt8O8=;
        b=j9+G3p2huSLhEsarTJKpytReK/Tw+EJG3s+y2KQZ3G3kTz9ID7Lc9T03Rc2GBD2FWi
         8iBW1j06YqJ7vmRxxrmaqS098RahCH3xJ2P1k7Gqy/WSmqx8imxPxEaxqtKOVBad/ZP3
         avakrmlNgQNdFx2Ha9r5ii2rFcsTF6yq/nd78OjjjM/poOEukbiBAzwxT5l46sZ69R8L
         VYtPZP2ovyxNLAQutyA1g8z/tvy8LwEqYE8fj5iRU2OXuwyXFkgEciM6O8zVlvaOGTJ4
         zs9sqsqj6UG+AQe+VOUXB2uwgMKJG4p8p0V++KQ0ASZcuSDGTACFzpzlkuojxtuQHYHH
         E6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFCXS4EE4EHFIuwfhc1MyRpLu/TwXTokUBwHC1zYKR/XNRokf6yXk8n0J+M0zg0O8uxENWvww6rpU2BvYUBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLfyFJQvEDynYCMbFPFT9kpLisLI2EamcZ9LVlzAGCSPHFg6LM
	BYAJeWQTli5SEOmhUPYtdVVsz1G8artfRFZXTp9lOvX6JCAmVY47sCe9S1lAvEVaOpuMKIrdcgu
	0eoK6LKuJblt/FmgiqegQpF6Ubbcb5/6faoy83g==
X-Google-Smtp-Source: AGHT+IEF5j0JkBVAgP1jTlkYufGIlKJxFTmmd49IaW+yK41rQF/NpMRTMvOPM1xHJnDTOa2dEHhH9wuEn2USXNPEeWM=
X-Received: by 2002:a05:690c:89:b0:6b1:4948:f689 with SMTP id
 00721157ae682-6dff290379dmr105980107b3.34.1727158574971; Mon, 23 Sep 2024
 23:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240924022600.1441969-1-vignesh.raman@collabora.com>
In-Reply-To: <20240924022600.1441969-1-vignesh.raman@collabora.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 24 Sep 2024 08:16:04 +0200
Message-ID: <CAA8EJprUUUc0iDph-HPrW1anrdnzYju7+JERQdHbwxvznq=H4w@mail.gmail.com>
Subject: Re: [PATCH v1] docs/gpu: ci: update flake tests requirements
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
	mripard@kernel.org, rodrigo.vivi@intel.com, 
	linux-mediatek@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, amd-gfx@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 04:26, Vignesh Raman
<vignesh.raman@collabora.com> wrote:
>
> Update the documentation to require linking to a relevant GitLab
> issue for each new flake entry instead of an email report. Added
> specific GitLab issue URLs for i915, xe and other drivers.
>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  Documentation/gpu/automated_testing.rst | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/gpu/automated_testing.rst b/Documentation/gpu/automated_testing.rst
> index 2d5a28866afe..f73b8939dc3a 100644
> --- a/Documentation/gpu/automated_testing.rst
> +++ b/Documentation/gpu/automated_testing.rst
> @@ -67,20 +67,25 @@ Lists the tests that for a given driver on a specific hardware revision are
>  known to behave unreliably. These tests won't cause a job to fail regardless of
>  the result. They will still be run.
>
> -Each new flake entry must be associated with a link to the email reporting the
> -bug to the author of the affected driver, the board name or Device Tree name of
> -the board, the first kernel version affected, the IGT version used for tests,
> -and an approximation of the failure rate.
> +Each new flake entry must include a link to the relevant GitLab issue, the board
> +name or Device Tree name, the first kernel version affected, the IGT version used
> +for tests and an approximation of the failure rate.
>
>  They should be provided under the following format::
>
> -  # Bug Report: $LORE_OR_PATCHWORK_URL
> +  # Bug Report: $GITLAB_ISSUE
>    # Board Name: broken-board.dtb
>    # Linux Version: 6.6-rc1
>    # IGT Version: 1.28-gd2af13d9f
>    # Failure Rate: 100
>    flaky-test
>
> +The GitLab issue must include the logs and the pipeline link. Use the appropriate
> +link below to create an issue.
> +https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/ for i915 drivers
> +https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/ for xe drivers

drm/msm for msm driver, please. Otherwise we can easily miss such issues.

> +https://gitlab.freedesktop.org/drm/misc/kernel/-/issues for other drivers
> +
>  drivers/gpu/drm/ci/${DRIVER_NAME}-${HW_REVISION}-skips.txt
>  -----------------------------------------------------------
>
> --
> 2.43.0
>


-- 
With best wishes
Dmitry
