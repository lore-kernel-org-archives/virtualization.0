Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C08145B23
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720078362; cv=none; b=cKS51rfBZVHjpEOFULWUfd4M+FePkTRg8MoG+7vrTc3STrqAScNE44LBTcNepS3VzDkiRPZym3XUDBMCZXNrJq2dRq1iGlcBeKZWahfQZznF9RVG5oYmWRusCT65zIGd4JBP0VX3E+eYLAEYlSpS0Bs2iqfxM4Y0PQGfYPmFhVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720078362; c=relaxed/simple;
	bh=8HlmpJMCXUdLQJpNWUAEVrqJS0MrfXPhDJstgMIWOsw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EkBWmBVj92X1aYh27Q3JowFLp0lVMzrj62x0PzSysKwTdYty39S/Q+TEdPcHH+kveYTJkQxtwE0hujBUImcOTjuqzEOpS4Lmq4bPxHnN7zKpTDHcap2skL3UCPIu2cQEMQjbcE7InT1jUlIy2DiJVWN4h/LvPSfd1/Qr7EshphA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HEd8YQ69; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HEd8YQ69"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1E686409AD
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 07:32:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OFegUMSQNPAN for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Jul 2024 07:32:40 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.16; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org B15EF4062C
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B15EF4062C
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HEd8YQ69
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B15EF4062C
	for <virtualization@lists.linux-foundation.org>; Thu,  4 Jul 2024 07:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720078360; x=1751614360;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8HlmpJMCXUdLQJpNWUAEVrqJS0MrfXPhDJstgMIWOsw=;
  b=HEd8YQ69NHkbBjyCFEMPjMDL1VXo+JXBIqeJWPAwtW9SImuCzAUibtvD
   N+oyjwrhYiIZTWIEpC/B/35zxXkFQ4Ur8Ti2bn86YfuDLV/ZrYNUArHdZ
   bRGNPVcnvsgz5QQ4+vT3GaMzipVuZENKoNzN+tza/cQ/9Ilhiw7J/lRQm
   S8EXJDc19fsCnYbs1r0/MLWHhOJ5KQXxE6qoxZgVYqq+VJX0Ok8IHFwks
   PUhdmVsbdIaqmLN2QPmQDvEj8cfuy92ORRm4+x9R0K1Rw968MHD4FV38P
   E98b+ntg5+//MAdJ1b+RyJAOjWA79FftVu9NF+hpaUovw80xNL009ZqrI
   w==;
X-CSE-ConnectionGUID: svwfLopiROSWuvNjIQTnzA==
X-CSE-MsgGUID: HGbjru9ARWS0Ow+TbR+72Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17476682"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="17476682"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 00:32:39 -0700
X-CSE-ConnectionGUID: hdEgb+MBQFOD37NcQY3N4w==
X-CSE-MsgGUID: H+fHHzmfRBq+AaDMDklizQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; 
   d="scan'208";a="47166851"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.125.248.220]) ([10.125.248.220])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2024 00:32:35 -0700
Message-ID: <fc7f5bb1-25b7-4a5f-8d6b-1fa17b1af534@linux.intel.com>
Date: Thu, 4 Jul 2024 15:32:32 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Liu, Yi L" <yi.l.liu@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v8 06/10] iommufd: Add iommufd fault object
To: "Tian, Kevin" <kevin.tian@intel.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20240702063444.105814-1-baolu.lu@linux.intel.com>
 <20240702063444.105814-7-baolu.lu@linux.intel.com>
 <ZoXZZ2SJ/WdlMJaX@Asurada-Nvidia>
 <309e37d1-6066-4ba1-b30c-402a3c3e7c76@linux.intel.com>
 <ZoY01iLmzoV4fIPG@Asurada-Nvidia>
 <BN9PR11MB52769E10ED0741F5ED3E5B668CDE2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52769E10ED0741F5ED3E5B668CDE2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/4 14:37, Tian, Kevin wrote:
