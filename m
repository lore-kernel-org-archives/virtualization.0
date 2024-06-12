Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26CB17C20F
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718198393; cv=none; b=uzTz4mUKyI55i/Zvh5VLMF03IWZI0/dVHr9/s/5f+9dlYlatxGXcJVm+v+/CoWdookHDOp2qOlM2SOKd3PRwHNPUtcsyDl6+R3xvYx/eYk9sTeTbR6jOYr+svpKx2S6HCauFXAFJPT8DyGaLVcOYetRXepJGhbLAojfuze/P2VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718198393; c=relaxed/simple;
	bh=30kMMEM/0RGIoM4AKwXZ6d0eDjEm1u/8hrr3qBtEMls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETO6nvY5hDozeUYgN0hjlMGk7wsFqSaSvWNq9A6yyH5luj+lEDCNdUgoYqNFbdMr43vARkiRrDWkDXW36Nrku0JvWvkv5kjKjHEtU8JP2t7TouzJ5JoJ80/2/d4/jX9X7tQRx3slu70svdMbX03WGHEOZ9od6p706+tjqggaJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Uarz9UoZ; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Uarz9UoZ"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 706CF402B0
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:19:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_dXGSOMTvdV for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jun 2024 13:19:51 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72b; helo=mail-qk1-x72b.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1B48F402C8
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1B48F402C8
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Uarz9UoZ
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1B48F402C8
	for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 13:19:50 +0000 (UTC)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-797e2834c4eso75161285a.0
        for <virtualization@lists.linux-foundation.org>; Wed, 12 Jun 2024 06:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718198390; x=1718803190; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WIK4gueTNICdj2uOTyUO46d7/vRhcgixUddDleOmgKI=;
        b=Uarz9UoZHQa7FeiXaqEfinpjXynO2NSo1tIU7yY2B75F4l9zTHkic3MoEuOfYJq4f1
         sqJFRHQHFucPS8ji/yhxnwoq/z4heyTyfuWr1zKCISOG01KXZdylek8vyVrGJVyQtB0N
         P0JM8SZhAc6Vx68TWxsLG7bUa/9ludqGsvfMt3DWAldLUMw5dT5KRch/Nb/bBuPCm2m/
         IEhhSyvar+6ii7946t8Jl53Ny6wdSvTqID0bFTepvX1VJk3/6e1pKebAREf6BRddQlVd
         7mAPaIWKn9CkWJqTJ9QBfhsEHY4PPdKwmUN+R+LPAp9Fv6ZHQmwuGiy2K/SARNLIGZ2T
         AIVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718198390; x=1718803190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIK4gueTNICdj2uOTyUO46d7/vRhcgixUddDleOmgKI=;
        b=Ibcxp7q0L0TtnqZq5V1pS9uelFFLc1yrdNzxEMqWHVwBCGsCXG5Gs1z87nymAQl7xY
         KsT7B80M9wrDOIigRg3lEj/4BHZhi12mC+tHOm8b32/dpvxxwTMmQb00WXKMY7LN/gBK
         bpgTat8QLMNjHHyCv2xFrxHhv2LSlSr6nO19r2rgc+4t36zG0/RWndG4XzQK4GNafUQK
         O0IFh1pBTkG7ho3WDf61MFJUZZwihCWYvbfr2Kt+SFNWfEE/KsvIxo/aT/PAfdkeDkST
         MEd5Dn2BBGVCKERpG8XwrgmveZPc+Nk3Q/qflNJIXHpMerz0riTuFRLDKb4iWR0DCWJW
         Rg5w==
X-Forwarded-Encrypted: i=1; AJvYcCVk5IJR8n2I9HSr3gPFzwwXHbc1lVf3zlD+dKmE8GyW3y3c1H40/wDmjQhWbNfgyuW7qxu8FQxhTyLO+/q+rau9QqAQGRemTu70DfilHZwQMvSouWyh3K6x8g==
X-Gm-Message-State: AOJu0YxNLP/ORuMha7DoHI3gZTchxGbUfo6Y+TSt07ba1v+IS1fBZLa+
	vUGa+XPIZNx2sB6nWVjW4AKYBKFoKYcf0iB2X7gxABTqZwD6tihqK7LYw0kI0eI=
X-Google-Smtp-Source: AGHT+IHIr3wVyaXMObF0gIHRTDzfj+r/v0k7L3AOz0PBBlBNpukbYjT9PBJBIvgFmfGPvox7DSPLxQ==
X-Received: by 2002:a05:620a:3184:b0:795:4e3d:2a55 with SMTP id af79cd13be357-797c2dd5e40mr960856185a.28.1718198389310;
        Wed, 12 Jun 2024 06:19:49 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.89])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7955bffcb4esm344068285a.131.2024.06.12.06.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:19:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sHNtC-008rr0-Eu;
	Wed, 12 Jun 2024 10:19:46 -0300
Date: Wed, 12 Jun 2024 10:19:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
Message-ID: <20240612131946.GT791043@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3ee41c29-46bb-4897-9e93-5982c43736cb@linux.intel.com>
 <BN9PR11MB52764D7EF1EEDA95B694E8B68CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52764D7EF1EEDA95B694E8B68CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>

On Fri, Jun 07, 2024 at 09:38:38AM +0000, Tian, Kevin wrote:
> > From: Baolu Lu <baolu.lu@linux.intel.com>
> > Sent: Thursday, June 6, 2024 2:28 PM
> > 
> > On 6/5/24 4:28 PM, Tian, Kevin wrote:
> > >> From: Lu Baolu <baolu.lu@linux.intel.com>
> > >> Sent: Monday, May 27, 2024 12:05 PM
> > >>
> > >> +
> > >> +/**
> > >> + * struct iommu_hwpt_page_response - IOMMU page fault response
> > >> + * @size: sizeof(struct iommu_hwpt_page_response)
> > >> + * @flags: Must be set to 0
> > >> + * @dev_id: device ID of target device for the response
> > >> + * @pasid: Process Address Space ID
> > >> + * @grpid: Page Request Group Index
> > >> + * @code: One of response code in enum
> > iommufd_page_response_code.
> > >> + * @cookie: The kernel-managed cookie reported in the fault message.
> > >> + */
> > >> +struct iommu_hwpt_page_response {
> > >> +	__u32 size;
> > >> +	__u32 flags;
> > >> +	__u32 dev_id;
> > >> +	__u32 pasid;
> > >> +	__u32 grpid;
> > >> +	__u32 code;
> > >> +	__u32 cookie;
> > >> +	__u32 reserved;
> > >> +};
> > >
> > > with the response queue per fault object we don't need all fields here,
> > > e.g. dev_id, pasid, etc. Cookie is sufficient.

Wait, why did we make it per object? The fault FD is supposed to be
sharable across HWPTs.

> > I prefer not to mess the definition of user API data and the kernel
> > driver implementation. The kernel driver may change in the future, but
> > the user API will remain stable for a long time.
> 
> sure it remains stable for reasonable reason. Here we defined some
> fields but they are even not used and checked in the kernel. IMHO it
> suggests redundant definition. If there is value to keep them, do we
> need to at least verify them same as the completion record?

They are not here for the kernel, they are here for userspace.

A single HWPT and a single fault queue can be attached to multiple
devices we need to return the dev_id so that userspace can know which
device initiated the PRI. Same with PASID.

The only way we could remove them is if we are sure that no vIOMMU
requires RID or PASID in the virtual fault queue PRI fault message.. I
don't think that is true?

Cookie is not a replacement, cookie is an opaque value for the kernel
to use to match a response to a request.

Jason
