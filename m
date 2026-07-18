Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8159D30C146
	for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 17:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784396491; cv=none; b=Zkh6WvaVB2vB5z33/7as12L3nEouA8vJMh566Wx7A+hd0mOOBdY3PfHyL9yIBg4xRAPX9nmQEhbMKtNH5uvonh5RrebOcJe66+IS/YAHEr3qJClKE9MFnvWK6IZEGDih4heEhUZupuhXjGgMU4L+wSKx2o1c1BHaKTG7VWIFnEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784396491; c=relaxed/simple;
	bh=CEpVNIMFamK8ZFZw4YMxNorECvmbWE2CGRI+ZPpAoZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=csUn1Hg9T3pHVkvvt8zEfpMzFh9nlpp/oVem64FcltuO+vgJSf0/A0A4qv+yaoly9LzR2Da/IgnIDjtgOWRVVHPTqc1FJpKwC6oGyHbVTQhnlVhhcIfD5pjr3uDHlC0stTGaNzbN5Q5NcThpVoH+ebpwmVM23McuUl3pKj3alT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzdnMn0D; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzdnMn0D"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so8900515b3a.3
        for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784396490; x=1785001290; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1FYkIyXnGh51CvHiVgoa6lNBE/dJN10l2yCF+0lEhds=;
        b=HzdnMn0DKfSMKubU4rXrIieK5HfzLmwbRiCY69uLDS4jJA0NSuMVXYVsAi8s2ZftFB
         C4nWukGgLIkqTw2S79FnHVGvVyon95lSG14YJKtuyr34b66LIICcikecjwWRgpdvDiDk
         cIoOkXqsCiV0UzKZM96NK2SDew1SVgLWATPrE8XD9t6TgdVVrGTgEURcuPusYQNRhlB/
         7XnJaZ+eSLcX4v3RunbIruT6YTaF+WuLhVvckbKesTqvhRGZk1n4ZcoIBh/h7gc21TAC
         a6/ySJERNL6+bVlIorYAONrOJBRYe5SyBXyhq1H7PswH39cwiqMJHIkHDPo/8Zc7Mm8o
         EzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784396490; x=1785001290;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1FYkIyXnGh51CvHiVgoa6lNBE/dJN10l2yCF+0lEhds=;
        b=ehg8eOAkRZhoyxRmRWPY6xdm8AEzz8PVBVEmLJrljbwTYoaDKJCNZl6jbRcytyqV61
         P67DVwWzcBnynAGN2CbLUfcmAshlJ4rJc5qnPVyQGgfEcP+1ZTMztI5ZQT05iySl/q2U
         wj2ulTZrJBbMOraYlxgBcBoX9zPIxvuXZ+GqUA6mO6TwEQ1fcIbsXWYrE4nRy5vManFq
         i9TTXIoFwQSK3kgxI79MqDY2iV/cYZoo+PPSLtlpbcou9kHpH86S7nNU2dTj4x5XyIKE
         HhTEhmuz1JROkqq81Ysjk8u2HFVSCNO8flS+UYNT63sgajCYdyByqnlxXJplfld1RBY2
         utxg==
X-Forwarded-Encrypted: i=1; AHgh+Rrqg51byigoLB418BLKs2MPWs7c3HvhIZwdT4sYJV1FjEGvDSSx9RmoY7WneBHFtqOvS+R4xalBtgXekxoyHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyulHA2MWUBPTN+NS9GFqniOJ31RP4or4O3Ha6/b8K5TlhTejnO
	bjtNQaz3AyFEoMA41wcaoZKLOCgcQCytb/jPGyWv50W88vtDBMxSqD1A
