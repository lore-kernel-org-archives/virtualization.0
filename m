Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BDF38DF9
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709920214; cv=none; b=OubSErXV5qJ02C33TwGdqIN7B1j/l1W3C2uRu4bW5ymki+AWmO3SM18ciSytrBPbUg3glyvAT6rUdjdVjjcA08+YmoIKhkxBYxtZBHfi0oSn+NR7DFNLqHlLl9HeicOeT980gZR30I/umdjWy2XG0uwG+fLmHvOEOXdpKLha9Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709920214; c=relaxed/simple;
	bh=D4lAezz1Fe85IAGC56X4pGJ4Or5jTbAWiToJS9KUs+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZc/83ZCMqyDSZcD19NtrlqwO9fw8W6Hh1xAl046Pess2qLOmomvqcvh1docXdnEfafCtOTZn17L7fgHPJHRatUQcIVn96bgjNTjmx1sp7Tb6vwaaUJ+K01C7Umd5j+jTnAp/eDLfrryYvFIAW0alMCoOsslE0Y3p2MEwnFwaiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GyTP6nMz; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GyTP6nMz"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A281E41CB7
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 17:50:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.1
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KiG4CgiJqH2b
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Mar 2024 17:50:12 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::234; helo=mail-oi1-x234.google.com; envelope-from=jgg@ziepe.ca; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C16AD40194
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C16AD40194
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=GyTP6nMz
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by smtp2.osuosl.org (Postfix) with ESMTPS id C16AD40194
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Mar 2024 17:50:11 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3c22bca4cbeso555476b6e.1
        for <virtualization@lists.linux-foundation.org>; Fri, 08 Mar 2024 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709920211; x=1710525011; darn=lists.linux-foundation.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ExG2PAh8KBxjdV5p9HMOJ0D9TzLucoEgJI4R5jjzcnY=;
        b=GyTP6nMzCD7JxxvCeoTzyNrZTDUtdmYglB8sBfhM/6hxRNmMGTix7JzHxq/7UryHn1
         Z79y+/NYPXD8yP3bq8++8vUJQbtFwMHbPwOQp+haQU1nD42NYNfpwe7471MBJFOwdHkC
         wPE8lq3lbaRhZxJVbyjy8Wlv4DRxwuRu3q58K/7N2YPn3xhl1m/w7OnH65YTWRE3rFxk
         C2OXmJ8JgYbqRAdfhrN6cZKvutMh8Kce0kgyDbNhkS8qTyKab3ChO8G3/71eb4Y1i+HY
         hdG0m/Zy+6KWCCc06i7y9TKOhqYB01Q6nFmSc9HmQS5wvpA6rhWfTjAaDPnO2j5Ibo0S
         JtEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709920211; x=1710525011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExG2PAh8KBxjdV5p9HMOJ0D9TzLucoEgJI4R5jjzcnY=;
        b=viKXS1ldXQEniGjrLaD5Tmdoed5bGZsCKEfmyd0AvXU1BIvrb8yE2N01cYY8Njnw9i
         xws1Aov7aHIlDynQ5Gsuj/aTv43hR5VAHqJpCFQvQ12uV+Kds8NVuEKWWBbyKC6pi7ne
         NFmM0f4imzXaVjeOLsZMtFJkXxh46D8beHoI72ayO5p4hGDwgmENmUcQroGI3hizqeF6
         CpOBj4pB7jF8/1GPL/k2bXYU4V9xWLIynFWRidpAiQJuQ5cav/Z1Snefyz15jQ8RX85G
         SSBb+0AQ8Z0TQIFhjgndoO/Bze4bCbmPaPdb2IUxJQs6DR51rPGkts15dbQrmZ310mNm
         F6pQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp+VXdVbqk5lkE7JiLH45uecMscpCVp1OnWBempj+yW14y7aW/PxGD9MWO5c9JsmnBOpp3dXHMmYj+Vp6gHf48KB3t9NS6UtuR7vQxibXaqCibMDm0iowLrA==
X-Gm-Message-State: AOJu0YxgF9wklbLAGkRSv/eBSi1Q3sJvEPNkD/cdwIpA4yQhm423oUre
	a061x8k2ip6XHfBpP1G5wkuhHiRE2tcE8UP4Pr2qCkZRcmuCNgNAi6p6knL8qv4=
