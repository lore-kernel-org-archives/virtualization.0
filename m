Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB46C433F5
	for <virtualization@archiver.kernel.org>; Sat, 27 Nov 2021 17:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A867180F35;
	Sat, 27 Nov 2021 17:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8lQAq9pqnG4v; Sat, 27 Nov 2021 17:10:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0F51480D19;
	Sat, 27 Nov 2021 17:10:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9D90C0012;
	Sat, 27 Nov 2021 17:10:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E419DC000A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 17:10:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C474680F4A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 17:10:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o1sgUrZbSmnn
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 17:10:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0A13480D3A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638033000;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HpbaxbvFUA47MZA1WKLWnHmqPk4XzwH/ybSQA0YW/3U=;
 b=eU/XcV3Ei5iSykS/edf4YGrYDBmeQTOkkq+LScdDLtN0knJszTLxZ/UPvDoao90siN3RsY
 LTpnWdJQ/+DvJjsE1mziBBr05/vekPdxNzQwDxk5xRGzBXJ41YvxCv9093gBfbjLtk6/vi
 28Ds/OJPq9O0tV3T6VbMUHFIFSZlB0o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-588-IIrSOeGlMeyk_-hDeUcwBA-1; Sat, 27 Nov 2021 12:09:59 -0500
X-MC-Unique: IIrSOeGlMeyk_-hDeUcwBA-1
Received: by mail-wm1-f70.google.com with SMTP id
 ay34-20020a05600c1e2200b00337fd217772so7289231wmb.4
 for <virtualization@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 09:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-transfer-encoding:content-language;
 bh=HpbaxbvFUA47MZA1WKLWnHmqPk4XzwH/ybSQA0YW/3U=;
 b=wwZGiGSvkiWntpso0O3eoSL5m/SHKIi1MIFrCVkzVa5mnNnbyZuOMAF6OkVdhHDJtA
 dcNBVUX9x+Wvjk+Ly70kRrIqn0vdqJQSx88RbgLjg2og0kegLVFm7KwCyn2YYA29xPHZ
 rHd4JCN8wOebELefCJ9JaXJKR80fwxL6F/+ueXhxDs63rpJJZQV96XzU40PeNvS88GF/
 RANnQPzckUBOckp0SXsJqAefirEy5OJiWIo6BAp4IlOWCDqGLq9qeMGrQYLjxEI3N2sX
 Ti7HLmBlq0A05XLtgQkNVjM5bRRY5F0LMuXLWjxZ4lcxnghLiO8Mtl7LrblL3cYuKD0C
 sZvQ==
X-Gm-Message-State: AOAM530bQOMz3Corza5bmtDv/40qhdhO4EBlcK7KfgTbEZsJ6GBehK/w
 NBiR0KEcnm0K1XKQa5f5aVcEutBatf5Gu2gVtTWhKi3ipvzbr3zmnxDTRdZYD4epfUPMHiSohuO
 6ofpm1C2DZufuqjQQ0R4TsPKDxhIbNYslDggySxQLyA==
X-Received: by 2002:a05:600c:1993:: with SMTP id
 t19mr24514983wmq.21.1638032998488; 
 Sat, 27 Nov 2021 09:09:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylYMDW9wx2S0IayDXstUPO7/eLe+ycsLrI5JjytrC1XlaOvj4Wu+g0pzy2+IExg10pcHBflw==
X-Received: by 2002:a05:600c:1993:: with SMTP id
 t19mr24514956wmq.21.1638032998308; 
 Sat, 27 Nov 2021 09:09:58 -0800 (PST)
Received: from ?IPv6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id l5sm10976720wrs.59.2021.11.27.09.09.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Nov 2021 09:09:57 -0800 (PST)
Subject: Re: [PATCH v2 5/5] iommu/virtio: Support identity-mapped domains
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, joro@8bytes.org,
 will@kernel.org, mst@redhat.com, jasowang@redhat.com
References: <20211123155301.1047943-1-jean-philippe@linaro.org>
 <20211123155301.1047943-6-jean-philippe@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
