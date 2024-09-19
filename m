Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9C4199FB3
	for <virtualization@lists.linux.dev>; Thu, 19 Sep 2024 09:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736987; cv=none; b=akpibSNCa2FsxF4cl8TaRwORqCvPScKyyksOSliQnu13x2J/LYVAZ5Q+K/KvOxPDVLYGeOkIyXv/8uPWJo9m/id7+Foqb9rjKbufBH2gVUaLV2uSVrxf8YqCHWWUeLFA9gb3GCdxClKbmsP0d3fHZZvlUGIyswmtEq1xR1dyAwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736987; c=relaxed/simple;
	bh=GBKLk++RiHmSa+xZyLWzRzbv6vq/fyNaBroUnKPSjk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jfB09FR+oitNFa5j2p58akykpTX++c78ZFw8GN24R7MpsBE5Cyns2CGSvqPBppligtXxbVQb0ssw2pGI/IismER9VP74G8YOR4fxjgcQrmV3h+Td9QL8SKHPUt7L7i6OYUyDnpRlUM5EZO87zc9TmFlZOMoQvY+ru9QQN2rhNQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sf17iwn/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sf17iwn/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726736984;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Rq+cQaKr5fIzckPNU2eHYeEIwA9KA7YHqBru4Wf9Dtk=;
	b=Sf17iwn/9R8w9ccvf6to5kblgxZPl0fE6Lx01gRntNUWC95BEWbeiKB5St8c/z/fRg3QtD
	O0tSvnLFas61xes75d97wd8TGDYyyhGGtYbNZB1IU3TGR1c+uhl3gx5dlvr5+0pYBW9TBl
	8naJG/37ntAxaBgBtZGYfFJiT9ccdRI=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-1--L3pabMTusH-UggcPkeQ-1; Thu, 19 Sep 2024 05:09:43 -0400
X-MC-Unique: 1--L3pabMTusH-UggcPkeQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2f761c328f7so4848671fa.3
        for <virtualization@lists.linux.dev>; Thu, 19 Sep 2024 02:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726736981; x=1727341781;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rq+cQaKr5fIzckPNU2eHYeEIwA9KA7YHqBru4Wf9Dtk=;
        b=jkzNKrF/SNtNPVAWcAHcDjoQK1Z35mHPqzm1cYzD0JK+JdhFcTcQDPp4TMZH0fp0Nx
         wHfeZfWbh/qn6/v9vSjnuEurynRPsjXv0B3GyqkcGbyI9bIgsIEnV0NC6+5v7VPEsh4z
         05g2wAaRPKhHNTK0+JCAxP6rMbjEo2aRsyYiNauD8HWEMbRz9f1xR/kZ9FnLrO6hRSJW
         JaNTNkOnPhkIbzsXEbJINVjGvXb6C5lk825JHmk8GCeIHiIEDrOre0DuKF6TdTB10SI+
         AdqqFu1Jrqrr0fBvtVMuOnhnSwlTmh4cVbu4yMPqiix55xoyuzwJKF9eOJLGC04TZoN1
         kgmw==
X-Forwarded-Encrypted: i=1; AJvYcCXe/IeDKk7X5UdLJHILKU4gfMln2a7vP3/mgMUinHxCaQUoImi6SNhEYMTq89xjRZe2dW+LOgEjLSymkhlbkQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw64ogVHAdE8THny3dy7Rwo1rRcq8KbMnqwN8rD7B/1wAlpRVe/
	xa60h/3RcLe1uuuE6aKfmz+YROj5IHYUrFl8ewM+NSn3hmOakJH7CRP0ren0sd2PNPBAewCrsOH
	JMXnQ5vG6CNt2ftl/aeDBJ3Qwqow0LxiBF1Yu77swhO79aYVHaMzCnYgn71Mpjygu
X-Received: by 2002:a05:651c:556:b0:2f7:631a:6e0c with SMTP id 38308e7fff4ca-2f787f44858mr154067491fa.35.1726736981246;
        Thu, 19 Sep 2024 02:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXlhx0ZYFFILOr+eSVX9GqI1Pl9zIL3cezPHns3baIKNpd04+lYjHibY6nPvLGqLCFJFNyAw==
X-Received: by 2002:a05:651c:556:b0:2f7:631a:6e0c with SMTP id 38308e7fff4ca-2f787f44858mr154067231fa.35.1726736980672;
        Thu, 19 Sep 2024 02:09:40 -0700 (PDT)
Received: from [10.131.4.59] ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80dbsm14614968f8f.33.2024.09.19.02.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 02:09:40 -0700 (PDT)
Message-ID: <fc05d089-ce04-42d2-a0d7-ea32fd73fe90@redhat.com>
Date: Thu, 19 Sep 2024 11:09:40 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Ira Weiny <ira.weiny@intel.com>, John Groves <John@Groves.net>,
 virtualization@lists.linux.dev
