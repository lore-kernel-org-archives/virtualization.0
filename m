Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5782823D7
	for <virtualization@lists.linux.dev>; Mon, 23 Sep 2024 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727066153; cv=none; b=cfw6KZmfw0BQaPLgIe+LRuuklHd+jYsJ9cjMWSK1nw1myvKK/ifvok6PZ67audjzp6KYyfyg2XeS76+GOKgW7MvwB5xtVC36bysTy7oT5UT0h2v9M7FyimbLORs+7nkE9d5nqVf9kLq+frJXQiP4s1RQmkO81HJwFxpOOuLxiCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727066153; c=relaxed/simple;
	bh=SWQiBkOvaSoXWRkFAVT1WljyXlnXpNnpVgL9hUUeRN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBc00K0Wslymp+B9SRDElEHyw4vT/oCNbTWJDFLqyIz8bx3YGzfeN7Vt5RfaRJi2ulJdDnsdyJ79tyoujLnIMeW/J4qB+XXGEiAgpyBdLDASvPZszg+QJQi0rvi6OwgVZ7zZbn9jpy5eu4vp1ngi7fQCFgUdhRz4VPHTTdZadig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zx3QBzIy; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zx3QBzIy"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f74e613a10so54071801fa.1
        for <virtualization@lists.linux.dev>; Sun, 22 Sep 2024 21:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727066149; x=1727670949; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2JetWe2QTd8KWzvXFEGG8UYoUhkg88bJC3o+AzFZy+4=;
        b=Zx3QBzIyZQ3yvvM4TGSSY8KKoMZqgRwgLiATV+7PhRtW8hVJxt+2M6z0xReJQ8eDtm
         urYwe1jZ5+l5NR/VzuKPaxaEVktzAh3Wsrl1EFc3HQ/7UzWIKniJg2nt4oJf0uia5phU
         FqgX96K7l8tZ1/evRLGlHSO+LI2EctJBOi0zPhCBEHmx5PA83KB7cJzr3H4K4dIXwTbh
         LcG1L/fccNRDC2RwyK2CEv2GOSqClEmuTlLBwOHsE/zuo+p4TEb2FtlAsc3H35VddH/K
         AwlI7hjfUX32d3sM5RPe0YKk0NArog/4eE4O+H52ZB9b6Uqm1p7yNB/oikPurUkfjRD5
         2k8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727066149; x=1727670949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2JetWe2QTd8KWzvXFEGG8UYoUhkg88bJC3o+AzFZy+4=;
        b=eYO1DZOF+6zj2kckV14MKlC08F+deFrotqfh1AA3NGV6FJ5TFhJU1kwZVbGcoh6Jy3
         49STSgACJMWGSRJWJC8fIQ7qxjkfa7RITh3/k4M2mJa6VAjcS+sxA1yVD6bF1o5OA4K8
         sFaEWAnnu1iKsmSMW6htJik9dHB7fN/Rprfd3nbiKk/1vO3W3kCrG5v8sT3AEH0suPlF
         ioL/cSIKueMHimWDX2y6c7bf56Rm8KtOQ1FhJOi4cmlVnz4AAGdaaaK/trodjRm4KzKq
         Cqpgf5z04Gpu6c+pi9HSM007Z3lPuipeadVLEtq3rgYkzpk41bc9zTvOY4qR0RgpDp5h
         ssvw==
X-Forwarded-Encrypted: i=1; AJvYcCXnFS+ivmtp3BsHuI/vw32EjCwgo/ySlZ2ybDo3X7CEGMoDSVmK6wDgPxhzjVenuIkrPH+y4FB5gLj6xhMfxw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzCXYlQ5vq0jr6Zr/3wjV9uVnsTOMDzwrLiWXWOs0KYjdUpvsrb
	vRDHGhexNtXL+o4wetNLx9VTIEpUjbYozXDn/Q7AoQxJwr8NOy2wBMHezI+hjcM=
