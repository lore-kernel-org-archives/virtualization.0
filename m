Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779021635B2
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 09:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332418; cv=none; b=cxh2yU1IOSbM3Ite1HcG7uuUt1CqNb9ykx7nsORhGD3huFt1n8gh8TfPfD+plWV7Ub7S+8UgxGizzd3k37smL6A1rhmmaDBpifRbac0/BBWKu5FVdFJms6ZouI/BZKsSiUH6ImI9QkKHZ0EyaYlcxsFYfr2V/8Jz9XWL7fGrDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332418; c=relaxed/simple;
	bh=TF+PTbkgSx0ZnPRn+1LyMRtzCYZzLtwMrn37b5euxao=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TMsY56tjlGj8lXfVXjMgVsdoxJypqFlfnAAWi5q9Vnf+si4o+nlpckFqfet/dH8zBgGWLqVmeFtfPnLpHwIkDCEi7HmNoREfIbyl+ttwcl4R9opGd2Ork/OpqDoiwcRZQME0RbBQFvz6l8enyHfZ5E/5/zZ63UGurSA1m9i9kF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ew/A8Iwj; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ew/A8Iwj"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1A6B1426BF
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 09:13:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h_9p7zN5FFTw for <virtualization@lists.linux-foundation.org>;
 Fri, 10 May 2024 09:13:35 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.11; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 82CB5404B5
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82CB5404B5
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ew/A8Iwj
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 82CB5404B5
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 09:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715332416; x=1746868416;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TF+PTbkgSx0ZnPRn+1LyMRtzCYZzLtwMrn37b5euxao=;
  b=Ew/A8IwjmxCmLHMR1IS8HOj1LbhrXl4s0RhwsqoAuM1xlu60La9oI/Bz
   JeYUvJs2I8Bz0xAqK/7RmLZSwiSQ2hwd+DTiVk/4WMlnYZWPCNyVJ+t2d
   C7g9n2LC/qTOGP/tHQXrM/eWiZUOIZLNQ6/9dlDOBNAV4/zlnhR5NBYxA
   +1FKq+iiR28oYP3XTkzlJjS9mXvmicbmnc+7n07ipgQjS/kM8grYpoxkL
   6SMf3ZYb1JPV4gMC4Hc4qGAOWKKaaLZChgr1dPQkbBM3wdxJ88F9qkjPm
   VbbGTMqMyaEh50691I6vPgnHjb1dx4Lku0Gj338GhDyI8nnR/HYz5P9jf
   A==;
X-CSE-ConnectionGUID: 6aQztw3QScSAwRYtGqvNBw==
X-CSE-MsgGUID: iEFuennkSsOGbP1DGTLdXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="21879088"
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="21879088"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 02:13:35 -0700
X-CSE-ConnectionGUID: HlxxGN5LQIqbfopkgkxtpA==
X-CSE-MsgGUID: rZ7SJb6RSguTrlxaCy7EDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,150,1712646000"; 
   d="scan'208";a="29555229"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.237.100]) ([10.124.237.100])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 02:13:30 -0700
Message-ID: <b510a556-a8fe-4328-9917-e50ef074dfee@linux.intel.com>
Date: Fri, 10 May 2024 17:13:29 +0800
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
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <20240508002242.GP4718@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240508002242.GP4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/8 8:22, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 10:57:06PM +0800, Lu Baolu wrote:
>> +static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
>> +				       size_t count, loff_t *ppos)
>> +{
>> +	size_t fault_size = sizeof(struct iommu_hwpt_pgfault);
>> +	struct iommufd_fault *fault = filep->private_data;
>> +	struct iommu_hwpt_pgfault data;
>> +	struct iommufd_device *idev;
>> +	struct iopf_group *group;
>> +	struct iopf_fault *iopf;
>> +	size_t done = 0;
>> +	int rc;
>> +
>> +	if (*ppos || count % fault_size)
>> +		return -ESPIPE;
>> +
>> +	mutex_lock(&fault->mutex);
>> +	while (!list_empty(&fault->deliver) && count > done) {
>> +		group = list_first_entry(&fault->deliver,
>> +					 struct iopf_group, node);
>> +
>> +		if (list_count_nodes(&group->faults) * fault_size > count - done)
>> +			break;
> 
> Can this list_count be precomputed when we build the fault group?

Yes. Done.

> 
>> +
>> +		idev = group->attach_handle->idev;
>> +		if (!idev)
>> +			break;
> 
> This check should be done before adding the fault to the linked
> list. See my other note about the race.

Done.

> 
>> +
>> +		rc = xa_alloc(&idev->faults, &group->cookie, group,
>> +			      xa_limit_32b, GFP_KERNEL);
>> +		if (rc)
>> +			break;
> 
> This error handling is not quite right, if done == 0 then this should
> return rc.
> 
> 
>> +
>> +		list_for_each_entry(iopf, &group->faults, list) {
>> +			iommufd_compose_fault_message(&iopf->fault,
>> +						      &data, idev,
>> +						      group->cookie);
>> +			rc = copy_to_user(buf + done, &data, fault_size);
>> +			if (rc) {
>> +				xa_erase(&idev->faults, group->cookie);
>> +				break;
> 
> Same here
> 
> (same comment on the write side too)

All fixed. Thank you!

Best regards,
baolu

