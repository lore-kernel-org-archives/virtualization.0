Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21A7282F06
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777575014; cv=none; b=dlS2ErxscVr46Vq63bIxnymCqpWK6ocrbNLjPbvQ+fuWKCBYE/N2kmLrNPER99hVXHCrf1beqzrb3iEytb9+WVNgGJB0a8sk/HBqdEMzKXucZDx41xNAJQJW3LmNSAua2x1FwIrEAGcZKDSANStqKYFgVxh+YaPDvIaxwX6SY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777575014; c=relaxed/simple;
	bh=WtobduLOS6TjAXp0bMctU+axRtnCk+aSW1NSZ8Ca5q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSPZGYs0sUPCjAXXwLHlz1ckopI+1JyuPnMHVJNZafBCRZrDNPulhc1wLGlQ9O+eMenADRHjVfjhvFoNfx7ENfpDR/s1vP3RNPIW66AZQrNvwmk6R2ifmY9rWxoMBhW0X1VkaTYChbp72KfWQIDvCuAtgpp2dtwY5dgETEhNs2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=hADA0zpE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mTsfiq2A; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="hADA0zpE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mTsfiq2A"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E99AEC0099;
	Thu, 30 Apr 2026 14:50:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Apr 2026 14:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777575011; x=1777661411; bh=31eKb1GPyw
	vbkiPuzXzAtZKxLoCKEG3Ll7hcfm5Uv+w=; b=hADA0zpE2YoZUJI7J58ncoiAEz
	gdCloXPZ7RkXVRAYdsE61vycEs4dqhDKW/S2KaQi/TC2lVQ5NJcfCf+Jb3JZ7I6K
	KQZU3K5Jm4n7U7tBE39TE6A+GBc0Yp/n/9U3qqDfgpjMnOiA5ZL6GQiA/8NThSYC
	9qVTk69L7Vtlq8D/AS+ylouDUxdMXOcTnsGNI+q3RPUslU6Cnz4Y0+lpCB7+yl6V
	W/sAfTGEiLsZdtBd6q8H6phv2DTOcwYSBMRI/lIXyieOrv/3Ffnd43XIEDpPyC0U
	WJmELkWGgyyX6Cvk9XrkXVe4SdN9ZbbQGVWNhqLi2aOsTrVe2ghX8O2XKiCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777575011; x=
	1777661411; bh=31eKb1GPywvbkiPuzXzAtZKxLoCKEG3Ll7hcfm5Uv+w=; b=m
	Tsfiq2AL7mY211mEcqEwT+2vwIJQ/HtQBCYVB4lFqkTT0d5FkMJdK5hcB0MiYyga
	640m+ufFgor2QVRAdNMK2dfS/7jyQOC5hJ4EP4tvM4OAz0cpJw9H8sFnEXwr2VsY
	zfXJUNo0jQp5X1qUkAc7Yy5li18i1ar4U+Ma+h3C2p/ix0KmthnZseZBJek0ZRpQ
	sh0MlJqew3GseGrzwd8f2hhGCO2qECUZ+WLEgYGJLFvE/NjdrRSalw1N7cEo3WJl
	zTOZLZHPXdgXd1zffpUM1/jaCzLohLqWLw4VYbV+wST5YuDMFtMm6Woz8e2T2kkQ
	cvP2phYFH3eEuanoOECMw==
X-ME-Sender: <xms:YqTzaXUBYHSSjmi8ehtPFkUTVDvanc1C2xM37cO0KpOSZsjGTDIFsg>
    <xme:YqTzaXzNfV71ll1jNbA0kR1JToKSLZ6l1Q1vBrvbyPgtnnEzVJeBB5nBAc5Xmluio
    -A-hKPg0U7wMYVhWCbdP2lUf25B4-poMgQ61dIa321KeyQrF4c>
