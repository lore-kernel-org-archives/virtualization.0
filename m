Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C9B2628B
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Feb 2024 07:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500513; cv=none; b=Cv/jdCx5ZTMYVJ7rZEn7tGOqW1nXBPBAxmmMz60MtDegBZt/MO/FjzoNwdcD7jYTT0MpphWA4AYR8oM2qkIulCr0UpZKGPCxLI3YNDKPMIun/XSxtb11NtpO++VXrMNGPLv7D4Cm7EPgCygqqI6ecMXxfDWS+kciN5f6wFvvjrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500513; c=relaxed/simple;
	bh=IoYu+i7KKnzz4BOoEaK041vDn3DjPnDvaToCAeVuexQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bpKknTKCjNq+N2bSKPLRyhCKdGOMATflUySLV/0F68PSuoIoToo0/Pb/vSUiyOwPYGh/RaXc7QAZ+LzyYB30RybXNV7EJwMy2fX5GIjSTERwF6XKjyWWbTsBEL+H+L3yiQ3pGMoFwyE0q60DomBZoeK5rrtkvv8jG3WCmjIPSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KFb3VGxi; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KFb3VGxi"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A7D4C60DFF
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Feb 2024 07:28:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3KWK9X4Vyx_D
	for <virtualization@lists.linux-foundation.org>;
	Wed, 21 Feb 2024 07:28:31 +0000 (UTC)
X-Greylist: delayed 427 seconds by postgrey-1.37 at util1.osuosl.org; Wed, 21 Feb 2024 07:28:30 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C1EC960B8C
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C1EC960B8C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KFb3VGxi
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.20; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	by smtp3.osuosl.org (Postfix) with ESMTPS id C1EC960B8C
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Feb 2024 07:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708500511; x=1740036511;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IoYu+i7KKnzz4BOoEaK041vDn3DjPnDvaToCAeVuexQ=;
  b=KFb3VGxiG2j0T+Sqg5/q4Clpfbfn6TgXNHi8CM5jjCCcWiIZBZgLH5pb
   3dI6i/aD2qhDjzPkJX/JCuMIb4jyhL79yLCKWuXhlwalWYUa7kJRfeiv0
   4J8tvDFiNg/SwtDzm97wfYvY5k39ukTkbbyJAHsgUjGJgVQ4KztZ0+SIC
   af7RAhW4j2sKIFjONI7La+TM2gDj3rdDy0eZg4dMQ5Z8kMa3CXSpdvR1w
   K0+DJ93InihvTnbwjow7326rilU+1kaSZa2RCl881hPcG7wQRq9mm2Ib/
   cR0Plhvu9trptfXJAdnuP257xq/7901AHYzi0zHxFS1mmdRasIgwHr4OP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2516574"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2516574"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:21:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="42523584"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.203]) ([10.249.171.203])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:21:15 -0800
Message-ID: <e77922a5-89d3-4036-8d98-9c3fbef4f39c@linux.intel.com>
Date: Wed, 21 Feb 2024 15:21:12 +0800
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
 <b0f5e418-8faa-45d1-b086-61f6c009c0cb@linux.intel.com>
 <BN9PR11MB5276151E34AC91883986A39D8C572@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276151E34AC91883986A39D8C572@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/21 14:49, Tian, Kevin wrote:
>>>> +struct iopf_attach_cookie {
>>>> +	struct iommu_domain *domain;
>>>> +	struct device *dev;
>>>> +	unsigned int pasid;
>>>> +	refcount_t users;
>>>> +
>>>> +	void *private;
>>>> +	void (*release)(struct iopf_attach_cookie *cookie);
>>>> +};
>>> this cookie has nothing specific to iopf.
>>>
>>> it may makes more sense to build a generic iommu_attach_device_cookie()
>>> helper so the same object can be reused in future other usages too.
>>>
>>> within iommu core it can check domain iopf handler and this generic cookie
>>> to update iopf specific data e.g. the pasid_cookie xarray.
>> This means attaching an iopf-capable domain follows two steps:
>>
>> 1) Attaching the domain to the device.
>> 2) Setting up the iopf data, necessary for handling iopf data.
>>
>> This creates a time window during which the iopf is enabled, but the
>> software cannot handle it. Or not?
>>
> why two steps? in attach you can setup the iopf data when recognizing
> that the domain is iopf capable...

Oh, maybe I misunderstood. So your proposal is to make the new interface
generic, not for iopf only?

Best regards,
baolu
