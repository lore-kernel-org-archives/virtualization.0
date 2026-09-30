Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A473AE1A0
	for <virtualization@lists.linux.dev>; Wed, 30 Sep 2026 04:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744224; cv=none; b=Ja5IBUGwxuG5ehMErAiHYwi5dPU0GOlqu/4mp3l0Ksbn6sedYPG04B4mnchpRGqscKTxHJxdimHQLo9Hqft0FZ7TT2RrZuSJUszXCKDajtXIxLLZUzG6TPPfw+lwjCBqVgP4dkZB5N9/dESMx4lAA2T1GPjRcfZWKZ3OZuyDeaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744224; c=relaxed/simple;
	bh=1LzUJWyVpEJ6t0FLAllTJUVlsjTLhKqKyXpXO76wJIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ByO2nTXq0rdH1Zor2wLoECLTt9doVOFhM9WzdynSzJV/RghR7AZ5zrEyewXf713r/EMWkhcncoVyDcn1zi3JngFz3c+PczpC79nuMxx7c5G5XNbhM986vwhF+8G92ASc+SUxBasTKzR+FvDxP9QyF5yb0hyuRMIqJ0y0946XmDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=ZJMvIwby; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="ZJMvIwby"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68U4uQrb098371
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 30 Sep 2026 13:56:26 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=Il6Pn8W1NJX9qhwbRcpycT2Saqf/wh2/BgvOLGH6lG4=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1790744186; v=1;
        b=ZJMvIwbyT8HsLngGKDH8Dxl0o6DaQol1ktghTGr8gxAPjovpuDN1bQfkJcXPUJfp
         VTTNJ22GMW1PslrLxc5OsAR0JsKbo2suAjU0opJkeP9Ive4PqU3sq7Bczbw6wEPl
         5590um/csXpYGEFb+W0ZkIUy6U6k80/YZgshn2v4rZShf7OJjcaUvRxJZErJFiSB
         3qA3GqNktTXgv4ChUSK54faOGV209MrbZ/nt+r3vLIocCzAwhMrXedGZtohA/3jC
         BQDp7FbMNoHyyD6tiMRLLqnALtGhGXfxQTJ2wG6ODOp5pAzsGkthx/tOjcUs9X5T
         ReqciSAod4gJPVdAE60hcw==
Message-ID: <dce3d9ed-87a7-43fe-b7d8-c7281514f7d1@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 30 Sep 2026 13:56:26 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v9 3/4] drm/virtio: implement userptr resource support
To: "Huang, Honglei" <honghuan@amd.com>, dmitry.osipenko@collabora.com,
        airlied@redhat.com, kraxel@redhat.com
Cc: gurchetansingh@chromium.org, olvaffe@gmail.com, Ray.Huang@amd.com,
        dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
        linux-kernel@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        amd-gfx@lists.freedesktop.org
References: <20260924095556.1326164-1-honghuan@amd.com>
 <20260924095556.1326164-4-honghuan@amd.com>
 <fd17a38e-a827-41a5-a46e-db2135bb9257@rsg.ci.i.u-tokyo.ac.jp>
 <37c0ef9c-7249-4785-a3fd-646d816e2d4c@amd.com>
 <47d7114c-f035-4628-a911-c7ab30d55a75@rsg.ci.i.u-tokyo.ac.jp>
 <ae305517-e678-4ac3-93d3-f250bd37b2be@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ae305517-e678-4ac3-93d3-f250bd37b2be@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/09/29 11:22, Huang, Honglei wrote:
