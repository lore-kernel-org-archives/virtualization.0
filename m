Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817836AB8
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716168367; cv=none; b=COnlFtn56Mvudj8nGLChMMEOoJ3CBsTu1ry7W19R3Nyp5cXBBtC2Fdyr9NK6H0eOsL5HKqsXq7WN8fb7LVZH4nn/q4ieGKt/WuiqxxLPdceF6o2bMgOfnsurTapfrbSycUJLZZr0YmJBj+tPw8sy6NIONe8BMA7OFd/SbmvJIJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716168367; c=relaxed/simple;
	bh=TtwtjcXrrA11KTveXffexyVsNN0b1pCRGDvph290NUQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H3WhO49lai8/FO89ChqaFt1awyjBPZw7K8gqrwQDhzedjuO4aBVDKNm8SKTL5FnlFZtVf8wCgTDq9pmqj7Elt7QpUUXVnpGLgHvdKh2mq/VFXyf9/U2TDsWHMwaEDzyr4veg60mEBQiZLcZ35kmTcLAOk0we8CUBCpWKMUlnZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=inyhMKtt; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="inyhMKtt"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0755E606C4
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 01:26:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Bf6bRP3LSkn for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 01:26:05 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 031E26066A
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 031E26066A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=inyhMKtt
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 031E26066A
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 01:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716168365; x=1747704365;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TtwtjcXrrA11KTveXffexyVsNN0b1pCRGDvph290NUQ=;
  b=inyhMKtt40q1Cp89ck/GS8B8G48yAVjrWWwGZXt/lYA1AqVqevIdU6SF
   Cv+XCQ+uCQ0ZcWTEapXok7b6QP4CQMp4ueLE5gFg5pkOChBqTvlu5BXAw
   f2I77yXtReWc6HA7cTxnwcAf1GUlY8JnKkFdlBOv3Y2z994g5hfE6TvY/
   7yZvh4NqNYTvjEaD12bWgL8I9o01QxD3Ax62ZMDCuXLw3MNibtjpTICkh
   jOAqTT5kpJ0Szae5l2a4xzLu6wU5rqverxO2P0q1e234yxoJROSDN5/V3
   87nVhY5S8BIwaMRHaChmpJcAu9LfnhzIQZmMhOgzk2sH90Pz2OXLaLTYk
   Q==;
X-CSE-ConnectionGUID: Qfh1kAkDSnqogxJSvELKkg==
X-CSE-MsgGUID: 5WDSAQwkT7Gyg4pHSqZrkQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12498190"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12498190"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 18:26:04 -0700
X-CSE-ConnectionGUID: SI+sGxD1SaWg/GFY7brOWg==
X-CSE-MsgGUID: db5ZHzgxSsuIxnX9A7ZDYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="36786047"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa005.fm.intel.com with ESMTP; 19 May 2024 18:26:01 -0700
Message-ID: <79bacf16-dfa6-42c7-b02d-117985e38472@linux.intel.com>
Date: Mon, 20 May 2024 09:24:09 +0800
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
>> +static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user
>> *buf,
>> +					size_t count, loff_t *ppos)
>> +{
>> +	size_t response_size = sizeof(struct iommu_hwpt_page_response);
>> +	struct iommufd_fault *fault = filep->private_data;
>> +	struct iommu_hwpt_page_response response;
>> +	struct iommufd_device *idev = NULL;
>> +	struct iopf_group *group;
>> +	size_t done = 0;
>> +	int rc;
>> +
>> +	if (*ppos || count % response_size)
>> +		return -ESPIPE;
>> +
>> +	mutex_lock(&fault->mutex);
>> +	while (count > done) {
>> +		rc = copy_from_user(&response, buf + done, response_size);
>> +		if (rc)
>> +			break;
>> +
>> +		if (!idev || idev->obj.id != response.dev_id)
>> +			idev = container_of(iommufd_get_object(fault->ictx,
>> +							       response.dev_id,
>> +
>> IOMMUFD_OBJ_DEVICE),
>> +					    struct iommufd_device, obj);
>> +		if (IS_ERR(idev))
>> +			break;
>> +
>> +		group = xa_erase(&idev->faults, response.cookie);
>> +		if (!group)
>> +			break;
> is 'continue' better?

If we can't find a matched iopf group here, it means userspace provided
something wrong. The current logic is that we stop here and tell
userspace that only part of the faults have been responded to and it
should retry the remaining responses with the right message.

Best regards,
baolu
