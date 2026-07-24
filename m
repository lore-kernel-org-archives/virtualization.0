Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D96F8003D
	for <virtualization@lists.linux.dev>; Fri, 24 Jul 2026 01:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784855797; cv=none; b=hRaGWTWYv+y2msXlvBQtVnnKS9GrCgWDSDSJMQEwF5W/rmqcxBUezxd1mxmoSWe6rNXppB8cL0aMZUAFc6WWYIq6btja7BhwqeJh4s3/V+6XHp80YZyOoSQtijujf8d9XWgZ+n0MzdqujFh1C3j83n86uGAaQUVhcacPybdHTCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784855797; c=relaxed/simple;
	bh=wJzD9QvTCglgx3fR3MrpGanUghvfUXMDCYIwZaPGglw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NJ4xoKZQN2fHU1Yy+rpjxDXSc9B5L92+kqdXvH4oUK/WMQdgnQexFuxEEs56MCAB89nNHFwm8GvlKNXEUFnGVH8rCtZYMWoS3j2JNR1KvknmjFK8g07kjEfCUkOH7LR/aHII4YZsIkkUlVWLDtmdQrZ7Qor6GtkWsHu0z+pmDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgRrD6EE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgRrD6EE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ceae1ed204so13104855ad.0
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 18:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784855796; x=1785460596; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+P68SGyEkXyuPtnYKgNRn5xkOTG48cqiZ8JIO+6h7/0=;
        b=fgRrD6EEXbAPGPJEqjo26Q1D6UU40EPIiwflcswprZDSSLCiZtan3qaQXo8rZ3w0H4
         BJAtUOh9eV+LP+kkXaJpxZ9VWBeGnPIPgu2QuesAALb13nagL1+5lJnTzLWpXFuoHPdU
         uQQpTwyNiHGUSRUbc4oWHqRHGm2Ql4jM3GWEmMtcAn704zZuRDTki4v6Qt6fkHZi1YQi
         sYZaXf/dJVnN2L4+lP91+o2pRPzkfH8CnV32blAg9C28mfl9WQ/ZGOn70wZZm56jKfqw
         8uhmVYrbwgsB43UexYpBvKcsl72p0kCDZAgDhExPcHlIdUHha/DI3A69Ee8eh7+gHKxg
         /4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784855796; x=1785460596;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+P68SGyEkXyuPtnYKgNRn5xkOTG48cqiZ8JIO+6h7/0=;
        b=J1tEkN8lVHiFhBMCpfY2jKsbwGydgH/s3kVDeRMVvPLymbeUWlPwXJGjL6B96XbjZj
         YIW34B8Dj1AZqFEqlr1N0MJdeqKuW/X7m1XflMvofmzwu3hwp20M0doSJeBw2xEoq4Nd
         /9e70gn4jRww1Jk1WvTki/B0FrePv3EuXe/1ARl/EHqm4yutsLFUbHboeBIsT1M+CI5D
         BIDYDThHVYXC9iLRVbgzXtSoAVnjtZ+iE3FxNDxcye2h6QwQf0QnJzl98g7Lv/RN4u0P
         4Bpac+c9ZBK4cpvfAtEYz27dYXRMFhhZEe9eFZxJfcm3CaU4pdEjuCZzlnOSoVApO8c+
         kkqA==
X-Forwarded-Encrypted: i=1; AHgh+RqLZoXkud6G4eHpgTzXcsFdQGbE7Nxl/hzpxI/mstuf9uSqppvfCI1q4RIpoDl6tew8kqLKaeNXzS+BFfTciw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZh5KuCsee8TvLred18VN9CO4jdipxm58GLL6eW05TXm7QsnNg
	d0RE3u4u6rQRSmCj8IodUwJADjxbXLLYZsRjqM+xaZVAvB60p9D/CzPP
X-Gm-Gg: AR+sD10wQPjiZimY1OdLIuzt1um1ghnBhOQ4kgzaBhUpkoHww4E37Guh+UqKU2Z81jm
	iR3iXWvThK5YvIlubG/mKUK6QXkC3/2uigtIidsZVIZGXX/DdzJMrhLwfIWEzqeTuNGlunzJRVC
	p90w1aFlWTz+/uTOmpeMBzhkDvdLuQc8+Tm47TzlRk/8EYVRmPL51rLMXe27tVs+qGIKeJ0ZCuw
	v5X5ujtZF0EiL2UUigPw47jJv97mDK9VWvXU66LTTeLnztZr+3mbcpi8rb68ofeSvtK8mwoZ5Mf
	F/WOK8Bj4mdE5mCZzdRV8XMZAdUwM3dMHUaeSb3+3w0ttbs2hiaPzGy5g5oFGi0LQ7zFf5gkEIV
	hbvuBYvr8lGDAWLEV+IFdGjv4KRZgz3jousXxzHdcvSyt/hiQxZFYlexa7CZq3Zh8AJHIYmq+x2
	dCA7VeLXHBCiiN/Z/aP7Y=
