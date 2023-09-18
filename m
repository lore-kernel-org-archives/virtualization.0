Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0325C46CA1
	for <virtualization@archiver.kernel.org>; Mon, 18 Sep 2023 15:58:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 456B081FF4;
	Mon, 18 Sep 2023 15:58:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 456B081FF4
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=BTJeH0Yj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wIPhuyQsDc34; Mon, 18 Sep 2023 15:58:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6974C81FAC;
	Mon, 18 Sep 2023 15:58:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6974C81FAC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D1E2C0071;
	Mon, 18 Sep 2023 15:58:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 831F7C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 15:58:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A6644094F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 15:58:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4A6644094F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=BTJeH0Yj
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m0GqDqT3JKEu
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 15:58:06 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3AAEB40C20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 15:58:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3AAEB40C20
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-402d0eda361so51138075e9.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Sep 2023 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695052684; x=1695657484;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BuWLNVcWzC6ASPZz9GEuSYcaG6pqUJBDXR7IC05cfLo=;
 b=BTJeH0Yjzrzq8hs/T59XpfmXWq3fKHLF+L8lNWLIt63fTId72nokG7LjnrEno1J0rl
 389um1QlVGF979y8Zr0kgsatNLd9222strxR6zF3OBe3l3VmzTiJJYxgg9UtyxZX6VkD
 hZOVhCU3c2ul7NDok0G0rfV78GgNGQQ0fKjUd/0spaXpk+uCRw1xvT5vS6/er4p3tIEH
 KB3MwaABr6xGjLx2ksPvg4DliVOCkH0C8oHHLZAW9rqe3cGZqXx/JbbXgnDEIAfx5aZ2
 Wn/bIoCPX+/qhJDSjRt7AakqsqW98tL1mE9OyzkFpBmWMUx69OQfBSoa0SFx6jyvovun
 /Y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695052684; x=1695657484;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuWLNVcWzC6ASPZz9GEuSYcaG6pqUJBDXR7IC05cfLo=;
 b=cKg0I4uAG99UYSjoJgpy2b5I7V95o5kx2nzkMzyz9APG8LDSViu1lnweGNhX7e3WVC
 5B4KG+MwxXHot7CEtrjriQ2ZbJP9fJFMuaefp+IF2/myXP9Ov1yjK/okQzGLkQUUFVED
 hJt/SjUrHJa3Rd53fSQSW4QUhL4/SigW0Es0Ib6YQLztbTSiKxyEMPft/VF2Ly5wMr2/
 YHNHbn5eJO0ueOxKOskJHIi3VQLwidnJfLP4bNOkfp4yZoNqLx519Og+8WGASvRQDuKZ
 Zf648ipbUH2HgYUkEB3YD7WeQ4nP4YeemLRkPUmugcsbuPmMwYox8wGny09xgzBFrcpP
 cluw==
X-Gm-Message-State: AOJu0YzCs4TTqJ+v4UQchIyhhHW2wKAp2hCmrW0q+hB6R+m78RJ7UG1f
 JuaemhlMk4hsEA9Qb4Jm708jsg==
X-Google-Smtp-Source: AGHT+IFkwjfPBd2yc8mJTKncE3vqTaKfj1taiCNjhQjrYNC7gDR/8luatOeD/+/M95Nq3Fi20OUQWg==
X-Received: by 2002:a05:600c:3784:b0:3fb:4055:1ddd with SMTP id
 o4-20020a05600c378400b003fb40551dddmr7641400wmr.28.1695052683796; 
 Mon, 18 Sep 2023 08:58:03 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
 by smtp.gmail.com with ESMTPSA id
 ay18-20020a05600c1e1200b003fef5e76f2csm3022438wmb.0.2023.09.18.08.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Sep 2023 08:57:59 -0700 (PDT)
Date: Mon, 18 Sep 2023 16:58:00 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230918155800.GA2751287@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
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

On Mon, Sep 18, 2023 at 01:51:43PM +0200, Niklas Schnelle wrote:
> Pull out the sync operation from viommu_map_pages() by implementing
> ops->iotlb_sync_map. This allows the common IOMMU code to map multiple
> elements of an sg with a single sync (see iommu_map_sg()). Furthermore,
> it is also a requirement for IOMMU_CAP_DEFERRED_FLUSH.
> 
> Link: https://lore.kernel.org/lkml/20230726111433.1105665-1-schnelle@linux.ibm.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

This must be merged after "iommu/dma: s390 DMA API conversion and
optimized IOTLB flushing" because of the updated iotlb_sync_map()
prototype.

Thanks,
Jean

> ---
>  drivers/iommu/virtio-iommu.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 17dcd826f5c2..3649586f0e5c 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
>  	int ret;
>  	unsigned long flags;
>  
> +	/*
> +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> +	 */
> +	if (!viommu)
> +		return 0;
>  	spin_lock_irqsave(&viommu->request_lock, flags);
>  	ret = __viommu_sync_req(viommu);
>  	if (ret)
> @@ -843,7 +849,7 @@ static int viommu_map_pages(struct iommu_domain *domain, unsigned long iova,
>  			.flags		= cpu_to_le32(flags),
>  		};
>  
> -		ret = viommu_send_req_sync(vdomain->viommu, &map, sizeof(map));
> +		ret = viommu_add_req(vdomain->viommu, &map, sizeof(map));
>  		if (ret) {
>  			viommu_del_mappings(vdomain, iova, end);
>  			return ret;
> @@ -912,6 +918,14 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
>  	viommu_sync_req(vdomain->viommu);
>  }
>  
> +static int viommu_iotlb_sync_map(struct iommu_domain *domain,
> +				 unsigned long iova, size_t size)
> +{
> +	struct viommu_domain *vdomain = to_viommu_domain(domain);
> +
> +	return viommu_sync_req(vdomain->viommu);
> +}
> +
>  static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> @@ -1058,6 +1072,7 @@ static struct iommu_ops viommu_ops = {
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
