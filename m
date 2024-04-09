Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E324F20E
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 02:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712628765; cv=none; b=RbVg3jfK7LIow29vuo8vt6VMvaiWOyKB2CSz9Nix01J/KaSv4hTocC0aB9FQ5NbjhnK5LNagmsBvxZYOBm6gTPnIx0Hf7sYKbk30z6Nv/7/OqMYZ/4y1FjZ+d7JbaNvypk4d0QZeCV9giLgvTrAxB/4tkl4OxS/yV8fQxKndZis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712628765; c=relaxed/simple;
	bh=8eK+10VMJe90oRq0AJ/aDRfzlyzRnsxQ71/YrliutVo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tLzqslsKgaSwt3+Azj9T4H0Fc59I7l1YAwGsNSdoI8FCkFLxxFD65NG8gN7egMvI/YFWEnkiOHdjJfKnar/eB+hfNFacbTOl/B+TLdooqCTGT1JPYNUXCPapBy6KJ9sSiEGkmoKiRFiWpDFqrDUGNG1oCESDpdkGqVauibHNOsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eIug9VyC; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eIug9VyC"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7169B4085F
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 02:12:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.699
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZSlOtVjPA38w for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Apr 2024 02:12:42 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4DA6940857
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DA6940857
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eIug9VyC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4DA6940857
	for <virtualization@lists.linux-foundation.org>; Tue,  9 Apr 2024 02:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712628762; x=1744164762;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8eK+10VMJe90oRq0AJ/aDRfzlyzRnsxQ71/YrliutVo=;
  b=eIug9VyCT52fu+6r4T1CmHdT1DTPOnO9bAo+txczTdflBG62YZ4n+ojs
   zx3t0xWaaEcNyAomMTuoaQYySOLRhXBrE0I2lvlnfrloxmD98AzIs5V+G
   TLNTqQPTY9ZjVVfhDrHY22zn3FaymfWlPlBxwG81ziMaN3OwWlEy8uy1M
   Hr+Qc3N7nrQYQBWHeXPcbnBBHuWV7j+tkUELAB2e6fnxV3ahKMV7n58YM
   1rV1hCPr3Hsrks9WqEHvOyGKQg4NYEYida0Nz+jp7LrmiZl98TVC5A6Oy
   AhNxsWcGum7Im/eCO2GgQaqFb/nZBzpaLJCVtdYDNgTDKFWlBMSVRSTM0
   A==;
X-CSE-ConnectionGUID: NxZMleS5QiSKe+DtykQ2dA==
X-CSE-MsgGUID: QRwZHQblQ+CMMcq2oxmr1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="11709440"
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="11709440"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 19:12:40 -0700
X-CSE-ConnectionGUID: w4k0UXTzRUS7xxPqU7gLjA==
X-CSE-MsgGUID: hT9REQAWQjW3sSHkLMgkOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,188,1708416000"; 
   d="scan'208";a="20105232"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa006.fm.intel.com with ESMTP; 08 Apr 2024 19:12:37 -0700
Message-ID: <86e723e7-c3be-41b1-95d8-dbdf86bbdab5@linux.intel.com>
Date: Tue, 9 Apr 2024 10:11:28 +0800
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
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240408141946.GB223006@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/24 10:19 PM, Jason Gunthorpe wrote:
> On Sat, Apr 06, 2024 at 02:09:34PM +0800, Baolu Lu wrote:
>> On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
>>> On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
>>>> +	/* A bond already exists, just take a reference`. */
>>>> +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
>>>> +	if (handle) {
>>>> +		mutex_unlock(&iommu_sva_lock);
>>>> +		return handle;
>>>>    	}
>>> At least in this context this is not enough we need to ensure that the
>>> domain on the PASID is actually an SVA domain and it was installed by
>>> this mechanism, not an iommufd domain for instance.
>>>
>>> ie you probably need a type field in the iommu_attach_handle to tell
>>> what the priv is.
>>>
>>> Otherwise this seems like a great idea!
>> Yes, you are right. For the SVA case, I will add the following changes.
>> The IOMMUFD path will also need such enhancement. I will update it in
>> the next version.
> The only use for this is the PRI callbacks right? Maybe instead of
> adding a handle type let's just check domain->iopf_handler  ?
> 
> Ie SVA will pass &ommu_sva_iopf_handler as its "type"

Sorry that I don't fully understand the proposal here.

We need to get the attach handle at least in below cases:

1. In the iommu_sva_bind_device() path so that the existing bind could
    be reused.

2. In the iommu_report_device_fault() path so that the context-specific
    data could be used in the fault handler.

The problem is that the context code (SVA, IOMMUFD, etc.) needs to make
sure that the attach handle is really what it has installed during
domain attachment. The context code needs some mechanism to include some
kind of "owner cookie" in the attach handle, so that it could check
against it later for valid use.

Best regards,
baolu
