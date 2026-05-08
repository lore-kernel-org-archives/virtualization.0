Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3702DF6EA
	for <virtualization@lists.linux.dev>; Fri,  8 May 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254252; cv=none; b=fqKj/QLc1NT1/93yAqoHvtamcL0etj5xzYIj1t0Brfq8ilbNMckNKm1jJH+eBctPz+ZyfEb96mo5j4UtK4fulb983vpSlMtjQ101Du4vJXl7BjMpU3d6DUw7LqNsZhSW1ZOKHD1s52TLb2uhp2Cjt0OhgVIp3j3ooH977cZWzgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254252; c=relaxed/simple;
	bh=EtgD1VNRsK8d4lAzXro19T0Vx6V8jLE24r087m6Qgqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nXWmX8lKuqZsJGMQ+bQb3NOKZFrCBUTVFgELuuvfO/i6kHebIHM+ekKNVT1d4MCDq6Jd0qeISl/d8Ob/1wCOWwBDlp5he/F1s42scmOEDBMad5V/orv15rd+TGsXzyb9UVjpxbsVRSvqSCBElTiUl2/is/xjHYRevmbd7LoGqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=BQwi8Bh8; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="BQwi8Bh8"
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6486k7w8145610
	for <virtualization@lists.linux.dev>; Fri, 8 May 2026 08:30:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=vpkNWOxv2MKVZdyw2YC4ieRyxiQ+NH8A65VfzBl7rQU=; b=BQwi8Bh8NYox
	b7LJuIr3GvE6TtLB8vNaoKOlW8rcipR+gOoYdRAN1z32fYQhHOo5eO1HD/NEXF3S
	zxXqZ1n6O1zuSR25f/KVQ8Gx77g8GinFvbAGVh7X945EiNFmeNMtP8ifc567Fy4+
	Nm+PAjuvCiPE/zYOcAzWdJbpnqPzhDDCSp0dEsaDToXDXNDXgauWSQUDxTJlD6xx
	/BujEr0VQGxiG1IqiuYPMpQ1CIMH1rWkNco0hTvaONyRLBz9ShO6JLc7uyF3htOq
	FDzLTBOz7w/D4U/jIAE7xrGQnpM8lStBJQSPiT5VPCoDLX286+TC9pmjo2KKkmIa
	mRx292hXqg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by m0089730.ppops.net (PPS) with ESMTPS id 4e13ddsb9m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <virtualization@lists.linux.dev>; Fri, 08 May 2026 08:30:47 -0700 (PDT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f525565b33so2810954eec.0
        for <virtualization@lists.linux.dev>; Fri, 08 May 2026 08:30:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778254247; x=1778859047;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vpkNWOxv2MKVZdyw2YC4ieRyxiQ+NH8A65VfzBl7rQU=;
        b=ph/O6BH2iXKBzztOeeJyub/8+UZZGXEiXNRF0XGx02r0OiNElsV43ERkP8uFZlinLK
         6/+ZBeaJ+8P8s5KVPbu1Hgv+aOlH8J6bbQxja9t5cc8XRRZNKrUnzrnE/W2yZGxTvnGt
         oDHvmqGymXEbpkDbfBvVUEwcKg5Dcr/qoFiuHe6whqxADu4M974Q54qk4nYPRUDArjIU
         4Zftl+UOzW4SckI5gWP04WUCe90nk1meIs8IM2ysr5DDIE8K6xPXcsa8FLCkP2Hn0bXT
         s2qZHYMqMmu39+4xT3APcycYxCL6Axd9pdbOHv3Ql/D/GAeXGIlBaqVQhcyZKluuUXeu
         MDzw==
X-Forwarded-Encrypted: i=1; AFNElJ+vlXht1DbXTRRZ+8I65uRkfv2WRZ5hkg0seyPvpe3WdyTuGOLNGAAOTL5VBjhjRN0vQNmY/1mfVDht95LF4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxBlJeXOSeMQZuKTfX4MVJph+H3Gik/22WFZKMsL13gfTtMoujx
	yFD7BfGJKjKk8BWNRBHiGy1tzGKNPBZPKYTvBjoLDML9HRG/44kxO6Vm8KFN7yopdDgLNNk6+6w
	Wdk0h/Ul763Bfk3GhG7Ev0SGeXvl9EX9Dn89jrU//kFeFO3s8J2QDOg6QJ2IO2wZqOVo=
X-Gm-Gg: Acq92OG7qvJoram2aBlsPkGJCpgVSv/rZAaTWZhgy3jAW6TgfXEXFF/e94rZxuDNi4s
	cHFmrvBMPOhNuje82SJF7dTTMJ0OFBJhZvYAeDDtnxd5nAu/aC0NNUjX7knla1Km79WY0mso+SP
	p9TvtNGKT3eeyetNAK629DW1TaFUjG4eQuiKib3PeL4yjoZe5H7TXu5ZBh0xhHDmGfBfwP1kmDM
	LfMkJS2Is+EdHGTBPLVVSx0Nb0PuULhb2TlQDSvixT+a/kWzexIJTHO/eTdrZgrnJvBQEe8RcsE
	K/YcRtitk21K0bokRAxtXsaCkfKUEX9iM+k7fLcq0mIbsOqbbCVu3gS44ZA1aV8wGnnK4Toh2Sm
	s4PzB7dUtIJKUFj+x+djGWKLR
X-Received: by 2002:a05:7300:cc0e:b0:2f5:285c:4374 with SMTP id 5a478bee46e88-2f55114357bmr6248687eec.35.1778254246575;
        Fri, 08 May 2026 08:30:46 -0700 (PDT)
X-Received: by 2002:a05:7300:cc0e:b0:2f5:285c:4374 with SMTP id 5a478bee46e88-2f55114357bmr6248656eec.35.1778254245892;
        Fri, 08 May 2026 08:30:45 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f91004b6a2sm1188733eec.0.2026.05.08.08.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 08:30:45 -0700 (PDT)
Message-ID: <015b1e9c-0a2d-472a-b750-9154800832ee@meta.com>
Date: Fri, 8 May 2026 16:30:40 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] vfio/pci: Replace vfio_pci_core_setup_barmap()
 with vfio_pci_core_get_iomap()
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
References: <20260505173835.2324179-1-mattev@meta.com>
 <20260505173835.2324179-4-mattev@meta.com>
 <20260507162141.072483ce@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260507162141.072483ce@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1NSBTYWx0ZWRfX6d+zk2KMISQ0
 cxD9BwFGgrEjvUve+2lgOURcGC+Fcfrn9z67RthE0RWJfZERsNz62gSIk0c4voVccJBnl6lKv10
 pyhD+wNYVY0B7spnzY6bU7Sa615aUz4a3BHCLzBo70GQwuHLXs4dKC7P4CDOxaeLNR+bq1uDgma
 hM7ZvZrPwEHZIFsfQCpMFzwF8Wp1qSOO8M8oXUwLv4wnn8spvumxQM1//NMERHKfKwo2i7tE0Gv
 9RzpVZDJGSdf7pb0P7p7bjoW/v7FO9wuES3TqZ4iSe87rDtC4Vey/CAf/NvDz6EDwghr5fRGFFC
 /4HGxYmWbnEknSqiXiuueV3o9A9niD94kNd9tvL0Xr5v432ay0DV8VECqhQ2NSTmdwE1Ybb1fY9
 xWj3DVmope1D1045W6LBf4Q7eTjgb9w1wYB3AtJOPA4yL1q7Pazr8yS4TXjLkvmarhdgJ2geD6N
 yKklvLfe0k9FIJ/SYJw==
