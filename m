Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B52D3A60
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043713; cv=none; b=TSuRj1G5Eqd2e+a+F7itmKaaDxKm+bH2vfwzCK3yW5dHFOb4gDwIgWgYFnfr/RlInEyGojeWM78F0p/Y1RjhLsH7c/IiSOl9LFhvCFY2K46Qu9rDPESxpkOjD8rBhdlSeg+4jkl8wMvQX8V8QHKfyikMzW8ZKahin1qalLx3TXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043713; c=relaxed/simple;
	bh=ioJ64Vv4/63C6jN9tf7/hYM07FRHdTvnzqSDPYYNvoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=susWW1MVQFgOAXnDbKYeJfc1k09J9RReSrujIrtqoHDf4lruhVevMqBYagqVlDPA30E7/GEe230MQwTBFzi0fuNws7lssFfpk6lNveKNDLvIoKAwEsJpM7yb3drqAdKZ7LgfhF+g64h+KpKVIaKz6RFd/Ob26l7wdLFargBWTJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=DW3TZ+JD; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="DW3TZ+JD"
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O8ah9O037893
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 08:15:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=q9BtwkbPllejPVBe4f4tiQUOCFRGB+hx4Z1hh2G7sJU=; b=DW3TZ+JDjU0O
	zwt4q4JN+sUgpBDXiEjG+mOHnHds07sqT+OYjLqB058WrppSFseAB2c40/AxM+YQ
	+b7Q4DrERbPIvOslCMIx9iwGhC9Lc79qdx5a21IfgWUrd9ahvmspNrsp90eP6kkK
	gwcRwuFmBHLUonsd51ltnnxOlAAfLhY3STLctMdm3tvyCeIh7rE6hctfyQTPKY4e
	RI/4KFLPXVfGugVEG8mK6Rv70AMmGhjPGxoeb2HIi/vQV6Bmr+yi39HUHMRHr/7Z
	rcIIEmMRDuQsF3v2mgyaCSznhm9HlhOuxImu0MjL+g4rGC0fIRlk73PpY28TsUi3
	RKI+t7xmPA==
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dr55c1xn3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 08:15:10 -0700 (PDT)
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-66f103b3141so5038821a12.0
        for <virtualization@lists.linux.dev>; Fri, 24 Apr 2026 08:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777043709; x=1777648509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q9BtwkbPllejPVBe4f4tiQUOCFRGB+hx4Z1hh2G7sJU=;
        b=A2P4UViP0BsxwBmIaRZvv1bfPXa2GR7mlHGIprFFKE4NGPjLoiirmgGvGLntwhebSX
         Rxu6T1J3DJ9e1MweEgbFHO5mnARPG0dFWkCVXFiDaaTFikjizZw4ab+hD20/t5PnIkyp
         7UNNeweQuytykDhxJt/cPbtcZdKT5p187osXwo3zOnnLgsQkke26rnWeUOS9SHf6Csst
         iYpg3a35eBkeRgGjedchzaam7gM1lyVTQP2F0L1Z2Ca2H1S6COx6mwTO9u2IVRr819/o
         DK04RD8xjnYrg99AzcWHXbs1B4FvSRP6jg/0kaz0/YlQb0k1T7LzbIV4hJQJx9/m0tfZ
         3QQg==
X-Forwarded-Encrypted: i=1; AFNElJ9erSZ0vqgF0TXJF54EV9Y8r2c6InFNMr4Kcg7tXNll+DZfka0AJ8Wt1OZvdsgwcTlGs46YEme/DvcXje1NZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyW6DYmNBHm0zWJdrzWVbWDswPICO6Pypds4+TzaT20eVKixpVc
	eov40rKxtzeUAg/Vk69/7iUSYIZYXvcDCg5qeSM56cgPSSVuY4IOazHc49dmF13mO+VXGnuKdiv
	pJMGeV0W0VOkE+cqRZtBPewpV40bAV0rwqcA8y9I+HPrkKEjrkChyRoHE2CGwYY5KgtA=
