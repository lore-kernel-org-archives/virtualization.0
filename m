Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9180242ABE
	for <virtualization@lists.linux.dev>; Wed, 15 May 2024 07:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758111; cv=none; b=hQfHXfoEOPFUJag6tibXSbokcxEQrnGbrXTqhrBhBK6L+XkBEMBdxcMuzlai40SRfWjHVSae0ziXQyIMNdDAHZaQ2gP4KaivtIoTSxRHyavPb8EHe3K7JY9V1yKBSZ8RvFUiG/qfODdpZnVGrgji3DKilRi6kUBlaUxnvQDoWm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758111; c=relaxed/simple;
	bh=YLbYeR2qa2wbfO2nU+XWi7bTC6EFmE0dyzqkh+N5NAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEtYh889sWTg1DVK/sNSI2df51EpPpBNEwUtwZidCZ0cYIJZ366DNDickZZp0DNlinIQJfBxc7yTHTbmcHStHZArJWjsx2drvEVtky9WsJ9ycMoQyqh4QUMkLQGs88+Y4lcCOy0BsR75ynGC2QoE9oZnuutheM92aLA/w5oH0uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q++NISsA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q++NISsA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715758110; x=1747294110;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YLbYeR2qa2wbfO2nU+XWi7bTC6EFmE0dyzqkh+N5NAc=;
  b=Q++NISsAuZUheV+D90SMLlHjFBSEtVaXKroboAbM7lKQiZ3tIL/9wvt8
   vUdHjncLttBRAE0ZQ4QEWPhsDLCSKMR7zZgDZ91PZ4cJsW6t0ZNYSkUnr
   KRXVESv5OiFHWYny9IXlshY9wohOzXxHAhGEDFMDkuLAR/85sk9iKT+Dz
   oSToLa1J2rvqRuJ3+N6O+wCSO/Hl/Kk7mm8RX4ofE6FCnH1+5B4iFtYze
   EmOCcVLfsoXk+va9DfEGyEKsa1p9nYrDYEtHimvcQP1KHImXuIqCOXIPo
   gYCszJk5DW5Z+Z3lkq8S3DZ9OFG+TQuMeiGTn5ugXFR7cIzsyBX5+9DeX
   g==;
X-CSE-ConnectionGUID: HVu5AOL5TKiA9piOPQySgg==
X-CSE-MsgGUID: pUnRx3dKSyObkvD7qgBCcA==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="23192870"
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="23192870"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:28:29 -0700
X-CSE-ConnectionGUID: gqXDQH8xRZGC7/T8jl4/gw==
X-CSE-MsgGUID: cpM15ZpSTz6Un7ujWz2QWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,161,1712646000"; 
   d="scan'208";a="31379847"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.125.245.197]) ([10.125.245.197])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 00:28:26 -0700
Message-ID: <58a3e4b1-dae6-4f37-b5b7-0c77b9b6b839@intel.com>
Date: Wed, 15 May 2024 15:28:23 +0800
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
 <20240514094234-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <20240514094234-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/14/2024 9:44 PM, Michael S. Tsirkin wrote:
> On Tue, May 14, 2024 at 05:27:07AM +0800, Zhu Lingshan wrote:
>> @@ -880,7 +881,9 @@ static struct pci_device_id ifcvf_pci_ids[] = {
>>   			 VIRTIO_TRANS_ID_BLOCK,
>>   			 PCI_VENDOR_ID_INTEL,
>>   			 VIRTIO_ID_BLOCK) },
>> -
>> +	/* standard virtio pci devices */
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET,
>> +		     PCI_ANY_ID) },
>>   	{ 0 },
>
> To summarize, I don't think ifcvf should drive standard virtio devices.
> If it can then it sounds more like a reason to try to reuse more code
> from virtio core.
Yeah, OK.
By the way, I send out a V2 of MAINTAINER patch only changing my
email address to kernel.org.
>
>
>>   };
>>   MODULE_DEVICE_TABLE(pci, ifcvf_pci_ids);
>> -- 
>> 2.43.0
>