X-Received: by 2002:a17:90b:590d:b0:387:e0db:bc23 with SMTP id 98e67ed59e1d1-38ec65f41c9mr5899490a91.35.1784855794548;
        Thu, 23 Jul 2026 18:16:34 -0700 (PDT)
Received: from [192.168.86.23] ([136.25.189.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d1300401fsm26431307c88.3.2026.07.23.18.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 18:16:33 -0700 (PDT)
Message-ID: <08078e22-81d3-4d8a-ad31-c73964ee13b3@gmail.com>
Date: Thu, 23 Jul 2026 18:16:26 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Hari Mishal <harimishal1@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
 huster@cs.uni-goettingen.de, mhollick@seemoo.de, jiska.classen@hpi.de
References: <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
 <1fe328d1-edf9-4e72-a145-be74ede20e60@gmail.com>
 <2026071803-passage-dares-8240@gregkh>
 <ae5bc86b-cb8d-4530-9e58-d285007deac0@gmail.com>
 <20260718131715-mutt-send-email-mst@kernel.org>
 <f8c50876-e18d-4493-ba91-7a4090b6385a@gmail.com>
 <20260723195258-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20260723195258-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/23/26 16:59, Michael S. Tsirkin wrote:

> On Sat, Jul 18, 2026 at 10:41:26AM -0700, Carlos Bilbao wrote:
>> Hello Michael,
>>
>> On 7/18/26 10:21, Michael S. Tsirkin wrote:
>>> On Sat, Jul 18, 2026 at 10:07:30AM -0700, Carlos Bilbao wrote:
>>>> On 7/17/26 22:29, Greg Kroah-Hartman wrote:
>>>>
>>>>> On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
>>>>>> Historically, one of the biggest criticisms of coco, especially around
>>>>>> device hardening, was that there were too many values that a
>>>>>> malicious/buggy device could misreport, making it a losing battle. That is
>>>>>> no longer the case with LLMs, and we have the advantage (and challenge) of
>>>>>> open-source dev, which allows us to receive many of these fixes "for free".
>>>>>> If others want to burn their tokens, let them :)
>>>>> I have lots of tokens to burn :)
>>>>>
>>>>> So along those lines, any suggestions on how best to fuzz these code
>>>>> paths?  Any workloads you all use for testing that I can take advantage
>>>>> of?
>>>> We've the virtio-mem config struct layout and the kernel source, so for
>>>> obvious fixes like a NULL check, static analysis is better than fuzzing.
>>>> Claude took a few mins to find me two examples:
>>>>
>>>> Patch 1: virtio-mem: reject non-power-of-two device_block_size
>>>> This one is for virtio_mem_init() to check if
>>>> !is_power_of_2(vm->device_block_size)
>>>>
>>>> Patch 2: virto-mem: validate region_size and usable_region_size
>>>> THis one checks region_size != 0 and vm->usable_reion_size >
>>>> vm->region_size.
>>>>
>>>> An endless factory of "silly" checks like these are low hanging fruit.
>>> At the same time, these checks don't actually help within the coco
>>> threat model, do they?
>>>
>>>> Now, for harder bugs, looking around for fuzz options, VirtFuzz [1] looks
>>>> like a great candidate for those interested in pursuing this direction.
>>>>
>>>>
>>>> Their PoC fuzzes wireless/Bluetooth stack, but nothing our AI overlords
>>>> can't quickly adapt for virtio-mem and other virtio drivers; the JSON
>>>> definition to describe device behavior is easily extensible. Their threat
>>>> model [2] describes an external attacker, but in the context of coco, the
>>>> virtio device itself is the attacker.
>>> What we need, however, is to exclude DoS attacks - these are outside the
>>> threat model. If people try to address all DoS attacks uncritically we
>>> just get a churn of changes which just might introduce issues of their
>>> own.
>>>
>>> Example:
>>>
>>> 	BUG_ON(!is_power_of_2(....));
>>> panics, non exploitable.
>>>
>>> 	if(!is_power_of_2(....))
>>> 		goto error;
>>>
>>> can become exploitable if the cleanup is done wrong.
>>
>> Yes, you are 100% technically right about the scope of the threat model.
>> DoS is out of scope because it is a fundamentally unreachable goal; the
>> cloud provider can always just "pull the plug". The dangers of
>> "vibe-coding" you point out are real, over-eager LLMs fixing up and down
>> will create new vulnerabilities in complex cleanup paths. Also, TBH, I
>> sympathize with a maintainer's disinterest in reviewing a million stupid
>> checks.
>>
>> But, to play devil's advocate: this assumes a missing check
>> like is_power_of_2 only ever leads to a benign crash, rather than already
>> cascading into an unknown, exploitable state down the line.
>>
>> So these checks are not _just_ to prevent DoS!
> I don't get it. It's normally for bug reporters to show the problem
> is real. How about analysing what's going on eh?
> The situation where a misbehaving hypervisor crashes guest
> and this is reported as a "security problem" is unsustainable.
>
>> Anyhow, this is the exact justification for VirtFuzz. If your main concern
>> is that adding validation checks might introduce subtle exploit paths in
>> the error-cleanup code, VirtFuzz and tools like that, can fuzz those new
>> paths exhaustively. It gives the automated safety net needed to scale coco
>> device with as little regressions as possible.
> Sorry I'm pretty sceptic how far this will get us, supposedly
> all virtio drivers have been fuzzed by now.
>
> Are we gonnu be inserting specilation barriers around all these
> "security checks", as one example?
>
> If there's something that never happens, I'm okay with just BUG_ON
> instead of carefully propagating errors all around the place.


