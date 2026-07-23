Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB783DAADB
	for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784849021; cv=none; b=cgckMwVdFasHM8mLcB4Qj6+i6bCITcucvNACvtUpFHcW8ShHx/Zaab55Pe+CNom0mLKlqjGbo5RCCAkkXoTotv6D+dcrA2aPq5JbVv3fsckz9kYNK4pdUcF/hHd7PjOtgoI5o0XLttA1ISCJcbzQpsOAiKgiJUqymx7vZg/brOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784849021; c=relaxed/simple;
	bh=RCslVQ8rlKf+KIrsldOKN583xnKkZ29q2nJfToVvW2c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DtUVwIKhunjD4Rv4CrnXnED+ddNxpKpvYKA8b3QK8ytRTl8dsalEOGe+t8g0qU32j0E53lWlzVP4+CkuWYbY3oNLAVMa8yyiMM10tZMiqqGCNQXx8DytTbqXcQ91lGolTe3X6RcE830vmuit5SHL5YHqORmSHOmx6ODPBZ/d9Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJCaRKNT; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJCaRKNT"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so857639a91.0
        for <virtualization@lists.linux.dev>; Thu, 23 Jul 2026 16:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784849020; x=1785453820; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lqcRKTyLq58dqD717R3/m+4peqMaa1kds05szz65JzE=;
        b=WJCaRKNT8hlw54M9N0spe6TVQLemyO2QU/oQ7uDabjLOZydqwEF2mJfkV6sWNlPrHp
         lEVIgDe0P0zLf3qs+fShn6wo3r+rhjJnFPIBChGPPxUhvL9I2A65a3oGuiiAwl/8PdxD
         n8k4FqhSMylcFQhA3bgOgsOP3+/2jrbBIvko7Fl5fwUTQ5jORJ9IWAh5gPATjyldZbaD
         WexXh2mlbS5VDN573yuFcnx15wrTVKKxZ7Zxd+Irybwcsn4j5toqP3xfTgrULNugX5Ta
         ND4Bqc1WdD/QWMXQJ1VaPupc47cRZwHbrS+yXAaUVuif01Yz+xXqXQ0DmYolz9PDEsKb
         mvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784849020; x=1785453820;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lqcRKTyLq58dqD717R3/m+4peqMaa1kds05szz65JzE=;
        b=QBmYZRAnXTqB2O5D/Kv5Ivavhvo+gSe7T1WN/BoQjdUW1Yvf1Jwf679yu7IIkHQ82O
         Vrq/DmuiVUAr9lUoZilJX+C1NNF1gxxXWXVNgM3/DidBR1aUMr9kd3+yyipOE3V47MlG
         HSCwNPhu6bT9GxhWFkF0L7FyR6zz1YP7DzcKC9vjsgV01E9WUI9dcsVO1B21XpmX1pkV
         GmiWadYV5aovYr9a03QVQ2vRL5v478ehlWdE6R6IyO5aXRST1+iIdYJU6X4lvgtJkDkd
         JDSVsYz8tml5rpy7eowKkrSaNFvLKDNf4QEBDKbMsMTSCzzm7yk11E77evSL3oCbyVJu
         TeZQ==
X-Forwarded-Encrypted: i=1; AHgh+RrXuo/T10dktVzlAtW6ODIWNLdetF1RzwvsuHyjQdBLiKX4eqW7j2povSG6cRl5pUj2qpKYE8OGJ+1EutdZAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YztWOnYE8zW1koTgORZkl43g6TYx7/lBjAdQqO+G798oMWxqft6
	diH12Nv47idhEfrRR6p3rmbQ2PXZBv82orJmU64U/EEpY9lnjhLXcXge
X-Gm-Gg: AR+sD10EOl47eXCNmeujr9g6/k4oSspZCQMKQ1nWWRmKrGUTt0++5RkvHh0t0bPEKLE
	b1pRBCmf2RELll3bp1IPy9Us29k58OWvcMETMG2YaojlDIN1eRcjcWlkHUFgBeZLOTc4v3q/QNI
	Y9zgnAsunEqFAbtGnnrTTK/3viNSeV9vTX0m/Fc1xGu8jXvqF2a3yPRYxE0fBD4pPPXeE3v6l5a
	3Inu5+4EGPa9VAHB6zR5a3/7qy2scR4f8f6ZuYpG6R667lUO1QCCzsLjgcBaJYfQ8lw5mjYsmYj
	7N9udWmNmsJN16i7Crsvc/NB1f2ml96VmQRlJRvmaq1t6Ns2/+naE+eIj1bn9nHBcgWIcvlTvjS
	/Oj4evqIQ35VpXgoWi5aRQxhiOMhKoln9UVkDV90LQAMB98Vk83KZYJ7o2yIcu+QuCK38RrMGnZ
	A/GgOE+9gGqMNL9dbFGH4=
