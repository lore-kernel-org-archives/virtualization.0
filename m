Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387B15E89
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 01:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718674688; cv=none; b=nNgN65/vqthjdExV4IA4qnlDPsEPBn3j/cW8FkLYemh8c5gPJ7e1MwIFGm4ODs6k1X3ov8vIQv/LL7LVvb1dT+kEfOrx28ClTisW+f/bd4nx6EpnSIS4F9PJznpizlw7vw2L+X/D48spdlZa3RqKP10tMO7B4oRs4WfZSeEF4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718674688; c=relaxed/simple;
	bh=4SfRuGLXuOtfgs+VhCcT8scU2Nzh8VcPuJvjNReQd84=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fzm/KSWCxFsoOsm0lMq1gKBb+EJPrQ1I/QeaoiFB3Z7FWnrO817sw6BKxSanRCSl2+cBnIMwWCMb96JRYa4St802l1UJhPwpn913wzClW/sdL+FpgC5Csd4J2XIPvdjg854R25s7t/E8at4E5kuWiYo97DN0JYNu33XkOAhuJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gO5heBFj; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gO5heBFj"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6B6C360792
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 01:38:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aVmHh0ZnjzHK for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jun 2024 01:38:05 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4F75C60784
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F75C60784
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=gO5heBFj
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4F75C60784
	for <virtualization@lists.linux-foundation.org>; Tue, 18 Jun 2024 01:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718674685; x=1750210685;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4SfRuGLXuOtfgs+VhCcT8scU2Nzh8VcPuJvjNReQd84=;
  b=gO5heBFjfvlg+0W8pywRbw53hrYyY2HZdPl9rtMbABQLWYtVPjEsyKsZ
   byLKmTxclfKgCth786263N+owybUD5iFdjLFFNF7Q5aSPhBjRud07v2Io
   jEjJnLiceo9uYrVPkUveAh2KZUy+Z2IJk6Xgz5dhVjJQ+yOZxRR1KRj7Q
   jQCAf5isdgsmQoSwLW1NZbmoqeq4JFV1tH7k7obWs2D/KeOTxxJV883UH
   NuEZmhHJOnKS4CezugAWCQZNZQagt97xuZ9lOw4uA0NIexhNiYVtS96vx
   0QALQqnVHkLgSVhsqhC7/yHUPaUtFEVJcrqr4s8Ezhoi2SqwD7D3pnwm3
   w==;
X-CSE-ConnectionGUID: 98BKW3u2R1i4lx4GG71IxQ==
X-CSE-MsgGUID: T0ktjBkIRr+wVVhW96lJ+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="26158146"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="26158146"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 18:38:03 -0700
X-CSE-ConnectionGUID: Ddl5w9urQ/iFSVCmAUcTRg==
X-CSE-MsgGUID: kIYlmEebQyW7v5j/rRk+lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41481150"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa010.fm.intel.com with ESMTP; 17 Jun 2024 18:38:00 -0700
Message-ID: <dea1adb9-2980-4c7b-8ddd-c7ed800f983c@linux.intel.com>
Date: Tue, 18 Jun 2024 09:35:35 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 03/10] iommu: Add attach handle to struct iopf_group
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240616061155.169343-1-baolu.lu@linux.intel.com>
 <20240616061155.169343-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C5ED6E9CEB0B22B0CC108CCD2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C5ED6E9CEB0B22B0CC108CCD2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/17/24 3:41 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, June 16, 2024 2:12 PM
>>
>> Add a new IOMMU capability flag, IOMMU_CAP_USER_IOASID_TABLE, which
>> indicates if the IOMMU driver supports user-managed PASID tables. In the
>> iopf deliver path, if no attach handle found for the iopf PASID, roll
>> back to RID domain when the IOMMU driver supports this capability.
>>
> 
> above is stale.
> 

Yes. "a new IOMMU capability flag, IOMMU_CAP_USER_IOASID_TABLE" should
be changed to "a static flag in iommu ops".

Best regards,
baolu
