Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C293D413F
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 17:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616379; cv=none; b=ALM7bJjv/O8MAbBL8i8CbxQbO1gqOrTv6KTPhlwUXA/WO02Ywn/nqqcmJ57nBrkHawIem+c16vexzf9hqYGl1JgyM+XYQI3JYocq0RyQOh4BKs1fC5bpYjd94NPGxkwQpZEUfGbIh7F2NRNgJWo60kRGBfniG3uvJ2XG7pXJ138=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616379; c=relaxed/simple;
	bh=lcz5eZaLRXdjIolMdPv5SqbjrCe9pdfrzt/bvztK6vE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ExtbW0FwiqCemDkRZ3Sz+XrNRT4RiKJ4Kc7+l9CCpwMRxf/8gALFaRu/JC/B1/ahZogEZTb+W5w+tmdp5OeCk5NL5hsxCbISgebk1inXZftiMVgHyXzZXxE3iCn6k2d/BfOUIwvSesbNOwds7amkkNyPE1obBN8ZTQVqUt43W24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=vksL4Kmk; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="vksL4Kmk"
Received: from [192.168.10.153] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 68SHPi5M004380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 29 Sep 2026 02:25:44 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=rvIrxGw3Y3qe2djohG1u2oQ0KR6/RuYYbn73hE+XyXI=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1790616344; v=1;
        b=vksL4Kmk3TJCH7made6gj3jSvb3jdJENbOR5pWR+szdAzcEDQaLPXHjNm6rJaA0K
         HtfOEQYrCXaAPV2TdcOHQooJxvX8xUV0MKAS/Rz+KZ+Yel/5oV9QwUcRZRzPMsHx
         cpuVJLKYh89tOUAE6SFHEFqFS72TQY5RNaX/elb5rsWMKYrZBfJmJtBwMUgTmWkq
         Hj2dEBHD08Ar5Md0q++qsPOyfYRJzQBCSG0AMmGhFBpc14VnRKsVZbCbiAc30y0p
         NhD+64BLr1gStTdBXBVAKu8/GdKtK8RrMMy/uxwbXZKrn6dk0wKTOdzzJVPsWYTb
         KYrEuqkrhchwURlMmW0mow==
