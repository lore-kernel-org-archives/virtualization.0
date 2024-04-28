Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D3457873
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Apr 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714299759; cv=none; b=NXtgiGKI+ryM6c5cq+pUWcUm9tMVy5uQqybGl2pyYvBx6OVd0fv7NMUM5twCA+LgbwhiX9dsCzHPQ3C7jlayz0AI9yh/SS/CCwsovn/8+3QTC+iMrGfgwyTFCBRUMysNU3AhHY40SMqHrj2xbd0KmginRYUpVnrY5H/rYWU1Dr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714299759; c=relaxed/simple;
	bh=t7yVg/5llcD2DQRjFAumsRe9vh7we/yBmI/XPyc27SA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=byKb/NJXptoHlsNWCnqBAdak5jpm1gHzJRnnCs3tuUB9bFXRyXMBetYu85tv5xyCsK7gvqY4LdDPEBT14g5PTJLj6kTLteaNTz51sXNNfnA3sJbXBd1HHbuU6AE+5LSmD7Tm1JHjJoN1zXcsWNQUyz13goGxkBpW7r0Of3w/34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DIUPhv/g; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DIUPhv/g"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B01D605E2
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Apr 2024 10:22:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zL8Cq4_cSeR1 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 Apr 2024 10:22:36 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5FB3660087
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5FB3660087
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DIUPhv/g
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5FB3660087
	for <virtualization@lists.linux-foundation.org>; Sun, 28 Apr 2024 10:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714299757; x=1745835757;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t7yVg/5llcD2DQRjFAumsRe9vh7we/yBmI/XPyc27SA=;
  b=DIUPhv/g+fPtgEauvJ7iWde3EEuc7bwBJ1jotacv+Be3kujopy+wXqwp
   4ZKy3vRvD8YmlFkw6QoQFunuL2Pe5I2XgeeOGH+UOygc0XDknbgMfh5LY
   MuHiy5dgPehnEuxD3/iIKgUP0ZfI7qijWN57ANEY4YBIxKwp1nl5GTKd8
   rYY3QyO6Zj06aSq5XLGmiGbEIulfdyaGFUZaU3x78+zoJEgPRU1za9Cz9
   vbsA3KLEq7ow3NyLJnzpCx4Vsck+1Z4f4OY2xe+8dQkO5tmEn1I09LGwl
   9DRJsY+yFSLFwFv19b7fWkyskMYMLAePpvB/KNbH0329g4I4oz2g8i0/W
   A==;
X-CSE-ConnectionGUID: 5MNW2AosTTezUA+5zebW3Q==
X-CSE-MsgGUID: FxaAFSthSXGs+PZnthqTeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="27497830"
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="27497830"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 03:22:34 -0700
X-CSE-ConnectionGUID: AR3/mjPPQwu5ubPNxBEAqA==
X-CSE-MsgGUID: IyJahcqkQWSNxFA+JVoF/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,237,1708416000"; 
   d="scan'208";a="63310673"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.244.72]) ([10.125.244.72])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2024 03:22:30 -0700
Message-ID: <5871aaec-b81a-4ad4-8eb1-656a04d04bda@linux.intel.com>
Date: Sun, 28 Apr 2024 18:22:28 +0800
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

On 2024/4/10 7:48, Jason Gunthorpe wrote:
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

After removing the refcount from the attach handle, I am trying to make
the code look like this,

         /* A bond already exists, just take a reference`. */
         handle = iommu_attach_handle_get(group, iommu_mm->pasid);
         if (handle) {
                 if (handle->domain->iopf_handler != 
iommu_sva_iopf_handler) {
                         ret = -EBUSY;
                         goto out_unlock;
                 }

                 refcount_inc(&handle->users);
                 mutex_unlock(&iommu_sva_lock);
                 return handle;
         }

But it appears that this code is not lock safe. If the domain on the
PASID is not a SVA domain, the check of "handle->domain->iopf_handler !=
iommu_sva_iopf_handler" could result in a use-after-free issue as the
other thread might detach the domain in between the fetch and check
lines.

Probably we still need to keep the refcount in the attach handle?

Best regards,
baolu
