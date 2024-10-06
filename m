Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D0188907
	for <virtualization@lists.linux.dev>; Sun,  6 Oct 2024 19:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728244020; cv=none; b=AeOy7YqOmvVroI2xXk3mpri8BE6e2SDUn7+8scTYEMWdOChiW+8ABZuYvKZ0fVal5Go/kIcID28ogutuuQOfC1On4cze7FUH188YQK+Q1amSje4Q8+vjar20i8EzYqNNHD7x06auAETs3K5kQz/WZhRShzA2V7OxnGBegMSLK1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728244020; c=relaxed/simple;
	bh=t24rienVc4EcFw1ZjloxygcF35IiW56DAVO5p2W/jJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB3DPhZ44fQpxRvsB8XbluMu/QIbv8WA+wx1UktLwI9aIAunzykBLEr/agQ4GeEX/TV2Maz1LxPBFjCCQWeix3z3Q6kmUmofyWrBcaxmuSHdQeutzCvQaaWaamirdJ6UW+ALcd9QPFtZgnetRvUn9RsEZ4xWCJ+83f+appVxfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PonxWTWF; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PonxWTWF"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fac3f1287bso39299581fa.1
        for <virtualization@lists.linux.dev>; Sun, 06 Oct 2024 12:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728244017; x=1728848817; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nudt6VvmPjF0HbFLFck+5c0LXbisuTPtkHJzkxMI8Xk=;
        b=PonxWTWFVgCku+IhTB1lRH07yfU5CpXKpf59gibouBsUkGoNmOAFS0cXQwimOZCs3V
         pGYdkCGHz8UldUG9d5/C04QPbm87fNTtL4oCiCIn2H4EWp4WqsIin98PwHgD4WF+NfYu
         ZdLl5LkQfFi1ESJivgh0e2XEJ7ZiPp2VHvBtCkdRhxhGuxhkyux+hNDd7MZ2hSErZlAu
         4b9KcCMYPHIwhDlApfBJMtajkERu8j5r11gkcJhPUYOJ9yF+4PDXbrlOFMIQ4KEPTpgq
         ThJ3Gi4UmJFORdnoYGUw2EyRrc1tWc0gIqeHjncLqejFKbdkP00xCgbfPJ1pG4VSldUc
         vA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728244017; x=1728848817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nudt6VvmPjF0HbFLFck+5c0LXbisuTPtkHJzkxMI8Xk=;
        b=azcYOYRpBnOwKioHApn5W4/WR/vyO4NVnASPk/XJSc0ywy/Q/uZGz9Jka1serYNuhz
         2j/tMV94YOiHL5tt4iFOz0JI+dJdXmkPMjNwld3tV6Rj1UcxRH+lRneBBMCOYPV9xYHj
         9q7rBQHE6dbNqBoYC1Ed61hkn3EJAGhzyJl8hTtZKrJ2WZhmkH3kjjkYHo6Uhi7BfjGo
         uWqYIzzXn8e4WJX38Ypk/9Qqgp6OovmlAPiSa3HUiQLa8cc3aNKaihOvMU+J5Wrp6oS9
         UnDLwmSF121L4UG8PTHRC1Ka7M5H//4aLixKg3Siyv7dcBoeNaHa6YNsVtyzLY0c0U05
         80hQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+4dWlH4veyTLdOW0l1eJznoox5IUNS+25kbGC39nrW7ShZJ7M+0i4NRWsVJXoZ7r7EfQr9xDmQf0zAWyydg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQmXh0o1BNf7ncbsPtzyOWrBuwXP19gSuhtjVavsREqn2RWIth
	D1IXs7j+dr8xi7XcwXWV7CbQ0aZR4zCOz1FwPRERCiDHacZlSYzcXCwcIPDq2y8=
X-Google-Smtp-Source: AGHT+IHQ40ic093FZX3v4B1HtEnY+cFajGIuhrqmUeVmOK/1zrCrTPpZ72nuQMgcgqEOYhJIrHyv5A==
X-Received: by 2002:a2e:f1a:0:b0:2fa:d84a:bda1 with SMTP id 38308e7fff4ca-2faf3c1439dmr35177721fa.10.1728244016963;
        Sun, 06 Oct 2024 12:46:56 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff23e0bsm610963e87.243.2024.10.06.12.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 12:46:55 -0700 (PDT)
Date: Sun, 6 Oct 2024 22:46:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, deborah.brouwer@collabora.com, 
	linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/3] drm/ci: add sm8350-hdk
Message-ID: <eoumkcfeiw5v5apczgthateomnhjs3ihdyjwcjppg4gwgdseo5@vh3loy4jlma7>
References: <20241004133126.2436930-1-vignesh.raman@collabora.com>
 <20241004133126.2436930-4-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004133126.2436930-4-vignesh.raman@collabora.com>

On Fri, Oct 04, 2024 at 07:01:20PM GMT, Vignesh Raman wrote:
> Add job that executes the IGT test suite for sm8350-hdk.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  drivers/gpu/drm/ci/arm64.config               |   7 +-
>  drivers/gpu/drm/ci/build.sh                   |   1 +
>  drivers/gpu/drm/ci/test.yml                   |  16 ++
>  .../drm/ci/xfails/msm-sm8350-hdk-fails.txt    |  15 ++
>  .../drm/ci/xfails/msm-sm8350-hdk-flakes.txt   |   6 +
>  .../drm/ci/xfails/msm-sm8350-hdk-skips.txt    | 211 ++++++++++++++++++
>  6 files changed, 255 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-fails.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-flakes.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-sm8350-hdk-skips.txt
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
