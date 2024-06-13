Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752AF132123
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 04:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718252743; cv=none; b=hwxuOtHI3l5/fX9Be52yQBBxXce0N3fjEvirLTX/PaqwGvVS8qlSMcU2V4hr/pn4OusngN9taAlsvz3HweFzEgqyEUZEuzOaEDqX7CLZ+eAefeutz9atPNC71HTnfEANMEQoYrDihy1HCMhs9ZS3zAL4NbAIyNCaHhT476anJeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718252743; c=relaxed/simple;
	bh=zX+jRNQ+a555huSmEGAMNFubMd0Bt5uQ73a96jcFDzY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EMhcL88d8ivynar9LXZty9AwEVBJhNqTwzMsBjHdbjYLmWv8CZZnCnuoPdu2adCXA6wKsxUG1L26BLNU3jYO8E3Bd4iJcZTG0MsNpcUg7CTMt4k+vB++7uznRvoghwl8bCt2fR4r2t3D4opiMuhEn97n+SD/LqVgGDstQTnLo5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DlCHHpsT; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DlCHHpsT"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 14D4081DF0
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 04:25:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eW1q6FQJkYHG for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jun 2024 04:25:41 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 0BAAC81DE4
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0BAAC81DE4
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DlCHHpsT
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0BAAC81DE4
	for <virtualization@lists.linux-foundation.org>; Thu, 13 Jun 2024 04:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718252740; x=1749788740;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zX+jRNQ+a555huSmEGAMNFubMd0Bt5uQ73a96jcFDzY=;
  b=DlCHHpsThk+XQ2QpA+fQwa20qX2yRlOsSbP/40MSQLhwtIP6V3ZO09GS
   uz0VMtR0xmsWNapE3oWzABIK0NhqxxfHAwBRvD82GvhYxW77WblQWuyzJ
   4Q7CcE9qdn2itO3tRhn8KsX4CQagTLfMGWn827uk5CqEAUyDfT2LFoYi8
   5IM8zz54Amj9LpbHWa5mfFgklCLACb4D6MhXeHREiqt81bhfAXb4E01uu
   4JII6d9dH550uFpriSFRTzlfTzferGJ2H3WmXpaizKx9dchWcLw9/zQ1+
   rzrIvX7Jl7STGHrfqDlfzgzHU90DnmhUnRl84yP7U342Kpp2qjRB56U07
   Q==;
X-CSE-ConnectionGUID: YCYstZfbSTumhjslHEtyMA==
X-CSE-MsgGUID: d5y26JbGQf2OmuIXCg+29Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="26163597"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="26163597"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 21:25:39 -0700
X-CSE-ConnectionGUID: NlmSv4PPSdG4CIIC18aTtQ==
X-CSE-MsgGUID: 3ZXeQl4SSWaRGvJB4ZZZFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="39969433"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa008.fm.intel.com with ESMTP; 12 Jun 2024 21:25:35 -0700
Message-ID: <013afe9a-756f-4c85-baa1-977bea6be395@linux.intel.com>
Date: Thu, 13 Jun 2024 12:23:17 +0800
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
Subject: Re: [PATCH v6 03/10] iommu: Add attach handle to struct iopf_group
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240527040517.38561-1-baolu.lu@linux.intel.com>
 <20240527040517.38561-4-baolu.lu@linux.intel.com>
 <20240612133732.GW791043@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240612133732.GW791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 9:37 PM, Jason Gunthorpe wrote:
> On Mon, May 27, 2024 at 12:05:10PM +0800, Lu Baolu wrote:
>> @@ -206,20 +182,49 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>>   	if (group == &abort_group)
>>   		goto err_abort;
>>   
>> -	group->domain = get_domain_for_iopf(dev, fault);
>> -	if (!group->domain)
>> +	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
>> +		group->attach_handle = iommu_attach_handle_get(dev->iommu_group,
>> +							       fault->prm.pasid,
>> +							       0);
>> +		if (IS_ERR(group->attach_handle)) {
>> +			if (!device_iommu_capable(dev, IOMMU_CAP_USER_IOASID_TABLE))
>> +				goto err_abort;
> 
> I'm not excited about calling a function pointer on every fault. Let's
> just add a constant flag to iommu_ops?

Yes, it's reasonable given this is a critical path. How about below
additional change?

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 16b3a2da91ef..69ea4d0374b9 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -253,12 +253,6 @@ enum iommu_cap {
          */
         IOMMU_CAP_DEFERRED_FLUSH,
         IOMMU_CAP_DIRTY_TRACKING,       /* IOMMU supports dirty tracking */
-       /*
-        * IOMMU driver supports user-managed IOASID table. There is no
-        * user domain for each PASID and the I/O page faults are forwarded
-        * through the user domain attached to the device RID.
-        */
-       IOMMU_CAP_USER_IOASID_TABLE,
  };

  /* These are the possible reserved region types */
@@ -557,6 +551,10 @@ static inline int __iommu_copy_struct_from_user_array(
   * @default_domain: If not NULL this will always be set as the default 
domain.
   *                  This should be an IDENTITY/BLOCKED/PLATFORM domain.
   *                  Do not use in new drivers.
+ * @user_pasid_table: IOMMU driver supports user-managed PASID table. 
There is
+ *                    no user domain for each PASID and the I/O page 
faults are
+ *                    forwarded through the user domain attached to the 
device
+ *                    RID.
   */
  struct iommu_ops {
         bool (*capable)(struct device *dev, enum iommu_cap);
@@ -600,6 +598,7 @@ struct iommu_ops {
         struct iommu_domain *blocked_domain;
         struct iommu_domain *release_domain;
         struct iommu_domain *default_domain;
+       bool user_pasid_table;
  };

  /**
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index a629d8a93614..cd679c13752e 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -189,7 +189,9 @@ void iommu_report_device_fault(struct device *dev, 
struct iopf_fault *evt)
 
fault->prm.pasid,
                                                                0);
                 if (IS_ERR(group->attach_handle)) {
-                       if (!device_iommu_capable(dev, 
IOMMU_CAP_USER_IOASID_TABLE))
+                       const struct iommu_ops *ops = dev_iommu_ops(dev);
+
+                       if (!ops->user_pasid_table)
                                 goto err_abort;

Best regards,
baolu
