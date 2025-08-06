Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3175F277CA2
	for <virtualization@lists.linux.dev>; Wed,  6 Aug 2025 23:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754524732; cv=none; b=ZSlnKKyYfJSMeqdP+ttBitoOPKlguMN14NseZRCy1PtwKMoLkNfchvIcQh1K0aawg05WUle8e7tsxwtLwcLwo87ZoYtz1kWUcS6iC4YI+vKoYV0SprZRgKO9BMd9eUDXmcQLKg84PuFmejFdDSRhsYwrP7T9dudrDQvu0PGromQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754524732; c=relaxed/simple;
	bh=Ch3Lu3JNorrE3DqTb4s0lvqvQJV5+k082o5zzm77yE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXALvslyrZ2xtk5lvG6mGyh36yGbqaRF47hmBHmBK00/5xDioHhjteOwK79HUGrzqzzUSKUsqHGztCWS81kOa1vyex+BFhTt9ZgDiOWfu6VC7UuF94TDZNqrFQ3CMKa+gISZ64zy9XT0yPfKLbpzNav3ju3KmYpOOTthCYgfPPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MH27oci2; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MH27oci2"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e182e4171bso52627985a.3
        for <virtualization@lists.linux.dev>; Wed, 06 Aug 2025 16:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754524730; x=1755129530; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I4DgF6Vw8xGQncqmkZy1+xUkx+suIzKaCcwcVTdjpkA=;
        b=MH27oci2nJjyrPxMZoBx++UIIjvZjcXN591pFI4mCv0vumJ8zo9CY4GZZvnt8++Bt0
         brldMJZ8vFFmEpnD35dbhq7FUD1SsRA9CPy0Z/o4x38G+c+swFzuu/H30lsNaw2XqHzb
         XjqAKhjOulsOytsl+GIH1u1ucneKHUt2oN0M/fJZHwlf5aplJ0J2Wpb1BawBVUrCgCqM
         0zjeR4mJvxbUDii1p+ec4W7sUOs12HTiySstdxmjAS+ysmLLZXAwkt8td2q281PXtDaW
         mM0h+kH+newNYQ8i38K1g4oyiOt0KKwuAUDj9HldbQv7K6Za5qNIEcfVfX0uQlV5x5MM
         ktig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754524730; x=1755129530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4DgF6Vw8xGQncqmkZy1+xUkx+suIzKaCcwcVTdjpkA=;
        b=QueThJQmXG66MP4eF9I6+d8MAOaK0Sx6GQRs2SC+Qp4oBj3uXbEyzbQjumvGufpHiK
         StI5ApGr/xNs6Xx26HgEK6EKmxh/YdKBLes/AZ1WIIw7BhPRF1m4BBMY19zFDGivAHwW
         4IpJoeXuKFWqVcZ335qCPK2z3XA2py8PhECJ+5IsxdpFGTL4xsn0D6hHlPDpB3zxvkxg
         dqi03/vDOnQ0jyptkqkwxobl+58PxRvx+Vqg5UxRto1g0s98R5NwGE1PPdH24UK+ZxZw
         bD/nmqpnySU8jY5myEFVMIDINRjUxCu//zGr/hy+4X977byinPuXx4izHV4LweC6xZDl
         b93A==
X-Forwarded-Encrypted: i=1; AJvYcCXn6p8D6xxjpVX6oUgWWOnj4GN+G1OjV4yHw+R8huYuslX23AHKtCTvUNgreB2m8caLgnlBPeCpZjYsvptE6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx741+APpR5KnMeiBx0lAOkygtnlG42W1MQYQOsizr6PozIkyRl
	3rT1GAoB6gSjzHzreviDjbQBaI+5a0YNTdUpGA3L9+blPN+0wuq8HOIell48jdNv7oY=
