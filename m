Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141A83ACA6B
	for <virtualization@lists.linux.dev>; Tue,  5 May 2026 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999223; cv=none; b=YUo2DxkK15rT/gfQZN1ORPDA3cS2so8LJc+J+dnx1hXYUzcWZF2xFrwSpKiWbKiOkqaQF/N84zYl7TqaCMC/E+GJIwkiHnDPS8k0hCh5I6jalXduwMeT4kB4qZGTEwdrbb2ecTx3b3+P80Q8lc+h/C9X9jJV6c8huCZhvGgDYAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999223; c=relaxed/simple;
	bh=UDR1zOPIRSdW0W4yFUpqT4dJSQum3JAxuTAJBHmewzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZ1tSPMAvTcYml48fbfa4hqXrdZvLC0IUird3jWpnatRfsAMAVQ5eKdQC7ER3uMlHNtEsudFYhVEBUjqPwzd34Qf8Qfy+RsfCHmYngkbn7oFE6wwvK/gZolNHKPCL7E0OGGAUQ+MJCpJ2azRuY2Uax+C+CF1Kbl2hYvXLGoOPxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=HlRPtb9e; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HlRPtb9e"
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645EFaQX3822270
	for <virtualization@lists.linux.dev>; Tue, 5 May 2026 09:40:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=tYIUuM8zuFxT1UxHsWJkyelnLZZiUalOVyo2zlArhts=; b=HlRPtb9exjPN
	n2rKzsjZtjkSuDEb9KH2ORJNZaf9TUxWkpDI5uu5oI4/WU2mWpiUn3N0D08cZzb2
	k6X/E2D/BEgCmcZiz4rcm6w+ruhcOgsPXm1uOYVyFrqFGcvg8KVYdG7isct8AHR5
	ZmjwU+HnFkQVK7p+d815WNHitv65yXgXiYX45bloskp+mLwuHCAH2ydqCy0w/4r6
	nRm4ji76gbkH7Opp4NEZgm6HoALCX9r4EZKdRZH8ecflaZTOPfOlErweZFCUuj9Z
	vrkHbcgaZHeqFD0rSoAMX4LsSA5JjSUZLF/6Q8dtMR2tNXf1oRkjnWR+J2SpJY11
	mMW1c18Tyw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx315e66h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Tue, 05 May 2026 09:40:21 -0700 (PDT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-131371497a1so644085c88.0
        for <virtualization@lists.linux.dev>; Tue, 05 May 2026 09:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999221; x=1778604021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tYIUuM8zuFxT1UxHsWJkyelnLZZiUalOVyo2zlArhts=;
        b=s9EqPV8SKuyh+gYfLIkhL8/oZ1DiYILti08QlnlJaSwt6YvqMO6q3toVNdGZwBoaGL
         2aXz3tC705fdQR9o1TN7OFnC56Q5KU+iYzAiu3sS7RcKi/vfWR+0QkIrCWi+iWIf1XVu
         zUt2z/tdHtT4Ik1EqMY/dGgve/pGiGdJ9uR0UcFSb9NNBREKaeFwr7sd+zkKswwPt6Qy
         0JgaqRAeRuLWe7wDGEXZYyW9OQye8jR9Cq1/oUR2fKuqedq1M8n/tR1vooKbUqg28Cle
         qrjaRFs4A1fVaQNAH/3k2YH47Y3mbsARlBpxcw0Kpvb5i6ZzbKXWAiXNNvPpvo0+jarc
         iEqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ZrZyHSHueH414u9vI42TDHZqyh8JwtbMCzT7c0zf6X+UIQnfbKdWQtiiNG37w6ewruNny6Dcdvzsg7CwWXQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwktGKw5SCFdhTooWjIpCPMrLvkWGseZHjP61IKj5ByV0Tsj3pT
	kFr2kOqCMEe+EvssHXW2S3I59yEDt8bgPMPXtH4XWhDhHVhRJw5oNou/ksdZ/PEveoMSEW60NEE
	LiLtcmAhZ5JhM626FFAZI1QDLQ/7CkFclrLPJ0SbX1V8KuvPxhIAZJN0DC9gUCrRJZVM=
X-Gm-Gg: AeBDievFd4835JAgqorHH2QwnybtBM9WP+QYcVNZS29n0cZyqHjkzQ1ZUvta95h6C54
	yANbHBLS382kDQxrqF70BSt2Ucp4QX2Za5Rb3orzY6/twvnxHUpS/TwXQ94v7zR5f3r3D6gIFrg
	R4loBPEDQLbg4LxWknIR0ggkcBHA3SyuzcCT6NHnvlmFLZnUfzypt/Ik6HejWyN/J+DbHBdrLJp
	tV1s9EATHWqzR9LhmYPySz0SxblD+tCLBfUyQbpEOMzoHthgJtq6+ffCsMHqTPW72J5PRdXHY5d
	8Pk8bA12vRCytIcgOfcGaNh1PaQEdEzw4sQbEOoMUZB68Asdn9huTUb1e9NfwnO4kOvLZ8KSO9Y
	/nevm0mto0xi3DlBd615EGKslKPxU464ya7BTLnNn
X-Received: by 2002:a05:7022:61a:b0:128:d2b3:5df with SMTP id a92af1059eb24-12dfd81a65emr7341072c88.23.1777999220511;
        Tue, 05 May 2026 09:40:20 -0700 (PDT)
X-Received: by 2002:a05:7022:61a:b0:128:d2b3:5df with SMTP id a92af1059eb24-12dfd81a65emr7341042c88.23.1777999219794;
        Tue, 05 May 2026 09:40:19 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df82a141asm24127544c88.8.2026.05.05.09.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 09:40:19 -0700 (PDT)
Message-ID: <ab327008-2b5f-4fbb-8045-736ff90ea5ab@meta.com>
Date: Tue, 5 May 2026 17:40:14 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] vfio/pci: Set up bar resources and maps in
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
References: <20260430100340.2787446-1-mattev@meta.com>
 <20260430100340.2787446-2-mattev@meta.com>
 <20260430141341.163ed827@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260430141341.163ed827@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: T3vYISyeK3uwXDT6RYjragVgbzm1_ItG