X-Proofpoint-GUID: CBb-6_flAvNJtS5TpHhdCBimhIiS43SV
X-Authority-Analysis: v=2.4 cv=KJhqylFo c=1 sm=1 tr=0 ts=69fe01a7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=855S8uPTkML1Oy45N9_h:22 a=VabnemYjAAAA:8
 a=CeaZP3YjJKAO-qlWyq0A:9 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: CBb-6_flAvNJtS5TpHhdCBimhIiS43SV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01

Hi Alex,

On 07/05/2026 23:21, Alex Williamson wrote:
> 
> On Tue, 5 May 2026 10:38:31 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> Since "vfio/pci: Set up barmap in vfio_pci_core_enable()", the
>> resource request and iomap for the BARs was performed early, and
>> vfio_pci_core_setup_barmap() just checks those actions succeeded.
>>
>> Move this logic to a new helper that checks success and returns the
>> iomap address, replacing the various bare vdev->barmap[] lookups.
>> This maintains the error behaviour of the previous on-demand
>> vfio_pci_core_setup_barmap() scheme.
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/nvgrace-gpu/main.c | 11 ++++-------
>>   drivers/vfio/pci/vfio_pci_core.c    | 11 +++++------
>>   drivers/vfio/pci/vfio_pci_dmabuf.c  |  2 +-
>>   drivers/vfio/pci/vfio_pci_rdwr.c    | 30 ++++++++---------------------
>>   drivers/vfio/pci/virtio/legacy_io.c | 13 ++++++-------
>>   include/linux/vfio_pci_core.h       | 20 ++++++++++++++++++-
>>   6 files changed, 43 insertions(+), 44 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
>> index fa056b69f899..e153002258ce 100644
>> --- a/drivers/vfio/pci/nvgrace-gpu/main.c
>> +++ b/drivers/vfio/pci/nvgrace-gpu/main.c
>> @@ -184,13 +184,10 @@ static int nvgrace_gpu_open_device(struct vfio_device *core_vdev)
>>   
>>   	/*
>>   	 * GPU readiness is checked by reading the BAR0 registers.
>> -	 *
>> -	 * ioremap BAR0 to ensure that the BAR0 mapping is present before
>> -	 * register reads on first fault before establishing any GPU
>> -	 * memory mapping.
>> +	 * The BAR map was just set up by vfio_pci_core_enable(), so
>> +	 * check that was successful and bail early if not:
>>   	 */
>> -	ret = vfio_pci_core_setup_barmap(vdev, 0);
>> -	if (ret)
>> +	if (IS_ERR(vfio_pci_core_get_iomap(vdev, 0)))
>>   		goto error_exit;
> 
> Sashiko notes we're not setting ret here.  The bots are also paranoid
> about the unreachable condition that the get_iomap below could return an
> ERR_PTR.  Maybe head off both by adding an __iomem pointer to the
> nvgrace_gpu_pci_core_device struct and a temporary one here.  Store the
> iomap in the temporary variable, use it to test for IS_ERR() and
> PTR_ERR(), then set the pointer in the structure after the last error
> condition here.  Add one line in the close_device to set it NULL.  Then
> just use nvdev->bar0_io below.

