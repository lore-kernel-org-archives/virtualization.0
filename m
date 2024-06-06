Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECC822338
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717654819; cv=none; b=KP5qMfmLUeYcaNep+s1mm9LupWOVEx1N1mGipy/edDB/r25QxKOZfrXFlzMl6W34rCttQqo0fAeBwFMaK+FNhMTHrXzUQ+9a0xxZKA/vPje3VmRN2WLWCHDZ3NoanFDPOk1NZ6wtKk/7PZssx5iv2e0viiil/1zwXWicUsf3NKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717654819; c=relaxed/simple;
	bh=VhWurgY4SNYpQC5RgKYTiiS00Kxh5m8ta7BWoyK0uds=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C18CKxSub2pDVuIzebCdDRK5ie20MC9loJWDTRDE8GDkajhldSrt4ZkiV6aKp6MD7tkDMaJYdMzaNh8I0BQW5Sl3Ha28jR8VyhQA+VS7DPJ58dFJiQQ+T3cdz5ZeUUs+98O8JI+kNV1Dsj9wInuYwNY68n5EV5oaRE+HFfzfmLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DoKv4M2u; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DoKv4M2u"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7419942417
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 06:20:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PMNl_VQGx-Vn for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Jun 2024 06:20:16 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.10; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3F82742414
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3F82742414
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DoKv4M2u
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3F82742414
	for <virtualization@lists.linux-foundation.org>; Thu,  6 Jun 2024 06:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717654816; x=1749190816;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VhWurgY4SNYpQC5RgKYTiiS00Kxh5m8ta7BWoyK0uds=;
  b=DoKv4M2uJOwHlPwYEh3fjsaadaYEq/oLuaxsj95vADYZHpNRZS4lrl+R
   ZujdpuTk3FvYNGlgJ/EjIWFRYAQdW9dwJKI+TC74JuyClavJdUGgAjt+o
   JfdRz4pngkg9gZmjMxt2DgPyI0oLvxS/TofBrc7YLl14fxbOECK+bV0go
   5mE2wyG61piFWaJJ8UkrrAbMZGgTo8Id3coBoowAoMp7+MJ2KbyRNqrl9
   xJ5cEmXzQ9YsEE1QSBBDBk+JO9r5pWUjtOMho0jtLkyydxp9itshKtYEC
   b3apEq5DHvrmK9QzGDWuPVO+EyZMdJ49Wxl74tuQteY2Kt8h7LHVd2pIT
   Q==;
X-CSE-ConnectionGUID: YFJ752lpRW2YEtOi7t3GiA==
X-CSE-MsgGUID: ZVBHzj0SRsGnwr/0pF/WUA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="25700802"
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="25700802"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 23:20:16 -0700
X-CSE-ConnectionGUID: 2MuqxhvNRnuxX+F/PpqWBw==
X-CSE-MsgGUID: /4JIvm5/TUqS0kZTFBMszw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,218,1712646000"; 
   d="scan'208";a="61056085"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa002.fm.intel.com with ESMTP; 05 Jun 2024 23:20:12 -0700
Message-ID: <26f7e8b4-7702-4aa5-b370-b529df21e0c1@linux.intel.com>
Date: Thu, 6 Jun 2024 14:18:02 +0800
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
Subject: Re: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52764CBD6B889A07A8CCB4918CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764CBD6B889A07A8CCB4918CF92@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/24 4:23 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 27, 2024 12:05 PM
>>
>> @@ -249,6 +249,12 @@ enum iommu_cap {
>>   	 */
>>   	IOMMU_CAP_DEFERRED_FLUSH,
>>   	IOMMU_CAP_DIRTY_TRACKING,	/* IOMMU supports dirty
>> tracking */
>> +	/*
>> +	 * IOMMU driver supports user-managed IOASID table. There is no
>> +	 * user domain for each PASID and the I/O page faults are forwarded
>> +	 * through the user domain attached to the device RID.
>> +	 */
>> +	IOMMU_CAP_USER_IOASID_TABLE,
>>   };
> 
> Given all other context are around PASID let's just call it as USER_PASID_TABLE.
> 
> btw this goes differently from your plan in [1] which tried to introduce
> different nesting types between Intel and other vendors.
> 
> I guess the reason might be that you want to avoid getting the handle
> for RID on Intel platform in case of failing to find the handle for the
> faulting PASID. and save a new domain type.
> 
> this looks fine to me but should be explained.

Yeah! I was considering this in two aspects and chose this simple
solution in the end.

- If we choose to add a new domain type, we need to change iommufd,
   iommu core and the individual driver. That seems too complicated to
   address a small issue here.

- Fundamentally, this is a hardware implementation difference, hence use
   the existing per-device iommu capability interface sounds more
   reasonable.

> 
> [1] https://lore.kernel.org/linux-iommu/0de7c71f-571a-4800-8f2b-9eda0c6b75de@linux.intel.com/
> 

Best regards,
baolu
