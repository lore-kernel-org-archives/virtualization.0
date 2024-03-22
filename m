Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A858F5DF24
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711127055; cv=none; b=hkuAgYjJpPoi7uoul3HQIbvbHqD55CbJj3fcWItPHRR+Oahd2N+AxlBN8ktXvroKNt6qHBpBtfmeCKrHP5xUjOl7I+Jd7uGklsmXBnNyvqu6iVhm+Hd/jSBW9l3MC9wqoAZDhokSvjXffJwwEqj8sTBAPAL8nbmSW/OxEaZwVIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711127055; c=relaxed/simple;
	bh=F2cON8G466CEiB2xctEBotK4ZUZCOX8kUGGaoxBRHl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNvVQxJlu16ybgyu9SlvuknHwk7X7xVxI6OzaG2mmyu3Q5/L4JXfUOs3n4U6sq7GE3EM4UOBLCLOq3Wc8JVXKMQPY7wgZDWoodeElFB7Hha+2mXjEUybWaxn8sfKc3NgMrnkgp2EyMLWnA5PuESFEqFc20YtlK6dd7TTlXJZsPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gKploWqT; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gKploWqT"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A04E60697
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 17:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13N3W95ucxHG
	for <virtualization@lists.linux-foundation.org>;
	Fri, 22 Mar 2024 17:04:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::72a; helo=mail-qk1-x72a.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3446360684
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3446360684
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=gKploWqT
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3446360684
	for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 17:04:12 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-789e5021703so159196985a.0
        for <virtualization@lists.linux-foundation.org>; Fri, 22 Mar 2024 10:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711127052; x=1711731852; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6bmTLjYhpzrW7g0IUEWDDdCG7VehUoT56RlgrSoKr94=;
        b=gKploWqTqDczlN65WxM5msEKY5Gdf3In+To+us0Z1Zyy3sPuLoq2PiLJGqg0rlMqvp
         K6vbyD/+4/71CmZJCAFo3ucsae4/dWy6csAN798cX4skxKVseUMpJdsCjwuyva3eW2Hp
         KXZ6Pp/mhWPwFyVfsfGC0N9qlve8QldI/o1wE2opLzmpAyR3lew4YD/Er8qk8eBlKpt3
         +HfevGRIN5NRUjiB08RatiykYYTqUwVT5xzNeVClbvtY7dx7bwdrv+jKks6FmGImVBnb
         3CADUBTNar2da45iS2kgLNjQun1GITY69jeGYzp23+URsKImyY7dRBgel1eMLV8ffjnm
         zzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711127052; x=1711731852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6bmTLjYhpzrW7g0IUEWDDdCG7VehUoT56RlgrSoKr94=;
        b=hn+yTcdesUv39jHMlHw5xUO67x6g8LHVVGWRxeTEZhf03Kjl5HY7aXbnlhjw5uS0Bj
         TXIwM2XakNKNlwcy9+J0/APyFnZy/IV1p6qwbx03OKMypoDcPaHrpee266ulzp0XRnje
         GI4ajRiPL3SFyNafb7FeBd1fmu3Tu/6vZJ4nasYDh1t2V9n2gXWmSlBBge11sxl00upW
         icEGIB19yV1qx02W+HErmCjkobMvWlVv/9dzqfMv/yHeKe6cpxtt5Hm/F7aMOt8VR3vH
         iRmwMeWqegr2srajt3XhOvCGQKhBnXr4ZJW4ECI42q7pHd4MHY7kcFJ+1RZfSWd+ky0n
         BYlw==
X-Forwarded-Encrypted: i=1; AJvYcCXcbiDUOPYOAI8lc/h3fKS0580/sbAu8hW5ZmPeAy3ZAeOQCMtvmw9yzpAgRcCo0OuGU/p+D9HLMZCsE8OB09ph/A/iuwrvi/uHS8i1UB3eyuudMMs4WcVlgA==
X-Gm-Message-State: AOJu0YzXG//jRMsfmw533OorBZJj2tkDO1Re+5Z99nXzc9LtvxPSwBOL
	2+pPInIjxcbkpYparAF6ZfoDMFMb9yzWkO9tu0J34h4trJmXGBDXn3Pcf6/vlFw=
X-Google-Smtp-Source: AGHT+IGCuCLf0r0lAOyGbCQQgecN3nqXlLc/lQ8IcmAc2LgzDweXJnwWqJ+Euwk9ABhKAExpPSSADA==
X-Received: by 2002:a05:6214:1250:b0:696:47ea:df2e with SMTP id r16-20020a056214125000b0069647eadf2emr2633333qvv.23.1711127051828;
        Fri, 22 Mar 2024 10:04:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id q15-20020ad45caf000000b0069124066c2fsm1223742qvh.140.2024.03.22.10.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 10:04:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rniJO-00CS0w-OK;
	Fri, 22 Mar 2024 14:04:10 -0300
