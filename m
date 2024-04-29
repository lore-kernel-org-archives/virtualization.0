Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39CD51C
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Apr 2024 05:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714367329; cv=none; b=IMviBfYOP7QwgSePSvo5t3P3r1nHtgILE7Sws2y2Fvvy0Y2VCgBxs3s0tKEvegXxteghkpejVuSt9fExfOhMsvBSi2XeToesJiZJr3okiMgrZn94oYY+fPPeH5kNORV8+MVWJeJ4VhgsR2rMtFycwX4Pt63OJhuqcLYNpoF8Urs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714367329; c=relaxed/simple;
	bh=mxVSpiVc3CFUOue6xPqdNIQrLke23NOIAqrrjzMXkAs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XJuJ+w7yp4q5hpj9IJopchepDMUHonfgtVHCrHRWbrIMPWyBfgLYpNhx6OvqpDvWXqrGxCpTDTGPr3sLJRTGgMWgBjyzH51Ji6TNRGnH9kBhBqdjxC1GjojBvnxfMSMPMOF5pzN7Bkic5/cblJkPTIfvqmZOmAeU700gya8TPME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RSgnFO13; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RSgnFO13"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6B0240119
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Apr 2024 05:08:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x6QUTBtEXp5j for <virtualization@lists.linux-foundation.org>;
 Mon, 29 Apr 2024 05:08:47 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 77953400A4
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 77953400A4
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RSgnFO13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 77953400A4
	for <virtualization@lists.linux-foundation.org>; Mon, 29 Apr 2024 05:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714367326; x=1745903326;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mxVSpiVc3CFUOue6xPqdNIQrLke23NOIAqrrjzMXkAs=;
  b=RSgnFO13ARYXb53RfTbpwSDxxgiO2+ENe43FvZGhQJQuXl/EqmKzwNYz
   0U4gjJ8UsGC7uctSIkDrVWQtO9cw4EeuxztEGrRRVa3Ixk4EHDmTHQZ7t
   gRUf5ASczeZry/v1PM+n6p1Vl0m+lMWpOMjFhnH+5tblU8AcvMLDxuFJC
   QzekCmwBtdm5Ki3u8gFawzvEGEtCCtwTEnerUre9Kb3LG5xp7JZvJenkX
   Ac+oW0iGM4UfkCcBiq8zg1N4lKYpcd4kUM7dVeYRyBnot2UMPwEOQwRVD
   hZeJ2WoH0doSa3EsDlqXwF+ZxqUe60/FEJe3DUn60YpigtIcjPiny8x0E
   w==;
X-CSE-ConnectionGUID: vdnwyEHERXiCFS1viCF3WA==
X-CSE-MsgGUID: vGfrpiL6SouJ9xoRMHehHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10231757"
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="10231757"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 22:08:44 -0700
X-CSE-ConnectionGUID: mvNirE5RSEyXwSzpR9HIbw==
X-CSE-MsgGUID: lTA8GHIvRQ+tyNNKpDF9ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,238,1708416000"; 
   d="scan'208";a="26630786"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa008.jf.intel.com with ESMTP; 28 Apr 2024 22:08:42 -0700
Message-ID: <001d6fa8-d2f5-4011-988d-d2bc4f43a1aa@linux.intel.com>
Date: Mon, 29 Apr 2024 13:07:14 +0800
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
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
 <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
 <20240408141946.GB223006@ziepe.ca>
 <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>
 <20240409234800.GD223006@ziepe.ca>
 <5871aaec-b81a-4ad4-8eb1-656a04d04bda@linux.intel.com>
 <BN9PR11MB5276F89C1C21BD03207A044F8C1B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F89C1C21BD03207A044F8C1B2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 10:39 AM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Sunday, April 28, 2024 6:22 PM
