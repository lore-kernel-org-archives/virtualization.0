Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D36523C2
	for <virtualization@lists.linux-foundation.org>; Sun, 14 Jan 2024 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mr9bPacV"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C4EE606C6
	for <virtualization@lists.linux-foundation.org>; Sun, 14 Jan 2024 13:13:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C4EE606C6
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mr9bPacV
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IQ4cJtIMFHes
	for <virtualization@lists.linux-foundation.org>;
	Sun, 14 Jan 2024 13:13:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8B1A660681
	for <virtualization@lists.linux-foundation.org>; Sun, 14 Jan 2024 13:13:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8B1A660681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705238007; x=1736774007;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H1A4/qffyCpAVBjkSooDaLmud7wmIzZtJsCV04rZkQE=;
  b=mr9bPacVUGpnkQMlnGQ/guvkId7fNl9LpwyZhWXxfjAEs/v6GAKHFPLH
   xwse9b8LBbNDcblWQLmZOsrUCmUzvwgRZ98pcSh7Z9z4810/oRwMBxb8+
   zrq0LnKKn/owr6TDMnK3r5BoatHDcSTcR6ZkwqPRGHgFwAXP1sMxPWhQ3
   ohMW1ErO0TiIi2MjbkTHJe4H7vJn1L5MFh9cfTr6OYmSFqjVhkxz0P4cZ
   JzvOQZ8+LNtXr6ut+NijFIQl6VKQO5cYbnUUzC+mzUmbyndcHAwGSbFSA
   6NC/Bm8SjWWJvI5HiUN94cfSZWUIpX2DGq5ATX0yMGOiaBfbNHFZYb99h
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="20936360"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="20936360"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 05:13:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="786838999"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="786838999"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.215.17]) ([10.254.215.17])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 05:13:22 -0800
Message-ID: <293a5643-ef36-4a34-9b6b-0f5b47061c2e@linux.intel.com>
Date: Sun, 14 Jan 2024 21:13:19 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
To: Joel Granados <j.granados@samsung.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <CGME20240112215609eucas1p1eedeeee8e1cca2c935b41816a50f56f6@eucas1p1.samsung.com>
 <20240112215606.36sth724y6zcj43k@localhost>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240112215606.36sth724y6zcj43k@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/13 5:56, Joel Granados wrote:
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
>> [1]https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.liu@intel.com/
>> [2]https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@linux.intel.com/
>> [3]https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-delivery-v2
> I was working with this branch that included Yi Liu's
> wip/iommufd_nesting branch. Now Yi Lui has updated his work in this post
> https://lore.kernel.org/all/20240102143834.146165-1-yi.l.liu@intel.com.
> Is there an updated version of the page fault work that is rebased on
> top of Liu's new version?

Yes. I am preparing the new version and will post it for discussion
after the merge window.

Best regards,
baolu
