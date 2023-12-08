Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784BF7460
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYufYB8m"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E53AA83B90
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 06:02:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E53AA83B90
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dYufYB8m
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aX3xIB5FK9Cy
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Dec 2023 06:02:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A3FE283B56
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 06:02:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A3FE283B56
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702015328; x=1733551328;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8YfUtY53ybfUCrDRuQ3/gMPNDKuhyX3Iq/kRdGPDIQk=;
  b=dYufYB8mVSLa2e999XpwZC+CU8VOldFJ4qdt87+wbSXu5VJKFXO99jDh
   Av7GgTxE447unDBi+sFIW/pk+KZELi9sDLJMxak1CVoIwE57/+W63w0vB
   KsjxTmnvpvpNlLGPWmp4vA6rOivneLIIpRoKBrCLky85XOM9CvMqQVfYK
   9VySDTmubbF4t8JrwT6C212iv7piD4EpRT1bH0VO4V44w0m1sgAUNOtPT
   XwKVWbjTD3xgsXgbBCytD9kLipDykixmEbPs7fO8kSSyL1QUG+80DYOvN
   Qcc3/UJ/qs21RRqLJmgDGBc3wc+7ZeYHbF7jShbAExfspuKr0XT/MGWGd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1467168"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="1467168"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 22:02:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="842486903"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="842486903"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 07 Dec 2023 22:02:03 -0800
Message-ID: <46c80b4e-9f05-4fb2-a31d-7386a41c895a@linux.intel.com>
Date: Fri, 8 Dec 2023 13:57:26 +0800
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
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231201142427.GJ1394392@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231201142427.GJ1394392@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/1/23 10:24 PM, Jason Gunthorpe wrote:
> On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
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
>> IOMMUFD framework. User space can then handle the page fault and respond
>> to the device top-down through the IOMMUFD. This allows user space to
>> implement its own IO page fault handling policies.
>>
>> User space indicates its capability of handling IO page faults by
>> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
>> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
>> for page fault delivery. On a successful return of HWPT allocation, the
>> user can retrieve and respond to page faults by reading and writing to
>> the file descriptor (FD) returned in out_fault_fd.
> 
> This is probably backwards, userspace should allocate the FD with a
> dedicated ioctl and provide it during domain allocation.

Introducing a dedicated fault FD for fault handling seems promising. It
decouples the fault handling from any specific domain. I suppose we need
different fault fd for recoverable faults (a.k.a. IO page fault) and
unrecoverable faults. Do I understand you correctly?


> If the userspace wants a fd per domain then it should do that. If it
> wants to share fds between domains that should work too.

Yes, it's more flexible. The fault message contains the hwpt obj id, so
user space can recognize the hwpt on which the fault happened.

Best regards,
baolu
