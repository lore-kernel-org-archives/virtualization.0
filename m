Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB501CD5BCE
	for <virtualization@archiver.kernel.org>; Tue, 19 Sep 2023 14:48:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C127404C8;
	Tue, 19 Sep 2023 14:48:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5C127404C8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=iirJkXOf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v_9qsKpANj1m; Tue, 19 Sep 2023 14:48:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 7D88E4032C;
	Tue, 19 Sep 2023 14:48:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7D88E4032C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45529C0071;
	Tue, 19 Sep 2023 14:48:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56915C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 14:48:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2AB7682AF8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 14:48:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2AB7682AF8
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=iirJkXOf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p3XmPP4_em46
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 14:48:11 +0000 (UTC)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2128A82342
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 14:48:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2128A82342
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6564515ec4eso19008996d6.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Sep 2023 07:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1695134890; x=1695739690;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EquMz/cfki7kEYJ0MaznRKfaKZ1PqbzvZHpIvKnZUnM=;
 b=iirJkXOfMj0tkQM/DUs0ze9NQb2lH5AYN2v+wYHBmteiKny/YG5Qb3ZfZZVj7x4dAe
 kii33/eKHp38OK8QhU0wFUY2KhSAFqSrqGsTg1QsfVBcFfqysTpwrFHrqXFWDAkyUNOL
 uxZ0A+gAd19mMkrJauGQucPxX2ODtLZ2FrsOWZl8dbBGljiqFcsw0WK2NxVF/ZCNTEdJ
 Est8xBoC5P+9KCeDo6fQ6fSnWGXZ6hdHOMjT4AEgc3kE4iajKBW90HzcTKoP4/OXN00z
 ijQk4pRDiRDbcEA8cbIlWi8vOCDMI0SHkFvfMv32F0G6y6HugYAx7BsHTedvdkB5FABT
 oMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695134890; x=1695739690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EquMz/cfki7kEYJ0MaznRKfaKZ1PqbzvZHpIvKnZUnM=;
 b=d+qL1KqWgs0g2x6IhD0zxbpVFgmaTPrB4hwFGP/hNut6s5Kx9jz26Z6kzh0FHzqzM8
 /cbbu/28xjFPx8pqSY2yn49v8xKsMQc8jl+E35ats/Nm1QQkVM0tYhAJopV6U/lwCA2W
 gt31Xw/WUt1CDsVoYBdB0FlhjHqsFLpzgg15OAlaXdaXmuJEKOPZVJmxAU8VfAeYlOtG
 tnXflboNbnC+tmukS4Z992etKxF52pZlk+5rUZZ+y+h/+L6KYhGbLCX4cBMVg6DKOKso
 Mn1iTZyu7g+KEEJXa7coJlj0HMcoPzLj7XvCypYQCO0Dyr60AhcOo2nh/TL0HeVD0Guv
 XS8A==
X-Gm-Message-State: AOJu0YxAyisMRV0W9uyKHNonEq2DpeFLNFWYEdLytd1sisnQPN4u0Ncm
 k3MYnnELm5zwgSqzqPI9Ko0y/DeT6gvY3bzrsa4=
X-Google-Smtp-Source: AGHT+IFhbKsrLcKnFuicZOuiJBoQGo+a4wPHjLFimyP3XIPppsptAboML0WRwQZ8AGOCizTCF1f9dQ==
X-Received: by 2002:a05:6214:1192:b0:64f:60e9:9285 with SMTP id
 t18-20020a056214119200b0064f60e99285mr12393879qvv.30.1695134889866; 
 Tue, 19 Sep 2023 07:48:09 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.26.201]) by smtp.gmail.com with ESMTPSA id
 w25-20020a0cb559000000b0064f72988fecsm4437544qvd.127.2023.09.19.07.46.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 07:47:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1qic01-000ExN-0m;
 Tue, 19 Sep 2023 11:46:49 -0300
Date: Tue, 19 Sep 2023 11:46:49 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230919144649.GT13795@ziepe.ca>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230919081519.GA3860249@myrica>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 iommu@lists.linux.dev, Will Deacon <will@kernel.org>
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

On Tue, Sep 19, 2023 at 09:15:19AM +0100, Jean-Philippe Brucker wrote:
> On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
> > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > > index 17dcd826f5c2..3649586f0e5c 100644
> > > --- a/drivers/iommu/virtio-iommu.c
> > > +++ b/drivers/iommu/virtio-iommu.c
> > > @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
> > >   	int ret;
> > >   	unsigned long flags;
> > > +	/*
> > > +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> > > +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> > > +	 */
> > > +	if (!viommu)
> > > +		return 0;
> > 
> > Minor nit: I'd be inclined to make that check explicitly in the places where
> > it definitely is expected, rather than allowing *any* sync to silently do
> > nothing if called incorrectly. Plus then they could use
> > vdomain->nr_endpoints for consistency with the equivalent checks elsewhere
> > (it did take me a moment to figure out how we could get to .iotlb_sync_map
> > with a NULL viommu without viommu_map_pages() blowing up first...)

This makes more sense to me

Ultimately this driver should reach a point where every iommu_domain
always has a non-null domain->viommu because it will be set during
alloc.

But it can still have nr_endpoints == 0, doesn't it make sense to
avoid sync in this case?

(btw this driver is missing locking around vdomain->nr_endpoints)

> They're not strictly equivalent: this check works around a temporary issue
> with the IOMMU core, which calls map/unmap before the domain is
> finalized.

Where? The above points to iommu_create_device_direct_mappings() but
it doesn't because the pgsize_bitmap == 0:

static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
					       struct device *dev)
{
	struct iommu_resv_region *entry;
	struct list_head mappings;
	unsigned long pg_size;
	int ret = 0;

	pg_size = domain->pgsize_bitmap ? 1UL << __ffs(domain->pgsize_bitmap) : 0;
	INIT_LIST_HEAD(&mappings);

	if (WARN_ON_ONCE(iommu_is_dma_domain(domain) && !pg_size))

Indeed, the driver should be failing all map's until the domain is
finalized because it has no way to check the IOVA matches the eventual
aperture.

Jason
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
