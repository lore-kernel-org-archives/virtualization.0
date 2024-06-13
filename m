Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2875113791E
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718260965; cv=none; b=CbEU5p0DvdCzpAxA/OTUsXPc0vY2hfKuTEig5m/ydn7rDm6NX6vAsCKJRlK3nOWXcH+Fyt01Q8eMJGhXfUacCM7tHVOQ2GTZ8zQov2LGNq3gkMwEjtV0Orccs6AxIhDO/0ITlf2qJJl5TeVUjEmW09tE/K8cMzOTIlG4+zAanXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718260965; c=relaxed/simple;
	bh=nih8HgDoXnDxJo9FTwV8yzVyB7RsNmA2vKpkgq0mT6g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KxOOYkDZr5Qw++u9Yl2taSUFbb3Y8YvoZgfITEaklDhbEyVnDIVdW0o+NA48xCriPlN0+LLM7ermEQGOVjZklvhG4GAo41PktxGhqltFY47o9+yRtoWO5Jrk1ouNhnGp6O3+p2n1tOD1WvtvJukey0FojHg8Zq9iGl2FEIsEE24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I+VYC/Qq; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I+VYC/Qq"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C611C841E3
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:42:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MzrjQGnLoO2t for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 06:42:43 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 15A3A82C04
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 15A3A82C04
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I+VYC/Qq
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 15A3A82C04
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 06:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718260962; x=1749796962;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nih8HgDoXnDxJo9FTwV8yzVyB7RsNmA2vKpkgq0mT6g=;
  b=I+VYC/QquUwNqpghTZU1Egjuine3cxWmjK51W6Fkz9v3tR+Tfkkis/iT
   7osyALOCN8/KFrv7FvaS9Am22zOHsYXy9tf2qvMzofkuW5kxOXMmXr5Fe
   VFNuMuF9K0nW0n7s71t1Bwi13j6KLxn4VyvNf3WtcOy4gZxQVjidM8gWk
   0LtShvXebbdezWf/tRgKg2DI3+bfBjV56IPgVC3rwLMxs7M+LD+n0VVGb
   tWvrrbJ0pIoUNd7E8LcSgBmA5L5CuT5/yeIGFU9l9cKpgjRhNe25L4E9P
   mFwiqLwy7+9hSTbHxOVykdZIAMRaV+Vpa1Ze5cnJUbRyO0zjr1389n1Ph
   Q==;
X-CSE-ConnectionGUID: ocgxbkgpThqFa1Hktw/qsA==
X-CSE-MsgGUID: 26g5gP/dQ9CmgTe3zY33jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32546265"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="32546265"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 23:42:40 -0700
X-CSE-ConnectionGUID: nMJpsTrOTnS0VSuRh0vJ5w==
X-CSE-MsgGUID: I3OWTSD2SEOg9c+X370K5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="45167888"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 12 Jun 2024 23:42:37 -0700
Message-ID: <247f231c-3829-49c2-a8d9-11c3cc4b80ca@linux.intel.com>
Date: Thu, 13 Jun 2024 14:40:18 +0800
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
Subject: Re: [PATCH v6 05/10] iommufd: Add fault and response message
 definitions
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-6-baolu.lu@linux.intel.com>
 <20240612135219.GZ791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612135219.GZ791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:52 PM, Jason Gunthorpe wrote:
> On Mon, May 27, 2024 at 12:05:12PM +0800, Lu Baolu wrote:
>> +/**
>> + * struct iommu_hwpt_pgfault - iommu page fault data
>> + * @size: sizeof(struct iommu_hwpt_pgfault)
>> + * @flags: Combination of enum iommu_hwpt_pgfault_flags
>> + * @dev_id: id of the originated device
>> + * @pasid: Process Address Space ID
>> + * @grpid: Page Request Group Index
>> + * @perm: Combination of enum iommu_hwpt_pgfault_perm
>> + * @addr: Fault address
>> + * @length: a hint of how much data the requestor is expecting to fetch. For
>> + *          example, if the PRI initiator knows it is going to do a 10MB
>> + *          transfer, it could fill in 10MB and the OS could pre-fault in
>> + *          10MB of IOVA. It's default to 0 if there's no such hint.
>> + * @cookie: kernel-managed cookie identifying a group of fault messages. The
>> + *          cookie number encoded in the last page fault of the group should
>> + *          be echoed back in the response message.
>> + */
>> +struct iommu_hwpt_pgfault {
>> +	__u32 size;
> Given we fail the system call if size is not exactly the right value
> we should probably drop it here.
> 
> The ioctl to get the FD can someday specify the format of the fault
> messages if we need to upgrade. If we want to change it down the road
> then the old FD will be exactly as it is now, and the user will
> request a new format FD that only works in whatever the new way is.

Okay, sure!

Best regards,
baolu