>>
>> On 2024/4/10 7:48, Jason Gunthorpe wrote:
>>> On Tue, Apr 09, 2024 at 10:11:28AM +0800, Baolu Lu wrote:
>>>> On 4/8/24 10:19 PM, Jason Gunthorpe wrote:
>>>>> On Sat, Apr 06, 2024 at 02:09:34PM +0800, Baolu Lu wrote:
>>>>>> On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
>>>>>>> On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
>>>>>>>> +	/* A bond already exists, just take a reference`. */
>>>>>>>> +	handle = iommu_attach_handle_get(group, iommu_mm-
>>> pasid);
>>>>>>>> +	if (handle) {
>>>>>>>> +		mutex_unlock(&iommu_sva_lock);
>>>>>>>> +		return handle;
>>>>>>>>      	}
>>>>>>> At least in this context this is not enough we need to ensure that the
>>>>>>> domain on the PASID is actually an SVA domain and it was installed by
>>>>>>> this mechanism, not an iommufd domain for instance.
>>>>>>>
>>>>>>> ie you probably need a type field in the iommu_attach_handle to tell
>>>>>>> what the priv is.
>>>>>>>
>>>>>>> Otherwise this seems like a great idea!
>>>>>> Yes, you are right. For the SVA case, I will add the following changes.
>>>>>> The IOMMUFD path will also need such enhancement. I will update it in
>>>>>> the next version.
>>>>> The only use for this is the PRI callbacks right? Maybe instead of
>>>>> adding a handle type let's just check domain->iopf_handler  ?
>>>>>
>>>>> Ie SVA will pass &ommu_sva_iopf_handler as its "type"
>>>> Sorry that I don't fully understand the proposal here.
>>> I was talking specifically about the type field you suggested adding
>>> to the handle struct.
>>>
>>> Instead of adding a type field check the domain->iopf_handler to
>>> determine the domain and thus handle type.
>>>
>>>> The problem is that the context code (SVA, IOMMUFD, etc.) needs to
>> make
>>>> sure that the attach handle is really what it has installed during
>>>> domain attachment. The context code needs some mechanism to include
>> some
>>>> kind of "owner cookie" in the attach handle, so that it could check
>>>> against it later for valid use.
>>> Right, you have a derived struct for each user and you need a way to
>>> check if casting from the general handle struct to the derived struct
>>> is OK.
>>>
>>> I'm suggesting using domain->iopf_handle as the type key.
>>
>> After removing the refcount from the attach handle, I am trying to make
>> the code look like this,
>>
>>           /* A bond already exists, just take a reference`. */
>>           handle = iommu_attach_handle_get(group, iommu_mm->pasid);
>>           if (handle) {
>>                   if (handle->domain->iopf_handler !=
>> iommu_sva_iopf_handler) {
>>                           ret = -EBUSY;
>>                           goto out_unlock;
>>                   }
>>
>>                   refcount_inc(&handle->users);
>>                   mutex_unlock(&iommu_sva_lock);
>>                   return handle;
>>           }
>>
>> But it appears that this code is not lock safe. If the domain on the
>> PASID is not a SVA domain, the check of "handle->domain->iopf_handler !=
>> iommu_sva_iopf_handler" could result in a use-after-free issue as the
>> other thread might detach the domain in between the fetch and check
>> lines.
>>
>> Probably we still need to keep the refcount in the attach handle?
>>
> 
> What about Jason's another comment in his original replies?
> 
> "
> Though I'm not convinced the refcount should be elevated into the core
> structure. The prior patch I showed you where the caller can provide
> the memory for the handle and we don't have a priv would make it easy
> to put the refcount in a SVA dervied handle struct without more
> allocation. Then we don't need this weirdness.
> "
> 
> That sounds like we'll need a iommu_sva like structure to hold
> its own refcnt. Then we don't need this type check and refcnt
> in the core.

The problem I'm facing isn't about who allocates the handle memory.
Instead, there's no mechanism to synchronize access between two threads.
One thread might remove the handle while another fetches and reads a
member of its structure.

A similar issue exists with iommu_get_domain_for_dev_pasid(). It fetches
and returns a domain, but there's no guarantee that the domain will
*not* be freed while the caller is still using it.

One reason I introduced the reference count for attach handles is to
potentially replace iommu_get_domain_for_dev_pasid(), allowing the
domain to be accessible without any potential UAF issue.

Best regards,
baolu