X-Gm-Gg: AeBDieudCm0HXUYjaNdehni/pYqeCzBCMaaswou8IwpHP/OJQJVeGBFFXduPGRl94Q2
	GfCJV7KArdm1bqTiTn3QyMNP804+kgJ6fOW4Tro3vxMzSVNBV2jOc7CRt/IfCsirBVQePYTcPdZ
	Zu4YfX3hIP8wi8kacpHBD2355uubQkpukTCtHh8d1K1mQ32KDu9SIL2JyYtG6LRe6pBHbSd+Yv0
	jVzIzLwQjszz9LA2LS9SBetnHDREw6Pvfh76XQPUlOwCYrQGQYIxw8j4NfuvS1KXb+JYR910C8G
	B4xJExGPO+Y847pMbq7Vz7hhyLR9N+SauCgpXU5j+ypEqqEwpqmq22azMgrTfwJUAhwm9N/WrRD
	wCAUzL/7/wu3FkrLuv6PcK55PrBbgOPJciNP32Efdb1xi2U9bzDCdJx1QnkTWjWm72tIdaPkSn6
	cig446t1yCn1hlbQOSVODzdM2ldJQ5Xyph/zwxfDnxA9+nJf2tX6HjBAQk29MKtUxfjO+eupXEI
	ljPzvOEnKG9pjDq7OQhnpupRsjtI0FjYQ==
X-Received: by 2002:a05:6402:1c04:b0:670:3b53:9bc with SMTP id 4fb4d7f45d1cf-672bfd8b7f6mr10189109a12.4.1777043708645;
        Fri, 24 Apr 2026 08:15:08 -0700 (PDT)
X-Received: by 2002:a05:6402:1c04:b0:670:3b53:9bc with SMTP id 4fb4d7f45d1cf-672bfd8b7f6mr10189093a12.4.1777043707727;
        Fri, 24 Apr 2026 08:15:07 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde? (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c4d5babcsm4861621a12.23.2026.04.24.08.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 08:15:07 -0700 (PDT)
Message-ID: <729d6593-f88b-42bf-b3a0-8c364d9ca5b4@meta.com>
Date: Fri, 24 Apr 2026 16:15:06 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] vfio/pci: Set up bar resources and maps in
 vfio_pci_core_enable()
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Ankit Agrawal <ankita@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>, Kees Cook <kees@kernel.org>,
        Shameer Kolothum <skolothumtho@nvidia.com>,
        Yishai Hadas
 <yishaih@nvidia.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Eric Auger <eric.auger@redhat.com>, Peter Xu <peterx@redhat.com>,
        Vivek Kasireddy <vivek.kasireddy@intel.com>,
        Zhi Wang <zhiw@nvidia.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev
References: <20260423182517.2286030-1-mattev@meta.com>
 <20260423182517.2286030-2-mattev@meta.com>
 <20260423153053.6833135e@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260423153053.6833135e@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qRPoOh7zP30lRu1DmXoRrARyX7EnS3B0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE0NyBTYWx0ZWRfXwz84SDF76GiC
 uzYuF0EMw/q8EBcAwmmIqW8CkYOpKt13k6MhaS/WZ12oWQ0v1Na66RDfZ5DZTnVS7rrGfJtXJMJ
 xzNZ3zIe3o60rmlY3E2Gkm+/HwDGrKcTFmC7y6UlMMIBpbx7O3IW7OeSncUrv5VMlx/FDMlyHV+
 4zq3FpjzMPOzlsX+ndiWzW94Fd8Sug1wKimlwbQMA7DWoSbgtUUcLQARy/eVj6mQP8UNEm95eYH
 Ks45rvzw/vYnAPftt7NT/0eamb+Xt7ZPy6dboAxhVM3/2MGq17Hq+92/PeNz8n5ryvIuEUjdJcF
 Kl7Y7Lk/20ZvYcyrKG1GDovcN2sq6lvadyjV580bWF0zbq1a0RfxueY6XfZBAeGEf/ndX0U41r9
 fYMThN+YnGk3quoL/6J4wy+gVzjsAZ875HJeRcgEMcAsDJauGs9xUO1tErr4R2UqZbH998gASrv
 OT25skoyCOpC0ONbkSQ==
X-Authority-Analysis: v=2.4 cv=fprsol4f c=1 sm=1 tr=0 ts=69eb88fe cx=c_pps
 a=DTy5UCxgudPLKrSn28m7Kw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=tpM8CJlwf7uhpglF1g9U:22 a=VabnemYjAAAA:8 a=c9-ciuUNkuK7RFakVDoA:9
 a=QEXdDO2ut3YA:10 a=VzYV69SsQLkmnS9OQLw-:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: qRPoOh7zP30lRu1DmXoRrARyX7EnS3B0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01

