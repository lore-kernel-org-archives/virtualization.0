Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E66B58AD9
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709924745; cv=none; b=kztVM5I7rWf2h3eSSeKk4qP8HcWR132YmJONPfujFINQE2fiPXRY1bejCRi9aob6eQn6SQb1l2LLNRoOyofcm89ynnEmJz8fMicysPCu7IpCllBcRKn71YTBrLs8DAuCHK7Up/yaeBL1TD2b8m8GxUy70xbekMW7fSP7pt0qn1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709924745; c=relaxed/simple;
	bh=ILaKu4J8rSQrN8d6WmZQitsoeFgh+zPlpkPgOdLz644=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Co9UuOvjTegwVdoI968vJye5PvTXRt179gRtVwMvveOPbsoet/zaZaFDPbS9uhhG5H42VwaIP6MIUibnjFXWirdcWIk3OEWjQXEc3ZTOY2LBtmm2p9JtQa3DwHYsiDGqmh9k6k62OfBNeJRVUco3LWYS5OTqrWNOwbPudBtb9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nvQNbyWM; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nvQNbyWM"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B83A741E12
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 19:05:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hD44lho-IxzK
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Mar 2024 19:05:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4860:4864:20::33; helo=mail-oa1-x33.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E9A9741E0C
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E9A9741E0C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=nvQNbyWM
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E9A9741E0C
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 19:05:41 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-2210a266118so844156fac.1
        for <virtualization@lists.linux-foundation.org>; Fri, 08 Mar 2024 11:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709924740; x=1710529540; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7qMRR7sLkZVUANHdEsXoEoSh+RPGbp+63DXPrOksx9o=;
        b=nvQNbyWM3mDwN+2SADxJgy3UII0H6IpRtZvAodSwFJ+l1oLKe+QqWjvGy0K41MuBZr
         ZQDTmAC1XtPBZnAIF8nFapu8h48tAfTN2LTvNov44wJlESEE4KP2Xdfpov21h34asMk5
         7Zsu0blH8b1IJa0kbpKGbZQMj567/qE+h0j38qELcTKRqZ+DuFu43RXBhTBT5PPPHZHx
         Fe7I0H3Z0NNra0BBx/BMjcnsOtIOKBM32LtVgQXsRMslNY5qTsjYHGqgom7GGiuG1xmh
         QO9Bj32FfsR2JEsu2MzvdyGp5p1aGNzowzZmKXKik6j8xIB9SCjdltkwg2tgys22Txtq
         9lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709924740; x=1710529540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qMRR7sLkZVUANHdEsXoEoSh+RPGbp+63DXPrOksx9o=;
        b=EO1cjcLeMupb+aa+FGn/VI5FFcFdwMvku/jOpgvBWDN2eb+XAhT4hqltolxN6wJO74
         LZ9VtbCiSbJtrdzee9hwlflrAECi4Bl1IYWHE6jP1TG364CCdKVs/09KxxQdveqhj5oN
         BPghOayNo3EbYoPuKcAd140WBehwlM6657LYO3Jh0nQicbYOtKzyiiqI0EUVj4MoOI4Q
         76LQZNGBqAZotgs9THQoAvYidvXS8DL1sw3BNlCYDvlQ3MLerwDwwtetjTEy/IaSTSH0
         wu+Uczqj9en+gqvoej1UueYnVvjzcSWJsuflxunPEoB+PDXY8wH4wzX2gmlfSS1Quqv2
         bjCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVENRM4VhLKHyYnfdTPwiUsQaMfco0/VRVOvk7ZgPlvwggABNX4IQRGNnCfxsmwFW+h2jIfQsQSVFx17SH8ew6z0QPmDNpOZcxJcWX3lqhgKQT157gzBXf35w==
X-Gm-Message-State: AOJu0Yzv2QrAIRb/xME3wfCi1GUNYLTDiC3J/YyCo94RCiR/Bjkp3QJL
	GOeKjiRfDYaPvjRSJXCKcJW5tKjDrIGc5erOE0duHIRg1/r/oKHdFPIsTiwgOy0=
X-Google-Smtp-Source: AGHT+IFDoglDB8jr4C0bRLZGs90q16mK5wPOyxs6caLbupPbYv27tZdKsh1cc0oiSg/2ojAvVJQeAA==
X-Received: by 2002:a05:6870:844f:b0:220:fc89:db73 with SMTP id n15-20020a056870844f00b00220fc89db73mr42008oak.0.1709924740712;
        Fri, 08 Mar 2024 11:05:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id la12-20020a056871410c00b00221847430e2sm1485oab.30.2024.03.08.11.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 11:05:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rifXH-007kGb-7w;
	Fri, 08 Mar 2024 15:05:39 -0400
Date: Fri, 8 Mar 2024 15:05:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Message-ID: <20240308190539.GY9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122073903.24406-6-baolu.lu@linux.intel.com>

On Mon, Jan 22, 2024 at 03:39:00PM +0800, Lu Baolu wrote:

> @@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
>   * @__reserved: Must be 0
>   * @data_type: One of enum iommu_hwpt_data_type
>   * @data_len: Length of the type specific data
> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
>   * @data_uptr: User pointer to the type specific data
>   *
>   * Explicitly allocate a hardware page table object. This is the same object
> @@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
>  	__u32 __reserved;
>  	__u32 data_type;
>  	__u32 data_len;
> +	__u32 fault_id;
>  	__aligned_u64 data_uptr;
>  };

?? We can't add fault_id in the middle of the struct??

> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
> +		struct iommufd_fault *fault;
> +
> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
> +		if (IS_ERR(fault)) {
> +			rc = PTR_ERR(fault);
> +			goto out_hwpt;
> +		}
> +		hwpt->fault = fault;
> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
> +		hwpt->domain->fault_data = hwpt;
> +		hwpt->fault_capable = true;

I wonder if there should be an iommu API to make a domain fault
capable?

Jason
