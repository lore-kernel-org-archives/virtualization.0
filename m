Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3AEC83F2C
	for <virtualization@archiver.kernel.org>; Mon,  4 Sep 2023 15:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 74CA2813DB;
	Mon,  4 Sep 2023 15:34:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74CA2813DB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oB3Lg7OW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R2oZgxVehx_M; Mon,  4 Sep 2023 15:34:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 062FD813B6;
	Mon,  4 Sep 2023 15:34:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 062FD813B6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C8304C0039;
	Mon,  4 Sep 2023 15:34:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13AACC0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 15:34:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E194561009
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 15:34:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E194561009
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=oB3Lg7OW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ddouBFSNkCNz
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 15:34:01 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB4F761005
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Sep 2023 15:34:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BB4F761005
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-401d80f4ef8so16958065e9.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 04 Sep 2023 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693841638; x=1694446438;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8mKB1k2ZE2G/ciLlCDtCzQ5wGQ8xRQbZHnxa2+q17Z8=;
 b=oB3Lg7OWLWiapp7FbmlDZw7u6BM10s8mLie1hG7AdeLhTEN7knW66YWKeM9eHuL2ET
 xNT3dGgnbUBcpudUwSqRxuZ48Q8KHZPdD/d/tR5SEM4Jm0H7LIMO/zTnZvIfsic2cNbN
 1SjM5esi1vr+tTxk/4uv2Pp+9Pu0B/wtJl2Xf5GSnWQaBDTSWLs6xvXA+mTlS3UzW0J1
 yblMDWMBcJohG9g03gkCWEKTjYBiBi41Hx6wNsXDCm9G3ra9gj4Eg8YYdj8cbCEaHOQL
 JTFqYbRi6QdQB1ZH4Prl72IVf0/4eeJCxx7WSaqZ0mTMLoVlRaq2Qc6lU75waw0UaLnX
 ViVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693841638; x=1694446438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mKB1k2ZE2G/ciLlCDtCzQ5wGQ8xRQbZHnxa2+q17Z8=;
 b=dEJz/sMN39IZ7q1WAvW7GjEL63KIh9zZGlIfP+KHcUgJsdodBCTEMSOQeGuy5o6ZAU
 dpEzIwm2TFiF6CicDHIX+zMeGWVxSoNYAXuskJZXOyK4qSrGPn3JuqjGHxQxItuzUrOc
 25iRyn5bAgvp/AUFc9bQCxy43JiQ808iYgmoi8GUQNYu76jw7rq3oQWrgq37Qchl/yT9
 r+FGC1LaQxb9+wJxui+O2Qp2dKxFXCFBi7ve21m0E4JwqNwIC7A7sacFtBvNIpqf9Owi
 NQZsgJ8vmpSWoSdGw8QQopzfBUWhvhpuueTxbijcXyi5wWwfSMJj+LYsPgqlH7h+zee0
 WKVQ==
X-Gm-Message-State: AOJu0Yw5/4RAOSfS2yDA9HDhWPPdMxmBqkQC2Gs3mxrW+10TCC4qXQl6
 WTSnwrtV6A6AxlGdx31e5EEVwg==
X-Google-Smtp-Source: AGHT+IGhYh7h7UosmsP+axnCskrqTn/m5wl+B+KT+YE2nQBzRYMTV/Fur6gSkA0GnBJj6rv+rEUuzA==
X-Received: by 2002:a05:600c:2945:b0:3fe:89be:cd3 with SMTP id
 n5-20020a05600c294500b003fe89be0cd3mr7728851wmd.22.1693841638575; 
 Mon, 04 Sep 2023 08:33:58 -0700 (PDT)
Received: from myrica ([2.220.83.24]) by smtp.gmail.com with ESMTPSA id
 o24-20020a05600c379800b003fed70fb09dsm14379467wmr.26.2023.09.04.08.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 08:33:58 -0700 (PDT)
Date: Mon, 4 Sep 2023 16:34:03 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Message-ID: <20230904153403.GB815284@myrica>
References: <20230825-viommu-sync-map-v1-0-56bdcfaa29ec@linux.ibm.com>
 <20230825-viommu-sync-map-v1-2-56bdcfaa29ec@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230825-viommu-sync-map-v1-2-56bdcfaa29ec@linux.ibm.com>
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

On Fri, Aug 25, 2023 at 05:21:26PM +0200, Niklas Schnelle wrote:
> Add ops->flush_iotlb_all operation to enable virtio-iommu for the
> dma-iommu deferred flush scheme. This results inn a significant increase

in

> in performance in exchange for a window in which devices can still
> access previously IOMMU mapped memory. To get back to the prior behavior
> iommu.strict=1 may be set on the kernel command line.

Maybe add that it depends on CONFIG_IOMMU_DEFAULT_DMA_{LAZY,STRICT} as
well, because I've seen kernel configs that enable either.

> 
> Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/iommu/virtio-iommu.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index fb73dec5b953..1b7526494490 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -924,6 +924,15 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
>  	return viommu_sync_req(vdomain->viommu);
>  }
>  
> +static void viommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	if (!vdomain->nr_endpoints)
> +		return;

As for patch 1, a NULL check in viommu_sync_req() would allow dropping
this one

Thanks,
Jean

> +	viommu_sync_req(vdomain->viommu);
> +}
> +
>  static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1049,6 +1058,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
>  		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;
>  	default:
>  		return false;
>  	}
> @@ -1069,6 +1080,7 @@ static struct iommu_ops viommu_ops = {
>  		.map_pages		= viommu_map_pages,
>  		.unmap_pages		= viommu_unmap_pages,
>  		.iova_to_phys		= viommu_iova_to_phys,
> +		.flush_iotlb_all	= viommu_flush_iotlb_all,
>  		.iotlb_sync		= viommu_iotlb_sync,
>  		.iotlb_sync_map		= viommu_iotlb_sync_map,
>  		.free			= viommu_domain_free,
> 
> -- 
> 2.39.2
> 
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