X-Received: by 2002:a17:90b:274b:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-38ec85060bcmr4678203a91.10.1784849019910;
        Thu, 23 Jul 2026 16:23:39 -0700 (PDT)
Received: from [192.168.86.23] ([136.25.189.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130262d2sm17551764c88.7.2026.07.23.16.23.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 16:23:39 -0700 (PDT)
Message-ID: <2c636784-30c4-4de9-86ef-81c0027a85cf@gmail.com>
Date: Thu, 23 Jul 2026 16:23:34 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Hari Mishal
 <harimishal1@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
 huster@cs.uni-goettingen.de, mhollick@seemoo.de, jiska.classen@hpi.de
References: <2026071757-grout-composer-165d@gregkh>
 <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
 <1fe328d1-edf9-4e72-a145-be74ede20e60@gmail.com>
 <2026071803-passage-dares-8240@gregkh>
 <ae5bc86b-cb8d-4530-9e58-d285007deac0@gmail.com>
 <9569e577-aa82-4642-b9d9-fd496fc12849@kernel.org>
 <2026072036-outburst-rebel-c71b@gregkh>
 <8237ffef-4fb4-40b4-82c3-e9236032ab7e@kernel.org>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <8237ffef-4fb4-40b4-82c3-e9236032ab7e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/20/26 02:19, David Hildenbrand (Arm) wrote:

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
>>> "silly" is the right word.
>> "silly" in what way?
>>
> As in producing "silly" low-hanging fruit patches that don't move the needle
> when it comes to security.
>
>> Seriously, I'm trying to figure out what you all care about here and
>> what exactly the threat model you want this driver to work in, and I'm
>> getting conflicting answers.
>>
>> Either you all do worry about the "device" sending bad data and want to
>> protect from that, or you don't and you trust it.  Pick one please so
>> that we know how to deal with these bug reports we are getting.
>>
>> For example, for USB we have said our threat model is:
>>
>>    - we do NOT trust the device before a driver is bound to the device,
>>      so if a malicious device can do something to the kernel, the kernel
>>      needs to be fixed.
>>    - During the probe() call for a USB driver, the driver does NOT trust
>>      the device, and again, anything a malicious device can do to the
>>      kernel, the kernel should fix.
>>    - After probe() for a USB driver succeeds, it's up to the driver if it
>>      wants to validate all data coming from the device or not.  Right
>>      now, in general, the kernel trusts the device at that point in time
>>      so additional checks are discretionary and at the whim of the
>>      maintainer.
>>
>> For that last point, I will note that some BIG users of Linux (i.e.
>> billions of Android devices) still explicitly do NOT want to trust the
>> USB device at this point in time, and are relying on the kernel to
>> protect the system from bad devices.  In that case, various patches have
>> been taken to different drivers and subsystems to play whack-a-mole on
>> while Android gets their act together to finally come up with a solid
>> defensive plan (like ChromeOS has had for a decade.)  It will be seen
>> which happens first, all drivers are properly fuzzed and fixed up, or
>> Android gets their act together and finally fixes their b0rked system
>> trust model.  I think Android management is relying on the kernel
>> community to do the kernel work as they keep refusing to staff the
>> userspace work that they need to do here...
> Right, and for virtio devices trusting the device after probe is just extremely
> questionable.
>
> What changes during probe that the device suddenly sends us good data?
>
> Why would a hypervisor that tried to break us before probe not try to break us
> after probe?
>
>> And yes, I really need to write this up in a more solid document for USB
>> and get it into the tree, but at least this email thread has forced me
>> to write down the above :)
>>
>>
>> So, again, for virtio drivers, what exactly do you all want to say is
>> your threat model that the drivers need to handle?  Can you all agree on
>> something please?  Otherwise, for new developers like Hari, this is
>> totaly confusion as to what they should be doing.
> Well, I am also totally confused why we end up checking against some MUST
> clauses in the spec, but not against others.
>
> I am very much in favor of making virtio-mem completely safe to use even in
> coco, where it is currently not used at all.
>
> If it's really about "don't let a device trigger any unexpected kernel code
> execution by sanitizing all input data", fine with me. We should do exactly
> that. Try checking all MUST clauses etc.
>
> But I don't think doing the "low hanging fruit" adds any security. It should be
> done properly or not at all.


I think you're mistaken in assuming that these "silly" fixes don't move the
needle at all when it comes to security. We can't really quantify these
things, and one extra NULL check by itself is probably not going to make a
meaningful difference. But, IMHO, this should be treated as the opposite of
"death by a thousand cuts", many small hardening improvements, each
individually insignificant, can collectively make the kernel substantially
more robust over long periods of time.


Thanks,

Carlos

