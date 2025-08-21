Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B62222C7
	for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766824; cv=none; b=PFeuyh027GlgpoCZ/s9iD+GvYgWbmSbZkIhrOY14oXLYUtn7tIwE9/5PHayK03pIVhCBS1dciKVmqx52HaEDxW5MSKUINYPim1/DmoNkVbXEDA9L5qRHw45WsKCMQ6uIzP7XZE7Eljy1m4HXui06WYbMFZ1KHjcAn4lDc5wXa14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766824; c=relaxed/simple;
	bh=F1bQCaVkknpAXmD3Y2LWgtDLgRsVad+mR861NV5ZCaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBNgaISuAI6TXqwJYtn83RTX9LjAYjPpB1QRkUPR4OQ0fC/tOiaOaOTQYnRGs5XCInGpTICLBMJ79Nl6EL+fTRx1VA42QTuZIw26Sb/y/4SF5iIhfjZMa6HNdzRcNWgWrn0ltcTOuXGuaQnDmOJypI8PlhBLxUlZDMjdh66cAdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QgC8nfWu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QgC8nfWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755766821;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZryWVFyVtFZSWAWYLNDZgexNLIyxMGbOeXWK21db0Rc=;
	b=QgC8nfWuVswRFkPsdiva0CL94JyUSg+vXb/9GDSbHY+Ysd2y4jPhERaR6DwZfqE/tTtmds
	128TtuRaszC1L1vpF3wGA7WNl/YD6BbC9VjnsYBZa7323jxobMUmo+vVXSCJbrMFCWZLlI
	vMbzyrFM2+GrtCRDQZsJsJxd4eNRNYk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-sPpNv0JqN0GqWbZT2QBGcg-1; Thu, 21 Aug 2025 05:00:19 -0400
X-MC-Unique: sPpNv0JqN0GqWbZT2QBGcg-1
X-Mimecast-MFC-AGG-ID: sPpNv0JqN0GqWbZT2QBGcg_1755766817
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b9edf2d82dso380949f8f.2
        for <virtualization@lists.linux.dev>; Thu, 21 Aug 2025 02:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755766817; x=1756371617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZryWVFyVtFZSWAWYLNDZgexNLIyxMGbOeXWK21db0Rc=;
        b=wLiRzIeMMbQbkqwIHUyl7YLcArmb5KYdTdQ0g55laJQ/5WTwbR+o41D2N83BQaoCzS
         rRffvoEMjFANXoVNZj9eZMEHLO8yoZ4bZ4UA5H6yln6BTtwagkX+8QGOvcdEK5r4B5RQ
         dPUTC4nkq/ye2omnJvSq18amAUKqdvvhtFvM/yABiGwlcJH9VRL0GFy289zVjvoIIypY
         n/kdWEXkzsFAqn4mr4WODdQK7kgoBLZ8Ohj54DocmWNU811t+6jvlHTnKskdmrP/8I/z
         JXENm2Xgzn84rldnPEJ4DfatsqF6Ll7viAuuKg8F0vRb0X/2W6mMkifqrMEIa/vUYsK9
         CPRA==
X-Forwarded-Encrypted: i=1; AJvYcCWdXUbNvwVPQwV+ZjR7vEXr94V+1/RmYLKvyjPxup9fHb85xvBu2nDOWt05R+Qi/NNiaJEApJs++VcVZWM3Ug==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywk1dSeOq0L7Z+r/6PRnnIZIdaOd5tIvtVbKhY0CV04P4njuRID
	2xwFjAvPO90wU0c3jxpMYcQK2XcwaCw/EaptdNuTiLyeXAed5LoNrhLYQpuLrMwLZbc8R6wxb7P
	UlLFoeHLHEEabrX8CpMqZbCoTtNBnMlPFqWJuYuQSPJ4uT2TyH+gaR3t8VbyXWLIYej4pyoLcWc
	+QoDQ=
X-Gm-Gg: ASbGncufbY9PgSKGWhKI4axsjLdCvb2CK60EojBAoATaRw0Pjv+iUhxNCjWP2Gpcdxh
	8Nzw1DLcOcWsjvcYbqpH2uuKXgTozMBr6UuM2YtQkqHrSC0wzBco2STHeqA03Ek5mRKzi7X4hnj
	0eySqPV+IlEk5e8H30whcgeekQdbApSqHGgcpNEUBW5fbeRerxkvqZrUMxd2uMpDGHLC/K3TYPX
	riGEPn6Tpf270Glryhod/HdJEvVr4D3tyJGHTpUZzX5l/KVFc6gdNOr4W1Sl6o3xHOEhUYe4e9k
	rUj47A9XHAHknEYfyCilYzwz3a1FYEz6Z26TLvYkf30sYbYnjQLOwo62Qw7xxe/Y+7seDKhtz+Z
	CIooTvs5LWgU=
