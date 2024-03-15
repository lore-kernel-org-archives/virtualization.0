Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D885D502
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Mar 2024 01:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710465877; cv=none; b=MGUHcvFmxf25DuGj5Vv9F515llkj06BSRMnJ/DPvsqIq/R/GbHgAXYZszoxGh1jfKbE6KLGk9Az9FCzkJhr64pES7zp9K5lZO1is+BfXHST7h6pcq+lvKH5KcQ5xFG0ed1zs6FFBS3xyH96MN6chEf8bOtwPnr89MBSgbokiIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710465877; c=relaxed/simple;
	bh=RINii3wGGnlUbE3ZLF3vQV3MCY+kCa38spzuhHObNjs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XEeNG8t3R2BQStKuyo2L4MUMLdU9ZWg0hntwEyN4tbaganTTxjgPX8rXtGH77DJ+1lfFT4IopkxFw8IVLcHN2Ul1/HmGCCZnEp1kxJWmhbP9f0bZ0+/d3NB2RBikPCxtR6XQ0KzgJHJopGM8JtgX8P37BTEhrl/uzjODnaE+9Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XreUmlMu; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XreUmlMu"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D2B86400E7
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Mar 2024 01:24:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2OUpscSeCULz
	for <virtualization@lists.linux-foundation.org>;
	Fri, 15 Mar 2024 01:24:35 +0000 (UTC)
X-Greylist: delayed 428 seconds by postgrey-1.37 at util1.osuosl.org; Fri, 15 Mar 2024 01:24:34 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4CE36400E5
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4CE36400E5
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XreUmlMu
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.19; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4CE36400E5
	for <virtualization@lists.linux-foundation.org>; Fri, 15 Mar 2024 01:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710465874; x=1742001874;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RINii3wGGnlUbE3ZLF3vQV3MCY+kCa38spzuhHObNjs=;
  b=XreUmlMuwONQcQCFYSHFmN2m8181gD4tB0x0+z9wUagMlQ5WNcJTqDBU
   zUi1G+90pWN1tWRJQxdl/MyYs1JXI04pbHc95MmuLySRKR4Ftv8f7nvvF
   WOFz4lyqoU8v1aAkQyH6gX+vSst0dqXlTmQfkNNTblAmYlVhmaiCI4Ckv
   En780/w/IbPXmyUNkbpRnjMPmGIxxUm4TczL4LHe7uHmESZeL/Z1lOhJ6
   Hy2Rtu0+67WErYZ4TPNVHXqSGGjQq8Q3jtsSbfCZr5gEh/fZ/el9zXqp/
   3nDkZLfYkbN5GPgUmjd1DpQZEzfgX6dpcVXbQfZo/KhvkYx9q97XcvNhf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5175578"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5175578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:17:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="12947095"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa007.jf.intel.com with ESMTP; 14 Mar 2024 18:17:21 -0700
Message-ID: <7a6ac83b-3165-4abe-91be-a58f69656f8a@linux.intel.com>
Date: Fri, 15 Mar 2024 09:16:43 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240308190539.GY9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/9/24 3:05 AM, Jason Gunthorpe wrote:
> On Mon, Jan 22, 2024 at 03:39:00PM +0800, Lu Baolu wrote:
> 
>> @@ -411,6 +414,8 @@ enum iommu_hwpt_data_type {
>>    * @__reserved: Must be 0
>>    * @data_type: One of enum iommu_hwpt_data_type
>>    * @data_len: Length of the type specific data
>> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
>> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
>>    * @data_uptr: User pointer to the type specific data
>>    *
>>    * Explicitly allocate a hardware page table object. This is the same object
>> @@ -441,6 +446,7 @@ struct iommu_hwpt_alloc {
>>   	__u32 __reserved;
>>   	__u32 data_type;
>>   	__u32 data_len;
>> +	__u32 fault_id;
>>   	__aligned_u64 data_uptr;
>>   };
> 
> ?? We can't add fault_id in the middle of the struct??

Yes. I should add the new field at the end.

By the way, with a __u32 added, this data structure is not 64-byte-
aligned anymore. Do we need to add another unused u32 entry, or just let
the compiler handle it?

> 
>> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
>> +		struct iommufd_fault *fault;
>> +
>> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
>> +		if (IS_ERR(fault)) {
>> +			rc = PTR_ERR(fault);
>> +			goto out_hwpt;
>> +		}
>> +		hwpt->fault = fault;
>> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
>> +		hwpt->domain->fault_data = hwpt;
>> +		hwpt->fault_capable = true;
> 
> I wonder if there should be an iommu API to make a domain fault
> capable?

The iommu core identifies a fault-capable domain by checking its
domain->iopf_handler. Anyway, what's the difference between a fault or
non-fault capable domain from iommu core's point of view?

Best regards,
baolu