X-Google-Smtp-Source: AGHT+IHqotrzjMlulGgfxn/O3daDWLB1M/i0FqmA6MZtfAe0W8HVLP0YT6jYEI77fyNP3sENbK2zQA==
X-Received: by 2002:a54:4781:0:b0:3c1:ebff:89a2 with SMTP id o1-20020a544781000000b003c1ebff89a2mr10704452oic.55.1709920209271;
        Fri, 08 Mar 2024 09:50:09 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id t11-20020a0568080b2b00b003c1f461d1cbsm1447808oij.37.2024.03.08.09.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 09:50:08 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rieMB-007Z0m-Os;
	Fri, 08 Mar 2024 13:50:07 -0400
Date: Fri, 8 Mar 2024 13:50:07 -0400
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
Subject: Re: [PATCH v3 3/8] iommufd: Add fault and response message
 definitions
Message-ID: <20240308175007.GW9225@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-4-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122073903.24406-4-baolu.lu@linux.intel.com>

On Mon, Jan 22, 2024 at 03:38:58PM +0800, Lu Baolu wrote:

> +/**
> + * enum iommu_hwpt_pgfault_flags - flags for struct iommu_hwpt_pgfault
> + * @IOMMU_PGFAULT_FLAGS_PASID_VALID: The pasid field of the fault data is
> + *                                   valid.
> + * @IOMMU_PGFAULT_FLAGS_LAST_PAGE: It's the last fault of a fault group.
> + */
> +enum iommu_hwpt_pgfault_flags {
> +	IOMMU_PGFAULT_FLAGS_PASID_VALID		= (1 << 0),
> +	IOMMU_PGFAULT_FLAGS_LAST_PAGE		= (1 << 1),
> +};
> +
> +/**
> + * enum iommu_hwpt_pgfault_perm - perm bits for struct iommu_hwpt_pgfault
> + * @IOMMU_PGFAULT_PERM_READ: request for read permission
> + * @IOMMU_PGFAULT_PERM_WRITE: request for write permission
> + * @IOMMU_PGFAULT_PERM_EXEC: request for execute permission
> + * @IOMMU_PGFAULT_PERM_PRIV: request for privileged permission

You are going to have to elaborate what PRIV is for.. We don't have
any concept of this in the UAPI for iommufd so what is a userspace
supposed to do if it hits this? EXEC is similar, we can't actually
enable exec permissions from userspace IIRC..

> +enum iommu_hwpt_pgfault_perm {
> +	IOMMU_PGFAULT_PERM_READ			= (1 << 0),
> +	IOMMU_PGFAULT_PERM_WRITE		= (1 << 1),
> +	IOMMU_PGFAULT_PERM_EXEC			= (1 << 2),
> +	IOMMU_PGFAULT_PERM_PRIV			= (1 << 3),
> +};
> +
> +/**
> + * struct iommu_hwpt_pgfault - iommu page fault data
> + * @size: sizeof(struct iommu_hwpt_pgfault)
> + * @flags: Combination of enum iommu_hwpt_pgfault_flags
> + * @dev_id: id of the originated device
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @perm: Combination of enum iommu_hwpt_pgfault_perm
> + * @addr: page address
> + */
> +struct iommu_hwpt_pgfault {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dev_id;
> +	__u32 pasid;
> +	__u32 grpid;
> +	__u32 perm;
> +	__u64 addr;
> +};

Do we need an addr + size here? I've seen a few things where I wonder
if that might become an enhancment someday.

> +/**
> + * struct iommu_hwpt_page_response - IOMMU page fault response
> + * @size: sizeof(struct iommu_hwpt_page_response)
> + * @flags: Must be set to 0
> + * @dev_id: device ID of target device for the response
> + * @pasid: Process Address Space ID
> + * @grpid: Page Request Group Index
> + * @code: response code. The supported codes include:
> + *        0: Successful; 1: Response Failure; 2: Invalid Request.

This should be an enum

> + * @addr: The fault address. Must match the addr field of the
> + *        last iommu_hwpt_pgfault of a reported iopf group.
> + */
> +struct iommu_hwpt_page_response {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dev_id;
> +	__u32 pasid;
> +	__u32 grpid;
> +	__u32 code;
> +	__u64 addr;
> +};

Do we want some kind of opaque ID value from the kernel here to match
request with response exactly? Or is the plan to search on the addr?

Jason
