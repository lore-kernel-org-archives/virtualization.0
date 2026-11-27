Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817824;
	b=3To/WewxyF2J6UmfFmaD5YrpatPKP0VfBsSkgdVgIS7KXqP2uLABxIIAg30W9M+rff/G
	 xAtCW81JpFpdBtVpWyXTBGW7Zj+JG3rzNoh8GJFzEV0kDHN0ZUSjTyObcOj/JUOi/2GfW
	 WQRi6iNbkl7OzkdAP1MBUkkHWfq2LWYK6/6NSWF+kJzgr7iYDNIt7RVcueq/gMhIHVRGS
	 vmxY3/ODQ7PCFLoidtmdnhHlaIzfUxUdZEsgmfkMOHHQsTVOHfvTHaYJu0085a9wXx+eg
	 mz9I5KHATViWKi22cxk46g1zFf8ht60AHAy36RXswUCw/SL1hRX7SwIsJP8L7qcz0tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817824;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3bjnl3x1uRBJpCoTy6jJV187S3SL1Isxb5UBvBIQ2N0=;
	b=0L8LJ/iGAnvqosyXV3L+Us56sK/f4evxq7gJ12q4geHtpUm2F8SWY3cR77sYhb70NOPS
	 Bnp2MDNTMjiOwfOEw6/f9kwI8uWLzrVTmsTpvAFiz770bVPjdC8BRCtRfpELXnOV9Gn3I
	 1esT5PqPZdA0AN5W/9MVuzUPMF6dQa1/0Xj+qH+wOVZogWO6yYOBlZ0hyw6t2nNK7c9wp
	 i5QG1yx3M0cRIfg/dqdSwOjD+sp67sFudooz+rR2CsqJe6/8zE6SHTTO4ZK6CNP8ZOxUz
	 6cAa+khlvVuLAQzF/zfXyeRVTiZKihkOANSWrwU5EiA8WBK0VIjTfgeKd824/OAnftg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8YqIaa2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48306606A31C;
	Fri, 27 Nov 2026 22:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8YqIaa2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC811F00898;
	Fri, 27 Nov 2026 22:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795817823;
	bh=3bjnl3x1uRBJpCoTy6jJV187S3SL1Isxb5UBvBIQ2N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P8YqIaa2RBHZML1s0S1G51PbgmVxbhoDyDpkAKV70uwOWagJnFFB6HU6q1/UH8dBg
	 RdaxW60DcdONludbExlgsffvuze6jrGemLoAu+j4PvqrTe1YJ4qA3OIrp+MCM5fivQ
	 Py7XQm/Y/JgIoUcKvurQxDO8X3QKgY118UBNvC0HRIRX69gcP7VE8WDR68rNwSY+dz
	 MOOsQ0/HR56/ZpsnElcTcoOXcNiXHRjRD9Fo4zBgb9ofzu2S+gS2ag/FHwj1vZG3FH
	 qgfGO0hdHWMxWZWhQniTZ06Yb7BV+GBJUPXPv5StwQfZGwH3QTwuQi0IpIgzum5Fuo
	 K61apGAhB0ZLQ==
Date: Fri, 27 Nov 2026 22:17:37 +0000
From: Jean-Philippe Brucker <jpb@kernel.org>
To: Cam Miller <cam@linux.ibm.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, schnelle@linux.ibm.com,
	mjrosato@linux.ibm.com
Subject: Re: [RFC linux v1 3/3] iommu/virtio: Add device links for endpoints
Message-ID: <20261127221737.GA1603267@myrica>
References: <20261124155410.768743-1-cam@linux.ibm.com>
 <20261124155410.768743-4-cam@linux.ibm.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124155410.768743-4-cam@linux.ibm.com>

On Tue, Nov 24, 2026 at 10:54:10AM -0500, Cam Miller wrote:
> Make each endpoint a consumer of the virtio-iommu device, so that the
> driver core unbinds each endpoint driver before viommu_remove() runs.
> 
> Before this change, removing a virtio-iommu (for example via "echo 1 >
> /sys/bus/pci/devices/<dev>/remove") tears down the IOMMU groups of all
> its endpoints while their drivers are still bound. The endpoints keep
> stale IOVAs and their later dma_free_contiguous() leads to WARNs in
> __iommu_group_free_device(), endpoint IO hanging, and crash at shutdown.
> 
> Make each endpoint a consumer of the viommu with device_link_add(), as
> arm-smmu and other IOMMU drivers do. The driver core then unbinds the
> endpoint drivers before viommu_remove() runs, so that their DMA teardown
> will still see an intact domain.
> 
> Fixes: edcd69ab9a32 ("iommu: Add virtio-iommu driver")
> Suggested-by: Jean-Philippe Brucker <jpb@kernel.org>
> Signed-off-by: Cam Miller <cam@linux.ibm.com>
> ---
>  drivers/iommu/virtio-iommu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index dd10c3e98a3d..a84a653f269e 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1044,6 +1044,9 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
>  			goto err_free_dev;
>  	}
>  
> +	if (!device_link_add(dev, viommu->dev, DL_FLAG_AUTOREMOVE_SUPPLIER))
> +		dev_dbg(dev, "could not add device link\n");

Could you return -ENODEV? The rest looks good

Thanks,
Jean
