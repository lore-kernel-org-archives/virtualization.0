Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FC01292EE
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 10:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714471799; cv=none; b=h5youSmScauRmfnIt6V8GqUKQmK2exosO1oChiZOEmO2V5b2NKoASCIqN+7BBWB8sE6k0xJmTA7eaIof/6POllOs6WwZcW0nWRwJkVM72Nd3Qh/hYecKlwgPJLApBAtkiu/bBpQJPuC2BWPWeWmSOTDuJdYWYbOQdtn+bU0EZ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714471799; c=relaxed/simple;
	bh=mNpTAbsh1hHbVBOwdxXS11hKaRI+rocDAKPjlm5GISQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC3Z2d3YgI4ykMKUCKDShDd92LZaCzU9k3DZgwfzKaIYEgLOxmwxCPMH15Pb978KN3pqnqzYesLBvYA4Xiq+6Oy6CIcWEopW2KPoynFVdPv8BR9gPXExSoXYbwWxSwjL5O01H6UA8BBvNdNcXPtFfFRHHNfaET/VdyIcq+2Rc/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AXQYeWCC; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXQYeWCC"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DB99400F8
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 10:09:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hsuCxaO9_4yz for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Apr 2024 10:09:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::135; helo=mail-lf1-x135.google.com; envelope-from=dmitry.baryshkov@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E6413400F3
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=linaro.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E6413400F3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AXQYeWCC
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E6413400F3
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 10:09:56 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-51b526f0fc4so6897526e87.1
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Apr 2024 03:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714471794; x=1715076594; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mbwpFJFih7RIT1NY26n8+loi/ZJwnp9wrw9uANwmIA=;
        b=AXQYeWCCzH7m9M25flffWJ3xg3tdT7gZNjtBpkU6upbI8brvlZHWzSXWEUQupKbHZa
         zAGjb4wde5ZErO6pjSK8lEOJPieI2QzVMwrSp7CUukQ8RZHMOVMCHqrNoZT5mpTpRn+v
         ZDTKStBqCnPsBvyuB+rqbKtP+30tQGUbflI8C71ArD0kFKJELCRoiq7uxOnbCV+2Nleb
         krwV+0O+dAoqhnb0lUHCwL27hzsx5DraYT1fxhxD1ZTBSM9X3v7LH65egAgLzYfd4uhx
         /gFYU116QswFvwe1Ab3bIKCT0dagZ3j6Elk4uTL8CKViXuG/RoG7EgMSiiBgCjGVQyKB
         GpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714471794; x=1715076594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mbwpFJFih7RIT1NY26n8+loi/ZJwnp9wrw9uANwmIA=;
        b=rVks1bINYGS7B71RuoH9J2s4eIJFpUpJHFoexKq3qIlvQEfavrzdDJktpsmL2bqCMT
         LTTSVT0bIA/rxCvB7YfNRmABA+rVcR6znm79XcBjXtoV8FOTDPIsufieeOzQC4D4dxrf
         x01x75bFLtSa2d59XHnaD/KV8Q1JjxWtiqh0l40pe6gQcFeOtvep+XZHye2bGyA4/1Yp
         w4mqwRObHiChzqPTx95d8Lf+uxoqfm/HLg0vlnBqYSP80nvW9kxUpld+YhOUB+fAejZR
         nClbbPFVlCEXfcvJAysaa/zEsJHNpvTAvQVlbQVAa244k54RQ9Gb5JgymbNOu88U+amr
         yg5A==
X-Forwarded-Encrypted: i=1; AJvYcCXVuWrYrJ6y0KZMCC1tBPfr3YzM5KQBJO/oLAb+J8tggvfjPF++b4n31lV14UO4c8jt7rtGbemcypZg0+0LzK3R50sZCEMmAjuwxCTwkmuFxTk8BvHRWfO9Tw==
X-Gm-Message-State: AOJu0YwLP9E0SlZSDHnXrUhqhl+xMti/j0nM05EXBFtolm1+VUDySyWl
	DlaijF5JYtri3VjbAsDdRPUERdDkWwbX2ehdsLEMQemQemxoLQEMlMP+DjzaZuY=
