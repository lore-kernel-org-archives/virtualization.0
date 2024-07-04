Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E1717C67
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720062159; cv=none; b=H9un7chSygoZfqx65gA0ODSZ+1whjYU1j1BrfC+XrylvWmw3PSSQ2Zj3wcLQYX0adpGKiV/qg2rjS6yV3hHcywUGekCiB3sXz9w8aC9+WWaqWvHNLMdP4l0Em/jLVxtStk1iHXIAAhCyQpa8NxfW+AuMKDwVKNXgpeiXrpWjLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720062159; c=relaxed/simple;
	bh=+kcZ1X9JjlxsvYhu42cGMpuRp/ZGcCJLflR2cd6Au/8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bxS1KUz/setB2nPKlJeY9dPArkJnVIykwToLddJq+hxTJoBuc7Op6BDS2eioJBR9SciPsnY0z2UCavxaPiLOkw34qP1BfZMMTUSmLYRqyr7vCYIh0YiTva2KEMBeFI6PV0ihmw6XiiC3WJq8j5QJK+rgQbc0rtb1xKsS4VXvuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SOuFYUHS; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SOuFYUHS"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4C40F8473B
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 03:02:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2SWxfMvF_Koi for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Jul 2024 03:02:36 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.18; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 436A883FF8
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 436A883FF8
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SOuFYUHS
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 436A883FF8
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 03:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720062157; x=1751598157;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+kcZ1X9JjlxsvYhu42cGMpuRp/ZGcCJLflR2cd6Au/8=;
  b=SOuFYUHStxwXBzqbZXG5DpnoHls1yrixBuXZ1G55qZaPwQvC+SD+nRa5
   NXGZs53sjunhdqR6LY9akRI/2ZOvhjiKr1P72QtzrbdOgiDSyvRMXxZiu
   EplYql8gZj1Mih8bkY8wg41GDc/v3LiAOBeIru3V+UUD3qGUfHItY4bhS
   Sixox8I1NQB063YoOWopoAtJgWIBmZ6Y9nk3vouNs5KbHpHDwb1OVTkWC
   h7K8FksuyrTuT61lOIFLswl9XLqlvdOWt0qnre2QnXpQL8QrBAimjcCFE
   Ytk+9HnC+7ZRi2WsEpMgdVtwPdB+oOTbYlhzqiOYRZYphujpwLgGABci1
   g==;
X-CSE-ConnectionGUID: fo3CPQPaSIWDWEjLCz2LIg==
X-CSE-MsgGUID: fYrvc5TjRT+8E1ZJlhMGVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17459195"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17459195"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 20:02:36 -0700
X-CSE-ConnectionGUID: ry6BGg4WQ02kI5AnyNuMqA==
X-CSE-MsgGUID: dJblXAP8QI2e5VpUwXL21g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="77188479"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa002.jf.intel.com with ESMTP; 03 Jul 2024 20:02:32 -0700
Message-ID: <309e37d1-6066-4ba1-b30c-402a3c3e7c76@linux.intel.com>
Date: Thu, 4 Jul 2024 10:59:45 +0800
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
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Yi Liu
 <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>, iommu@lists.linux.dev,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
To: Nicolin Chen <nicolinc@nvidia.com>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/24 7:06 AM, Nicolin Chen wrote:
> Hi Baolu,

Hi Nicolin,

> On Tue, Jul 02, 2024 at 02:34:40PM +0800, Lu Baolu wrote:
> 
>> An iommufd fault object provides an interface for delivering I/O page
>> faults to user space. These objects are created and destroyed by user
>> space, and they can be associated with or dissociated from hardware page
>> table objects during page table allocation or destruction.
>>
>> User space interacts with the fault object through a file interface. This
>> interface offers a straightforward and efficient way for user space to
>> handle page faults. It allows user space to read fault messages
>> sequentially and respond to them by writing to the same file. The file
>> interface supports reading messages in poll mode, so it's recommended that
>> user space applications use io_uring to enhance read and write efficiency.
>>
>> A fault object can be associated with any iopf-capable iommufd_hw_pgtable
>> during the pgtable's allocation. All I/O page faults triggered by devices
>> when accessing the I/O addresses of an iommufd_hw_pgtable are routed
>> through the fault object to user space. Similarly, user space's responses
>> to these page faults are routed back to the iommu device driver through
>> the same fault object.
> There is a need for VIOMMU object to report HW fault to VMM. For
> example, a HW-accelerated VCMDQ may encounter HW errors. HW will
> raise an IRQ to the host kernel and the host kernel will forward
> it to the guest. I think we can have a viommu->fault, similar to
> the hwpt->fault introduced by this series. This viommu->fault can
> also benefit nested IOMMU for reporting translation error.
> 
> I learned that this hwpt->fault is exclusively for IOPF/PRI. And
> Jason suggested me to add a different one for VIOMMU. Yet, after
> taking a closer look, I found the fault object in this series is
> seemingly quite generic at the uAPI level: its naming/structure,
> and the way how it's allocated and passed to hwpt, despite being
> highly correlated with IOPF in its fops code. So, I feel that we
> might have a chance of reusing it for different fault types:
> 
> +enum iommu_fault_type {
> +	IOMMU_FAULT_TYPE_HWPT_IOPF,
> +	IOMMU_FAULT_TYPE_VIOMMU_IRQ,
> +};
> 
>   struct iommu_fault_alloc {
>   	__u32 size;
>   	__u32 flags;
> +	__u32 type;  /* enum iommu_fault_type */
>   	__u32 out_fault_id;
>   	__u32 out_fault_fd;
>   };
> 
> I understand that this is already v8. So, maybe we can, for now,
> apply the small diff above with an IOMMU_FAULT_TYPE_HWPT_IOPF type
> check in the ioctl handler. And a decoupling for the iopf fops in
> the ioctl handler can come later in the viommu series:
> 	switch (type) {
> 	case IOMMU_FAULT_TYPE_HWPT_IOPF:
> 		filep = anon_inode_getfile("[iommufd-pgfault]",
> 					   &iommufd_fault_fops_iopf);
> 	case IOMMU_FAULT_TYPE_VIOMMU_IRQ:
> 		filep = anon_inode_getfile("[iommufd-viommu-irq]",
> 					   &iommufd_fault_fops_viommu);
> 	default:
> 		return -EOPNOSUPP;
> 	}
> 
> Since you are the designer here, I think you have a better 10000
> foot view -- maybe I am missing something here implying that the
> fault object can't be really reused by viommu.
> 
> Would you mind sharing some thoughts here?

I think this is a choice between "two different objects" vs. "same
object with different FD interfaces". If I understand it correctly, your
proposal of unrecoverable fault delivery is not limited to vcmdq, but
generic to all unrecoverable events that userspace should be aware of
when the passed-through device is affected.

 From a hardware architecture perspective, the interfaces for
unrecoverable events don't always match the page faults. For example,
VT-d architecture defines a PR queue for page faults, but uses a
register set to report unrecoverable events. The 'reason', 'request id'
and 'pasid' fields of the register set indicate what happened on the
hardware. New unrecoverable events will not be reported until the
previous one has been fetched.

With the above being said, I have no strong opinions between these two
choices. Jason and Kevin should have more insights.

Thanks,
baolu
