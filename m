Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059A72F7AD2;
	Thu, 27 Aug 2026 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787830169; cv=none; b=GIliT4I7QkVt5ReBp6VfTnTZsz0sYJ5VSN/dcqCMTVcHR3DLjeCc85mN6oAE0TttLNMuWc7kEMFhXaVhH8c5Nq55FcUifW4a9CYrKOjsaNJ13BiPUii3cDdwlZ5eJ1d0ix1fvJdfXltnnmdPeDHNk08RWHxRpWqrUL1TtZl5bPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787830169; c=relaxed/simple;
	bh=UzLVCE0USUwFgPcRQvUNA0WrLO8yQI5v2E2NhqpPlWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5pby0vPt2LUT1UxYr2W7aMwshD3qogmknhG2GzCaekWE/cAiB/XQ4MPRTkE+q0pN5d2a7oy151lxT11LWU3jJ4TMm5drE8Df94fp79tC9dFK36NTiTyCfZJv8XgYIi3PcwBMK5jDDX5INJsKe7a+N+v+DMquTjXXo0j16vS2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrRC3ueL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrRC3ueL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C41F1F000E9;
	Thu, 27 Aug 2026 11:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787830166;
	bh=xeCezXT+fdicRh/I2V+IQNhaMWKU48C1cfcJ7s7KGYc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lrRC3ueLyhJ3LRaloBMYLclOIjbVXfyBIHRnUE0mLPM7vmtbyJvEXiRaj+esLmtFn
	 eprGIkPruSToMk0rv6vlJE2QvvTHFAeo1rX7TSYVFmRNkFglR6vfFYxwzgEqc8n6Xb
	 bwo/tlRMX2NWcVnn7WZ2sHA70Znc/H0z1n2uXmX0+VKWb4nCh6nFaAdvQpOw6JiIBr
	 xDipBitts4YcgjxV4Db72XMMrYszf2A4ZHyrFnRINp1Cvn8i0mwuXnPY4lmtFrg2zc
	 L8G4BpDiqoZHlIGWYYDC2vvtwenM4MOGwlWtGTKDO+sC6K2nKFvPu/dHzEjnip1zCb
	 dNXVfgouIeD+A==
Message-ID: <9c2b7a50-0128-4026-9033-f5c92216da07@kernel.org>
Date: Thu, 27 Aug 2026 13:29:19 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFCv2 PATCH 0/6] Support memory hotplug/unplug for TDX CoCo
 guests
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "kas@kernel.org" <kas@kernel.org>,
 "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "prsampat@amd.com" <prsampat@amd.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "Qiang, Chenyi" <chenyi.qiang@intel.com>,
 "Reshetova, Elena" <elena.reshetova@intel.com>,
 "michael.roth@amd.com" <michael.roth@amd.com>,
 "ackerleytng@google.com" <ackerleytng@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "x86@kernel.org" <x86@kernel.org>, "Xu, Yilun" <yilun.xu@intel.com>,
 "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
References: <20260623101739.79695-1-zhenzhong.duan@intel.com>
 <5921ace1-219d-4947-99d9-13b56e1ec6fa@kernel.org>
 <IA3PR11MB91365F3F771C43C4BA7E61B392AD2@IA3PR11MB9136.namprd11.prod.outlook.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <IA3PR11MB91365F3F771C43C4BA7E61B392AD2@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/27/26 10:18, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: David Hildenbrand (Arm) <david@kernel.org>
>> Subject: Re: [RFCv2 PATCH 0/6] Support memory hotplug/unplug for TDX CoCo
>> guests
>>
>> On 6/23/26 12:17, Zhenzhong Duan wrote:
>>> This RFCv2 series implements comprehensive support for virtio-mem and ACPI
>>> DIMM memory hotplug/unplug in Intel TDX confidential computing guests.
>>> It explores the start-private memory approach utilizing the native
>>> TDG.MEM.PAGE.RELEASE API.
>>>
>>> We are seeking feedback from Kiryl on the CoCo guest implementation, MM
>>> experts on DIMM & virio-mem memory hotplug integration and broader
>>> virtio/CoCo community input on the overall approach. We are not seeking
>>> x86 maintainer review at this stage.
>>>
>>> == Changes from RFC v1 ==
>>>
>>> - Eliminated callback infrastructure: Dropped plug callback and replaced
>>>   unplug callback with platform-level unaccept function into core MM
>>>   hotplug and virtio-mem subsystems.
>>> - Added comprehensive bitmap tracking: Introduced a "plugged" bitmap
>>>   alongside the unaccepted bitmap to track populated hotplug memory
>>>   states to support load_unaligned_zeropad().
>>> - Enhanced SRAT parsing: Extended the EFI stub to parse ACPI SRAT tables
>>>   early, ensuring hotpluggable ranges are tracked from initial boot.
>>>
>>> For more introduction about the background or other efforts in community,
>>> please check the RFCv1 cover letter [1].
>>>
>>> == Technical Approach ==
>>>
>>> - Early SRAT Integration: A lightweight EFI stub parser scans ACPI SRAT
>>>   tables to identify hotpluggable ranges and adjust bitmap boundaries
>>>   early, avoiding the overhead of the full ACPI subsystem.
>>> - Comprehensive Bitmap Tracking: Introduces a "plugged" bitmap right
>>>   after the unaccepted bitmap. Both static and hotplugged memory are
>>>   tracked, allowing the guest to map which ranges are populated by the
>>>   VMM. This prevents acceptance beyond plugged memory boundaries due to
>>>   load_unaligned_zeropad() operations.
>>> - Platform Extensibility: Exposes generic CoCo memory interfaces. Other
>>>   confidential platforms (like AMD SEV-SNP) can easily adopt this by
>>>   hooking their specific mechanisms into arch_unaccept_memory().
>>> - Hotplug & Guest Control: Integrates platform-level unaccept logic
>>>   into ACPI hotplug and virtio-mem handlers. Uses TDG.MEM.PAGE.RELEASE
>>>   for TDX to explicitly set memory to the "unaccepted" state during
>>>   unplug, removing host hole-punching dependencies.
>>> - Kexec Handover: Leverages existing EFI mechanisms to seamlessly hand
>>>   over both the extended unaccepted bitmap and the new plugged bitmap
>>>   across kexec boundaries.
>>>
>>> == Testing ==
>>>
>>> - dimm and virtio-mem memory hotplug/unplug
>>> - lazy and eager accept
>>> - kexec/kdump with hotplugged memory
>>>
>>> This is tested with Marc-André Lureau's newest qemu series [2]
>>
>> What's the status of this?
> 
> Marc's QEMU series is merged.
> For this series, following feedback from Kirill and Pratik, the preferred approach
> is updating the UEFI spec for hotplug memory ranges rather than parsing SRAT
> at the EFI stage. Pratik is already pushing this forward, I am currently waiting on
> his RFCs. If he hasn't taken over the entire implementation, I can rebase my
> remaining patches on top of his work.
> 
> Hi Pratik, have you sent your UEFI RFC out yet? Just wanted to make sure
> I didn't miss your thread.
> 
>>
>> I am still not sure whether we shouldn't perform acceptance from
>> move_pfn_range_to_zone() and from memory notifiers / generic_online_page.
> 
> My understanding is that we already have full support for lazy and eager acceptance
> in generic_online_page() for static memory. We should be able to reuse that for
> hotplug memory and avoid adding acceptance logic in other places.
> 
> All we need is extending unaccept_bitmap and adding new plugged_bitmap to support
> hotplug memory. I updated accept_memory() to check both bitmaps to determine
> which memory should be accepted.

