Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9242E53379
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 10:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716201813; cv=none; b=byuIEUiHwt4SxYwDkUgDrIg1Y++eHm/KFYBS3U+9ZzPtrja3dCA80hFiBd+MFGkt+Qx/MtJ40QUMIpoiWvYZAiMJVwydCbYcauBhMkUamJibFxfPlhnZ/XJLJErEyS2zln9Th5KWz0k7kb4SoB/tq6HlZ8wvyBFie3ZTaS+z4X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716201813; c=relaxed/simple;
	bh=Iz9ztzUrzHwU28kEfAv2CoCZ/02g4GuMeMy9kUlFIHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnzg5SPafogrz0duB1jkdqmzt7ohBATyNbpuSsIC/L1ooZmjtjxN+oWP4BCa2WKkB/0881ebYGB9uD3jAwKoc4WQpglz37yd1xgqIXMayhJhgdVc4OrilhSkjWHVWZZ3G+FsaLbyL/cOqsFqqu/2Sjz/x8pGax8PJDPbNLdUWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f3fgru7M; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3fgru7M"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 30C7A402F6
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 10:43:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vLJPSCRluoHc for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 10:43:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12e; helo=mail-lf1-x12e.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 614EC401FE
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 614EC401FE
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=f3fgru7M
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 614EC401FE
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 10:43:29 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-5238fe0cfc9so2405303e87.0
        for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716201807; x=1716806607; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=icwVF42TmZ2hZjEXcduZvhpSy5tVelIfuJSjSBSENHo=;
        b=f3fgru7Mw5My3F3BcwUYyrqmVW2Xtkr3z/HO9XpVi45kZ8dVmRSmE8m+GOcrhp4593
         oRic5Ny7nnzbKJxPJJMsI79yO2pwyEJI+/lHkjE+mNi7auLCYqhB9tqBFabyImr5j4ap
         M+lvMhQnFaaIm3nC3wHnD7imiOO1C8240TQgzw2XN0vvVWNCj8cMl/kRRyRHaao7xrvG
         jxm/cWwr35QmjR1idhL6xo6ckJLJwWciI18Ly5yI+deQsbtInd6yePnBOiFXklHdFHQl
         TALU+2NVfh/QcT2R/yRvqV7DEbpGxBl6dTWCqD2aZ2lIwAaQDlMKfmvGrSfd0A6xayhp
         Pt7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716201807; x=1716806607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icwVF42TmZ2hZjEXcduZvhpSy5tVelIfuJSjSBSENHo=;
        b=c5LpErcEdFKIMj+gxZGPkW5zfODNx/HGHQNdBLizYUbUuaKsCN1Ky4OBHEYPHtP3ZQ
         hvREMqmMXks2FSyP0X1gJQ4PN4a8oEWFyd+uKt6v4c/G8ls1eCJvGlhch/c7n0HRELVf
         nYLxgbj3GC0HGMkduw0o8MQpVgELu1nhGfD9AHatfbaVWgi1M6Da23v+chpNB8PWy2Zy
         C+u/ypSzXuexj82g1tuZLorjpog5hca6UfmXTtFu4CvwHOVzWgBNcZCvE/FyonaW+c4m
         Z+PunBqAaAf05AVkNMX7ikovMgDf7UkAD0RNAWwmNd7mSPcZH7NzgT1i2n30zSkllr5n
         4GOw==
X-Forwarded-Encrypted: i=1; AJvYcCXW2RfQrXDqmFELgH5uyH+i1IsKdQvT958sZjOehXRAimXdRCbw/R98KkE1B+p/xH0yidBXzkkRiTAUgbBBenEZLSZave7eVlh49jPBOPJcxlKriSTwKLZTbQ==
X-Gm-Message-State: AOJu0YzFWyAHfrZs+tzLvN/aPutT3jg8QhplYJNmRqI1bnvF2PO2L3ep
	knTXpk9e/msXKHGrhWAzqeQJin6aT8GOuhnjDr14/+SB5pIanNhi5l7/osS7CB8=
X-Google-Smtp-Source: AGHT+IFzot8n6xHV0OHm6wH4k0sEr+LYxBLD0eD+umJwBs/mAovf2bSRWjBos0WaEoAs2a0risJ1Ww==
X-Received: by 2002:a05:6512:4801:b0:51d:8ff3:f835 with SMTP id 2adb3069b0e04-52407cddc3fmr1595444e87.26.1716201806986;
        Mon, 20 May 2024 03:43:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5238bee41afsm2044239e87.294.2024.05.20.03.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 03:43:26 -0700 (PDT)
Date: Mon, 20 May 2024 13:43:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] drm/ci: uprev mesa version
Message-ID: <2qzmfv3oc6feihwxu3tl37rg6w3qsj2vddu5olvqk6vhqr26cc@bxu5y6ijvtfa>
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-2-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517092502.647420-2-vignesh.raman@collabora.com>

On Fri, May 17, 2024 at 02:54:57PM +0530, Vignesh Raman wrote:
> zlib.net is not allowing tarball download anymore and results
> in below error in kernel+rootfs_arm32 container build,
> urllib.error.HTTPError: HTTP Error 403: Forbidden
> urllib.error.HTTPError: HTTP Error 415: Unsupported Media Type
> 
> Uprev mesa to latest version which includes a fix for this issue.
> https://gitlab.freedesktop.org/mesa/mesa/-/commit/908f444e
> 
> Use id_tokens for JWT authentication. Since s3 bucket is migrated to
> mesa-rootfs, update the variables accordingly. Also copy helper scripts
> to install, so that the ci jobs can use these scripts for logging.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Uprev to recent version and use id_tokens for JWT authentication
> 
> ---
>  drivers/gpu/drm/ci/build-igt.sh   |  2 +-
>  drivers/gpu/drm/ci/build.sh       |  6 +++--
>  drivers/gpu/drm/ci/container.yml  | 12 +++------
>  drivers/gpu/drm/ci/gitlab-ci.yml  | 44 +++++++++++++++++++++----------
>  drivers/gpu/drm/ci/image-tags.yml |  2 +-
>  drivers/gpu/drm/ci/lava-submit.sh |  4 +--
>  drivers/gpu/drm/ci/test.yml       |  2 ++
>  7 files changed, 44 insertions(+), 28 deletions(-)
> 

[skipped]

> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index 8bc63912fddb..612c9ede3507 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -150,6 +150,8 @@ msm:sdm845:
>      BM_KERNEL: https://${PIPELINE_ARTIFACTS_BASE}/arm64/cheza-kernel
>      GPU_VERSION: sdm845
>      RUNNER_TAG: google-freedreno-cheza
> +    DEVICE_TYPE: sdm845-cheza-r3
> +    FARM: google

I see that this is the only user of the FARM: tag. Is it correct?
Also we miss DEVICE_TYPE for several other boards. Should we be adding
them?

>    script:
>      - ./install/bare-metal/cros-servo.sh
>  
> -- 
> 2.40.1
> 

-- 
With best wishes
Dmitry
