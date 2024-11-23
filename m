Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1835C3C466
	for <virtualization@lists.linux.dev>; Sat, 23 Nov 2024 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732379317; cv=none; b=ip6AXvz7pBp6xKXuc/TbQtgoLvU3uo2pT+qV9Yj8YXR7VrhJb8RmBRkfAAAuuH9Zt6c8Ci4DGKtViT8Z1Z0flMbpH0jVbgJgqjk8F+TbFE6iPlLz8gPChPF7ES7HBXjyuTPFd8A77Ebm3Ls3+YsojzHGg3y1mrvYOMO4GlxLyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732379317; c=relaxed/simple;
	bh=vdx1suno17IuHcCGvmAN0knP6K0z8ynfDrFJblEl1Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0LxKaZGbNtxjdkDCR7J1TdM4cvFyEIUXYyxL4T9XcHeqvHLZT1zi3eTaDYuTomN87wswovW6SbNs6J5oU/Smur7qpkQXTJ8hHjbZkr61Hzl54ZRrbwGNAkUs7J/mhiLM6HvX5mezjYySfCv+Ki7yslmXEkGfl+U1MTbqPbIsMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XyJFiQU8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XyJFiQU8"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53a007743e7so3503418e87.1
        for <virtualization@lists.linux.dev>; Sat, 23 Nov 2024 08:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732379314; x=1732984114; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h/Pl08QUPuKL5fWRHLnSBBIgiCofcCWFTEDw/7LzjT8=;
        b=XyJFiQU84WG2HsYwM2DBH4nGjtM6Dln1sbtWk2WpemcOOv8lBgSgzlMJs7mpceHX0D
         im9hBNerXnm9EDUMU/OSqSG1kBtTQ6Ibog1gx9YDAmVhWld7epHNh7F0Xw/mJRY8ZvER
         pc3QaM+2mOfXPL1AOxzWruCArsFMDGFtVVHntwxyasQM6OPDqVYPMdEbjiGMbrBxBTuH
         VScQpy9E9LBZpqpL8F8+YRnDexxhxu6M14QXUKWs4rFknGLLgIVzhgpSlk+8uEzSW3Qv
         LNkrzZbQQcOp0t7L81H+/4Q241prWmP2NK7BO3HuvLyWj+opKVwfmA3LD+sdwr+Cr1oh
         p09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732379314; x=1732984114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h/Pl08QUPuKL5fWRHLnSBBIgiCofcCWFTEDw/7LzjT8=;
        b=LCQ51HZWATLox7rDnULU5d0I3TVRr4dIx1loQ17y16M7FVPNyfwp392IZhGe5zUyEc
         Iojd90qBsn1f8VSdO7xLfy8j+qHfSEU3cohb0l0xqsMLvFcfoXz0OlrZBtFeYUpaesgM
         QiMjWo/HvNEqdeulYvO7c3JeXbqNmIfuyDVWngxD8Nb9z4mWF+3PteIaXWyySgl7QQOP
         d1vXrKGK1B+nrnBzEeaycz1VgH1GqK/F/W0IDxnTBGeHzwOiuil8Qt9moqRUSDM18bRU
         opvwj4UXrmQIqNk2rZvC6GHSEPYrTJ2n6IFnSaIVyjM1+B4XHafKbJ2AMZsS8Ar27GOf
         oH3A==
X-Forwarded-Encrypted: i=1; AJvYcCXl3ozZo5PwJsMmYylf7Tbdsw6jfxJBQtQDInXQ442miTyLeTGkhw3JyYssTwTPHlrSr2S3Aam5+f7Y+0LKag==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ9UMxwO1pUR7PzjIqvGJYx5kaS+cTOjykW+e4PWWvBJLjaOvT
	TUkDdukeHRn+b3+BxG4Tn8xTeqvrt4e8LQf6L2NpP3VWk6WNAgCRq84is2MSsio=
X-Gm-Gg: ASbGncvpYJ5xizL9xXPcCbLKa707CZZ6ogtGaKkk98w1wVKrGDC/NlbrPUKCuw//SgA
	7UymVCaJFCsG5IrlAe8NIEm1mAi5+F4M5EOKXhE+/3mAL4P2w0FVsgS1okF4znR+gQopBzBTEIb
	tn248nwjPTE/hJ7Gzk4+VQYSmM5R+WPGR5Wfh0z5wy6h0EjjZJBlErrPkO9TU8K+iFknlkFQx+l
	GohbX0BQz1BsbRdSQ+UUDUUPzOSv6onUuQWeCQ8HxR1cfBCm9N8c+Rdc1nEcP6x9zHTL8aoXspM
	MIlFKF2pasoaAVKxv913ZLI6iQvIIQ==
X-Google-Smtp-Source: AGHT+IFvAsLUXPoRNkWhRpJryldr2ECx/WRa6OPlTabGGwJsNBFlz2rBkajwmVrME7jHv4HZvi5yzA==
X-Received: by 2002:a05:6512:a90:b0:539:f8c7:4211 with SMTP id 2adb3069b0e04-53dd37a5c34mr3004585e87.26.1732379314192;
        Sat, 23 Nov 2024 08:28:34 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2497f04sm963206e87.254.2024.11.23.08.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 08:28:32 -0800 (PST)
Date: Sat, 23 Nov 2024 18:28:30 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: airlied@redhat.com, kraxel@redhat.com, dri-devel@lists.freedesktop.org, 
	virtualization@lists.linux.dev
Subject: Re: [PATCH 1/2] drm/cirrus: Use virtual encoder and connector types
Message-ID: <y74662j6zqvocvpa3zbig5owhqu2o43xdrwkeswgwd5mak2cx7@esgliauvzkh5>
References: <20241029143928.208349-1-tzimmermann@suse.de>
 <20241029143928.208349-2-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029143928.208349-2-tzimmermann@suse.de>

On Tue, Oct 29, 2024 at 03:34:23PM +0100, Thomas Zimmermann wrote:
> The cirrus driver only works on emulated Cirrus hardware. Use the
> correct types for encoder and connector.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/tiny/cirrus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/cirrus.c b/drivers/gpu/drm/tiny/cirrus.c
> index f06a2be71f60..0231bdf94b8a 100644
> --- a/drivers/gpu/drm/tiny/cirrus.c
> +++ b/drivers/gpu/drm/tiny/cirrus.c
> @@ -587,14 +587,14 @@ static int cirrus_pipe_init(struct cirrus_device *cirrus)
>  
>  	encoder = &cirrus->encoder;
>  	ret = drm_encoder_init(dev, encoder, &cirrus_encoder_funcs,
> -			       DRM_MODE_ENCODER_DAC, NULL);
> +			       DRM_MODE_ENCODER_VIRTUAL, NULL);
>  	if (ret)
>  		return ret;
>  	encoder->possible_crtcs = drm_crtc_mask(crtc);
>  
>  	connector = &cirrus->connector;
>  	ret = drm_connector_init(dev, connector, &cirrus_connector_funcs,
> -				 DRM_MODE_CONNECTOR_VGA);
> +				 DRM_MODE_CONNECTOR_VIRTUAL);

This will also remove the EDID property from this connector. I'm not
sore if that is an expected behaviour or not.

>  	if (ret)
>  		return ret;
>  	drm_connector_helper_add(connector, &cirrus_connector_helper_funcs);
> -- 
> 2.46.0
> 

-- 
With best wishes
Dmitry
