Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5653630BC
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 04:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777521699; cv=none; b=ar733Zs62IRq8O7rCld5WYListoNbC85ijmOPSl1GeMNKqYk+5E0H7Q/rKU0xYC2KtdYQk1ZHUuT75xpn8b2wpzXGx2AJCp3Q01JmxS3DRZeaBp5C0OCp7eOfpf9RHWC7fxHhTIwNiLGLvx7NQ5ImK+riOD9d9aillEDPL+Bu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777521699; c=relaxed/simple;
	bh=UqGlwYKQ99FA8XHTLASMfq9OyJsugGt5xoGIdkcFK0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZwXu2yS55XRME5vlwejo1CxaRM23eqtxiPBEstdfwoIAe5hfnwcHBc9bDh4b5CIOekdPxLeY/uWqKBssVbWzk8RfxHjK7Ya8wIbfBbEQBS+pZ3JO/1Wmn5qAmC/YACRcULP6l7EmOlE9sCZkUnbuUpTCgRUWukx7BZ/MPIvrBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=m+rIUvnR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QpLe9WRY; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="m+rIUvnR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QpLe9WRY"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 12B8FEC0047;
	Thu, 30 Apr 2026 00:01:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Apr 2026 00:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777521689; x=1777608089; bh=2ylbdgSEO3
	g7pTjq5Ngy4PvXfav/Y4wiIhm1YRccQLc=; b=m+rIUvnRjz9/8XoBRi1na6YL0m
	qtCPtZbQTvHnQiqB9jSXUAA6TwJjlOJoLdVvPYtEIusCCjyA6t4lBfi1O8NEM66A
	GZR30GH9ZetjhaPGYmY93MGqBUMeeNvezCjsuF5nsWiVt7EVDnCKamRQ3Nv2Jubf
	EqOGPGVH2tDZFdY9aq/X3Ljso7OAdhH0LQeDGjWGFA74kmOrd8l0e1eOMbnoV7FS
	kC4+NLoH/LnesKHXQSdGsoM2I1tjl/Dw3VFZKFEC2eJ+3Egts+B6vEjrOThm9Zga
	NvDPTK9d1lRDwFjU8+uVGJN4YUnJjUxk3JU/AB2XIWCuRI1Ft5jUAFkOFBWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777521689; x=
	1777608089; bh=2ylbdgSEO3g7pTjq5Ngy4PvXfav/Y4wiIhm1YRccQLc=; b=Q
	pLe9WRYowph1Kl4KLVOS5KSidJSLOTifNzNH/SP7law4UKeAIA+pmlUITiD32ot+
	jZYGLNVxwkO9br9gYnvnLafM60jLXm7OoPRHUosPcLlfsmnEmt+P3ywLDbMAtexQ
	KPCyXdSyrx7Kw7Xx+0ZJwO3MeoqCQI1abABbz1Z6c1c8rvOkEyk+Crk/815sgBfY
	vp4H+LZ0lJy26/nXVf73/iRFxZpqHjV8tgJOcMl+dy/E87rw+S3KVaRv+d6wyoua
	tESPlHtQCQHVIiIjPjvB9DLkhP1eUM57U6kWE8J4JK87ru0uin9u6n+1OpvHFA9f
	UENUGHSwFjHky+B/RctIQ==
X-ME-Sender: <xms:GNTyabX8PBPDfqwgBJY7ZPBDWRtlqfyzR1VU_l90N9jo6MNVknCAxw>
    <xme:GNTyabxHUKsyUArbro6Ihy9eXSDlLk1eeZ-7kYpfqkLECGeMCHyFvACmfHz0Dhmst
    7wWPMzqWb56I2GvsV8Um7bq2wgzt0otN8z96JHbjb1thfebfHg>
