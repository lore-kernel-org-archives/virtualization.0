Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8EF1822DA
	for <virtualization@lists.linux-foundation.org>; Fri, 14 Jun 2024 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718327965; cv=none; b=VseHtu9H6rKzE/qPvGfSyPGO/3Pudmthbu/SrIdmdJkfGaCeKkrh18llXSdKXXKfeMET3nvPBnlDiCnVne2KiOJPt1aclKYf/HSenxkecK6RhdSs/k5vtx/x+S0xXg0x+aVXfz1aJWL12B6INLqZR5LgwaBh4rmHZZ0u9IAW9tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718327965; c=relaxed/simple;
	bh=Y3xFmer/bJb5jwuUcExtgxCX4BjTUCWoKsvdsQB96HE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fGnjODLrndsrIar+EmL3sXC/P/MBnK2fA10iZKjCVMehRzzvssWa/z/29OE/6Oddek2Rrze4ctFLlFYY7QL7Xiu2qOTFQS2glDD+Cm2IJaCz4JO4Ujj9eClITGOTMk+Po0vJbGL9tDko6s0SM/oIr0+SfMxXrRiz2bP/t/pScxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/EEL0Pi; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/EEL0Pi"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7A1954015D
	for <virtualization@lists.linux-foundation.org>; Fri, 14 Jun 2024 01:19:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id c6kZkpGFF_FE for <virtualization@lists.linux-foundation.org>;
 Fri, 14 Jun 2024 01:19:22 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 459EF4015A
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 459EF4015A
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k/EEL0Pi
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 459EF4015A
	for <virtualization@lists.linux-foundation.org>; Fri, 14 Jun 2024 01:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718327963; x=1749863963;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y3xFmer/bJb5jwuUcExtgxCX4BjTUCWoKsvdsQB96HE=;
  b=k/EEL0Pi2nrMFMySbi+trWbj7y2B5HFbrQusavkupQ5/naCySgLkMXVm
   lkF5Zp9EPCcvTwiyVtwgBpjXhCdZXV7aMQ9KTpc+N0B424TTkpRb+zPcu
   M5UxWIwowiAABSzKXVz6C1EaJRcdTXrmAgx85rP31ckChEURskqUSGFed
   abKFBAhC4Yotq+qNcO0jLkg/d5hVEGNSfXgvJzDfdpktEUHFeqDO2lgfj
   eIthLqBR2x1fLlFqiVD0as2yuZ0YEF7DKNe6NPX9IP4F3x80en7CfsMzr
   R7jCD2vFpXhL2WiWxTDf/77n624QUD1puu+6t2TYWIsBkpFjtTObNCiki
   A==;
X-CSE-ConnectionGUID: 9oM4DiTsTByrKh7cxF10qw==
X-CSE-MsgGUID: PJWTqF3IS1uJPeoxc5wpsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15346727"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15346727"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 18:19:22 -0700
X-CSE-ConnectionGUID: srtDBUcgR/GMQOGdRXhpKQ==
X-CSE-MsgGUID: B49IlPj3TwGU3zZoYVf2og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="40266698"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa010.jf.intel.com with ESMTP; 13 Jun 2024 18:19:18 -0700
Message-ID: <1a053b9c-6cbf-4b8c-9d23-731b8a22c747@linux.intel.com>
Date: Fri, 14 Jun 2024 09:16:58 +0800
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
Subject: Re: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-4-baolu.lu@linux.intel.com>
 <20240612133732.GW791043@ziepe.ca>
 <013afe9a-756f-4c85-baa1-977bea6be395@linux.intel.com>
 <20240613114948.GA791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240613114948.GA791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 7:49 PM, Jason Gunthorpe wrote:
> On Thu, Jun 13, 2024 at 12:23:17PM +0800, Baolu Lu wrote:
> 
>>   struct iommu_ops {
>>          bool (*capable)(struct device *dev, enum iommu_cap);
>> @@ -600,6 +598,7 @@ struct iommu_ops {
>>          struct iommu_domain *blocked_domain;
>>          struct iommu_domain *release_domain;
>>          struct iommu_domain *default_domain;
>> +       bool user_pasid_table;
>>   };
> Yeah, maybe spell it
> 
>    u8 user_pasid_table : 1;

Done.

Best regards,
baolu