Right about ret.  On the 2nd, the bots could benefit from a comment on
the ...get_iomap() below saying that it "cannot fail" if this one
passes, but hey.  I can add a struct member to track it (bots can then
worry that it might be NULL, if they don't notice that
nvgrace_gpu_check_device_ready() can't happen if
nvgrace_gpu_open_device() didn't succeed, etc. etc.).

>>   
>>   	if (nvdev->resmem.memlength) {
>> @@ -275,7 +272,7 @@ nvgrace_gpu_check_device_ready(struct nvgrace_gpu_pci_core_device *nvdev)
>>   	if (!__vfio_pci_memory_enabled(vdev))
>>   		return -EIO;
>>   
>> -	ret = nvgrace_gpu_wait_device_ready(vdev->barmap[0]);
>> +	ret = nvgrace_gpu_wait_device_ready(vfio_pci_core_get_iomap(vdev, 0));
>>   	if (ret)
>>   		return ret;
>>   
>> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
>> index 62931dc381d8..5c8bd13f10d0 100644
>> --- a/drivers/vfio/pci/vfio_pci_core.c
>> +++ b/drivers/vfio/pci/vfio_pci_core.c
>> @@ -1761,7 +1761,7 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>>   	struct pci_dev *pdev = vdev->pdev;
>>   	unsigned int index;
>>   	u64 phys_len, req_len, pgoff, req_start;
>> -	int ret;
>> +	void __iomem *bar_io;
>>   
>>   	index = vma->vm_pgoff >> (VFIO_PCI_OFFSET_SHIFT - PAGE_SHIFT);
>>   
>> @@ -1795,12 +1795,11 @@ int vfio_pci_core_mmap(struct vfio_device *core_vdev, struct vm_area_struct *vma
>>   		return -EINVAL;
>>   
>>   	/*
>> -	 * Even though we don't make use of the barmap for the mmap,
>> -	 * we need to request the region and the barmap tracks that.
>> +	 * Ensure the BAR resource region is reserved for use.
>>   	 */
>> -	ret = vfio_pci_core_setup_barmap(vdev, index);
>> -	if (ret)
>> -		return ret;
>> +	bar_io = vfio_pci_core_get_iomap(vdev, index);
>> +	if (IS_ERR(bar_io))
>> +		return PTR_ERR(bar_io);
>>   
>>   	vma->vm_private_data = vdev;
>>   	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 69a5c2d511e6..46cd44b22c9c 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -248,7 +248,7 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_core_device *vdev, u32 flags,
>>   	 * else.  Check that PCI resources have been claimed for it.
>>   	 */
>>   	if (get_dma_buf.region_index >= VFIO_PCI_ROM_REGION_INDEX ||
>> -	    vfio_pci_core_setup_barmap(vdev, get_dma_buf.region_index))
>> +	    IS_ERR(vfio_pci_core_get_iomap(vdev, get_dma_buf.region_index)))
>>   		return -ENODEV;
>>   
>>   	dma_ranges = memdup_array_user(&arg->dma_ranges, get_dma_buf.nr_ranges,
>> diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
>> index 3bfbb879a005..7f14dd46de17 100644
>> --- a/drivers/vfio/pci/vfio_pci_rdwr.c
>> +++ b/drivers/vfio/pci/vfio_pci_rdwr.c
>> @@ -198,19 +198,6 @@ ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
>>   }
>>   EXPORT_SYMBOL_GPL(vfio_pci_core_do_io_rw);
>>   
>> -/*
>> - * The barmap is set up in vfio_pci_core_enable().  Callers use this
>> - * function to check that the BAR resources are requested or that the
>> - * pci_iomap() was done.
>> - */
>> -int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar)
>> -{
>> -	if (IS_ERR(vdev->barmap[bar]))
>> -		return PTR_ERR(vdev->barmap[bar]);
>> -	return 0;
>> -}
>> -EXPORT_SYMBOL_GPL(vfio_pci_core_setup_barmap);
>> -
>>   ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>>   			size_t count, loff_t *ppos, bool iswrite)
>>   {
>> @@ -262,13 +249,11 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_core_device *vdev, char __user *buf,
>>   		 */
>>   		max_width = VFIO_PCI_IO_WIDTH_4;
>>   	} else {
>> -		int ret = vfio_pci_core_setup_barmap(vdev, bar);
>> -		if (ret) {
>> -			done = ret;
>> +		io = vfio_pci_core_get_iomap(vdev, bar);
>> +		if (IS_ERR(io)) {
>> +			done = PTR_ERR(io);
>>   			goto out;
>>   		}
>> -
>> -		io = vdev->barmap[bar];
>>   	}
>>   
>>   	if (bar == vdev->msix_bar) {
>> @@ -423,6 +408,7 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
>>   	loff_t pos = offset & VFIO_PCI_OFFSET_MASK;
>>   	int ret, bar = VFIO_PCI_OFFSET_TO_INDEX(offset);
>>   	struct vfio_pci_ioeventfd *ioeventfd;
>> +	void __iomem *io;
>>   
>>   	/* Only support ioeventfds into BARs */
>>   	if (bar > VFIO_PCI_BAR5_REGION_INDEX)
>> @@ -440,9 +426,9 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
>>   	if (count == 8)
>>   		return -EINVAL;
>>   
>> -	ret = vfio_pci_core_setup_barmap(vdev, bar);
>> -	if (ret)
>> -		return ret;
>> +	io = vfio_pci_core_get_iomap(vdev, bar);
>> +	if (IS_ERR(io))
>> +		return PTR_ERR(io);
> 
> Sashiko seems to note a real existing error here that should also be
> pulled out to a separate fix.  Given the right offset, this could
> generate a negative BAR value.

Yuck, loff_t signed, yep.  Isn't the real root of this that it
never makes sense for VFIO_PCI_OFFSET_TO_INDEX() to return a negative
index here or anywhere else?

I suggest instead, to also avoid this elsewhere in future, something
like:

  #define VFIO_PCI_OFFSET_TO_INDEX(off)	((u64)(off) >> VFIO_PCI_OFFSET_SHIFT)

> The test at the end of the previous
> chunk should should be expanded to `if (bar < 0 || bar > ...BAR5...)`.

Not necessary if VFIO_PCI_OFFSET_TO_INDEX() can't return < 0 (the
magnitude would be 24b so can't overflow the `int bar` it's assigned
into).

> Do you want to pick that up in this series?  I think it's the only case
> that lets that slip through.  Thanks,

Sure, I'll post a fix.  I don't think it needs to be part of this series
though if it's just the macro, do you agree?

Do you know why drivers/gpu/drm/i915/gvt/kvmgt.c has copied
VFIO_PCI_OFFSET_TO_INDEX() and friends?  Perhaps the shift was different
(the reason drivers/vfio/pci/ism/main.c has its own versions).  The same
loff_t issue seems to exist in both of those places, unfortunately.


Matt

PS: with minor question:
Relatedly, I'd made `bar` an int following existing convention in

  vfio_pci_core_get_iomap(struct vfio_pci_core_device *vdev, int bar)

But I'll make this `unsigned int`, please flag if this violates taste
and decency.  IMO any BAR/index parameter should be unsigned; most are,
some signed remain.