X-Google-Smtp-Source: AGHT+IFANWQ65KZ59WdgrDI2FuFpMbQnfiL3URTM3vOK97JEagYF4FdcVxplz+UK/NHUjDwB1sfURQ==
X-Received: by 2002:a05:651c:2222:b0:2f7:5049:160 with SMTP id 38308e7fff4ca-2f7cb30cb37mr68942501fa.13.1727066149384;
        Sun, 22 Sep 2024 21:35:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f79d2e1b38sm28430311fa.1.2024.09.22.21.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 21:35:48 -0700 (PDT)
Date: Mon, 23 Sep 2024 07:35:45 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: kraxel@redhat.com, daniel@ffwll.ch, airlied@gmail.com, 
	mripard@kernel.org, maarten.lankhorst@linux.intel.com, 
	dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev
Subject: Re: [PATCH v2 02/10] drm/bochs: Use helpers for struct drm_edid
Message-ID: <2fuwrqk4aeuflsxjr73zj6nyvvmpmiupam4oemw7oxfia22ila@5hehupmjzkhh>
References: <20240902105546.792625-1-tzimmermann@suse.de>
 <20240902105546.792625-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902105546.792625-3-tzimmermann@suse.de>

On Mon, Sep 02, 2024 at 12:53:40PM GMT, Thomas Zimmermann wrote:
> Implement a read function for struct drm_edid and read the EDID data
> with drm_edit_read_custom(). Update the connector data accordingly.
> 
> The EDID data comes from the emulator itself and the connector stores
> a copy in its EDID property. The drm_edid field in struct bochs_device
> is therefore not required. Remove it.
> 
> If qemu provides no EDID data, install default display modes as before.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/tiny/bochs.c | 48 +++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
> index 47a45a14306c..197fc00b373f 100644
> --- a/drivers/gpu/drm/tiny/bochs.c
> +++ b/drivers/gpu/drm/tiny/bochs.c
> @@ -85,7 +85,6 @@ struct bochs_device {
>  	u16 yres_virtual;
>  	u32 stride;
>  	u32 bpp;
> -	const struct drm_edid *drm_edid;
>  
>  	/* drm */
>  	struct drm_device *dev;
> @@ -172,12 +171,14 @@ static void bochs_hw_set_little_endian(struct bochs_device *bochs)
>  #define bochs_hw_set_native_endian(_b) bochs_hw_set_little_endian(_b)
>  #endif
>  
> -static int bochs_get_edid_block(void *data, u8 *buf,
> -				unsigned int block, size_t len)
> +static int bochs_get_edid_block(void *data, u8 *buf, unsigned int block, size_t len)
>  {
>  	struct bochs_device *bochs = data;
>  	size_t i, start = block * EDID_LENGTH;
>  
> +	if (!bochs->mmio)
> +		return -1;
> +
>  	if (start + len > 0x400 /* vga register offset */)
>  		return -1;
>  
> @@ -187,25 +188,20 @@ static int bochs_get_edid_block(void *data, u8 *buf,
>  	return 0;
>  }
>  
> -static int bochs_hw_load_edid(struct bochs_device *bochs)
> +static const struct drm_edid *bochs_hw_read_edid(struct drm_connector *connector)
>  {
> +	struct drm_device *dev = connector->dev;
> +	struct bochs_device *bochs = dev->dev_private;
>  	u8 header[8];
>  
> -	if (!bochs->mmio)
> -		return -1;
> -
>  	/* check header to detect whenever edid support is enabled in qemu */
>  	bochs_get_edid_block(bochs, header, 0, ARRAY_SIZE(header));
>  	if (drm_edid_header_is_valid(header) != 8)

I understand that you probably don't want to change the behaviour of the
driver, but maybe it's better to check drm_edid_read_custom return
value? Bochs, amdgpu and radeon are the only drivers that call
drm_edid_header_is_valid().

> -		return -1;
> +		return NULL;
>  

-- 
With best wishes
Dmitry
