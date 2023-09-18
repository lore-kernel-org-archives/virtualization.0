Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5D3CD37B0
	for <virtualization@archiver.kernel.org>; Mon, 18 Sep 2023 15:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2C86A40C18;
	Mon, 18 Sep 2023 15:59:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2C86A40C18
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=guHh9yVJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2wJGFfRqUuev; Mon, 18 Sep 2023 15:59:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B20534060C;
	Mon, 18 Sep 2023 15:59:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B20534060C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A562C0071;
	Mon, 18 Sep 2023 15:59:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33CD2C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 15:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0024F4177B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 15:59:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0024F4177B
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=guHh9yVJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U9VhDjlzP3UB
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 15:59:11 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B012741775
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 15:59:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B012741775
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31c5cac3ae2so4187603f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695052748; x=1695657548;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3XBJAiGdnAah6NYpzFbKj5jrg8y8Zyfvfwd8mgzKL8c=;
 b=guHh9yVJ5gJn8PzZP82d3zC+r305bIKChAtDVjr120GbxW4PovtII00wY6T69TICYK
 6DaeBmDVeidWK99AlGmabVTgfeG78fcWVBm1Wv7uiF9Rbx5pbC+vB9N0FlGbKiaa9erp
 /5Z+wrmgDu2VZulsoy3ymjLZioNps5Gdnl1MJ2AY7LsaJPEKJ6iuYQchhLDRLRxajfvu
 MH2sAWNp81niY8e8WW4rvmr1fJN9gVHTVJGhDtI9lszYOBzHRbMyZdWtoyZZFAYvvsi1
 4UdhAAlBRoqFIjURnVnXqL4ZXkpw6t2+yQeInXNCvo1sBsISQO9pFv5dRrB2anHHUrgD
 6uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695052748; x=1695657548;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3XBJAiGdnAah6NYpzFbKj5jrg8y8Zyfvfwd8mgzKL8c=;
 b=XEZ662OePRyj2lupknBo/NtcX0HtKtDaKsr/tbwQNOdGmv9lwLB69x0aLTEHfsgah+
 c8NEdrSG5yGeoIvBCDpv8tuGICY9zGewyQ6O0+l2eTIF7nq8pLF3wxII9Wq51KxWeLJl
 OOtjZ3po9cmmnwN1SlqvKfwxpFRvHdPxTPpEAG8zQfFI9STqHxtkIyW+ZR8TBcjFPNiH
 DN0LnV6JqIugNce+2tPeSETii6Wqe9kqN9FRxxdpXYagv6FRg15DBwmBhB9GNWZJbnp/
 ClgDM6OTU9Z95reLWfg3rg13i90aNNStkX0KYcx1YJ5U+IOlaFQ9Vt25efM8x+kvptxS
 Mm/A==
X-Gm-Message-State: AOJu0YycrgR+f12iYzusT5eCU2fFJ/y5EaLkU4aA1WHQ48AuhN2QE2BH
 K1+rsRouw8PSIWW7JmbxczRHlg==
X-Google-Smtp-Source: AGHT+IGKCbH5H/HzgTN4rOlc0G7gV3sYCmmjllMp3MZ0mg9AwdHJzCYa0YtI/bnTzf2Hxk/+Rx6GTQ==
X-Received: by 2002:a5d:56ce:0:b0:314:1230:29b0 with SMTP id
 m14-20020a5d56ce000000b00314123029b0mr8616133wrw.52.1695052748670; 
 Mon, 18 Sep 2023 08:59:08 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
 by smtp.gmail.com with ESMTPSA id
 8-20020a05600c028800b00402c0a8a084sm15481477wmk.17.2023.09.18.08.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 08:59:07 -0700 (PDT)
Date: Mon, 18 Sep 2023 16:59:11 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH v2 2/2] iommu/virtio: Add ops->flush_iotlb_all and enable
 deferred flush
Message-ID: <20230918155911.GB2751287@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-2-f33767f6cf7a@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230918-viommu-sync-map-v2-2-f33767f6cf7a@linux.ibm.com>
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

On Mon, Sep 18, 2023 at 01:51:44PM +0200, Niklas Schnelle wrote:
> Add ops->flush_iotlb_all operation to enable virtio-iommu for the
> dma-iommu deferred flush scheme. This results in a significant increase
> in performance in exchange for a window in which devices can still
> access previously IOMMU mapped memory when running with
> CONFIG_IOMMU_DEFAULT_DMA_LAZY. The previous strict behavior can be
> achieved with iommu.strict=1 on the kernel command line or
> CONFIG_IOMMU_DEFAULT_DMA_STRICT.
> 
> Link: https://lore.kernel.org/lkml/20230802123612.GA6142@myrica/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/virtio-iommu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 3649586f0e5c..4dd330fbcbdd 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -926,6 +926,13 @@ static int viommu_iotlb_sync_map(struct iommu_domain *domain,
>  	return viommu_sync_req(vdomain->viommu);
>  }
>  
> +static void viommu_flush_iotlb_all(struct iommu_domain *domain)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	viommu_sync_req(vdomain->viommu);
> +}
> +
>  static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1051,6 +1058,8 @@ static bool viommu_capable(struct device *dev, enum iommu_cap cap)
>  	switch (cap) {
>  	case IOMMU_CAP_CACHE_COHERENCY:
>  		return true;
> +	case IOMMU_CAP_DEFERRED_FLUSH:
> +		return true;
>  	default:
>  		return false;
>  	}
> @@ -1071,6 +1080,7 @@ static struct iommu_ops viommu_ops = {
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
