Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A583190468
	for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470139; cv=none; b=mFqLjddzxoEyufCZYZP9gL8Eu/DnqfmFXKsgI9xN2a+IJMCHhYv0fupgQ9sPiR6eyAIngPQFEPne9Tnll5xHhfZUtllQQSnkWsE5jSplEtm+3gXhOtDoghEscS51YkgqeZaE8Ug/h8Hn8aeNuEoLD9PJxiysmFzCbdzzdEmRPbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470139; c=relaxed/simple;
	bh=d0kEcihBGsGD5nDyvWyTxRr8mW/Cnur/oqUPU7wQLd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ctK+LWetxtyQQ3MmJx3h2h3argShesybT1UR7RG2q1emFzygSRBeaKO7gPUgjrKLRSoi8HxTuk7M1qVUPORPbsiDeRSpvycOa/92ccn+2jh7g+ycQbebL09jNHuoU2uhrVobRv7yXR3mdnHgEX9/vPBo3iGmYeUaBL/lxua9TpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MkN61CqB; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkN61CqB"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43690d4605dso8313185e9.0
        for <virtualization@lists.linux.dev>; Thu, 13 Feb 2025 10:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739470135; x=1740074935; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tjhyPWW7IENWta5YWXnWXfdvibFoyaw+P8ehIpKlekY=;
        b=MkN61CqBaMFCT7atWsBuuWNfk8XVPrALwhO5MmUq4Pw2Zn4zexfCmErTKMQtwFnRcn
         5mfL45mrgtspniq6i2f0AwXGXhIKxA4wDyc869qtX1F9WWF/W0Vo3A+/w6Nb7Jdz1foZ
         BeWuNzOh/g8rGSSLi5rUdEe+p19FvZOZcfidnszKg6LkiAgpDmn6pxNnl1CfXlgVJ1ad
         mGtHupVOrkrPvr9+npTrV3HOZETLHFfEVE32AkJqTHuBbFyoN2OVnaigVN5ozcbOl+bC
         5khZVB1VotpAj4rSkwWWBL4knraUGeMnarDVOSXiUE3/SDt2hSN2vt/O1Oi6sdGFErPt
         db6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739470135; x=1740074935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjhyPWW7IENWta5YWXnWXfdvibFoyaw+P8ehIpKlekY=;
        b=GY/elW/JvhQit2XfX4WKpAALV9zMw59MgI/3cDg0da6aFiCoJrfo8rmV3A2CeO0PAV
         e83PU6MQfVT5kQXNc851EfQnqQQcfNH1/JG6V50J3n2pGDQ+xfmGW4Ox0iwbpxxPcohY
         xj14PtXiADgqyc6VRWpxct46PsxWMamMoAPcwljXBOf3s5f+9YhV+C0i60LTyaR4DGMn
         4yHbmAkYGx3j0DgDNz9Ur//imJwMvVKvryGoFKCSlqS/t38WkKCi9uA875RT5waLDQAI
         tBsshMtWfYOtW9tzbexGnFbxLmkZ2C4rGzS/vCOqqn0BgzDy0GahpC8xNZ0ZC8qRDrET
         v5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbAL9J04uOSSX32CGv3SFp7yrNRW/40CeDa13lFDak6VmPEdgkHEiBP1g2Fda6y4G8tQqFL2yM3Om/nZE3CA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0yl799WSBp3NHoZRooZJ4ImrP2HvU2K1raMH4LwPeuxF8vQyw
	PrsCXURC0Q5bxEiQdJSzWpgw7VtoXbYpetC5kFFNfMcLaWYxNo/sBcLANIvcSPM=
