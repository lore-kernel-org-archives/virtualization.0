Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE3B2EAE6
	for <virtualization@lists.linux-foundation.org>; Sun, 19 May 2024 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716113769; cv=none; b=TJ2AWWaVZiu/oJPJPi21c3MnN/izbrVvPdu3qP6tTVqRVc5ckMoBDVXyVnCSu1w0HgXhVhzTgA8Fumrh97Rrcgpd/u4ho80UOPLhsm5WfepvlpUrZpxFDjHp7ZoJnHEWTuBX8xJSuN3zYl/qNnS43XBiJV15aEdEyB+5U5ldx40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716113769; c=relaxed/simple;
	bh=VKnSetxDAoXP/ZBCUBNfgL1hEJz3ci3eugGSDxO0V6w=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JoqhFvUSF5l3U2N2UH0PwsCXspo+ZKCNRl74FQ4Q3352NAwg3e2uxwVf82gqAaj96bevkbauSoaNV2rCvXEaG1mY9f0ezdcb95RR02jBfY54/YmSXivxwqSkFupZRkRhWmcafIXWSXcTcnjJSi4s6sFSZykuep838HSvxSzbZ6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMb+hKV+; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMb+hKV+"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B9BA440453
	for <virtualization@lists.linux-foundation.org>; Sun, 19 May 2024 10:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sm7fo3isAQhz for <virtualization@lists.linux-foundation.org>;
 Sun, 19 May 2024 10:16:07 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org EF27F40434
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EF27F40434
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XMb+hKV+
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EF27F40434
	for <virtualization@lists.linux-foundation.org>; Sun, 19 May 2024 10:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716113767; x=1747649767;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VKnSetxDAoXP/ZBCUBNfgL1hEJz3ci3eugGSDxO0V6w=;
  b=XMb+hKV+NbJcQc3Gatg99kgKAkWykVgvgxNnB3vKXdESP23a0CxXnrG4
   bTtd1+F8IZmu2MVizfRFtO6KSvNU0BORUtO6E9ADMRpXYHu2aLsXqTcBF
   XjD587HUnNxiSET7DpFCX90pi1/h9oYsPovqavHOlT9Qdh8RzK6UJXXUc
   8r/+2pGhD0/NuMKvJlbPsNOVhNQ4iIMLNpUFZgk7WkjwtQMr7XH+qPG6Z
   yT8eLLw3IEZ6M7g292YEq90BTFl+J097M/06PnF7GW1H9A+b2k9aRswjw
   WP1ReEghdUALEkMp1H2whlQq6rREv4FQsV16Rd64eLPadhATvPqWg0ufs
   A==;
X-CSE-ConnectionGUID: 4xZU8bAwTryMd/rxivgxAg==
X-CSE-MsgGUID: JKnDIk6sSV6FrxCo2Z6q5Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="23392650"
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="23392650"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 03:16:06 -0700
X-CSE-ConnectionGUID: zahNnwR3SQawlWRiO68LUg==
X-CSE-MsgGUID: xqV9xgJ0QVCRuviYWR/4iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="32257604"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa009.fm.intel.com with ESMTP; 19 May 2024 03:16:02 -0700
Message-ID: <604d8d9c-6b9d-4cd3-91e7-79923b044472@linux.intel.com>
Date: Sun, 19 May 2024 18:14:12 +0800
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
Subject: Re: [PATCH v5 2/9] iommu: Replace sva_iommu with iommu_attach_handle
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527615219EEF0EF3EACCF38D8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527615219EEF0EF3EACCF38D8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 3:21 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 30, 2024 10:57 PM
>>
>>   #else
>> -static inline struct iommu_sva *
>> +static inline struct iommu_attach_handle *
>>   iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
>>   {
>> -	return NULL;
>> +	return ERR_PTR(-ENODEV);
>>   }
>>
> 
> this should be a separate fix.

Yes. It could be a fix.

> 
> existing drivers (idxd and uacce) only check IS_ERR() on the return
> value. A Null pointer may lead to an error reported at a later point.

Though I don't think it could cause any real problem because this
interface should always be called after the sva enabling one.

Best regards,
baolu
