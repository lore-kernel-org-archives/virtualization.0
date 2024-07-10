Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DB712C489
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 08:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720600575; cv=none; b=qOTMVxShirY02LPwc43GwNf84fVmGgeCLA4DWErAbiK9qUejbdc/qBM5zSM9gAv2t992IO+6gSYI3aipL9d5GJ6a9LLg1Vxx17cGiLibGLhLVbSzYq22YvqPGBL47C3Vs66TiJEE7Q9mypgMZZIt5W5r1JaG8j9MMgvdiLfhmTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720600575; c=relaxed/simple;
	bh=b/dygOvp0wyogHXGzt0P/JA3Psilj/juRjotDTNSf2M=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jtXZkDjCXH7IeqUagQu6rIRcAPnxP47uljRmVUFGxkgMy8D2D+0RWI3EwMcxFFzP0uF1zXffUlkLJD72R3aBhAwcBCm816KIC4wDBeDmmWWIbKDGPlvrtQnwfcOcx7N1CdBSkcu87Pp19tXpi7j2CAcZRL2jln0kKU1Rl53uQks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BpQDxl9z; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BpQDxl9z"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6EBF981F5A
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 08:36:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 46grVHgx8-Zx for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Jul 2024 08:36:12 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 900DB81F4D
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 900DB81F4D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BpQDxl9z
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 900DB81F4D
	for <virtualization@lists.linux-foundation.org>; Wed, 10 Jul 2024 08:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720600573; x=1752136573;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b/dygOvp0wyogHXGzt0P/JA3Psilj/juRjotDTNSf2M=;
  b=BpQDxl9zlRiiktLSNx/05E53/uRd7qs8pJpSwPQZAyMwOa4k/boAGkfT
   7HCsN3SyGKIJPl3+czf6qJPLq/4ypfVVv1Cn8bnxC5YpjAL83FGDjnwx6
   rPm00UtCAriVTPBAseM25MT5HN35k6JOZw1wVjnNLk4VobXmXh1vQ5sdk
   adAbbKh9HlUzz74KoK3Ixslc3ookDknnA1XvxObu8gTs2yLaDk+5hhSh5
   sfT4cPJefM7nfeKsi5yrzcALthpWIDwR3lhUTXfyFaApVZd2hWeBGyXT1
   11fd1AeoGAK3vj40+evg7TjwdYx8gLLPK4y1YMmw7xFoUUmv/kxegjG5s
   Q==;
X-CSE-ConnectionGUID: aUW0EqmhRK+CbE4MPy9k0w==
X-CSE-MsgGUID: owE1BTIoQeKFZX0wdwoRkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="20810284"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="20810284"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:36:12 -0700
X-CSE-ConnectionGUID: ddX+wz/jQZ6WOJZ31OzKTQ==
X-CSE-MsgGUID: TeiuBPilT4OqbcfhE8PxBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; 
   d="scan'208";a="79298015"
Received: from jiaoxu-mobl.ccr.corp.intel.com (HELO [10.124.241.177]) ([10.124.241.177])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 01:36:09 -0700
Message-ID: <16e5d5df-3a4d-4bf3-adf6-8edb08df985c@linux.intel.com>
Date: Wed, 10 Jul 2024 16:36:06 +0800
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
Subject: Re: [PATCH v7 07/10] iommufd: Fault-capable hwpt
 attach/detach/replace
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-8-baolu.lu@linux.intel.com>
 <Zn8oZ80p0p1bHgBC@ziepe.ca>
 <7421b923-0bd6-4c9d-81e6-07d954085171@linux.intel.com>
 <20240709173643.GI14050@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240709173643.GI14050@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/10 1:36, Jason Gunthorpe wrote:
> On Mon, Jul 01, 2024 at 01:55:12PM +0800, Baolu Lu wrote:
>> On 2024/6/29 5:17, Jason Gunthorpe wrote:
>>> On Sun, Jun 16, 2024 at 02:11:52PM +0800, Lu Baolu wrote:
>>>> +static int iommufd_fault_iopf_enable(struct iommufd_device *idev)
>>>> +{
>>>> +	struct device *dev = idev->dev;
>>>> +	int ret;
>>>> +
>>>> +	/*
>>>> +	 * Once we turn on PCI/PRI support for VF, the response failure code
>>>> +	 * should not be forwarded to the hardware due to PRI being a shared
>>>> +	 * resource between PF and VFs. There is no coordination for this
>>>> +	 * shared capability. This waits for a vPRI reset to recover.
>>>> +	 */
>>>> +	if (dev_is_pci(dev) && to_pci_dev(dev)->is_virtfn)
>>>> +		return -EINVAL;
>>> I don't quite get this remark, isn't not supporting PRI on VFs kind of
>>> useless? What is the story here?
>> This remark is trying to explain why attaching an iopf-capable hwpt to a
>> VF is not supported for now. The PCI sepc (section 10.4.2.1) states that
>> a response failure will disable the PRI on the function. But for PF/VF
>> case, the PRI is a shared resource, therefore a response failure on a VF
>> might cause iopf on other VFs to malfunction. So, we start from simple
>> by not allowing it.
> You are talking about IOMMU_PAGE_RESP_FAILURE ?
> 
> But this is bad already, something like SVA could trigger
> IOMMU_PAGE_RESP_FAILURE on a VF without iommufd today. Due to memory
> allocation failure in iommu_report_device_fault()
> 
> And then we pass in code from userspace and blindly cast it to
> enum iommu_page_response_code ?
> 
> Probably we should just only support IOMMU_PAGE_RESP_SUCCESS/INVALID
> from userspace and block FAILURE entirely. Probably the VMM should
> emulate FAILURE by disabling PRI on by changing to a non PRI domain.
> 
> And this subtle uABI leak needs a fix:
> 
> 		iopf_group_response(group, response.code);
> 
> response.code and enum iommu_page_response_code are different
> enums, and there is no range check. Need a static assert at least and
> a range check. Send a followup patch please

Yes, sure.

Thanks,
baolu