X-ME-Received: <xmr:YqTzae-n-MFPEMn9IbUCMBtHYzzXufuFMkZD2HWINpaa5ecTV144WWPOkNf0o8kKAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekkedtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepgggrlhcurfgr
    tghkvghtthcuoehvrghlsehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqne
    cuggftrfgrthhtvghrnhepheekgfefveetkeethffhgeeivdffkeegueevkeefveeltefg
    leehffegudegkedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehvrghlsehinhhvihhsihgs
    lhgvthhhihhnghhslhgrsgdrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgepsh
    hmthhpohhuthdprhgtphhtthhopehtvgguugihrdgrshhtihgvsehvrghtvghsrdhtvggt
    hhdprhgtphhtthhopehmshhtsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjrghsoh
    ifrghnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepgihurghniihhuhhosehlihhn
    uhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepvghpvghrvgiimhgrsehrvgguhh
    grthdrtghomhdprhgtphhtthhopehmrghrmhgrrhgvkhesihhnvhhishhisghlvghthhhi
    nhhgshhlrggsrdgtohhmpdhrtghpthhtohepvhhirhgvshhhrdhkuhhmrghrsehlihhnrg
    hrohdrohhrghdprhgtphhtthhopeigvghnqdguvghvvghlsehlihhsthhsrdigvghnphhr
    ohhjvggtthdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YqTzac_AjHKvXA36zYPO7mpL7WCtVF8h4yrJV5k80i1B6YRAfJBLGQ>
    <xmx:YqTzadVVSnPGgTuGP7zuMk5_cAFf1Oep4Kw18Ky65JiSYPb-yxPaJw>
    <xmx:YqTzaZe8BK1-pNUhq2QALHn9BNbvD3wih_hIqonJZlII6H7hnYNMqg>
    <xmx:YqTzaWYRc4mwkSgPJVwFLhtit2XC2b2KD0HFEpCJ9kSH-XYkLXxd3w>
    <xmx:Y6Tzad-W9K1K9gMyTK8AWY_EOa3OxDxN6FHYxEHlm-m6gSs5rnrayJDO>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 14:50:08 -0400 (EDT)
Message-ID: <b3cfed78-15db-459a-9f69-155ea615ecf8@invisiblethingslab.com>
Date: Thu, 30 Apr 2026 15:50:05 -0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] virtio-mmio: add xenbus probing
To: Teddy Astie <teddy.astie@vates.tech>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
Cc: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20260429141339.74472-1-val@invisiblethingslab.com>
 <1777473712.8631fc262581453bbf619ec5b2062170.19dd9b07146000f373@vates.tech>
 <fd6493ac-9d3e-475a-a844-6e53b0472820@invisiblethingslab.com>
 <1777536698.8631fc262581453bbf619ec5b2062170.19ddd7187da000f373@vates.tech>
 <74953b6a-d195-4a12-800d-af324ff35b29@invisiblethingslab.com>
 <1777556830.8631fc262581453bbf619ec5b2062170.19ddea4b728000f373@vates.tech>
Content-Language: en-US
From: Val Packett <val@invisiblethingslab.com>
Autocrypt: addr=val@invisiblethingslab.com; keydata=
 xm8EaFTEiRMFK4EEACIDAwQ+qzawvLuE95iu+QkRqp8P9z6XvFopWtYOaEnYf/nE8KWCnsCD
 jz82tdbKBpmVOdR6ViLD9tzHvaZ1NqZ9mbrszMXq09VfefoCfZp8jnA2yCT8Y4ykmv6902Ne
 NnlkVwrNKFZhbCBQYWNrZXR0IDx2YWxAaW52aXNpYmxldGhpbmdzbGFiLmNvbT7CswQTEwkA
 OxYhBAFMrro+oMGIFPc7Uc87uZxqzalRBQJoVMSJAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMB
 Ah4HAheAAAoJEM87uZxqzalRlIIBf0cujzfSLhvib9iY8LBh8Tirgypm+hJHoY563xhP0YRS
 pmqZ6goIuSGpEKcW5mV3egF/TLLAOjsfroWae4giImTVOJvLOsUycxAP4O5b1Qiy+cCGsHKA
 nCRzrvqnPkyf4OeRznMEaFTEiRIFK4EEACIDAwSffe3tlMmmg3eKVp7SJ+CNZLN0M5qzHSCV
 dBBkIVvEJo+8SDg4jrx/832rxpvMCz2+x7+OHaeBHKafhOWUccYBLKqV/3nBftxCkbzXDbfY
 d02BY9H4wBIn0Y3GnwoIXRgDAQkJwpgEGBMJACAWIQQBTK66PqDBiBT3O1HPO7mcas2pUQUC
 aFTEiQIbDAAKCRDPO7mcas2pUaptAX9f7yUJLGU4C6XjMJvXd8Sz6cGTyxkngPtUyFiNqtad
 /GXBi3vHKYNfSrdqJ8wmZ8MBgOqWaaa1wE4/3qZU8d4RNR8mF7O40WYK/wdf1ycq1uGad8PN
 UDOwAqdfvuF3w8QMPw==
