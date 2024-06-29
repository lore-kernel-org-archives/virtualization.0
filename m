Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA61EB31
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719633514; cv=none; b=hgHyMFB7IE/baENYfoSniTrDeqaIkSdHB4YUbaTv4oPVf7+iqI07leojxzrw6RWuAKqHRS4op7PTC+i0QI5GO2EjiAbKZnrUlwZDYFJuQrxVKSctBodiif84koATGGf0WxTwlcCGEXJsVJ8hT7MOH46VfjPDB/+OFfzHEZbgAgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719633514; c=relaxed/simple;
	bh=KAM2m2vrRAt/9MTW/snw1O4VivECpPi3UISTEE8FRps=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mU2/PdP3t4J2wohj1caq8WuTPCT/W/X+Tr3RQxxpircvUXKZ/E9KsQr9On7MsUjgfEVyYh9hFUtc6tM3bJeWui95pYeQLxdJfz1/vkH+a5EdqzOW5t16D6r9XdsjPODcBtnzrP3R4/pbi+XjWmAN8iSYwiLKe5DMPWrrhNcfUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=am5s1+96; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="am5s1+96"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7B459400EA
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 03:58:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6HEV8WhnTrZu for <virtualization@lists.linux-foundation.org>;
 Sat, 29 Jun 2024 03:58:31 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.7; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5B61E40021
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B61E40021
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=am5s1+96
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5B61E40021
	for <virtualization@lists.linux-foundation.org>; Sat, 29 Jun 2024 03:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719633511; x=1751169511;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KAM2m2vrRAt/9MTW/snw1O4VivECpPi3UISTEE8FRps=;
  b=am5s1+96wmJ7uZgTYnXzzpSLzwyQywCEdFj2o1Iwaq+71yXRVCOc+LRj
   iP9ne/jMw28KRHipzYkbwijtzyn+r3M8FEG6W5QFXUkZdGy0j3LtBS2o3
   /UmZyWgERpO7hAkIxZk+FxpdZxqtT7qW8xQnoQnEEEG4NGhjmG4be9wWB
   FVta/7bEqPFiJlGYlVvUFN5g6Qf/TYd9ogM++GTPZCxkbAwSQA0YdZZ3h
   V6XudvgpMnRZDgxux94nNilap7O91oqF8hwePQeITrUxEqzat+2kx9bya
   R5qhZFWSRQ9t9OsxZ9VIqo+J85okVyLZ1bnsSiPSOIpITB57weHdIe5O5
   g==;
X-CSE-ConnectionGUID: boCFr7KUTnCQUCIgIsE78A==
X-CSE-MsgGUID: XVt5f2q0SxSXKQCP8QbVxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="42247197"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="42247197"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 20:58:06 -0700
X-CSE-ConnectionGUID: o/L9obIOSLqrGV1okJ2tdw==
X-CSE-MsgGUID: yu2LNLFdQwGzf1VGpU5Dfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="45004877"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 20:58:03 -0700
Message-ID: <4bda68fb-0aa4-4160-8e8a-7024938ea525@linux.intel.com>
Date: Sat, 29 Jun 2024 11:58:01 +0800
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
Subject: Re: [PATCH v7 04/10] iommu: Extend domain attach group with handle
 support
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-5-baolu.lu@linux.intel.com>
 <Zn8luxc+RLBOIIX0@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Zn8luxc+RLBOIIX0@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/29 5:06, Jason Gunthorpe wrote:
> On Sun, Jun 16, 2024 at 02:11:49PM +0800, Lu Baolu wrote:
> 
>> +int iommu_replace_group_handle(struct iommu_group *group,
>> +			       struct iommu_domain *new_domain,
>> +			       struct iommu_attach_handle *handle)
>> +{
>> +	struct iommu_domain *old_domain = group->domain;
>> +	void *curr;
>> +	int ret;
>> +
>> +	if (!new_domain)
>> +		return -EINVAL;
>> +
>> +	mutex_lock(&group->mutex);
>> +	ret = __iommu_group_set_domain(group, new_domain);
>> +	if (ret)
>> +		goto err_unlock;
>> +	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
>> +	if (handle) {
>> +		curr = xa_store(&group->pasid_array, IOMMU_NO_PASID, handle, GFP_KERNEL);
>> +		if (xa_err(curr)) {
>> +			ret = xa_err(curr);
>> +			goto err_restore;
> But this error unwind doesn't work because the xa_erase() already
> happened and there may have been a handle there that we don't put
> back.

Yes, you are right.

> 
> Something like this - store to a reserved entry cannot fail:

This code looks good to me. Thanks!

Best regards,
baolu
