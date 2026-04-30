Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF877279917
	for <virtualization@lists.linux.dev>; Thu, 30 Apr 2026 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777521900; cv=none; b=ptNgg66j27aUgg0FpZFmChrKUDHgjIwwN5CbyrrfMwBn9QCT9p8tDGOpP7hmPKbKCah7mylpkrFvYrOuDvlWjF+7WGR6D/IZhJkBPFSlSjyaERmchPBhmLcSh9qZH0fnfQpM/TBl/PriqCcaaFXgb+krVQN7Y34BpQdXdVkMKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777521900; c=relaxed/simple;
	bh=NJdNkxLXulJ1IHUIIonHMmU+R++lYEefoBrZtKQIBKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8PH2HQznx44uNKv8/DZDZYRJ41p6Oosn7Gjtgy2fmFTadBzPEp5pZdqZGQ42qYG4Rqj5I8n/WvbvprGnYR5KSipjf7Ax8dVL9BG8gUDCaGwzgiYVhNNLnv/5ENA0XcKbkDNlxwpkFFT8TTETu0zawxz1XHFjhjtNaiQT33VOSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=JyCWiLaE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OaD/azlC; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="JyCWiLaE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OaD/azlC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B7BFEC007C;
	Thu, 30 Apr 2026 00:04:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 30 Apr 2026 00:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777521898; x=1777608298; bh=iL9Jih/Ibg
	bma67bqFqcCfMBsbo2+Snn9M19XNZspzs=; b=JyCWiLaEgzIHYgINBaGye7XqFD
	OYZ7C1lh8SiRT5+BRculK1vq6aO1YS966FiE0Vj554g1+kdcyjpeHxBvmxAl+CgA
	WM2Z54FDy3bfTVXAXNEATkm9wiMj5sOuce8FBZ6l9LbqHg2UQXzw1nB0dEDSkLGx
	F+Qhg0ss+IPYuaw35dKmfy3H26kH2o79O9nTRs/Kqq+dyZDYb+qcE09FO5QxsGZP
	ss11EITd4UU3/1epImcHEl0Y1iTi1rYNsezxGLJFuzQQUyuMZJfp0nEEpzEYMsCh
	J26tT8N9ZubB3EXMHojLQ7SOFfcEAWMnFFhERjmvpPEMb05gxiVClFKdZGiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777521898; x=
	1777608298; bh=iL9Jih/Ibgbma67bqFqcCfMBsbo2+Snn9M19XNZspzs=; b=O
	aD/azlC6c6H+mOtUakvf+EJmEZdD0ueW08mGxLkGEKn7iZqtKmWPxJBqEo/J8FBR
	lnESHM7xVB3IdWiaERcKmzrZ+aAwW8fT8DBYaYt2Www1gXE4vfopqQ3pp3EiKqoO
	+XGE6NtYyirL4wsrxnUMLn/E0JHGWpDqFAeRGtHlP5NsF+62/tuaLUAU9V5MiNFz
	P2+cbP9gIQY0C6eupKNVV0Vk9kLk0FUJTxH/X12AsHo/KGTGrPUDOFqujp/TsJtS
	UMDssK7f7YEmaVgts/rsL+PTLLEZTVK/O+/krfP8aXCaIVVKgJ0zuFmyoj1dc8wb
	6/pR4+XrPnTKfbJ79mDqA==
X-ME-Sender: <xms:6dTyaRiisW2jVl819D-fkqKk140bCT8pr7be5W4dPF6e-t-lfdbT7g>
    <xme:6dTyaVtW3hOA5uvDpw9roBf34aPhMs1_5iNwkAY9iFvHK9GQ6jBC45CQShhNt2k-i
    WhCNrTvdKakt0kiD7lrjPQG5nIfTAIkSeuODIB2ZcZEVX1s6g>
