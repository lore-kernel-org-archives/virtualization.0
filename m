Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4C2127E0D
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348361; cv=none; b=GJa175D3y+SnhuJfo20g6jyjw7ckrG/7BFKFTruJEUJ5FuxFuNpvOZYVoAl2cP8CtlSolBBKwWufr68xn6nJ+8x6jSV+X0SUwicrvwDS8XvOhjRXbBmQ5WAvOHjf6vV4oMwhmxBXlNBrURKOVlIWB62trWBCwu6WrKIxepAzVWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348361; c=relaxed/simple;
	bh=S3PWVcPLr1dX8LF8lbNqL9BTLtoY8MY8E4uSnFJY7DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lppQA4eQ4AP/qqzAcr3nvJy+XNps6R5QMBCvvAE1s+5Ejd/q1pIVwi1ge8np8b/bCrZ/t4IEdbowyDxW0tz/O7JKq7Z/LzKSaY0Sy8nKH2SYGv954tWgAPBZvody3sgit6zhJLGrahJr97cfTQ8olT+XSeF3WzteO2Vhrt5MYec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=fopMwLDk; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fopMwLDk"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1457B42AF2
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 13:39:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4rTPsjEuroBa for <virtualization@lists.linux-foundation.org>;
 Fri, 10 May 2024 13:39:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::830; helo=mail-qt1-x830.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 00E8140102
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 00E8140102
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fopMwLDk
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 00E8140102
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 13:39:18 +0000 (UTC)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-43df23e034cso17230971cf.0
        for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 06:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715348358; x=1715953158; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S+RTUECXr8LV6dsVCr+XO/1bNGoM61WJWMM3wIZuHWM=;
        b=fopMwLDkGrygvtV/t/1clrIhzwQMZdyHnYRQMYTbSOE1T1o1xEH/MGPOD3gmRzFf63
         q5JDI/jiy/crHylDgWvkgg2hoGJukHYqUD4PeQGNJ5BUlAv28XyePz5MqJ6dqXhOPPEW
         kAetYZpzIWzaWDQKxmfLBWJvP1d+C0VlkMOnct3tyheLFWYvM0GZShGV8XVpp2gpyBz9
         I0F5jsdWhZpIKYeBhKXSUoEscbKkIov+L7XYhELNppwv9nu6wVxbPEA1i3rhPTjZl1Wc
         5CJ0usQDFVYTyrkmU6z0QnvtXuy2gnKktD7Ghkdgu68bBABSJznrK1CzhxL+70MJkFNM
         liBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715348358; x=1715953158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+RTUECXr8LV6dsVCr+XO/1bNGoM61WJWMM3wIZuHWM=;
        b=gPBeyXNbpy5n3aKJ9LASXNXNHZ3uR6MefTFKH42Ar8qd/cKwHR5zopO7nWtWEFrpPp
         dy3XuRen/OSGaDVxiQWeCDrOjO9hn5T7o5rjciDiFXz1oAQxliUz7POSlH2dmfFg+Tw2
         hhntCMYPeHOy7zeMNoITDJK4jnvgwq0Ou3iDHTq6Y9Lj3lZ3Dt81DBLD15n2UuZHJW8R
         GaQm1WiljDl49DKHnG/jWb39QuqJ/qh5bh8eMe1gX1RqRO5rvwBVn31DaGLE8wd/Y6GB
         bJHIVb7dcYBtvRaEFAk3uDhkNFwxyMhbT2c2gaC1Db2FQm0f8Yfq4DfwTksJN6Qo+uwW
         BIdw==
X-Forwarded-Encrypted: i=1; AJvYcCWhxwIdSOHpGW/35ZaJSj8dt/omamyO4D8VWDSta75JUz8GZi9jaB/sQXBEc3lCEe6wltzQwq9nLLW16y5qkF92yYqhxBx3H6olxYmtAcv04UfkMIynv5avEg==
X-Gm-Message-State: AOJu0YyPwn1h25YQBFcjAKUjG29OG38Z9UcTwKyZNWd0HF6/CK/soCCy
	khTFE1viu4JXZaQNy3fqVSlcJOUOe+ArGKIrPuCIddYnkH4dNuQmf9cwHJKcNFk=
X-Google-Smtp-Source: AGHT+IH6Xw8gGuqZr95qyqNM0r9axJP/CbWZNxoYFGO4ShQvgevQy0mPDi2AqZ8yxbLD2P81pSHTKA==
X-Received: by 2002:a05:622a:1988:b0:439:baf4:619a with SMTP id d75a77b69052e-43dec29796emr107215871cf.22.1715348357837;
        Fri, 10 May 2024 06:39:17 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df569ba65sm21354511cf.70.2024.05.10.06.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 06:39:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s5QSy-006Cvp-GK;
	Fri, 10 May 2024 10:39:16 -0300
Date: Fri, 10 May 2024 10:39:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
Message-ID: <20240510133916.GX4718@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-7-baolu.lu@linux.intel.com>
 <20240508001840.GO4718@ziepe.ca>
 <065cfc43-b164-4817-9be7-8f37585742ec@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065cfc43-b164-4817-9be7-8f37585742ec@linux.intel.com>

On Fri, May 10, 2024 at 11:20:01AM +0800, Baolu Lu wrote:
> On 5/8/24 8:18 AM, Jason Gunthorpe wrote:
> > On Tue, Apr 30, 2024 at 10:57:07PM +0800, Lu Baolu wrote:
> > > diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
> > > index 13125c0feecb..6357229bf3b4 100644
> > > --- a/drivers/iommu/iommufd/fault.c
> > > +++ b/drivers/iommu/iommufd/fault.c
> > > @@ -15,6 +15,124 @@
> > >   #include "../iommu-priv.h"
> > >   #include "iommufd_private.h"
> > > +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
> > > +{
> > > +	int ret;
> > > +
> > > +	if (idev->iopf_enabled)
> > > +		return 0;
> > > +
> > > +	ret = iommu_dev_enable_feature(idev->dev, IOMMU_DEV_FEAT_IOPF);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	idev->iopf_enabled = true;
> > > +
> > > +	return 0;
> > > +}
> > I would greatly prefer we remove this from the drivers :\ I guess it
> > is Ok for now
> > 
> > Doesn't this need a counter? We can have many fault capable PASIDs?
> > That will get changed in the PASID series?
> 
> Okay, let's design this more gracefully after the PASID interfaces are
> landed. For now, we assume that the device driver will do this.

Well, for now to work the device drivers do still need these calls.

I'm trying to get them into NOPs in the drivers so we can remove this.

Jason
