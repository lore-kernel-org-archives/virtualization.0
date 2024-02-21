Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7403D39FF2
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Feb 2024 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708494772; cv=none; b=WCUoNSyeP3HIyhxMwjCYNqbgu3yWY2UaILGe0gRVt+jcdsM6hQkm1XvN+7qKycucgvdfem7CqkTaEY9lfOkVRYJmMnHYpPMtCcS+lvc/SGooJsdnT5LfJEAZaDt+4+jzQQrkBf2RLQJmqPjqUBOKrjkOCls60gDDgGE3Sd8QGG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708494772; c=relaxed/simple;
	bh=m9KXViBMIqK3eY0oESEJYXMAttcld2hKY0eqPgtVrzM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RqrF8HVkfQjEnnDTxeC4Dz55H37xVBHYiIYLpNNvUKIYrMrk2Pndfo5D3YtOeKjY5DnM6uyREGbnt4mnLtBJQAc0GNOZN85IOH+Z/SYngGMYpObvufQHBYKsfgAj3wBBbc6WXPLp8buJDBcJIhSoohM/qn6PLpmEdZq9k6Y9C1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eQfTzSDY; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eQfTzSDY"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 561A8404F6
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Feb 2024 05:52:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ia2PjPFatzH9
	for <virtualization@lists.linux-foundation.org>;
	Wed, 21 Feb 2024 05:52:47 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D5D97403C7
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D5D97403C7
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eQfTzSDY
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D5D97403C7
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Feb 2024 05:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708494767; x=1740030767;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m9KXViBMIqK3eY0oESEJYXMAttcld2hKY0eqPgtVrzM=;
  b=eQfTzSDYKoM9OThoBJj+i0rm8t4qgtSq7VQyHlxvEKmcrelsV6lq+bqN
   dvBwyFOog/J1E6RYr6O6NV3tEQOnmIjeGkeF0sB3eFmSv8JefzEx9Q9li
   OSnfqa+jgWXLJ8/q/lQfLziiJyzYaqn7PhSTpQENXy2m/1Du6k1E7Hals
   Ax4ku1+DqtxZEbkSNzigDzGh34FEKkkRdJiubBHgo6ZovyIy0fTelFGG2
   rwsTlfLSBhzEF4SvtgShQyjmClZd/h4n5owGMB+1WiwDsfXqO0fMKBRE5
   iw+CzXbM52UYZWzxWtedA6rax+oM1aIdAVIDpIV74wzsxWUUaQeJVZjAr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="5592743"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="5592743"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 21:52:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9643953"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.203]) ([10.249.171.203])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 21:52:42 -0800
Message-ID: <b0f5e418-8faa-45d1-b086-61f6c009c0cb@linux.intel.com>
Date: Wed, 21 Feb 2024 13:52:39 +0800
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
Subject: Re: [PATCH v3 1/8] iommu: Add iopf domain attach/detach/replace
 interface
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-2-baolu.lu@linux.intel.com>
 <BN9PR11MB527629BF9A0E27E36D3925B18C452@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527629BF9A0E27E36D3925B18C452@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/7 16:11, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, January 22, 2024 3:39 PM
>>
>> There is a slight difference between iopf domains and non-iopf domains.
>> In the latter, references to domains occur between attach and detach;
>> While in the former, due to the existence of asynchronous iopf handling
>> paths, references to the domain may occur after detach, which leads to
>> potential UAF issues.
> 
> Does UAF still exist if iommu driver follows the guidance you just added
> to iopf_queue_remove_device()?
> 
> it clearly says that the driver needs to disable IOMMU PRI reception,
> remove device from iopf queue and disable PRI on the device.

The iopf_queue_remove_device() function is only called after the last
iopf-capable domain is detached from the device. It may not be called
during domain replacement. Hence, there is no guarantee that
iopf_queue_remove_device() will be called when a domain is detached from
the device.

> 
> presumably those are all about what needs to be done in the detach
> operation. Then once detach completes there should be no more
> reference to the domain from the iopf path?

The domain pointer stored in the iopf_group structure is only released
after the iopf response, possibly after the domain is detached from the
device. Thus, the domain pointer can only be freed after the iopf
response.

> 
>>
>> +struct iopf_attach_cookie {
>> +	struct iommu_domain *domain;
>> +	struct device *dev;
>> +	unsigned int pasid;
>> +	refcount_t users;
>> +
>> +	void *private;
>> +	void (*release)(struct iopf_attach_cookie *cookie);
>> +};
> 
> this cookie has nothing specific to iopf.
> 
> it may makes more sense to build a generic iommu_attach_device_cookie()
> helper so the same object can be reused in future other usages too.
> 
> within iommu core it can check domain iopf handler and this generic cookie
> to update iopf specific data e.g. the pasid_cookie xarray.

This means attaching an iopf-capable domain follows two steps:

1) Attaching the domain to the device.
2) Setting up the iopf data, necessary for handling iopf data.

This creates a time window during which the iopf is enabled, but the
software cannot handle it. Or not?

Best regards,
baolu
