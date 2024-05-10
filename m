Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A42148FED
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 03:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715311536; cv=none; b=dG+hyDvl6wGp9ZFKx+afNQYUHga2jXxcr99BY831dUdUUCbkT70UrKPqGHRU3eNFbMAx53CVVEdJPur7uQ1w+HgQkI7cc3QuIGlemjS0o4NlCYWkC8TrcCYRJVyO8MyXJl7gZKXVIF+KyWKOH02SjdI5CO8ppeZ9f/WrzBGjHsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715311536; c=relaxed/simple;
	bh=+60/R6ZelmCn2D21Wc5U/v/CxzPMEwJYHz3a+CsKrH0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=OyFXzwiCdZ99Bh43riPwD63Xd561zvenrX5vMo4Wpi0snfKt7WCe1Ff18UhXLhjfcbEs+y4imCWxT4C8Ko7QXqxVLdhV3l6LLJ5CvJk6wk+IHpKrq/mBHEWHPS5AMRtmN7CxoPsNJu9+pJPvPHLQsVnPXn+yt+sJCdYK0S4VAoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGeUA/Dm; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGeUA/Dm"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9048984231
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 03:25:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LmGQY_gkvYJR for <virtualization@lists.linux-foundation.org>;
 Fri, 10 May 2024 03:25:34 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E3C168422F
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3C168422F
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gGeUA/Dm
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E3C168422F
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 03:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715311534; x=1746847534;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+60/R6ZelmCn2D21Wc5U/v/CxzPMEwJYHz3a+CsKrH0=;
  b=gGeUA/DmSFuqvrfIpFKkmkQy+i9rbiAhNhZwhMllpT/50BoofjB4Iw3F
   wnCnJ5tP03pH2HPK0gVgojZ5Ui4ksjGn1Sn0b1DXMX02cj4/DgAN9NB2S
   45aheYM7W0yeSsT5p9BlmSrSBjUtZJYJcZlkViis/Nj/yU/SV7Z2khYbQ
   xXkjqwq4gH+gZooslFQpVgEG/QvBiyanciFadoK2l5HB0EEMW4WYrMjIQ
   zuFn7KROFhiicIBSdRfV5ApxR2JHnN+j7TOqFXDSooWE1jHgWTe4QxjHA
   vhbASAxDsCXeK1N5fMxL0xfSRT3eOOBCdLudXWdK0gAwTF2ZxFJ7eqVHH
   w==;
X-CSE-ConnectionGUID: xZJzY93dSm++9Ap5ugSehw==
X-CSE-MsgGUID: 7pnDoyAgRkizJHXBMIRMTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11439975"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11439975"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 20:25:33 -0700
X-CSE-ConnectionGUID: 4+6y3HM2QO+Ic3I0KZ0M1Q==
X-CSE-MsgGUID: cZN55lAqTSaJNzDeu+BCvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="66919206"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 09 May 2024 20:25:29 -0700
Message-ID: <134825df-bbf7-4666-b4e7-cbadf9c2b27e@linux.intel.com>
Date: Fri, 10 May 2024 11:23:49 +0800
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
Subject: Re: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
 <20240508002508.GQ4718@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240508002508.GQ4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/24 8:25 AM, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 10:57:08PM +0800, Lu Baolu wrote:
>>   /**
>> @@ -412,6 +415,9 @@ enum iommu_hwpt_data_type {
>>    * @data_type: One of enum iommu_hwpt_data_type
>>    * @data_len: Length of the type specific data
>>    * @data_uptr: User pointer to the type specific data
>> + * @fault_id: The ID of IOMMUFD_FAULT object. Valid only if flags field of
>> + *            IOMMU_HWPT_FAULT_ID_VALID is set.
>> + * @__reserved2: Padding to 64-bit alignment. Must be 0.
>>    *
>>    * Explicitly allocate a hardware page table object. This is the same object
>>    * type that is returned by iommufd_device_attach() and represents the
>> @@ -442,6 +448,8 @@ struct iommu_hwpt_alloc {
>>   	__u32 data_type;
>>   	__u32 data_len;
>>   	__aligned_u64 data_uptr;
>> +	__u32 fault_id;
>> +	__u32 __reserved2;
>>   };
>>   #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)
> [..]
> 
>> @@ -359,7 +359,7 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>>   	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
>>   		 __reserved),
>>   	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
>> -		 __reserved),
>> +		 __reserved2),
> This is now how the back compat mechanism works. The value here is the
> absolute minimum size, it should never increase. The first __reserved
> is always the right value.
> 
> If you change it then old userspace that doesn't include the fault_id
> will stop working.

Yeah! I will remove this change.

Best regards,
baolu
