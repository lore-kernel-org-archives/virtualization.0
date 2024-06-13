Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C4212DD91
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 03:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718248048; cv=none; b=HaPqC/c5ZZg0U9oN0peWjJZE7p/08NhHXeJmPWf+8EEjzzM+IET0EjzdyUQwXHHiFXwMkIIkuKGHtLI8tZxrUHV9Gd6unCbGNOS9ljWv7z4fiABfFbW3ny3GNHhy4FpQe345+P9IeON5vx6FJXPqk7mpMBPw4DUkMJ5GsUOMJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718248048; c=relaxed/simple;
	bh=OIcere13pVOettULjJywtuj49HytiD3Jo1GU9kFl7kg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mmtrrzYDCqWeQ5sYvgL1tspdMtaX337WxM1y1DQucqPJWlydjok89V+fTfSdHQD8p8X+4zxmRhzwxL1znnYjRs8d5NsPlt2pmvqFzdZwanHBvnBV+IrX79TrGQHhtRJNYm7H0GuZdlrwq7acXyxW1TLkF3A6mYzmvCwnak6zJek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcIsf7JK; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcIsf7JK"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46CE44064A
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 03:07:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jB8IdV6zTdZN for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 03:07:25 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A158F405E6
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A158F405E6
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hcIsf7JK
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A158F405E6
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 03:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718248044; x=1749784044;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OIcere13pVOettULjJywtuj49HytiD3Jo1GU9kFl7kg=;
  b=hcIsf7JKw87/p+ergjHsQfQDbAbUJS+WQfq0vK/THS7SVkklCVm8Sf9X
   tiTA8inJH+ei26J5uoMFtl6AqnRsd7KQyLc6NB1okMXVotS1qm0ptdX2B
   vojaI6YLN+MzW809mIkzSkgVtp0lSoQeZxGddR+oVylIrQxEhYJs27zQr
   MOW7ZvKVgVvKxnuRJ/L5ws2MjTYJG5GNMithq5JpQ+YnaKZ7JxcBVoqjA
   bpuElm9cvW39OH+5EZqU2FYdYLFxfQXu35wS2EtHeO/0lCYb6HbrVHRja
   hIIIfuQJ38MAxDD7ktL61g7GYUr9+RPvSqZ6rYRu080HqTX71ljmzH2Y9
   Q==;
X-CSE-ConnectionGUID: Jtezs4NeSnKr9zrejzu63g==
X-CSE-MsgGUID: 4wHatzb9QN+gKk0EC1gO/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="40449409"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40449409"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 20:07:19 -0700
X-CSE-ConnectionGUID: n9i8A+gXSge7LiRP9GEd9w==
X-CSE-MsgGUID: LLvptQCXTimLNEyV7eOA+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39911926"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 12 Jun 2024 20:07:16 -0700
Message-ID: <ec07f4f3-d537-4687-bacb-b88af2d2667c@linux.intel.com>
Date: Thu, 13 Jun 2024 11:04:57 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 01/10] iommu: Introduce domain attachment handle
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767B3B1F441D9AA656AC258CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ae7c05b0-104e-4c71-99aa-fed2a4f209fb@linux.intel.com>
 <20240612131059.GS791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612131059.GS791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:10 PM, Jason Gunthorpe wrote:
> On Thu, Jun 06, 2024 at 01:33:29PM +0800, Baolu Lu wrote:
> 
>>> But if certain path (other than iopf) in the iommu core needs to know
>>> the exact domain pointer then this change breaks it.
>>
>> The iommu core should not fetch the domain pointer in paths other than
>> attach/detach/replace. There is currently no reference counter for an
>> iommu domain, hence fetching the domain for other purposes will
>> potentially lead to a use-after-free issue.
> 
> If you are doing this then we should get rid of
> iommu_get_domain_for_dev_pasid, and always return the handle
> there. Making it clear that all those flows require handles to work.

I removed iommu_get_domain_for_dev_pasid() in this series. The iopf
handling is the only path that requires fetching domain, where we
requires attach handle to work.

> 
> But is this really OK? What happened to the patch fixing the error
> unwind in attach_pasid? Doesn't it always need the domain to undo a
> failed attach?

attach_pasid switches from being unassigned to being assigned with a
real domain, so the unwind operation simply involves calling
iommu_ops->remove_dev_pasid.

In the future, probably we will introduce a replace interface for pasid.
In that scenario, the caller should explicitly pass both the old and new
domains. If the replace operation fails, the interface will revert to
the old domain.

In my mind, the iommu core should only manage the default domain for
kernel DMA. All domains that are allocated by domain_alloc interfaces
should be managed by the callers and passed through the attach/detach
/replace interfaces.

> 
> Jason
> 

Best regards,
baolu
