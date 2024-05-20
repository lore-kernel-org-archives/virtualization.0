Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808028831
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716171647; cv=none; b=bIxpf7oV9fPzlu2SduiuCQpu/mtgcYyTvr/IulkciwQfkPuTKKmZlQtpRq/DcYGPWg5+ciitV6m2yHEM2u3YMmQuzTfHeVJ1YbLnRAbyx4fSF7iFw98XMiXd8isO/mEYglp65JFB3JBbkP5+kR77LKO1o95zOkZ9fju+HNtAeuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716171647; c=relaxed/simple;
	bh=HmTOhh9HFJBHTh79UxzuMR2rO3zHP4siktUZD+OBd/0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dyQLa3drkX9yTUvDQXxvH1Em2UdpkPqmMmc/oroz1JFyHB12R7rmduWgvrT6QKSn0jA25rJQuj3pwLn4oqG12NU5lH1to8zyuzuYp5me0kKz/A4wCO5xbplbs8Qo9WME/BHgU1UDJK4/OFXxBSp7m5o+BfDBLj/ikuQbPOMjyjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kSa1K2NC; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kSa1K2NC"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2186A404DF
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 02:20:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t7E29jVbOAFl for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 02:20:45 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.15; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D46C240342
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D46C240342
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kSa1K2NC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D46C240342
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 02:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716171645; x=1747707645;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HmTOhh9HFJBHTh79UxzuMR2rO3zHP4siktUZD+OBd/0=;
  b=kSa1K2NCcYpiieZiL3WVAIi9quciOoeowdj/ZC032mvm9K3e69+e2gar
   G/aWYbsQZnQ/MNUsI6AE/ZfwLEuTbJs1B6zcdSov4oahpRcY9ViG4ewO0
   9loTpUHWbo/MGsMWTjEnrzp6LlKdf6kmvum7xJ1XTB5C1Y46Nm3Q9x0nQ
   YcyYiED32M1woFVlEvZt5SrDv190f+NYipLu6/IiGbif0/qUsANGgnbi/
   X/zKZ7zOWlggQr3B3GMgLiysmJpZaiORH+u0rp5njVh3H9pZGJrh46FLf
   HrLG1ySsKERD6UhF10Qm7Q/KpIUlD5+ZeMd2zfyElFnuq1BEWgb6Vu3lu
   w==;
X-CSE-ConnectionGUID: l8IxA//TR7+Z7d73lvkzPA==
X-CSE-MsgGUID: eS9Qb3nWQNC7Ryh2HTiM+A==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12466674"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12466674"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 19:20:44 -0700
X-CSE-ConnectionGUID: 0+13nvqtSJi+hGLjcBYcKA==
X-CSE-MsgGUID: I4mEjD1XR6mn5Z5VCt6elQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32286015"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa007.fm.intel.com with ESMTP; 19 May 2024 19:20:39 -0700
Message-ID: <b09f96db-8451-4de9-81c5-312cffdfd4fc@linux.intel.com>
Date: Mon, 20 May 2024 10:18:49 +0800
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
Subject: Re: [PATCH v5 7/9] iommufd: Associate fault object with
 iommufd_hw_pgtable
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-8-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A8E898983310B83C399E8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A8E898983310B83C399E8CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 4:50 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 30, 2024 10:57 PM
>>
>> @@ -227,7 +233,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx
>> *ictx,
>>   	refcount_inc(&parent->common.obj.users);
>>   	hwpt_nested->parent = parent;
>>
>> -	hwpt->domain = ops->domain_alloc_user(idev->dev, flags,
>> +	hwpt->domain = ops->domain_alloc_user(idev->dev, 0,
>>   					      parent->common.domain,
>> user_data);
> 
> it reads slightly better to clear the fault bit and still pass in flags.
> 

Done.

-       hwpt->domain = ops->domain_alloc_user(idev->dev, 0,
+       hwpt->domain = ops->domain_alloc_user(idev->dev,
+                                             flags & 
~IOMMU_HWPT_FAULT_ID_VALID,
                                               parent->common.domain, 
user_data);

>> @@ -308,6 +314,19 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd
>> *ucmd)
>>   		goto out_put_pt;
>>   	}
>>
>> +	if (cmd->flags & IOMMU_HWPT_FAULT_ID_VALID) {
>> +		struct iommufd_fault *fault;
>> +
>> +		fault = iommufd_get_fault(ucmd, cmd->fault_id);
>> +		if (IS_ERR(fault)) {
>> +			rc = PTR_ERR(fault);
>> +			goto out_hwpt;
>> +		}
>> +		hwpt->fault = fault;
>> +		hwpt->domain->iopf_handler = iommufd_fault_iopf_handler;
>> +		hwpt->domain->fault_data = hwpt;
>> +	}
> 
> this is nesting specific. why not moving it to the nested_alloc()?

Nesting is currently a use case for userspace I/O page faults, but this
design should be general enough to support other scenarios as well.

Best regards,
baolu
