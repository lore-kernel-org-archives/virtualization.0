Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE84C98
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 06:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eh/5mUpC"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 87F694031C
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 06:39:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 87F694031C
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Eh/5mUpC
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K0Ac7934xlRN
	for <virtualization@lists.linux-foundation.org>;
	Fri,  8 Dec 2023 06:39:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3F5AB40176
	for <virtualization@lists.linux-foundation.org>; Fri,  8 Dec 2023 06:39:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F5AB40176
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702017584; x=1733553584;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g2XYI3wGsgRd94waAtpwRHsl4O1wz+sDDWlsY1kGQdE=;
  b=Eh/5mUpCn4n7NtkxAmqwpBgs2b5uoQNqJHCDff0sQg996L6GG4OgFGYD
   mvhBQ9ehKnyzCWrXZ1M7oaohh/wexTwwKDjj2rfI/6Y+gfcZi/8YN9HVW
   SMxPDlYu/3R27YrJGz+jzNpiAiQW2JS5Q48NCaXMTHMTky7eeKicb9GRq
   Q6rg/H32+gEwRZ81U2v3vHH+A/n8oBlzG/zO/7cJs5kDeX1L3mJOc4/Gb
   SX7jfbMK22bdpG4gA+OdM0WVx4zDB3k7ijArLnV2cnfm6ag7I43ROe2NY
   VPrJbguE78tNCG2ZmT+Tf0DS1O8fnu/KXqjN1Oa5d/ZJsejfjWh8bxaGm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="398234213"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="398234213"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 22:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="945319532"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; 
   d="scan'208";a="945319532"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga005.jf.intel.com with ESMTP; 07 Dec 2023 22:39:39 -0800
Message-ID: <c0937374-223a-4ff5-800e-c8287f0ee5ad@linux.intel.com>
Date: Fri, 8 Dec 2023 14:35:02 +0800
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
Subject: Re: [PATCH v2 2/6] iommufd: Add iommu page fault uapi data
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <20231026024930.382898-3-baolu.lu@linux.intel.com>
 <20231201151405.GA1489931@ziepe.ca>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231201151405.GA1489931@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 12/1/23 11:14 PM, Jason Gunthorpe wrote:
> On Thu, Oct 26, 2023 at 10:49:26AM +0800, Lu Baolu wrote:
> 
>> + * @IOMMU_HWPT_ALLOC_IOPF_CAPABLE: User is capable of handling IO page faults.
> 
> This does not seem like the best name?
> 
> Probably like this given my remark in the cover letter:
> 
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -359,6 +359,7 @@ struct iommu_vfio_ioas {
>   enum iommufd_hwpt_alloc_flags {
>          IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
>          IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
> +       IOMMU_HWPT_IOPFD_FD_VALID = 1 << 2,
>   };
>   
>   /**
> @@ -440,6 +441,7 @@ struct iommu_hwpt_alloc {
>          __u32 data_type;
>          __u32 data_len;
>          __aligned_u64 data_uptr;
> +       __s32 iopf_fd;
>   };
>   #define IOMMU_HWPT_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_HWPT_ALLOC)

Yes. Agreed.

>> @@ -679,6 +688,62 @@ struct iommu_dev_data_arm_smmuv3 {
>>   	__u32 sid;
>>   };
>>   
>> +/**
>> + * struct iommu_hwpt_pgfault - iommu page fault data
>> + * @size: sizeof(struct iommu_hwpt_pgfault)
>> + * @flags: Combination of IOMMU_PGFAULT_FLAGS_ flags.
>> + *  - PASID_VALID: @pasid field is valid
>> + *  - LAST_PAGE: the last page fault in a group
>> + *  - PRIV_DATA: @private_data field is valid
>> + *  - RESP_NEEDS_PASID: the page response must have the same
>> + *                      PASID value as the page request.
>> + * @dev_id: id of the originated device
>> + * @pasid: Process Address Space ID
>> + * @grpid: Page Request Group Index
>> + * @perm: requested page permissions (IOMMU_PGFAULT_PERM_* values)
>> + * @addr: page address
>> + * @private_data: device-specific private information
>> + */
>> +struct iommu_hwpt_pgfault {
>> +	__u32 size;
>> +	__u32 flags;
>> +#define IOMMU_PGFAULT_FLAGS_PASID_VALID		(1 << 0)
>> +#define IOMMU_PGFAULT_FLAGS_LAST_PAGE		(1 << 1)
>> +#define IOMMU_PGFAULT_FLAGS_PRIV_DATA		(1 << 2)
>> +#define IOMMU_PGFAULT_FLAGS_RESP_NEEDS_PASID	(1 << 3)
>> +	__u32 dev_id;
>> +	__u32 pasid;
>> +	__u32 grpid;
>> +	__u32 perm;
>> +#define IOMMU_PGFAULT_PERM_READ			(1 << 0)
>> +#define IOMMU_PGFAULT_PERM_WRITE		(1 << 1)
>> +#define IOMMU_PGFAULT_PERM_EXEC			(1 << 2)
>> +#define IOMMU_PGFAULT_PERM_PRIV			(1 << 3)
>> +	__u64 addr;
>> +	__u64 private_data[2];
>> +};
> 
> This mixed #define is not the style, these should be in enums,
> possibly with kdocs
> 
> Use __aligned_u64 also

Sure.

> 
>> +
>> +/**
>> + * struct iommu_hwpt_response - IOMMU page fault response
>> + * @size: sizeof(struct iommu_hwpt_response)
>> + * @flags: Must be set to 0
>> + * @hwpt_id: hwpt ID of target hardware page table for the response
>> + * @dev_id: device ID of target device for the response
>> + * @pasid: Process Address Space ID
>> + * @grpid: Page Request Group Index
>> + * @code: response code. The supported codes include:
>> + *        0: Successful; 1: Response Failure; 2: Invalid Request.
>> + */
>> +struct iommu_hwpt_page_response {
>> +	__u32 size;
>> +	__u32 flags;
>> +	__u32 hwpt_id;
>> +	__u32 dev_id;
>> +	__u32 pasid;
>> +	__u32 grpid;
>> +	__u32 code;
>> +};
> 
> Is it OK to have the user pass in all this detailed information? Is it
> a security problem if the user lies? Ie shouldn't we only ack page
> faults we actually have outstanding?
> 
> IOW should iommu_hwpt_pgfault just have a 'response_cookie' generated
> by the kernel that should be placed here? The kernel would keep track
> of all this internal stuff?

The iommu core has already kept the outstanding faults that have been
awaiting a response. So even if the user lies about a fault, the kernel
does not send the wrong respond message to the device. {device_id,
grpid, code} is just enough from the user. This means the user wants to
respond to the @grpid fault from @device with the @code result.

Best regards,
baolu