X-Gm-Gg: ASbGncsx0AaSMd+i27EXZP8ru8ZHw+TYFSYGts64+BAbEQE6sU/Z2PkQ24Qmc8igRg4
	X82NEaO06PMR6r71dqOMCrazgOu2EOfSq7NbGS9RgAUHgjgZ8Jcqjodz7c7J7hqyHon79tGieSo
	vJbF+jkY36yleW/3INL25u4E4VItcudQ3KfPzEE8pjYaDMKp3RxUR4dor2WNi3xWS7LSokY+2hW
	mbSM0wXnrLbL/ZDEN3esZrmKJq81zJVK+8jDH1gZEr1t3B2ataWlgnc6fRBygGTYp2jD6n8QJPb
	gbGhBgVwVckIzk3PbV+SvC7pS6eo7Fb5DOgJ23AAD5/DNL9naktcbqyK2ozUl+ApZlF+uvPaVw2
	Kno0yqKvlIEtYc3e6Sub+SyJdAI00KPCrlgEb1zSjRDQzNpBNy5euWV11EUkgd7fGIxJe
X-Google-Smtp-Source: AGHT+IGnS032BQYfbSfwSqYTvKso8Ea62PyX+fE1vpQVHfXPFL26cVNK4i9ZyLJUzr/PgtuVEArJEg==
X-Received: by 2002:a05:620a:4045:b0:7e6:97a2:ea7d with SMTP id af79cd13be357-7e81677da93mr625181985a.62.1754524729857;
        Wed, 06 Aug 2025 16:58:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e80b869d4bsm310283985a.24.2025.08.06.16.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 16:58:49 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujo1w-00000001sk1-2RDU;
	Wed, 06 Aug 2025 20:58:48 -0300
Date: Wed, 6 Aug 2025 20:58:48 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, virtualization@lists.linux.dev,
	will@kernel.org, jacob.pan@linux.microsoft.com,
	eric.auger@redhat.com, code@tyhicks.com,
	eahariha@linux.microsoft.com, vijayb@linux.microsoft.com,
	bboscaccy@linux.microsoft.com
Subject: Re: [PATCH v3 3/3] arm-smmu: select suitable MSI IOVA
Message-ID: <20250806235848.GD377696@ziepe.ca>
References: <20250806215539.1240561-1-shyamsaini@linux.microsoft.com>
 <20250806215539.1240561-4-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806215539.1240561-4-shyamsaini@linux.microsoft.com>

On Wed, Aug 06, 2025 at 02:55:39PM -0700, Shyam Saini wrote:
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3642,17 +3642,30 @@ static int arm_smmu_of_xlate(struct device *dev,
>  static void arm_smmu_get_resv_regions(struct device *dev,
>  				      struct list_head *head)
>  {
> -	struct iommu_resv_region *region;
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  
> -	region = iommu_alloc_resv_region(MSI_IOVA_BASE, MSI_IOVA_LENGTH,
> -					 prot, IOMMU_RESV_SW_MSI, GFP_KERNEL);
> -	if (!region)
> -		return;
> -
> -	list_add_tail(&region->list, head);
> +	static const u64 msi_bases[] = { MSI_IOVA_BASE, MSI_IOVA_BASE2 };
>  
>  	iommu_dma_get_resv_regions(dev, head);
> +
> +	/*
> +	 * Use the first msi_base that does not intersect with a platform
> +	 * reserved region. The SW MSI base selection is entirely arbitrary.
> +	 */
> +	for (int i = 0; i != ARRAY_SIZE(msi_bases); i++) {
> +		struct iommu_resv_region *region;
> +
> +		if (resv_region_intersects(msi_bases[i], MSI_IOVA_LENGTH, head))
> +			continue;
> +
> +		region = iommu_alloc_resv_region(msi_bases[i], MSI_IOVA_LENGTH, prot,
> +						 IOMMU_RESV_SW_MSI, GFP_KERNEL);
> +		if (!region)
> +			return;
> +
> +		list_add_tail(&region->list, head);
> +		return;
> +	}
>  }

I think this whole series looks pretty good, but I would suggest to
put this in a helper..

'iommu_set_sw_msi()' perhaps, must be called after iommu_dma_get_resv_regions()

Then maybe the constants can just be placed in the .c file inside the
helper function.

Jsaon