Cc: Oscar Salvador <osalvador@suse.de>, qemu-devel@nongnu.org,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 linuxarm@huawei.com, wangkefeng.wang@huawei.com,
 John Groves <jgroves@micron.com>, Fan Ni <fan.ni@samsung.com>,
 Navneet Singh <navneet.singh@intel.com>,
 =?UTF-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240815172223.00001ca7@Huawei.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240815172223.00001ca7@Huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for the late reply ...

> Later on, some magic entity - let's call it an orchestrator, will tell the

In the virtio-mem world, that's usually something (admin/tool/whatever) 
in the hypervisor. What does it look like with CXL on bare metal?

> memory pool to provide memory to a given host. The host gets notified by
> the device of an 'offer' of specific memory extents and can accept it, after
> which it may start to make use of the provided memory extent.
> 
> Those address ranges may be shared across multiple hosts (in which case they
> are not for general use), or may be dedicated memory intended for use as
> normal RAM.
> 
> Whilst the granularity of DCD extents is allowed by the specification to be very
> fine (64 Bytes), in reality my expectation is no one will build general purpose
> memory pool devices with fine granularity.
 > > Memory hot-plug options (bare metal)
> ------------------------------------
> 
> By default, these extents will surface as either:
> 1) Normal memory hot-plugged into a NUMA node.
> 2) DAX - requiring applications to map that memory directly or use
>     a filesystem etc.
> 
> There are various ways to apply policy to this. One is to base the policy
> decision on a 'tag' that is associated with a set of DPA extents. That 'tag'
> is metadata that originates at the orchestrator. It's big enough to hold a
> UUID, so can convey whatever meaning is agreed by the orchestrator and the
> software running on each host.
> 
> Memory pools tend to want to guarantee, when the circumstances change
> (workload finishes etc), they can have the resources they allocated back.

Of course they want that guarantee. *insert usual unicorn example*

We can usually try hard, but "guarantee" is really a strong requirement 
that I am afraid we won't be able to give in many scenarios.

I'm sure CXL people were aware this is one of the basic issues of memory 
hotunplug (at least I kept telling them). If not, they didn't do their 
research properly or tried to ignore it.

> CXL brings polite ways of asking for the memory back and big hammers for
> when the host ignores things (which may well crash a naughty host).
> Reliable hot unplug of normal memory continues to be a challenge for memory
> that is 'normal' because not all its use / lifetime is tied to a particular
> application.

Yes. And crashing is worth than anything else. Rather shutdown/reboot 
the offending machine in a somewhat nice way instead of crashing it.

> 
> Application specific memory
> ---------------------------
> 
> The DAX path enables association of the memory with a single application
> by allowing that application to simply mmap appropriate /dev/daxX.Y
> That device optionally has an associated tag.
> 
> When the application closes or otherwise releases that memory we can
> guarantee to be able to recover the capacity.  Memory provided to an
> application this way will be referred to here as Application Specific Memory.
> This model also works for HBM or other 'better' memory that is reserved for
> specific use cases.
> 
> So the flow is something like:
> 1. Cloud orchestrator decides it's going to run in memory database A
>     on host W.
> 2. Memory appliance Z is told to 'offer' 1TB or memory to host W with
>     UUID / tag wwwwxxxxzzzz
> 3. Host W accepts that memory (why would it say no?) and creates a
>     DAX device for which the tag is discoverable.

Maybe there could be limitations (maximum addressable PFN?) where we 
would have to reject it? Not sure.

> 4. Orchestrator tells host W to launch the workload and that it
>     should use the memory provided with tag wwwwxxxxzzzz.
> 5. Host launches DB and tells it to use DAX device with tag wwwwxxxxzzzz
>     which the DB then mmap()s and loads it's database data into.
> ... sometime later....
> 6. Orchestrator tells host W to close that DB ad release the memory
>     allocated from the pool.
> 7. Host gives the memory back to the memory appliance which can then use
>     it to provide another host with the necessary memory.
> 
> This approach requires applications or at least memory allocation libraries to
> be modified.  The guarantees of getting the memory they asked for + that they
> will definitely be able to safely give the memory back when done, may make such
> software modifications worthwhile.
> 
> There are disadvantages and bloat issues if the 'wrong' amount of memory is
> allocated to the application. So these techniques only work when the
> orchestrator has the necessary information about the workload.

Yes.

> 
> Note that one specific example of application specific memory is virtual
> machines.  Just in this case the virtual machine is the application.
> Later on it may be useful to consider the example of the specific
> application in a VM being a nested virtual machine.
> 
> Shared Memory - closely related!
> --------------------------------
> 
> CXL enables a number of different types of memory sharing across multiple
> hosts:
> - Read only shared memory (suitable for apache arrow for example)
> - Hardware Coherent shared memory.
> - Software managed coherency.

Do we have any timeline when we will see real shared-memory devices? zVM 
supported shared segments between VMs for a couple of decades.

