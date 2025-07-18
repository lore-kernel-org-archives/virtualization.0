Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A601E98E3
	for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752831677; cv=none; b=c15M7IhjnQD5bx7B0ONyQPNUNCp3C2iVkTclphOeRAFSRr6EYUSkboZwpK5RU7dnVzG2cjhBOxVyHLB/+ijGb47lThXmYgndcFejivCGf2RbDRXlSgJu4pVfsQKHSvs8h4Xka5y/AiZVIYkJueqcY765Lmgxd0dF/pXFNdgKixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752831677; c=relaxed/simple;
	bh=sbKeCSt0RtHYhGLjFWwp4ZxDPyEVwe1NRU21kLtUqog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=cvpx4xe3ZfgrbW4QxsprDIiXTbH1K7ibdkeYRf6JWzsgtH1CICdW3UQvhCtgjehNnMI8zBtozyUJ8zTp9aZMcQMdWcqV9OwZJN9v6wisyHBHYxPWGX1KeUozN27cUEiQ9KaYFcPMom6PB5Y792Opd2QXxPoxMo1M/btY2y/WdBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=caUcxdNt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caUcxdNt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752831674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2k8P4SsAE2taUCCItdd8XVG4WJdoRX6JSakoyi78eDA=;
	b=caUcxdNtPrxWUhY17OIfI34FnJEUDC9Zi1xQIQLR/v/ZUmYEVNO9q4H6/ywS5zgBiZwYRK
	ULzdlRe0ddMcZnQFddctPhuflFI5iUfL2HweZNlTXNkyyKsvS9BDFZnBumf7+SOCaNypNg
	ujncbNy+F/LnRPRC4rXoL8lsZSVbgsg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-D5i9H5ybME6Gnfwj-3fYaQ-1; Fri, 18 Jul 2025 05:41:13 -0400
X-MC-Unique: D5i9H5ybME6Gnfwj-3fYaQ-1
X-Mimecast-MFC-AGG-ID: D5i9H5ybME6Gnfwj-3fYaQ_1752831672
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-456267c79deso6134855e9.1
        for <virtualization@lists.linux.dev>; Fri, 18 Jul 2025 02:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752831671; x=1753436471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2k8P4SsAE2taUCCItdd8XVG4WJdoRX6JSakoyi78eDA=;
        b=hjguL16vT5AGufoxX1RRph2eZpNeKY/KGAlElxZbp/STWkZCjrToFLDGU775btktWh
         6dkmpgXGLIBHVwLLZkFfnYXVXCG5XHaJuoToP+DMQrgU7i4qHUIjcLVQ6AjDIJo+OYON
         +WXKPdopiCHj6gdNrVfKWxjZOUSg98ydAwF2B+38zmikM7/jP6sJ1OdUrYsTVpebI/Jq
         r8xCvHyjP51qJ4QBCt3aPX2KPNh8LxA+XumvK9injqy5WHZO8EdEZ3b5ouXSpqmzFC6U
         3PBwPk6ONYzzGPU2GPwXEGnlj6tG/YgPp9Zo+kwxkl1ERgZcuKvekfG8NxqmFg/oreiJ
         R60Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFE5xCg9U4GRDp9VzPJYpTTmOiEGiMWNHlGz+11a9QLDt8+352ZVOhRaDQXXGRv5M2xFGeuO+/q32wqU5lnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyViBjI9w/46SvvI+NSSz0jKEVhDuZQgwUZkHSF+1sqZuX7xpwK
	RslrZ0ewj6qHwXku+vREQuBV73UWUaGZi5ujhuwnAGkn6Ym944+PXQSdkJPdgFU7ZBlZoJ2r+DF
	moQOdOHu4mkXuKuAr8Om+svXIYKZB6FiptdxW9u8LwqXX+bXVJNRqSstDeWaOIBFBExZB
X-Gm-Gg: ASbGncsikxIBbqc63PDC5UMox0e3Cm1mRAcviCwrc+MXXbZoZOxZcoXWo6IMUMwBWNG
	qXMnxUqxZYcOajRT2WlTBngcv5H+pu+K4bNtAofutipGqcRjbF/ayvLDqGpJYBrEMbjudVfx6fi
	KZHs4oLHsq8Sc6PhyLGNzUWXX8oN3CKVhhIdJeGTLTlXc1qAZfppkB434UinEoru41bk9DZSPvN
	lVfPzpAUXhyoEsdy8RSPGGnWcBkwFH6ulnuZcoUwCOk8xDby1RcJI9ulXTYB9ljkXkKhKqkUncO
	GhaOMnA4TKr28RmF6EPoZNPFSXURpZA7
