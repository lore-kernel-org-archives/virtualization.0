Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DC5132106
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 04:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718254233; cv=none; b=QN4mdcPqbqcQIOyIndQO/AnHG8PQzXzX21aPWCADlQkfHdC1a++uDdhzMzr3W5kU+rb7vW5ertuW0ajkIiMgslaNaNTUTZ59cSHAywi5te9Moy/gvzHQiRoswAj5DbNv19DjPkjurkYRuVb2nbvZQg4ER/AaEWmekcVczpyInF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718254233; c=relaxed/simple;
	bh=CZrtrf8crQja7wO1mkA1ifii1KCTrpRJ1BM17B9Ba/8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u6pcidNZysBzxvpEccN0T3k8Gq0CwN90Rkt3WLN2LWaJ0Y+zJg6YszZyqzd0uvlnFDd9kIGTNNDW6abMW1KuaGw4UsCjnRyby177BrRVVghbgpEG8HX04oqL9TUYpf8l3hYHc2Rycv0eOrNntqPIbopdJ4ld57HBWd8uuQm3Grw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N4wvlk5l; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N4wvlk5l"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 033616070D
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 04:50:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o68McOabTuYF for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 04:50:31 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 191E36070C
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 191E36070C
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N4wvlk5l
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 191E36070C
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 04:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718254231; x=1749790231;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CZrtrf8crQja7wO1mkA1ifii1KCTrpRJ1BM17B9Ba/8=;
  b=N4wvlk5lVjJQmu5RsxRLYH4xU4dhrrJQnbqaqoQ9mFNNwbzWzVSjcibT
   suplQ5bxNtgLGSmQJHIRDZttIHcJA+iZSK5oj05enPvMmz5cah98vrvPT
   r3o5LckztiGEqWVz54kcflPJzrZigIVvz5ciWGQG9VcROjfOxMxncSX7j
   DN1+hTbWhOoHkXV8TfkI72JaZU9+o/7Eb0NrFpE6XIjgWtmtXOEHbujjs
   9OwycUItbDQ3ji328eIzmD4rJLupUfq7Xj0jLO9dFLZQmlmUlk73UFanE
   se81MqliZKqqiq8z5YQ9NVIu3xMa+rJnnu/oOEl1l1PiJVqHPpzZ7uu6p
   A==;
X-CSE-ConnectionGUID: g8L64AEWRG6l9djdOQL29Q==
X-CSE-MsgGUID: yWsWVPcPRkWUJylZGjQHgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="12047532"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="12047532"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 21:50:18 -0700
X-CSE-ConnectionGUID: x5UnoJ9AQvmH++aW966J8w==
X-CSE-MsgGUID: eiM8bmmaTjywYF1Vu6P/KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="44968157"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa005.jf.intel.com with ESMTP; 12 Jun 2024 21:50:15 -0700
Message-ID: <bc702b48-627f-4145-8c9b-684880a73edb@linux.intel.com>
Date: Thu, 13 Jun 2024 12:47:55 +0800
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
Subject: Re: [PATCH v6 04/10] iommu: Extend domain attach group with handle
 support
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-5-baolu.lu@linux.intel.com>
 <20240612134120.GX791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612134120.GX791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:41 PM, Jason Gunthorpe wrote:
> On Mon, May 27, 2024 at 12:05:11PM +0800, Lu Baolu wrote:
>> Unlike the SVA case where each PASID of a device has an SVA domain
>> attached to it, the I/O page faults are handled by the fault handler
>> of the SVA domain. The I/O page faults for a user page table might
>> be handled by the domain attached to RID or the domain attached to
>> the PASID, depending on whether the PASID table is managed by user
>> space or kernel. As a result, there is a need for the domain attach
>> group interfaces to have attach handle support. The attach handle
>> will be forwarded to the fault handler of the user domain.
>>
>> Add some variants of the domain attaching group interfaces so that they
>> could support the attach handle and export them for use in IOMMUFD.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu-priv.h |  8 +++
>>   drivers/iommu/iommu.c      | 99 ++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 107 insertions(+)
> I don't have an objection to it like this, but I wonder if we could be
> smaller to teach iommu_attach_device_pasid to use IOMMU_NO_PASID to
> attach the handle to the rid?
> 
> It would have an if there to call the  __iommu_attach_group() instead
> of the pasid attach ?

This is a good idea. I guess that in the future, we will have
iommu_attach_device_pasid(IOMMU_NO_PASID) to replace
iommu_attach_group(). The group->domain and domain_ops::attach_dev will
also be removed.

I'd suggest making such refactoring in a separate series with wider
discussions. For now, let's make this special interface for iommufd.

Best regards,
baolu
