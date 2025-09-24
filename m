Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A20E196C7C;
	Wed, 24 Sep 2025 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758740360; cv=none; b=O83l+Agh+wlvc5BLHlwsTzXach7WG03SpjOGSHi/+STnj709COgb2qGR4bK6kk68Heqs32znPK0MIRN13WiONRW3kbMQAoumyrDgCXVPCadfAOhvCdVTYRyPxNuDo3N3Jy4yuVTC9itJqW1lYjQN5VayJHkci1QLryffR5wGobs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758740360; c=relaxed/simple;
	bh=shOc0550izPFhLShgnA9fPj/F3zfGl/0YdmW06cMmi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rdMVAW90R3R/kBQAR34fw/4X6UcRBCF8zJtywGvcRfivRnQj0l+vYQr7bVV1FB0PjI3NhJkmyyzXwaG0OU7uqiYvWXPFsKns+Gy8k8GsGCyZSb162DPO7XyFdvGdek3FB44+MdKZYJENbN6J2j4fmYrbEEicCExYbSY7Ge49z7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B45E106F;
	Wed, 24 Sep 2025 11:59:09 -0700 (PDT)
Received: from [10.57.32.18] (unknown [10.57.32.18])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFE423F66E;
	Wed, 24 Sep 2025 11:59:09 -0700 (PDT)
Message-ID: <ab5b53dd-2d34-43bf-bd26-02bae3073794@arm.com>
Date: Wed, 24 Sep 2025 19:59:07 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] arm-smmu: select suitable MSI IOVA
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: Will Deacon <will@kernel.org>, thierry.reding@gmail.com, robh@kernel.org,
 joro@8bytes.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 virtualization@lists.linux.dev, jacob.pan@linux.microsoft.com,
 eric.auger@redhat.com, code@tyhicks.com, eahariha@linux.microsoft.com,
 vijayb@linux.microsoft.com, bboscaccy@linux.microsoft.com,
 saravanak@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
 lizhi.hou@amd.com, clement.leger@bootlin.com
References: <20250909154600.910110-1-shyamsaini@linux.microsoft.com>
 <20250909154600.910110-4-shyamsaini@linux.microsoft.com>
 <aMw4I0AjKNPY6SOw@willie-the-truck> <20250918224322.GR1326709@ziepe.ca>
 <aM0HQ51DelZW_Rt8@willie-the-truck> <20250919120839.GV1326709@ziepe.ca>
 <20250923155647.GA22010@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20250923161912.GB2547959@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250923161912.GB2547959@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-09-23 5:19 pm, Jason Gunthorpe wrote:
> On Tue, Sep 23, 2025 at 08:56:47AM -0700, Shyam Saini wrote:
>> Hi Jason, Will,
>>
>> On 19 Sep 2025 09:08, Jason Gunthorpe wrote:
>>> On Fri, Sep 19, 2025 at 08:33:23AM +0100, Will Deacon wrote:
>>>> pieces and will need to work on the userspace side. It's not like
>>>> MSI_IOVA2 is magically going to work (and I bet it won't be tested).
>>>
>>> It could, if someone checks the default memory map a second constant
>>> could be selected that works.
>>>
>>>>> Nicolin has some patches on the iommufd side to let userspace select
>>>>> the MSI address instead, but they are not done yet.
>>>>
>>>> Maybe we should just wait for that? Carrying a temporary hack with ABI
>>>> implications to support broken hardware isn't particularly compelling
>>>> to me.
>>>
>>> This patch would still be needed for kernel users.
>>>
>>> Arguably the kernel users should just be using the iova allocator from
>>> dma-iommu.c. This whole hard coded constant/sneaky uapi is just a hack
>>> to make vfio work..
>>>
>>> So maybe if the single constant doesn't work we could set some
>>> indication that the caller must allocate the MSI iova, the kernel can
>>> use the dma-iommu allocator and VFIO can just refuse to use the device
>>> for now.
>>
>> So, are we settling on having two predefined MSI IOVA base constants,
>> and if both of those conflict with reserved regions on a given platform,
>> falling back to dynamic allocation via the IOVA allocator? Just checking
>> if that's the consensus we're reaching.
> 
> I think Will is arguing against introducing a new constant..
> 
> Yesterday I was looking at the SW_MSI code again.. What specific
> problem is it you have?
> 
> It looks to me like dma-iommu.c is already allocating MSI addresses
> using its built in IOVA allocator. So if your DT is marking that space
> reserved then it should Just Work right now as dma-iommu.c already
> processes the reserved ranges and will allocate MSI addresses around
> them?
> 
> The base value of the SW_MSI is only used by VFIO - are you trying to
> use VFIO with this device, or have I misunderstood the dma-iommu.c
> logic?

Indeed the sole user of the entire 
IOMMU_RESV_SW_MSI/iommu_dma_get_msi_cookie() mechanism is that one place 
in vfio_iommu_type1. iommu-dma itself treats MSIs just like any other 
DMA mapping, so if address space limitations are not correctly described 
then any breakage will be to DMA in general.
> If it is only VFIO at issue then perhaps we should solve this by
> completing the work Nicolin started to allow VFIO userspace to specify
> the MSI Aperture?

+1 to that - the arbitrary fake MSI reserved region was only ever meant 
to be a first step to get existing VMMs working with bare minimal 
"squint and pretend it's like x86" changes; MSI_IOVA_BASE was literally 
just picked to fit the standard Qemu virt machine memory map nicely. It 
was always intended that we'd eventually have more 
Arm-system-architecture-aware VMMs that would understand it's just a 
notional hole that needs punching in VFIO address space _somewhere_, and 
we'd figure out some interface for negotiating it. There has also always 
been at least one platform where this MSI_IOVA_BASE knowingly could 
never work, but that one (Arm Juno) also has sufficient other 
impediments to realistic VFIO usage (I've had it working, but it's 
definitely no more than a novelty) that it was never going to justify 
any upstream investment itself.

If we do now have a "serious" VFIO-capable system where the basic bodge 
no longer suffices, that surely does justify it finally being time to do 
the right thing.

Thanks,
Robin.
