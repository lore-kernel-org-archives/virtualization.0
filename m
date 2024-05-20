Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFE679EF
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 01:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716168939; cv=none; b=pF8ZzAbiLDmRVifschp1ImZoAoWZDl9uIzpmzRTH6qMIKwFZS+W4bBhrJ7QJxuNOSCj0SoQpDGemQkCfA5aKc/6YWJnBjIa5a8PWSEaLIaSuXV6Av32f7quuaUFFJ4pAF/k1Vfkfxknco1NQQNQSTFg7u1SYrsyP935nT8ZtA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716168939; c=relaxed/simple;
	bh=VR6ZYeZcCM4yblOV/1NPtY2M0KZ0UgfEH1ScYqV1UsE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LlRlmMt7bjs5BhsSlV/5ORQBsojcNqXiW3JouE/IobgpDumrnadz/8zdmtIZhcfX1uh5riVtPBv9wu0f7bHO5izbWl0edU1TUvnr+ZVgu3tOTfDKeSDGUmudUvTXTysc/1Mva29RUvyGeg8G7XlcT+fMeLhF4UCT8ZLuDrKuFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rip0IDHf; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rip0IDHf"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2267260673
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 01:35:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -4.299
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ABB_XqfDr0Rl for <virtualization@lists.linux-foundation.org>;
 Mon, 20 May 2024 01:35:37 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.17; helo=mgamail.intel.com; envelope-from=baolu.lu@linux.intel.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 2D5436066A
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none) header.from=linux.intel.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2D5436066A
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Rip0IDHf
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2D5436066A
	for <virtualization@lists.linux-foundation.org>; Mon, 20 May 2024 01:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716168937; x=1747704937;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VR6ZYeZcCM4yblOV/1NPtY2M0KZ0UgfEH1ScYqV1UsE=;
  b=Rip0IDHfRkWP+RoQheHR8T1j/9skr0xg0+vz3qdL2i8/Zm8LiAtqzdfB
   VAlQMdgzwFek3YQ0JtS7RF+hONN5GCs8JCfajTjJV9BT/R8WK6f8ItaVH
   7hsQVXoKGNj1JZplcmkY5gTqL82jRxuijCCT7jlInZPhfMX0LgkI1uhiG
   SHfwQAScX49mAlaYdBuWBpqJQ9oh4hpjGAMW8eFS+DoIYWTWpcwWBek+w
   2JkHC3Qi88gYHo7or/zxabpHXEAcN+fO2n50AU+n2qy1tJcWjzAGVrCZR
   YzfZlNaEt8e9dfFxs3bc+2kxapRPVcnzJ/Ygz79HpOg6hmiQtFgNGSbjp
   g==;
X-CSE-ConnectionGUID: 2ubDCng5Q0eYQNFKHBIdrA==
X-CSE-MsgGUID: mn8/MRnCT66ZwoSdXjboYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11077"; a="12399690"
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="12399690"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2024 18:35:36 -0700
X-CSE-ConnectionGUID: QUaP7uYHRRyDzJoDH8+C4A==
X-CSE-MsgGUID: yZT4bqSOQCGZ3TdBEi/f4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,174,1712646000"; 
   d="scan'208";a="69808925"
Received: from unknown (HELO [10.239.159.127]) ([10.239.159.127])
  by orviesa001.jf.intel.com with ESMTP; 19 May 2024 18:35:32 -0700
Message-ID: <e30d919c-2e28-4e01-8317-2a4d82049056@linux.intel.com>
Date: Mon, 20 May 2024 09:33:41 +0800
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
Subject: Re: [PATCH v5 5/9] iommufd: Add iommufd fault object
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Joel Granados <j.granados@samsung.com>
References: <20240430145710.68112-1-baolu.lu@linux.intel.com>
 <20240430145710.68112-6-baolu.lu@linux.intel.com>
 <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52769AC595B6BDA8FB4639258CEC2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/15/24 4:37 PM, Tian, Kevin wrote:
>> +
>> +		iopf_group_response(group, response.code);
> PCIe spec states that a response failure disables the PRI interface. For SR-IOV
> it'd be dangerous allowing user to trigger such code to VF to close the entire
> shared PRI interface.
> 
> Just another example lacking of coordination for shared capabilities between
> PF/VF. But exposing such gap to userspace makes it worse.

Yes. You are right.

> 
> I guess we don't want to make this work depending on that cleanup. The
> minimal correct thing is to disallow attaching VF to a fault-capable hwpt
> with a note here that once we turn on support for VF the response failure
> code should not be forwarded to the hardware. Instead it's an indication
> that the user cannot serve more requests and such situation waits for
> a vPRI reset to recover.

Is it the same thing to disallow PRI for VF in IOMMUFD?

Best regards,
baolu
