Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80E431A5D
	for <virtualization@lists.linux.dev>; Wed, 19 Aug 2026 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132329; cv=none; b=uhQoE+/8zREi/yhD1qn5Q0QWPDbQEM76HDFdjecK0JkwbS10oysjaLXUHklIXVotwZITK8Utv/Om8WA16VlPxFNTfJcTJ7HTNJkXifsc810vJ/MHozRfh7t2m7IGfhYHqS4qxvakiPGdeMheJUb2c/ZFIXR+oZFcPazAI7OHuow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132329; c=relaxed/simple;
	bh=J6mSe9srmMOVX4k8pkviFEsYyHSi5MliEjFyl7u70WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FFbjMjBnzRmCfgcKTPE4uNod5jHccKy5WoBCeQobMfUcpATYAUDjpB+QDt6VwUm2KPgC53+BCUk+5g+g2fGSrqzKQS4oy+14XwCo29baN03muyCXCiNskWfbtWyq8AEIilBHpU0/d9gOzRDF0ghO84zTdc5vVF0P6LEQePTXnWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=T/Kb4+1s; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="T/Kb4+1s"
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67J9cJnn090701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 19 Aug 2026 18:38:19 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=ug82VAI/a0QozUV8v/ZE006rMyqBDcb8VDA+Mu3mfoY=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1787132300; v=1;
        b=T/Kb4+1scf++SM3H7NSzFQv4fE5fah6VYD0rlZa6sj7VJkUQIPU96mmVYXbsZJ3W
         XzxS14UYYSmoeDA7EyBxhB6abP2bge/pdKQUZl/DA09SBLgRoE1RrT4bxjKowOGK
         0Y2pp+yjFoPTa6rR7h7Sl5wBQBv7H2bzvTgnDf/NvJwpZqMJueCVHZk8utCg7dYz
         ZRlgAvqX/55DWrnI9g7WYxTIbW0YIXrOEk+LTMbmZjnpiAfcDjMzNp1m9yHgmf+e
         5FKT3Yflq52G9t7is4YMXfRj7hcJRm8+AjsMkhwvYdnnP7Y7MmxWJDj46OCNLirJ
         CG6moukqDaH/Fmcyfm1SPA==
Message-ID: <fc507e46-2c4f-4db1-8509-590588b0fd10@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 19 Aug 2026 18:38:19 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: About new backend for GPU compute ROCm in qemu
To: "Huang, Honglei" <honghuan@amd.com>
Cc: qemu-devel@nongnu.org, virtio-comment@lists.oasis-open.org,
        dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
        Honglei Huang <honglei1.huang@amd.com>, Huang Rui <Ray.Huang@amd.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>
References: <ba0b1bbf-5ebf-4ac3-9f7b-8740e3bc283b@amd.com>
 <ea899a6b-0a59-4a9c-9e81-3ed70711da59@rsg.ci.i.u-tokyo.ac.jp>
 <78f0583f-93c0-4374-ba37-fd36f6388f0e@amd.com>
 <c79bbd91-0057-4e9a-bc56-28ca4c4ccae2@rsg.ci.i.u-tokyo.ac.jp>
 <3c3eb833-8026-44ad-8e33-dea346752db2@amd.com>
 <33bf6649-c1b9-43f6-94dd-09167d8e5db6@rsg.ci.i.u-tokyo.ac.jp>
 <63d485c3-a418-493d-aad0-26b3c115f5b8@amd.com>
 <7fa93963-880b-47fd-a51b-880a651be963@rsg.ci.i.u-tokyo.ac.jp>
 <ef751787-8688-4e30-8bc4-f1740ef162fc@amd.com>
 <14c4d7ac-607f-4372-8d1f-ca836f36498b@rsg.ci.i.u-tokyo.ac.jp>
 <c318631e-d26a-4e24-98ba-5b7d5037a8cd@amd.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c318631e-d26a-4e24-98ba-5b7d5037a8cd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/08/19 11:37, Huang, Honglei wrote:
