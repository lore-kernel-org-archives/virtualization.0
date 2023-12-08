Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3895224
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 05:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nl83Afc3"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D0CE640474
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 05:15:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D0CE640474
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nl83Afc3
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C3dCzzN5eLa5
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Dec 2023 05:14:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 74269400F1
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 05:14:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 74269400F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702012499; x=1733548499;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eMqZIBfmXsW4JIGVz2VpEyeyCc8OAVvggzWL9Lorv+E=;
  b=Nl83Afc3OoTsFZ+rape1lqd89Qu5ftZZbr8tlao+CH8roqqi/McrON69
   gA7ioFMn/QbnMCyDzQ+OS2KD6fVMWcv5CK4clvHThDBTD48L8RmUbiAXb
   LuQHTmLldSrUT4RZsnxyxOhuqPSecBcG6b61IqWzqfKT/KBj3YZKBzsXP
   iRx1XZQQkP17jm+zVANVG+8x64tf+qJH7hACA2vsqhxaW7y/EpTifE3ZC
   9v3YUCs2pLcyTJspAwmJ8AS+wLBA1G8BOtQnMgKy1Sxx+CnxrToqoM+JA
   cL79SzxQMs4WDuZOkSFSyqt/x+ecvoCNOaM8+CcU2/KCMzg0eGCtECXd1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="480554319"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="480554319"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 21:14:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="775684230"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="775684230"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga007.fm.intel.com with ESMTP; 07 Dec 2023 21:14:54 -0800
Message-ID: <8d29c6fb-0928-4c11-a9af-02647597cb4e@linux.intel.com>
Date: Fri, 8 Dec 2023 13:10:17 +0800
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
Content-Language: en-US
To: Joel Granados <j.granados@samsung.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <CGME20231204150747eucas1p2365e92a7ac33ba99b801d7c800acaf6a@eucas1p2.samsung.com>
 <20231204150744.db3hfpq4v55cuavn@localhost>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231204150744.db3hfpq4v55cuavn@localhost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/4/23 11:07 PM, Joel Granados wrote:
> On Thu, Oct 26, 2023 at 10:49:24AM +0800, Lu Baolu wrote:
>> Hi folks,
>>
>> This series implements the functionality of delivering IO page faults to
>> user space through the IOMMUFD framework for nested translation. Nested
> Does this mean the IOPF_CAPABLE HWPT needs to be parented by a HWPT
> created with IOMMU_HWPT_ALLOC_NEST_PARENT set?

No. It's generic, nested translation is simply a use case that is
currently feasible.

Best regards,
baolu
