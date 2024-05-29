Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CB216078E
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 06:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965773; cv=none; b=ZPf1Vf4TJHcFltZhXSLgIrpHbvaUp96dO85v0Tr46399w32YHMjc6E8vdVJi87i2Kuq6AxttzJFDVU9c8XiutsTgjqhbpv/iMq/cF6VGBnKy1HUrQUowAH82erY2iZ0ODgp8u0ut5OX89B0bP+D23c+WNWT6hTriS5QWj8zyoIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965773; c=relaxed/simple;
	bh=VN1Kq0JprgKgiY84Fl4GWOkl9GMDYn0hDtl9lNW63Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8+4O8phOEcDYe9ajwcCfPa6ksle06qiwNOwzNvuzmRJgsxvvYANImQCSpvSpdX/TUGTcfI7C//bizdwiWdRS0VFFDTVhA9duvVtU0FYKu8ZgUF+BqcG6tVdnkWM2KwtBr0B5zEEfxCydtUJL84b0/rcYtr74ewBVAHFaayLYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EEslL9zm; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEslL9zm"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D324C815C1
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 06:56:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yZlgV78fQP8l for <virtualization@lists.linux-foundation.org>;
 Wed, 29 May 2024 06:56:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::236; helo=mail-lj1-x236.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DF44381514
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF44381514
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=EEslL9zm
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DF44381514
	for <virtualization@lists.linux-foundation.org>; Wed, 29 May 2024 06:56:09 +0000 (UTC)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2e6f2534e41so17035081fa.0
        for <virtualization@lists.linux-foundation.org>; Tue, 28 May 2024 23:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716965767; x=1717570567; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8XM/FgEx6d8NuTgtXrGUs5+LoMJwxG6LNXhNDqRvo0=;
        b=EEslL9zmv58zzz3FPeCA5zUgPyogKNmeaLIyPV6YeVjWZ9hFtxSgVbFMeZnIeBocwb
         eJQANZlqupw9MRk5RABg+gIeH1sytAxlzWTNn2NEpMmlE+HlkFgzHIWHT3Py7aVr+z7T
         8tmQfSlsW/2xAUoC0GsbP97fvjdWYwu15A2xYDLJ3IM5hO4L7R8vLNV+/VEElOOGBoPL
         OSrDk4mXkn3r8ozt0oCVDFM+QkMDOjwa5UVvT13b/VJXMydwjh+nvkDNrqIMmZ8jx7Cv
         UOZN5UTVTXmKWYVP/eBfYb1Qw3lsRCZYvpmIwMfvGw//nAb1x05x/6zvfRKGz6r7VnU/
         ZI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716965767; x=1717570567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8XM/FgEx6d8NuTgtXrGUs5+LoMJwxG6LNXhNDqRvo0=;
        b=Sz/tF7cRzGh+PyIVpqi8MIOg0SwE5T2epfpokWSMqAW2ZyZ8N2Ri6wyacg4wPpcW5K
         yv18dV9Cb91wrT2G/8wV6D7hGCw0+NYQuQc4PHWrKZlbHAwLKesngvuB37MqGSXyIBZL
         kfet2iL00DTIivMlB/24ceaSE2MVWWapw3hCP4ZO5KJVo/KiIE671pzVmT4dEdc1edHD
         m3phlBDQSFrMKPMnVNq1FR+QWVnXsWGMQ3gnJdpZnA49psJZecLFbsaCL5pIdzPjdHcj
         ovdRE0metUbbcpILpBOvE4FyMs09KBaq9PaZkDTJCBWmXh2+lKL0Yk67+kfvCDfTEfj8
         bwGQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+eqmBzlHtoky7lYvKoAGbkQIUL5UyLHGwwi5+t5Aue8Ajvzy2QgcakI9lhiCHuGI7aX/VclepLoVb+JwPM7jF5/TgdkQD0C99qnQ/HD2KQUy0vZDwdMF80g==
X-Gm-Message-State: AOJu0YygrCUnOpnbT4upFiii9Gv9ClwIXlWSWCcS/DtPLss6ZgSxhcmS
	ifVagsEMKyJwVZu/5Y9YPZGbRqFzZDRg/LN7+fcng5SR3V/rcSp7XUsJUUIY0YU=
X-Google-Smtp-Source: AGHT+IE8Vr6rfevCpWjYYJnFoMwyjAbgft8519qmMf8AdXmrOTwD8aPPvmWsyWzNiVDX4RqJ44Re8w==
X-Received: by 2002:a05:6512:902:b0:51d:4af6:bb86 with SMTP id 2adb3069b0e04-529612c529amr9109860e87.0.1716965767480;
        Tue, 28 May 2024 23:56:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52aff3f65d8sm88039e87.181.2024.05.28.23.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 23:56:07 -0700 (PDT)
Date: Wed, 29 May 2024 09:56:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] drm/ci: uprev mesa version
Message-ID: <jzb7oa2qtbavelujxwzk5vmcchazvva4aynxo2ceoigthgth2f@j3kjkj6okmwz>
References: <20240529024049.356327-1-vignesh.raman@collabora.com>
 <20240529024049.356327-2-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529024049.356327-2-vignesh.raman@collabora.com>

On Wed, May 29, 2024 at 08:10:44AM +0530, Vignesh Raman wrote:
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
> v3:
>   - Move adding farm variable and updating device type variable to seperate commit
> 
> ---
>  drivers/gpu/drm/ci/build-igt.sh   |  2 +-
>  drivers/gpu/drm/ci/build.sh       |  6 +++--
>  drivers/gpu/drm/ci/container.yml  | 12 +++------
>  drivers/gpu/drm/ci/gitlab-ci.yml  | 44 +++++++++++++++++++++----------
>  drivers/gpu/drm/ci/image-tags.yml |  2 +-
>  drivers/gpu/drm/ci/lava-submit.sh |  4 +--
>  6 files changed, 42 insertions(+), 28 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
