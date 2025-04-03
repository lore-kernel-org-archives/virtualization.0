Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F2E1A5B8F
	for <virtualization@lists.linux.dev>; Thu,  3 Apr 2025 23:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743722783; cv=none; b=EHBXlOD6YcDfM4+ws77S5vVFmGQuMCerdie1CGjGktodQkMrtSnEto0xwBvzVcyxt/LOSuoARZhGiwxtk6QK400hRFE1T8oUrZYetRaZg/+ALPaBVi4u/KmzQcaC5BZRpjQzKtQgjFX/uZifciWpKHKzp4LH4vOzzlrct3kDQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743722783; c=relaxed/simple;
	bh=4UzC/VLVd7ky4BarzKv5YEItSxNeADmRgcM+DEoOJYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mmq6iYArynu/MeTi61UFkbLqNZN9OeV7QWliEYUtF8C358SacFAB8Vpf89UUXcuo8ctVNJjIlRWWLfVLfwbiNnu658danoe4VXyqhqfziNxx/9j+FJ8GItZif/CYOSTcqG8zgLYQMr2stwL5NBSrPQ9UCEcagxiNiGJtUTJ7ytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dBhNZfhf; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dBhNZfhf"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6e8ffa00555so12907566d6.0
        for <virtualization@lists.linux.dev>; Thu, 03 Apr 2025 16:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743722780; x=1744327580; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0dnmrlpBGeFmqcu0Pq2phWVQb3k+1PXSaVmeXw2bjGQ=;
        b=dBhNZfhfoBhLusUVCBjCatLaMjhVpZV2gwEhpWvjnKgzogs/SkNUieYntOD0Inkm13
         cKD1tfsAg6OKzQa5I4Fil2J0woKNkT21zOyKsXq6Puv7eHJcthk+lC6XWbSYaxkeCKWm
         f2HhAfPM7Nevku9vA/7NzIl+vtuXxMW0fgCBRweuZ2zyeG3Yb4/zgoCSHpslGMT5qvIH
         GRAE9LOTN+bdsyCUrKYXRwm1OEwcI+WWbdHDTiPyzMJK1/uHCx8WJROf9lsiDmUd/CN7
         hfcwHbRP8r4oEbJZArLei5hJSRXQzxUHGbDDD1+WTnnUy4pSZmEwIZ6OOqZ6aNvE0nGA
         bS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743722780; x=1744327580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dnmrlpBGeFmqcu0Pq2phWVQb3k+1PXSaVmeXw2bjGQ=;
        b=FotZPUQH+Fj1JlHiCewT/J5ACUDccijz3uksl//XbOIlvBD5bT298HG93nMrcvsSLN
         TyiijLeVTQXe/5NtyNAU/GE1jXutDuNPdgKskcPJGaswHIVnjyK+7s4C3TbofT2HyYLU
         zhgQPpiVGQdSVw4jULspY77AFQjvbLnGMzDcYNmcCJu8iAOXsbda0zEUhLwUTzaAnXSU
         LcKWirYCI0fr4/QgPIayxjSmBcHYFwdlH2+fLl1+gbb2sKl9rTqN+17AFwPHjBmUDHV7
         maZfeCvG60JKLoFsKPROFicwUVDgdQf3sXI8WVi/FwSaVWWkuvEOqtB6aBxSxUUIpbrB
         W8zg==
X-Forwarded-Encrypted: i=1; AJvYcCXayfxi4w68hqjvBrUjZBfiKQPy8Xn0fYGY0nC3rpf8FHTb9VX5PHsztW9e2e3J6U+ySxZpLS+AfqzZfqxNmA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNnuMKEQDqLyGDLc6UGdCu0aIcTUebLQ9YbnbgI4IGDLIiSOTN
	dXICdLC5sr0MzF7X6S6jLEzq8Q0Kvux8E6TKOXwskCQgc/QhtvHw8QQFK3w6C38=