X-ME-Received: <xmr:GNTyaS81bMRlVmF02nYmg-sjCwKsTA64eyvXUqWaZhLEnfOLHlFlcM2A8P6YJCu5LA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekieefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepgggrlhcurfgr
    tghkvghtthcuoehvrghlsehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqne
    cuggftrfgrthhtvghrnhepjeehkeffhedvffeffffflefgfeejudejiefhtdeijeeuteei
    teejtdettdeuleevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    vhgrlhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsggprhgtphhtth
    hopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthgvugguhidrrghsthhi
    vgesvhgrthgvshdrthgvtghhpdhrtghpthhtohepmhhsthesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepjhgrshhofigrnhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhopeig
    uhgrnhiihhhuoheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopegvph
    gvrhgviihmrgesrhgvughhrghtrdgtohhmpdhrtghpthhtohepmhgrrhhmrghrvghksehi
    nhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomhdprhgtphhtthhopehvihhrvghshh
    drkhhumhgrrheslhhinhgrrhhordhorhhgpdhrtghpthhtohepgigvnhdquggvvhgvlhes
    lhhishhtshdrgigvnhhprhhojhgvtghtrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GNTyaQ9lpwWEvk7D3W8FOh-v8UFvy9LxD077RmK18-iGsxLBpoBz4A>
    <xmx:GNTyaRXFM_C8bISyB3i7LdjfauPLV9X3t-nWnjGRYfaWm68YS0Qwmg>
    <xmx:GNTyadeaXKWt2qxuCLhWVSLndggsuCTkf0mnZSRjDKLk7NNMj3f5jQ>
    <xmx:GNTyaaYyiptX3NkomcuJsJ32POBzihjItVqHl3XfHHuPE-wTrpR3KA>
    <xmx:GdTyaR_elsMaFCiS5kLMPtw1pVuxe2GZrjMOk0JwWSMBarSfnRE4KbXO>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 00:01:25 -0400 (EDT)
Message-ID: <fd6493ac-9d3e-475a-a844-6e53b0472820@invisiblethingslab.com>
Date: Thu, 30 Apr 2026 01:01:22 -0300
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
In-Reply-To: <1777473712.8631fc262581453bbf619ec5b2062170.19dd9b07146000f373@vates.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/29/26 11:41 AM, Teddy Astie wrote:
> Hello,
>
> Le 29/04/2026 à 16:18, Val Packett a écrit :
>> […]
>>
>> I've been working on porting virtio-mmio support from Arm to x86_64,
>> with the goal of running vhost-user-gpu to power Wayland/GPU integration
>> for Qubes OS. (I'm aware of various proposals for alternative virtio
>> transports but virtio-mmio seems to be the only one that *is* upstream
>> already and just Works..) Setting up virtio-mmio through xenbus, initially
>> motivated just by event channels being the only real way to get interrupts
>> working on HVM, turned out to generally be quite pleasant and nice :)
> Is it HVM specific, or can we also make it work for PVH (we can actually
> attach a ioreq server to PVH guests) ?

Sorry, typo, I did mean PVH of course!

I've been testing this with PVH guests + PV dom0, with my PV alloc_ioreq 
fix:
https://lore.kernel.org/all/20251126062124.117425-1-val@invisiblethingslab.com/ 


(Time to resend that one as a non-RFC I guess…)

HVM actually does have legacy ISA interrupts (which are often used with 
virtio-mmio on KVM), funnily enough, and I've tried firing those from a 
DMOP but that silly thing didn't work properly.

>> I'd like to get some early feedback for this patch, particularly
>> the general stuff:
>>
>> * is this whole thing acceptable in general?
>> * should it be extracted into a different file?
>> * (from the Xen side) any input on the xenstore keys, what goes where?
>> * anything else to keep in mind?
>>
>> It does seem simple enough, so hopefully this can be done?
>>
>> The corresponding userspace-side WIP is available at:
>> https://github.com/QubesOS/xen-vhost-frontend
>>
>> And the required DMOP for firing the evtchn events will be sent
>> to xen-devel shortly as well.
> Could that be done through evtchn_send (or its userland counterpart) ?

Actually, yes… The use of DMOPs is only dictated by the current Linux 
privcmd.c code (the irqfds created by the kernel react to events by 
executing HYPERVISOR_dm_op with a stored operation), we can avoid the 
need to modify Xen by simply expanding the privcmd driver to make 
"evtchn fds". Sounds good, will do.

>> [..]
>>
>> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
>> index ce5bc0d9ea28..56bc2b10526b 100644
>> --- a/drivers/virtio/Kconfig
>> +++ b/drivers/virtio/Kconfig
>> @@ -171,6 +171,13 @@ config VIRTIO_MMIO_CMDLINE_DEVICES
>>    
>>    	 If unsure, say 'N'.
>>    
>> +config VIRTIO_MMIO_XENBUS
>> +	bool "Memory mapped virtio devices parameter parsing"
> that text seems to miss the xenbus aspect
Yep, didn't change that yet, ack
>> [..]
> In some way, we're defining a new "PV driver" which is a virtio-mmio
> one, I guess we can eventually specific some form of protocol that
> backend/frontend would need to follow ?

Right, Jürgen mentioned documenting the keys in the xenstore-paths doc.. 
would the entire "protocol" (keys + state transition logic) fit into that?

The keys are currently derived from the initial Arm prototype which 
wasn't actually using xenbus properly (the guest driver was configured 
by a device tree node, but the ioreq server used xenstore keys, without 
properly transitioning between states).


Thanks,
~val

