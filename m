Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A6142BC5C;
	Wed, 15 Jul 2026 11:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784116023; cv=none; b=FJAj4W7EPOhtj8R6KtsjbFcfgjqIn6MylmiBFRJPnxyOOQYDvxnrY7da7qHeFn5niiASKNtmWBD0dQ8VsgEp20vVh0zWMwG2MvQ0/UaYIbHJMN6nHVbFJrAeiFw5dGm2evvm2yXkXPaM4B2bJXVKVvFsEtm0OD/CjAbyCnwIi5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784116023; c=relaxed/simple;
	bh=BLPCSunTJ3zr5SckKnaywr/bmK8bofE2jjvwIYixo1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPzNAAAKHXFOpmSDgi1/o/Iup29dd+9C6g7yz/K7iqfNnJwy3I3wNo2yHy41K5SAG4TbJzFWtpWGC4wHE29Cxxn8xhGBGpTu6qJYPUz2mhvfCeFQrmyACc8whiHryJ/+rWtZ8AC25G3eb9ATK1XhPPn4SEBiAX3YtOFRX5v3MQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWpaJyMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWpaJyMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C811F000E9;
	Wed, 15 Jul 2026 11:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784116022;
	bh=dcTDkAgoDZGRPTbWG7kahUaFo/axPdkloq1LsXGiOLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mWpaJyMin/WRraQDG5Jvus4NlYkkc/G92t8muhf4iISYhg2bynLey/6w96Ey3amc+
	 J2XWP+MWl2PzN07UTXt7z+QGhweOxHGe9Z73csgyoPxUgOHUhgE3sHktWt3Z8I1heg
	 O4Lgq5S6ed34WEk9TZ1MGrI5fPJoInSoPIQ8AtQpMQM8ZjgfTypbEeS10kgGKvws1f
	 1cHqKvXSsgUqAAqgskAfoATwpe13KydR3CVvhTH56xl3sDeH+RhZui/J/yrNylkxDM
	 5dQLVy84m2zYgBeJQGH8YfHwFyeacrWgCM0jVOyF/4FTd5W7FgN/Nbo7jmvDJEVpkV
	 xq8dLIL1h0Gcw==
Date: Wed, 15 Jul 2026 12:46:57 +0100
From: Will Deacon <will@kernel.org>
To: weimin xiong <15927021679@163.com>
Cc: Jean-Philippe Brucker <jpb@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, virtualization@lists.linux.dev,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Xiong Weimin <xiongweimin@kylinos.cn>
Subject: Re: [PATCH v1 2/2] iommu/virtio: Handle iommu_device_register()
 failures
Message-ID: <aldzMU_wZOqo2ofl@willie-the-truck>
References: <20260714024949.190014-1-15927021679@163.com>
 <20260714024949.190014-3-15927021679@163.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714024949.190014-3-15927021679@163.com>

On Tue, Jul 14, 2026 at 10:49:49AM +0800, weimin xiong wrote:
> From: Xiong Weimin <xiongweimin@kylinos.cn>
> 
> iommu_device_register() returns an error when the IOMMU core fails to
> register the hardware instance or probe the buses. viommu_probe()
> currently ignores that error and continues as if the device was
> registered successfully.
> 
> Propagate the failure and unwind the sysfs entry and virtqueues that
> were set up earlier. Clear the driver data on the error path as well,
> since it is set before registration so bus probing can find the
> virtio-IOMMU instance.
> 
> Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
> ---
>  drivers/iommu/virtio-iommu.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 342785c76..9118377d7 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -1240,7 +1240,9 @@ static int viommu_probe(struct virtio_device *vdev)
>  
>  	vdev->priv = viommu;
>  
> -	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
> +	ret = iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
> +	if (ret)
> +		goto err_remove_sysfs;

Given that the first patch shouldn't be needed (per Robin's comments at
[1]) and this is augmented an error path that we shouldn't be hitting in
practice, I don't think we need to treat this as a fix. You can probably
just lump it in with your virtio-iommu hardening series.

Will
