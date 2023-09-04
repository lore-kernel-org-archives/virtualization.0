Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB2BC71153
	for <virtualization@archiver.kernel.org>; Mon,  4 Sep 2023 15:26:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 315C940942;
	Mon,  4 Sep 2023 15:26:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 315C940942
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KWqe+g70
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F57M9eVIjm1O; Mon,  4 Sep 2023 15:26:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 131A24092A;
	Mon,  4 Sep 2023 15:26:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 131A24092A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D47F0C0039;
	Mon,  4 Sep 2023 15:26:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E755C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 15:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5FC4640B24
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 15:26:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5FC4640B24
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=KWqe+g70
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GUzlxSXrM_QD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 15:26:30 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E407402E0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 15:26:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9E407402E0
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4018af1038cso16059885e9.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Sep 2023 08:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693841187; x=1694445987;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fDf3q7+EQu7w2zbw3JsPePbQVuqHBAlzwY6aMD3wySI=;
 b=KWqe+g70uwYuYiRUibUMS++WjmfDRLotaacSpJN8AaBJJOJFPC49J18pewXw9A6V2C
 k6GctqZZfNxo59+mT7Jl1/Thy26HKDKkh/cuZXeBYGUdDfXSthVfQI9G0Ob/Yc6KCgOQ
 8I6KxEp/LTR2XwXUthQrA370ZSRYTpkYDInOIuel3wK7dn6Ivty+xPE5DC3hZGlEksrj
 FGCsN21saWtNhhx5fQekmGrxm0uUEWlFFk29dIszCwsoATM8SH8M9SEapl4VTq1onYyN
 RE+d+TjQIrIJ/c3sujmRzjeuaHWXGXnCb+Vw/ANjNvkYxtM3sDgVh0NgdN7ACbTy81Rk
 nzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693841187; x=1694445987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fDf3q7+EQu7w2zbw3JsPePbQVuqHBAlzwY6aMD3wySI=;
 b=BauQaXW2DHtVyrRWn1SaGhEVMqaODlpxCdX5GDTrHVIZ9ojTRvXxi+l3b7xaa4ulHk
 k1eNNTCkYGszj+Yo6WLSCRMoCWey4Ve92uGS8KGNuqTuBSj55JN0QURjhzKofFDeFXaC
 jXlMV8hoPOOv1Im/3zP5O/f70OjO03v6FBF/kH1T8NWZSy3Esaln/uGbjxJNc5c0MhOI
 aAZtMQluxNSLOibBd4io3A2PymbQnXixKTnNTlSXy6f1TX6p/5dovLgsnRQUpryf2fYR
 yottlDCL7TRkO9FLpIDLKKovLCxNooQQDqIjIxcbNBZ3Uv2bV7/wvaDx8FN1/ST80g7n
 H5NQ==
X-Gm-Message-State: AOJu0Yz0YGGcTGAucXpLG7oenediWgXveoORPLc6qNqOhppK9SM2HTKE
 eRsmbV+IQOOGBnyvz/yz/vi7bw==
X-Google-Smtp-Source: AGHT+IHWxHR1EFAYshcTB7RB95vh4F3SsbWMVSXXFSxXBH5grbtimj3wW7/bF5tK15QkRFCPr/KWYg==
X-Received: by 2002:a5d:66ce:0:b0:317:d048:8d87 with SMTP id
 k14-20020a5d66ce000000b00317d0488d87mr6659141wrw.61.1693841187508; 
 Mon, 04 Sep 2023 08:26:27 -0700 (PDT)
Received: from myrica ([2.220.83.24]) by smtp.gmail.com with ESMTPSA id
 z23-20020a1c4c17000000b00401d8181f8bsm17377650wmf.25.2023.09.04.08.26.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 08:26:27 -0700 (PDT)
Date: Mon, 4 Sep 2023 16:26:32 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230904152632.GA815284@myrica>
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
 <20230825-viommu-sync-map-v1-1-56bdcfaa29ec@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230825-viommu-sync-map-v1-1-56bdcfaa29ec@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Niklas,

Thanks for following up with these patches

On Fri, Aug 25, 2023 at 05:21:25PM +0200, Niklas Schnelle wrote:
> Pull out the sync operation from viommu_map_pages() by implementing
> ops->iotlb_sync_map. This allows the common IOMMU code to map multiple
> elements of an sg with a single sync (see iommu_map_sg()). Furthermore,
> it is also a requirement for IOMMU_CAP_DEFERRED_FLUSH.
> 
> Link: https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/virtio-iommu.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 3551ed057774..fb73dec5b953 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -843,7 +843,7 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  			.flags		= cpu_to_le32(flags),
>  		};
>  
> -		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> +		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
>  		if (ret) {
>  			viommu_del_mappings(vdomain, iova, end);
>  			return ret;
> @@ -909,9 +909,21 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
>  {
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
> +	if (!vdomain->nr_endpoints)
> +		return;

I was wondering about these nr_endpoints checks, which seemed unnecessary:
if map()/unmap() were called with no attached endpoints, then no requests
were added to the queue, and viommu_sync_req() below is a nop.

But at least viommu_iotlb_sync_map() and viommu_flush_iotlb_all() need to
handle being called before the domain is finalized (for example by
iommu_create_device_direct_mappings()). In that case vdomain->viommu is
NULL so if you add a NULL check in viommu_sync_req() then you should be
able to drop the nr_endpoints checks in both patches.

Thanks,
Jean

>  	viommu_sync_req(vdomain->viommu);
>  }
>  
> +static int viommu_iotlb_sync_map(struct iommu_domain *domain,
> +				 unsigned long iova, size_t size)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	if (!vdomain->nr_endpoints)
> +		return 0;
> +	return viommu_sync_req(vdomain->viommu);
> +}
> +
>  static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1058,6 +1070,7 @@ static struct iommu_ops viommu_ops = {
>  		.unmap_pages		= viommu_unmap_pages,
>  		.iova_to_phys		= viommu_iova_to_phys,
>  		.iotlb_sync		= viommu_iotlb_sync,
> +		.iotlb_sync_map		= viommu_iotlb_sync_map,
>  		.free			= viommu_domain_free,
>  	}
>  };
> 
> -- 
> 2.39.2
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
