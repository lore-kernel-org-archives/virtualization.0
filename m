Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A69D219E2
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 06:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712729623; cv=none; b=ncryESr46Un9KYcVYp0AtqH865wzU5JqW64xkOH2HQcC20x8olKQiyeEXNX48IsgyL/W01ckPPElIoCOi3WHcXIZr6kwyrOCfYSJoDyuHwRek1aON7cDsSsymnncEb5vrYPwuJNFRhcON7dzEkZmHgHGB+Z2JHpcKwP0AdpYPfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712729623; c=relaxed/simple;
	bh=W2gn7RhUJ3uLUCLohYqWt9SWWd8i3R/AyaTViZgpI/8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m2n7SHYS0jBRB3n+Opq2dn2VKqUTCKCiKc0+XuURZa+YyYgI54+49G2odvgsKvbQMAmrWxoGPTO72kwIiUNMxL7Sa174HjgRXp2b9FVLxYXj2W83EqveSiqbFzI3IGOPV3p2BMrvfu4RhF4YvgvjN/04+YVYLUzBv1wKjUKOZoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wi/m+9v0; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wi/m+9v0"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3531440492
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 06:13:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.699
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gu4UKc7rZ06b for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Apr 2024 06:13:39 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.15; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9EB1A40457
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9EB1A40457
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Wi/m+9v0
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9EB1A40457
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Apr 2024 06:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712729618; x=1744265618;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W2gn7RhUJ3uLUCLohYqWt9SWWd8i3R/AyaTViZgpI/8=;
  b=Wi/m+9v0B+gU1ocFlCy7nGqwYVaoYR9o7eeYlD+q8/R7CNMNtAHXqnG0
   lHqsiu5l7F6sCwBH8zA6cM/NV4oxHZBLpFx9JKcU2CM4FtJzEHDj+aCYw
   WaRyUeZVNK87wmLPdcLRdfNkruf9MBXLPjxe4QAJ5FRudw8g6GFagcebL
   wQw8+y1XDTOi/YR2Bg5rf5YToHyKOF28Nn9hUa8As6iIsqLMjZuNDN1/A
   zkAOveQ93cYSwZJjzwCmCNlUqbCZ+YpIY7ye7BnSCDVlmzyyRnkUEjpiB
   r0vl3uJOu3ZRNef1DkybJZOY7AkX+cjDAZl6IFIkw4epI7e5tCBEg1Sol
   Q==;
X-CSE-ConnectionGUID: j/v5AgPETVG7Tu2mKAKBtQ==
X-CSE-MsgGUID: CDyCTbYlSBK7s9q0yA0FEA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11863520"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11863520"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 23:13:36 -0700
X-CSE-ConnectionGUID: Wh9iTWoiSv2pFWIGC0bm3Q==
X-CSE-MsgGUID: v9D6xfsIRuOWKxPZB4NFHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25207459"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 09 Apr 2024 23:13:33 -0700
Message-ID: <69e7bf80-13e3-4775-baff-cccbcd91bfc2@linux.intel.com>
Date: Wed, 10 Apr 2024 14:12:22 +0800
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
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
 <20240408141946.GB223006@ziepe.ca>
 <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>
 <20240409234800.GD223006@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240409234800.GD223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 7:48 AM, Jason Gunthorpe wrote:
> On Tue, Apr 09, 2024 at 10:11:28AM +0800, Baolu Lu wrote:
>> On 4/8/24 10:19 PM, Jason Gunthorpe wrote:
>>> On Sat, Apr 06, 2024 at 02:09:34PM +0800, Baolu Lu wrote:
>>>> On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
>>>>> On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
>>>>>> +	/* A bond already exists, just take a reference`. */
>>>>>> +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
>>>>>> +	if (handle) {
>>>>>> +		mutex_unlock(&iommu_sva_lock);
>>>>>> +		return handle;
>>>>>>     	}
>>>>> At least in this context this is not enough we need to ensure that the
>>>>> domain on the PASID is actually an SVA domain and it was installed by
>>>>> this mechanism, not an iommufd domain for instance.
>>>>>
>>>>> ie you probably need a type field in the iommu_attach_handle to tell
>>>>> what the priv is.
>>>>>
>>>>> Otherwise this seems like a great idea!
>>>> Yes, you are right. For the SVA case, I will add the following changes.
>>>> The IOMMUFD path will also need such enhancement. I will update it in
>>>> the next version.
>>> The only use for this is the PRI callbacks right? Maybe instead of
>>> adding a handle type let's just check domain->iopf_handler  ?
>>>
>>> Ie SVA will pass &ommu_sva_iopf_handler as its "type"
>> Sorry that I don't fully understand the proposal here.
> I was talking specifically about the type field you suggested adding
> to the handle struct.
> 
> Instead of adding a type field check the domain->iopf_handler to
> determine the domain and thus handle type.
> 
>> The problem is that the context code (SVA, IOMMUFD, etc.) needs to make
>> sure that the attach handle is really what it has installed during
>> domain attachment. The context code needs some mechanism to include some
>> kind of "owner cookie" in the attach handle, so that it could check
>> against it later for valid use.
> Right, you have a derived struct for each user and you need a way to
> check if casting from the general handle struct to the derived struct
> is OK.
> 
> I'm suggesting using domain->iopf_handle as the type key.

Oh, I see. It works. Thanks!

Best regards,
baolu
