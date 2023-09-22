Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7114CD4F2E
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 07:57:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 57A1E41495;
	Fri, 22 Sep 2023 07:57:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 57A1E41495
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C0olOR8I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0DPGyIlR0bYO; Fri, 22 Sep 2023 07:57:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B4DED4117E;
	Fri, 22 Sep 2023 07:57:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B4DED4117E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9611AC0039;
	Fri, 22 Sep 2023 07:57:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D60EDC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 07:57:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B705981F47
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 07:57:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B705981F47
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.a=rsa-sha256 header.s=google header.b=C0olOR8I
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5ZMDTyxgmTHK
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 07:57:16 +0000 (UTC)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BA72B81F3A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 07:57:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BA72B81F3A
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-31fa15f4cc6so1727559f8f.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695369434; x=1695974234;
 darn=lists.linux-foundation.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZnFqnWCwcyqa0uxptZjUfiZurm7gKfTYACFMprkcSZc=;
 b=C0olOR8IxUM9RaiDx29tR2IkLsvKMZBTD+pLU2vTsNfRaRIGe3mpQm3Msho16V6fWw
 tt5PKn72C69MyRuVXugkwkdxski/7IOjQ9ulVEPVb1sMcqZP/pViQIxit9FFUGrctQdM
 D7Zhr07hlOxf8HW5hElz5mDeIKONWMdRXhXeG12lMsqDnoO0+HJALaOP90KyJPMp8Hq8
 ExsWqFshKRCynYcc/rUAko7jUgGfuHUQbgtoj9Jup7DnA3rZN/MkHMnIVHksVtQ8Qq8+
 /0n0CIsYDCEm8CMDk3DyB4HacXpcfMZGtBTnZU4OqR+WPGX/iTWPTxfhu7qBLoGgOnMJ
 2Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695369434; x=1695974234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZnFqnWCwcyqa0uxptZjUfiZurm7gKfTYACFMprkcSZc=;
 b=azMh/Vabzpew+2Yr55Fsx8FoyUP+mvgC9VRIKZMp9xz2PvWSQVgIO8xWtAW0jx/NWQ
 zl7cUXYAkTdb3K5gQzFN17T8bhDtTPgfKmo5DDMlOB1jsNWP5Qalbyv7srURLPys4it/
 n+uRpwJmeQGy8oBCIWc8abM21zwbtDGF7v60b5q+4PN0d2cAQoFOTDRcvWytQVi3sSCi
 KfR/kvIQW7uY+/JnWTrUPe3x5zklJO5tgzh7Wua59wF9qDnLBGOhJiZVurk2w74CTzD0
 EyFeAeiggAge2TbWO/fIi+OFxSA42Qg5u705m/eU90JdAQQ16+Wnpuorfs0EqmGbIa0F
 vONQ==
X-Gm-Message-State: AOJu0YyS+Pq83HAX2s7GKvIjD2OFRj/6gjW1R3wj4RciB8zpifoeNh99
 YLuuW+7x2BNPKkZlGQsuajOFxQ==
X-Google-Smtp-Source: AGHT+IHWcZglriBzW9X2jK5nxXTgqPGq0Rp8QA7W/Rk3EcPZ5Jyf8nkyUbyRRLcvr0oqOvJfnIoUVw==
X-Received: by 2002:adf:f008:0:b0:31f:fab1:c3c3 with SMTP id
 j8-20020adff008000000b0031ffab1c3c3mr7029007wro.35.1695369433661; 
 Fri, 22 Sep 2023 00:57:13 -0700 (PDT)
Received: from myrica ([2a02:c7c:7290:b00:fd32:2b31:6755:400c])
 by smtp.gmail.com with ESMTPSA id
 y12-20020adffa4c000000b0031f5f0d0be0sm3746610wrr.31.2023.09.22.00.57.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 00:57:13 -0700 (PDT)
Date: Fri, 22 Sep 2023 08:57:19 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v2 1/2] iommu/virtio: Make use of ops->iotlb_sync_map
Message-ID: <20230922075719.GB1361815@myrica>
References: <20230918-viommu-sync-map-v2-0-f33767f6cf7a@linux.ibm.com>
 <20230918-viommu-sync-map-v2-1-f33767f6cf7a@linux.ibm.com>
 <ae7e513b-eb86-97e2-bed0-3cca91b8c959@arm.com>
 <20230919081519.GA3860249@myrica> <20230919144649.GT13795@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230919144649.GT13795@ziepe.ca>
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

On Tue, Sep 19, 2023 at 11:46:49AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 19, 2023 at 09:15:19AM +0100, Jean-Philippe Brucker wrote:
> > On Mon, Sep 18, 2023 at 05:37:47PM +0100, Robin Murphy wrote:
> > > > diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> > > > index 17dcd826f5c2..3649586f0e5c 100644
> > > > --- a/drivers/iommu/virtio-iommu.c
> > > > +++ b/drivers/iommu/virtio-iommu.c
> > > > @@ -189,6 +189,12 @@ static int viommu_sync_req(struct viommu_dev *viommu)
> > > >   	int ret;
> > > >   	unsigned long flags;
> > > > +	/*
> > > > +	 * .iotlb_sync_map and .flush_iotlb_all may be called before the viommu
> > > > +	 * is initialized e.g. via iommu_create_device_direct_mappings()
> > > > +	 */
> > > > +	if (!viommu)
> > > > +		return 0;
> > > 
> > > Minor nit: I'd be inclined to make that check explicitly in the places where
> > > it definitely is expected, rather than allowing *any* sync to silently do
> > > nothing if called incorrectly. Plus then they could use
> > > vdomain->nr_endpoints for consistency with the equivalent checks elsewhere
> > > (it did take me a moment to figure out how we could get to .iotlb_sync_map
> > > with a NULL viommu without viommu_map_pages() blowing up first...)
> 
> This makes more sense to me
> 
> Ultimately this driver should reach a point where every iommu_domain
> always has a non-null domain->viommu because it will be set during
> alloc.
> 
> But it can still have nr_endpoints == 0, doesn't it make sense to
> avoid sync in this case?
> 
> (btw this driver is missing locking around vdomain->nr_endpoints)

Yes, that's on my list

> 
> > They're not strictly equivalent: this check works around a temporary issue
> > with the IOMMU core, which calls map/unmap before the domain is
> > finalized.
> 
> Where? The above points to iommu_create_device_direct_mappings() but
> it doesn't because the pgsize_bitmap == 0:

__iommu_domain_alloc() sets pgsize_bitmap in this case:

        /*
         * If not already set, assume all sizes by default; the driver
         * may override this later
         */
        if (!domain->pgsize_bitmap)
                domain->pgsize_bitmap = bus->iommu_ops->pgsize_bitmap;

Thanks,
Jean
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