> 
> 
> On 9/29/2026 1:25 AM, Akihiko Odaki wrote:
>> On 2026/09/29 1:22, Huang, Honglei wrote:
>>>
>>>
>>> On 9/26/2026 7:33 PM, Akihiko Odaki wrote:
>>>> On 2026/09/24 18:55, Honglei Huang wrote:
>>>>> Add userptr blob objects so the guest kernel can pin an existing
>>>>> userspace mapping and advertise it as CREATE_BLOB backing entries.
>>>>>
>>>>> - New virtio_gpu_object_userptr type for userptr resources
>>>>> - Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
>>>>> - Omit FOLL_WRITE when VIRTGPU_BLOB_FLAG_USE_READONLY is set
>>>>> - Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
>>>>> - DMA-map the scatterlist only when virtio_gpu_use_dma_api() is
>>>>>    required; use DMA_TO_DEVICE for USE_READONLY blobs
>>>>> - Mark writable pages dirty when unpinning
>>>>> - Keep pages pinned until RESOURCE_UNREF is queued; drop them from
>>>>>    cleanup_object() on the unref response or on create failure
>>>>> - Clear userptr->pages on pin failure to avoid double-free on cleanup
>>>>> - Reject unaligned or overflowing userptr ranges at create time
>>>>> - Disallow PRIME export of userptr objects
>>>>> - Save CREATE_BLOB params and restore userptr resources after
>>>>>    hibernation without using the shmem restore path
>>>>>
>>>>> The hibernation restore path maps with the same attrs and direction
>>>>> used at create time, as documented next to the call. Like shmem
>>>>> blobs, the DMA API can still bounce through a buffer there. This
>>>>> design only avoids a second guest side shmem allocation and memcpy,
>>>>> nothing more.
>>>>
>>>> I don't see the restore path is documented though this says 
>>>> "documented next to the call".
>>>
>>> Will fix in next version
>>>
>>>>
>>>>>
>>> ...
>>>>> +        goto err_cleanup;
>>>>> +    }
>>>>> +
>>>>> +    userptr->sgt = sgt;
>>>>> +
>>>>> +    if (virtio_gpu_use_dma_api(vgdev->vdev)) {
>>>>> +        enum dma_data_direction dir =
>>>>> +            (userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY) ?
>>>>> +            DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
>>>>> +
>>>>> +        ret = dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
>>>>> +                      dir, 0);
>>>>
>>>> I checked the ROCm code and documentation, and I do not see how this 
>>>> mapping satisfies the HIP coherence contract when bounce buffers or 
>>>> explicit DMA cache maintenance are required.
>>>>
>>>> HIP distinguishes two coherence models:
>>>>
>>>>  > Coarse-grained coherence: The memory is considered up-to-date only
>>>>  > after synchronization performed using hipDeviceSynchronize(),
>>>>  > hipStreamSynchronize(), or any blocking operation that acts on the
>>>>  > null stream such as hipMemcpy(). To avoid the cache from being
>>>>  > accessed by a part of the system while simultaneously being 
>>>> written by
>>>>  > another, the memory is made visible only after the caches have been
>>>>  > flushed.
>>>>  >
>>>>  > Fine-grained coherence: The memory is coherent even while being
>>>>  > modified by a part of the system. Fine-grained coherence ensures 
>>>> that
>>>>  > up-to-date data is visible to others regardless of kernel 
>>>> boundaries.
>>>>  > This can be useful if both host and device operate on the same data.
>>>>
>>>> https://rocm.docs.amd.com/projects/HIP/en/docs-10.0.0/how-to/ 
>>>> hip_runtime_api/memory_management/coherence_control.html
>>>>
>>>> Fine-grained access requires coherence throughout execution; copying
>>>> between the original pages and a bounce buffer only at kernel 
>>>> boundaries
>>>> would not suffice. Coarse-grained access could support such copies, but
>>>> they must occur at the required synchronization points. I found no code
>>>> that synchronizes this DMA mapping at those points.
>>>>
>>>
>>> Whether dma_map_sgtable() bounces is decided by the platform's IOMMU/ 
>>> SWIOTLB behind the device, not by we request. attrs=0 here just 
>>> matches the existing shmem blob path, and is exactly what native 
>>> (non- virtualized) ROCm's own userptr support does too:
>>>
>>> // drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c, 
>>> kfd_mem_dmamap_userptr()
>>> ret = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
>>>
>>> And HIP's coarse-grained/fine-grained coherence isn't a DMA layer 
>>> property, it is a GPU VM/cache thing. In upstream KFD it's 
>>> implemented as GPU MMU page table attributes (MTYPE_CC/MTYPE_RW, the 
>>> SNOOPED bit), set by whichever driver programs the real GPU's page 
>>> tables for this memory:
>>>
>>> // drivers/gpu/drm/amd/amdkfd/kfd_svm.c, svm_range_get_pte_flags()
>>> mapping_flags |= coherent ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
>>> pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
>>>
>>> I really want to disable the bounce buffers in DMA, but it is a 
>>> platform behaviour, can not disable it in this layer. And in XEN, the 
>>> dmapping for it is another form of iovector/simple sgtable. And if 
>>> use the virtio-iommu or somthing else, the efficiency and the 
>>> complexity of driver integration are both lower than using iovector/ 
>>> sgtable directly.
>>> And for how to handle the DMA thing for userptr, since we have so 
>>> many concern about it, maybe we can drop this part in next version. 
>>> But we may have the AI review warn/error.
>>
>> Documentation/core-api/dma-attributes.rst says:
>>
>>  > DMA_ATTR_REQUIRE_COHERENT
>>  > -------------------------
>>  >
>>  > DMA mapping requests with the DMA_ATTR_REQUIRE_COHERENT fail on any
>>  > system where SWIOTLB or cache management is required. This should only
>>  > be used to support uAPI designs that require continuous HW DMA
>>  > coherence with userspace processes, for example RDMA and DRM. At a
>>  > minimum the memory being mapped must be userspace memory from
>>  > pin_user_pages() or similar.
>>  >
>>  > Drivers should consider using dma_mmap_pages() instead of this
>>  > interface when building their uAPIs, when possible.
>>  >
>>  > It must never be used in an in-kernel driver that only works with
>>  > kernel memory.
>>
>> This is exactly our use case. Although the platform decides whether a
>> mapping requires bouncing or cache maintenance, 
>> DMA_ATTR_REQUIRE_COHERENT lets the driver reject mappings that cannot 
>> meet this requirement.
>>
>> The shmem path serves a different use case, but amdkfd is a relevant 
>> comparison. HIP's coherence guarantees depend on both the GPU VM/cache 
>> configuration and the DMA mapping established by the kernel driver. 
>> GPU page table attributes alone cannot make a bounce buffer coherent 
>> with the original userspace pages.
>>
>> The amdkfd mapping you cited therefore warrants discussion with its
>> developers as well. I have CCed the maintainer.
> 
> 
> Will add DMA_ATTR_REQUIRE_COHERENT in virtio GPU userptr in next version.
> And are there some places else need to be modified?

I don't have anything else to add right now. As a QEMU developer, I've 
only reviewed the more obvious aspects of this patch, so others may have 
deeper kernel-specific feedback.

At this stage, my main priority is seeing how the current feedback is 
resolved. Before we dig deeper into the low-level details, I’d also like 
to review the virtio specification changes alongside the 
QEMU/virglrenderer implementation so I can better evaluate the overall 
design.

Regards,
Akihiko Odaki
