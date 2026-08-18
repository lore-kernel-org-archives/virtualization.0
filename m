Received: from www3579.sakura.ne.jp (www3579.sakura.ne.jp [49.212.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54622367B99
	for <virtualization@lists.linux.dev>; Tue, 18 Aug 2026 04:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.243.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787025956; cv=none; b=RyZvC7OmYQuX3s/LrUJIak8FiPh4fY1j+jU7pbijZteBUqIWjKfN3ui4uXh4hWpGxGP+LiKrOhOLkiBr4AWBYeFYVpo9WlL0EZoAJNBnnJ1zkwI7FUvf4dcvCcSkZlXcAGpi0UGbX0qkVAh88k3lUPFuXDC60uhZMt5dBWwR1mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787025956; c=relaxed/simple;
	bh=NTVAAtaxcIYj6XvSSMNLAVdhWO2zjdle8ExA2zORZaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jB1Ix4AFNXueRNtZuNa6PHLv7XrK2Q8oPjk3YUUO3X54Zhxy9qDIG3iK3kyW7Af5dZixFJFF3hy46MM5NppUReMeS5dckS6AfQ7KfqWt0ECreMRDyeCTy/0JXtHDRzasAYpJvES5DhUwWbyqCAD26SPYX1dFdkyA6aEqdnGX7wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b=l1EO/y/6; arc=none smtp.client-ip=49.212.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rsg.ci.i.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.b="l1EO/y/6"
Received: from [192.168.10.145] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
	(authenticated bits=0)
	by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67I45UEX067040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 18 Aug 2026 13:05:30 +0900 (JST)
	(envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=OKx7rY6j+14rtDZI9D+rxCqRbVOMawh0/rYbw8bD0sM=;
        c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20250326; t=1787025930; v=1;
        b=l1EO/y/6lKwMnZljKAPCnhk48OyDZFmwCMWkEwfIZrolLiBB9ZPcFyKxhFPnayU3
         0DOKqvXkyoOnpJOzrLp5vP8SJUlr3yacInqXuHPDW0Yz+/dSe9n9C98+o9jSPdpQ
         rVhZN7GE0LaJn4HLNrUUiintSviFp7FG5r6tVcWVT1sOXgn+f5+5cPiNC7xb06Sf
         9nscUGnxcmxrrM/N5LqYY+HWUPOXvKIZsda9x8He6+LzMFO1Ob+IbrB3kHk3+vL7
         78NVdAJiniw5cPhtxz8+/l+Q4+uxk4kHeRIjBT3D9Wtdtgv9g8UIVPqW4vwY1NoM
         ProkdEUC3qolfXrtOXTrlA==
Message-ID: <33bf6649-c1b9-43f6-94dd-09167d8e5db6@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 18 Aug 2026 13:05:29 +0900
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
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <3c3eb833-8026-44ad-8e33-dea346752db2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/08/18 11:50, Huang, Honglei wrote:
> 
> 
> On 8/18/2026 12:29 AM, Akihiko Odaki wrote:
>> On 2026/08/17 22:44, Huang, Honglei wrote:
>>>
>>>
>>> On 8/17/2026 7:44 PM, Akihiko Odaki wrote:
>>>> On 2026/08/17 12:19, Huang, Honglei wrote:
>>>>>
>>>>> Hi Michael, Alex, Dmitry, Akihiko,
>>>>
>>>> Hi Honglei,
>>>>
>>>>>
>>>>> I'm bringing AMD GPU compute ROCm based on virtio. I posted a ROCm 
>>>>> over virtio
>>>>> implementation to virglrenderer nine months ago (MR !1568 [1]). The 
>>>>> ROCm side has
>>>>> been supportted by ROCm offical.
>>>>>
>>>>> Current implementation is a virtio gpu context type capset handled 
>>>>> inside
>>>>> virglrenderer, sharing the display path. That's an awkward fit, many
>>>>> compute GPUs have no display engine at all.
>>>>
>>>> I think "sharing the display path" conflates several layers and 
>>>> makes the problem difficult to assess. It would help to identify the 
>>>> concrete constraint behind "awkward fit."
>>>>
>>>> End-to-end, there are four relevant layers:
>>>>
>>>> 1. Host GPU stack: hardware, host kernel, and host userspace
>>>> 2. Paravirtualization stack: virglrenderer and QEMU
>>>
>>> Yes we are asking can we add a new file like virtio-gpu specific for 
>>> compute, but maybe we can only add a new backend like virglrenderer 
>>> specific for compute.
>>>
>>>> 3. Host/guest interface: virtio and the capset-specific command stream
>>>
>>> In this plan we may need just add a capset id.
>>>
>>>> 4. Guest GPU stack: guest kernel and guest userspace
>>>
>>> Won't modify the guest kernel in this plan, this email list.
>>>
>>>>
>>>> Orthogonally, acceleration is separate from display and scanout. A
>>>> physical device may provide both, but acceleration does not require a
>>>> display engine. Linux likewise exposes render and compute interfaces
>>>> separately from modesetting. The userspace interface virglrenderer 
>>>> uses is messy; there is Vulkan, EGL, OpenGL, and now you are adding 
>>>> ROCm. But there is one thing I must note is that acceleration and 
>>>> display is decoupled, and acceleration does not require display.
>>>
>>> Yes totally agreed.
>>>
>>>>
>>>> At the protocol layer, context command buffers are carried by 
>>>> VIRTIO_GPU_CMD_SUBMIT_3D. Scanout uses separate core virtio-gpu 
>>>> commands, and VIRTIO_GPU_CMD_GET_DISPLAY_INFO may report no enabled 
>>>> displays. At the implementation layer, QEMU handles scanout 
>>>> presentation. virgl_cmd_set_scanout() obtains resource information 
>>>> through virgl_renderer_resource_get_info() or 
>>>> virgl_renderer_resource_get_info_ext(). That does not make scanout a 
>>>> virglrenderer-owned display path.
>>>
>>> Yes, agreed.
>>>
>>>>
>>>> Therefore, if "sharing the display path" means sharing the same 
>>>> device, control queue, and QEMU execution context, that identifies a 
>>>> possible source of contention. If it means that capsets or 
>>>> virglrenderer are inherently tied to display, I do not think that is 
>>>> accurate. Vulkan compute is already used through Venus with libkrun 
>>>> [2], and VCL proposes OpenCL support through virglrenderer [3].
>>>
>>> Yes，but the vulkan is for GFX originally, and for some formal AI 
>>> frame work like pytorch, it's support is limited, and it performance 
>>> is lower than ROCm, and vulkan also lacks many AI infrastructure, 
>>> like composable kernel.
>>> And for virCL, actually it is came from same project with ROCm native 
>>> context, but the original author didn't continue to support it, they 
>>> handed it over to someone else to take over. And in the first version of
>>> virCL, it didn't pass the test of actual projects.
>>>
>>> And it seems like virCL didn't upstream into virglrenderer also, 
>>> correct me if I am wrong.
>>
>> I cited Venus and VCL only as examples showing that virtio-gpu and
>> virglrenderer are not intrinsically tied to display. I did not suggest
>> either as a substitute for ROCm.
>>
>>>
>>>>> Beyond that, sharing the display path is increasingly painful:
>>>>>
>>>>>    - Compute hammers the queues more than graphics, so sharing
>>>>>      virtio gpu's single control queue with display/virgl causes 
>>>>> contention
>>>>>      and display stutter.
>>>>
>>>> All non-cursor commands do share one control queue, but a fence 
>>>> avoids serialization.
>>>
>>> yes, agreed.
>>>
>>>>
>>>> There may still be implementation-level contention, and it is not
>>>> necessarily specific to compute. A sufficiently busy graphics workload
>>>> could expose the same bottlenecks. Possible contributors in current 
>>>> QEMU
>>>> include:
>>>>
>>>> a) qemu_console_hw_gl_block() blocks the entire queue when QEMU only
>>>>     needs to fence scanout commands.
>>>
>>> Yes, agreed.
>>>
>>>>
>>>> b) virtio_gpu_virgl_unmap_resource_blob() may also block the entire
>>>>     queue just to delay one command.
>>>
>>> Yes, but it is seems like it is must, someone else in AMD tried to 
>>> use async method to relase blob, but it failed to consistency issue, 
>>> then
>>> reverted to sync version.
>>
>> Queue-wide suspension is not inherently required. Commit 4eb0aace85f5 
>> ("virtio-gpu: Support mapping hostmem blobs with map_fixed") added a 
>> path that avoids per-blob MemoryRegion teardown when 
>> virgl_renderer_resource_map_fixed() succeeds. The remaining path is 
>> also being improved with:
>>
>> https://lore.kernel.org/qemu-devel/20260424-force_rcu-v4-0- 
>> feccfaca0568@rsg.ci.i.u-tokyo.ac.jp/
>> ("[PATCH v4 0/6] virtio-gpu: Force RCU when unmapping blob")
> 
> Thanks. force_rcu is a clean fix for the RCU-reclamation part, but it 
> still keeps the unmap synchronous and serial.
> 
>>
>>>
>>>>
>>>> c) QEMU dispatches the control queue and calls into virglrenderer from
>>>>     its main-loop thread along with display work and many other things.
>>>>     Venus's render server can offload renderer work, but control-queue
>>>>     dispatch remains in QEMU's main loop.
>>>
>>> Yes, we did some async optimization in ROCm context, but its 
>>> effectiveness is limited, see bellow.
>>>
>>>>
>>>> In any case, I think you need to do some experiments to track down 
>>>> the real cause. a) is easy to check: just comment out all 
>>>> qemu_console_hw_gl_block() calls; it may corrupt display but removes 
>>>> the blocking. b) can also be tested by leaking the mappings instead 
>>>> of blocking the whole queue. Using a different display device like 
>>>> qxl tells whether c) is causing contention.
>>>
>>> Yes, totally agreed. following is my findings. In short words:
>>>
>>> Optimization can reduce queue pressure, but it can't withstand 
>>> absolute overload because each command has some overhead. Making all 
>>> commands asynchronous would lead to a debugging hell about 
>>> asynchronous issues.
>>> And we have high load applications rocmprofiler  that continuously 
>>> catch information need virtio queue to handle. But create a new 
>>> backend can not solve it simply, we are trying to find a way. like 
>>> shmem between guest and host, then use cpu polling, bypass the 
>>> virtqueue.
>>
>> Most commands are fast on the CPU side, while heavy processing
>> happens asynchronously on the GPU. Cases (a) and (b) are exceptions.
>>
>>>
>>> The load is mostly memory management. Running an AI model allocates 
>>> and frees a large number of blobs. We already did some optimization 
>>> release them asynchronously, but the host processing is a single 
>>> queue one
>>> process_cmdq, this is where the main bottleneck in my debugging 
>>> work / my understanding so far. I'm not certain it's the whole 
>>> picture, so please correct if I am wrong.
>>>
>>> A model load or unload frees a large batch of BOs and allocates 
>>> another. Some of those commands are async in the virtio-gpu guest 
>>> driver, but QEMU still has to work through them on the one queue, 
>>> which takes time; so even though any single command is quick, there 
>>> are simply too many of them, the single queue backs up, and 
>>> everything behind it, gets delayed.
>>>
>>> real work load (a few downstream customisations): loading one 16 GB 
>>> model (gemm4 e4b), drives ~1200 blob creates, a burst of
>>> ~1400 resource frees at teardown, ~3700 submits and ~6000 virtqueue 
>>> notifies, caused a 22 s guest soft lockup. And the behavior of memory 
>>> operations are controlled by upper layer like pytorch / HIP / runtime,
>>> we can not control it.
>>>
>>> To be honest, a separate backend won't fix this. But the real 
>>> solution maybe is compute specific. That logic is only useful to the 
>>> compute path, and folding it into the shared display device / 
>>> renderer would mean churning code that is mature and stable for 
>>> graphics, with regression risk. Keeping compute on its own instance 
>>> and backend lets us iterate on these compute only optimisations.
>>
>> A 22-second lockup is too long for those command counts.
>>
>> The most probable explanation I have is that the ROCm integration 
>> blocks QEMU's main loop thread while synchronously waiting for GPU 
>> execution. Creating separate devices won't resolve this because the 
>> main loop thread is shared, and synchronously waiting on the GPU 
>> should be avoided in the first place.
> 
> No synchronously waiting in ROCm backend, we are using user queue, and 
> event waiting, no sync operation in CMD wait. all the resource release 
> in ROCm are all async now.
> Only the sync thing is memory thing mapping/unmapping in qemu, as long 
> as it remains synchronous, it will be overwhelmed by the massive number 
> of requests.

