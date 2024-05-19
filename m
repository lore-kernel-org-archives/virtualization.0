Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F93A487A9
	for <virtualization@lists.linux-foundation.org>; Sun, 19 May 2024 14:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716127433; cv=none; b=goVI/npgvurtRE5eadIZ1qTCJdv9HcCJKfvmkzTeDdFech5Jh8EGx646bwCBRg3W6Gq88b25vMrjWdyLIn4heHF8EVdyyAv1wzyJOHuYIFahd4cZMO4VfMubhzKS1UJOixVqgDYhIAcdJdHGNrtN0I9ci4QVjjq/PNq78N9ffZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716127433; c=relaxed/simple;
	bh=ARmOeQiHP4d/q5mgCSxMdhI46iVoSC/5ft3lev2E/AE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h+8Rdr1twk4/8xLHbsiVMXscuD5sZJBHSDH3dEXy9JeuBFCyMDGN79vlX+Ef6XA403IDlwyoxMBbRDqeUDDls8NvQWOXIUBFe3bApYicGh7O9xDdz4xY7ZEhngDRRsgYRjEM0cKa1xtNtEz6f/5RCgRUXRYS3C8mFA2O/F4Ru+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jYsCZ630; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jYsCZ630"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id EDC3A60614
	for <virtualization@lists.linux-foundation.org>; Sun, 19 May 2024 14:03:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id efgxgvAAigi2 for <virtualization@lists.linux-foundation.org>;
 Sun, 19 May 2024 14:03:51 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.9; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 003A8605F5
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 003A8605F5
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=jYsCZ630
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 003A8605F5
	for <virtualization@lists.linux-foundation.org>; Sun, 19 May 2024 14:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716127431; x=1747663431;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ARmOeQiHP4d/q5mgCSxMdhI46iVoSC/5ft3lev2E/AE=;
  b=jYsCZ6306A0tT9AAIkp0pcG/vR10WyWtvlz6hHggvaX1vI0D69vUJwlS
   bqsVvWsF6avUFs+DKetnikbP0MtVPSjzWYSGfMw5EUoy6LeGNcKtvvWAK
   qXB2Pjc+XOKeH4hPhCPmQwVRM3H0Y7EiM1cMIrpML8YQqrEvO8lMOQomT
   ESKHU1VQBgw+x4ngbHipmF0eC1iqJCGRbB+TcNTBhEiOeLd2UQK/XM6ka
   JPjBEvI6WdHrf+GEG+7L2tTYmp3qMSC2oeZVqUSiVY+jrQSPe8niIiJDn
   /ksrkgfpdcMhaHFj2eZaSzqX3ZYg6h7u9D/4nDCXbTM1+Wtx9UWOtXrcZ
   g==;
X-CSE-ConnectionGUID: jAeAVHElRQOmT7UwoNthDw==
X-CSE-MsgGUID: jP3NPVhbQsy7nRtCR1KOtg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="34769363"
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="34769363"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 07:03:49 -0700
X-CSE-ConnectionGUID: hlDNrFh6TleY1OYmN5I/ww==
X-CSE-MsgGUID: ymjepgDyRPCCOahlLRk1iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,173,1712646000"; 
   d="scan'208";a="36690457"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.244.72]) ([10.125.244.72])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 07:03:46 -0700
Message-ID: <884a4104-27c8-4604-bd80-3b8cf84fd144@linux.intel.com>
Date: Sun, 19 May 2024 22:03:43 +0800
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
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52762A339B6E103369C22F068CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762A339B6E103369C22F068CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/15 15:31, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 30, 2024 10:57 PM
>>
>> Previously, the domain that a page fault targets is stored in an
>> iopf_group, which represents a minimal set of page faults. With the
>> introduction of attachment handle, replace the domain with the handle
> 
> It's better to use 'attach handle' as the code does.

Done.

> 
>> +	handle = iommu_attach_handle_get(dev->iommu_group, pasid, 0);
>> +	if (IS_ERR(handle))
>> +		return PTR_ERR(handle);
>>
>> -	if (!domain || !domain->iopf_handler) {
>> -		dev_warn_ratelimited(dev,
>> -			"iopf (pasid %d) without domain attached or handler
>> installed\n",
>> -			 fault->prm.pasid);
>> +	group->attach_handle = handle;
>> +	group->domain = handle->domain;
> 
> this change also removes the warning message. Is it desired?

Not desired.

Perhaps we can add a message when the iopf handling is aborted.
Something like below:

err_abort:
+        dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
+                             fault->prm.pasid);
         iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);

Though I am not sure which is better dev_warn() or dev_info().

Best regards,
baolu
