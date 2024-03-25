Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1CA184EED
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Mar 2024 04:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711342800; cv=none; b=JHmlDZyfRWgtYK9xS55WwM5pLa07vsO1IIL/cY6zLNzsXJ9d7aLlw1wsPqZVc48SfKGB/ghjQu7w8W7lczV2caGv5xQH3FJvtnE9kKDb4lv7my1RFczKEl5u3dTQPOFGpgC24CaOIuH/otcWkDCJM5D2hl8IvU24QTR1eaM0/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711342800; c=relaxed/simple;
	bh=JPIFdOVVVlbXRwS1CVptMVqz9h//vSxocpBlOd35dic=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IP0Dv/qlMgx/CyhOfx7Jk1fhy4w1LgfLnh1RrGg9upK39d7a71qkvmsQXbjb3WA/pffe0Yudzh0Fd7pL+JQ0sT+fZL9H/RdvdcDe1I6GsLXKw1oRbwOY9/E5NktLJG9++FEgTj5d9EbiBsxY+zC0e2Sk+6oT1uOLB2bPu39STWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mWlu96VM; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mWlu96VM"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D6A6A40151
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Mar 2024 04:59:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tZvWQf4p3Ydc for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Mar 2024 04:59:57 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 37694400FF
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37694400FF
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mWlu96VM
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 37694400FF
	for <virtualization@lists.linux-foundation.org>; Mon, 25 Mar 2024 04:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711342797; x=1742878797;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JPIFdOVVVlbXRwS1CVptMVqz9h//vSxocpBlOd35dic=;
  b=mWlu96VM0HuDdc7EfBV1Qq1KSk0Cjdp8QYvlZEe9snOdUSq43j7Tn4o4
   kQ/Iz4xCrayb/qPfi8uJfVtWRIQKXiSDdQL7cBB4hCYjQIaoNBZ7eTs68
   PczE2lBUzO9121wTKRSxGeEPxw/qG+Wfj4D1EF9pEx94ikwKAzoGBEy2b
   fXV2KcnUX4awc8kXIWD3Q8MJgdVt1cn0xds/q6NLSBDHN45bPfAEL8VTg
   tmkMvy9p9WngfwOJ/iRaExhxSEBCxSofoY/Xc6+QtSqlThu9EF3ynIEOg
   GRJnMhR3D/ZAXplmo0wmoS82Vd3MLTaL478rEZlzl1Xzr6/fwY+z4MqWD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6259988"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6259988"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 21:59:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="46493985"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.86]) ([10.254.209.86])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 21:59:49 -0700
Message-ID: <d296d43f-6835-43b3-a5ba-cbbf8b580a27@linux.intel.com>
Date: Mon, 25 Mar 2024 12:59:46 +0800
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
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <20240308190539.GY9225@ziepe.ca>
 <7a6ac83b-3165-4abe-91be-a58f69656f8a@linux.intel.com>
 <20240322170613.GI66976@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240322170613.GI66976@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/23 1:06, Jason Gunthorpe wrote:
> On Fri, Mar 15, 2024 at 09:16:43AM +0800, Baolu Lu wrote:
>> On 3/9/24 3:05 AM, Jason Gunthorpe wrote:
>>> On Mon, Jan 22, 2024 at 03:39:00PM +0800, Lu Baolu wrote:
>>>
>>>> @@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
>>>>     * @__reserved: Must be 0
>>>>     * @data_type: One of enum iommu_hwpt_data_type
>>>>     * @data_len: Length of the type specific data
>>>> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
>>>> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
>>>>     * @data_uptr: User pointer to the type specific data
>>>>     *
>>>>     * Explicitly allocate a hardware page table object. This is the same object
>>>> @@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
>>>>    	__u32 __reserved;
>>>>    	__u32 data_type;
>>>>    	__u32 data_len;
>>>> +	__u32 fault_id;
>>>>    	__aligned_u64 data_uptr;
>>>>    };
>>>
>>> ?? We can't add fault_id in the middle of the struct??
>>
>> Yes. I should add the new field at the end.
>>
>> By the way, with a __u32 added, this data structure is not 64-byte-
>> aligned anymore. Do we need to add another unused u32 entry, or just let
>> the compiler handle it?
> 
> Yes, add a reserved u32 to ensure the structs is always without
> implicit padding.

Sure.

> 
>>>
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
>>>> +		hwpt->fault_capable = true;
>>>
>>> I wonder if there should be an iommu API to make a domain fault
>>> capable?
>>
>> The iommu core identifies a fault-capable domain by checking its
>> domain->iopf_handler. Anyway, what's the difference between a fault or
>> non-fault capable domain from iommu core's point of view?
> 
>  From the core? Nothing. I'm just wondering from an API perspective if
> we should have a little inline to indicate it.

I have no objection if there's a consumer for it.

Best regards,
baolu