X-Proofpoint-ORIG-GUID: T3vYISyeK3uwXDT6RYjragVgbzm1_ItG
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69fa1d75 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22 a=VabnemYjAAAA:8
 a=nkPybr1PKv9t0ePcFoAA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2MSBTYWx0ZWRfXwvDphFCCeCaD
 oWZKkeOkcz4RttSO3YBF38f5MdzGOpVwCr0SaUC6zLQia0YfqbxaYJd169xHvgeByyMDNj+oiAI
 +GMMXWFVHj5oLhgJ2ffWdzKEFI52CaG/FItYffYEztE5p3EyT7KoWguwvk4cCjXI9HQloUzJPY8
 fAc4YsHqBob3dAEZ82E5VXqY9nOjT5dukm/XlP835kylcyFXqaNFThMBc/CpjiqXwh3iqSR2nzu
 54uTwdFmkBcd0x1UDT6GtbUUnU7I2zd1HQkvDh7byNxL97SYMREjaG9uTOWJc1uDvGjn1hpGj/o
 a1h5zBSDnTZxwscbMR8r+iNYzuf3QcT41idBhgOYEDpmEsXMRcpbfErVr8MUZGcAcesEzVDSi5i
 u4xORjUH4AGaaGKnlFqHDrPEE8tgreZrT13FKQUW4VhdtlBJRB5NV6bsl3Si0BBFv51XeDZI8E5
 pNInakrGfbvnXIFdWwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01

Hi Alex,

On 30/04/2026 21:13, Alex Williamson wrote:
> 
> On Thu, 30 Apr 2026 03:03:20 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> Previously BAR resource requests and the corresponding pci_iomap()
>> were performed on-demand and without synchronisation, which was racy.
>> Rather than add synchronisation, it's simplest to address this by
>> doing both activities from vfio_pci_core_enable().
>>
>> The resource allocation and/or pci_iomap() can still fail; their
>> status is tracked and existing calls to vfio_pci_core_setup_barmap()
>> will fail in a similar way to before.  This keeps the point of failure
>> as observed by userspace the same, i.e. failures to request/map unused
>> BARs are benign.
>>
>> Fixes: 7f5764e179c6 ("vfio: use vfio_pci_core_setup_barmap to map bar in mmap")
>> Fixes: 0d77ed3589ac0 ("vfio/pci: Pull BAR mapping setup from read-write path")
> 
> Neither of these introduced races, they only moved what they were
> already doing into a function or made use of that shared function for
> what they were already doing.  I'm inclined to believe the raciness
> existed from the introduction, 89e1f7d4c66d.
> 
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_core.c | 33 ++++++++++++++++++++++++++++++++
>>   drivers/vfio/pci/vfio_pci_rdwr.c | 29 ++++++++++++----------------
>>   2 files changed, 45 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 3f8d093aacf8..eab4f2626b39 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -482,6 +482,38 @@ static int vfio_pci_core_runtime_resume(struct device *dev)
>>   }
>>   #endif /* CONFIG_PM */
>>   
>> +static void vfio_pci_core_map_bars(struct vfio_pci_core_device *vdev)
>> +{
>> +	struct pci_dev *pdev = vdev->pdev;
>> +	int i;
>> +
>> +	/*
>> +	 * Eager-request BAR resources, and iomap.  Soft failures are
>> +	 * allowed, and consumers must check the barmap before use in
>> +	 * order to give compatible user-visible behaviour with the
>> +	 * previous on-demand allocation method.
>> +	 */
>> +	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>> +		int bar = i + PCI_STD_RESOURCES;
>> +		void __iomem *io = ERR_PTR(-ENODEV);
> 
> It would collapse the nesting depth to just do:
> 
> 		vdev->barmap[bar] = ERR_PTR(-ENODEV);
> 
> 		if (!pci_resource_len(pdev, i))
> 			continue;
> 
> 		if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
> 			pci_dbg(vdev->pdev, "Failed to reserve region %d\n", bar);
> 			vdev->barmap[bar] = ERR_PTR(-EBUSY);
> 			continue;
> 		}
> 
> 		vdev->barmap[bar] = pci_iomap(pdev, bar, 0);
> 		if (!vdev->barmap[bar]) {
> 			pci_dbg(vdev->pdev, "Failed to iomap region %d\n", bar);
> 			vdev->barmap[bar] = ERR_PTR(-ENOMEM);
> 		}
> 
> It's debatable what level to use for the errors, but we were previously
> silent on this, so going all the way to pci_warn() seems unnecessary.