> 
> 
> On 8/18/2026 7:27 PM, Akihiko Odaki wrote:
>> On 2026/08/18 17:53, Huang, Honglei wrote:
>>>
>>>
>>> On 8/18/2026 3:50 PM, Akihiko Odaki wrote:
>>>> On 2026/08/18 13:26, Huang, Honglei wrote:
>>>>>
>>>>>
>>>>> On 8/18/2026 12:05 PM, Akihiko Odaki wrote:
>>>>>> On 2026/08/18 11:50, Huang, Honglei wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 8/18/2026 12:29 AM, Akihiko Odaki wrote:
>>>>>>>> On 2026/08/17 22:44, Huang, Honglei wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 8/17/2026 7:44 PM, Akihiko Odaki wrote:
>>>>>>>>>> On 2026/08/17 12:19, Huang, Honglei wrote:
>>>>>>>>>>>
>>>>>>>>>>> Hi Michael, Alex, Dmitry, Akihiko,
>>>>>>>>>>
>>>>>>>>>> Hi Honglei,
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> I'm bringing AMD GPU compute ROCm based on virtio. I posted a 
>>>>>>>>>>> ROCm over virtio
>>>>>>>>>>> implementation to virglrenderer nine months ago (MR !1568 
>>>>>>>>>>> [1]). The ROCm side has
>>>>>>>>>>> been supportted by ROCm offical.
>>>>>>>>>>>
>>>>>>>>>>> Current implementation is a virtio gpu context type capset 
>>>>>>>>>>> handled inside
>>>>>>>>>>> virglrenderer, sharing the display path. That's an awkward 
>>>>>>>>>>> fit, many
>>>>>>>>>>> compute GPUs have no display engine at all.
>>>>>>>>>>
>>>>>>>>>> I think "sharing the display path" conflates several layers 
>>>>>>>>>> and makes the problem difficult to assess. It would help to 
>>>>>>>>>> identify the concrete constraint behind "awkward fit."
>>>>>>>>>>
>>>>>>>>>> End-to-end, there are four relevant layers:
>>>>>>>>>>
>>>>>>>>>> 1. Host GPU stack: hardware, host kernel, and host userspace
>>>>>>>>>> 2. Paravirtualization stack: virglrenderer and QEMU
>>>>>>>>>
>>>>>>>>> Yes we are asking can we add a new file like virtio-gpu 
>>>>>>>>> specific for compute, but maybe we can only add a new backend 
>>>>>>>>> like virglrenderer specific for compute.
>>>>>>>>>
>>>>>>>>>> 3. Host/guest interface: virtio and the capset-specific 
>>>>>>>>>> command stream
>>>>>>>>>
>>>>>>>>> In this plan we may need just add a capset id.
>>>>>>>>>
>>>>>>>>>> 4. Guest GPU stack: guest kernel and guest userspace
>>>>>>>>>
>>>>>>>>> Won't modify the guest kernel in this plan, this email list.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Orthogonally, acceleration is separate from display and 
>>>>>>>>>> scanout. A
>>>>>>>>>> physical device may provide both, but acceleration does not 
>>>>>>>>>> require a
>>>>>>>>>> display engine. Linux likewise exposes render and compute 
>>>>>>>>>> interfaces
>>>>>>>>>> separately from modesetting. The userspace interface 
>>>>>>>>>> virglrenderer uses is messy; there is Vulkan, EGL, OpenGL, and 
>>>>>>>>>> now you are adding ROCm. But there is one thing I must note is 
>>>>>>>>>> that acceleration and display is decoupled, and acceleration 
>>>>>>>>>> does not require display.
>>>>>>>>>
>>>>>>>>> Yes totally agreed.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> At the protocol layer, context command buffers are carried by 
>>>>>>>>>> VIRTIO_GPU_CMD_SUBMIT_3D. Scanout uses separate core virtio- 
>>>>>>>>>> gpu commands, and VIRTIO_GPU_CMD_GET_DISPLAY_INFO may report 
>>>>>>>>>> no enabled displays. At the implementation layer, QEMU handles 
>>>>>>>>>> scanout presentation. virgl_cmd_set_scanout() obtains resource 
>>>>>>>>>> information through virgl_renderer_resource_get_info() or 
>>>>>>>>>> virgl_renderer_resource_get_info_ext(). That does not make 
>>>>>>>>>> scanout a virglrenderer-owned display path.
>>>>>>>>>
>>>>>>>>> Yes, agreed.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Therefore, if "sharing the display path" means sharing the 
>>>>>>>>>> same device, control queue, and QEMU execution context, that 
>>>>>>>>>> identifies a possible source of contention. If it means that 
>>>>>>>>>> capsets or virglrenderer are inherently tied to display, I do 
>>>>>>>>>> not think that is accurate. Vulkan compute is already used 
>>>>>>>>>> through Venus with libkrun [2], and VCL proposes OpenCL 
>>>>>>>>>> support through virglrenderer [3].
>>>>>>>>>
>>>>>>>>> Yes，but the vulkan is for GFX originally, and for some formal 
>>>>>>>>> AI frame work like pytorch, it's support is limited, and it 
>>>>>>>>> performance is lower than ROCm, and vulkan also lacks many AI 
>>>>>>>>> infrastructure, like composable kernel.
>>>>>>>>> And for virCL, actually it is came from same project with ROCm 
>>>>>>>>> native context, but the original author didn't continue to 
>>>>>>>>> support it, they handed it over to someone else to take over. 
>>>>>>>>> And in the first version of
>>>>>>>>> virCL, it didn't pass the test of actual projects.
>>>>>>>>>
>>>>>>>>> And it seems like virCL didn't upstream into virglrenderer 
>>>>>>>>> also, correct me if I am wrong.
>>>>>>>>
>>>>>>>> I cited Venus and VCL only as examples showing that virtio-gpu and
>>>>>>>> virglrenderer are not intrinsically tied to display. I did not 
>>>>>>>> suggest
>>>>>>>> either as a substitute for ROCm.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>> Beyond that, sharing the display path is increasingly painful:
>>>>>>>>>>>
>>>>>>>>>>>    - Compute hammers the queues more than graphics, so sharing
>>>>>>>>>>>      virtio gpu's single control queue with display/virgl 
>>>>>>>>>>> causes contention
>>>>>>>>>>>      and display stutter.
>>>>>>>>>>
>>>>>>>>>> All non-cursor commands do share one control queue, but a 
>>>>>>>>>> fence avoids serialization.
>>>>>>>>>
>>>>>>>>> yes, agreed.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> There may still be implementation-level contention, and it is not
>>>>>>>>>> necessarily specific to compute. A sufficiently busy graphics 
>>>>>>>>>> workload
>>>>>>>>>> could expose the same bottlenecks. Possible contributors in 
>>>>>>>>>> current QEMU
>>>>>>>>>> include:
>>>>>>>>>>
>>>>>>>>>> a) qemu_console_hw_gl_block() blocks the entire queue when 
>>>>>>>>>> QEMU only
>>>>>>>>>>     needs to fence scanout commands.
>>>>>>>>>
>>>>>>>>> Yes, agreed.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> b) virtio_gpu_virgl_unmap_resource_blob() may also block the 
>>>>>>>>>> entire
>>>>>>>>>>     queue just to delay one command.
>>>>>>>>>
>>>>>>>>> Yes, but it is seems like it is must, someone else in AMD tried 
>>>>>>>>> to use async method to relase blob, but it failed to 
>>>>>>>>> consistency issue, then
>>>>>>>>> reverted to sync version.
>>>>>>>>
>>>>>>>> Queue-wide suspension is not inherently required. Commit 
>>>>>>>> 4eb0aace85f5 ("virtio-gpu: Support mapping hostmem blobs with 
>>>>>>>> map_fixed") added a path that avoids per-blob MemoryRegion 
>>>>>>>> teardown when virgl_renderer_resource_map_fixed() succeeds. The 
>>>>>>>> remaining path is also being improved with:
>>>>>>>>
>>>>>>>> https://lore.kernel.org/qemu-devel/20260424-force_rcu-v4-0- 
>>>>>>>> feccfaca0568@rsg.ci.i.u-tokyo.ac.jp/
>>>>>>>> ("[PATCH v4 0/6] virtio-gpu: Force RCU when unmapping blob")
>>>>>>>
>>>>>>> Thanks. force_rcu is a clean fix for the RCU-reclamation part, 
>>>>>>> but it still keeps the unmap synchronous and serial.
>>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> c) QEMU dispatches the control queue and calls into 
>>>>>>>>>> virglrenderer from
>>>>>>>>>>     its main-loop thread along with display work and many 
>>>>>>>>>> other things.
>>>>>>>>>>     Venus's render server can offload renderer work, but 
>>>>>>>>>> control- queue
>>>>>>>>>>     dispatch remains in QEMU's main loop.
>>>>>>>>>
>>>>>>>>> Yes, we did some async optimization in ROCm context, but its 
>>>>>>>>> effectiveness is limited, see bellow.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> In any case, I think you need to do some experiments to track 
>>>>>>>>>> down the real cause. a) is easy to check: just comment out all 
>>>>>>>>>> qemu_console_hw_gl_block() calls; it may corrupt display but 
>>>>>>>>>> removes the blocking. b) can also be tested by leaking the 
>>>>>>>>>> mappings instead of blocking the whole queue. Using a 
>>>>>>>>>> different display device like qxl tells whether c) is causing 
>>>>>>>>>> contention.
>>>>>>>>>
>>>>>>>>> Yes, totally agreed. following is my findings. In short words:
>>>>>>>>>
>>>>>>>>> Optimization can reduce queue pressure, but it can't withstand 
>>>>>>>>> absolute overload because each command has some overhead. 
>>>>>>>>> Making all commands asynchronous would lead to a debugging hell 
>>>>>>>>> about asynchronous issues.
>>>>>>>>> And we have high load applications rocmprofiler  that 
>>>>>>>>> continuously catch information need virtio queue to handle. But 
>>>>>>>>> create a new backend can not solve it simply, we are trying to 
>>>>>>>>> find a way. like shmem between guest and host, then use cpu 
>>>>>>>>> polling, bypass the virtqueue.
>>>>>>>>
>>>>>>>> Most commands are fast on the CPU side, while heavy processing
>>>>>>>> happens asynchronously on the GPU. Cases (a) and (b) are 
>>>>>>>> exceptions.
>>>>>>>>
>>>>>>>>>
>>>>>>>>> The load is mostly memory management. Running an AI model 
>>>>>>>>> allocates and frees a large number of blobs. We already did 
>>>>>>>>> some optimization release them asynchronously, but the host 
>>>>>>>>> processing is a single queue one
>>>>>>>>> process_cmdq, this is where the main bottleneck in my debugging 
>>>>>>>>> work / my understanding so far. I'm not certain it's the whole 
>>>>>>>>> picture, so please correct if I am wrong.
>>>>>>>>>
>>>>>>>>> A model load or unload frees a large batch of BOs and allocates 
>>>>>>>>> another. Some of those commands are async in the virtio-gpu 
>>>>>>>>> guest driver, but QEMU still has to work through them on the 
>>>>>>>>> one queue, which takes time; so even though any single command 
>>>>>>>>> is quick, there are simply too many of them, the single queue 
>>>>>>>>> backs up, and everything behind it, gets delayed.
>>>>>>>>>
>>>>>>>>> real work load (a few downstream customisations): loading one 
>>>>>>>>> 16 GB model (gemm4 e4b), drives ~1200 blob creates, a burst of
>>>>>>>>> ~1400 resource frees at teardown, ~3700 submits and ~6000 
>>>>>>>>> virtqueue notifies, caused a 22 s guest soft lockup. And the 
>>>>>>>>> behavior of memory operations are controlled by upper layer 
>>>>>>>>> like pytorch / HIP / runtime,
>>>>>>>>> we can not control it.
>>>>>>>>>
>>>>>>>>> To be honest, a separate backend won't fix this. But the real 
>>>>>>>>> solution maybe is compute specific. That logic is only useful 
>>>>>>>>> to the compute path, and folding it into the shared display 
>>>>>>>>> device / renderer would mean churning code that is mature and 
>>>>>>>>> stable for graphics, with regression risk. Keeping compute on 
>>>>>>>>> its own instance and backend lets us iterate on these compute 
>>>>>>>>> only optimisations.
>>>>>>>>
>>>>>>>> A 22-second lockup is too long for those command counts.
>>>>>>>>
>>>>>>>> The most probable explanation I have is that the ROCm 
>>>>>>>> integration blocks QEMU's main loop thread while synchronously 
>>>>>>>> waiting for GPU execution. Creating separate devices won't 
>>>>>>>> resolve this because the main loop thread is shared, and 
>>>>>>>> synchronously waiting on the GPU should be avoided in the first 
>>>>>>>> place.
>>>>>>>
>>>>>>> No synchronously waiting in ROCm backend, we are using user 
>>>>>>> queue, and event waiting, no sync operation in CMD wait. all the 
>>>>>>> resource release in ROCm are all async now.
>>>>>>> Only the sync thing is memory thing mapping/unmapping in qemu, as 
>>>>>>> long as it remains synchronous, it will be overwhelmed by the 
>>>>>>> massive number of requests.
>>>>>>
>>>>>> Mapping and unmapping should not block QEMU's main-loop thread for 
>>>>>> that
>>>>>> long. The command counts you reported are relatively small. That 
>>>>>> is why
>>>>>> I suspect something else went wrong, such as the main-loop thread 
>>>>>> being
>>>>>> inadvertently blocked while waiting for the GPU.
>>>>>
>>>>> Will investigate it.
>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> In any case, profiling is necessary before touching the 
>>>>>>>> implementation.
>>>>>>>>
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>    - Compute contexts need far more blob / shared memory than 
>>>>>>>>>>> a display one.
>>>>>>>>>>
>>>>>>>>>> It is not a problem by itself. Frequent mapping and unmapping 
>>>>>>>>>> might amplify the second issue above, but that needs to be 
>>>>>>>>>> measured.
>>>>>>>>>
>>>>>>>>> Yes, agreed. I can give more detailed information.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>    - Maybe needs a wider ROCm / compute stack, cause the 
>>>>>>>>>>> render model fits poorly:
>>>>>>>>>>>      rocprofiler (PC sampling, SQTT/SPM, counters, high 
>>>>>>>>>>> bandwidth streams)
>>>>>>>>>>>      and ROCgdb (wave control, address watch, async 
>>>>>>>>>>> exceptions an
>>>>>>>>>>>      out of band channel that must not block display).
>>>>>>>>>>
>>>>>>>>>> virglrenderer does not impose a particular render model. 
>>>>>>>>>> That's why Vulkan Compute just works with Venus.
>>>>>>>>>
>>>>>>>>> Yes but vulkan is used for GFX initally. And can not support 
>>>>>>>>> many AI application.>
>>>>>>>>>>>    - Events, faults and GPU reset/SMI are async and don't map 
>>>>>>>>>>> onto fences.>    - All of this is hard to extend cleanly 
>>>>>>>>>>> inside a display capset.
>>>>>>>>>> Capset is not about display but determines the protocol of the 
>>>>>>>>>> VIRTIO_GPU_CMD_SUBMIT_3D command stream. You have described 
>>>>>>>>>> events, faults and GPU reset/SMI are async don't map onto 
>>>>>>>>>> fences that may be associated with VIRTIO_GPU_CMD_SUBMIT_3D 
>>>>>>>>>> which is dictated by capset. An additional feature may be 
>>>>>>>>>> necessary, and it may or may not be dictated by capset. The 
>>>>>>>>>> other things are irrelevant with the protocol capset 
>>>>>>>>>> represents; they are either behavioral or about different 
>>>>>>>>>> commands.
>>>>>>>>>
>>>>>>>>> A fence is the one shot, but event is stateful and repeatable.
>>>>>>>>> That may or may not be tied to capset. Agreed.
>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On the QEMU/host side, would something like this be OK? One 
>>>>>>>>>>> step, two parts:
>>>>>>>>>>>
>>>>>>>>>>>    - a dedicated headless virtio gpu instance for compute.
>>>>>>>>>>
>>>>>>>>>> A second device would isolate its virtqueues and device-wide
>>>>>>>>>> renderer_blocked state. That may be useful if measurements 
>>>>>>>>>> show that
>>>>>>>>>> these are the bottlenecks, but it is not yet clear that they 
>>>>>>>>>> are or that
>>>>>>>>>> a second device is the appropriate solution.
>>>>>>>>>>
>>>>>>>>>>>    - that instance served by a separate ROCm backend library 
>>>>>>>>>>> loaded
>>>>>>>>>>>      in-process by QEMU.
>>>>>>>>>>
>>>>>>>>>> First, I think we need to establish why ROCm cannot or should 
>>>>>>>>>> not remain
>>>>>>>>>> in virglrenderer. The virglrenderer, Venus, and VCL 
>>>>>>>>>> maintainers are
>>>>>>>>>> likely better placed to advise on that boundary. Once the 
>>>>>>>>>> protocol
>>>>>>>>>> requirements and performance measurements are clear, we can 
>>>>>>>>>> assess the
>>>>>>>>>> appropriate QEMU integration.
>>>>>>>>>
>>>>>>>>> venus is borned for GFX.
>>>>>>>>> virCL not merged.
>>>>>>>>>
>>>>>>>>> To be clear, I'm not saying virglrenderer can't host a ROCm 
>>>>>>>>> native context it clearly can. My hesitation is more about fit 
>>>>>>>>> and direction: virglrenderer has grown up around GL/graphics, 
>>>>>>>>> and I haven't yet found compute oriented plumbing there to 
>>>>>>>>> build on, while ROCm moves very fast and I need something I can 
>>>>>>>>> keep current with low friction.
>>>>>>>>
>>>>>>>> Whether keeping ROCm in virglrenderer would create extra 
>>>>>>>> friction is primarily a question for the virglrenderer 
>>>>>>>> maintainers. Its graphics origins do not by themselves motivate 
>>>>>>>> adding a separate backend interface to QEMU.
>>>>>>>
>>>>>>> Fair. The first draft version in virglrenderer was in May 2024, 
>>>>>>> and ROCm has gone 5.7 → 7.14 in that window.
>>>>>>
>>>>>> One point to note is that virtio-gpu development in QEMU is somewhat
>>>>>> less active. crosvm is the most active user of virglrenderer, and 
>>>>>> QEMU
>>>>>> sometimes lags behind it. If you are considering moving the ROCm 
>>>>>> integration from virglrenderer to QEMU solely because ROCm evolves 
>>>>>> rapidly, I do not think that would be a good idea. A rapidly 
>>>>>> evolving component is better kept in virglrenderer unless there is 
>>>>>> another reason to place it in QEMU.
>>>>>
>>>>> Actually didn't see something new about compute merged in to 
>>>>> virglrenderer this recently 2 years.
>>>>
>>>> Neither QEMU nor virglrenderer has seen new compute-related 
>>>> additions in the past two years.
>>>
>>> Maybe that is the reason we need a compute specific path? But I think 
>>> the VFIO or vDPA are all can be used for compute, they are really 
>>> active. We only need a small file for compute, providing the basic 
>>> mechanisms, this code will also benefit other computing devices, such 
>>> as NPU, I believe there will be more and more computing devices in 
>>> the future.
>>
>> I think this highlights that you are pioneering device-specific 
>> paravirtualization here. Venus demonstrates a vendor-neutral approach, 
>> but it didn't get compute-specific plumbing simply because Venus 
>> didn't need one. Pushing improvements through virglrenderer will help 
>> both graphics and compute accelerators.
>>
>>>
>>>
>>>>
>>>> While you have regularly updated the merge request, initiating 
>>>> discussions around it is necessary to move review forward. Open- 
>>>> source projects like QEMU and virglrenderer need proactive driving 
>>>> to complete reviews. Simply shifting the ROCm integration to QEMU 
>>>> will not resolve this bottleneck.
>>>
>>> Yes I have actively promoted it, but I haven't received substantial 
>>> reviews regarding virtio gpu userptr and virglrenderer. Hard to make 
>>> MR move forward without a substantial review. So I am finding a 
>>> another way.
>>
>> I don't see recent engagement on the MR. Reaching out publicly on the 
>> MR would be a good way to show that you are actively driving it forward.
>>
>>>
>>>>
>>>> Besides, looking at the "Architecture Components" in the 
>>>> description, most of them haven't been merged yet. The virglrenderer 
>>>> code cannot be merged in its current state, so focusing on those 
>>>> dependencies first is essential.
>>>
>>> Yes, I must admit that most of them not merged.
>>> But actually for para virtualization those components are need merged 
>>> together because they are closely connected.
>>>
>>>>
>>>> However, taking a naive approach can lead to a chicken-and-egg 
>>>> problem: component maintainers want the virglrenderer side 
>>>> stabilized first, while virglrenderer maintainers want the component 
>>>> side stabilized. To break this deadlock, I suggest seeking consensus 
>>>> on the interfaces before completing the implementation. Once an 
>>>> interface agreement is reached, changes to each component can land 
>>>> independently:
>>>
>>> I've seen amdgpu native context (for GFX) and msm native context 
>>> merged quickly. And actually ROCm native context is using the same 
>>> method. That's why I think this is a problem of direction.
>>
>> It is understandable that those merged more quickly given the state of 
>> the "Architecture Components" mentioned earlier. For both the amdgpu 
>> and msm native contexts, the UAPI was already in place, allowing those 
>> changes to be reviewed and merged in isolation.
>>
>>>
>>>>
>>>> - virtio interface: I raised a concern regarding the interface [1][2]
>>>>    that needs to be addressed.
>>>
>>> I'm open to any feedback from the virtio maintainer, but since it's 
>>> really just you and me discussing this, I can immediately modify your 
>>> proposal if the maintainer agrees.
>>
>> A pattern sometimes I observe is that maintainers often skip patches 
>> with unaddressed discussion items. Updating the code to resolve known 
>> feedback often serves as a good trigger to draw in new reviewers.
>>
>>>
>>>> - amdkfd patches: There are interface-level concerns [3] that still 
>>>> need
>>>>    resolution.
>>>
>>> We have a another solution to solve it, it is already done in 
>>> virglrender.
>>>
>>>> - ROCm runtime: The description lists this as "90% complete," but the
>>>>    linked pull requests were closed due to inactivity. They need to be
>>>>    reopened and seek for a consensus on its interface.
>>>
>>> It was completed using another PR, so it was closed.
>>
>> These are great news. I suggest updating the MR description then so 
>> that potential reviewers can see the progress.
>>
> 
> Thanks Akihiko, appreciate the detailed review and the process guidance.
> 
> Let me clarify the requirements about the compute specific path is from 
> the actual project requirements and the current stack actually behaves.
> 
> - Isolation is necessary, not a preference.
> If compute stays on the GFX path, GFX, ROCm compute and NPU compute and 
> any other custom ASIC all all through one virtio-gpu control queue. We 
> already see severe stutter from compute at only light tomoderate load, 
> and we've verified it affects gfx. Customer workloads are not 
> predictable, cannot assume a benign load and once several compute 
> devices are stacked alongside gfx on a single queue, the behaviour under 
> real load is anyone's guess. Just as important: when something does go 
> wrong, a single queue mixing multiple devices is extremely hard to 
> decouple and debug. A dedicated path provides pressure relief, workload
> isolation, clean code decoupling, independent debuggability, and 
> independent evolution.