Mapping and unmapping should not block QEMU's main-loop thread for that
long. The command counts you reported are relatively small. That is why
I suspect something else went wrong, such as the main-loop thread being
inadvertently blocked while waiting for the GPU.

> 
>>
>> In any case, profiling is necessary before touching the implementation.
>>
>>>
>>>>
>>>>>    - Compute contexts need far more blob / shared memory than a 
>>>>> display one.
>>>>
>>>> It is not a problem by itself. Frequent mapping and unmapping might 
>>>> amplify the second issue above, but that needs to be measured.
>>>
>>> Yes, agreed. I can give more detailed information.
>>>
>>>>
>>>>>    - Maybe needs a wider ROCm / compute stack, cause the render 
>>>>> model fits poorly:
>>>>>      rocprofiler (PC sampling, SQTT/SPM, counters, high bandwidth 
>>>>> streams)
>>>>>      and ROCgdb (wave control, address watch, async exceptions an
>>>>>      out of band channel that must not block display).
>>>>
>>>> virglrenderer does not impose a particular render model. That's why 
>>>> Vulkan Compute just works with Venus.
>>>
>>> Yes but vulkan is used for GFX initally. And can not support many AI 
>>> application.>
>>>>>    - Events, faults and GPU reset/SMI are async and don't map onto 
>>>>> fences.>    - All of this is hard to extend cleanly inside a 
>>>>> display capset.
>>>> Capset is not about display but determines the protocol of the 
>>>> VIRTIO_GPU_CMD_SUBMIT_3D command stream. You have described events, 
>>>> faults and GPU reset/SMI are async don't map onto fences that may be 
>>>> associated with VIRTIO_GPU_CMD_SUBMIT_3D which is dictated by 
>>>> capset. An additional feature may be necessary, and it may or may 
>>>> not be dictated by capset. The other things are irrelevant with the 
>>>> protocol capset represents; they are either behavioral or about 
>>>> different commands.
>>>
>>> A fence is the one shot, but event is stateful and repeatable.
>>> That may or may not be tied to capset. Agreed.
>>>
>>>>
>>>>>
>>>>> On the QEMU/host side, would something like this be OK? One step, 
>>>>> two parts:
>>>>>
>>>>>    - a dedicated headless virtio gpu instance for compute.
>>>>
>>>> A second device would isolate its virtqueues and device-wide
>>>> renderer_blocked state. That may be useful if measurements show that
>>>> these are the bottlenecks, but it is not yet clear that they are or 
>>>> that
>>>> a second device is the appropriate solution.
>>>>
>>>>>    - that instance served by a separate ROCm backend library loaded
>>>>>      in-process by QEMU.
>>>>
>>>> First, I think we need to establish why ROCm cannot or should not 
>>>> remain
>>>> in virglrenderer. The virglrenderer, Venus, and VCL maintainers are
>>>> likely better placed to advise on that boundary. Once the protocol
>>>> requirements and performance measurements are clear, we can assess the
>>>> appropriate QEMU integration.
>>>
>>> venus is borned for GFX.
>>> virCL not merged.
>>>
>>> To be clear, I'm not saying virglrenderer can't host a ROCm native 
>>> context it clearly can. My hesitation is more about fit and 
>>> direction: virglrenderer has grown up around GL/graphics, and I 
>>> haven't yet found compute oriented plumbing there to build on, while 
>>> ROCm moves very fast and I need something I can keep current with low 
>>> friction.
>>
>> Whether keeping ROCm in virglrenderer would create extra friction is 
>> primarily a question for the virglrenderer maintainers. Its graphics 
>> origins do not by themselves motivate adding a separate backend 
>> interface to QEMU.
> 
> Fair. The first draft version in virglrenderer was in May 2024, and ROCm 
> has gone 5.7 → 7.14 in that window.

One point to note is that virtio-gpu development in QEMU is somewhat
less active. crosvm is the most active user of virglrenderer, and QEMU
sometimes lags behind it. If you are considering moving the ROCm 
integration from virglrenderer to QEMU solely because ROCm evolves 
rapidly, I do not think that would be a good idea. A rapidly evolving 
component is better kept in virglrenderer unless there is another reason 
to place it in QEMU.

Regards,
Akihiko Odaki
