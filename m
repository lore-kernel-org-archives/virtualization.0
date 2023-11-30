Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FB5125C3
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YurLH23v"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1C81B400EA
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 03:51:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1C81B400EA
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YurLH23v
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d92d1MZudrWE
	for <virtualization@lists.linux-foundation.org>;
	Thu, 30 Nov 2023 03:51:26 +0000 (UTC)
X-Greylist: delayed 428 seconds by postgrey-1.37 at util1.osuosl.org; Thu, 30 Nov 2023 03:51:26 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B3231400D1
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B3231400D1
	for <virtualization@lists.linux-foundation.org>; Thu, 30 Nov 2023 03:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701316287; x=1732852287;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WZZMnWGpd1y0ccfThg5B81AdxxPkKMFT8brLpoZWyyM=;
  b=YurLH23vq+9tGSvYFb6lzvSBYO/yW8C+9xHfjw5rHiFe3q9W3VELZL4G
   LxF+ELuzziGeQzX2ZSOchuanoW8aE1wCxZRCC1tJWiGl9HFpd9SNVakZa
   rJjMdIQXHfyPf+z+0ltajLuKJabyC1CySpX1EOgpWOAik9nnDFWqGJC7m
   8ye79C2VlwhMTOQO37PcXn0MrVLtTD8Eaz7mB1zkNvhRUgV1jMcOaHhHx
   va8THTKRoDeNNIQfTj17TKA3ASY6k2ioxM3ZM0Y5+AI27VL/VO4ZLqtqn
   F8Xk81HmzRJzq3qu9Yv2y6uJdUe6+h5boWkIF3MixkA9TIse213dK3EhW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="246696"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="246696"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 19:44:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1016499582"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="1016499582"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.155]) ([10.249.171.155])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 19:44:12 -0800
Message-ID: <61736bbd-1e8f-4dce-9c31-c1a6f10ae344@linux.intel.com>
Date: Thu, 30 Nov 2023 11:44:10 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <55ed1ac0f2024c429b396cb751773d62@huawei.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <55ed1ac0f2024c429b396cb751773d62@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/11/29 17:08, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: 26 October 2023 03:49
>> To: Jason Gunthorpe <jgg@ziepe.ca>; Kevin Tian <kevin.tian@intel.com>;
>> Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robin
>> Murphy <robin.murphy@arm.com>; Jean-Philippe Brucker
>> <jean-philippe@linaro.org>; Nicolin Chen <nicolinc@nvidia.com>; Yi Liu
>> <yi.l.liu@intel.com>; Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: iommu@lists.linux.dev; linux-kselftest@vger.kernel.org;
>> virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org; Lu
>> Baolu <baolu.lu@linux.intel.com>
>> Subject: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
>>
>> Hi folks,
>>
>> This series implements the functionality of delivering IO page faults to
>> user space through the IOMMUFD framework for nested translation. Nested
>> translation is a hardware feature that supports two-stage translation
>> tables for IOMMU. The second-stage translation table is managed by the
>> host VMM, while the first-stage translation table is owned by user
>> space. This allows user space to control the IOMMU mappings for its
>> devices.
>>
>> When an IO page fault occurs on the first-stage translation table, the
>> IOMMU hardware can deliver the page fault to user space through the
>> IOMMUFD framework. User space can then handle the page fault and
>> respond
>> to the device top-down through the IOMMUFD. This allows user space to
>> implement its own IO page fault handling policies.
>>
>> User space indicates its capability of handling IO page faults by
>> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
>> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
>> for page fault delivery. On a successful return of HWPT allocation, the
>> user can retrieve and respond to page faults by reading and writing to
>> the file descriptor (FD) returned in out_fault_fd.
>>
>> The iommu selftest framework has been updated to test the IO page fault
>> delivery and response functionality.
>>
>> This series is based on the latest implementation of nested translation
>> under discussion [1] and the page fault handling framework refactoring in
>> the IOMMU core [2].
>>
>> The series and related patches are available on GitHub: [3]
>>
>> [1]
>> https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.liu@int
>> el.com/
>> [2]
>> https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@li
>> nux.intel.com/
>> [3]
>> https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-deliv
>> ery-v2
> 
> Hi Baolu,

Hi Shameer,

> 
> Do you have a corresponding Qemu git to share? I could give it a spin on our ARM
> platform. Please let me know.

This version of the series is tested by the iommufd selftest. We are in
process of developing the QEMU code. I will provide the repo link after
we complete it.

Best regards,
baolu