What was observed was a guest soft lockup, which points to a vCPU lockup 
rather than mere display stutter. A dedicated path will not resolve or 
simplify profiling here, as vCPUs interleave execution across graphics, 
compute, and other tasks.

> 
> - Fit: much of this hardware has no display at all.
> Many compute accelerators have no scanout and no 3D. Hosting them in
> virglrenderer brings no benefit, the name itself, virgl, says it was 
> built for GL, and I don't see anything on its roadmap serving compute. 
> As high density compute becomes common it will need substantial 
> infrastructure of its own and a more aggressive design tuned for high 
> load. Venus works well as a vendor neutral abstraction, but we need
> native, hardware-specific compute; "improvements through virglrenderer 
> help both" only holds if there is compute plumbing to improve, and there 
> isn't.

Historical naming like "virgl" and "3D" can be misleading, but 
virglrenderer functions today as a generic accelerator framework. While 
legacy OpenGL-specific paths aren't relevant here, the core 
infrastructure actively handles hardware-specific graphics acceleration 
as well as vendor-neutral compute acceleration. We haven't seen a reason 
it cannot also support hardware-specific compute acceleration yet.

> 
> - Velocity and ecosystem.
> Some compute devices are already taking their own path rather than 
> sharing the GFX one. We've maintain a private virgl branch for over two 
> years. ROCm moves fast, and to keep pace the integration needs to live 
> with ROCm and share its CI and infrastructure. A compute specific path 
> is what lets us track that pace.

