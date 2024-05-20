Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166829A0
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 00:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716165813; cv=none; b=YjNAfM47TH4Q0D8BRTpIOzSs1dVDZERAcccpNh0W47Gl8TVfDNkEFcyKhUOsps5lN5yTU4Yq13eWU1zVGLtq2DWghoB+N1vk0cL7qKqqpgC312LrF5ZYQ40MkrHr7hHYTIQHbTozHhgaQMtu85zc26bdMGGDizmjJi5DkIRodHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716165813; c=relaxed/simple;
	bh=aVkcrnGQ/nxpvAqMCgMiaH8kqQb8EwrY1QZoYulcowE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gFyRD4rFaet1pct7irth23Oe9EryYM7y4v00FTba+VRjQaaYueBelI/93D5LeCzCYlhS3g4BjAqq61CM7yHAnmjofuyflOINM81CbEHd/92xec8k2yXLD4HAXYW/K6DXEoIoObnNm1s0cbtT6JpUtHj1oTpw3BWxgjGCKz43FZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IHl81CXH; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IHl81CXH"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id EDF33404B8
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 00:43:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f6luuM4yUwYp for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 00:43:31 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.14; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org B925E40459
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B925E40459
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IHl81CXH
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B925E40459
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 00:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716165811; x=1747701811;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aVkcrnGQ/nxpvAqMCgMiaH8kqQb8EwrY1QZoYulcowE=;
  b=IHl81CXHa25urb0+Ywjl6ykvyDnADX/vxRjGvnsHk48NJKwD4SN4Kvx6
   Zw2g6bRLElXE0Zlgf8/OJ/r3plFrQP3w3eZYaNB4ha67Q8zQGa3GLFZG/
   Mi2BMA9cFsAutfQn2jP3wIwO3sFps1urxOj6duF0CakKN4OLhlcRVrDwc
   nIvc+g9/gXvuuyyFWFZxn4JYIBfuC0K6futDEH+Qia3C3p8i1d39hNjQp
   y5XI5DI3JfZwbaqsMB2JAEk249LzX3BuyLrLCht++Zor9paIZyROLKJx+
   HRI9ia5462RUP+683f6Ym4njbnmStjnSmJ8wLp8/IXDVs2AUuqoez8HDz
   g==;
X-CSE-ConnectionGUID: +aUOESPdRaq+OcdP4YyNQQ==
X-CSE-MsgGUID: qyv4+y+1SCa2CvYZCTc6sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12496277"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12496277"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 17:43:29 -0700
X-CSE-ConnectionGUID: xB/Je+3AS+2QgXYP1HQUBQ==
X-CSE-MsgGUID: T0vAkOzoRNiMFMYQpVpi/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="32500338"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 19 May 2024 17:43:18 -0700
Message-ID: <733e3788-d303-4b75-aa97-d97489a7f0bf@linux.intel.com>
Date: Mon, 20 May 2024 08:41:26 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <20240508001121.GN4718@ziepe.ca>
 <a03d3bf6-0610-427c-bf2a-5f6c410e220e@linux.intel.com>
 <BN9PR11MB5276F21755C883FE7EC784228CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F21755C883FE7EC784228CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 3:57 PM, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, May 8, 2024 6:05 PM
>>
>> On 2024/5/8 8:11, Jason Gunthorpe wrote:
>>> On Tue, Apr 30, 2024 at 10:57:06PM +0800, Lu Baolu wrote:
>>>> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>>>> index ae65e0b85d69..1a0450a83bd0 100644
>>>> --- a/drivers/iommu/iommu-priv.h
>>>> +++ b/drivers/iommu/iommu-priv.h
>>>> @@ -36,6 +36,10 @@ struct iommu_attach_handle {
>>>>    			struct device	*dev;
>>>>    			refcount_t	users;
>>>>    		};
>>>> +		/* attach data for IOMMUFD */
>>>> +		struct {
>>>> +			void		*idev;
>>>> +		};
>>> We can use a proper type here, just forward declare it.
>>>
>>> But this sequence in the other patch:
>>>
>>> +       ret = iommu_attach_group(hwpt->domain, idev->igroup->group);
>>> +       if (ret) {
>>> +               iommufd_fault_iopf_disable(idev);
>>> +               return ret;
>>> +       }
>>> +
>>> +       handle = iommu_attach_handle_get(idev->igroup->group,
>> IOMMU_NO_PASID, 0);
>>> +       handle->idev = idev;
>>>
>>> Is why I was imagining the caller would allocate, because now we have
>>> the issue that a fault capable domain was installed into the IOMMU
>>> before it's handle could be fully setup, so we have a race where a
>>> fault could come in right between those things. Then what happens?
>>> I suppose we can retry the fault and by the time it comes back the
>>> race should resolve. A bit ugly I suppose.
>>
>> You are right. It makes more sense if the attached data is allocated and
>> managed by the caller. I will go in this direction and update my series.
>> I will also consider other review comments you have given in other
>> places.
>>
> 
> Does this direction imply a new iommu_attach_group_handle() helper
> to pass in the caller-allocated handle pointer or exposing a new
> iommu_group_set_handle() to set the handle to the group pasid_array
> and then having iomm_attach_group() to update the domain info in
> the handle?

I will add new iommu_attach/replace/detach_group_handle() helpers. Like
below:

+/**
+ * iommu_attach_group_handle - Attach an IOMMU domain to an IOMMU group
+ * @domain: IOMMU domain to attach
+ * @group: IOMMU group that will be attached
+ * @handle: attach handle
+ *
+ * Returns 0 on success and error code on failure.
+ *
+ * This is a variant of iommu_attach_group(). It allows the caller to 
provide
+ * an attach handle and use it when the domain is attached. This is 
currently
+ * only designed for IOMMUFD to deliver the I/O page faults.
+ */
+int iommu_attach_group_handle(struct iommu_domain *domain,
+                             struct iommu_group *group,
+                             struct iommu_attach_handle *handle)

Best regards,
baolu