X-Gm-Gg: AfdE7clewt/42GUebB1ZwOMLdq0j6zgu/wm+jmNmtp1kGpfk+isdyYYcRSZ9YIJDTZ7
	V+HeGpArg1HFsQgPcS7FtBoDwOVMeL3sdzAalmK4vEphGxrNO8cvHnUxbfEUWBD1Pw3xeaSasQC
	B02ByBTt1GmygfCJ0SmJ7eMl5OM2D7DLdugIcSm2VwRQ33aOYuIjzTQVjHqGuPbjbKpDinx3Hpq
	jiv7lROdFgVqlX0y/yVMGHBXP5vemGG0xpsDS4uRUG5VCdbYJTkR5bpWjlY5+JpT7VmEeIeFqJA
	Zssv0CWaFred+0wZ+sOHAtT8JwDVAHiso9YjdK6jE55iqmqefYMfOfryh2IOpXBZhi+rDTPGaqU
	wnFd2tjycvfSNyp56k9Nd6FLS6YhgIWBloDRwQDQbTSjWNwwb7iz35446TUF+HDN7F/ujK0vHfA
	KqDdsfSViEpYE3KOmV+9k=
X-Received: by 2002:a05:6300:2284:b0:3c0:9c1a:8943 with SMTP id adf61e73a8af0-3c3ada5be63mr8296643637.75.1784396489817;
        Sat, 18 Jul 2026 10:41:29 -0700 (PDT)
Received: from [192.168.86.23] ([136.25.189.61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429fdcaefsm19500844eec.10.2026.07.18.10.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2026 10:41:29 -0700 (PDT)
Message-ID: <f8c50876-e18d-4493-ba91-7a4090b6385a@gmail.com>
Date: Sat, 18 Jul 2026 10:41:26 -0700
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
References: <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
 <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
 <1fe328d1-edf9-4e72-a145-be74ede20e60@gmail.com>
 <2026071803-passage-dares-8240@gregkh>
 <ae5bc86b-cb8d-4530-9e58-d285007deac0@gmail.com>
 <20260718131715-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20260718131715-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Michael,

On 7/18/26 10:21, Michael S. Tsirkin wrote:
> On Sat, Jul 18, 2026 at 10:07:30AM -0700, Carlos Bilbao wrote:
>> On 7/17/26 22:29, Greg Kroah-Hartman wrote:
>>
>>> On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
>>>> Historically, one of the biggest criticisms of coco, especially around
>>>> device hardening, was that there were too many values that a
>>>> malicious/buggy device could misreport, making it a losing battle. That is
>>>> no longer the case with LLMs, and we have the advantage (and challenge) of
>>>> open-source dev, which allows us to receive many of these fixes "for free".
>>>> If others want to burn their tokens, let them :)
>>> I have lots of tokens to burn :)
>>>
>>> So along those lines, any suggestions on how best to fuzz these code
>>> paths?  Any workloads you all use for testing that I can take advantage
>>> of?
>>
>> We've the virtio-mem config struct layout and the kernel source, so for
>> obvious fixes like a NULL check, static analysis is better than fuzzing.
>> Claude took a few mins to find me two examples:
>>
>> Patch 1: virtio-mem: reject non-power-of-two device_block_size
>> This one is for virtio_mem_init() to check if
>> !is_power_of_2(vm->device_block_size)
>>
>> Patch 2: virto-mem: validate region_size and usable_region_size
>> THis one checks region_size != 0 and vm->usable_reion_size >
>> vm->region_size.
>>
>> An endless factory of "silly" checks like these are low hanging fruit.
> At the same time, these checks don't actually help within the coco
> threat model, do they?
>
>> Now, for harder bugs, looking around for fuzz options, VirtFuzz [1] looks
>> like a great candidate for those interested in pursuing this direction.
>>
>>
>> Their PoC fuzzes wireless/Bluetooth stack, but nothing our AI overlords
>> can't quickly adapt for virtio-mem and other virtio drivers; the JSON
>> definition to describe device behavior is easily extensible. Their threat
>> model [2] describes an external attacker, but in the context of coco, the
>> virtio device itself is the attacker.
> What we need, however, is to exclude DoS attacks - these are outside the
> threat model. If people try to address all DoS attacks uncritically we
> just get a churn of changes which just might introduce issues of their
> own.
>
> Example:
>
> 	BUG_ON(!is_power_of_2(....));
> panics, non exploitable.
>
> 	if(!is_power_of_2(....))
> 		goto error;
>
> can become exploitable if the cleanup is done wrong.


