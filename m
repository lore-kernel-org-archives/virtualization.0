Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E204D17A1
	for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790005680; cv=none; b=YYIORm7rzPwaAlGgz0QyzDlDpbPX+iOkXlW49gBDvX7jOHRjyOwK3VodNrt1lIvXJtU6MhAhQk/ESHlUi/LFs0XnUzt9Bb1zrpsiLXMpwQra4rKhD+PlDIcktiInPlYMBA4zPMoRTGLiZxkXNOLI3ezh9c5WkunId0j3ZSm+0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790005680; c=relaxed/simple;
	bh=xGLfA1m+bcd6cQO4yshQSi+ud4HVrdOAi+ou2Af706o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQInab3wd9cxtrML7YiEHFePW+8e8Cj8qk0FldJDAnxsi4L+JrvuKgqPtcoSVVMDAuRIJoIGj844IdjGmh0lE5clUFnCYRviEIpPCcevPVzxuDI0qUxCMEaJcodk2hdJMoZIurF8itFbk7/80kBrye4WODyVV/fcp07JA5W/jFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IdgbYm0D; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IdgbYm0D"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso2676181a91.1
        for <virtualization@lists.linux.dev>; Mon, 21 Sep 2026 08:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790005678; x=1790610478; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NymQllFGW/d7T1ecbWk0XQBpiDM3En0PKGwwReZs9hI=;
        b=IdgbYm0DUM2tBR7WhX9ieXDvGpS8Hx18CY7oMfYWl5uFYyEp2rH/IhW2qMhXuJvhB+
         4G8ZRUjlYziuRMcdkne7Gg6mTf8U5NcKXRKbDNyiBW7bbSIgzWVn1OL5vr3Ih+HqwZO+
         0fLQ+ZkI9wH5hFMe6kZb1uo2E8dliaE0+CW7IlUjdTuLWJDMvG2V/IRAAXkZ3RxZy5xk
         GKCEUA2jeM0Z5+70PiuiggD5b4LM2JSouZrzHvZRWiG+YjaIfsukQAvP1JFdz6oD4O95
         +MspiJS5Mr/pQ37WG5UQ6U2DTj0opbYW/yrWal3iFaz5p+CZ/8zu4GqNG0mIgtNIsWIt
         ZWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790005678; x=1790610478;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NymQllFGW/d7T1ecbWk0XQBpiDM3En0PKGwwReZs9hI=;
        b=yv2WmUQHfmpqsDmSBPCEDi21e02kQi//3mlC4dtuopTqn2F4QDfvFuMNPhNzAILDcn
         7GpzZYXI0MPDt8ec0rvHUQkZN5tL44sIKV+h+6ddvjQiTHDQKF/33acrwT13kKwfF9m1
         EmM0Z+uGiBWNbguukahUqm0wJ4W/0lOdegZFu8MT+4DyeDBNuVV1Brgk7sX9VZnBfTBI
         g6Z9UQl5/GlnNGD19G2bv6rzgqDbid2EUzzg3AsUZwh+ykqQS71tSuQMQUxPiVuymtkk
         EOE/zaoae4hP2zk+ghRm2Rdd5ofYRN6Vpt/94CobIMtkxYYIcup6C47i0SpMZBpSSsH7
         YNEw==
X-Forwarded-Encrypted: i=1; AKwUvBwp5Q2WVNeA+wZwtq6xfLnbBFZ91sDS4X90FUt9y2ukf/yhJFKOAe82y5I1b6Kll7hf9Lk+hgeA6bsnaFQg3A==@lists.linux.dev
X-Gm-Message-State: AFuF++kbPt7jk4F8gdBncz9ej4by8CfSGxtnCCf/Pio7XiMF1dwFxGYv
	U+eDO9wjMUWSiEY05RnaQ/d668MDgG2M4jo7eaZ7IOPsiadh+H47syQJIxNfXLIEW58=
