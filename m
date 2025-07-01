Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2D1C84B3
	for <virtualization@lists.linux.dev>; Tue,  1 Jul 2025 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356213; cv=none; b=Q7ep3csWDc8U5RP+lwhJeqqejgufFYhsODK8qWPe0hwXRVkdgCNATwoiRFyqu06pyD6BFcodZdij+58V3djf8ubKQN0OSZdTDtdg3nVdHLDaEkOSM9YkGikjCGv2OLraTPyG1YkttMDixK5aeeqHq6ORQWrLdWZNXNBP+H8pgas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356213; c=relaxed/simple;
	bh=40HJ61IlZ4oeOAOWTEBZB/uoEVqaZ3mQ7wDobABmmsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UmPg5dpTJn776iTx0IETrY0mnxAhe7nXOck07xWcuyqW1Go5EAJAwnYVmtXDVHGpOdHLZ4rlvf3g29x8X670pz6flaL9TSkoRbyqO/2MkbiyecdmlT+SBJNhQ8drSIT8MbECDOJBAW+A6FIAy9KVxu8+Cxuv65sHnGtRk8slkxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gayH5c5m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gayH5c5m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751356209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UrfeDL2USMWBF7Hfk0LG3gqMbltvMY7Jsuk0qzV7YpU=;
	b=gayH5c5m3pRGzO/NL15TU/CwRxM8TA/nfBvhl4SZtPVUx01iOc+uEk18NbqS7JJqE2AOYI
	tnppJtgW3RMtNyvfkn1ctzXksom4MyVNPUqZr/tUnY11nWqPClNpaSrlisfwlay4aQ3PfB
	m6uTVSBwPMyda4uArDlzCKBc3aF2dlc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-LM-ui2z7Mz6jhNC8PcG8IQ-1; Tue, 01 Jul 2025 03:50:08 -0400
X-MC-Unique: LM-ui2z7Mz6jhNC8PcG8IQ-1
X-Mimecast-MFC-AGG-ID: LM-ui2z7Mz6jhNC8PcG8IQ_1751356207
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-452ff9e054eso25198475e9.2
        for <virtualization@lists.linux.dev>; Tue, 01 Jul 2025 00:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751356206; x=1751961006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrfeDL2USMWBF7Hfk0LG3gqMbltvMY7Jsuk0qzV7YpU=;
        b=abCSB4H21VE642MZ+xPyBp6ambPfMOIqGu0CJiYcUc7tEk5YpmouZx7bBiEyIFJnui
         BhNlyk88ygBo9uivtRLCDWubMRtueKVGADbWKb+Tki+PAiTJTb1Gr0Z9GXOOmZLcXwFe
         g6ez9RBi2boIGkHwHtkdt1WPF5HXTfGCgFmp6fp5vvLUY+Vy2SKnhzvvKhzLB444XprU
         0opQyZobHSZsK5Z6EoSaouSz16NmXKniMCbnrj0zZKKAZhNgw3EfquuJtqoZxF1/wExw
         7W1RTn34hKQtHJtiGC/VM0ab01rTamLm4AEcoAGDkQaF+GBsyzyeWWMu8+PcwK0huyB3
         8Hrw==
X-Forwarded-Encrypted: i=1; AJvYcCUbt582r9mjLZWKUT3CXyIy4PqR7Kcr7Un7t/MplJ1ZK8mzQmOckGVUG6GFWAUC5GVd1xzvxEPgVIkO939UPg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvVmbSiaVv4RKpYP0CXYBNSUkim9TlSlW3Czie/0rXYFeJQL+r
	Y59u58aVxxMJlp20JvO3f5gy1KmosGtcN4ZNhOGwMFOaQzQBafi+v5Q01VvU4ZN1aIatMUsOfmj
	/uNJkxNZCFz9/YF9xNSpvIcrt9mM2xGGEHAUlW8xyfmFlyBopzfU/z0fFeXQSx4NmsYOG
X-Gm-Gg: ASbGncu2Kmex+GN4vULzaKEbVXOAMDtXGXVvTfcX210SOt12t/fZB3apGnVwnynT69d
	zf3bCJXIS5wUhID4LcaoOgUOP+8NDqqgxMXfO68UoYGNQuXsX9eYW9KfRKk8cZNv0xSFtHSkKdq
	cNEedb3tP/SnPFzD0QBgoDc0dbaxPLE6WaMHbICuJ26DXpmi6wlezvFjSc4CxuROlSx/XPlBP7L
	/etEgudB1JExElnCWRyUjJYHfCZBKGN+K1G9hn6RyYnq3LKxAIOwqT/QTxbWv38Y38sqEvaQOh0
	wrYhYtp6V8P8leri
X-Received: by 2002:a05:600c:1e0d:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-4538edeb1e3mr186231955e9.0.1751356205987;
        Tue, 01 Jul 2025 00:50:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNEap5hfehObObyasCyQhPEbo2n4At1g+WsLQ4hkN8qo9UeYJIf1N5Pojy/Kj0YHenVGSRhg==
X-Received: by 2002:a05:600c:1e0d:b0:43c:e478:889 with SMTP id 5b1f17b1804b1-4538edeb1e3mr186231595e9.0.1751356205538;
        Tue, 01 Jul 2025 00:50:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152e:1400:856d:9957:3ec3:1ddc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234be76sm187329465e9.15.2025.07.01.00.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 00:50:05 -0700 (PDT)
Date: Tue, 1 Jul 2025 03:50:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	hch@infradead.org, xieyongji@bytedance.com
Subject: Re: [PATCH 9/9] vduse: switch to use virtio map API instead of DMA
 API
Message-ID: <20250701034754-mutt-send-email-mst@kernel.org>
References: <20250701011401.74851-1-jasowang@redhat.com>
 <20250701011401.74851-10-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250701011401.74851-10-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IKxU75Ivu2nPCda3vndsBwWLF8kjcL01ageRvSN7Fa0_1751356207
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2025 at 09:14:01AM +0800, Jason Wang wrote:
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
> Signed-off-by: Jason Wang <jasowang@redhat.com>

so what exactly is the issue fixed by all this pile of code?
I just don't really see it. yes the existing thing is a hack
but at least it is isolated within vduse which let's be
frank is not it's only issue.


> ---
>  drivers/vdpa/vdpa_user/iova_domain.c |  2 +-
>  drivers/vdpa/vdpa_user/iova_domain.h |  2 +-
>  drivers/vdpa/vdpa_user/vduse_dev.c   | 31 ++++++++++++++++------------
>  3 files changed, 20 insertions(+), 15 deletions(-)
> 
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
> index 64bc39722007..f86d7111e103 100644
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
> 2.34.1