Message-ID: <58572359-8232-3204-f69a-7f50b887a122@redhat.com>
Date: Sat, 27 Nov 2021 18:09:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20211123155301.1047943-6-jean-philippe@linaro.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, iommu@lists.linux-foundation.org,
 sebastien.boeuf@intel.com
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Jean,

On 11/23/21 4:53 PM, Jean-Philippe Brucker wrote:
> Support identity domains for devices that do not offer the
> VIRTIO_IOMMU_F_BYPASS_CONFIG feature, by creating 1:1 mappings between
> the virtual and physical address space. Identity domains created this
> way still perform noticeably better than DMA domains, because they don't
> have the overhead of setting up and tearing down mappings at runtime.
> The performance difference between this and bypass is minimal in
> comparison.
>
> It does not matter that the physical addresses in the identity mappings
> do not all correspond to memory. By enabling passthrough we are trusting
> the device driver and the device itself to only perform DMA to suitable
> locations. In some cases it may even be desirable to perform DMA to MMIO
> regions.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  drivers/iommu/virtio-iommu.c | 63 +++++++++++++++++++++++++++++++++---
>  1 file changed, 58 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index eceb9281c8c1..6a8a52b4297b 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -375,6 +375,55 @@ static size_t viommu_del_mappings(struct viommu_domain *vdomain,
>  	return unmapped;
>  }
>  
> +/*
> + * Fill the domain with identity mappings, skipping the device's reserved
> + * regions.
> + */
> +static int viommu_domain_map_identity(struct viommu_endpoint *vdev,
> +				      struct viommu_domain *vdomain)
> +{
> +	int ret;
> +	struct iommu_resv_region *resv;
> +	u64 iova = vdomain->domain.geometry.aperture_start;
> +	u64 limit = vdomain->domain.geometry.aperture_end;
> +	u32 flags = VIRTIO_IOMMU_MAP_F_READ | VIRTIO_IOMMU_MAP_F_WRITE;
> +	unsigned long granule = 1UL << __ffs(vdomain->domain.pgsize_bitmap);
> +
> +	iova = ALIGN(iova, granule);
> +	limit = ALIGN_DOWN(limit + 1, granule) - 1;
> +
> +	list_for_each_entry(resv, &vdev->resv_regions, list) {
> +		u64 resv_start = ALIGN_DOWN(resv->start, granule);
> +		u64 resv_end = ALIGN(resv->start + resv->length, granule) - 1;
> +
> +		if (resv_end < iova || resv_start > limit)
> +			/* No overlap */
> +			continue;
> +
> +		if (resv_start > iova) {
> +			ret = viommu_add_mapping(vdomain, iova, resv_start - 1,
> +						 (phys_addr_t)iova, flags);
> +			if (ret)
> +				goto err_unmap;
> +		}
> +
> +		if (resv_end >= limit)
> +			return 0;
> +
> +		iova = resv_end + 1;
> +	}
> +
> +	ret = viommu_add_mapping(vdomain, iova, limit, (phys_addr_t)iova,
> +				 flags);
> +	if (ret)
> +		goto err_unmap;
> +	return 0;
> +
> +err_unmap:
> +	viommu_del_mappings(vdomain, 0, iova);
> +	return ret;
> +}
> +
>  /*
>   * viommu_replay_mappings - re-send MAP requests
>   *
> @@ -637,14 +686,18 @@ static int viommu_domain_finalise(struct viommu_endpoint *vdev,
>  	vdomain->viommu		= viommu;
>  
>  	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> -		if (!virtio_has_feature(viommu->vdev,
> -					VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
> +		if (virtio_has_feature(viommu->vdev,
> +				       VIRTIO_IOMMU_F_BYPASS_CONFIG)) {
> +			vdomain->bypass = true;
> +			return 0;
> +		}
> +
> +		ret = viommu_domain_map_identity(vdev, vdomain);
> +		if (ret) {
>  			ida_free(&viommu->domain_ids, vdomain->id);
> -			vdomain->viommu = 0;
> +			vdomain->viommu = NULL;
nit: that change could have been done in patch 2
>  			return -EOPNOTSUPP;
>  		}
> -
> -		vdomain->bypass = true;
>  	}
>  
>  	return 0;
Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