The plugged bitmap is a very odd beast. I hate it, but I can see why it might
currently be required. I wonder if there is a better name for it because

	"plugged"

is an overloaded term. What are the real semantics we want to express?

IIUC, unplug for virtio-mem requires prior conversion to shared memory. We
should have an intuitive mechanism for virtio-mem to just do the right thing
when unplugging memory (IOW, preparing for handback to the hypervisor).

> 
>>
>> In particular, it's unclear to me how virtio-mem (which uses interfaces to
>> add/remove memory) interacts with unaccept_memory / coco bitmap.
> 
> It works the same way as a physical DIMM: when memory is plugged, the
> corresponding bits in plugged_bitmap are set, and vice versa.

Well, no. When adding a Linux memory block through add_memory_resource() you do
coco_set_plugged_bitmap(). And in virtio_mem_send_plug_request() you do
coco_set_plugged_bitmap().

That's just super inconsistent and messy.


(coco_set_plugged_bitmap() and memory acceptance should *definitely not* be
open-coded like that in virtio_mem. There must be a clear abstraction layer with
clear, well documented semantics that virito-mem can iuse)


> 
> Memory acceptance is already handled in generic_online_page(), so we 
> do not need to do it inside virtio-mem. However, we do need to call
> unaccept_memory() during a memory unplug event in virtio-mem.

Again, I think we really need an abstraction that can just naturally be extended
for platforms that have to perform some work when returning memory to the
hypervisor. Open-coding x86's unaccept_memory() is not the way to go.

> 
> Currently, tdx_unaccept_memory() can act as a no-op since QEMU handles 
> hole-punching the private memory. That said, we still need to invoke 
> unaccept_memory() to properly update the unaccept_bitmap bits.
> 
>>
>> Can we have an overall design view on what happens at which stage when adding
>> /
>> removing memory through virtio-mem?
> 
> I have put together a design view summary for virtio-mem below.
> Please let me know if this looks correct or if we should adjust the framing.
> 
> Design Overview
> ---------------
> We maintain system stability and state safety using two metadata tracking
> layers during dynamic memory resizing operations:
> 1. plugged_bitmap: Explicitly tracks blocks plugged into the guest.
>    This protects load_unaligned_zeropad() from reading omitted memory
>    holes, preventing catastrophic guest crashes.

I hate load_unaligned_zeropad() so much at this point. We should finally rip it
out. I wish I would have more spare time to look into that.

The plugged bitmap is a clear sign that load_unaligned_zeropad() just has to go
instead of us hacking around it.

> 2. unaccept_bitmap: Explicitly tracks the secure page initialization state.

I didn't fully grasp the level of hackery we have to apply to make
load_unaligned_zeropad() not do stupid things.

Am I correct that we have to accept more memory, possibly falling into unplugged
virtio-mem ranges? What is the effect of that?

> 
> Step-by-Step Lifecycle Stages
> -----------------------------
> Using sub-block hotplug of a new memory block with eager acceptance
> as an example:
> 
> 1. Memory Addition (Plug) Stage
>    a. Host notifies guest -> virtio-mem driver handles the plug event.
>    b. Driver marks the allocated memory ranges in 'plugged_bitmap' by
>       calling coco_set_plugged_bitmap(addr, size, true). During this stage,
>       a plug request is also sent to the VMM.
>    c. Driver adds memory blocks via add_memory_resource().

Assume you hotplug a single device block (e.g., 2M). virtio-mem will set the
plugged bitmap of that one block. But add_memory_resource() will set the plugged
bitmap of the entire Linux memory block.

That seems completely broken?


-- 
Cheers,

David
