Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E88028C039;
	Tue, 17 Jun 2025 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750165188; cv=none; b=FNUQx6r2eZRg3K6jeBnSf2J97bHSgZDRLX5bK5YMrwbeJ/AeTzd5xAYKRRYePpNMvvOaNyT6/QwsCU3D+y4j/m5JXHVKKMy88NlXFYkHNTfVL2Gr+CyPVaMt6rJXcyfJhIh3OqCQONNudjI/ijjGShY1NZExkdzsqIF6iP62TZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750165188; c=relaxed/simple;
	bh=oYOeIAfsmU4t9r2TCrVIZpfx7hejLpjjsg6BpCI0j9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URfdkGoc7al0TQIDd//bPkWjpWzu16JWqQCFrAkqCBj6q01oFQgSoSEkbvLNoy+4WypTDTIiown+KJzcttNU4uyYxtiNekZaszp0fCHx64scaVFenFoFieYRmQ66JYdV6VGx1nb3Lb/nXJgsUH7wSgKvQGbEc8hIrE7n07dUBJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feHrvWfX; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feHrvWfX"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-525b44b7720so1330719e0c.0;
        Tue, 17 Jun 2025 05:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750165186; x=1750769986; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IJGnTu2P8k2zWLpKT9gQ0C6Ynav6qAdbDTnXBuG6SzE=;
        b=feHrvWfXnsv5o6FcagI10RufqIfcu3SAAcrDseaBMHq/1OkGHZeGCynOmpOJe82ON2
         SCVLyhehjlstzUsPt3ioJ4IQhLkW5l3GNTh3ocaYmGSauQElRPFU14b/b7rtUdG1sC+X
         MfYyaVtAQ8LtSHRq5C2tXLfDVFfoR5u7SKbZZr9VIOld179LDV4sXRn/BP3pPdGFGNAl
         oBNqvq84q3w0ssBrNsxlLqhCnuzcdSqbePfyqJ5EhcelOJAQWw3yixaHaA5w2x1uBv9W
         Z7jVm0CjmUhaZrKOfQqJjI9x3LYyxVmOVy9lNlEngfyfJYDd+g7gQQ+3BZFJtdeX89C0
         DB0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750165186; x=1750769986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJGnTu2P8k2zWLpKT9gQ0C6Ynav6qAdbDTnXBuG6SzE=;
        b=ZvykPzPnWEeaCkB/8qqvStEWYytyeARILF0J391V4e5h7qAc3JfwV/SIHOhdXJPlO4
         b8NngvTzvPmfv30fdISKpur20QVgcaz/3ucaREc7hDQi8xX1CnxHfnHep7BLLjxRp+e5
         udvDe4zTfsfpElngGa7YLmnUSaePQ+mlxecgi1CSMBe7xjYVkIMwiZIoI3dxQQfFuIyp
         10lG4uGepFOsR0g3KwiWWYpNdfoHZcvindb/qwUjsqfYVm7+2eFaKCtHODKUdjimQ8JR
         IfV2ihOSHPJFDT6VJavaXBI3q6Zn1dg4RGUm0foMxleoHuYR5QJqDaMzEgaGkRgoXuAX
         kRng==
X-Forwarded-Encrypted: i=1; AJvYcCUV8MqLO3Z01D4gfEZn250L/NOMrQgu6/wsgfmk7eLJnn/qCE169drCgWjZNas8nhxUjao=@lists.linux.dev, AJvYcCXXP39hfI8FdayUY0H65DM9yz9/S6nRBjEn3gCksWCQoQDsiFPZqDfHpdwGtqwQALG7YvAzum23Ju6zR/NsCeQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwpZ2CaNX21bNwTzrAT2WDQHRDzr3MvAD47YERQiKmFLrGy0WHL
	EdipTtG/hc1Fbx7sgmKj6bItsCWOLpnWBF1qWW3uve/vaS1jUYLh2Dv+ZjRFwSHLMGGkfFJwIlT
	EjY4Dqqexf4CzF2cYE4Yucs4doyXyJ4o=
