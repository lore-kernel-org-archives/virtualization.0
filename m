Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A40831A56D
	for <virtualization@lists.linux.dev>; Tue,  9 Sep 2025 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433531; cv=none; b=QUuHOC8v+nD3q7I0UZovv1GRM1bB2/z/FMff63vwvepgRLOxpgbynKbxwKmoxnDxZPUhB/Nxw7e9rg/KKgWIrZBKOMAu+LOxphMUKGrHn8jY+/ET/nIWWRi1SCwJpP5NXnAR3yHDBVmoa0EiISX3Xov+YDDD0Gvr/oNiqDKCZ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433531; c=relaxed/simple;
	bh=bKYz3c9y+gNOcYf7TFJwhjWkpIADlCUKYQIpmt+9Y2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FAEZgXoD06DQQl9bGx6iserOXrOR+n7YImDwJNSHV1lZ2oHOjPGwZkU+xkFrexmV7tmxqVowy3AflKAe9x6vARXSRUpOXgJ+lmeosEKXQM5RyYXzdL2PzQ0q0IK4lG/iSDYKWcZhPnzfueUfa3pFDA4fq3A4d5oTOg3mPra2YCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IOA2cOYb; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IOA2cOYb"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-811dc3fdc11so245492385a.2
        for <virtualization@lists.linux.dev>; Tue, 09 Sep 2025 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757433528; x=1758038328; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xhvGZRaKvGOKbFuieB7cy8gqgC/YDYs/ewa6xCzMoyM=;
        b=IOA2cOYbpg/DtYwNKgDUjwzJ72Emah3NrU0acLCobbQxS5KHN965w37JaFjHfwfg9h
         +CuAIpPqkAZFn9rM3N5SgZNBooOvYHMmxEKWdMcisLP3fWFa8bVrTsQWxj6bp3X7NcJp
         /bZ4fauGogiXA9w1VIgK4tEVJvjg/iHda8dCaEbxZK1q9J5wLYaqVvnqPuWEp7B1xKgU
         J8gyuCfcwBF+/Tn5EAmAn11cTUke3B4ivv0KhjlPnXmwwnov35jUyO+QN8ynGoxQ5NaI
         KMjjXzFNT83+zahUtuGw6aMI1E4kyG9RuWe+WVqo1yPyM8MC88Z1Q031EXhQoePFOU0n
         YFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757433528; x=1758038328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhvGZRaKvGOKbFuieB7cy8gqgC/YDYs/ewa6xCzMoyM=;
        b=gUycadf36fA+PoCuPAriFQGp8C93wfjq1S4cpP52UzXr9u9BxDhlyB3GsKA1wDlP9W
         vUDArQhM/OflXD+DZnBjwvM+oJg08i/O09prqbX5oARrCM21eP320wZSdhjcCVn39VlK
         sEC7iBYCQj/8pCHNWoIObcnvhNu1kaOlB8Gm3TOIE13jcRS1xUHCnFuJll/QRJY7rJgL
         aPCW4lqlL3107JtG6KA5mfL6gH8cHOBMox1L2pX8CYFQPUzwOjXjc53Y1zgCl0sP/w4V
         +U9ROqxYnhSkO4ZJfu2NEtZifyWACOPWdxyURU0CR42NbjN2UngBu9GU1W0THf843NFA
         1pzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKpSVf36gzvUjzXYaE7K7XvgQyJQDBtOkUgwnP8WtXBfO2rgskdGe1hn6cn2Q3VntzLkBpPLw31ufi1lGnRg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCnPFMFEXclkNUXG+EdpjqkAHpuR2yABTOKQ9X/eiMMaEn2F4U
	sFW3YsyFOohDO6WTS659PXRJfUJ2mJ15HVaaFQC3qkxqLNOLRSaWFiJf64u7TYg/ylw=
X-Gm-Gg: ASbGncsLoWWkarJ0a8rQJaCfdZZydgHoyAgFjWGLrKGhaL9cSh2EUnZfTwYMYfqIRJ1
	w/lc8Y61BWxCDKC7RuVzF7klCEFWr6F5z9iNuOw42OTgWNqsQTeKeM3elPRL3XzP236c3ayVfc2
	vswV0jeJ1QLXHHNazMgX5kCm255aL4oBiy5h2uNMRmBQa+/x1yWkAmlFxxgTaAAPbXrAyP9bYPO
	2w5DGEl8TIVDRB5Smv/W7tZTbiOWr4+LNozy92jz09D86dob4cY7s5chsleHDUxdcSMs7D1/Cyr
	dSo0IV2Onxv8x2fHLdNcmT9g5UAolKPEkveUjpTiGEwi8j9C3XX09QGSlx2UpyiUoeoNK6dg+Q7
	A5DXfie7Q/ovh+C/0dYTCyw9BjziF9uSA/EnZ1E2VH+nkdQ8pblWrvuEW1dDEtC6voDXflKkTHs
	YljEY=
X-Google-Smtp-Source: AGHT+IHIkjBRe7yt4WbOZJ/YpK79iphLy2T8QoB+1HLpvRtSFAYohJmx9nvB2OQluCbq6HB69MOUdw==
X-Received: by 2002:a05:620a:4609:b0:816:638f:4ab0 with SMTP id af79cd13be357-816638f4eebmr916110485a.27.1757433528370;
        Tue, 09 Sep 2025 08:58:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58d4957fsm141532185a.3.2025.09.09.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:58:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uw0k3-00000003iHY-0OSc;
	Tue, 09 Sep 2025 12:58:47 -0300
Date: Tue, 9 Sep 2025 12:58:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: thierry.reding@gmail.com, robin.murphy@arm.com, robh@kernel.org,
	joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	virtualization@lists.linux.dev, will@kernel.org,
	jacob.pan@linux.microsoft.com, eric.auger@redhat.com,
	code@tyhicks.com, eahariha@linux.microsoft.com,
	vijayb@linux.microsoft.com, bboscaccy@linux.microsoft.com,
	saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	lizhi.hou@amd.com, clement.leger@bootlin.com
Subject: Re: [PATCH v4 4/4] drivers: iommu: refactor arm_smmu_get_resv_regions
Message-ID: <20250909155847.GB882933@ziepe.ca>
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
 <20250909154600.910110-5-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909154600.910110-5-shyamsaini@linux.microsoft.com>

On Tue, Sep 09, 2025 at 08:46:00AM -0700, Shyam Saini wrote:
> Both ARM SMMU v2/v3 drivers have common set operations for
> arm_smmu_get_resv_regions(), except iommu_dma_get_resv_regions()
> call all other operations can be clubed into common code block.
> So to avoid code duplication put common operations in a new helper
> function iommu_set_sw_msi() and call this helper function from
> arm_smmu_get_resv_regions() instead.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 26 ++-------------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       | 24 ++-----------
>  drivers/iommu/iommu.c                       | 37 +++++++++++++++++++++
>  include/linux/iommu.h                       |  6 ++++
>  4 files changed, 47 insertions(+), 46 deletions(-)

I would do this first, not after you made all the changes to both
drivers.

And then once you do it:

> -	static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };

Can just be constants written here, nothing else in the kernel should
refer to them any more because they are dynamic. The only way to learn
the value is to read the IOMMU_RESV_SW_MSI. Thus don't write them out
in public headers to prevent mis-use.

I'm comfortable with this side from the iommu perspective once you get
agreement on the DT representation.

Jason
