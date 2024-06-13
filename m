Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2631E13775B
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260513; cv=none; b=A1BO4Df7dMPRUYUladMJmXw3SFxjiy562d2evgPmXujHzPCDqIK5m09vmUVZr5vvJ+sWt7ZY5RMztJgy0mbwhE3UBrN1qwTJMKxfdlhcTY8RTgkCeDO42STQL3UJe6qhpnN1gLOYko9kGWB4HU+i5g3qcSTjBSEzitaMJpo/tuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260513; c=relaxed/simple;
	bh=2YW1VcDO5vvDgSqZENQpnOTikqYo3+QOeHpBuHEJ79k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=amukfbdK+IgIUkJXzjzRVxt7c51TDCWTln4hjOeLI3M0qYxUNcSSMD2MHxIHoElg4l7d+ifh4C903AjPzKQyQ3usIAaXuExtXZ3ovyXBZeCSMsI5f9oJUh0ryMa6T22rgvF/IoYXIrggFaRh1C341F4Ku0dCpwmWmmozGiTu4bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U7BShz6R; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U7BShz6R"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A8B5440672
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:35:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CP5Jsp-Sf6LE for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 06:35:10 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org E7944408BC
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7944408BC
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U7BShz6R
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E7944408BC
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718260510; x=1749796510;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2YW1VcDO5vvDgSqZENQpnOTikqYo3+QOeHpBuHEJ79k=;
  b=U7BShz6RLzdLga15+M4sdFWkqge2tUpMouaHhUGZZsA9oLG8dn169r/G
   Fid7Zju9wC0DARW8OsPKVdwIEjlammqsyi/VXNPTgt6qvCsdfFIRgeU+L
   0sNEcLstn9j8FxCVtG2iQcZnWQh+8xxd+zNCr5QfDEGyP2tz2YYP/8vpz
   Vh9jj9gENDYVZF6z5c02U49+7tMfgRjVTqAnmcLoEEO/HQafrir7lNoN0
   Eg8U48IZpI8LplHdyP7Mjf1TJAX6S57JNhEbQBaN4z8M62vhMIbsPFwDH
   YN23Lkq9LK7UGeAQya2RDBXNF0Du1aAh1IViKkBlkwyngxbwpMMTn2TcK
   w==;
X-CSE-ConnectionGUID: MCxiRwmBQ0OMJY3kB2q6Wg==
X-CSE-MsgGUID: eUIQD+jiQImcGM00vm/+sg==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18881195"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="18881195"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:35:09 -0700
X-CSE-ConnectionGUID: jdv7yU8XQAu31tmE04AqOg==
X-CSE-MsgGUID: x3FFM3qqTRWUpMXS9tD9RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="71241593"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa001.fm.intel.com with ESMTP; 12 Jun 2024 23:35:05 -0700
Message-ID: <52144c4e-0421-46ca-bd00-8602c12c901a@linux.intel.com>
Date: Thu, 13 Jun 2024 14:32:46 +0800
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
 <20240612131946.GT791043@ziepe.ca> <20240612135021.GY791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612135021.GY791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:50 PM, Jason Gunthorpe wrote:
> On Wed, Jun 12, 2024 at 10:19:46AM -0300, Jason Gunthorpe wrote:
>>>> I prefer not to mess the definition of user API data and the kernel
>>>> driver implementation. The kernel driver may change in the future, but
>>>> the user API will remain stable for a long time.
>>> sure it remains stable for reasonable reason. Here we defined some
>>> fields but they are even not used and checked in the kernel. IMHO it
>>> suggests redundant definition. If there is value to keep them, do we
>>> need to at least verify them same as the completion record?
>> They are not here for the kernel, they are here for userspace.
>>
>> A single HWPT and a single fault queue can be attached to multiple
>> devices we need to return the dev_id so that userspace can know which
>> device initiated the PRI. Same with PASID.
>>
>> The only way we could remove them is if we are sure that no vIOMMU
>> requires RID or PASID in the virtual fault queue PRI fault message.. I
>> don't think that is true?
>>
>> Cookie is not a replacement, cookie is an opaque value for the kernel
>> to use to match a response to a request.
> Oh I got this wrong, the above is the response, yeah we can ditch
> everything but the cookie, and code right?
> 
> struct iommu_hwpt_page_response {
>         __u32 cookie;
>         __u32 code;
> };
> 
> What is the workflow here? We expect the VMM will take the vIOMMU
> response and match it to a request cookie for the kernel to complete?

The workflow in the host kernel involves looking up the iopf_group using
the cookie value in the response queue and then responding to the
iopf_group with the code. Therefore, from the host kernel's perspective,
it is acceptable if the user only passes the cookie and code in the
response message.

Since you both agreed that the response message could be simplified, I
will implement the above structure in the new version.

Best regards,
baolu
