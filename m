Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ADB1E3DDB
	for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755191508; cv=none; b=hGRlBTOSCiroTAIW6kvNGH89DWNT9wAB23W3Jv2T2B9pAyO3vY0J6ui+B8XRutdZoS3Kfklcu+ztW9M/ynsQFf9Ep2XLJ7HnrhABZbLHaKssCs0yFsbMhuvYs27SRXRjvtrkpjx8Xw1Reh0szbCqLquZLnKKTTzaZyrSJPQtl6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755191508; c=relaxed/simple;
	bh=AhX5F4G0aBYzPmFDasmo2ht5cOhGbSJjHuqzpT/I+Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwgK6hmbJvYrhwWD7o4sMT4orU/jOSNrjmZlsea9x/BtlyfboKp/LMxoDokc8mUiDU7NBdAeBki+2toG3hMWblUO6j9HH7tCoF3lBQyQ1vpPCkKJTIouET8WuVJTZ0V1vPbRUiHaA6glns8ca3UOKGc9dzJcfujvVVxVFn8yo1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uspf+S06; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uspf+S06"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755191506;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lznyOOkV6KkkIEe59fB3MWrdJzsx93AmS4/MBGo8g1g=;
	b=Uspf+S06CRjvpvhh1zBI92fWnUIxeCJj9r4qeRXYeN/dLQTC8wPFDU3WwRrM8c57yNvIg+
	8bp3iGERf/0rYnlfPuwH/YDfvc4CXn6qrLYcECGvaqyhuAsfGIcuFp1mh8nRmMgdRRkjla
	Odvr3A1ALZrS4qoNDJbpr+ZggJuL3IQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-0K-Rg3r_Mw6rh3NCaMMGXQ-1; Thu, 14 Aug 2025 13:11:45 -0400
X-MC-Unique: 0K-Rg3r_Mw6rh3NCaMMGXQ-1
X-Mimecast-MFC-AGG-ID: 0K-Rg3r_Mw6rh3NCaMMGXQ_1755191505
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e870676ac0so278575985a.3
        for <virtualization@lists.linux.dev>; Thu, 14 Aug 2025 10:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755191504; x=1755796304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lznyOOkV6KkkIEe59fB3MWrdJzsx93AmS4/MBGo8g1g=;
        b=GtBoINVUxTgl0HLAFmz7OyjlwuTwZt5aPE+BQvu7AWu1psACM47Y5KbTV/4lbBv61w
         ZfsrlbEbM5HuACBsRxWxDvfhGi+l321Z0iD7f/fiDv5dbiSWVSSc07kzSxhXoKxlx5Kg
         avnHmUcitKt+pxPJXHTeNMWpYbHylbSz1fHYkYgUxghlF8SqOrUBH3F7VIOWwAbTL4ph
         tgirRrh7qXv3FXCCVGCxZ5Y1Ho7YPjzM/hiMvk/uD/rsFNtzHk4dxqjvYP5h1ErJKr5C
         tTftGA9dw+LFfh3KciemuPOfz+8wrF4tpR04CyX3YY/xS90rWvwACF1XhyEHS6QvnOCl
         EwsA==
X-Forwarded-Encrypted: i=1; AJvYcCXUOsUrR4t2BQVH/sNkf6/1o/5yF+qbds1ApQSVuv3DbmVBj4WjvkeBM+POywYvaYeGebw3gA/GCA1scXtSyQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZN/ugIWnDYV1A6P1xaYkhOroZr0sAxQsPbGVYcyLkZ60OV5/0
	hvtitpPv3eYR9CEGOLnuKw8zVKWOgzENBcYR+t756kByGchBfeFGC3rHArlbF36iL55okyh6iAS
	SqAeRpAQuiyjzDTXrarcmJvcWCaDGIYmN1QbeDE7BkHyLLC5miD1X6nazSWKtOlgkiMfV7wCyf7
	it
X-Gm-Gg: ASbGncunFn+qpRX56+Q/0g349FRiqcHGKTSncyFpb1eW0nA0rC7e+OPTdlD5t27dztt
	NPsxkSBcypyz3vMX+ysabJgm977McbsPsjH2KAE4HwaQ+sIfEwHpQKRmMmXSqWjQkk9cwdg8neJ
	dH4APTUQd19CAsOYPtnhrc890o+D1kd0tYC+kyXym3/spwuhTO+rVLHfuD5B/W7rroB780M+gx3
	31+lYIOjTUuOfBckozW7XJdJIPxMUyNTYOkCEJENHCYq+hmv3rsDcmCVTbDHn2joNgjL7SqJzcn
	C76bjz0PcCFScNi1fTtPF4fCzUZmpLNPvenuqIo9ONj9drWsX8auhMQogZFm5c36yfu94Z5PisY
	EzsbultKRI1U=
X-Received: by 2002:a05:620a:424a:b0:7e8:7094:52e7 with SMTP id af79cd13be357-7e87094638dmr516634485a.10.1755191504403;
        Thu, 14 Aug 2025 10:11:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1WjbN3jtp13Y9aVPhnFkE4KaUT281M8OZYzkWWCEt0LdtOUTsCxK8pvtDoHGnPioaqAABXA==
X-Received: by 2002:a05:620a:424a:b0:7e8:7094:52e7 with SMTP id af79cd13be357-7e87094638dmr516630585a.10.1755191503980;
        Thu, 14 Aug 2025 10:11:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874? ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87b37e80bsm2466785a.37.2025.08.14.10.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 10:11:43 -0700 (PDT)
Message-ID: <589663b5-7b92-4366-b4c1-6d4e091a0ea7@redhat.com>
Date: Thu, 14 Aug 2025 19:11:41 +0200
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
X-Mimecast-MFC-PROC-ID: rzDKdtnpb182w6Cd7tpPuM3fnyGU16GJ2P3VnJxcKWQ_1755191505
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Robin,

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

This version works for me. Thanks for the diligent respin.

Tested-by: Eric Auger <eric.auger@redhat.com>

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

