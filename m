Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1497FF505
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 04:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716177758; cv=none; b=VOSkzUEoAr6VnAyY3DOnEjGH26rMCZ6VwQQwCcMk2FesYU3X1mBiM6oOc4B9rwd3jBeruMPKMm6361jMrhjDdR9usGp7cDJmtQnMGkg57d+Ewo/erSP0X6ZhHxDWjeQu3m6c9Qr/fInhlnAAK+xM21AhN+yNXPAUj8AvpzIthxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716177758; c=relaxed/simple;
	bh=fgm8MnasUfp5gUQywE3WLZ8eiovWbEY/6L/UNSu7+ho=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j9KclhIQxNzVuE26ovsRvFS2AuPASYENtal1FhwpnRozXXe0+Tahkogpy0GbGi33Ha9O54/liEvBv7e+594lLOwzVMk23HSmaKmuvEZ2LZ++wDinqbz6mH/POfRYEosdu+LD4+fyT7LLs3BWC+Pml52rG0bE5nE8cDJcFPoAGM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRbfCxVh; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRbfCxVh"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B706E40907
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 04:02:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bQ1ENiQ1KY-j for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 04:02:36 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.17; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BFD4640151
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BFD4640151
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XRbfCxVh
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BFD4640151
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 04:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716177756; x=1747713756;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fgm8MnasUfp5gUQywE3WLZ8eiovWbEY/6L/UNSu7+ho=;
  b=XRbfCxVhAx7P4gr1ITgll5aqSiE/7XTGAn0sNcpKZvI2NWlmOWh3o7x0
   R4ky3JOBxQ5k47y2APUYjUc5/Yoe/S5ccgXKqu8uBnDJRlU0QjN/nbKW7
   I4+3iQB7kiITtaZ2+TDaxT2+7uaaXaoM68AMvjBsNn1fJt+ivifmkdcKd
   HRKP71XKDBFc/kH2PRiCshwH8SbJ+m1NRr8/A5oDsO5xPjsOU4TuH0aCv
   LMNRDuyP9RXAObXLBCsQGJR/sogLbYo2sgZYcyI22O9T92cWOKKC1dymc
   QMO7PurmhSCnoHmBx3mtuexkKAV+M1DZi760zfv0VYAou6R/DYxIJTb1I
   w==;
X-CSE-ConnectionGUID: PFv194mbRr6e2a+gBwZLFg==
X-CSE-MsgGUID: MEnF0IXrSHSEflCHlXxoeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12157804"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12157804"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 21:02:34 -0700
X-CSE-ConnectionGUID: B4dH7KHrSO+UmnIsYcfqLw==
X-CSE-MsgGUID: zsu2PH6MSoeFiiHI3qWQRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="36912098"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa003.fm.intel.com with ESMTP; 19 May 2024 21:02:31 -0700
Message-ID: <a43634c5-4005-4701-8f3e-d4fffcee9193@linux.intel.com>
Date: Mon, 20 May 2024 12:00:39 +0800
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
Subject: Re: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A8E898983310B83C399E8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <b09f96db-8451-4de9-81c5-312cffdfd4fc@linux.intel.com>
 <BN9PR11MB5276F07A130CD617777A3AAD8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F07A130CD617777A3AAD8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 11:39 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 20, 2024 10:19 AM
>>
>> On 5/15/24 4:50 PM, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, April 30, 2024 10:57 PM
>>>>
>>>> @@ -308,6 +314,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd
>>>> *ucmd)
>>>>    		goto out_put_pt;
>>>>    	}
>>>>
>>>> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
>>>> +		struct iommufd_fault *fault;
>>>> +
>>>> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
>>>> +		if (IS_ERR(fault)) {
>>>> +			rc = PTR_ERR(fault);
>>>> +			goto out_hwpt;
>>>> +		}
>>>> +		hwpt->fault = fault;
>>>> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
>>>> +		hwpt->domain->fault_data = hwpt;
>>>> +	}
>>>
>>> this is nesting specific. why not moving it to the nested_alloc()?
>>
>> Nesting is currently a use case for userspace I/O page faults, but this
>> design should be general enough to support other scenarios as well.
>>
> 
> Do we allow user page table w/o nesting?
> 
> What would be a scenario in which the user doesn't manage the
> page table but still want to handle the I/O page fault? The fault
> should always be delivered to the owner managing the page table...

I am not sure. But if nesting is the only case for user page table, it's
fine to move above code to the nested_alloc helper.

Best regards,
baolu