Development velocity is a priority for all of us. Architectural 
separation is a potential approach, but it won't solve the primary 
upstream bottlenecks—namely, unmerged interface dependencies and quiet 
review threads.

> 
> To be direct about the driver: separating compute from graphics is a 
> real project requirement, coming from our customers' real time 
> constraints and our architects' direction (I just work here). not a code 
> placement preference on my part. And we cannot assume future compute 
> needs will stay close to what virglrenderer provides today.
Device emulation in QEMU is largely single-threaded either due to the 
Big QEMU Lock (BQL), so creating a compute-specific path won't satisfy 
the requirement. That said, you are not constrained by what either 
virglrenderer or QEMU provides today; you can propose a change whenever 
appropriate.

> 
> We only need a small, self-contained piece to provide the basic 
> mechanisms; that same code benefits other compute devices, NPUs 
> included, and I expect there will be more and more of them. We'll keep 
> the virglrenderer MR open and update its description, but in all honesty 
> I can't say how far the design will end up diverging from that version 
> as it evolves to meet the actual project requirements.

I encourage evaluating virglrenderer's generic framework to see which 
underlying mechanisms already meet your needs. If specific capabilities 
essential to your compute path are missing, detailing those exact gaps 
will give us a foundation to discuss how to address them.

Regards,
Akihiko Odaki
