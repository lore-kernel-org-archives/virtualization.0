Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB3D381C8
	for <virtualization@lists.linux-foundation.org>; Sun, 19 May 2024 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716113381; cv=none; b=O41KNyz3ffqMYN+n5+HCbQI2eTruzLevtiap08P5Yqj//4N5hcSsraCCczZUbLA+pLqVZxUYGGdc76yPERyXM1JPa3pgmOVBhtC2ubOlXckiJ4jeiflCTXeSY9PIZsWcC6gwjGutPq5MDRmgi7e+j0G8PCGAqGQDUAzaMdBwTaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716113381; c=relaxed/simple;
	bh=3pqbNvdYRhWc2XQ8kSFBcuNQeXXTsBDv7SxsX1AkypM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=prOv7jFzCfQvBHpvhYpxm5VISnpWTlzIs/DkPk5Bb9Ejmf6bfIUSigE1+I5/xpCgU0qsRFNR2EIGcmi/oikOVujpFJ8m+JR+GIAVK6Fb4hWCBmEqS82Esps9/r8JSvLRm4dW6orzWEmzKu3M3r9rGOOI67bgHzHAO55KfxdyoII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OI8ulXXA; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OI8ulXXA"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ED1EA605EE
	for <virtualization@lists.linux-foundation.org>; Sun, 19 May 2024 10:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 92mGqF9Soo9x for <virtualization@lists.linux-foundation.org>;
 Sun, 19 May 2024 10:09:38 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 56017605E6
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 56017605E6
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OI8ulXXA
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 56017605E6
	for <virtualization@lists.linux-foundation.org>; Sun, 19 May 2024 10:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716113379; x=1747649379;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3pqbNvdYRhWc2XQ8kSFBcuNQeXXTsBDv7SxsX1AkypM=;
  b=OI8ulXXAxJZAcVRtyvpO5ZFUNqUlfdyMKg4/CS08Adk3gHhVZzRAuSIg
   UtrTiLNVjzcFnyl00Zvlsk12cGSv2RCMqCIZOaia2F3UmfXHGxFfxwlAy
   1h1uYm3QRvWsKz5W3aEkYS0NgadlOlZ7x9mmpyaOrIUGMVT0iElFl0Igx
   MV0oU4RPYv3a0TbEDj46SAF4S6zYPrwEQd2PPueTF1TwgEX/5EuzOIzZY
   haNILIXojxGum1qsT/2vbLlgBH7cPVf5kj1qAftgS8tgOOq5dsNUWRbPd
   yNKq4n7WAeLCp4y9b0tTIhWoFfOINRrcvaMGqyBdICXjQa6tNoc3MqiZY
   A==;
X-CSE-ConnectionGUID: x8onXzy0SYSVH4BEMlUC6A==
X-CSE-MsgGUID: x1JEmLzXRsueagnYbw7ydg==
X-IronPort-AV: E=McAfee;i="6600,9927,11076"; a="12422247"
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="12422247"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 03:09:37 -0700
X-CSE-ConnectionGUID: Fz4KnX5YTNaXWKsOX48Lkg==
X-CSE-MsgGUID: TmitfyhdQs++X2CiWV1/2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,172,1712646000"; 
   d="scan'208";a="37168261"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 19 May 2024 03:09:33 -0700
Message-ID: <6b0529a9-b1c6-44ba-8c45-ad233de6484e@linux.intel.com>
Date: Sun, 19 May 2024 18:07:42 +0800
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
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v5 1/9] iommu: Introduce domain attachment handle
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-2-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F0DAE4B5F63513C38A158CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F0DAE4B5F63513C38A158CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 3:17 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 30, 2024 10:57 PM
>>
>> +/* Add an attach handle to the group's pasid array. */
>> +static struct iommu_attach_handle *
>> +iommu_attach_handle_set(struct iommu_domain *domain,
>> +			struct iommu_group *group, ioasid_t pasid)
>> +{
>> +	struct iommu_attach_handle *handle;
>> +	void *curr;
>> +
>> +	handle = kzalloc(sizeof(*handle), GFP_KERNEL);
>> +	if (!handle)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	handle->domain = domain;
>> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, handle,
>> GFP_KERNEL);
> 
> this could be just xa_insert() which returns -EBUSY if the entry isn't NULL.

Yes, exactly.

> 
>> +	if (curr) {
>> +		kfree(handle);
>> +		return xa_err(curr) ? curr : ERR_PTR(-EBUSY);
> 
> 'curr' is not an error pointer. You need ERR_PTR(xa_err(curr)).

Fixed.

> 
>>   int iommu_attach_group(struct iommu_domain *domain, struct
>> iommu_group *group)
>>   {
>> +	struct iommu_attach_handle *handle;
>>   	int ret;
>>
>>   	mutex_lock(&group->mutex);
>> +	handle = iommu_attach_handle_set(domain, group,
>> IOMMU_NO_PASID);
>> +	if (IS_ERR(handle)) {
>> +		ret = PTR_ERR(handle);
>> +		goto out_unlock;
>> +	}
>>   	ret = __iommu_attach_group(domain, group);
>> +	if (ret)
>> +		goto out_remove_handle;
>>   	mutex_unlock(&group->mutex);
> 
> It's slightly better to set the handler after __iommu_attach_group().
> 
> doing so is aligned to the sequence in iommu_group_replace_domain().

I did it in this way because erasing an attach handle is easier than
rolling back the group to the previous domain from the perspective of
coding. I didn't realize attaching the group and storing the attach
handle had to be done in a specific order.

> 
>> @@ -2211,13 +2307,33 @@ EXPORT_SYMBOL_GPL(iommu_attach_group);
>>   int iommu_group_replace_domain(struct iommu_group *group,
>>   			       struct iommu_domain *new_domain)
>>   {
>> +	struct iommu_domain *old_domain = group->domain;
>> +	struct iommu_attach_handle *handle;
>>   	int ret;
>>
>>   	if (!new_domain)
>>   		return -EINVAL;
>>
>> +	if (new_domain == old_domain)
>> +		return 0;
>> +
> 
> __iommu_group_set_domain() already does the check.

Removed.

Best regards,
baolu
