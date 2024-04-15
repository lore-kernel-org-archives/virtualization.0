Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA01F612EC
	for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 11:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713181607; cv=none; b=hjjf+ijfsI482k2Ivo+pY8aB78DxdQu2EQ4eQFVHZXBoYbWp+65dQUqqQ4dhPHJ6wpWX1k2hLeFyLVpPM7wYJXx//6xDfJ90lc1rReRFQe/dhTMIRILES9pX8kBFHR4GVGOsiaFftBWxgT+Btis3OWRuQPeAWLhHjvaC2TIXFY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713181607; c=relaxed/simple;
	bh=G0HhoxszPbF9NpJkaiR4im0ES+4yQ6Veyy/XPAB4JZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=anxFcBRWuWF2axIwm0q+fKTqJBjmI+wM34dPBJ3WuvMGe7EIa+iVLi8l595+wVfi/tKr3/52kqxJmt+4W4w4jXe76SB1DNDV9tNB0QhsKrvq2xdq8/K5UP8VTOXKeVIy+Q0aRyMf+z5Ga3nNHQfMCgGY6iTYQ/4rIUhsgazAedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=STWj+5zD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STWj+5zD"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41868bb713cso4846615e9.0
        for <virtualization@lists.linux.dev>; Mon, 15 Apr 2024 04:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713181604; x=1713786404; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q/XTGiszVeV2U+fi7d7DW89OoniTeFFzxOJmQzqNlPs=;
        b=STWj+5zDZtqL5ONAQ1dfnYCYYz4uepCG2yNhy18f7v35E6jLz2zHdKKyROgDlFvC6R
         5eNJGD7iQKivKSpCzm59eI2u4PuHYonSBdsOxUs0KY1d6uYH6lJZ+iBQ4HO9hLuN8WLi
         OIL5BYnRFmeNh6wqha1Awds9y9gUBpso8RdcAZVgJ/rDNXYFWV8x9LTT1Bg/tH4FJrNl
         a6XN9A/y8BkSd78lst73x6nHlq9AkviECLhsbPKgr/jDbqzjF/NWJRy6dp0kaxWhM41x
         QEIQhjGuusWKMpCWwg8B/MjC7wn+F6+fu3VOAy40CRT6C+CqxKKOtEKIx7sOxXsvYfac
         hJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713181604; x=1713786404;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q/XTGiszVeV2U+fi7d7DW89OoniTeFFzxOJmQzqNlPs=;
        b=aS9ock7rIbpLLOdismgSC+iBxJexVxDHd03h/sP/tHeE3dNsNk9TcmcROualqKwb5L
         i82kdnZTOsT8GQWaAg4JkF97C8f2zQI3M/tPFmgU6KTPr2N53D4PvGOCRaq9Obp8QK4S
         lOvRuNUqclwjhpwzu61Xg3TF1zvfWopcBordZVXMgJDV4QO6fHBQjZjXnHACk70cEFfi
         Ue9DVf4kF9MYmKj0IVZUYcdHEAUCjXADeCxwTPpdByJRWOx82fjyblf9uMupXQfzAchS
         r37toeZJ8MkTdW11tlUhd9jLoJRmv5zSksTcLwgtk7Hh3GuYCI/dm3vAH0Ck2JvwUwIm
         TI1g==
X-Gm-Message-State: AOJu0Yy1vHYKDF3fC0DQ5+1Gpo7jX5ty5/E8FtyVj3IYkpAyk1naBcTM
	DsIS9JZ9OHzfATgiCSj2AWtbmRhtq8/8a5HizcDuFotFmKmTTaSllxyEeZhix1A=
X-Google-Smtp-Source: AGHT+IGdDa27CAAJwYbX49Cx6+FbcSrj/I6z+QBAdQdkZ0RG9ETzirr+mEAyCbWEh0CCbibqYXWlOw==
X-Received: by 2002:a05:600c:35c7:b0:418:4aac:a576 with SMTP id r7-20020a05600c35c700b004184aaca576mr2995769wmq.39.1713181604176;
        Mon, 15 Apr 2024 04:46:44 -0700 (PDT)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d4b46000000b00341c7129e28sm11851802wrs.91.2024.04.15.04.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 04:46:43 -0700 (PDT)
Date: Mon, 15 Apr 2024 12:46:56 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: flyingpenghao@gmail.com
Cc: virtualization@lists.linux.dev, Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH]  viommu: return error code for unknown probe type
Message-ID: <20240415114656.GA387653@myrica>
References: <20240415081823.18847-1-flyingpeng@tencent.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415081823.18847-1-flyingpeng@tencent.com>

Hello,

On Mon, Apr 15, 2024 at 04:18:23PM +0800, flyingpenghao@gmail.com wrote:
> From: Peng Hao <flyingpeng@tencent.com>
> 
> If the probe types processed by the loop are all unknown,
> no error will be returned.
> 
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> ---
>  drivers/iommu/virtio-iommu.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 04048f64a2c0..80352505b762 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -555,6 +555,7 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>  			break;
>  		default:
>  			dev_err(dev, "unknown viommu prop 0x%x\n", type);
> +			ret = -EINVAL;

The intent here is only to warn (and it should probably be replaced with
dev_warn()). I don't think unrecognized properties should cause the
endpoint probe to fail, they just indicate that the device supports newer
features.

The virtio-iommu specification states this in 5.13.6.7.1 Driver
Requirements: PROBE request: 
"If the driver doesn’t recognize the type of a property, it SHOULD ignore
 the property."

Ideally, new PROBE properties are introduced alongside a virtio feature
bit, and the device doesn't present them in the PROBE buffer if that
feature isn't negotiated during device initialization. However we don't
yet have an example of such extension. Did you encounter this problem on
existing systems?

Thanks,
Jean

>  		}
>  
>  		if (ret)
> -- 
> 2.31.1
> 