Yes, you are 100% technically right about the scope of the threat model.
DoS is out of scope because it is a fundamentally unreachable goal; the
cloud provider can always just "pull the plug". The dangers of
"vibe-coding" you point out are real, over-eager LLMs fixing up and down
will create new vulnerabilities in complex cleanup paths. Also, TBH, I
sympathize with a maintainer's disinterest in reviewing a million stupid
checks.

But, to play devil's advocate: this assumes a missing check
like is_power_of_2 only ever leads to a benign crash, rather than already
cascading into an unknown, exploitable state down the line.

So these checks are not _just_ to prevent DoS!

Anyhow, this is the exact justification for VirtFuzz. If your main concern
is that adding validation checks might introduce subtle exploit paths in
the error-cleanup code, VirtFuzz and tools like that, can fuzz those new
paths exhaustively. It gives the automated safety net needed to scale coco
device with as little regressions as possible.


> 		
>
>
>>   Here's a vibe coded PR of what I mean:
>>
>> https://github.com/seemoo-lab/VirtFuzz/pull/7
>>
>> CCed the creators/authors, thanks for open sourcing this!
>>
>> Thanks,
>> Carlos
>>
>> [1] https://github.com/seemoo-lab/VirtFuzz
>>
>> On 7/17/26 22:29, Greg Kroah-Hartman wrote:
>>
>>> On Fri, Jul 17, 2026 at 08:31:09PM -0700, Carlos Bilbao wrote:
>>>> Historically, one of the biggest criticisms of coco, especially around
>>>> device hardening, was that there were too many values that a
>>>> malicious/buggy device could misreport, making it a losing battle. That is
>>>> no longer the case with LLMs, and we have the advantage (and challenge) of
>>>> open-source dev, which allows us to receive many of these fixes "for free".
>>>> If others want to burn their tokens, let them :)
>>> I have lots of tokens to burn :)
>>>
>>> So along those lines, any suggestions on how best to fuzz these code
>>> paths?  Any workloads you all use for testing that I can take advantage
>>> of?
>>
>> We've the virto-mem config struct layout and the kernel source, so for
>> obvious fixes like a NULL check, static analysis is better than fuzzing.
>> Claude took a few mins to find me two examples:
>>
>> Patch 1: virtio-mem: reject non-power-of-two device_block_size
>> This one is for virtio_mem_init() to check if
>> !is_power_of_2(vm->device_block_size)
>>
>> Patch 2: virto-mem: validate region_size and usable_region_size
>> THis one checks region_size != 0 and vm->usable_reion_size >
>> vm->region_size.
>>
>> An endless factory of "silly" checks like these are low hanging fruit.
>>
>> Now, for harder bugs, looking around for fuzz options, VirtFuzz [1] looks
>> like a great candidate for those interested in pursuing this direction.
>>
>>
>> Their PoC fuzzes wireless/Bluetooth stack, but nothing our AI overlords
>> can't quickly adapt for virtio-mem and other virtio drivers; the JSON
>> definition to describe device behavior is easily extensible. Their threat
>> model [2] describes an external attacker, but in the context of coco, the
>> virtio device itself is the attacker. Here's a vibe coded PR of what I mean:
>>
>> https://github.com/seemoo-lab/VirtFuzz/pull/7
>>
>> CCed the creators/authors, thanks for open sourcing this!
>>
>> Thanks,
>> Carlos
>>
>> [1] https://github.com/seemoo-lab/VirtFuzz
>> [2] https://www.computer.org/csdl/proceedings-article/sp/2024/313000a024/1RjEa0y9RMQ
>>
>>
>>> thanks,
>>>
>>> greg k-h
>> [2] https://www.computer.org/csdl/proceedings-article/sp/2024/313000a024/1RjEa0y9RMQ
>>
>>
>>> thanks,
>>>
>>> greg k-h


Thanks,

Carlos

