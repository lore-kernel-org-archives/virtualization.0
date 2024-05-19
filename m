Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEED4AEDA
	for <virtualization@lists.linux-foundation.org>; Sun, 19 May 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716129468; cv=none; b=hrVEuIgZnE6YzQN/11AaK3Px7dca4I/IFpTnqNPtRwNr6mAnAEZJ2pCm1ymyxcB/EuYKcAQJAssk7j9ImkN8kR4UUjXUT9o012JYj86FeCfoi0AfzwtQElCU4it5uR4SYhdIx2BbWC+wKOpQccVmbIcmdGPriUMmxpJUiwhioic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716129468; c=relaxed/simple;
	bh=7T1VueeZHq6IfwKomhlIjMYUhBWiRr9Lz4G4Ygn6vuw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ISVXhPF6Gf1K1Ps0UB2HDiBI6lGM3SkXlTjEVsNaZrbYmVNzSKeSVm0N9ZCOxr6zRwIFYNfo386e4wCKs4x2rb2vjZDi51swLqn/gdQaNThNFmVLNozy6yeNdFfcwgJ92RhmMdkPHUZxHShedSabJHPqVyjlOMFnZcwRyelwPvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Noh0kq4W; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Noh0kq4W"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99A6B81EAB
	for <virtualization@lists.linux-foundation.org>; Sun, 19 May 2024 14:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4zMqK31XH8y1 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 May 2024 14:37:45 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 8830B81E88
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8830B81E88
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Noh0kq4W
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8830B81E88
	for <virtualization@lists.linux-foundation.org>; Sun, 19 May 2024 14:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716129466; x=1747665466;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7T1VueeZHq6IfwKomhlIjMYUhBWiRr9Lz4G4Ygn6vuw=;
  b=Noh0kq4WDJzVk4r0mbQfdLErMXnsMRB7diszEYhj8U+BY4yzPA9cZxy4
   CoDQcNMbjGs2V1R+LiozEXqVLwV8351zsAWQimymLdM9RMoE3UBKGOe75
   vXVL13CoyTPhTUa69ZkNheBmHmzzrpZ8O4LQmmUZEJDaBhA3TcW+6OScb
   6Ve1U1DIiQADWHSzLLiq0rteQKQA88BivrQkdGOiyvlqO3uVPlsUkwBQN
   MFUVu1EssW6u6uHjtxZF1RYDtvMbCTCWPFVweb+X66RxNdMT3YV88xy+r
   AuwrahMfgq+MDx/23uku9LgRgBi6fBITY/lBro0PjPuLaIrtbo6Onxgms
   Q==;
X-CSE-ConnectionGUID: Oy6da7KYS2am5M3RlDpTQw==
X-CSE-MsgGUID: +W11jAKPS0WPWK3ZmxOLrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="23664496"
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="23664496"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 07:37:45 -0700
X-CSE-ConnectionGUID: U/887R5zRvye6aFdnJdRfQ==
X-CSE-MsgGUID: HCWUP5VSScSsFHQ85uSJHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="63505015"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.244.72]) ([10.125.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 07:37:41 -0700
Message-ID: <805f3ae2-341e-4255-add8-3f6dd296a556@linux.intel.com>
Date: Sun, 19 May 2024 22:37:38 +0800
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
Subject: Re: [PATCH v5 4/9] iommufd: Add fault and response message
 definitions
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52762F2AF16AA5833D61AFF68CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762F2AF16AA5833D61AFF68CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/15 15:43, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 30, 2024 10:57 PM
>>
>> iommu_hwpt_pgfaults represent fault messages that the userspace can
>> retrieve. Multiple iommu_hwpt_pgfaults might be put in an iopf group,
>> with the IOMMU_PGFAULT_FLAGS_LAST_PAGE flag set only for the last
>> iommu_hwpt_pgfault.
> 
> Do you envision extending the same structure to report unrecoverable
> fault in the future?

I am not envisioning extending this to report unrecoverable faults in
the future. The unrecoverable faults are not always related to a hwpt,
and therefore it's more suitable to route them through a viommu object
which is under discussion in Nicolin's series.

> 
> If yes this could be named more neutral e.g. iommu_hwpt_faults with
> flags to indicate it's a recoverable PRI request.
> 
> If it's only for PRI probably iommu_hwpt_pgreqs is clearer.
> 
>> +
>> +/**
>> + * struct iommu_hwpt_pgfault - iommu page fault data
>> + * @size: sizeof(struct iommu_hwpt_pgfault)
>> + * @flags: Combination of enum iommu_hwpt_pgfault_flags
>> + * @dev_id: id of the originated device
>> + * @pasid: Process Address Space ID
>> + * @grpid: Page Request Group Index
>> + * @perm: Combination of enum iommu_hwpt_pgfault_perm
>> + * @addr: Page address
> 
> 'Fault address'

Okay.

> 
>> + * @length: a hint of how much data the requestor is expecting to fetch. For
>> + *          example, if the PRI initiator knows it is going to do a 10MB
>> + *          transfer, it could fill in 10MB and the OS could pre-fault in
>> + *          10MB of IOVA. It's default to 0 if there's no such hint.
> 
> This is not clear to me and I don't remember PCIe spec defines such
> mechanism.

This came up in a previous discussion. While it's not currently part of
the PCI specification and may not be in the future, we'd like to add
this mechanism for potential future advanced device features as it
offers significant optimization benefits.

> 
>> +/**
>> + * enum iommufd_page_response_code - Return status of fault handlers
>> + * @IOMMUFD_PAGE_RESP_SUCCESS: Fault has been handled and the page
>> tables
>> + *                             populated, retry the access. This is the
>> + *                             "Success" defined in PCI 10.4.2.1.
>> + * @IOMMUFD_PAGE_RESP_INVALID: General error. Drop all subsequent
>> faults
>> + *                             from this device if possible. This is the
>> + *                             "Response Failure" in PCI 10.4.2.1.
>> + * @IOMMUFD_PAGE_RESP_FAILURE: Could not handle this fault, don't
>> retry the
>> + *                             access. This is the "Invalid Request" in PCI
>> + *                             10.4.2.1.
> 
> the comment for 'INVALID' and 'FAILURE' are misplaced. Also I'd more
> use the spec words to be accurate.

Yes. Fixed.

> 
>> + */
>> +enum iommufd_page_response_code {
>> +	IOMMUFD_PAGE_RESP_SUCCESS = 0,
>> +	IOMMUFD_PAGE_RESP_INVALID,
>> +	IOMMUFD_PAGE_RESP_FAILURE,
>> +};
>> +

Best regards,
baolu