X-Gm-Gg: ASbGncvzEjxH0uyDrlQ49o3O5nnD6toZr/PVZ0ogx+RKmTnMJ9lbhEkDY9rwRQVTwAH
	XJOa3WLIY+xrDkWi7hbq7jNAGNhHoBMaPgJcDz4aVyLTPjcPM7ZWdb81b4wxFRUa1GGtHOSxcQf
	ut6XPwsLoyrVm+sWdlVKetzfBE33J7bSYWsj5gYJVo41HOZhAQWKejHwz3fNO8iIsXjogffk9ie
	iW2dEJ/VXh2Gf6kO+AZTjQfiSma4fswDsqzP+wwRLftT9I7No4SNNnk9nCu8oURRH4iFvrYTlon
	2foAvy50MWj3W7S6Zo801MVq+/eampBxtbK9Rzslms7yFoMCEZNbrY3593PUn37XdmJlsNZSGA9
	VUtxE6zZER5mBnvgiRd/grPk=
X-Google-Smtp-Source: AGHT+IFibU2LV4UUp0WQxSSCxFeutQYAvG/Wra81FTOp1ufuIAX96AWEwxKC9ZZdCWczg5MiXC+AeA==
X-Received: by 2002:ad4:5e87:0:b0:6e4:2872:45f5 with SMTP id 6a1803df08f44-6f01e76f04fmr21453616d6.25.1743722780451;
        Thu, 03 Apr 2025 16:26:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ef0f1652a3sm13173396d6.119.2025.04.03.16.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 16:26:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u0Twx-00000005TkW-0sfD;
	Thu, 03 Apr 2025 20:26:19 -0300
Date: Thu, 3 Apr 2025 20:26:19 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: code@tyhicks.com, devicetree@vger.kernel.org,
	eahariha@linux.microsoft.com, eric.auger@redhat.com,
	iommu@lists.linux.dev, jacob.pan@linux.microsoft.com,
	linux-arm-kernel@lists.infradead.org, vijayb@linux.microsoft.com,
	virtualization@lists.linux.dev, will@kernel.org
Subject: Re: [PATCH 0/3] make MSI IOVA base address and its length
 configurable
Message-ID: <20250403232619.GA681099@ziepe.ca>
References: <20250131003618.GB2296753@ziepe.ca>
 <20250403193458.158085-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403193458.158085-1-shyamsaini@linux.microsoft.com>

On Thu, Apr 03, 2025 at 12:34:58PM -0700, Shyam Saini wrote:
> Hi Jason,
> 
> > On Thu, Jan 30, 2025 at 03:21:37PM -0800, Shyam Saini wrote:
> > 
> > > Unfortunately, it is an HW issue.
> > 
> > Well, that's pretty bad to have built HW that can't DMA to low
> > addresses at all.. But OK.
> >  
> > > Are you okay with this passing custom MSI_IOVA via DTS approach ?
> > 
> > It isn't up to me, but I've understood the DT maintainers would reject
> > this as it isn't is describing HW but just a random Linux software
> > knob.
> > 
> 
> If i understood correctly MSI window IOVA is hw property, if yes
> then it should be accepted by DTS folks, did i misundertstand that?

It is not a HW property. The MSI window in the SMMU is entirely up to
software.

Yuor HW proprerty is the regions of IOVA that do not function in the
SMMU.

> > I think you should make selecting the sw_msi dynamic in Linux.
> 
> My understanding is that if we have to make it dynamic, we have to
> use iova allocator that would need iova_domain as a member of struct
> arm_smmu_domain, and allocate iova for MSI window dynamically using
> alloc_iova() in arm_smmu_get_resv_regions() is that what you meant
> when you mentioned selecting the sw_msi dynamically?

I would not structure it like that..

The simplest thing would be to have the SMMU driver have a list of
potential addresses and select the first one that does not intersect
with the non-working IOVA ranges.

Jason