X-Gm-Gg: ASbGncu75sO4gR0s4agy8jZ73QGllWgCDcEchtXM8u3V4z5tSu2yZf1CHJS4OGHbnmq
	OkEnbPNAOx7n6PM7JPmgtRCR0S96Hzj4E6KafWIn0T24H22tO+KQWfZHwcRWlk69Va/mVIQQTuE
	j69ZEW3U+kMVX977Ljn9GntwvOAj0ApsRfA2M+3PJFBA==
X-Google-Smtp-Source: AGHT+IFyDxk9ofOoSE1jUdDwuXC6uj68bPw86gFHeN0xbFulbam2J1M/auQRgbuNa5uXdcywAXE8tSUc/+x2hYqgo2M=
X-Received: by 2002:a05:6122:4586:b0:52f:47de:3700 with SMTP id
 71dfb90a1353d-53149677e4amr8402312e0c.5.1750165185838; Tue, 17 Jun 2025
 05:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250613090431.127087-1-tzimmermann@suse.de> <20250613090431.127087-8-tzimmermann@suse.de>
In-Reply-To: <20250613090431.127087-8-tzimmermann@suse.de>
From: Inki Dae <daeinki@gmail.com>
Date: Tue, 17 Jun 2025 21:59:08 +0900
X-Gm-Features: Ac12FXy1YqAOwtksyoMPU_mcRXzK8GOxRWP5F_To6gWRQ1V5y95DviShSwJIG6g
Message-ID: <CAAQKjZOiz3Z42N_GEPzqU=CCfim+Z7oCuyxuji6Guj_dKYsimw@mail.gmail.com>
Subject: Re: [PATCH v5 07/25] drm/exynos: Compute dumb-buffer sizes with drm_mode_size_dumb()
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: simona@ffwll.ch, airlied@gmail.com, mripard@kernel.org, 
	maarten.lankhorst@linux.intel.com, geert@linux-m68k.org, 
	tomi.valkeinen@ideasonboard.com, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, freedreno@lists.freedesktop.org, 
	linux-arm-msm@vger.kernel.org, imx@lists.linux.dev, 
	linux-samsung-soc@vger.kernel.org, nouveau@lists.freedesktop.org, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-tegra@vger.kernel.org, intel-xe@lists.freedesktop.org, 
	xen-devel@lists.xenproject.org, Seung-Woo Kim <sw0312.kim@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2025=EB=85=84 6=EC=9B=94 13=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 6:05, T=
homas Zimmermann <tzimmermann@suse.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> Call drm_mode_size_dumb() to compute dumb-buffer scanline pitch and
> buffer size. No alignment required.
>

Acked-by : Inki Dae <inki.dae@samsung.com>

Thanks,
Inki Dae

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/ex=
ynos/exynos_drm_gem.c
> index 4787fee4696f..ffa1c02b4b1e 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
> @@ -11,6 +11,7 @@
>  #include <linux/shmem_fs.h>
>  #include <linux/module.h>
>
> +#include <drm/drm_dumb_buffers.h>
>  #include <drm/drm_prime.h>
>  #include <drm/drm_vma_manager.h>
>  #include <drm/exynos_drm.h>
> @@ -330,15 +331,16 @@ int exynos_drm_gem_dumb_create(struct drm_file *fil=
e_priv,
>         unsigned int flags;
>         int ret;
>
> +       ret =3D drm_mode_size_dumb(dev, args, 0, 0);
> +       if (ret)
> +               return ret;
> +
>         /*
>          * allocate memory to be used for framebuffer.
>          * - this callback would be called by user application
>          *      with DRM_IOCTL_MODE_CREATE_DUMB command.
>          */
>
> -       args->pitch =3D args->width * ((args->bpp + 7) / 8);
> -       args->size =3D args->pitch * args->height;
> -
>         if (is_drm_iommu_supported(dev))
>                 flags =3D EXYNOS_BO_NONCONTIG | EXYNOS_BO_WC;
>         else
> --
> 2.49.0
>
>
