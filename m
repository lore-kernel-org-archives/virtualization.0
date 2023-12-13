Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7AFEDF
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 02:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="khkKKfGT"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3E7B160DA0
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 02:09:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E7B160DA0
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=khkKKfGT
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Ig5uMTAuSNZ
	for <virtualization@lists.linux-foundation.org>;
	Wed, 13 Dec 2023 02:09:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6BDD160864
	for <virtualization@lists.linux-foundation.org>; Wed, 13 Dec 2023 02:09:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6BDD160864
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702433375; x=1733969375;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MNAA322q9vhdRNtkpV3N3RglXmc+rKBeo/qJoA/OlJw=;
  b=khkKKfGTIiysS1cf6CjjajMphZxK6GuVwLaF++VlS1NNIl+QcopBYqrz
   sBsLq+tWxiz1iDdObcE1FwASCEfUbiWNmFPRmVDSVGOORTFy8wR5JmOwV
   O2uSQIj7jxalojs0U1EQb+71cyVQH/8XEtP8HmISd3zdr1MRfGX7Bsnp9
   I8e2pKc1Da0xjihlm/Tyawwanl7Mz47ytJxZ3ej3zNRyWmOw4TFG9oVGr
   zN3qRY9S20qYjceb8WSopBs/tRiwi/Ta3ora98w79woINtLI5wuCxNyKj
   fkfr/0Valh6sN1Vuwc3WO4az39HLkCVNtc71g64B6QTugwy5od8hrI90n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="392078361"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="392078361"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 18:09:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="21756369"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 12 Dec 2023 18:09:29 -0800
Message-ID: <276597d0-9947-44f1-a6b9-16d245394b22@linux.intel.com>
Date: Wed, 13 Dec 2023 10:04:49 +0800
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
Subject: Re: [PATCH v2 3/6] iommufd: Initializing and releasing IO page fault
 data
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Joel Granados <j.granados@samsung.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-4-baolu.lu@linux.intel.com>
 <CGME20231212131010eucas1p104d069ac6d6c97fce4987caa62c996ee@eucas1p1.samsung.com>
 <20231212131008.k6s5xwjgolp6geps@localhost>
 <20231212141208.GA3013885@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231212141208.GA3013885@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/23 10:12 PM, Jason Gunthorpe wrote:
> On Tue, Dec 12, 2023 at 02:10:08PM +0100, Joel Granados wrote:
> 
>>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>>> index 645ab5d290fe..0a8e03d5e7c5 100644
>>> --- a/drivers/iommu/iommufd/device.c
>>> +++ b/drivers/iommu/iommufd/device.c
>>> @@ -456,6 +456,16 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>>>   	if (rc)
>>>   		goto err_unlock;
>>>   
>>> +	if (hwpt->fault) {
>>> +		void *curr;
>>> +
>>> +		curr = iopf_pasid_cookie_set(idev->dev, IOMMU_NO_PASID, idev);
>> I'm hitting an error here when I try to attach to a hwpt that I created
>> previously with the `IOMMU_HWPT_ALLOC_IOPF_CAPABLE` flag.
>>
>> I get an -ENODEV from iopf_pasid_cookie_set which is triggered by
>> dev->iommu->fault_param being 0x0.
>>
>> I looked around and I see that the fault param gets set in
>> iopf_queue_add_device which is called from iommu_dev_enable_feature
>> only. Furthermore iommu_dev_enable_feature is only called in idxd and
>> uacce drivers.
>>
>> Questions:
>> 1. Should iopf_queue_add_device get called from the
>>     IOMMU_HWPT_ALLOC_IOPF_CAPABLE ioctl call? This make sense to me as
>>     this is where the device and the IOPF are related from user space.
> It probably needs to call the set feature thing in the short term.
> 
> In the medium term I would like the drivers to manage the iopf based
> on domain attachment not explicit feature asks

Yes, it's the same as my plan.

> 
>> 2. This is not intended to work only with idxd and uacce. right?
> It should work everywhere, I suspect Intel Team didn't hit this
> because they are testing IDXD SIOV?

Yes.

> Can you guys also test it as a PF
> assignment?

For PF assignment, probably the driver (vfio-pci) needs to enable iopf.

Best regards,
baolu