X-Received: by 2002:a05:600c:3e0e:b0:456:2ce8:b341 with SMTP id 5b1f17b1804b1-4562f88ae8fmr100832205e9.17.1752831671340;
        Fri, 18 Jul 2025 02:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa7BkpKtXuJaDGQzRXWWSPssfvtU6D+PwIGvHKYvelfUWXo4KopCbM0bXTNLbTS2IYUqf7ew==
X-Received: by 2002:a05:600c:3e0e:b0:456:2ce8:b341 with SMTP id 5b1f17b1804b1-4562f88ae8fmr100831945e9.17.1752831670805;
        Fri, 18 Jul 2025 02:41:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e886113sm74786085e9.23.2025.07.18.02.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 02:41:10 -0700 (PDT)
Date: Fri, 18 Jul 2025 05:41:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, hch@infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V4 9/9] vduse: switch to use virtio map API instead of
 DMA API
Message-ID: <20250718053951-mutt-send-email-mst@kernel.org>
References: <20250718091616.6140-1-jasowang@redhat.com>
 <20250718091616.6140-10-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250718091616.6140-10-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7_bJCuWbkqXDwBO8uYWljYeZIghRbwlG01qqC15d_dM_1752831672
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 18, 2025 at 05:16:16PM +0800, Jason Wang wrote:
> Lacking the support of device specific mapping supported in virtio,
> VDUSE must trick the DMA API in order to make virtio-vdpa transport
> work. This is done by advertising vDPA device as dma device with a
> VDUSE specific dma_ops even if it doesn't do DMA at all.
> 
> This will be fixed by this patch. Thanks to the new mapping operations
> support by virtio and vDPA. VDUSE can simply switch to advertise its
> specific mappings operations to virtio via virtio-vdpa then DMA API is
> not needed for VDUSE any more.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

So with all this, how do we know we did not forget any
users of dma api?


