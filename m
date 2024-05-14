Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78781370
	for <virtualization@lists.linux.dev>; Tue, 14 May 2024 01:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715650064; cv=none; b=k9XRc6EOZ1XofT2Gbn3Ae0N2NDtdOkJ5NzNOpY3C8VqbqxgB24Orp0NN2AromDiBw38tL7bt9PjxzMTNCouhcsg08Gr+htmsEqvX0gOQ1wSZAMEf/yboWyCVOptZrjYFZ4YKX68lboW2hlCWJ86jgA6UU5qME3yPTXA5LlnbMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715650064; c=relaxed/simple;
	bh=TfkQ5HFd6hbl8/3H0BVgplffWHY6HcPiwLTS2SAyR0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ug+7wmWpafsCFq/c1hajfWk/yvpDtGLcnsc99CHGmSCT6zJwiqUx9GB66wl5ZdrhWnTlv41mRFOpcmr0ZTVyVcmqzrKQnCybjsn5dkOw/sp04wkVOwZyIBMfW5yeUMj8Kz2NiC5oAq6JMvf970wCUM8YYnYmqKYkEVsEIXDlPp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NQB3Coet; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NQB3Coet"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715650063; x=1747186063;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TfkQ5HFd6hbl8/3H0BVgplffWHY6HcPiwLTS2SAyR0o=;
  b=NQB3Coet6kYG1ZCIKLlX06Ie8Glc4WNhCqLWKoKFKduzQsgiJenl+hda
   XWm7Ge2n39xFWlPw0K3NNd1UOzTcd1lxyxTy4Q2kQ2ALvDSuRIkMF8tP6
   S4HY+80PDw5DZZDdVHj5sv63h0pomzAtcaQ7QCQaey5eWftXi7+HhNrEM
   y0ebATAsZWGtSbwqL3JByiPWxwJcnP+t0gry9mw9Ng4FHoqHQ5Vc5UMpp
   0D0ekJnWgaCu3tilVwu1z2p1xhF1HBQehsnMsyzbTG2tnperbuVphP40m
   7gU0KIBi31MSvyB5XgfP2cqTvLYZiQ/8JWHPZjrXQsRRZbF8418J4xz9r
   A==;
X-CSE-ConnectionGUID: YTUC6QHQRiKdAl13p0SujA==
X-CSE-MsgGUID: b2X7iPAtRhi1FzqRxAIa0g==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11466264"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11466264"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 18:27:42 -0700
X-CSE-ConnectionGUID: fYXM1UaoSWqXGeDo/FChFQ==
X-CSE-MsgGUID: WW/D6cdbR/GMlNkd2jcEnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30584023"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.125.245.197]) ([10.125.245.197])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 18:27:41 -0700
Message-ID: <a5b4f0b0-caba-463b-ae60-f9a0bbb806f3@intel.com>
Date: Tue, 14 May 2024 09:27:38 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ifcvf/vDPA: ifcvf drives standard virtio pci devices
To: Parav Pandit <parav@nvidia.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>
References: <20240513212707.9894-1-lingshan.zhu@intel.com>
 <PH0PR12MB54814D7C2081F336ADCEC341DCE22@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <PH0PR12MB54814D7C2081F336ADCEC341DCE22@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/13/2024 9:36 PM, Parav Pandit wrote:
> Hi Lingshan,
>
>> From: Zhu Lingshan <lingshan.zhu@intel.com>
>> Sent: Tuesday, May 14, 2024 2:57 AM
>> To: jasowang@redhat.com; mst@redhat.com
>> Cc: virtualization@lists.linux.dev; Zhu Lingshan <lingshan.zhu@intel.com>
>> Subject: [PATCH] ifcvf/vDPA: ifcvf drives standard virtio pci devices
>>
>> Most of ifcvf code work for standard virtio pci, except for bar4. This commit
>> makes bar4 only effective for Intel products, thereby turning ifcvf into a
>> standard virtio pci driver.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   drivers/vdpa/Kconfig            |  2 +-
>>   drivers/vdpa/ifcvf/ifcvf_base.c | 17 ++++++++++++-----
>> drivers/vdpa/ifcvf/ifcvf_main.c |  5 ++++-
>>   3 files changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig index
>> 656c1cb541de..dbf09f35bcef 100644
>> --- a/drivers/vdpa/Kconfig
>> +++ b/drivers/vdpa/Kconfig
>> @@ -44,7 +44,7 @@ config VDPA_USER
>>   	  in a userspace program.
>>
>>   config IFCVF
>> -	tristate "Intel IFC VF vDPA driver"
>> +	tristate "Intel IFC VF and standard virtio-pci vDPA driver"
> The virtio specification limits the subsystem vendor and device id usage for informational purposes only.
> Hence this change/claim here for standard is not good.
>
> I don't have objection to have per vendor creativity in the spec, but for that let OASIS commit to ratify the spec to use subsystem vendor and device id for non-informational purposes.
> And amend the spec " (for informational purposes by the driver).".
The spec says:
The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY reflect 
the PCI Vendor and Device
ID of the environment (for informational purposes by the driver).

I don't see how this change conflicts with the spec.
>
>>   	depends on PCI_MSI
>>   	help
>>   	  This kernel module can drive Intel IFC VF NIC to offload diff --git
>> a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c index
>> 472daa588a9d..47bc9b11c678 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
>> @@ -178,7 +178,8 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev
>> *pdev)
>>   		hw->vring[i].irq = -EINVAL;
>>   	}
>>
>> -	hw->lm_cfg = hw->base[IFCVF_LM_BAR];
>> +	if (hw->pdev->subsystem_vendor == PCI_VENDOR_ID_INTEL)
>> +		hw->lm_cfg = hw->base[IFCVF_LM_BAR];
>>
>>   	IFCVF_DBG(pdev,
>>   		  "PCI capability mapping: common cfg: %p, notify base:
>> %p\n, isr cfg: %p, device cfg: %p, multiplier: %u\n", @@ -330,18 +331,24 @@
>> u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
>>   	struct ifcvf_lm_cfg  __iomem *lm_cfg = hw->lm_cfg;
>>   	u16 last_avail_idx;
>>
>> -	last_avail_idx = vp_ioread16(&lm_cfg->vq_state_region + qid * 2);
>> +	if (lm_cfg) {
>> +		last_avail_idx = vp_ioread16(&lm_cfg->vq_state_region + qid
>> * 2);
>> +		return last_avail_idx;
>> +	}
>>
>> -	return last_avail_idx;
>> +	return -EOPNOTSUPP;
>>   }
>>
>>   int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)  {
>>   	struct ifcvf_lm_cfg  __iomem *lm_cfg = hw->lm_cfg;
>>
>> -	vp_iowrite16(num, &lm_cfg->vq_state_region + qid * 2);
>> +	if (lm_cfg) {
>> +		vp_iowrite16(num, &lm_cfg->vq_state_region + qid * 2);
>> +		return 0;
>> +	}
>>
> This is more than informational and requires OASIS virtio committee to add section to indicate per subsystem vendor to allow its modifications.
This is Intel Specific implementation.
>
>> -	return 0;
>> +	return -EOPNOTSUPP;
>>   }
>>
>>   void ifcvf_set_vq_num(struct ifcvf_hw *hw, u16 qid, u32 num) diff --git
>> a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c index
>> 80d0a0460885..e89fd4d96ff1 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /*
>>    * Intel IFC VF NIC driver for virtio dataplane offloading
>> + * This driver also drives standard virtio-pci hardwares
>>    *
>>    * Copyright (C) 2020 Intel Corporation.
>>    *
>> @@ -880,7 +881,9 @@ static struct pci_device_id ifcvf_pci_ids[] = {
>>   			 VIRTIO_TRANS_ID_BLOCK,
>>   			 PCI_VENDOR_ID_INTEL,
>>   			 VIRTIO_ID_BLOCK) },
>> -
>> +	/* standard virtio pci devices */
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET,
>> +		     PCI_ANY_ID) },
>>   	{ 0 },
>>   };
>>   MODULE_DEVICE_TABLE(pci, ifcvf_pci_ids);
>> --
>> 2.43.0
>>
>