Date: Fri, 22 Mar 2024 14:04:10 -0300
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
Subject: Re: [PATCH v3 3/8] iommufd: Add fault and response message
 definitions
Message-ID: <20240322170410.GH66976@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-4-baolu.lu@linux.intel.com>
 <20240308175007.GW9225@ziepe.ca>
 <43ef5e3f-8a8e-4765-8025-b8207fd05f91@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ef5e3f-8a8e-4765-8025-b8207fd05f91@linux.intel.com>

On Thu, Mar 14, 2024 at 09:41:45PM +0800, Baolu Lu wrote:
> On 2024/3/9 1:50, Jason Gunthorpe wrote:
> > On Mon, Jan 22, 2024 at 03:38:58PM +0800, Lu Baolu wrote:
> > 
> > > +/**
> > > + * enum iommu_hwpt_pgfault_flags - flags for struct iommu_hwpt_pgfault
> > > + * @IOMMU_PGFAULT_FLAGS_PASID_VALID: The pasid field of the fault data is
> > > + *                                   valid.
> > > + * @IOMMU_PGFAULT_FLAGS_LAST_PAGE: It's the last fault of a fault group.
> > > + */
> > > +enum iommu_hwpt_pgfault_flags {
> > > +	IOMMU_PGFAULT_FLAGS_PASID_VALID		= (1 << 0),
> > > +	IOMMU_PGFAULT_FLAGS_LAST_PAGE		= (1 << 1),
> > > +};
> > > +
> > > +/**
> > > + * enum iommu_hwpt_pgfault_perm - perm bits for struct iommu_hwpt_pgfault
> > > + * @IOMMU_PGFAULT_PERM_READ: request for read permission
> > > + * @IOMMU_PGFAULT_PERM_WRITE: request for write permission
> > > + * @IOMMU_PGFAULT_PERM_EXEC: request for execute permission
> > > + * @IOMMU_PGFAULT_PERM_PRIV: request for privileged permission
> > 
> > You are going to have to elaborate what PRIV is for.. We don't have
> > any concept of this in the UAPI for iommufd so what is a userspace
> > supposed to do if it hits this? EXEC is similar, we can't actually
> > enable exec permissions from userspace IIRC..
> 
> The PCIe spec, section "10.4.1 Page Request Message" and "6.20.2 PASID
> Information Layout":
> 
> The PCI PASID TLP Prefix defines "Execute Requested" and "Privileged
> Mode Requested" bits.
> 
> PERM_EXEC indicates a page request with a PASID that has the "Execute
> Requested" bit set. Similarly, PERM_PRIV indicates a page request with a
>  PASID that has "Privileged Mode Requested" bit set.

Oh, I see! OK Maybe just add a note that it follows PCIE 10.4.1

> > > +struct iommu_hwpt_pgfault {
> > > +	__u32 size;
> > > +	__u32 flags;
> > > +	__u32 dev_id;
> > > +	__u32 pasid;
> > > +	__u32 grpid;
> > > +	__u32 perm;
> > > +	__u64 addr;
> > > +};
> > 
> > Do we need an addr + size here? I've seen a few things where I wonder
> > if that might become an enhancment someday.
> 
> I am not sure. The page size is not part of ATS/PRI. Can you please
> elaborate a bit about how the size could be used? Perhaps I
> misunderstood here?

size would be an advice how much data the requestor is expecting to
fetch. Eg of the PRI initiator knows it is going to do a 10MB transfer
it could fill in 10MB and the OS could pre-fault in 10MB of IOVA.

It is not in the spec, it may never be in the spec, but it seems like
it would be good to consider it, at least make sure we have
compatability to add it later.

> > > + * @addr: The fault address. Must match the addr field of the
> > > + *        last iommu_hwpt_pgfault of a reported iopf group.
> > > + */
> > > +struct iommu_hwpt_page_response {
> > > +	__u32 size;
> > > +	__u32 flags;
> > > +	__u32 dev_id;
> > > +	__u32 pasid;
> > > +	__u32 grpid;
> > > +	__u32 code;
> > > +	__u64 addr;
> > > +};
> > 
> > Do we want some kind of opaque ID value from the kernel here to match
> > request with response exactly? Or is the plan to search on the addr?
> 
> I am using the "addr" as the opaque data to search request in this
> series. Is it enough?

I'm not sure, the other discussion about grpid seems to be the main
question so lets see there.

Jason