The cleanest solution is to stop conflating the two threat models at the
driver level entirely. coco guests already select per-arch configs, so the
kernel already knows at build time whether the device is untrusted. We can
gate the hardening checks behind CONFIG_CONFIDENTIAL_COMPUTING and let
that config carry the threat model and its consequences, i.e., stricter
validation requirements, without burdening mainline virtio or maintainers
with DoS stuff that may not belong here.

Under this scheme, yes, BUG_ON for invariants that can't trigger outside
of coco either. The config wrapper would be reserved for checks that are
only meaningful for coco; so the DoS-vs-exploit distinction is structurally
clear instead of something y'all need to wage every time a patch needs
review.


>
>>> 		
>>>
>>>
>>>>    Here's a vibe coded PR of what I mean:
>>>>
>>>> https://github.com/seemoo-lab/VirtFuzz/pull/7
>>>>
>>>> CCed the creators/authors, thanks for open sourcing this!
>>>>
>>>> Thanks,
>>>> Carlos
>>>>
>>>> [1] https://github.com/seemoo-lab/VirtFuzz
>>>>
>>>> On 7/17/26 22:29, Greg Kroah-Hartman wrote:
>>>>
>>>>> On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
>>>>>> Historically, one of the biggest criticisms of coco, especially around
>>>>>> device hardening, was that there were too many values that a
>>>>>> malicious/buggy device could misreport, making it a losing battle. That is
>>>>>> no longer the case with LLMs, and we have the advantage (and challenge) of
>>>>>> open-source dev, which allows us to receive many of these fixes "for free".
>>>>>> If others want to burn their tokens, let them :)
>>>>> I have lots of tokens to burn :)
>>>>>
>>>>> So along those lines, any suggestions on how best to fuzz these code
>>>>> paths?  Any workloads you all use for testing that I can take advantage
>>>>> of?
>>>> We've the virto-mem config struct layout and the kernel source, so for
>>>> obvious fixes like a NULL check, static analysis is better than fuzzing.
>>>> Claude took a few mins to find me two examples:
>>>>
>>>> Patch 1: virtio-mem: reject non-power-of-two device_block_size
>>>> This one is for virtio_mem_init() to check if
>>>> !is_power_of_2(vm->device_block_size)
>>>>
>>>> Patch 2: virto-mem: validate region_size and usable_region_size
>>>> THis one checks region_size != 0 and vm->usable_reion_size >
>>>> vm->region_size.
>>>>
>>>> An endless factory of "silly" checks like these are low hanging fruit.
>>>>
>>>> Now, for harder bugs, looking around for fuzz options, VirtFuzz [1] looks
>>>> like a great candidate for those interested in pursuing this direction.
>>>>
>>>>
>>>> Their PoC fuzzes wireless/Bluetooth stack, but nothing our AI overlords
>>>> can't quickly adapt for virtio-mem and other virtio drivers; the JSON
>>>> definition to describe device behavior is easily extensible. Their threat
>>>> model [2] describes an external attacker, but in the context of coco, the
>>>> virtio device itself is the attacker. Here's a vibe coded PR of what I mean:
>>>>
>>>> https://github.com/seemoo-lab/VirtFuzz/pull/7
>>>>
>>>> CCed the creators/authors, thanks for open sourcing this!
>>>>
>>>> Thanks,
>>>> Carlos
>>>>
>>>> [1] https://github.com/seemoo-lab/VirtFuzz
>>>> [2] https://www.computer.org/csdl/proceedings-article/sp/2024/313000a024/1RjEa0y9RMQ
>>>>
>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>>> [2] https://www.computer.org/csdl/proceedings-article/sp/2024/313000a024/1RjEa0y9RMQ
>>>>
>>>>
>>>>> thanks,
>>>>>
>>>>> greg k-h
>>
>> Thanks,
>>
>> Carlos


Thanks,

Carlos

