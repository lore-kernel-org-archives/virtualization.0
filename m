Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C28B2749D5
	for <virtualization@lists.linux.dev>; Fri, 16 Jan 2026 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768553697; cv=none; b=uq8Mk4txKaEyjd40UK8k14Lk1CeUbtfsy9hV9mNEkPoAbZW34e6Tl/CmTh0biysaWTd2yhGSjuQVGs7iJmttrcJmT1nU6KJ3Pjrvqv6vwl5KzBXx6Y2WVdXVq921Xx+0LIGHMnglP23k+VFqTn8Nxv8ixM2BBfAmQHcfO44+WzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768553697; c=relaxed/simple;
	bh=pm233wS/ohA2Ydd1X1SihmpDtr3OjRzwQK3DWMrKG1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hn+U534aDPfZ792USUvMtEmsRm3Dccjzgs4pPsXnsaK5hfjcsPwE4c0HppEuAvdXnWKfnNJfJklCX47rCKfqVsoCijBmUW1uGBWf0FmPPxRiJUfeK1TZo2enPimQDpjnhA7bdHNripqgtErb1xsrufn7+Dl5byAxcJYuq30xfDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=fail (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=n1dQMUtD reason="key not found in DNS"; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="n1dQMUtD"
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60G8s9Dt038331
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 16 Jan 2026 17:54:15 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=vMaN48b+DmtoUknmJ5ekzd+XKSx2hXy5fgMpMnhoDAY=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=Message-ID:Date:Subject:To:From;
        s=rs20250326; t=1768553655; v=1;
        b=n1dQMUtDEijf6li7u4nt1WVL5eMiEQ/i92FXHXxXOpFjVL9YZnk87/P0qCx/dP3l
         nKn5nbLLDw+g1sidJdqJ2KWVbvRgIDibwsoPcsCCYUv8K8SPS4XmwlhNMDhysPwI
         pm1MKds06WAeZN4kNOaEWqTL5J3RNE9pQ9W5zAYfHOGvtHme0SNJx5LYIdHBhU6C
         CGJC7K0HeGVUYytmAGFz1Tl9fugZ7CznASSqlFARhMgoPGORk6Opvz9I7PjXTe7M
         W2bc+zu9X7CLZa75T//Owxi4yJ2awRKBNYqVWVv2CjXN03CN4lfaqA3I9olFcjha
         pswJhwgVEFE2AJF+b+4HRw==
Message-ID: <cc444faa-af80-4bab-ac3b-a013fef4a695@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 16 Jan 2026 17:54:09 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] virtio-gpu: Add userptr support for compute
 workloads
To: Honglei Huang <honghuan@amd.com>
Cc: Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
        Honglei Huang <honglei1.huang@amd.com>,
        David Airlie <airlied@redhat.com>, Ray.Huang@amd.com,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Simona Vetter <simona@ffwll.ch>
References: <20260115075851.173318-1-honglei1.huang@amd.com>
 <5b66df7d-374c-4e9c-88d5-bb514f9a7725@rsg.ci.i.u-tokyo.ac.jp>
 <2ae03f22-740d-4a48-b5f3-114eef92fb29@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <2ae03f22-740d-4a48-b5f3-114eef92fb29@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/01/16 16:20, Honglei Huang wrote:
> 
> 
> On 2026/1/15 17:20, Akihiko Odaki wrote:
>> On 2026/01/15 16:58, Honglei Huang wrote:
>>> From: Honglei Huang <honghuan@amd.com>
>>>
>>> Hello,
>>>
>>> This series adds virtio-gpu userptr support to enable ROCm native
>>> context for compute workloads. The userptr feature allows the host to
>>> directly access guest userspace memory without memcpy overhead, which is
>>> essential for GPU compute performance.
>>>
>>> The userptr implementation provides buffer-based zero-copy memory 
>>> access.
>>> This approach pins guest userspace pages and exposes them to the host
>>> via scatter-gather tables, enabling efficient compute operations.
>>
>> This description looks identical with what 
>> VIRTIO_GPU_BLOB_MEM_HOST3D_GUEST does so there should be some 
>> explanation how it makes difference.
>>
>> I have already pointed out this when reviewing the QEMU patches[1], 
>> but I note that here too, since QEMU is just a middleman and this 
>> matter is better discussed by Linux and virglrenderer developers.
>>
>> [1] https://lore.kernel.org/qemu-devel/35a8add7-da49-4833-9e69- 
>> d213f52c771a@amd.com/
>>
> 
> Thanks for raising this important point about the distinction between
> VIRTGPU_BLOB_FLAG_USE_USERPTR and VIRTIO_GPU_BLOB_MEM_HOST3D_GUEST.
> I might not have explained it clearly previously.
> 
> The key difference is memory ownership and lifecycle:
> 
> BLOB_MEM_HOST3D_GUEST:
>    - Kernel allocates memory (drm_gem_shmem_create)
>    - Userspace accesses via mmap(GEM_BO)
>    - Use case: Graphics resources (Vulkan/OpenGL)
> 
> BLOB_FLAG_USE_USERPTR:
>    - Userspace pre-allocates memory (malloc/mmap)

"Kernel allocates memory" and "userspace pre-allocates memory" is a bit 
ambiguous phrasing. Either way, the userspace requests the kernel to map 
memory with a system call, brk() or mmap().

>    - Kernel only get existing pages
>    - Use case: Compute workloads (ROCm/CUDA) with large datasets, like
> GPU needs load a big model file 10G+, UMD mmap the fd file, then give 
> the mmap ptr into userspace then driver do not need a another copy.
> But if the shmem is used, the userspace needs copy the file data into a 
> shmem mmap ptr there is a copy overhead.
> 
> Userptr:
> 
> file -> open/mmap -> userspace ptr -> driver
> 
> shmem:
> 
> user alloc shmem ──→ mmap shmem ──→ shmem userspace ptr -> driver
>                                                ↑
>                                                │ copy
>                                                │
> file ──→ open/mmap ──→ file userptr ──────────┘
> 
> 
> For compute workloads, this matters significantly:
>    Without userptr: malloc(8GB) → alloc GEM BO → memcpy 8GB → compute → 
> memcpy 8GB back
>    With userptr:    malloc(8GB) → create userptr BO → compute (zero-copy)

Why don't you alloc GEM BO first and read the file into there?

> 
> The explicit flag serves three purposes:
> 
> 1. Although both send scatter-gather entries to host. The flag makes the 
> intent unambiguous.

Why will the host care?

> 
> 2. Ensures consistency between flag and userptr address field.

Addresses are represented with the nr_entries and following struct 
virtio_gpu_mem_entry entries, whenever 
VIRTIO_GPU_CMD_RESOURCE_CREATE_BLOB or 
VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING is used. Having a special flag 
introduces inconsistency.

> 
> 3. Future HMM support: There is a plan to upgrade userptr implementation 
> to use Heterogeneous Memory Management for better GPU coherency and 
> dynamic page migration. The flag provides a clean path to future upgrade.

How will the upgrade path with the flag and the one without the flag 
look like, and in what aspect the upgrade path with the flag is "cleaner"?

> 
> I understand the concern about API complexity. I'll defer to the virtio- 
> gpu maintainers for the final decision on whether this design is 
> acceptable or if they prefer an alternative approach.

It is fine to have API complexity. The problem here is the lack of clear 
motivation and documentation.

Another way to put this is: how will you explain the flag in the virtio 
specification? It should say "the driver MAY/SHOULD/MUST do something" 
and/or "the device MAY/SHOULD/MUST do something", and then Linux and 
virglrenderer can implement the flag accordingly.

Regards,
Akihiko Odaki
