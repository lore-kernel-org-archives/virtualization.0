Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F2B22EFB
	for <virtualization@lists.linux-foundation.org>; Sat,  6 Apr 2024 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712383848; cv=none; b=dIM05zLPE0B8ePyrAM7XQ1u2L68spAXEg7e7gnzonhmkWFxCfqhZ0aQwlzJUrBukAbZ9P3zfy/UzqZAEigGFH3OFFNUC5jWDtTuUSTETWqljQYt1PkAdkKSJIHWOvaCYtfxfXNcsIAR1Ue6rKZXy+hWeUAs+nJemIXW21bHLVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712383848; c=relaxed/simple;
	bh=oW5lJbl5v3kR/8gLXMDQPaUPUS+d2GARjElgdEIrEZI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=K7yCuqg613A6wxaLBiAX2ZzuZWGVeFkjTQONFVCAOqjzsbQJzC4hYbrbYEvxsFpL1GBD9PjVXG2Wy0j8fTpMrgwyfB7k4kSmKiD7anV0UyUgBnoBHNlD2tj5/gOX8zFmPOnPQKDegLCkJiYdqlwmWsBCMh0qHVjJ/N9WZBL6vqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7ayYwpp; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7ayYwpp"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B6CF4038B
	for <virtualization@lists.linux-foundation.org>; Sat,  6 Apr 2024 06:10:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.699
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fpFYI3VcE-NZ for <virtualization@lists.linux-foundation.org>;
 Sat,  6 Apr 2024 06:10:43 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 0230E40413
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0230E40413
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D7ayYwpp
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0230E40413
	for <virtualization@lists.linux-foundation.org>; Sat,  6 Apr 2024 06:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712383843; x=1743919843;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oW5lJbl5v3kR/8gLXMDQPaUPUS+d2GARjElgdEIrEZI=;
  b=D7ayYwppKwqaC7A2j5tFxounjsGUt9GgxRcqs3LVRltJjtkWhBlw8VzE
   lAqMl2Vj3H6yIZ3kTlk+2Oc6Fdba3r6hQODb2kiEyCXijvIkIaVD2JJwi
   4aS4HUWKvoqKXVzsWb+ueiDJItoQTXi0VNABhY6mFUCEWlS6y+dfGT5wg
   0CgroNqDoV8v/AtJsbczb5uQe1Rnhp+HqEyh+3HJ8r6VNTU0C+QgKNWlU
   wcK9AOo7BjqS2xbnl6Mjt5CmhUSYb2iXowuLBxmRwa2cioIsqFE2dTi4w
   iJ2Kj7dxPseMIejtt/L04eRZGPBOT6agDW5ebqNWOI5gJ7hjD8psQIg37
   A==;
X-CSE-ConnectionGUID: ubHOEAJQTFKCeR8Hw9CwxQ==
X-CSE-MsgGUID: jts7XgsmRI60vslfXZ68zw==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="10695203"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="10695203"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 23:10:41 -0700
X-CSE-ConnectionGUID: 4IAu7IDhRMaelDhzLtb65w==
X-CSE-MsgGUID: +ETBezDHT6uZW0kFO/rxxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="24097072"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 05 Apr 2024 23:10:38 -0700
Message-ID: <e3f526e3-6474-49ff-b8d6-995aaf1c1830@linux.intel.com>
Date: Sat, 6 Apr 2024 14:09:34 +0800
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
Subject: Re: [PATCH v4 2/9] iommu: Replace sva_iommu with iommu_attach_handle
To: Jason Gunthorpe <jgg@ziepe.ca>
References: <20240403011519.78512-1-baolu.lu@linux.intel.com>
 <20240403011519.78512-3-baolu.lu@linux.intel.com>
 <20240403115913.GC1363414@ziepe.ca>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20240403115913.GC1363414@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/24 7:59 PM, Jason Gunthorpe wrote:
> On Wed, Apr 03, 2024 at 09:15:12AM +0800, Lu Baolu wrote:
>> +	/* A bond already exists, just take a reference`. */
>> +	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
>> +	if (handle) {
>> +		mutex_unlock(&iommu_sva_lock);
>> +		return handle;
>>   	}
> At least in this context this is not enough we need to ensure that the
> domain on the PASID is actually an SVA domain and it was installed by
> this mechanism, not an iommufd domain for instance.
> 
> ie you probably need a type field in the iommu_attach_handle to tell
> what the priv is.
> 
> Otherwise this seems like a great idea!

Yes, you are right. For the SVA case, I will add the following changes.
The IOMMUFD path will also need such enhancement. I will update it in
the next version.

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 08c0667cef54..9aee70f87a21 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -28,9 +28,22 @@ void iommu_device_unregister_bus(struct iommu_device 
*iommu,
  				 const struct bus_type *bus,
  				 struct notifier_block *nb);

+enum attach_handle_type {
+	ATTACH_HANDLE_TYPE_DEFAULT = 0,
+	ATTACH_HANDLE_TYPE_SVA,
+	ATTACH_HANDLE_TYPE_IOMMUFD,
+};
+
  struct iommu_attach_handle {
  	struct iommu_domain		*domain;
  	refcount_t			users;
+
+	/*
+	 * Set by the attach interface callers. The type field could be used
+	 * by the caller to identify whether the priv field was installed by
+	 * them.
+	 */
+	enum attach_handle_type		type;
  	void				*priv;
  };

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index c66cf26137bf..3eb664cc3f3a 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -90,7 +90,11 @@ struct iommu_attach_handle 
*iommu_sva_bind_device(struct device *dev, struct mm_
  	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
  	if (handle) {
  		mutex_unlock(&iommu_sva_lock);
-		return handle;
+		if (handle->type == ATTACH_HANDLE_TYPE_SVA)
+			return handle;
+
+		iommu_attach_handle_put(handle);
+		return ERR_PTR(-EBUSY);
  	}

  	/* Search for an existing domain. */
@@ -118,6 +122,7 @@ struct iommu_attach_handle 
*iommu_sva_bind_device(struct device *dev, struct mm_
  out:
  	handle = iommu_attach_handle_get(group, iommu_mm->pasid);
  	mutex_unlock(&iommu_sva_lock);
+	handle->type = ATTACH_HANDLE_TYPE_SVA;
  	handle->priv = dev;

  	return handle;

Best regards,
baolu
