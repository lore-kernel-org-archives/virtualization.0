Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104339FF7
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Feb 2024 06:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708495590; cv=none; b=Y0KG4r3L85+P2ByskL6Cbvadgn2p0uVVk8kfxE23PfygAz2PMTcwPNPTpWh9V1dVzqLADmRK5ym7eJOf2UX3IhrZKdwqHJLjuGTn10MbZZM3X9nHa607jJ+R4g3emLo4pwlAP33nVdBVJlkQEfvKSLADy1pjySTt1jYkR/K/a9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708495590; c=relaxed/simple;
	bh=7Br77jPOvxXbE+vPj5DX/LCE+itwJHpwXrfu8hQtPCA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jHPRIyxFmkQlug5zd4/hoqm0i1JFUqnRha3MGEjf+HkiPQtR10PpxmNoi1w4CZCx+7tjlN4YK0k8iRX8PLaI12okCzsDWauREK/A2EP7dPA5TuqUa1Tb4umu65LNwN5I9yWELTC9IfralR7bY/L8hwxZwYKCiQNpLc9YA7CnGWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OP8BMFGK; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OP8BMFGK"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F197141599
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Feb 2024 06:06:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.999
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q4Q_bZ6kPv6q
	for <virtualization@lists.linux-foundation.org>;
	Wed, 21 Feb 2024 06:06:27 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 4EA7A41596
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4EA7A41596
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OP8BMFGK
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4EA7A41596
	for <virtualization@lists.linux-foundation.org>; Wed, 21 Feb 2024 06:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708495588; x=1740031588;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7Br77jPOvxXbE+vPj5DX/LCE+itwJHpwXrfu8hQtPCA=;
  b=OP8BMFGK0eZxb90yv6M7eYZ7XS2IbIUeN55Srgflp5SngIhEx0ouoMPP
   u4x5PS/fvr4nejqxquGLSFhu+ID8kXOuGsOpy6yjt3o6rE9wSVi1OEo5W
   lu8q8Az+LKKcyCKrbNxumpdR5Ad1BR8RN/ZuRpu/sGvzQ6hNi4g2L135G
   efiFfb7UiUa6RPl9egw6s9lwIDDXSZ9KOxL/zJGmLNiwTFz63qIRgrdLW
   C6B61pzHuusplTyGjNFSu16Yeb8XtGqX/cH/yu93aXCnFN5IdNxyiLQJu
   2EvRlNFxQRRUMFIFZ3845yh3FbGabA7+EnNyIw94llwr5JmZdEdCyXiwo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="20071182"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="20071182"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:06:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9677457"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.203]) ([10.249.171.203])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 22:06:22 -0800
Message-ID: <56519d16-88a3-4ed8-a973-e931d22c478e@linux.intel.com>
Date: Wed, 21 Feb 2024 14:06:19 +0800
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
Subject: Re: [PATCH v3 5/8] iommufd: Associate fault object with
 iommufd_hw_pgtable
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
 <20240122073903.24406-6-baolu.lu@linux.intel.com>
 <BN9PR11MB5276C0BA42924298B650A5C28C452@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C0BA42924298B650A5C28C452@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/7 16:14, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Monday, January 22, 2024 3:39 PM
>>
>> +
>> +int iommufd_fault_iopf_handler(struct iopf_group *group)
>> +{
>> +	struct iommufd_hw_pagetable *hwpt = group->cookie->domain-
>>> fault_data;
>> +	struct iommufd_fault *fault = hwpt->fault;
>> +
> 
> why not directly using iommufd_fault as the fault_data?

The relationship among these structures is:

     iommufd_hwpt -> iommu_domain
           ^
           |
           v
     iommufd_fault

It appears preferable to hook the hwpt instead of iommufd_fault to an
iommu_domain structure.

Best regards,
baolu