Hi Alex,

On 23/04/2026 22:30, Alex Williamson wrote:
> 
> On Thu, 23 Apr 2026 11:25:07 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> Previously BAR resource requests and the corresponding pci_iomap()
>> were performed on-demand and without synchronisation, which was racy.
>> Rather than add synchronisation, it's simplest to address this by
>> doing both activities from vfio_pci_core_enable().
>>
>> The resource allocation and/or pci_iomap() can still fail; their
>> status is tracked and existing calls to vfio_pci_core_setup_barmap()
>> will fail in the same way as before.  This keeps the point of failure
>> as observed by userspace the same, i.e. failures to request/map unused
>> BARs are benign.
>>
>> Fixes: 7f5764e179c6 ("vfio: use vfio_pci_core_setup_barmap to map bar in mmap")
>> Fixes: 0d77ed3589ac0 ("vfio/pci: Pull BAR mapping setup from read-write path")
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c | 61 +++++++++++++++++++++++++++-----
>>   drivers/vfio/pci/vfio_pci_rdwr.c | 29 ++++++---------
>>   include/linux/vfio_pci_core.h    |  1 +
>>   3 files changed, 64 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 3f8d093aacf8..c59c61861d81 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -482,6 +482,55 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
>>   }
>>   #endif /* CONFIG_PM */
>>   
>> +static void __vfio_pci_core_unmap_bars(struct vfio_pci_core_device *vdev)
>> +{
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	int i;
>> +
>> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>> +		int bar = i + PCI_STD_RESOURCES;
>> +
>> +		if (vdev->barmap[bar])
>> +			pci_iounmap(pdev, vdev->barmap[bar]);
>> +		if (vdev->have_bar_resource[bar])
>> +			pci_release_selected_regions(pdev, 1 << bar);
>> +		vdev->barmap[bar] = NULL;
>> +		vdev->have_bar_resource[bar] = false;
>> +	}
>> +}
>> +
>> +static void __vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>> +{
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	int i;
>> +
>> +	/*
>> +	 * Eager-request BAR resources, and iomap; soft failures are
>> +	 * allowed, and consumers must check before use.
>> +	 */
> 
> I'd use this to describe that soft failures maintain compatible error
> signatures to previously used on-demand mapping.

Done.

>> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>> +		int ret;
>> +		int bar = i + PCI_STD_RESOURCES;
>> +		void __iomem *io;
> 
> Reverse Christmas tree ordering.

Done.

>> +
>> +		if (pci_resource_len(pdev, i) == 0)
>> +			continue;
>> +
>> +		ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
>> +		if (ret) {
>> +			pci_warn(vdev->pdev, "Failed to reserve region %d\n", bar);
>> +			continue;
>> +		}
>> +		vdev->have_bar_resource[bar] = true;
>> +
>> +		io = pci_iomap(pdev, bar, 0);
>> +		if (io)
>> +			vdev->barmap[bar] = io;
>> +		else
>> +			pci_warn(vdev->pdev, "Failed to iomap region %d\n", bar);
>> +	}
>> +}
> 
> I see you making the point in the cover letter about the resource
> request vs the iomap resource, but we currently handle these together.
> If either fails, setup barmap fails and the path returns error.  I
> don't see any justification for now allowing the request resource to
> succeed but the iomap fails.

The primary effect was to let consumers see -EBUSY for a resource 
reservation failure or -ENOMEM for an iomap failure (whether through 
this patch's vfio_pci_core_setup_barmap() or the next patch's helpers), 
and that keeps the error signatures identical.

A weak secondary effect was that a BAR that gets resource but fails for 
whatever reason to iomap it can still be used by most clients (assuming 
the general usage is to mmap).  The system's pretty sick if this is the 
case, so as I say it's weak.

OK, if you prefer the combined approach and don't feel the subsequent 
single-semantic check helpers (need mapping, need resource) are clearer 
to read then I'll recombine them, though:

  - If vfio_pci_core_map_bars() just sets barmap[n] iff both resource 
acquisition and iomap succeed, then a later check can only return one 
error from either cause.  I'll go with -ENOMEM unless you prefer -EBUSY. 
  Using something else can again make userspace see previously-unseen 
