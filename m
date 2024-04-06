Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6A1EB2F
	for <virtualization@lists.linux-foundation.org>; Sat,  6 Apr 2024 04:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712378129; cv=none; b=gBaHOV+G1KiQQkuLPpvTUKwtPCA5sYDOlJed8yTqMNikHV/MQ7pgo+lNUljR0mWNWl36Xqs/+pCZkfoD8Kb4yUBGMtmhImq1TqiEQrsPYwsPU4BBpL3NWBTJGmhsAJt8qqRhgdRefel5dVDCG6ezmYvFRL+VfxXdmmuItlxeU8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712378129; c=relaxed/simple;
	bh=qtmWZt/jxejIJ9PmMzYOhQaTUv0eoZfI7HqYDaoa34s=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VGFHr/PPoNTYvnDMvFnWx4Ybdi/zBqJSzZhvEpLXWs/xNakKC/3dstGhaQ13W9l1AgDXeRLQOKUZL/Mhy1QHN2glS1Ekoe0jtIoNrhxU+uGm3EecSmcCybZZQMqp34I87iXO3bjArepCLIOqjlZCV6KYH4B2mgGzRRTMC2zgyWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYl1aLMh; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYl1aLMh"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CBF8F4011A
	for <virtualization@lists.linux-foundation.org>; Sat,  6 Apr 2024 04:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.699
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JH6IFZhIlwF0 for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Apr 2024 04:35:24 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.14; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 83F97401DD
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 83F97401DD
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hYl1aLMh
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 83F97401DD
	for <virtualization@lists.linux-foundation.org>; Sat,  6 Apr 2024 04:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712378124; x=1743914124;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qtmWZt/jxejIJ9PmMzYOhQaTUv0eoZfI7HqYDaoa34s=;
  b=hYl1aLMhQimQbUoDYhIJrCcxmTs8tS+FAekHfkqlTAfSE6T336zRixES
   ZhPWAxIPCMNIVGgRSOmfrv/Lf5CQOc01YX+/o1NPTJrAd+RT++bv1x6ml
   YVUyBEl3e9PMyOyGSN7Gy1OMzq79Q2v9MT5no3cTT9UfJzD+4yPDxxC4D
   wg0VssqQf5Zfp6Eprp+zotFHmOu2rAR81oC6qFXl7TVocOL3/sZFq+YOp
   lqm0fAlxZGjS5FpKyPIO5pq5XyOkkx+YQ2oEHW7JbQRTocjY1Y+HHUe3P
   e4ooI7NdY+XQxBmB9xtflLdRRTTfWs8GSJTYozT1v5QHbijhbjmDYb8qw
   Q==;
X-CSE-ConnectionGUID: DqA+6z6rRdu7+eDXajEwMg==
X-CSE-MsgGUID: PIrPe9MqSHKmH0Imn0A3Og==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="11544632"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="11544632"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 21:35:22 -0700
X-CSE-ConnectionGUID: 4mLoGmmEQf61FPDk4wrB4w==
X-CSE-MsgGUID: 3A8nclyETq+tLMYeWrZfsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="23986342"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa004.fm.intel.com with ESMTP; 05 Apr 2024 21:35:18 -0700
Message-ID: <3b740988-7fe6-4328-8ce2-d66d9a2ab497@linux.intel.com>
Date: Sat, 6 Apr 2024 12:34:14 +0800
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
Subject: Re: [PATCH v4 1/9] iommu: Introduce domain attachment handle
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-2-baolu.lu@linux.intel.com>
 <20240403115851.GA1723999@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240403115851.GA1723999@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 7:58 PM, Jason Gunthorpe wrote:
> On Wed, Apr 03, 2024 at 09:15:11AM +0800, Lu Baolu wrote:
>> Currently, when attaching a domain to a device or its PASID, domain is
>> stored within the iommu group. It could be retrieved for use during the
>> window between attachment and detachment.
>>
>> With new features introduced, there's a need to store more information
>> than just a domain pointer. This information essentially represents the
>> association between a domain and a device. For example, the SVA code
>> already has a custom struct iommu_sva which represents a bond between
>> sva domain and a PASID of a device. Looking forward, the IOMMUFD needs
>> a place to store the iommufd_device pointer in the core, so that the
>> device object ID could be quickly retrieved in the critical fault handling
>> path.
>>
>> Introduce domain attachment handle that explicitly represents the
>> attachment relationship between a domain and a device or its PASID.
>> A caller-specific data field can be used by the caller to store additional
>> information beyond a domain pointer, depending on its specific use case.
>>
>> Co-developed-by: Jason Gunthorpe<jgg@nvidia.com>
>> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> ---
>>   drivers/iommu/iommu-priv.h |   9 +++
>>   drivers/iommu/iommu.c      | 158 +++++++++++++++++++++++++++++++++----
>>   2 files changed, 153 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>> index 5f731d994803..08c0667cef54 100644
>> --- a/drivers/iommu/iommu-priv.h
>> +++ b/drivers/iommu/iommu-priv.h
>> @@ -28,4 +28,13 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
>>   				 const struct bus_type *bus,
>>   				 struct notifier_block *nb);
>>   
>> +struct iommu_attach_handle {
>> +	struct iommu_domain		*domain;
>> +	refcount_t			users;
> I don't understand how the refcounting can be generally useful. There
> is no way to free this:
> 
>> +	void				*priv;
> When the refcount goes to zero.

This field is set by the caller, so the caller ensures that the pointer
can only be freed after iommu domain detachment. For iopf, the caller
should automatically respond to all outstanding iopf's in the domain
detach path.

In the sva case, which uses the workqueue to handle iopf,
flush_workqueue() is called in the domain detach path to ensure that all
outstanding iopf's are completed before detach completion.

For iommufd, perhaps I need to add the following code in the detach (and
the same to replace) paths:

--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -68,14 +68,35 @@ int iommufd_fault_domain_attach_dev(struct 
iommufd_hw_pagetable *hwpt,
         return 0;
  }

+static void iommufd_auto_response_handle(struct iommufd_fault *fault,
+                                        struct iommu_attach_handle *handle)
+{
+       struct iommufd_device *idev = handle->priv;
+       struct iopf_group *group;
+       unsigned long index;
+
+       mutex_lock(&fault->mutex);
+       xa_for_each(&idev->faults, index, group) {
+               xa_erase(&idev->faults, index);
+               iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
+       }
+       mutex_unlock(&fault->mutex);
+}
+
  void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable *hwpt,
                                      struct iommufd_device *idev)
  {
+       struct iommufd_fault *fault = hwpt->fault;
+       struct iommu_attach_handle *handle;
+
         if (WARN_ON(!hwpt->fault_capable))
                 return;

+       handle = iommu_attach_handle_get(idev->igroup->group, 
IOMMU_NO_PASID);
         iommu_detach_group(hwpt->domain, idev->igroup->group);
         iommufd_fault_iopf_disable(idev);
+       iommufd_auto_response_handle(fault, handle);
+       iommu_attach_handle_put(handle);
  }

Best regards,
baolu
