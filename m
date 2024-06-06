Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E22844361
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654131; cv=none; b=MNIe8cpTOHn2lnx5Dja7Zl8jCKs8j4icCn5djFAyoRZbpesEBI14Z/pOnMEqCiVORSmANGptbyfiesH0qlXpB9iJw/niArtu/zwyxJnei9fVL/YXumfhzdHowdSBFV+1c6ZJdJDtPZST4Qqly3QdN933xn2HjirbrAhywGtFhz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654131; c=relaxed/simple;
	bh=13akkfKAq2hsSCLQoZwEGPw7tB5uWCBWFWWz8dMiHsQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OFCvY6PwmmE0Cv6bM0dfZTmzuFIjUZsWYMH7C7ui4GWDeSCffLc/KTr9cIwE3p9VqWZWwTdBc6/zO/Cjq2iWTe+p+IUW3h7vhdJrCJETm5rkKyZttmmbMlduPnKOMkTThO7kTc2IUNxtc5Y8QJa5DmgBjLyc8LvhR5rl09parws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XyfGtsWU; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XyfGtsWU"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3E0F140542
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 06:08:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kc3DDUJxCF8x for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jun 2024 06:08:48 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 2EAD24054D
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EAD24054D
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XyfGtsWU
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2EAD24054D
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 06:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717654128; x=1749190128;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=13akkfKAq2hsSCLQoZwEGPw7tB5uWCBWFWWz8dMiHsQ=;
  b=XyfGtsWUgSjvxfG158f82/MMCs6935r7UcNJd5DTw0uEHo6PbHxitnVR
   9+aQOfATFkuDhHr+goXW1jEdT3Jl/uMaeq1e2pe9lUT+JR6Q57JazLbRB
   ikQ7B7n6QTRGJ3vwCx8QLf3QMeCx6m1orDCrnSO/9/S185vvI1gCMHHdY
   r4iQCYPvotBqLlTe5IEaPVA3Ys1WvyrPnD+w44ku+K8z+y8SUDZd3XLhs
   ACAljP2RpDqpOy7G9BKslzB37I99WldWcWLtA6NQv2zsyFbdxDiOgUp+s
   vOP24Xy/kHnvc6moHAd3GLW1r3Jr3GgX1xziaSfo+2Oyd+InweE80J0oz
   Q==;
X-CSE-ConnectionGUID: ve244M6pSU+/5c37lhhYdQ==
X-CSE-MsgGUID: YXcWJzsaTauOfhqWdsJb+Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="14104133"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="14104133"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 23:08:46 -0700
X-CSE-ConnectionGUID: v7Q61PdfSESz90u4pDDIQA==
X-CSE-MsgGUID: MzwVyrGjSHCTg59Wl3M16w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="68663885"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 05 Jun 2024 23:08:43 -0700
Message-ID: <afaf133b-7175-467f-a254-060b66b9cb4e@linux.intel.com>
Date: Thu, 6 Jun 2024 14:06:32 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/10] iommu: Remove sva handle list
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527658A85092F88329EB73E98CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527658A85092F88329EB73E98CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/24 4:15 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 27, 2024 12:05 PM
>>
>> @@ -69,11 +68,16 @@ static struct iommu_mm_data
>> *iommu_alloc_mm_data(struct mm_struct *mm, struct de
>>    */
>>   struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct
>> mm_struct *mm)
>>   {
>> +	struct iommu_group *group = dev->iommu_group;
>> +	struct iommu_attach_handle *attach_handle;
>>   	struct iommu_mm_data *iommu_mm;
>>   	struct iommu_domain *domain;
>>   	struct iommu_sva *handle;
> 
> it's confusing to have both 'handle' and 'attach_handle' in one function.
> 
> Clearer to rename 'handle' as 'sva'.

Yes. Could be cleaned up in a separated patch. All sva handle in
iommu-sva.c should be converted if we decide to do that.

> 
>>   	int ret;
>>
>> +	if (!group)
>> +		return ERR_PTR(-ENODEV);
>> +
>>   	mutex_lock(&iommu_sva_lock);
>>
>>   	/* Allocate mm->pasid if necessary. */
>> @@ -83,12 +87,13 @@ struct iommu_sva *iommu_sva_bind_device(struct
>> device *dev, struct mm_struct *mm
>>   		goto out_unlock;
>>   	}
>>
>> -	list_for_each_entry(handle, &mm->iommu_mm->sva_handles,
>> handle_item) {
>> -		if (handle->dev == dev) {
>> -			refcount_inc(&handle->users);
>> -			mutex_unlock(&iommu_sva_lock);
>> -			return handle;
>> -		}
>> +	/* A bond already exists, just take a reference`. */
>> +	attach_handle = iommu_attach_handle_get(group, iommu_mm-
>>> pasid, IOMMU_DOMAIN_SVA);
>> +	if (!IS_ERR(attach_handle)) {
>> +		handle = container_of(attach_handle, struct iommu_sva,
>> handle);
>> +		refcount_inc(&handle->users);
>> +		mutex_unlock(&iommu_sva_lock);
>> +		return handle;
>>   	}
> 
> It's counter-intuitive to move forward when an error is returned.
> 
> e.g. if it's -EBUSY indicating the pasid already used for another type then
> following attempts shouldn't been tried.
> 
> probably we should have iommu_attach_handle_get() return NULL
> instead of -ENOENT when the entry is free? then:
> 
> 	attach_handle = iommu_attach_handle_get();
> 	if (IS_ERR(attach_handle)) {
> 		ret = PTR_ERR(attach_handle);
> 		goto out_unlock;
> 	} else if (attach_handle) {
> 		/* matched and increase handle->users */
> 	}
> 
> 	/* free entry falls through */
> But then there is one potential issue with the design that 'handle'
> can be optional in iommu_attach_device_pasid(). In that case
> xa_load returns NULL then we cannot differentiate a real unused
> PASID vs. one which has been attached w/o an handle.

The PASID should be allocated exclusively. This means that once a PASID
is assigned to A, it shouldn't be assigned to B at the same time. If a
single PASID is used for multiple purposes, it's likely a bug in the
system.

So the logic of iommu_attach_handle_get() here is: has an SVA domain
already been installed for this PASID? If so, just reuse it. Otherwise,
try to install a new SVA domain.

> Does it suggest that having the caller to always provide a handle
> makes more sense?

I'm neutral on this since only sva bind and iopf path delivery currently
require an attach handle.

Best regards,
baolu