>> From: Nicolin Chen<nicolinc@nvidia.com>
>> Sent: Thursday, July 4, 2024 1:36 PM
>>
>> On Thu, Jul 04, 2024 at 10:59:45AM +0800, Baolu Lu wrote:
>>>> On Tue, Jul 02, 2024 at 02:34:40PM +0800, Lu Baolu wrote:
>>>>
>>>> +enum iommu_fault_type {
>>>> +     IOMMU_FAULT_TYPE_HWPT_IOPF,
>>>> +     IOMMU_FAULT_TYPE_VIOMMU_IRQ,
>>>> +};
>>>>
>>>>    struct iommu_fault_alloc {
>>>>        __u32 size;
>>>>        __u32 flags;
>>>> +     __u32 type;  /* enum iommu_fault_type */
>>>>        __u32 out_fault_id;
>>>>        __u32 out_fault_fd;
> and need a new reserved field for alignment.
> 
>>>>    };
>>>>
>>>> I understand that this is already v8. So, maybe we can, for now,
>>>> apply the small diff above with an IOMMU_FAULT_TYPE_HWPT_IOPF
>> type
>>>> check in the ioctl handler. And a decoupling for the iopf fops in
>>>> the ioctl handler can come later in the viommu series:
>>>>        switch (type) {
>>>>        case IOMMU_FAULT_TYPE_HWPT_IOPF:
>>>>                filep = anon_inode_getfile("[iommufd-pgfault]",
>>>>                                           &iommufd_fault_fops_iopf);
>>>>        case IOMMU_FAULT_TYPE_VIOMMU_IRQ:
>>>>                filep = anon_inode_getfile("[iommufd-viommu-irq]",
>>>>                                           &iommufd_fault_fops_viommu);
>>>>        default:
>>>>                return -EOPNOSUPP;
>>>>        }
>>>>
>>>> Since you are the designer here, I think you have a better 10000
>>>> foot view -- maybe I am missing something here implying that the
>>>> fault object can't be really reused by viommu.
>>>>
>>>> Would you mind sharing some thoughts here?
>>> I think this is a choice between "two different objects" vs. "same
>>> object with different FD interfaces". If I understand it correctly, your
>>> proposal of unrecoverable fault delivery is not limited to vcmdq, but
>>> generic to all unrecoverable events that userspace should be aware of
>>> when the passed-through device is affected.
>> It's basically IRQ forwarding, not confined to unrecoverable
>> faults. For example, a VCMDQ used by the guest kernel would
>> raise an HW IRQ if the guest kernel issues an illegal command
>> to the HW Queue assigned to it. The host kernel will receive
>> the IRQ, so it needs a way to forward it to the VM for guest
>> kernel to recover the HW queue.
>>
>> The way that we define the structure can follow what we have
>> for hwpt_alloc/invalidate uAPIs, i.e. driver data/event. And
>> such an event can carry unrecoverable translation faults too.
>> SMMU at least reports DMA translation faults using an eventQ
>> in its own native language.
>>
>>>  From a hardware architecture perspective, the interfaces for
>>> unrecoverable events don't always match the page faults. For example,
>>> VT-d architecture defines a PR queue for page faults, but uses a
>>> register set to report unrecoverable events. The 'reason', 'request id'
>>> and 'pasid' fields of the register set indicate what happened on the
>>> hardware. New unrecoverable events will not be reported until the
>>> previous one has been fetched.
>> Understood. I don't think we can share the majority pieces in
>> the fault.c. Just the "IOMMU_FAULT_QUEUE_ALLOC" ioctl itself
>> looks way too general to be limited to page-fault usage only.
>> So, I feel we can share, for example:
>>      IOMMU_FAULT_QUEUE_ALLOC (type=hwpt_iopf) -> fault_id=1
>>      IOMMU_HWPT_ALLOC (fault_id=1) -> hwpt_id=2
>>      IOMMU_FAULT_QUEUE_ALLOC (type=viommu_irq) -> fault_id=3
>>      IOMMU_VIOMMU_ALLOC (fault_id=2) -> viommu_id=4
>> The handler will direct to different fops as I drafted in my
>> previous mail.
>>
>>> With the above being said, I have no strong opinions between these two
>>> choices. Jason and Kevin should have more insights.
>> Thanks. Jason is out of office this week, so hopefully Kevin
>> may shed some light. I personally feel that we don't need to
>> largely update this series until we add VIOMMU. Yet, it would
>> be convenient if we add a "type" in the uAPI with this series.
>>
> This is ok to me.

So

Nicolin, perhaps can you please cook an additional patch on top of this
series and post it for further review?

Thanks,
baolu