In-Reply-To: <1777556830.8631fc262581453bbf619ec5b2062170.19ddea4b728000f373@vates.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/30/26 10:47 AM, Teddy Astie wrote:
> Le 30/04/2026 à 10:51, Val Packett a écrit :
>> On 4/30/26 5:11 AM, Teddy Astie wrote:
>>> Le 30/04/2026 à 06:06, Val Packett a écrit :
>>>> [..]
>>>>>> I'd like to get some early feedback for this patch, particularly
>>>>>> the general stuff:
>>>>>>
>>>>>> * is this whole thing acceptable in general?
>>>>>> * should it be extracted into a different file?
>>>>>> * (from the Xen side) any input on the xenstore keys, what goes where?
>>>>>> * anything else to keep in mind?
>>>>>>
>>>>>> It does seem simple enough, so hopefully this can be done?
>>>>>>
>>>>>> The corresponding userspace-side WIP is available at:
>>>>>> https://github.com/QubesOS/xen-vhost-frontend
>>>>>>
>>>>>> And the required DMOP for firing the evtchn events will be sent
>>>>>> to xen-devel shortly as well.
>>>>> Could that be done through evtchn_send (or its userland counterpart) ?
>>>> Actually, yes… The use of DMOPs is only dictated by the current Linux
>>>> privcmd.c code (the irqfds created by the kernel react to events by
>>>> executing HYPERVISOR_dm_op with a stored operation), we can avoid the
>>>> need to modify Xen by simply expanding the privcmd driver to make
>>>> "evtchn fds". Sounds good, will do.
>>>>
>>> Given that the event channel used by device models is exposed through
>>> ioreq.vp_eport ("evtchn for notifications to/from device model"). I
>>> don't think you need to expand the privcmd interface, and you should be
>>> able to do this instead :
>>>
>>> open /dev/xen/evtchn
>>> perform IOCTL_EVTCHN_BIND_INTERDOMAIN (for each guest vCPU)
>>>      with remote_domain=guest_domid, remote_port=ioreq.vp_eport
>>>
>>> Then interact with the event channel through IOCTL_EVTCHN_NOTIFY (with
>>> local port given by IOCTL_EVTCHN_BIND_INTERDOMAIN) and read/write on the
>>> file descriptor.
>> So the reason there's currently an ioctl to bind an eventfd to fire a
>> stored DMOP is that the whole idea is to (efficiently!) support generic,
>> hypervisor-neutral device server implementations via the vhost-user
>> protocol.
>>
>> Now of course, the current implementation isn't *entirely* hypervisor-
>> neutral as e.g. the vm-memory Rust crate (inside of the "neutral" vhost-
>> user device servers) does need to be built with the `xen` feature. But
>> still, that's how it works. What can be made generic is generic.
>>
>> xen-vhost-frontend, which is the thing that integrates these with Xen,
>> actually used to handle the interrupts in userspace[1] by firing the
>> DMOP itself (which is where I could "just replace that with
>> IOCTL_EVTCHN_NOTIFY") but that was offloaded to the kernel with the
>> introduction of IOCTL_PRIVCMD_IRQFD[2], similarly to KVM_IRQFD.
>>
> I think what would be preferable for your usecase would be to have a way
> to bind a event channel with a eventfd object, which should be a
> primitive that lives in the evtchn device.

Yeah, it would be an ioctl on the evtchn device, definitely. I wasn't 
being exact when I said "extend privcmd", sorry. I just meant "handling 
it on the Linux side" generally!

> The current interface kinda assume that you're looking to emulate a
> completely emulated virtio device with no Xen specifics, it looks like
> it's not exactly what you're implementing.
It's already implemented, and I'm not looking to change it much, just to 
make it work on x86_64. The only thing that wasn't already compatible 
was firing the host-to-guest interrupt, because on x86_64 we don't have 
anything like the (v)GIC with its massive arbitrary IRQ number space. 
Event channels are the only way to interrupt a PVH guest, hence using 
xenbus in the guest to provision the device.
> As you actually plan to switch to using event channels for notifying the
> guest, I think it would be preferable to do the same the other way
> (event channels to notify the host) so you only have event channels to
> worry about here.

The other direction is already implemented perfectly well in 
IOCTL_PRIVCMD_IOEVENTFD. The MMIO area is set up like so:

- ioreq is mapped with 
IOCTL_PRIVCMD_MMAP_RESOURCE(XENMEM_resource_ioreq_server, ..);
- vp_eport event channels (per cpu) are bound to the current domain via 
IOCTL_EVTCHN_BIND_INTERDOMAIN;
- those are passed, along with the ioreq page itself, to 
IOCTL_PRIVCMD_IOEVENTFD to get an eventfd that fires when a virtqueue is 
ready;
- which is an eventfd that xen-vhost-frontend passes to the vhost-user 
device server.

So for this direction, it's not a 1:1 mapping but rather a specific 
contraption designed to efficiently handle this use case:

- when an ioreq event channel (for any of the vcpus) fires,
- the kernel handler (ioeventfd_interrupt) checks if it's specifically 
an IOREQ_WRITE write to the VIRTIO_MMIO_QUEUE_NOTIFY offset,
- and if so, it signals the eventfd for any virtqueue that has new data 
(waking the generic device server which has the eventfd, so bypassing 
xen-vhost-frontend), pings the guest back via evtchn, and returns 
IRQ_HANDLED;
- otherwise the request is handled in userspace by xen-vhost-frontend 
(virtio configuration register access).

It just works :)

~val