X-Gm-Gg: ASbGnctpktR+X50Tc5m9EAHNXLD3gjL1JAJYEKTOxL4Vn0iTrDALVUSC9xU9SCT5Era
	DD10HRCgJYN4iW7TJEjjFk1sYN/vZcfPaSL8L0ktLdPe4z0BNaYcR578vptVqx3HdO7plnGThun
	3yA0CIkMyQWu7GCIzYiySK5vVZHN43zSk7zHD3CoXaIVgPYAU7AFTBckwsLyRYQ0dWCvFhbYriN
	xU6lSJxnV3WKXrLrRxj3keLebg4AdKFpm8hCh6ne3P067nRRUWevv6sbJ0VMzuytfoFoUutrE29
	o6XHK4OoQlXYog==
X-Google-Smtp-Source: AGHT+IHBorq/0LkWz12FFQh6I+j1iy+1Q+ZmebH36eKHS+Am0JM2CGK6dnXP/JraGzsTpnKadO9LAw==
X-Received: by 2002:a05:6000:2cc:b0:38f:2a53:1d78 with SMTP id ffacd0b85a97d-38f2a531dbbmr2040183f8f.10.1739470135465;
        Thu, 13 Feb 2025 10:08:55 -0800 (PST)
Received: from myrica ([2.221.137.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439618a9970sm23843215e9.33.2025.02.13.10.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 10:08:54 -0800 (PST)
Date: Thu, 13 Feb 2025 18:09:19 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: jacob.pan@linux.microsoft.com,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	"zhangyu1@microsoft.com" <zhangyu1@microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, patches@lists.linux.dev,
	tina.zhang@intel.com
Subject: Re: [PATCH 3/5] iommu/virtio: Move to domain_alloc_paging()
Message-ID: <20250213180919.GC243081@myrica>
References: <0-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com>
 <3-v1-91eed9c8014a+53a37-iommu_virtio_domains_jgg@nvidia.com>
 <20250212112235.714b0a14@DESKTOP-0403QTC.>
 <20250212233053.GV3754072@nvidia.com>
 <67ad876d.170a0220.3c21dc.85ceSMTPIN_ADDED_BROKEN@mx.google.com>
 <20250213094601.GA243081@myrica>
 <5irmuy6xwrjsrdjy7tmfzlnotxqdoqagjdsdtqjrrit673zaka@r43nyvc5gcyf>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5irmuy6xwrjsrdjy7tmfzlnotxqdoqagjdsdtqjrrit673zaka@r43nyvc5gcyf>

On Fri, Feb 14, 2025 at 01:03:43AM +0800, Yu Zhang wrote:
> On Thu, Feb 13, 2025 at 09:46:01AM +0000, Jean-Philippe Brucker wrote:
> > Hi Jacob,
> > 
> > On Wed, Feb 12, 2025 at 09:47:23PM -0800, Jacob Pan wrote:
> > > Our code and backend support are still in the early stages, that is why
> > > I am attempting to convert virtio-iommu driver to iommu_pt. Not sure if
> > > anyone has done the QEMU part to support VIRTIO_IOMMU_F_ATTACH_TABLE?
> > > @Jean @Eric Do you know?
> > 
> > As far as I know Tina worked on this most recently:
> > https://github.com/TinaZhangZW/qemu/commits/virtio-iommu/vt-d-pgtable/
> > https://lore.kernel.org/all/20231106071226.9656-1-tina.zhang@intel.com/
> 
> Thanks a lot for this information, Jean.
> IIUC, these patches were trying to add VT-d IO page table support in
> virtio-iommu, but it is not based on Jason's generic PT [1]. Just wondering,
> does anyone have plan to do the incorporation? 

I'm not aware of anyone working on this at the moment. Something you will
need for a portable pviommu is a library that manages PASID tables rather
than page tables [1], because the Arm SMMUv3 arch only support assigning
PASID tables to the guest. Alternatively you could implement opaque PASID
table allocation via host calls, letting the guest allocate GPA space and
the host manage the PASID table, but that idea didn't seem very popular at
the time.

Thanks,
Jean

[1] https://lore.kernel.org/all/20210115121342.15093-1-vivek.gautam@arm.com/
