Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B983233140
	for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756716; cv=none; b=CSZXSW5BxcSNdzZwnqo6CTHYeAGNgP18DQaW1wW9cfd3XOlPv/vfjNEeX80AZAVQzXNGvfcVii7LKXNOgWsPS4hTmyb0vBQbCXMVW/7z5CZriydIj6G73S0H6V73u1/lcvHwYw75KrtEdY/AuHR23NeZJfzqu4HtPN3j6pe/eks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756716; c=relaxed/simple;
	bh=5t/TrcuXNWNUZTuS5pgxHTJQKuHzmhw4UrOTlIJ4BOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QcVsB5JsE7iPBpnOdMJcmqcF0FOC+755+oUTtM8YE4vxQ+JXnzRnZQ/cTwGVcvuHSR0xO+gfTfe0B1kR4KzT1SzOwCfGmjsQQAL3QGS4KtwwaDM4QTsJ4nV83ycZWT0rlnXvg1gkgSj6Z8L/HReRm4tnCZaNiba0q8MjTnEmpZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ewRiOFrE; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ewRiOFrE"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5401ab97206so3985454e87.3
        for <virtualization@lists.linux.dev>; Mon, 13 Jan 2025 00:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736756713; x=1737361513; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HsOOejTFjVwFwvDCfWyTG69OVT7YoO10LJVJy5N++GA=;
        b=ewRiOFrEsokfpKwZ1bQcHZjYgHVEn1j2qW4EGVURUOU9CXz/omvW4jRKg4nO5AESwE
         UAnC0cZsF0M4FnKLaGvj0nKJKBFB6YVh+l60FhH/MA4lBV8uxRZnTu3yYwx66cvqFwJT
         iPAJ7DvlNYh4eekh11LXEFRGw4EnVDXJCdpSfKsYsVewZ2AFgbGMmZa74Xb4UVu5gPul
         UntwDorxHdfIab2fWxiOYWtJId3+fEpCBI89vg/Cl8SBs9nTonurfifaufLDALEgdx7e
         bW+ejhgY+8iy6VboomzQALY4y9ljgmb+h5Ltq86/YrBiOM6xgnVH0HsYRzwcWrge2pN7
         aMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736756713; x=1737361513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HsOOejTFjVwFwvDCfWyTG69OVT7YoO10LJVJy5N++GA=;
        b=F6F5RDXvjBkDLsHaDWvi3gWoS3tqI2GCllXd8wfKzAfsIwFwz78T+YcqNN9uEBsx7h
         96iN7AXkVRzcJ2xygjQUf5WOQanxcKqAdMqTwAqg7/0vzQY9bOIaG/JKJsDIxi/EbA9v
         0bBGdEG2+OJUib9iZVNH7OnZosmKcKjV9m38bqrchWIpkw0kBlTgbhIX4VTJQ8RYwVUL
         XWBIJHO5rm7t45pqY3k0+D1N6u0zqEiZZL/nvlCB+VPNp09TXbCO8ns6+93JGNnbWq54
         qdLcED9bQ/3reu21lqDSNZ//iQjgtuQjqCB9siv6tKPe1HB9nHbhEM8TQ0PV8/dEJVgK
         YCkA==
X-Forwarded-Encrypted: i=1; AJvYcCXhQc5i9VTMCtxMru9yNHwM93mUN7mGFjO+sYpdfyWwL5JM9QbQaGExQyokbKTHICE146V4YcgMdRbKvAO6sA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwEB8fe79who2XuTrlEZLgvvCV1bIlDZBN0v6OlPHP7tdKVSmD9
	9XjtEaRe3bna1rvB7cx5PaSFHnH9iuVAXlZNLGvtYAW4UKB64bTvGIoj/a6SGgQ=
X-Gm-Gg: ASbGncs3adfnyHJMKwpXiDQJ4pYFCgLTynGUqoPFia858yw0xFJcZRsWC7WNcHPiuZL
	5M9gR+T0hSL8dmHRth04rgWBcQxsfJqPrjXoNxaTU4ow0DSOhXoHPIg1n8+TdXNf9xqT0a0XN5e
	lU+2MnK5u6VIbo8u3udRXaOIcQm7nVU9MNPX0/9DOKSMy7KgFx2TSOgeTkQ3dMIiRpSZQVZzzHG
	7pAJxji2D0Cv7zuxxSHLAzUmOZcK//wylud4kkJ4eUPWLBcBDuCpeDko/7+Qc04ze9nE4XPJi44
	DsDDI8Lai0wUBOg3ERkxZmJKA4dRl53EY3ay
X-Google-Smtp-Source: AGHT+IERZWZtkZrsbkHThnFiBHKfz//tsYW/urMLTgJODZNi9Tp473Grr1NqQ4M0NySCRCOoV5n3Rw==
X-Received: by 2002:a05:6512:138c:b0:540:2188:763c with SMTP id 2adb3069b0e04-542845b0b55mr6338144e87.37.1736756712614;
        Mon, 13 Jan 2025 00:25:12 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428bec0659sm1286326e87.185.2025.01.13.00.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 00:25:11 -0800 (PST)
Date: Mon, 13 Jan 2025 10:25:09 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-mediatek@lists.infradead.org, freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org, 
	imx@lists.linux.dev, linux-samsung-soc@vger.kernel.org, nouveau@lists.freedesktop.org, 
	virtualization@lists.linux.dev, spice-devel@lists.freedesktop.org, 
	linux-renesas-soc@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-tegra@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, xen-devel@lists.xenproject.org, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>
Subject: Re: [PATCH v2 13/25] drm/msm: Compute dumb-buffer sizes with
 drm_mode_size_dumb()
Message-ID: <bbw2n4ccn5jlq7q7lsw3xdnbieazgexkwkycrqvk5aoiq5q3wx@nz6gd3unwkg4>
References: <20250109150310.219442-1-tzimmermann@suse.de>
 <20250109150310.219442-14-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109150310.219442-14-tzimmermann@suse.de>

On Thu, Jan 09, 2025 at 03:57:07PM +0100, Thomas Zimmermann wrote:
> Call drm_mode_size_dumb() to compute dumb-buffer scanline pitch and
> buffer size. The hardware requires the scnaline pitch to be a multiple
> of 32 pixels. Therefore compute the byte size of 32 pixels in the given
> color mode and align the pitch accordingly.

- scanline, not scnaline
- the statement about 32-pixel alignment needs an explanation that it is
  being currently handled by align_pitch().

With that in mind:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  drivers/gpu/drm/msm/msm_gem.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 

-- 
With best wishes
Dmitry