X-Received: by 2002:a5d:5887:0:b0:3b7:8a49:eee9 with SMTP id ffacd0b85a97d-3c494fc606bmr1222834f8f.8.1755766816954;
        Thu, 21 Aug 2025 02:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGt0CUA7tv7mcfd7oFDqpqP6OD/HbUnRgCATzsnpUqKXGdeLPxh20p229NNHjxNzZKD8sh7CA==
X-Received: by 2002:a5d:5887:0:b0:3b7:8a49:eee9 with SMTP id ffacd0b85a97d-3c494fc606bmr1222799f8f.8.1755766816404;
        Thu, 21 Aug 2025 02:00:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c5510a646asm90953f8f.15.2025.08.21.02.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 02:00:15 -0700 (PDT)
Message-ID: <d08e49ca-7089-433f-862a-8c3e9914af98@redhat.com>
Date: Thu, 21 Aug 2025 11:00:14 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v2] iommu/virtio: Make instance lookup robust
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 jean-philippe@linaro.org
Cc: iommu@lists.linux.dev, virtualization@lists.linux.dev,
 stable@vger.kernel.org
References: <308911aaa1f5be32a3a709996c7bd6cf71d30f33.1755190036.git.robin.murphy@arm.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <308911aaa1f5be32a3a709996c7bd6cf71d30f33.1755190036.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o9fzEKVBhTBRcUlvCg1uhVVXyg25MpHS1iExVmSNzxc_1755766817
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Robin, Joerg,

On 8/14/25 6:47 PM, Robin Murphy wrote:
> Much like arm-smmu in commit 7d835134d4e1 ("iommu/arm-smmu: Make
> instance lookup robust"), virtio-iommu appears to have the same issue
> where iommu_device_register() makes the IOMMU instance visible to other
> API callers (including itself) straight away, but internally the
> instance isn't ready to recognise itself for viommu_probe_device() to
> work correctly until after viommu_probe() has returned. This matters a
> lot more now that bus_iommu_probe() has the DT/VIOT knowledge to probe
> client devices the way that was always intended. Tweak the lookup and
> initialisation in much the same way as for arm-smmu, to ensure that what
> we register is functional and ready to go.
>
> Cc: stable@vger.kernel.org
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

could we get that fix merged as soon as possible? the virtio-iommu is
currently totally broken.

Thanks

Eric
> ---
>
> v2: Of course generic bus_find_device_by_fwnode() didn't work, since
>     it's dev->parent we need to check rather than dev itself, sigh...
> ---
>  drivers/iommu/virtio-iommu.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 532db1de201b..b39d6f134ab2 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -998,8 +998,7 @@ static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  	iommu_dma_get_resv_regions(dev, head);
>  }
>  
> -static const struct iommu_ops viommu_ops;
> -static struct virtio_driver virtio_iommu_drv;
> +static const struct bus_type *virtio_bus_type;
>  
>  static int viommu_match_node(struct device *dev, const void *data)
>  {
> @@ -1008,8 +1007,9 @@ static int viommu_match_node(struct device *dev, const void *data)
>  
>  static struct viommu_dev *viommu_get_by_fwnode(struct fwnode_handle *fwnode)
>  {
> -	struct device *dev = driver_find_device(&virtio_iommu_drv.driver, NULL,
> -						fwnode, viommu_match_node);
> +	struct device *dev = bus_find_device(virtio_bus_type, NULL, fwnode,
> +					     viommu_match_node);
> +
>  	put_device(dev);
>  
>  	return dev ? dev_to_virtio(dev)->priv : NULL;
> @@ -1160,6 +1160,9 @@ static int viommu_probe(struct virtio_device *vdev)
>  	if (!viommu)
>  		return -ENOMEM;
>  
> +	/* Borrow this for easy lookups later */
> +	virtio_bus_type = dev->bus;
> +
>  	spin_lock_init(&viommu->request_lock);
>  	ida_init(&viommu->domain_ids);
>  	viommu->dev = dev;
> @@ -1229,10 +1232,10 @@ static int viommu_probe(struct virtio_device *vdev)
>  	if (ret)
>  		goto err_free_vqs;
>  
> -	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
> -
>  	vdev->priv = viommu;
>  
> +	iommu_device_register(&viommu->iommu, &viommu_ops, parent_dev);
> +
>  	dev_info(dev, "input address: %u bits\n",
>  		 order_base_2(viommu->geometry.aperture_end));
>  	dev_info(dev, "page mask: %#llx\n", viommu->pgsize_bitmap);

