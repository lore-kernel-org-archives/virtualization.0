Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F7F20E029
	for <virtualization@lists.linux-foundation.org>; Wed, 16 Oct 2024 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092309; cv=none; b=LR9EQt5NjTxMihSjpNKIlppBwLksQ0zF7gifQ2jmhJrtTy8mQpJhxE8+llea0gpf6gYk/ndZ9SnNnxyRTsOVr6igUsMKa7xIo/CTMopMUrOjoYHZREGMjd6B1LPKup0ZaeWI7w6EjWTr1Af5ZEF9x92E3YK9eDFT2cNMGIAcoMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092309; c=relaxed/simple;
	bh=Gxz5OaGC+Qadp7iG3WP91/k0Dd/+X8K1vvRHRws4en0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j85acPRmi2m6zHtlb/pfo9eZbMhdDciehakYUQeNNIhRtO+D6e/ZQnZIeMMVUjmjYI7BeLbwiZl5+ACCPIXD3vwyu1LOCcnMgs5A6D+YPWiid82QYBKh7c4W9zfmFafOgvRainrR5znOEk92NzDbUwJYvvamHyr3I7y2F9bA7mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=U8VedeoO; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="U8VedeoO"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 051FA40461
	for <virtualization@lists.linux-foundation.org>; Wed, 16 Oct 2024 15:25:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8DRSpK6tEtiL for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Oct 2024 15:25:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4860:4864:20::29; helo=mail-oa1-x29.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B132C40158
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B132C40158
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=U8VedeoO
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B132C40158
	for <virtualization@lists.linux-foundation.org>; Wed, 16 Oct 2024 15:25:06 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-288d4da7221so1118320fac.1
        for <virtualization@lists.linux-foundation.org>; Wed, 16 Oct 2024 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1729092305; x=1729697105; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CjWIdbx6fjNxmaESEdgFKPth3aWiGnOIhiVNj6cHD48=;
        b=U8VedeoOs+jfPCjp1L4VmvuUd1AditMjWXyRPpDbWLNh7lzKokoWazUM7Ht7O8W0Lp
         0mxOkqDSAsBsgbo4KJWGqlO5SG32uZpNejyLuDZJusDyJQcLPXbtnNJavcx+v76cq5X6
         oFn91nxTJ+QfttgqLOTrK7iPglls1wnZd4/H/KfsGcC/04NzwZcAEklKCPOpBAtp1KoA
         +jM9WX+BTlTJ16oR2vPnhEfZgLPVIrwDjeshxyFCD18n6k82liHObqgEC+E1Kqdq/Syd
         GNrVD2IBQy1BedO2xYikIZktRYtaQCP4GDb584zsG7OfKxRFpMzm1JI2F72Te0u0s6uJ
         TORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729092305; x=1729697105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjWIdbx6fjNxmaESEdgFKPth3aWiGnOIhiVNj6cHD48=;
        b=fvziZSr5lYSXWodoOCCOoyKt3VIVaZk1HKpzXo1tH0D3HAJhqOJqnJ0K5i6kkcUNov
         H4OFErd6xMfi3A/Kw9FHEVSqsJzptVrQZxAi7ml9tFSxqKuvPOy3dOi04IQ4DXl+gYWr
         to9t3u7Y0HeEH8NLWQI4oYn2EHI3I1iUzOpW6AzgnbKVlM5dYMod0VS66XZ0/hH2iLHL
         HS8/Q5cQfMa5p5Kpex7oGFfj6AykhIF4baZ0GnibNmGqRjf0Y/EQ5WPVNLzU0OHlefHW
         5lQ2aVpPIjPh3dI9Wdpwty54Brn4QZgV7xJEui7A96hbDUu1k0ndYtA8m6OBHqwJd4e0
         jSJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUV3i8eFlNjk9HU4i4fg7rWPZ7wSMZrDqB9oLVMAdQFpqvUb95S+1Is6JjqPb00AyxwJ1CZDn7eYlgbDYJvBg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyDmkgNewZa7J9E2iTcV7szB0c7LCjh8XsjiQifDnhD1NFUd8vS
	xento4oNCPYMpt191GJICVwCg7pNbz3MjSXzq4CkoUHebantN/cl3Br7fmZm+Fc=
X-Google-Smtp-Source: AGHT+IHTbCtN3v7MBgWhJfsSvvyCftMb1j2RJtvVwpHEyVewjlSFT6OguCcs+kE/GdHA1PbG7MjK2g==
X-Received: by 2002:a05:6871:88a:b0:288:29ae:c981 with SMTP id 586e51a60fabf-288ee1146bcmr3961574fac.43.1729092305303;
        Wed, 16 Oct 2024 08:25:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b136395171sm197633985a.84.2024.10.16.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:25:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1t15tX-0008zC-Tq;
	Wed, 16 Oct 2024 12:25:03 -0300
Date: Wed, 16 Oct 2024 12:25:03 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v8 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
Message-ID: <20241016152503.GB4020792@ziepe.ca>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-8-baolu.lu@linux.intel.com>
 <CABQgh9EeKtYuu+vTTM0fwaKrLxdyC355MQxN8o8_OL9Y1NkE8A@mail.gmail.com>
 <20241015125420.GK1825128@ziepe.ca>
 <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABQgh9E+AnuyJgcM9tf1gEOUqcC_QSrA__Xha9sKYZp=NVRwhQ@mail.gmail.com>

On Wed, Oct 16, 2024 at 09:58:36AM +0800, Zhangfei Gao wrote:
> On Tue, 15 Oct 2024 at 20:54, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Oct 15, 2024 at 11:19:33AM +0800, Zhangfei Gao wrote:
> > > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > > +{
> > > > +       struct device *dev = idev->dev;
> > > > +       int ret;
> > > > +
> > > > +       /*
> > > > +        * Once we turn on PCI/PRI support for VF, the response failure code
> > > > +        * should not be forwarded to the hardware due to PRI being a shared
> > > > +        * resource between PF and VFs. There is no coordination for this
> > > > +        * shared capability. This waits for a vPRI reset to recover.
> > > > +        */
> > > > +       if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
> > > > +               return -EINVAL;
> > >
> > > I am using the SMMUv3 stall feature, and need to forward this to hardware,
> > > And now I am hacking to comment this check.
> > > Any suggestions?
> >
> > Are you using PCI SRIOV and stall together?
> 
> Only use smmuv3 stall feature.

Then isn't to_pci_dev(dev)->is_virtfn == false?

That should only be true with SRIOV

> > FEAT_SVA needs to be deleted, not added too.
> >
> > smmu-v3 needs some more fixing to move that
> > arm_smmu_master_enable_sva() logic into domain attachment.
> 
> Will think about this, Thanks Jason

Can you test it if a patch is made?

Thanks,
Jason