Hm, okay, returned it to a nesting-less format and replaced pci_warn()s 
with pci_dbg().

>> +
>> +		if (pci_resource_len(pdev, i) > 0) {
>> +			if (pci_request_selected_regions(pdev, 1 << bar, "vfio")) {
>> +				pci_warn(vdev->pdev, "Failed to reserve region %d\n", bar);
>> +				io = ERR_PTR(-EBUSY);
>> +			} else {
>> +				io = pci_iomap(pdev, bar, 0);
>> +				if (!io) {
>> +					pci_warn(vdev->pdev, "Failed to iomap region %d\n",
>> +						 bar);
>> +					io = ERR_PTR(-ENOMEM);
>> +				}
>> +			}
>> +		}
>> +		vdev->barmap[bar] = io;
>> +	}
>> +}
>> +
>>   /*
>>    * The pci-driver core runtime PM routines always save the device state
>>    * before going into suspended state. If the device is going into low power
>> @@ -568,6 +600,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device *vdev)
>>   	if (!vfio_vga_disabled() && vfio_pci_is_vga(pdev))
>>   		vdev->has_vga = true;
>>   
>> +	vfio_pci_core_map_bars(vdev);
>>   
>>   	return 0;
> 
> You're missing the barmap test in vfio_pci_core_disable() now, it's
> still testing for NULL, which is (almost?) never true.  It needs to
> convert to IS_ERR_OR_NULL().

Arrrrgh, yes it does, thank you.  (For the second time, the first being 
the !IS_ERR() typo you caught in patch #3 :(  Thanks there also; it 
slipped by my usual testing routine.)

>> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
>> index 4251ee03e146..f66ad3d96481 100644
>> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
>> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
>> @@ -200,25 +200,20 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
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
>> -		return -ENOMEM;
>> -	}
>> +	/*
>> +	 * The barmap is set up in vfio_pci_core_enable().  Callers
>> +	 * use this function to check that the BAR resources are
>> +	 * requested or that the pci_iomap() was done.
>> +	 */
> 
> Looks like a function level comment to be placed above the function
> definition.  TBH, the comment in the previous function could also be
> pulled up as a function level comment.
> 
>> +	if (bar < 0 || bar >= PCI_STD_NUM_BARS)
> 
> Maybe `if ((unsigned)bar >= PCI_STD_NUM_BARS)` but really author
> preference here.
> 
>> +		return -EINVAL;
>>   
>> -	vdev->barmap[bar] = io;
>> +	/* Did vfio_pci_core_map_bars() set it up yet? */
>> +	if (!vdev->barmap[bar])
>> +		return -ENODEV;
> 
> What hits this?  Should it be a WARN_ON_ONCE?  It would need to be a use
> case that accesses barmap outside of the window between enable and
> disable, where I think we're defining the contract that it's only valid
> between those events.  Both this and the range check could move to the
> iomap implemenation to keep the Fixes: patch reasonably small since
> afaik they're not triggered.  The BAR range test could be WARN_ON_ONCE
> as well, only driver bugs should hit it.  Thanks,

I've reduced the fix patch #1 to just an IS_ERR test (without the null 
or range checks as you suggest).  And indeed WARN_ON_ONCE() is a good 
idea as only tremendous mishaps would lead to these conditions 
triggering (worth testing though).

Also ack on your suggestion on patch #2 to make the call to 
nvgrace_gpu_wait_device_ready() more minimalist, and to order the 2x 
fixes up front.  Posting v4 shortly, cheers!


Thanks,


Matt