error values.

  - IMHO vfio_pci_core_setup_barmap() should still be renamed (in a 2nd 
patch) since it doesn't do any setting up anymore.  Cosmetic, but 
cleaner to parse when the callers use vfio_pci_core_check_barmap_valid() no?

> These functions also don't need the double-underscore prefix.

Done.

>> +
>>   /*
>>    * The pci-driver core runtime PM routines always save the device state
>>    * before going into suspended state. If the device is going into low power
>> @@ -568,6 +617,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>>   	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>>   		vdev->has_vga = true;
>>   
>> +	 __vfio_pci_core_map_bars(vdev);
>>   
>>   	return 0;
>>   
>> @@ -591,7 +641,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>>   	struct pci_dev *pdev = vdev->pdev;
>>   	struct vfio_pci_dummy_resource *dummy_res, *tmp;
>>   	struct vfio_pci_ioeventfd *ioeventfd, *ioeventfd_tmp;
>> -	int i, bar;
>> +	int i;
>>   
>>   	/* For needs_reset */
>>   	lockdep_assert_held(&vdev->vdev.dev_set->lock);
>> @@ -646,14 +696,7 @@ void vfio_pci_core_disable(struct vfio_pci_core_device *vdev)
>>   
>>   	vfio_config_free(vdev);
>>   
>> -	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>> -		bar = i + PCI_STD_RESOURCES;
>> -		if (!vdev->barmap[bar])
>> -			continue;
>> -		pci_iounmap(pdev, vdev->barmap[bar]);
>> -		pci_release_selected_regions(pdev, 1 << bar);
>> -		vdev->barmap[bar] = NULL;
>> -	}
>> +	__vfio_pci_core_unmap_bars(vdev);
> 
> I expect this doesn't need to change if we drop the separation between
> resources and iomap.

OK, restored.

>>   	list_for_each_entry_safe(dummy_res, tmp,
>>   				 &vdev->dummy_resources_list, res_next) {
>> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
>> index 4251ee03e146..bf7152316db4 100644
>> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
>> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
>> @@ -200,25 +200,18 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
>>   
>>   int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
>>   {
>> -	struct pci_dev *pdev = vdev->pdev;
>> -	int ret;
>> -	void __iomem *io;
>> -
>> -	if (vdev->barmap[bar])
>> -		return 0;
>> -
>> -	ret = pci_request_selected_regions(pdev, 1 << bar, "vfio");
>> -	if (ret)
>> -		return ret;
>> -
>> -	io = pci_iomap(pdev, bar, 0);
>> -	if (!io) {
>> -		pci_release_selected_regions(pdev, 1 << bar);
>> +	/*
>> +	 * The barmap is now always set up in vfio_pci_core_enable().
> 
> "now" is going to read strangely very quickly.

Hm, yeah, fixed.

>> +	 * Some legacy callers use this function to ensure the BAR
>> +	 * resources are requested, and others to ensure the
>> +	 * pci_iomap() was done, so check here:
>> +	 */
>> +	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
>> +		return -EINVAL;
>> +	if (vdev->barmap[bar] == 0)
>>   		return -ENOMEM;
>> -	}
>> -
>> -	vdev->barmap[bar] = io;
>> -
>> +	if (!vdev->bar_has_rsrc[bar])
> 
> Typo, this won't incrementally compile.  Thanks,

Fixed.

Alex, thanks for all your comments so far, I realise this is a pretty 
noddy fix but it's good to get it clean.


Matt

> 
> Alex
> 
>> +		return -EBUSY;
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
>> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
>> index 2ebba746c18f..1f508b067d82 100644
>> --- a/include/linux/vfio_pci_core.h
>> +++ b/include/linux/vfio_pci_core.h
>> @@ -101,6 +101,7 @@ struct vfio_pci_core_device {
>>   	const struct vfio_pci_device_ops *pci_ops;
>>   	void __iomem		*barmap[PCI_STD_NUM_BARS];
>>   	bool			bar_mmap_supported[PCI_STD_NUM_BARS];
>> +	bool			have_bar_resource[PCI_STD_NUM_BARS];
>>   	u8			*pci_config_map;
>>   	u8			*vconfig;
>>   	struct perm_bits	*msi_perm;
> 

