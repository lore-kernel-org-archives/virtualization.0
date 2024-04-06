Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99572263A
	for <virtualization@lists.linux-foundation.org>; Sat,  6 Apr 2024 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712384996; cv=none; b=M8A8hz2tZcKTR7cafa/JeSzUR71WTu7mVmIrYW+rgd9iWbJOP6U+RsJTkRrrpp/ZgcyeovrxyZIgvH43wwxmtCbgGizgGbUY+60DA2lB0Nhz7ug+ZArK5zGl7z6Xy4ig82oqjURoER/zpliOgQa3XjfQuda4vZRS9ZH4eWCYQJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712384996; c=relaxed/simple;
	bh=UMB1y8DSo+UPVEoOObQx/TI5qIqyG6i7IBdbk9Misvg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZDc/tPl9tYSIknszzUIlKnGkJF6YlbLW6NCS8dtNlgDZZ6N9/P05Ara3RyQJ91agdUm6/BpDC5psXn1opi6FJSUeth4GXNKHPt7XdGf6l0zYsc1BOHRkQQo4mPrAdj9/FTGe9HuG09v9wjeDx3e9Hzj02DmnU8snqqyx87MUM5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U4KIlLlu; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U4KIlLlu"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3237460831
	for <virtualization@lists.linux-foundation.org>; Sat,  6 Apr 2024 06:29:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.699
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zi86GCXiyQGo for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Apr 2024 06:29:53 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.19; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3D69160820
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3D69160820
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U4KIlLlu
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3D69160820
	for <virtualization@lists.linux-foundation.org>; Sat,  6 Apr 2024 06:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712384993; x=1743920993;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UMB1y8DSo+UPVEoOObQx/TI5qIqyG6i7IBdbk9Misvg=;
  b=U4KIlLlu+RdKQX3dmhehkJly4USqB6714oHgzTZ1zOrjBEjFJSDzRm5A
   W4T6zxsbJOX889Jc6qogFaNy7DeZl3eS4ReZNZa7w8rM+AaTcQmNEPEvo
   OjA65UOYfpMywuXZJgLwlO9b9QvZe3sHK7q549OQy4m8us4XY8e4BK1Xk
   kshbfF+f1EjbTwy+LfiU3goLNFW87tt1EzzOv3pOWneG4kAQWnY+pTbvP
   MHSca0Ddi6sLxKHpQKFLUVZlW+jxuRXpdZsVqJ4PdYKNSuk5gEW0NZaDb
   WnNvH0dYqUY+POCMD1U978VOot7F4YHDPlmLl/Ebqn7Ony6/z0OkRbiDi
   w==;
X-CSE-ConnectionGUID: qDxq9Tc7TLSBdeIoCcH2NA==
X-CSE-MsgGUID: brvOJn0lQpODMUwa1OMENA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7580665"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7580665"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 23:29:50 -0700
X-CSE-ConnectionGUID: bd3muIeKTE6+/DabsIqkTQ==
X-CSE-MsgGUID: iFs4qfuWTYqwAmrMEpV2hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="56858666"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 05 Apr 2024 23:29:47 -0700
Message-ID: <8b71bd41-dc1a-4a28-a380-8f470264f8da@linux.intel.com>
Date: Sat, 6 Apr 2024 14:28:42 +0800
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
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240403115913.GC1363414@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
>> -	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>> -	if (--domain->users == 0) {
>> -		list_del(&domain->next);
>> -		iommu_domain_free(domain);
>> +	iommu_attach_handle_put(handle);
>> +	if (refcount_read(&handle->users) == 1) {
>> +		iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>> +		if (--domain->users == 0) {
>> +			list_del(&domain->next);
>> +			iommu_domain_free(domain);
>> +		}
>>   	}
> Though I'm not convinced the refcount should be elevated into the core
> structure. The prior patch I showed you where the caller can provide
> the memory for the handle and we don't have a priv would make it easy
> to put the refcount in a SVA dervied handle struct without more
> allocation. Then we don't need this weirdness.

It's fine to move the refcount out of the core and allow the caller to
specify and manage its own attach handler. The refcount would then be
managed by the SVA code.

For the IOMMUFD case, we've discussed that all outstanding iopf's
should be automatically responded in the detach process. This ensures
the attach handle won't be used once the detach process completes.
Therefore, if this is true, there appears to be no need for a refcount
for IOMMUFD.

> 
>>   	mutex_unlock(&iommu_sva_lock);
>> -	kfree(handle);
> Also do we need iommu_sva_lock here anymore? I wonder if the group
> mutex would be sufficient..

The iommu_sva_lock protects the whole process of a mm binding, from
pasid allocation to domain attachment. While the group mutex only
protects the data within it structure. I don't think we could replace
iommu_sva_lock with group mutex in this patch. Or any misunderstanding?

Best regards,
baolu
