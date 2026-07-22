Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B5426ECF;
	Wed, 22 Jul 2026 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756531; cv=none; b=o0JTbWTfb5z8VgIZWOeKZZuNZHpoAkz8b+27Gb3PIA5fVvzaQ5BsAf4IDBtZ7DJMaQR+rZ4z3ZRDfFAxOn9xCP71sIJoe7eaadqEi7QxClipo1nqXCR1R9mdhoZLHNKlvIMI1azR7/81i1Bf+c6UiRAouGs5Qx3OAA0Zv8ZRR8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756531; c=relaxed/simple;
	bh=xVqncMVdBXMw28pX73y6xIsrPGLKgJC40RvJvGxuJE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQpCphfuLL7K/HFkmQoih0fPXAvtn4942+e7mA9Kp7UVvxPK94AYpmEmc9NTiXS0EL7yvrHvWBkhNSEXroOwTcDH3uj1hR5+Rqz916qPtLxhNL+52O5fRAnvhzB+/nVDE96LM3dV1z6hvmVhdqg06meeaQrKc6/kcY2UyC5uHko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aM5Ul6To; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aM5Ul6To"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61EFA1F000E9;
	Wed, 22 Jul 2026 21:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784756530;
	bh=li08vqzkfChXm7L2fLWJCauLBLfkW4tcSfSVjkWfxe0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aM5Ul6Toqu5GrPLH6J07mgg2tVd9KHjlwXKTnRhKVlD4QB2dh+CNKKJLbxSXpcCyE
	 bYy82BT5zJfP6HzLF0xbHDszDOARddtbmz6uMp6TKPwlvCFHCfnFdb8Vzk4yMOL/bs
	 wBwS8zJ2/6VKCXE+o6yG8dXS8wv6XdnXWR/9fTOAyLlq7/KJn/6VCMVwWCBr5rXRxO
	 hYx15xIHMcsciQYfYxUK98WCYGad90rnr+FBYVbfMtlaAS+sMeAMDUnG1/J4Gc0OXL
	 9Bf6KyrZ/bC/76JDbcaLWKm9gpCnIBffYo3EtzQ9TetrGFy6CBccn1Qqufa1D5Fpya
	 7iF/+rwuj+gog==
Date: Wed, 22 Jul 2026 22:42:05 +0100
From: Will Deacon <will@kernel.org>
To: weimin xiong <15927021679@163.com>
Cc: Jean-Philippe Brucker <jpb@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH v1 1/2] iommu/virtio: Set driver data before enabling
 virtqueues
Message-ID: <amE5Ld70N9tsf_dL@willie-the-truck>
References: <20260714025914.193580-1-15927021679@163.com>
 <20260714025914.193580-2-15927021679@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714025914.193580-2-15927021679@163.com>

On Tue, Jul 14, 2026 at 10:59:13AM +0800, weimin xiong wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> The event virtqueue callback retrieves the driver state through
> vq->vdev->priv. viommu_probe() currently initializes that pointer only
> after virtio_device_ready() and after the event queue is populated.
> 
> Store the driver data before creating the virtqueues so callbacks always
> see initialized driver state once the device is made ready. Clear the
> pointer again on probe failure.
> 
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  drivers/iommu/virtio-iommu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 9118377d7..4c91a82d2 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1173,11 +1173,12 @@ static int viommu_probe(struct virtio_device *vdev)
>  	ida_init(&viommu->domain_ids);
>  	viommu->dev = dev;
>  	viommu->vdev = vdev;
> +	vdev->priv = viommu;
>  	INIT_LIST_HEAD(&viommu->requests);
>  
>  	ret = viommu_init_vqs(viommu);
>  	if (ret)
> -		return ret;
> +		goto err_clear_priv;

I guess it would make sense to pass the 'vdev' instead of the 'viommu'
pointer to viommu_init_vqs(), now that you have linked them together.

Will