X-Google-Smtp-Source: AGHT+IHLFfBk+3bT5MCPiG0Sy+oXtj7PLWqAxH1nSKl7+nAmTFj46bAxdYE1eFckW76M0RQSsj0nqA==
X-Received: by 2002:ac2:5607:0:b0:51a:f596:9d53 with SMTP id v7-20020ac25607000000b0051af5969d53mr1449277lfd.42.1714471794305;
        Tue, 30 Apr 2024 03:09:54 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id b30-20020a056512025e00b0051bc39ef08esm2453377lfo.10.2024.04.30.03.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 03:09:53 -0700 (PDT)
Date: Tue, 30 Apr 2024 13:09:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch, robdclark@gmail.com, 
	david.heidelberg@collabora.com, guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	mcanal@igalia.com, linux-mediatek@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] drm/ci: skip driver specific tests
Message-ID: <esplx2t6yfrarxflxo5kq2lstx7uiy2atzcxtwf7kugsctnkat@ameojtgtpopj>
References: <20240430091121.508099-1-vignesh.raman@collabora.com>
 <20240430091121.508099-5-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430091121.508099-5-vignesh.raman@collabora.com>

On Tue, Apr 30, 2024 at 02:41:20PM +0530, Vignesh Raman wrote:
> Skip driver specific tests and skip kms tests for
> panfrost driver since it is not a kms driver.
> 
> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
> ---
>  .../gpu/drm/ci/xfails/amdgpu-stoney-skips.txt   | 14 +++++++++++++-
>  drivers/gpu/drm/ci/xfails/i915-amly-skips.txt   | 14 +++++++++++++-
>  drivers/gpu/drm/ci/xfails/i915-apl-skips.txt    | 14 +++++++++++++-
>  drivers/gpu/drm/ci/xfails/i915-cml-skips.txt    | 12 ++++++++++++
>  drivers/gpu/drm/ci/xfails/i915-glk-skips.txt    | 14 +++++++++++++-
>  drivers/gpu/drm/ci/xfails/i915-kbl-skips.txt    | 14 +++++++++++++-
>  drivers/gpu/drm/ci/xfails/i915-tgl-skips.txt    | 14 +++++++++++++-
>  drivers/gpu/drm/ci/xfails/i915-whl-skips.txt    | 14 +++++++++++++-
>  .../gpu/drm/ci/xfails/mediatek-mt8173-skips.txt | 12 ++++++++++++
>  .../gpu/drm/ci/xfails/mediatek-mt8183-skips.txt | 14 ++++++++++++++
>  drivers/gpu/drm/ci/xfails/meson-g12b-skips.txt  | 14 ++++++++++++++
>  drivers/gpu/drm/ci/xfails/msm-apq8016-skips.txt | 14 ++++++++++++++
>  drivers/gpu/drm/ci/xfails/msm-apq8096-skips.txt | 14 +++++++++++++-


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # msm skips


>  .../msm-sc7180-trogdor-kingoftown-skips.txt     | 15 +++++++++++++++
>  .../msm-sc7180-trogdor-lazor-limozeen-skips.txt | 15 +++++++++++++++
>  drivers/gpu/drm/ci/xfails/msm-sdm845-skips.txt  | 15 +++++++++++++++
>  .../gpu/drm/ci/xfails/rockchip-rk3288-skips.txt | 17 ++++++++++++++++-
>  .../gpu/drm/ci/xfails/rockchip-rk3399-skips.txt | 15 +++++++++++++++
>  .../gpu/drm/ci/xfails/virtio_gpu-none-skips.txt | 15 ++++++++++++++-
>  19 files changed, 260 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8173-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/mediatek-mt8183-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/meson-g12b-skips.txt
>  create mode 100644 drivers/gpu/drm/ci/xfails/msm-apq8016-skips.txt
> 
-- 
With best wishes
Dmitry