> 
> These surface using the same machinery as non shared DCD extents. Note however
> that the presentation, in terms of extents, to different host is not the same
> (can be different extents, in an unrelated order) but along with tags, shared
> extents have sufficient data to 'construct' a virtual address to HPA mapping
> that makes them look the same to aware  application or file systems.  Current
> proposed approach to this is to surface the extents via DAX and apply a
> filesystem approach to managing the data.
> https://lpc.events/event/18/contributions/1827/
> 
> These two types of memory pooling activity (shared memory, application specific
> memory) both require capacity associated with a tag to be presented to specific
> users in a fashion that is 'separate' from normal memory hot-plug.
> 
> The virtualization question
> ===========================
> 
> Having made the assumption that the models above are going to be used in
> practice, and that Linux will support them, the natural next step is to
> assume that applications designed against them are going to be used in virtual
> machines as well as on bare metal hosts.
> 
> The open question this RFC is aiming to start discussion around is how best to
> present them to the VM.  I want to get that discussion going early because
> some of the options I can see will require specification additions and / or
> significant PoC / development work to prove them out.  Before we go there,
> let us briefly consider other uses of pooled memory in VMs and how theuy
> aren't really relevant here.
> 
> Other virtualization uses of memory pool capacity
> -------------------------------------------------
> 
> 1. Part of static capacity of VM provided from a memory pool.
>     Can be presented as a NUMA setup, with HMAT etc providing performance data
>     relative to other memory the VM is using. Recovery of pooled capacity
>     requires shutting down or migrating the VM.
> 2. Coarse grained memory increases for 'normal' memory.
>     Can use memory hot-plug. Recovery of capacity likely to only be possible on
>     VM shutdown.

Is there are reason "movable" (ZONE_MOVABLE) is not an option, at least 
in some setups? If not, why?

> 
> Both these use cases are well covered by existing solutions so we can ignore
> them for the rest of this document.
> 
> Application specific or shared dynamic capacity - VM options.
> -------------------------------------------------------------
> 
> 1. Memory hot-plug - but with specific purpose memory flag set in EFI
>     memory map.  Current default policy is to bring those up as normal memory.
>     That policy can be adjusted via kernel option or Kconfig so they turn up
>     as DAX.  We 'could' augment the metadata with such hot-plugged memory
>     with the UID / tag from an underlying bare metal DAX device.
> 
> 2. Virtio-mem - It may be possible to fit this use case within an extended
>     virtio-mem.
> 
> 3. Emulate a CXL type 3 device.
> 
> 4. Other options?
> 
> Memory hotplug
> --------------
> 
> This is the heavy weight solution but should 'work' if we close a specification
> gap.  Granularity limitations are unlikely to be a big problem given anticipated
> CXL devices.
> 
> Today, the EFI memory map has an attribute EFI_MEMORY_SP, for "Specific Purpose
> Memory" intended to notify the operating system that it can use the memory as
> normal, but it is there for a specific use case and so might be wanted back at
> any point. This memory attribute can be provided in the memory map at boot
> time and if associated with EfiReservedMemoryType can be used to indicate a
> range of HPA Space where memory that is hot-plugged later should be treated as
> 'special'.
> 
> There isn't an obvious path to associate a particular range of hot plugged
> memory with a UID / tag.  I'd expect we'd need to add something to the ACPI
> specification to enable this.
> 
> Virtio-mem
> ----------
> 
> The design goals of virtio-mem [1] mean that it is not 'directly' applicable
> to this case, but could perhaps be adapted with the addition of meta data
> and DAX + guaranteed removal of explicit extents.

Maybe it could likely be extended, or one could built something similar 
that is better tailored to the "shared memory" use case.

> 
> [1] [virtio-mem: Paravirtualized Memory Hot(Un)Plug, David Hildenbrand and
> Martin Schulz, Vee'21]
> 
> Emulating a CXL Type 3 Device
> -----------------------------
> 
> Concerns raised about just emulating a CXL topology:
> * A CXL Type 3 device is pretty complex.
> * All we need is a tag + make it DAX, so surely this is too much?
> 
> Possible advantages
> * Kernel is exactly the same as that running on the host. No new drivers or
>    changes to existing drivers needed as what we are presenting is a possible
>    device topology - which may be much simpler that the host.
 > > Complexity:
> ***********
> 
> We don't emulate everything that can exist in physical topologies.
> - One emulated device per host CXL Fixed Memory Window
>    (I think we can't quite get away with just one in total due to BW/Latency
>     discovery)
> - Direct connect each emulated device to an emulate RP + Host Bridge.
> - Single CXL Fixed memory Window.  Never present interleave (that's a host
>    only problem).
> - Can probably always present a single extent per DAX region (if we don't
>    mind burning some GPA space to avoid fragmentation).

For "ordinary" hotplug virtio-mem provides real benefits over DIMMs. One 
thing to consider might be micro-vms where we want to emulate as little 
devices+infrastructure as possible.

So maybe looking into something paravirtualized that is more lightweight 
might make sense. Maybe not.

[...]

> Migration
> ---------
> 
> VM migration will either have to remove all extents, or appropriately
> prepopulate them prior to migration.  There are possible ways this
> may be done with the same memory pool contents via 'temporal' sharing,
> but in general this may bring additional complexity.
 > > Kexec etc etc will be similar to how we handle it on the host - 
probably
> just give all the capacity back.

kdump?

-- 
Cheers,

David / dhildenb

