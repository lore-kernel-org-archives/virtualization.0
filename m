Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88CB13213F
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 04:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718254613; cv=none; b=S4MgImn+97peUWoVXfzDE1vGlMYCCESD5l2dji5p4x+VXwTbgyqe9SysTezrlbgAL0iWOQTuKVKRp6bkiMrbyF7enGJmgWCppB855ah9Tjbgdior4M9D0g2C1lfGIFEPteITRJ4gc+EgMsRZKVIKxaoha/g0AYju+ryIN7ah1Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718254613; c=relaxed/simple;
	bh=iK1p+Q+knm8MizqNtiUBP6wYZDPbo3vXshptVmdVlII=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FGMtfxOdjAvDcYRpsuFK7Y0Tirh9uu0WAoKeoRWl0SpdHJd0tUya3c+cgMe7jD9W8hrpfdO/vZf0NaBVOjmPqbif6zCW777X2aaVmIvrEZ14al8qgaKhOoC4UN6UK4b7Q4DDQcuZZ6gjBZpYeOlumYSw5VWzMa4r7BH0mpGncDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SshC7wQd; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SshC7wQd"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 47B1640590
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 04:56:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xwaosW3KAhBc for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 04:56:51 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 031F340562
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 031F340562
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SshC7wQd
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 031F340562
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 04:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718254611; x=1749790611;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iK1p+Q+knm8MizqNtiUBP6wYZDPbo3vXshptVmdVlII=;
  b=SshC7wQdSuq0Nj9rImlakSBM46DVIZ8CvvMidB2qvNlw11Cca+P899pV
   5X1VqGjHL4UfLC3zMAQCblhSjdqy4stRP27uEl9N4jKrahUYPikjW91Pg
   C0dehSh0zjqyX9hmxbwnTNSyCLtaxCs900wg8K+P8BPJZRe7HS6GZX9CK
   dVfrChTJngAv3PWiPmxvbaWImTmMnQlnkwQ/FNE/ciQrqJr8T7ylzqjYr
   xeZnHIWUYr4mmvnaV8G4AYHtoMX6S+WP40DzdB45/TLjcCbsvBe38H89j
   A5COxF1yWHW0oMib3vGB0HMCukAnpbdKVLHacJmfZhtBkIq3b3TCwoT4d
   Q==;
X-CSE-ConnectionGUID: 6ezjllNFSbCbFOA7kxmYOg==
X-CSE-MsgGUID: i0TcDV0FSsevna+F8KPaSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="25689778"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="25689778"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 21:56:38 -0700
X-CSE-ConnectionGUID: wTJ39ElpRuCl6fhbamiwjg==
X-CSE-MsgGUID: KZQcRNa9REyHMABay2tsYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40652741"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 12 Jun 2024 21:56:35 -0700
Message-ID: <c1c689b7-84fd-4aec-83fb-2fb4244472e0@linux.intel.com>
Date: Thu, 13 Jun 2024 12:54:16 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
To: Jason Gunthorpe <jgg@ziepe.ca>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3ee41c29-46bb-4897-9e93-5982c43736cb@linux.intel.com>
 <BN9PR11MB52764D7EF1EEDA95B694E8B68CFB2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20240612131946.GT791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612131946.GT791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:19 PM, Jason Gunthorpe wrote:
> On Fri, Jun 07, 2024 at 09:38:38AM +0000, Tian, Kevin wrote:
>>> From: Baolu Lu<baolu.lu@linux.intel.com>
>>> Sent: Thursday, June 6, 2024 2:28 PM
>>>
>>> On 6/5/24 4:28 PM, Tian, Kevin wrote:
>>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>>> Sent: Monday, May 27, 2024 12:05 PM
>>>>>
>>>>> +
>>>>> +/**
>>>>> + * struct iommu_hwpt_page_response - IOMMU page fault response
>>>>> + * @size: sizeof(struct iommu_hwpt_page_response)
>>>>> + * @flags: Must be set to 0
>>>>> + * @dev_id: device ID of target device for the response
>>>>> + * @pasid: Process Address Space ID
>>>>> + * @grpid: Page Request Group Index
>>>>> + * @code: One of response code in enum
>>> iommufd_page_response_code.
>>>>> + * @cookie: The kernel-managed cookie reported in the fault message.
>>>>> + */
>>>>> +struct iommu_hwpt_page_response {
>>>>> +	__u32 size;
>>>>> +	__u32 flags;
>>>>> +	__u32 dev_id;
>>>>> +	__u32 pasid;
>>>>> +	__u32 grpid;
>>>>> +	__u32 code;
>>>>> +	__u32 cookie;
>>>>> +	__u32 reserved;
>>>>> +};
>>>> with the response queue per fault object we don't need all fields here,
>>>> e.g. dev_id, pasid, etc. Cookie is sufficient.
> Wait, why did we make it per object? The fault FD is supposed to be
> sharable across HWPTs.

The fault FD is shareable across HWPTs. Kevin was suggesting that the
response queue (for all outstanding IOPFs awaiting responses) could be
put in the fault structure.

Best regards,
baolu
