Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A91874C02
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 06:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717655395; cv=none; b=rrraYbEaZSxRZ4FcgPjJaO/Blxo+RWjicMTMwsfHdpdk9gGYrqu0talyXQ/Li/II6/Hcc/T0U4rheDJQzy2/Kpc2IPZfYMFJ8ubHLmJPn5KKSnGiojS4bNuYJ6EB8nZfyyp3WSEKO/OWACskmNUBkQ4sW5V2Psl4Td3S3WS98kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717655395; c=relaxed/simple;
	bh=O27iO+wy7mzIj32SyajX2niEXAj8Sxq6fC5HgmpcLk0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aPG+xm5zrX9dleVaigLjoJW/4fwfWDqPT9X8Y1sYG12LEoeTM653Y3ejJ88jwl6eBc9zvdza6mkEY2sIuk79k3Ggm4OjY/Y4ErBLmJHrKxkOFI/G54R5loSaGOYQB+QeHIO5BHG15jMNSFVDkH2eIJTTnTkx097rjAjt5YEhvps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTGa77i9; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTGa77i9"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E0AF403E6
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 06:29:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XeF5gzuZyUXH for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jun 2024 06:29:52 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 71D7A403E4
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 71D7A403E4
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VTGa77i9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 71D7A403E4
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 06:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717655393; x=1749191393;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O27iO+wy7mzIj32SyajX2niEXAj8Sxq6fC5HgmpcLk0=;
  b=VTGa77i9ZglkoA5MDczysumRxFfU5bGL3AYhFnTT32KkVrmq/6as6kRi
   8HloKIgoOrD92Ha88Vjg/PzSheLTn4qEHyqZjtkhzEu2PTdqdn3SHNyQV
   vnk7jSY41LVUv4qktOzh0+mnhF1TCqcaCoTXUNLTHhd8K9g3BUx8C42Dg
   uUGI3fwK5MORU3GvPcA+e9zAwQf3ybhbeFG+iH1vg7uTC2MbVrDk/sNPK
   AnrTAcX6glMbFJFYko3GcSPC+/pEq/EkB6wYbKcNXXbPcQaaj5kusWUwu
   up7xCXo3oZi4jWbkfPUb8nG3icSxo3ULB+LoaiNYe/YiWsbuJoRhqVJWM
   g==;
X-CSE-ConnectionGUID: gShlxopNS+2FdajmvfGuzQ==
X-CSE-MsgGUID: Hniwiw9fRRmHR013y90EOA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25707944"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="25707944"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 23:29:51 -0700
X-CSE-ConnectionGUID: v9Cu+/S3SPeBJgzh0+M12A==
X-CSE-MsgGUID: DwOXGjBlShunYlNvt+UtqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="38527016"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa007.jf.intel.com with ESMTP; 05 Jun 2024 23:29:47 -0700
Message-ID: <3ee41c29-46bb-4897-9e93-5982c43736cb@linux.intel.com>
Date: Thu, 6 Jun 2024 14:27:37 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52768F2D79C8FA75280F1FF38CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/24 4:28 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 27, 2024 12:05 PM
>>
>> +
>> +/**
>> + * struct iommu_hwpt_page_response - IOMMU page fault response
>> + * @size: sizeof(struct iommu_hwpt_page_response)
>> + * @flags: Must be set to 0
>> + * @dev_id: device ID of target device for the response
>> + * @pasid: Process Address Space ID
>> + * @grpid: Page Request Group Index
>> + * @code: One of response code in enum iommufd_page_response_code.
>> + * @cookie: The kernel-managed cookie reported in the fault message.
>> + */
>> +struct iommu_hwpt_page_response {
>> +	__u32 size;
>> +	__u32 flags;
>> +	__u32 dev_id;
>> +	__u32 pasid;
>> +	__u32 grpid;
>> +	__u32 code;
>> +	__u32 cookie;
>> +	__u32 reserved;
>> +};
> 
> with the response queue per fault object we don't need all fields here,
> e.g. dev_id, pasid, etc. Cookie is sufficient.

I prefer not to mess the definition of user API data and the kernel
driver implementation. The kernel driver may change in the future, but
the user API will remain stable for a long time.

I am neutral about whether we could remove above fields, but I need all
maintainers to agree on this, given that this has undergone five rounds
of review. :-)

Best regards,
baolu
