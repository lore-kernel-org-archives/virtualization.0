Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3401210958
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716177469; cv=none; b=C2cbv/vJ/XzYTA1PWkRpwfReO9ToqrrpWAENvL1fpeReAKiFhD6WLFWMFL07kXumPTP8C1n6zo0O33qalW3by5ic9dEPJlpD+g287i4klHXWofQR/uLTKJH72qLq4FFC5i8G0kfkkQ4pbPqJtaJyMApkSXSMh/FqFa7iYBLdseQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716177469; c=relaxed/simple;
	bh=LTlMRByhd4F+euVmK6Ked5hunQivRpLdxW4sWjwAKcY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BN7oC5kQzIFuO5lyv+oCUw1fZUEQ+UkjCUfic5mqq2Ju3kaNgK/FEg22gbVM3Jh6JVibSib8nqarDIjdh1eS6CD4zb+SCpkpAKs+6ySluhVx3TO8iJe2lLrbpth/m2VrIoiaKb7qps3t8zzaRLj7Oy4WzvSgYBUkVZrdV1L3CPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mEwkQGc7; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mEwkQGc7"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BC69881E51
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:57:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0KLp0NmNMO9j for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 03:57:47 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org F0B7781E46
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F0B7781E46
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mEwkQGc7
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F0B7781E46
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 03:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716177467; x=1747713467;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LTlMRByhd4F+euVmK6Ked5hunQivRpLdxW4sWjwAKcY=;
  b=mEwkQGc7Emy8L9hBwIejE6O7dCW58JUGn9vQP/Yi6cxP7LFm0ONO3ICf
   7HlFxejr3CfAejy4bsAF4MDlhzapvAnxClwkXIH8vdhhvKL/Fo8vUvxro
   4RaQNCRR2WXMZcSL+PiXtFcnDOHqtc9QaD23IxsZrYYrcYP/BHz9N9PGi
   IhsMIIfJZQ5RqJbI2xTpfMaQpZ4AFO/0bvzxXa4KrePZvcYhEhGtoSOSD
   Qktmmf6MX3sg9HW0DWzkufu/0ShnNTuCaVlz9wJ3px8aJfXYF2q1HBVIs
   byh14zY7gHbrbboCXR7dmjaDHgCLp7j5clIU+Hcg3clCjQSZoo/PjfIkA
   Q==;
X-CSE-ConnectionGUID: C6le++mZRdyFL/A3xWXpjQ==
X-CSE-MsgGUID: Vy/LOpOFQ9SxR6mFJST9KA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="23691832"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="23691832"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 20:57:46 -0700
X-CSE-ConnectionGUID: xhpZf/slTFm12oszjVwKKQ==
X-CSE-MsgGUID: g+zZGbeoR+icujyl1mlkuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32824611"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa006.jf.intel.com with ESMTP; 19 May 2024 20:57:42 -0700
Message-ID: <868a67fa-b5b5-439b-a906-57cdddeb1053@linux.intel.com>
Date: Mon, 20 May 2024 11:55:51 +0800
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
Subject: Re: [PATCH v5 6/9] iommufd: Fault-capable hwpt attach/detach/replace
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-7-baolu.lu@linux.intel.com>
 <BN9PR11MB5276D582749AD8B619B11B688CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <bd08d2b0-f226-4b42-8d3b-099c46435aa2@linux.intel.com>
 <BN9PR11MB527642EC35E6B925100D0AEA8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527642EC35E6B925100D0AEA8CE92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/24 11:35 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 20, 2024 10:10 AM
>>
>> On 5/15/24 4:43 PM, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, April 30, 2024 10:57 PM
>>>> +
>>>> +int iommufd_fault_domain_replace_dev(struct iommufd_device *idev,
>>>> +				     struct iommufd_hw_pagetable *hwpt,
>>>> +				     struct iommufd_hw_pagetable *old)
>>>> +{
>>>> +	struct iommu_attach_handle *handle;
>>>> +	int ret;
>>>> +
>>>> +	if (hwpt->fault)
>>>> +		ret = iommufd_fault_iopf_enable(idev);
>>>> +	else
>>>> +		iommufd_fault_iopf_disable(idev);
>>>> +
>>>> +	ret = iommu_group_replace_domain(idev->igroup->group, hwpt-
>>>>> domain);
>>>> +	if (ret)
>>>> +		goto out_cleanup;
>>>> +
>>>> +	iommufd_auto_response_faults(old, idev);
>>>> +	handle = iommu_attach_handle_get(idev->igroup->group,
>>>> IOMMU_NO_PASID, 0);
>>>> +	handle->idev = idev;
>>>
>>> why is auto response required in replace? new requests can come
>>> after the auto response anyway...
>>>
>>> The user should prepare for faults delivered to the old or new hwpt
>>> in the transition window.
>>
>> The current design of replace allows switching between one that is not
>> IOPF-capable and one that is. This implies that if we switch from an
>> IOPF-capable hwpt to a non-IOPF-capable one, the response queue needs to
>> be auto responded.
>>
> 
> then do it only for that scenario?

Yes. Will do this in the new version.

Best regards,
baolu
