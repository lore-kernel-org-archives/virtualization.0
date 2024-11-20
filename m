Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C3200CB
	for <virtualization@lists.linux.dev>; Wed, 20 Nov 2024 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732087611; cv=none; b=eJpe7Xt2H+pSahjSEolgVIJmGDFaVZzurFTKIwrMVfsoyDQWHb6NH2POANOxAn6KqFoHRRYAE30UD+Gc/Yt15GCF3CAzF6+7A4vly3qKVelHkkISPlNElawfrNzrBDBxDj6oD1Bf4KM+VqgkAtO+CGQCT+nMKGVnvvozHoHQAVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732087611; c=relaxed/simple;
	bh=biP9Dvrhc+G0qDx7cODYLf6RQAzvBJDKrAIMDhqkKjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LUzsCDUz7C3UWXEsEBIFP3/F4kPalxGczLk4/ZyDKLqp6XAER3hGujRXVOoBmLixcnYLyKJrsR8M+sYjgeq2vXIXft3GsPJ35Ga4DPpH0Y8SbhTRt/AvOlrNw1DHWRuFa2mVZgnhgCv5nq/+wb2LzU0QIE0UiYoaPOyYvUlAbag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MgLUepzk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MgLUepzk"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so2334704f8f.2
        for <virtualization@lists.linux.dev>; Tue, 19 Nov 2024 23:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732087608; x=1732692408; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIPtm7b8Gz8+1qEAQ0SdnpTPbujFoftQyLLRu5cTOkc=;
        b=MgLUepzkfM6om31bV8EwAgR8nLtGj+uoEAcouLPdveU9K+YbwhPpnZkhc6genj7ERL
         UWBNLJiX4GjCG/ytjIHhOq6+PBh42RANt8/2Q0Y+U3kX9MdfxTUurahW+5aEF2+rjt2F
         G5Apnuw5ynKjzmI62cbdLtAMuMxYqRZuvNqhqNs1O9tRJt7qW2Ziw/f/HVAT4C+vfwJq
         GdAaBZOI00pI/5nDaSTjF8XQnGpvPqjn5rtzmEaW9jGcaPodm5MBt1kzuRhkShBU0s5b
         dPfPGT659Se261SC72Pjj0NpNEh2pAkJ29WMlF0QCkMSc7y81BDDTnwECEq+qQsqFz1H
         4mKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732087608; x=1732692408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIPtm7b8Gz8+1qEAQ0SdnpTPbujFoftQyLLRu5cTOkc=;
        b=c2FJgADyPOTvIz1C5RUIvCXkul1nUANBcg7JEyMqm63RWaP+tZib/tGy1D1lTzGGEL
         E7ygV1QBDRBpOBKFVudQn+QZjxWx5yarvol6p0tVBr7CchFQnzYalEaLFeYasKM9ug3s
         Y+KE2jo5u7YDpEiHxTD04m9MMB1J5zBzsvlxNAjtS9NrLp5nDOW1G2IaKYIexnpSMJVu
         LW3W+UJpcVflhfOqmRU7q2l8qn3qf9R0e9w7SCNxok5YLeQKY7H4Bo9jbdeAKtgnG9n4
         jO066jFIttO1ajzXeKKQSWptVIBShqqJRfPsEV92PThe703TUcUWzIJ4IBaNn1NpyclR
         zcxg==
X-Gm-Message-State: AOJu0YwxCQD5R8k+yp0OzpZuhGWaXy47mTksoAuFsFDC71mSzkykqduU
	aehoDgNFZ4nLXcNvafvRPd+yPCx/bbDt4ACSoBFmyoagKxhXJB19/wqw/XMsm0E=
X-Google-Smtp-Source: AGHT+IE4o51sEx8SfAWBLWFg+1eVtkYzjlvSdvNDJErKDfiQXG6P7uoQ+i1al4onHerpPjh2jAqQUA==
X-Received: by 2002:a05:6000:2a8:b0:382:4a45:15ed with SMTP id ffacd0b85a97d-38254b1625cmr806374f8f.41.1732087607953;
        Tue, 19 Nov 2024 23:26:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38254911220sm1266335f8f.60.2024.11.19.23.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 23:26:47 -0800 (PST)
Date: Wed, 20 Nov 2024 10:26:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shijith Thotton <sthotton@marvell.com>
Cc: virtualization@lists.linux.dev, mst@redhat.com, jasowang@redhat.com,
	Satha Rao <skoteshwar@marvell.com>, schalla@marvell.com,
	vattunuru@marvell.com, ndabilpuram@marvell.com, jerinj@marvell.com,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] vdpa/octeon_ep: handle device config change events
Message-ID: <e939fa9f-fedf-4097-8dbe-45d3bc2523d9@stanley.mountain>
References: <20241120070508.789508-1-sthotton@marvell.com>
 <20241120070508.789508-2-sthotton@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120070508.789508-2-sthotton@marvell.com>

On Wed, Nov 20, 2024 at 12:34:51PM +0530, Shijith Thotton wrote:
> From: Satha Rao <skoteshwar@marvell.com>
> 
> The first interrupt of the device is used to notify the host about
> device configuration changes, such as link status updates. The ISR
> configuration area is updated to indicate a config change event when
> triggered.
> 
> Signed-off-by: Satha Rao <skoteshwar@marvell.com>
> Signed-off-by: Shijith Thotton <sthotton@marvell.com>
> ---
>  drivers/vdpa/octeon_ep/octep_vdpa_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/vdpa/octeon_ep/octep_vdpa_main.c b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> index 482c178a5221..6db951c6cb92 100644
> --- a/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> +++ b/drivers/vdpa/octeon_ep/octep_vdpa_main.c
> @@ -74,6 +74,14 @@ static irqreturn_t octep_vdpa_intr_handler(int irq, void *data)
>  		}
>  	}
>  
> +	/* Check for config interrupt. Config uses the first interrupt */
> +	if (unlikely(ring_start == 0 && ioread8(oct_hw->isr))) {
> +		iowrite8(0, oct_hw->isr);
> +
> +		if (likely(oct_hw->config_cb.callback))

Adding unlikely() and likey() hurts readability.  It adds noise.  You should do
it if it makes a difference on a benchmark but that seems unlikely here.

regards,
dan carpenter

> +			oct_hw->config_cb.callback(oct_hw->config_cb.private);
> +	}
> +
>  	return IRQ_HANDLED;
>  }
>  
> -- 
> 2.25.1
> 
