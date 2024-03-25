Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EDB15ECF9
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Mar 2024 03:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711339093; cv=none; b=aZ+zNTywMe8My7BHeW061uIOU4CLlnKUMHFnL2LrDd22O3I5Cidflo40RxDU++MIRPIMeoeqgKxABOuiJRJWeXh+d2hCb7bOAli77gyIKkFp/zvRH4xSbe2RFDJmwIcSAu3HXuHx1f02VdnbdMYOSffWc6/eSKLHfDr6i8UNVS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711339093; c=relaxed/simple;
	bh=qmHtWDM22Y7Pif9OF/b0d7AyT0SLY8IGS1SO0qYxiss=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=W776NftZ857qbEBvHbR0lq/8dWPM7EaDAe/PFPZbxU03isEgCSioV1kD14idr17ezqQLCroXo1hHUH/MuI5qIuCRhKBzPvaniFIHUjpAnvNd8feTwu9QGDpv5zNpjswGN/ElXX4bmOlGvx0MIV0O1qLvj/d64MIyw3+AHEeXq54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lpJhwLuE; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lpJhwLuE"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 903F581DA3
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Mar 2024 03:58:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5yYqsh4JnAEP for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Mar 2024 03:58:11 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BC71081D7C
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC71081D7C
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lpJhwLuE
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BC71081D7C
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Mar 2024 03:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711339091; x=1742875091;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qmHtWDM22Y7Pif9OF/b0d7AyT0SLY8IGS1SO0qYxiss=;
  b=lpJhwLuED+fsrmi6IMPQ0Gu888IQmOiwPE8KaHkk87vlNXsP0m7zSgxs
   0RvOMTGRVljqLukieEVMRxMRQ7fLdxPSn97WSnYxRxYZEENWCWddl8R10
   XQM1jJeJWDeH/UNMUL+4pbRGDwwT+l2324kZpuiEal9SECX2kl8iYTb+s
   f71CRhZP8GQxE4hjNjAnlKI8OBEivUzDX3QOfFrjWJhFICMDJwtBYuUj1
   CJMY4aGfuVIjfeCKFvY1DdOVHI8Kw7fO0zl8YnHzDIemaarPsjtR8gzK+
   LtTVlyhwSu/1qUGD9uf7860pu/VuuIlMBkorYEPZtRFagCVcDQzw5d/Ud
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="10094403"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="10094403"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 20:58:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="16147457"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 24 Mar 2024 20:58:06 -0700
Message-ID: <2ddd01fb-ec7d-4a7e-984b-31da78211f91@linux.intel.com>
Date: Mon, 25 Mar 2024 11:57:15 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/8] iommufd: Add fault and response message
 definitions
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-4-baolu.lu@linux.intel.com>
 <20240308175007.GW9225@ziepe.ca>
 <43ef5e3f-8a8e-4765-8025-b8207fd05f91@linux.intel.com>
 <20240322170410.GH66976@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240322170410.GH66976@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/23/24 1:04 AM, Jason Gunthorpe wrote:
>>>> +struct iommu_hwpt_pgfault {
>>>> +	__u32 size;
>>>> +	__u32 flags;
>>>> +	__u32 dev_id;
>>>> +	__u32 pasid;
>>>> +	__u32 grpid;
>>>> +	__u32 perm;
>>>> +	__u64 addr;
>>>> +};
>>> Do we need an addr + size here? I've seen a few things where I wonder
>>> if that might become an enhancment someday.
>> I am not sure. The page size is not part of ATS/PRI. Can you please
>> elaborate a bit about how the size could be used? Perhaps I
>> misunderstood here?
> size would be an advice how much data the requestor is expecting to
> fetch. Eg of the PRI initiator knows it is going to do a 10MB transfer
> it could fill in 10MB and the OS could pre-fault in 10MB of IOVA.
> 
> It is not in the spec, it may never be in the spec, but it seems like
> it would be good to consider it, at least make sure we have
> compatability to add it later.

Thanks for the explanation. It sounds reasonable. I will take it and add
some comments to explain the motivation as you described above.

Best regards,
baolu
