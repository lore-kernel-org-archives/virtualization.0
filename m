Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4583D367
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 01:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716167854; cv=none; b=En6XbHCMu604v1uCXyyKK9tOTC7zwdRJTf2IE9cqJ0zUjcdL679qdP2tuvCkNc3b9rgx+94ZisrFDvngnjQs0kgcVpToK9soVYgqlSH7Vutn9DCu3frW0K1KLeGoV+l3wyhD1zqrOrv+sViFVhatTOvmo7crFnEWV3DnRxhySjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716167854; c=relaxed/simple;
	bh=OBsVYV9d4GvPqYKGWaHDECvr5gkFQ/7IA+nKs2nXEZ8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DAn40xJz20shVyif3c5a/lWe/DyVPsG94xNO9SVN7jutww+78PUlLTdCNvW0dM2dCctndsUT/WiRijWhcb8wxBrhZpEKgbxnYTDcimANaihXAs22GIKq0PAt815izsFU2F/tef8JrvrT9G4gpZzCpDy6PhllWkcLq8Cf8XvuX1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzphQAKS; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzphQAKS"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CB95B40529
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 01:17:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qfrr4i7g7Fmb for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 01:17:32 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D314D40459
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D314D40459
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VzphQAKS
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D314D40459
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 01:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716167853; x=1747703853;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OBsVYV9d4GvPqYKGWaHDECvr5gkFQ/7IA+nKs2nXEZ8=;
  b=VzphQAKS7IQIfogL2anxJFDR0cPdwEj2AD2I4AKGtE0qW6+v+PwCF2nZ
   7J8s1tTdKiuWOG6G5uRnM9zLApsEt8NJJYdXIM48V4NhLJvzt6tB54zkh
   IK5KFnKfEDq161lLwdk2KQDTsWkAsJGS0qaIdMi5r/u1paxnU2SGLWRdJ
   IW6dFxNQi6/GhV/cf6RH1YUNgbEB1v346iJongWdJfyJqaDQoZH3JKtK4
   /XbrOhvKd9vyyCAh+CImecrnYDkeOEYxFBiG9o45El5UNtaEybU2tmad+
   O9G8bFxp6Dux2GDBT5ztktjDG38jux8Mxlx6Snbj63ZujgqtvoXklSHWy
   Q==;
X-CSE-ConnectionGUID: 46xOoRm5QnaxHHlfyWSibg==
X-CSE-MsgGUID: wyyRfXdET2iDDvtom/eBPQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12398676"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12398676"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 18:17:31 -0700
X-CSE-ConnectionGUID: ZxRdiSnpQ7+C2n7WWTY8JA==
X-CSE-MsgGUID: TEqOrygfTx+PwakUljXaig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="69805798"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 19 May 2024 18:17:26 -0700
Message-ID: <2dbfb49b-3d2e-4a3b-ad1b-e53062edbbd4@linux.intel.com>
Date: Mon, 20 May 2024 09:15:35 +0800
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
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 4:37 PM, Tian, Kevin wrote:
>> @@ -395,6 +396,8 @@ struct iommufd_device {
>>   	/* always the physical device */
>>   	struct device *dev;
>>   	bool enforce_cache_coherency;
>> +	/* outstanding faults awaiting response indexed by fault group id */
>> +	struct xarray faults;
> this...
> 
>> +struct iommufd_fault {
>> +	struct iommufd_object obj;
>> +	struct iommufd_ctx *ictx;
>> +	struct file *filep;
>> +
>> +	/* The lists of outstanding faults protected by below mutex. */
>> +	struct mutex mutex;
>> +	struct list_head deliver;
>> +	struct list_head response;
> ...and here worth a discussion.
> 
> First the response list is not used. If continuing the choice of queueing
> faults per device it should be removed.

You are right. I have removed the response list in the new version.

> 
> But I wonder whether it makes more sense to keep this response
> queue per fault object. sounds simpler to me.
> 
> Also it's unclear why we need the response message to carry the
> same info as the request while only id/code/cookie are used.
> 
> +struct iommu_hwpt_page_response {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 dev_id;
> +	__u32 pasid;
> +	__u32 grpid;
> +	__u32 code;
> +	__u32 cookie;
> +	__u32 reserved;
> +};
> 
> If we keep the response queue in the fault object, the response message
> only needs to carry size/flags/code/cookie and cookie can identify the
> pending message uniquely in the response queue.

It seems fine from the code's point of view. Let's wait and see whether
there are any concerns from the uAPI's perspective.

Best regards,
baolu
