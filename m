Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED81DD88D
	for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324026; cv=none; b=UpycYSPHDEQSrC6f7M24c1i20hgFGAj2b1XQHG1UjkxFPYzL/KijDq3l6XxM4vENYDRS42KBZSQ7MM0NH+0P17TXnzg/gRk8cz1Fcsby8N/cAXT+HatGszawYW+JAYbKyJyUdAch+rVT7UOnr6mSzZtz8IgkbD76WWMqUL8w7DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324026; c=relaxed/simple;
	bh=K8NrPJvJ8M1iVaaSo49zqyhxNu5E57OgZm4oAvKQ80A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o5IITS0tJO3U9cdIVs2LN/nCYETAqr3qW3Ms90mnsCRsk8oHvdCDKb55Vig98D0wVuKKimsU4WuYjulrGmfbMbFqNKGJeeHVEKJ5tOTzIHNEzMMvNUc5S+6o3L1A3wxbdeNoO4RBFuzg1Yq/7wIoR5pZ8wueuYyucG2Dm8RU9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEP/fUHM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEP/fUHM"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so578041066b.3
        for <virtualization@lists.linux.dev>; Tue, 18 Mar 2025 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742324020; x=1742928820; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSmaS9SiczKcQtf09ulZT+5WIK4YMWt6OMaokGfRCsg=;
        b=WEP/fUHM5rfjP9y5qD32FUTOViUBpbkp+6Vwo9Dx3G6SP+VNRm1OGJuC6vEQ9z05wO
         eM5aBSu9cfsng+PFkxHoDErPJPR3nsc6hVMa4Pt0C8zbyYsV31kuavSSp+SzJPQMjUdQ
         l01/IxevFDAuvVnUw0vAsjTKhzf0JF93zSlglgpVSMW7jo5kym30Yj6DvSNv8FJOSfjr
         Uz9arkQa++VvVx5fAKIXVE8nHYHyYL7PHEOVu/Rqs1mBiZN+Pe/XO9tZ20x1u+OiWFjt
         SY2RzfEq6l4+vZ3t+4RMWUs3qZ+zykVXJplgC198j4vxGyMMfV7oqvnWKbrsv8fA1Blj
         o77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742324020; x=1742928820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSmaS9SiczKcQtf09ulZT+5WIK4YMWt6OMaokGfRCsg=;
        b=em0Wd/xBBdsxQLr3zDloWTyO359PjdvJhY6a2JLA7/UlISPH+2Dm9sKnclY7xQkgow
         FrpQPeCnBvz/7/uuTzGiAsQRW5cu08JNtZpOmSvOWUEJFXaH+MEqabP2BKxiU6LYrruy
         2x80cMYTTPHlKvzK5d2oti2PvZWj93PpPPzPoFo1zjqeJfdcUcbjqjgGlK5ePdzbSy3b
         UGFI+xJpqODzmvTwO/fOrlGq4mpGfnBFnKdnhFhQYD69BowYk4FYnOJ9+q4sP2i21szK
         ahbmshcS2lAv82XQFSGH6PNmmnsep4tfU8z7+/gszyCivlWowHn4BmHzNfOv1ewMhP5y
         8kCA==
X-Forwarded-Encrypted: i=1; AJvYcCV6qW3PCjfmsU3xajOZEluJbiqmduZa/nYCnzebvQHSyO/rFjPmLq8DDduVjFRsTeNXJq46dKHL9V3NACuhxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywu6nzQ4dESxr0DqdvVMu8xWybUKw4jLIlNIMWLOAhFnUIGetqO
	2/3xyQtLY0lPqfPWBm753xBvlQMc7/Hqd/21qeY+QaNf2sYH5j1CMvYTBQLlldYqeUDMVKU5+xF
	cvysjil2IXLNTL47Fe5shlW6jYbw=
X-Gm-Gg: ASbGncsg2aOGxQp071sGbvK6JgaaCITbXJWis6Fzkjyzw80D6m+nQxn5MkpSP7Slca+
	Zibqz1G1gN78vElcMYwTRk5bAGYj0gjwqK6XmIt07FvMmfZg5wW4AjLDId4X5hmsAeic935sg5q
	ifaKuT8GU+tA/AmY5Cc61NCVd1L4s=
X-Google-Smtp-Source: AGHT+IHy0byJnCuVMXrI6AJh5ocZ8SngCGKvQOgZlVqfox+lUeg50TwL+nwFYQw3i7wWPHJ8oVgwl+RCo/bDzBfxPsI=
X-Received: by 2002:a17:907:6093:b0:ac3:17b6:737 with SMTP id
 a640c23a62f3a-ac330489663mr2006657366b.45.1742324019491; Tue, 18 Mar 2025
 11:53:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250314085858.39328-1-vignesh.raman@collabora.com> <20250314085858.39328-4-vignesh.raman@collabora.com>
In-Reply-To: <20250314085858.39328-4-vignesh.raman@collabora.com>
From: Helen Mae Koike Fornazier <helen.fornazier@gmail.com>
Date: Tue, 18 Mar 2025 15:53:27 -0300
X-Gm-Features: AQ5f1Jqexkq1v060b1nOUslkHnhYmXG2PP3WoUMn-4HQvHnlhFu6oru5qnG3QTk
Message-ID: <CAPW4XYb6zci74=maL8bCPDXMV=WZG=M9sFnpNxMX3auELvzUSQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/ci: arm64.config: mediatek: enable PHY drivers
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, airlied@gmail.com, 
	simona.vetter@ffwll.ch, robdclark@gmail.com, guilherme.gallo@collabora.com, 
	sergi.blanch.torne@collabora.com, valentine.burley@collabora.com, 
	lumag@kernel.org, quic_abhinavk@quicinc.com, mripard@kernel.org, 
	jani.nikula@linux.intel.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em sex., 14 de mar. de 2025 =C3=A0s 05:59, Vignesh Raman
<vignesh.raman@collabora.com> escreveu:
>
> The mediatek display driver fails to probe on mt8173-elm-hana and
> mt8183-kukui-jacuzzi-juniper-sku16 in v6.14-rc4 due to missing PHY
> configurations.
>
> Enable the following PHY drivers for MediaTek platforms:
> - CONFIG_PHY_MTK_HDMI=3Dy for HDMI display
> - CONFIG_PHY_MTK_MIPI_DSI=3Dy for DSI display
>
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>

Acked-by: Helen Koike <helen.fornazier@gmail.com>

Thanks,
Helen

> ---
>  drivers/gpu/drm/ci/arm64.config | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.c=
onfig
> index a8fca079921b..fddfbd4d2493 100644
> --- a/drivers/gpu/drm/ci/arm64.config
> +++ b/drivers/gpu/drm/ci/arm64.config
> @@ -193,6 +193,8 @@ CONFIG_PWM_MTK_DISP=3Dy
>  CONFIG_MTK_CMDQ=3Dy
>  CONFIG_REGULATOR_DA9211=3Dy
>  CONFIG_DRM_ANALOGIX_ANX7625=3Dy
> +CONFIG_PHY_MTK_HDMI=3Dy
> +CONFIG_PHY_MTK_MIPI_DSI=3Dy
>
>  # For nouveau.  Note that DRM must be a module so that it's loaded after=
 NFS is up to provide the firmware.
>  CONFIG_ARCH_TEGRA=3Dy
> --
> 2.47.2
>


--=20
Helen Koike
