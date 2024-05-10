Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6A3149005
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310968; cv=none; b=OgTLEg4nuVTDudwsES4FeZZ75YXIpgfO+LLlttkybcapiUSaYa+i+Wj1ADHSmwE2exFTIZz5wGQHWKFmCOI4PnpR7XbXrHQaNxvA4AnXmSPot/kFmAQfA7pa28XZYH2RxOlGMeO/NDft8eQLE8NWo+2v7cp7+2lzjFugHLnzKWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310968; c=relaxed/simple;
	bh=pDWGi20NXI+FF8nL+CvvJf3mfQcL2cl7VqETYXjiX7k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KD6h1ExCqbJzBpcwmeDwE7z9o9ojRTZUicHC+eghB1aRgmbJwqZtyVXHanrwpEWmX16ZpW0PEk/ceadrY/Jd1PH6XDRA9Vw4repOaNd3p+qhULeUGMTJzXfSI+ooRGwCaajSzMnp8jGzc7ihNrxF4+9Y9DnVorGrkZgcryZr/Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MSEW/QLt; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MSEW/QLt"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DEF261477
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 03:16:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MW46OFA-KC4S for <virtualization@lists.linux-foundation.org>;
 Fri, 10 May 2024 03:16:05 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.21; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7E3246125E
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7E3246125E
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=MSEW/QLt
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7E3246125E
	for <virtualization@lists.linux-foundation.org>; Fri, 10 May 2024 03:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715310966; x=1746846966;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pDWGi20NXI+FF8nL+CvvJf3mfQcL2cl7VqETYXjiX7k=;
  b=MSEW/QLtSsLaB49uZFjY6QSD97wRNGT5AFt1JkABUAKpPXsvIgP6Po15
   j08YK2PE10QakhrJb3+BkbMiXC2k+tsOK/yq590qepl3zkZZZMo3Y0iTe
   sML2Xx1BOaOGrFOzXXS3F05LJ4nloz85wfLRHxVe+At20FNMLMWtZHqip
   DbWb3iQC44kAOOvTNgSBUwobAT6Jv+/gM6LqOp9SfrY2s/7fLgrrCh/rC
   sPVAdp/C1b9vKLb7vOgf5i8dNcj8PZ/esrlHuSKpluPn4Tc05jzXS6Hsg
   1NToL/fyhUmGmqG3W9fA4Gpke0hz7KLQ9gaPRFpPHkN9Fc52hmFR7k6aK
   A==;
X-CSE-ConnectionGUID: 4gCpC/MjSgC3Qt218v+Nbw==
X-CSE-MsgGUID: 6fKDF2aSTv6QLaPLLTuozA==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="11209006"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="11209006"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 20:16:05 -0700
X-CSE-ConnectionGUID: 6k3t8mu3T5CHeD2PV0HUGg==
X-CSE-MsgGUID: yA5s8BzaQkajU6Im3Oq7sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="34324289"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 09 May 2024 20:16:01 -0700
Message-ID: <21ffbcc7-1103-4481-af14-5ee8856b9625@linux.intel.com>
Date: Fri, 10 May 2024 11:14:20 +0800
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
Subject: Re: [PATCH v5 3/9] iommu: Add attachment handle to struct iopf_group
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-4-baolu.lu@linux.intel.com>
 <20240508000454.GM4718@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240508000454.GM4718@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/24 8:04 AM, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 10:57:04PM +0800, Lu Baolu wrote:
>> @@ -206,8 +197,11 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>>   	if (group == &abort_group)
>>   		goto err_abort;
>>   
>> -	group->domain = get_domain_for_iopf(dev, fault);
>> -	if (!group->domain)
>> +	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ||
>> +	    get_attach_handle_for_iopf(dev, fault->prm.pasid, group))
>> +		get_attach_handle_for_iopf(dev, IOMMU_NO_PASID, group);
> That seems a bit weird looking?

Agreed.

> get_attach_handle_for_iopf(dev,
>     (fault->prm.flags &
>     IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) ? fault->prm.pasid : IOMMU_NO_PASID,
>     group);

The logic here is that it tries the PASID domain and if it doesn't
exist, then tries the RID domain as well. I explained this in the commit
message:

"
... if the pasid table of a device is wholly managed by user space,
there is no domain attached to the PASID of the device ...
"

Perhaps I can improve it like this,

	int rc = -EINVAL;
	...
	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
		rc = get_attach_handle_for_iopf(dev, fault->prm.pasid, group);
	if (rc)
		rc = get_attach_handle_for_iopf(dev, IOMMU_NO_PASID, group);

	if (rc || !group->attach_handle->domain->iopf_handler)
		goto err_abort;

Best regards,
baolu