> ---
>  drivers/vdpa/Kconfig                 |  8 +------
>  drivers/vdpa/vdpa_user/iova_domain.c |  2 +-
>  drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 31 ++++++++++++++++------------
>  4 files changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 559fb9d3271f..857cf288c876 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -34,13 +34,7 @@ config VDPA_SIM_BLOCK
>  
>  config VDPA_USER
>  	tristate "VDUSE (vDPA Device in Userspace) support"
> -	depends on EVENTFD && MMU && HAS_DMA
> -	#
> -	# This driver incorrectly tries to override the dma_ops.  It should
> -	# never have done that, but for now keep it working on architectures
> -	# that use dma ops
> -	#
> -	depends on ARCH_HAS_DMA_OPS
> +	depends on EVENTFD && MMU
>  	select VHOST_IOTLB
>  	select IOMMU_IOVA
>  	help
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.c b/drivers/vdpa/vdpa_user/iova_domain.c
> index 019f3305c0ac..8ea311692545 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.c
> +++ b/drivers/vdpa/vdpa_user/iova_domain.c
> @@ -447,7 +447,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
>  
>  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
>  				  size_t size, dma_addr_t *dma_addr,
> -				  gfp_t flag, unsigned long attrs)
> +				  gfp_t flag)
>  {
>  	struct iova_domain *iovad = &domain->consistent_iovad;
>  	unsigned long limit = domain->iova_limit;
> diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
> index 846572b95c23..a2316571671f 100644
> --- a/drivers/vdpa/vdpa_user/iova_domain.h
> +++ b/drivers/vdpa/vdpa_user/iova_domain.h
> @@ -64,7 +64,7 @@ void vduse_domain_unmap_page(struct vduse_iova_domain *domain,
>  
>  void *vduse_domain_alloc_coherent(struct vduse_iova_domain *domain,
>  				  size_t size, dma_addr_t *dma_addr,
> -				  gfp_t flag, unsigned long attrs);
> +				  gfp_t flag);
>  
>  void vduse_domain_free_coherent(struct vduse_iova_domain *domain, size_t size,
>  				void *vaddr, dma_addr_t dma_addr,
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index 934c50d15b28..d858c4389cc1 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -814,51 +814,55 @@ static const struct vdpa_config_ops vduse_vdpa_config_ops = {
>  	.free			= vduse_vdpa_free,
>  };
>  
> -static void vduse_dev_sync_single_for_device(struct device *dev,
> +static void vduse_dev_sync_single_for_device(void *token,
>  					     dma_addr_t dma_addr, size_t size,
>  					     enum dma_data_direction dir)
>  {
> +	struct device *dev = token;
>  	struct vduse_dev *vdev = dev_to_vduse(dev);
>  	struct vduse_iova_domain *domain = vdev->domain;
>  
>  	vduse_domain_sync_single_for_device(domain, dma_addr, size, dir);
>  }
>  
> -static void vduse_dev_sync_single_for_cpu(struct device *dev,
> +static void vduse_dev_sync_single_for_cpu(void *token,
>  					     dma_addr_t dma_addr, size_t size,
>  					     enum dma_data_direction dir)
>  {
> +	struct device *dev = token;
>  	struct vduse_dev *vdev = dev_to_vduse(dev);
>  	struct vduse_iova_domain *domain = vdev->domain;
>  
>  	vduse_domain_sync_single_for_cpu(domain, dma_addr, size, dir);
>  }
>  
> -static dma_addr_t vduse_dev_map_page(struct device *dev, struct page *page,
> +static dma_addr_t vduse_dev_map_page(void *token, struct page *page,
>  				     unsigned long offset, size_t size,
>  				     enum dma_data_direction dir,
>  				     unsigned long attrs)
>  {
> +	struct device *dev = token;
>  	struct vduse_dev *vdev = dev_to_vduse(dev);
>  	struct vduse_iova_domain *domain = vdev->domain;
>  
>  	return vduse_domain_map_page(domain, page, offset, size, dir, attrs);
>  }
>  
> -static void vduse_dev_unmap_page(struct device *dev, dma_addr_t dma_addr,
> +static void vduse_dev_unmap_page(void *token, dma_addr_t dma_addr,
>  				size_t size, enum dma_data_direction dir,
>  				unsigned long attrs)
>  {
> +	struct device *dev = token;
>  	struct vduse_dev *vdev = dev_to_vduse(dev);
>  	struct vduse_iova_domain *domain = vdev->domain;
>  
>  	return vduse_domain_unmap_page(domain, dma_addr, size, dir, attrs);
>  }
>  
> -static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
> -					dma_addr_t *dma_addr, gfp_t flag,
> -					unsigned long attrs)
> +static void *vduse_dev_alloc_coherent(void *token, size_t size,
> +				      dma_addr_t *dma_addr, gfp_t flag)
>  {
> +	struct device *dev = token;
>  	struct vduse_dev *vdev = dev_to_vduse(dev);
>  	struct vduse_iova_domain *domain = vdev->domain;
>  	unsigned long iova;
> @@ -866,7 +870,7 @@ static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
>  
>  	*dma_addr = DMA_MAPPING_ERROR;
>  	addr = vduse_domain_alloc_coherent(domain, size,
> -				(dma_addr_t *)&iova, flag, attrs);
> +					   (dma_addr_t *)&iova, flag);
>  	if (!addr)
>  		return NULL;
>  
> @@ -875,25 +879,27 @@ static void *vduse_dev_alloc_coherent(struct device *dev, size_t size,
>  	return addr;
>  }
>  
> -static void vduse_dev_free_coherent(struct device *dev, size_t size,
> +static void vduse_dev_free_coherent(void *token, size_t size,
>  					void *vaddr, dma_addr_t dma_addr,
>  					unsigned long attrs)
>  {
> +	struct device *dev = token;
>  	struct vduse_dev *vdev = dev_to_vduse(dev);
>  	struct vduse_iova_domain *domain = vdev->domain;
>  
>  	vduse_domain_free_coherent(domain, size, vaddr, dma_addr, attrs);
>  }
>  
> -static size_t vduse_dev_max_mapping_size(struct device *dev)
> +static size_t vduse_dev_max_mapping_size(void *token)
>  {
> +	struct device *dev = token;
>  	struct vduse_dev *vdev = dev_to_vduse(dev);
>  	struct vduse_iova_domain *domain = vdev->domain;
>  
>  	return domain->bounce_size;
>  }
>  
> -static const struct dma_map_ops vduse_dev_dma_ops = {
> +static const struct virtio_map_ops vduse_map_ops = {
>  	.sync_single_for_device = vduse_dev_sync_single_for_device,
>  	.sync_single_for_cpu = vduse_dev_sync_single_for_cpu,
>  	.map_page = vduse_dev_map_page,
> @@ -2009,7 +2015,7 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  		return -EEXIST;
>  
>  	vdev = vdpa_alloc_device(struct vduse_vdpa, vdpa, dev->dev,
> -				 &vduse_vdpa_config_ops, NULL,
> +				 &vduse_vdpa_config_ops, &vduse_map_ops,
>  				 1, 1, name, true);
>  	if (IS_ERR(vdev))
>  		return PTR_ERR(vdev);
> @@ -2022,7 +2028,6 @@ static int vduse_dev_init_vdpa(struct vduse_dev *dev, const char *name)
>  		put_device(&vdev->vdpa.dev);
>  		return ret;
>  	}
> -	set_dma_ops(&vdev->vdpa.dev, &vduse_dev_dma_ops);
>  	vdev->vdpa.map_token = &vdev->vdpa.dev;
>  	vdev->vdpa.mdev = &vduse_mgmt->mgmt_dev;
>  
> -- 
> 2.47.3