Message-ID: <47d7114c-f035-4628-a911-c7ab30d55a75@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 29 Sep 2026 02:25:43 +0900
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
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <37c0ef9c-7249-4785-a3fd-646d816e2d4c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/09/29 1:22, Huang, Honglei wrote:
> 
> 
> On 9/26/2026 7:33 PM, Akihiko Odaki wrote:
>> On 2026/09/24 18:55, Honglei Huang wrote:
>>> Add userptr blob objects so the guest kernel can pin an existing
>>> userspace mapping and advertise it as CREATE_BLOB backing entries.
>>>
>>> - New virtio_gpu_object_userptr type for userptr resources
>>> - Pin pages with pin_user_pages_fast() and FOLL_LONGTERM
>>> - Omit FOLL_WRITE when VIRTGPU_BLOB_FLAG_USE_READONLY is set
>>> - Charge FOLL_LONGTERM pins against RLIMIT_MEMLOCK
>>> - DMA-map the scatterlist only when virtio_gpu_use_dma_api() is
>>>    required; use DMA_TO_DEVICE for USE_READONLY blobs
>>> - Mark writable pages dirty when unpinning
>>> - Keep pages pinned until RESOURCE_UNREF is queued; drop them from
>>>    cleanup_object() on the unref response or on create failure
>>> - Clear userptr->pages on pin failure to avoid double-free on cleanup
>>> - Reject unaligned or overflowing userptr ranges at create time
>>> - Disallow PRIME export of userptr objects
>>> - Save CREATE_BLOB params and restore userptr resources after
>>>    hibernation without using the shmem restore path
>>>
>>> The hibernation restore path maps with the same attrs and direction
>>> used at create time, as documented next to the call. Like shmem
>>> blobs, the DMA API can still bounce through a buffer there. This
>>> design only avoids a second guest side shmem allocation and memcpy,
>>> nothing more.
>>
>> I don't see the restore path is documented though this says 
>> "documented next to the call".
> 
> Will fix in next version
> 
>>
>>>
> ...
>>> +        goto err_cleanup;
>>> +    }
>>> +
>>> +    userptr->sgt = sgt;
>>> +
>>> +    if (virtio_gpu_use_dma_api(vgdev->vdev)) {
>>> +        enum dma_data_direction dir =
>>> +            (userptr->flags & VIRTGPU_BLOB_FLAG_USE_READONLY) ?
>>> +            DMA_TO_DEVICE : DMA_BIDIRECTIONAL;
>>> +
>>> +        ret = dma_map_sgtable(drm_dev_dma_dev(vgdev->ddev), sgt,
>>> +                      dir, 0);
>>
>> I checked the ROCm code and documentation, and I do not see how this 
>> mapping satisfies the HIP coherence contract when bounce buffers or 
>> explicit DMA cache maintenance are required.
>>
>> HIP distinguishes two coherence models:
>>
>>  > Coarse-grained coherence: The memory is considered up-to-date only
>>  > after synchronization performed using hipDeviceSynchronize(),
>>  > hipStreamSynchronize(), or any blocking operation that acts on the
>>  > null stream such as hipMemcpy(). To avoid the cache from being
>>  > accessed by a part of the system while simultaneously being written by
>>  > another, the memory is made visible only after the caches have been
>>  > flushed.
>>  >
>>  > Fine-grained coherence: The memory is coherent even while being
>>  > modified by a part of the system. Fine-grained coherence ensures that
>>  > up-to-date data is visible to others regardless of kernel boundaries.
>>  > This can be useful if both host and device operate on the same data.
>>
>> https://rocm.docs.amd.com/projects/HIP/en/docs-10.0.0/how-to/ 
>> hip_runtime_api/memory_management/coherence_control.html
>>
>> Fine-grained access requires coherence throughout execution; copying
>> between the original pages and a bounce buffer only at kernel boundaries
>> would not suffice. Coarse-grained access could support such copies, but
>> they must occur at the required synchronization points. I found no code
>> that synchronizes this DMA mapping at those points.
>>
> 
> Whether dma_map_sgtable() bounces is decided by the platform's IOMMU/ 
> SWIOTLB behind the device, not by we request. attrs=0 here just matches 
> the existing shmem blob path, and is exactly what native (non- 
> virtualized) ROCm's own userptr support does too:
> 
> // drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c, 
> kfd_mem_dmamap_userptr()
> ret = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
> 
> And HIP's coarse-grained/fine-grained coherence isn't a DMA layer 
> property, it is a GPU VM/cache thing. In upstream KFD it's implemented 
> as GPU MMU page table attributes (MTYPE_CC/MTYPE_RW, the SNOOPED bit), 
> set by whichever driver programs the real GPU's page tables for this 
> memory:
> 
> // drivers/gpu/drm/amd/amdkfd/kfd_svm.c, svm_range_get_pte_flags()
> mapping_flags |= coherent ? AMDGPU_VM_MTYPE_CC : AMDGPU_VM_MTYPE_RW;
> pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
> 
> I really want to disable the bounce buffers in DMA, but it is a platform 
> behaviour, can not disable it in this layer. And in XEN, the dmapping 
> for it is another form of iovector/simple sgtable. And if use the 
> virtio-iommu or somthing else, the efficiency and the complexity of 
> driver integration are both lower than using iovector/sgtable directly.
> And for how to handle the DMA thing for userptr, since we have so many 
> concern about it, maybe we can drop this part in next version. But we 
> may have the AI review warn/error.

Documentation/core-api/dma-attributes.rst says:

 > DMA_ATTR_REQUIRE_COHERENT
 > -------------------------
 >
 > DMA mapping requests with the DMA_ATTR_REQUIRE_COHERENT fail on any
 > system where SWIOTLB or cache management is required. This should only
 > be used to support uAPI designs that require continuous HW DMA
 > coherence with userspace processes, for example RDMA and DRM. At a
 > minimum the memory being mapped must be userspace memory from
 > pin_user_pages() or similar.
 >
 > Drivers should consider using dma_mmap_pages() instead of this
 > interface when building their uAPIs, when possible.
 >
 > It must never be used in an in-kernel driver that only works with
 > kernel memory.

This is exactly our use case. Although the platform decides whether a
mapping requires bouncing or cache maintenance, 
DMA_ATTR_REQUIRE_COHERENT lets the driver reject mappings that cannot 
meet this requirement.

The shmem path serves a different use case, but amdkfd is a relevant 
comparison. HIP's coherence guarantees depend on both the GPU VM/cache 
configuration and the DMA mapping established by the kernel driver. GPU 
page table attributes alone cannot make a bounce buffer coherent with 
the original userspace pages.

The amdkfd mapping you cited therefore warrants discussion with its
developers as well. I have CCed the maintainer.

Regards,
Akihiko Odaki

> 
> Regards,
> Honglei
> 
>> Regards,
>> Akihiko Odaki
>>
>>> +        if (ret)
>>> +            goto err_cleanup;
>>> +
>>> +        userptr->dma_dir = dir;
>>> +        userptr->dma_mapped = true;
>>> +    }
>>> +
>>> +    ret = virtio_gpu_userptr_get_entries(vgdev, userptr, &ents, 
>>> &nents);
>>> +    if (ret)
>>> +        goto err_cleanup;
>>> +
>>> +    virtio_gpu_cmd_resource_create_blob(vgdev, &userptr->base, 
>>> params, ents,
>>> +                        nents);
>>> +
>>> +    userptr->base.params = *params;
>>> +    virtio_gpu_add_object_to_restore_list(vgdev, &userptr->base);
>>> +
>>> +    *bo_ptr = &userptr->base;
>>> +    return 0;
>>> +
>>> +err_cleanup:
>>> +    virtio_gpu_cleanup_object(&userptr->base);
>>> +    return ret;
>>> +}
>>
> 

