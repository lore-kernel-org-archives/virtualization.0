Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6BD18BC2D
	for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 22:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724796297; cv=none; b=YiQd/Joa2syzeeuOdcmV+Yyahd9g0VfmLGNtf+s9Xt8OdC/7lVBKunjc5tO0JogFg7bzoYJYDz5LKxfjr5s+sFEHIznC/FX1DFMg5qmDftXRV8MJl2o74hEXeVZQIZ0SBYNK1eWjp9pAa0pCmiEDyFVgXrVbObdOQmaHGc5KZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724796297; c=relaxed/simple;
	bh=9rGkUgOufBi7Mzv+5uM4oeDmEyRh5mYHyw6X74RrwqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kwbM1l4m+ZcTc6cVyovnEYyXgwpqoaybQ9Zo/ZCEWvmFE+TSvJpQiUiRrNuw6pwmti+hNZtrV+7XKa34VoUFURES2Hbui/Et0LoLV0PrDvTMeV8ca6gZe1JGM4YHjWGpDhXQzs8JEo9fgTq9jcZJOYN2858iXuJdwi6gWHWZoEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nkno5Yx4; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nkno5Yx4"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3718acbc87fso3325230f8f.3
        for <virtualization@lists.linux.dev>; Tue, 27 Aug 2024 15:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724796294; x=1725401094; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZgyQZttbFN6Mpv5C6Zqi3PHF1KkrD2jrO7egIws/+I=;
        b=Nkno5Yx4McQ8JR1lMpUBAo4BthhylMOuu0b8LBs23zdlcp0KBC2p+v0pXdDSHKw+40
         JfwBZe56VBoRGZjcNLQSDE/ALaivqTIMMD2ODeoY1VgirvkZxZwmuzo/dMGt3F9yaP91
         r0RwWua+6GDaSfuYx7PDgmM0i8ykr5dXBW+5L97xTUBl1MgTXVm0XnJ+jWPtj2OIUe33
         ls6rgND71Brsbo5DPkUav1J6DSy2/We/sRDhmWdyr11omU0aPar8+ry7ufsFenmZ34MT
         R89DGUs8bgzfhPkhYmp+9l/eZNETQqUgY/6+76OrtwFiMlVYgQPa3dHTkQn4/oH10Fc5
         j5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724796294; x=1725401094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZgyQZttbFN6Mpv5C6Zqi3PHF1KkrD2jrO7egIws/+I=;
        b=btsms3dxi4s2msfWxUtXmOoydLxHOe/mDCMDhdpDFCauaAPpY/H98cEaNefkVDrTqi
         4M/HvM4zUhROTW6eIZhD3PAMWbvKLmL5t2yUDiDXCoJ+gLYwizLUQIh6A8Gu+1ell7vV
         jjLUE0vY9gAWByYi1/wrHmM2ipVR/76XwvUGPM6ahORToFsUJfFFYHSkIgpfC+9qiL2p
         X6dkqXg02dtw0TMC84dtUQhMKD82jH+RVrzuiPtEqoUQ1xrntvBXXSDQGH9B/9dVVuC3
         yJ5FduBzMzorJClPEqpZ4i7aEnTDFyt8Q1Cb+8laU5vz6+d39PaxJqp9VFYdGgcqVBrS
         J1+g==
X-Forwarded-Encrypted: i=1; AJvYcCWeTFy7as5QvpGv5fBYNB+P/ydHkf9a5kw+PAw68InFMMgp1tTGdqRhlAH+ipaJA14+1NWbnCcq2GMtBOj78w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzp0wSvhSdmFIlYFShi7qSQL4ANETPNAbea9+mGO1ESfo5yWSb8
	R+QiXyvXjcWIRCFYOW5P9gSbcuRUI06kTz2ayQpNRp3YqMwap151PYklFIMuJex2b/Ex4zC+CwZ
	HP/aDmG9o3VDgrl4trhBNHPYGUOM=
X-Google-Smtp-Source: AGHT+IHWk+OQ6gg8FUjgV2v4vECfE0Fa9RJ/6lK2GykuDqzWb1DzW5pw5cVNOpUVhtAQtCWvfc0gKwWGbXHqNy0EXDs=
X-Received: by 2002:a05:6000:8d:b0:368:747c:5a04 with SMTP id
 ffacd0b85a97d-3731185ad48mr7748341f8f.25.1724796293984; Tue, 27 Aug 2024
 15:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240820070818.1124403-1-vignesh.raman@collabora.com>
In-Reply-To: <20240820070818.1124403-1-vignesh.raman@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 27 Aug 2024 15:04:42 -0700
Message-ID: <CAF6AEGu-T4=3jPRcnq3BFBtfb_yhmWE2b8EgxgTm5Q0bqSv04Q@mail.gmail.com>
Subject: Re: [PATCH v1] drm/ci: increase timeout for all jobs
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	deborah.brouwer@collabora.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 12:09=E2=80=AFAM Vignesh Raman
<vignesh.raman@collabora.com> wrote:
>
> Set the timeout of all drm-ci jobs to 1h30m since
> some jobs takes more than 1 hour to complete.
>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Acked-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/ci/test.yml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/ci/test.yml b/drivers/gpu/drm/ci/test.yml
> index b6f428cdaf94..09d8447840e9 100644
> --- a/drivers/gpu/drm/ci/test.yml
> +++ b/drivers/gpu/drm/ci/test.yml
> @@ -10,6 +10,7 @@
>  .lava-test:
>    extends:
>      - .test-rules
> +  timeout: "1h30m"
>    script:
>      # Note: Build dir (and thus install) may be dirty due to GIT_STRATEG=
Y
>      - rm -rf install
> @@ -71,6 +72,7 @@
>      - .baremetal-test-arm64
>      - .use-debian/baremetal_arm64_test
>      - .test-rules
> +  timeout: "1h30m"
>    variables:
>      FDO_CI_CONCURRENT: 10
>      HWCI_TEST_SCRIPT: "/install/igt_runner.sh"
> @@ -215,7 +217,6 @@ panfrost:rk3399:
>    extends:
>      - .lava-igt:x86_64
>    stage: i915
> -  timeout: "1h30m"
>    variables:
>      DRIVER_NAME: i915
>      DTB: ""
> @@ -414,6 +415,7 @@ panfrost:g12b:
>
>  virtio_gpu:none:
>    stage: software-driver
> +  timeout: "1h30m"
>    variables:
>      CROSVM_GALLIUM_DRIVER: llvmpipe
>      DRIVER_NAME: virtio_gpu
> @@ -436,6 +438,7 @@ virtio_gpu:none:
>
>  vkms:none:
>    stage: software-driver
> +  timeout: "1h30m"
>    variables:
>      DRIVER_NAME: vkms
>      GPU_VERSION: none
> --
> 2.43.0
>