X-Gm-Gg: AYBFou0q+wGxP2RRLp4aDVdszQomAZVNT5lcB4KitT6lHAnPpl0FkNDpxUfF3Phq/Tj
	bYjukClPnZuSElKoTwHcrm61oxKrwRRvIz40IHqFMEhGRac4ftrclW6mUasAiAbDFCmCus0u3OJ
	MPrB7kAFyL9iZLQ9PJOqWq3Nbe0KfyQVyieLwuLcJXgoK3CwIu/Jx/BGxFPHSJTIAZhhzz1p0oI
	zhHAzroNx2lyjDPOjgCiKW+0OweU6y4ioD8ewrmPeAmvYenJ0F81YqiXRbbDZTeq+ZsLUi2k4F2
	9Pd7kEPoIZFVuDzg8KCFjc+M2fnJOP6vqWgdfwzeKYiwSGhsX1aca7/b1d7IqRa7F+A6EekdrUq
	iPtuUmR68oEd+1RjSNlk3pZbNc8wokekYNkWCmBlb2Q9mp/wss9NltXs9aKYZyawhDKY6VJ7SYB
	+VCOjbfWj/2PLBXkhSgjfVO/eoeABdoQR7fFhoDiVtGJyVovq2GGrxdndNHanc/xMomNhDqpJwe
	A==
X-Received: by 2002:a17:90b:2750:b0:39e:6c69:776f with SMTP id 98e67ed59e1d1-39e6c697934mr11058030a91.24.1790005677565;
        Mon, 21 Sep 2026 08:47:57 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:a714:d1ef:56ba:be47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55c9cabdsm7471419a91.0.2026.09.21.08.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:47:57 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:47:54 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Francesco Valla <francesco@valla.it>
Cc: Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	Peng Fan <peng.fan@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	imx@lists.linux.dev, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 05/12] remoteproc: always report VIRTIO_F_VERSION_1
 feature
Message-ID: <arFRqopkkJf7Nlq4@p14s>
References: <20260916-remoteproc_virtio_map-v1-0-dac8c5eb4aa9@valla.it>
 <20260916-remoteproc_virtio_map-v1-5-dac8c5eb4aa9@valla.it>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-remoteproc_virtio_map-v1-5-dac8c5eb4aa9@valla.it>

On Wed, Sep 16, 2026 at 11:10:50PM +0200, Francesco Valla wrote:
> There is currently no way to report the VIRTIO_F_VERSION_1 using the
> resource table alone, as the per-vdev feature array is limited to 32
> bits.
> 
> Considering that the VirtIO 1.0 specification is now ~10 years old,
> always report the VIRTIO_F_VERSION_1 feature, as some drivers depend on
> it.
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>  drivers/remoteproc/remoteproc_virtio.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index 74e0da970f1d..cfd66d9d1c9e 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -249,7 +249,7 @@ static u64 rproc_virtio_get_features(struct virtio_device *vdev)
>  
>  	rsc = (void *)rvdev->rproc->table_ptr + rvdev->rsc_offset;
>  
> -	return rsc->dfeatures;
> +	return rsc->dfeatures | (1ULL << VIRTIO_F_VERSION_1);

I understand this.

>  }
>  
>  static void rproc_transport_features(struct virtio_device *vdev)
> @@ -275,14 +275,16 @@ static int rproc_virtio_finalize_features(struct virtio_device *vdev)
>  	/* Give virtio_rproc a chance to accept features. */
>  	rproc_transport_features(vdev);
>  
> -	/* Make sure we don't have any features > 32 bits! */
> -	BUG_ON((u32)vdev->features != vdev->features);
> +	/* Make sure we don't have any features > 32 bits except VIRTIO_F_VERSION_1 */
> +	if (WARN_ON_ONCE((u32)vdev->features !=
> +			 (vdev->features & ~(1ULL << VIRTIO_F_VERSION_1))))
> +		return -1;

And this.

>  
>  	/*
>  	 * Remember the finalized features of our vdev, and provide it
>  	 * to the remote processor once it is powered on.
>  	 */
> -	rsc->gfeatures = vdev->features;
> +	rsc->gfeatures = vdev->features & ~(1ULL << VIRTIO_F_VERSION_1);
>  

But I'm having trouble with this one.  

First bit 32 of vdev->features gets cleared and then bit 0 to 31 are assigned to
rsc->gfeatures.  Why bother with clearing bit 32?

>  	return 0;
>  }
> 
> -- 
> 2.55.0
> 