X-ME-Received: <xmr:6dTyacsMnR-RohTB2z3Igyxpab0NlxM3D5DKIiqnu12ky8Xts097ooIjIoUS1XtcYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekieefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepgggrlhcurfgr
    tghkvghtthcuoehvrghlsehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqne
    cuggftrfgrthhtvghrnhepjeduffejgeduleeklefhvedttdeuvdeuueeuhfevgfevjefg
    leevvdduhfdugfefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepvhgrlhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhnsggp
    rhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhgrhhosh
    hssehsuhhsvgdrtghomhdprhgtphhtthhopehmshhtsehrvgguhhgrthdrtghomhdprhgt
    phhtthhopehjrghsohifrghnghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepgihurg
    hniihhuhhosehlihhnuhigrdgrlhhisggrsggrrdgtohhmpdhrtghpthhtohepvghpvghr
    vgiimhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmpdhrtghpthhtohepvhhirhgvshhhrdhk
    uhhmrghrsehlihhnrghrohdrohhrghdprhgtphhtthhopeigvghnqdguvghvvghlsehlih
    hsthhsrdigvghnphhrohhjvggtthdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6dTyaSEYz1t3xvR8pfIguk8nQAhJj9YwTJMG3VDlnZ6v-kZcPIOT1w>
    <xmx:6dTyafO-K_qJOvef6JXVdpErpTtjay32BBTthQqX6yykEuILUDbAVQ>
    <xmx:6dTyaZK6_WOlkR-odxM6SH-y-9suq1J9e3MUp5GD-TsCGEfa14r8Kw>
    <xmx:6dTyaQ8HceBUcNi0PgnrIBqro1h3kDFB16VxRVsdBSTGRsSPdXMD2Q>
    <xmx:6tTyaQMbUIhLHFG1eCcCNe3bLz0fu_5aAi40MhVcvesPHVvR_GlJSV87>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Apr 2026 00:04:55 -0400 (EDT)
Message-ID: <98f95a70-7a28-463d-9bfe-203f6f740c21@invisiblethingslab.com>
Date: Thu, 30 Apr 2026 01:04:54 -0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] virtio-mmio: add xenbus probing
To: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
Cc: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
 <marmarek@invisiblethingslab.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20260429141339.74472-1-val@invisiblethingslab.com>
 <67632532-8421-4a10-a961-f7c4f05b177b@suse.com>
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
In-Reply-To: <67632532-8421-4a10-a961-f7c4f05b177b@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/29/26 12:35 PM, Jürgen Groß wrote:
> Some minor details from the Xen side of things:
>
> On 29.04.26 15:52, Val Packett wrote:
>> The experimental virtio-mmio support for Xen was initially developed
>> on aarch64, so device trees were used to configure the mmio devices,
>> with arbitrary vGIC interrupts used by the hypervisor. On x86_64
>> however, the only reasonable way to interrupt the guest is over Xen
>> event channels, which can only be acquired by children of xenbus,
>
> More exact: interdomain event channels need to be connected to a xenbus
> device. But you are needing those, so for your use case the above 
> statement
> is correct.
>
>> the virtual bus driven by Xen's configuration database, XenStore.
>> It is also a more convenient and "Xen-ish" way to provision devices.
>>
>> Implement a xenbus client for virtio-mmio which negotiates an
>> event channel and provides it as a platform IRQ to the
>> virtio-mmio driver.
>>
>>
>> Signed-off-by: Val Packett <val@invisiblethingslab.com>
>> ---
>>
>> Hi,
>>
>> I've been working on porting virtio-mmio support from Arm to x86_64,
>> with the goal of running vhost-user-gpu to power Wayland/GPU integration
>> for Qubes OS. (I'm aware of various proposals for alternative virtio
>> transports but virtio-mmio seems to be the only one that *is* upstream
>> already and just Works..) Setting up virtio-mmio through xenbus, 
>> initially
>> motivated just by event channels being the only real way to get 
>> interrupts
>> working on HVM, turned out to generally be quite pleasant and nice :)
>>
>> I'd like to get some early feedback for this patch, particularly
>> the general stuff:
>>
>> * is this whole thing acceptable in general?
>> * should it be extracted into a different file?
>> * (from the Xen side) any input on the xenstore keys, what goes where?
>
> You should add some documentation in the Xen source tree regarding the
> Xenstore keys (see docs/misc/xenstore-paths.pandoc there).
Ack, thanks!
>> […]
>>
>> +again:
>> +    err = xenbus_transaction_start(&xbt);
>
> No need to use a Xenstore transaction here. The written node(s) are
> regarded to be valid only after calling xenbus_switch_state() to set
> the frontend state to XenbusStateInitialised.
Oh, I assumed transactions were required for writing from the kernel to 
work at all…
>> [..]
>>
>> +static const struct xenbus_device_id virtio_mmio_xen_ids[] = {
>> +    { "virtio" },
>
> Please use "virtio-mmio" here, as I could imagine "virtio-pci" 
> devices, too. 

Ack. Would actually also distinguish it from the initial Arm 
proof-of-concept version…


Thanks,
~val

