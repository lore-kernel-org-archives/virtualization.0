Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF46225AE
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 11:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202847; cv=none; b=Oj28zCXCPpR3SZyVfackdEA5M2PLISJrMfJVUHB/oZq99I5AZmzYsi4/Ad+8ZI7qaakuxRmn8ZoROn9IS9jRudRDUIXkYN1JpHUXzdrRzcPdi30PaNdrKjCsQHKRL9UnhyG3E6PnqgonJsYLytosSOW9pnO1AsjEGIKS5McTQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202847; c=relaxed/simple;
	bh=opqwwImqcKJM//Av+ypRrBQEF3Ht3H8zS8zbCZiPUdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6Bezdm/8oCa8LEYd7T1wTqPOWBLf5jhnIG6rbMVPlZQVXBY3TdztkOVvTYBP6kRGyMN0In/lue0FnHyu6dt6m38bheXRQBzFd0BOHx1fv7L1ynC4YN1CWcljUlPEeiPCH+bnaoiQyCNshJKBhXqMZHu1Y3HY7nsZvO39T0LRYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j20xmqpB; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j20xmqpB"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4C30D401FE
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 11:00:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RvKdbdGOm4SF for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 11:00:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::12a; helo=mail-lf1-x12a.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 594F940173
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 594F940173
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=j20xmqpB
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 594F940173
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 11:00:45 +0000 (UTC)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-51ffff16400so6604167e87.2
        for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716202843; x=1716807643; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zbU3zeRUyfJhQipGYR6FKYCuEp6+mBicTADebou1jyQ=;
        b=j20xmqpBmf7HJGp/QveZlALzu8rFylFNrMAeU+x5sgm3peTo1ywguIRzRmuuitOTUj
         Arhm2SU3i6BnM8K4FeF7u0F8KAwhlP42A5XVmK4E5/8569OdytpsDEe99wMHmo9Rp9bb
         auKwgfFdqtn3d8YgyIjpcdoz2U3C3O7uZocuY8Zs1UO3sSxwS7ssIsCpMqZiWKepwGac
         2UXAktR7gkiIyzDa/PN02okkoGzy0d7Gpf7KlvAfsEkH/QMv+9QBh7P2YgUmI2T8ohG1
         o4IuH9KDpDu9oClq3O0ZRZuXlsZitRnm1hsS5kOUzu+yK7RfWGQXK2r3oJukJXwzb372
         hQMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716202843; x=1716807643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zbU3zeRUyfJhQipGYR6FKYCuEp6+mBicTADebou1jyQ=;
        b=gnbKOe0QqJXvmwkzBRHkYFtk6SpxAYDlaXfFLcicTseZkVjbQXWVCAHhkNztzvgb67
         9m7htKRWytzAYRrMeeDNtKJMdjEukrwd4Ng/WYQRs6c7WL3Vjjx4KkTLD5zJxzvnDO5O
         lomJTjRnS+ju2BxgW3ZGxRNwp3EFZHa9RfV/6gr/7XW6rwwM7xEOlmiONjYDHzphMzdo
         nWD68LofJnoQMoKakDIzlF6w3DIBmxup5eR2YKeFrNbkQi449aPS5uVROtjjI+bd4oSQ
         1xWC4avZa1/BCV2dvZa+SLDygEVXL+s1mmmS0aHtqsi8D3PG3eKpbYNESxjNh1iunVeP
         Ku+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAshhXvA0m84TTw5FjouBRmI5VAxZhuZv2EkffsKO3h1qrpoLbCBcdR7Ci0w34jyzeNQVvtWxXqpHaBO99rOvU5YWD0QdZN7AC5qr6Lmao4zlL4Nx9u6QX1w==
X-Gm-Message-State: AOJu0YwP8bB/XGtGGzHomMdI6/BwMtyDsWMDzAvtS3JfAYTErmwaFyWb
	r5O8ocm5lQQ2sBMKWY86Lutl07Yug6JEMu88juT8Y9Oh247HM/sIEOHGdMlmDQY=
X-Google-Smtp-Source: AGHT+IEoP2+bL0oMFj4P0Aa7CMuek/Wx23WK1fJZHUBxVQUK6n4Or8upEK0eOTuockV49z8ZJoyWZA==
X-Received: by 2002:ac2:504c:0:b0:51a:df97:cc8d with SMTP id 2adb3069b0e04-5220fd7cc70mr18338046e87.26.1716202842997;
        Mon, 20 May 2024 04:00:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f35ad5fdsm4253446e87.24.2024.05.20.04.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 04:00:42 -0700 (PDT)
Date: Mon, 20 May 2024 14:00:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] drm/ci: generate testlist from build
Message-ID: <o363vir3dqz2znrnifo6enbdwudalmxqbigdkci2ykxf5qjbnx@2ngllflxotgk>
References: <20240517092502.647420-1-vignesh.raman@collabora.com>
 <20240517092502.647420-3-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517092502.647420-3-vignesh.raman@collabora.com>

On Fri, May 17, 2024 at 02:54:58PM +0530, Vignesh Raman wrote:
> Stop vendoring the testlist into the kernel. Instead, use the
> testlist from the IGT build to ensure we do not miss renamed
> or newly added tests.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
> 
> v2:
>   - Fix testlist generation for arm and arm64 builds.
> 
> ---
>  drivers/gpu/drm/ci/build-igt.sh  |   34 +
>  drivers/gpu/drm/ci/igt_runner.sh |    9 +-
>  drivers/gpu/drm/ci/testlist.txt  | 2761 ------------------------------
>  3 files changed, 39 insertions(+), 2765 deletions(-)
>  delete mode 100644 drivers/gpu/drm/ci/testlist.txt
> 
> diff --git a/drivers/gpu/drm/ci/build-igt.sh b/drivers/gpu/drm/ci/build-igt.sh
> index 7859554756c4..e62244728613 100644
> --- a/drivers/gpu/drm/ci/build-igt.sh
> +++ b/drivers/gpu/drm/ci/build-igt.sh

[...]

> @@ -26,6 +50,16 @@ meson build $MESON_OPTIONS $EXTRA_MESON_ARGS
>  ninja -C build -j${FDO_CI_CONCURRENT:-4} || ninja -C build -j 1
>  ninja -C build install
>  
> +if [[ "$KERNEL_ARCH" = "arm64" ]]; then
> +    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib/aarch64-linux-gnu
> +elif [[ "$KERNEL_ARCH" = "arm" ]]; then
> +    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib
> +else
> +    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/igt/lib64

Could you please clarify this part? The arm64 vs arm don't look logical
from my point of view.

The rest LGTM.

> +fi
> +
> +generate_testlist
> +
>  mkdir -p artifacts/
>  tar -cf artifacts/igt.tar /igt
>  
-- 
With best wishes
Dmitry
