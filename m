Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB6FED8
	for <virtualization@lists.linux.dev>; Tue, 14 May 2024 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715649775; cv=none; b=ubXMHOE5FuqobcktR4g1cVVAWzaBAlOebEIpFWvCN7yooenPRIqotMtiROIH94N4/yy5HDOrzUUfy+ha4xZVUKZO3GkHT2FnlY4m77n/xhNgGcedyzOrXFhjTmY7sIGU9HHhh2lXGg/u31TNAXRkID+tVKtTM/xqC46R82pYNkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715649775; c=relaxed/simple;
	bh=KcSAhfkKjg48lWb+u9Se00jZY+Ca/+7lULD/usjk/9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ads0kzuNBrUaZ2kjvHsorZvlfZd+lFV5j2lVwieA1B8EpUksAkBE1HPyLHAzGqZ1DqmyJ1tE5I7J0h7SZKDmUZd4thySovFY9onCDk8nrsc15q8dxTzhgZapJRS3zsAGF5jXn1CXokc2w8/NLE1aXFTd+s3bFSLNV7LIbj8IVIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zt9s3GUi; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zt9s3GUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715649774; x=1747185774;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KcSAhfkKjg48lWb+u9Se00jZY+Ca/+7lULD/usjk/9k=;
  b=Zt9s3GUigo+sywbZSTDOnvLVVY3zBDookecLZ0eJ0VQiJ5woxhi7mOnM
   XEmCGjo1vUHaAHmG/fLqoqJ27qe1eF4KRy3rDURUrv43j2+xohA54G7lG
   3F9/Mwtj4VhpjkPEOyei/aS5Rxzw3mfqE5a8OWkeHr9lbj7Z2jDmuTumn
   J0ZcMeY3uFxgtb1S/0BKQEDGIh81fZuSSLGu5DDImnbde/iXV9x0Rg44R
   iiHyWXxbnveEnGIJ43Jzt//N/KlzMh8EZhspn3N0SY03o2j/9mCV0ctRv
   3v4sMHhiQqIqYjfejP2lNXIsa1OLd7THleEcqbmmf69Ycy1ZzPeT8mTVV
   A==;
X-CSE-ConnectionGUID: DlTQTvwZQDqJlkAcjouWEA==
X-CSE-MsgGUID: HSaby7itSleGLAgVZcOInQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11430683"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11430683"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 18:22:52 -0700
X-CSE-ConnectionGUID: MzGZSR5rRZCQrsShFQpUMA==
X-CSE-MsgGUID: e5fNE3+tQ96X8thTIEjkdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30457049"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.125.245.197]) ([10.125.245.197])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2024 18:22:51 -0700
Message-ID: <500997a7-6db6-4714-9aa2-a56c03de83ea@intel.com>
Date: Tue, 14 May 2024 09:22:48 +0800
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ifcvf/vDPA: ifcvf drives standard virtio pci devices
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev
References: <20240513212707.9894-1-lingshan.zhu@intel.com>
 <20240513093506-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20240513093506-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/13/2024 9:38 PM, Michael S. Tsirkin wrote:
> On Tue, May 14, 2024 at 05:27:07AM +0800, Zhu Lingshan wrote:
>> Most of ifcvf code work for standard virtio pci,
>> except for bar4. This commit makes bar4 only effective
>> for Intel products, thereby turning ifcvf into
>> a standard virtio pci driver.
>>
>> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
>> ---
>>   drivers/vdpa/Kconfig            |  2 +-
>>   drivers/vdpa/ifcvf/ifcvf_base.c | 17 ++++++++++++-----
>>   drivers/vdpa/ifcvf/ifcvf_main.c |  5 ++++-
>>   3 files changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
>> index 656c1cb541de..dbf09f35bcef 100644
>> --- a/drivers/vdpa/Kconfig
>> +++ b/drivers/vdpa/Kconfig
>> @@ -44,7 +44,7 @@ config VDPA_USER
>>   	  in a userspace program.
>>   
>>   config IFCVF
>> -	tristate "Intel IFC VF vDPA driver"
>> +	tristate "Intel IFC VF and standard virtio-pci vDPA driver"
>>   	depends on PCI_MSI
>>   	help
>>   	  This kernel module can drive Intel IFC VF NIC to offload
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_base.c b/drivers/vdpa/ifcvf/ifcvf_base.c
>> index 472daa588a9d..47bc9b11c678 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_base.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_base.c
>> @@ -178,7 +178,8 @@ int ifcvf_init_hw(struct ifcvf_hw *hw, struct pci_dev *pdev)
>>   		hw->vring[i].irq = -EINVAL;
>>   	}
>>   
>> -	hw->lm_cfg = hw->base[IFCVF_LM_BAR];
>> +	if (hw->pdev->subsystem_vendor == PCI_VENDOR_ID_INTEL)
>> +		hw->lm_cfg = hw->base[IFCVF_LM_BAR];
>>   
>>   	IFCVF_DBG(pdev,
>>   		  "PCI capability mapping: common cfg: %p, notify base: %p\n, isr cfg: %p, device cfg: %p, multiplier: %u\n",
>> @@ -330,18 +331,24 @@ u16 ifcvf_get_vq_state(struct ifcvf_hw *hw, u16 qid)
>>   	struct ifcvf_lm_cfg  __iomem *lm_cfg = hw->lm_cfg;
>>   	u16 last_avail_idx;
>>   
>> -	last_avail_idx = vp_ioread16(&lm_cfg->vq_state_region + qid * 2);
>> +	if (lm_cfg) {
>> +		last_avail_idx = vp_ioread16(&lm_cfg->vq_state_region + qid * 2);
>> +		return last_avail_idx;
>> +	}
>>   
>> -	return last_avail_idx;
>> +	return -EOPNOTSUPP;
>>   }
>>   
>>   int ifcvf_set_vq_state(struct ifcvf_hw *hw, u16 qid, u16 num)
>>   {
>>   	struct ifcvf_lm_cfg  __iomem *lm_cfg = hw->lm_cfg;
>>   
>> -	vp_iowrite16(num, &lm_cfg->vq_state_region + qid * 2);
>> +	if (lm_cfg) {
>> +		vp_iowrite16(num, &lm_cfg->vq_state_region + qid * 2);
>> +		return 0;
>> +	}
>>   
>> -	return 0;
>> +	return -EOPNOTSUPP;
>>   }
>>   
>>   void ifcvf_set_vq_num(struct ifcvf_hw *hw, u16 qid, u32 num)
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
>> index 80d0a0460885..e89fd4d96ff1 100644
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
> Will make it conflict with the normal virtio driver, won't it?
>
> What are you trying to achieve here?
The confliction exists before, in my setup, virtio-pci driver always 
probe virtio-pci devices
before ifcvf.

Since ifcvf drives is all standard virtio-pci except for bar4, so this 
patch intends to maximize
the use of the ifcvf driver and allow developers without Intel hardware 
to also develop this driver.

Thanks
Zhu Lingshan
>
>
>
>> -- 
>> 2.43.0

