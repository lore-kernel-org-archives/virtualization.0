Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F22C86D
	for <virtualization@lists.linux.dev>; Sat, 18 Jul 2026 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784345474; cv=none; b=T5y7igLlZeeyTlQW4S46tmzdiAAgtbSDl+ZJ+h8+55KaE/FqIiXfErbQUmmlnzSMeOq/0WaGbpYcWQ0jmVQYTb51HQEP1kT1n3sSVk7MEm9+xpvDrHml5ptpxHK1s3ecQGPODPhX4G1BQmSGp7AImuWn9BHwDVY6wvuq3pgoMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784345474; c=relaxed/simple;
	bh=EhOILQ2CzRfX7FpizBFZKa1aP7v+pzIVeM3zBFiukdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHWZO68SmDiGZyLp9CW4jFNJpsLe11QbgZZeDhRCtYFlM2Xtsnx8v/0YcGEVpOrJv146wx/TMtRst6FO+xdrdamAXtnThiLCx1QGP+y5KXwM9PEgB5SFM7XpNG986O40XvH5MsJP//mAkFGonNKPuvOyrQIEK/f4rOm0MgHjVqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThCI649f; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThCI649f"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc73e322dbso101854625ad.1
        for <virtualization@lists.linux.dev>; Fri, 17 Jul 2026 20:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784345472; x=1784950272; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3tfqyGYtLEB1OXJEi7UqI9+Wt1ooEfiwjFj9XLA9r7g=;
        b=ThCI649fvm/ABACXt36/oOoNF1AXqb88AzFTBHvUdM9QQsJlGkh4seg8kXkTr7QHPY
         Cl/3jY7CweTK5n9A2miUecwbFjJ8uCB3U22WLfBJi1dPZCLrOxTV5W0+MBG2GrEr0x04
         WGCqaYzZr+/RSuF5PCyF/HqBT7GJCTMI3yqGtGA60yHngzciF0ZAd4CK59QZSZgKxhP9
         n5ABnTGVMLtPfE/TG8gZROy1+VyGRH4HdJWzO0yuhDMAUDQf30wzTbfx+3J88RUtky9j
         ZteNQtHjkX3vMwB8nZ6K77YGJNHvSp1itok8e1tinU80EJp69YAIed9WiTNMHarAWWnt
         wmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784345472; x=1784950272;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3tfqyGYtLEB1OXJEi7UqI9+Wt1ooEfiwjFj9XLA9r7g=;
        b=WZGEswIiMO8i93dJFisFQ37WGGcrFHkOJNhB/EHOK0Vzk1isvKzOhh03t1gBXrJSSu
         QtdMhfP3s+pNI6Eefr/e530OZEBYQCNDfEIpkbbn8BCbSYpkSuwfINQFktFz/gA0N88c
         ZG9Y4mdp59x4d5Dk1clQGIVOvcA9lxmIMP0k5vjoLmyeo7zH77r60Wi2TKMKuAsq3as8
         YfHxslB6O7R+lqxxaOWcb1d1/yQDyRO7KqujKKp0zrsdZeUZIcdgM7QoK8Cpk7URtqy1
         fHDCspoy/OI/htLK42btwUzWGPHdNsjRMjZnF4M6DRl0Lbv5guZgmBbzhhrg11ByxVRe
         +xAQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq2Mv6+ASdqkBAClvSojm56sksbm+cO8EKM3jFhg6+U0clS3sPiuzb/oTNK3J0LAMwfI6UOvH0guNlpXQpQsw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzl8vqCIrFUcLBeK3J0lfkbhZN+X9JlNyGucMb964R78aXEq535
	vMrt+buONrLA03CzzH9y/FeQsKExRNK6mSn/xhih4f+OpKc3v9RiPMI0
X-Gm-Gg: AfdE7cl1jNhAci1YIRMt/GoXS93+YAb75wuq82k2N2mUE0+USWQhGd2l13WsKMCXm0D
	cQsJ9CtL/XNyMSkt3YUXPLMkUMDqZk+V7Eg6QeLMSi4Ih5xRPEmBMq7r+mjuseNg/phntXAhYGN
	ET6bSjp66XHu8hAfZ7Mvi/ejegUT/IqtjvKYetr1vQIebkPMX8CS7ic6ZxUhAKHg4PJnWRpjJQo
	gkmgGpYilug46axNkUUrmfsQ93m5WBeU6DANsfLrqewpTVgUnSmLFh7sFVFtl+KSiSNXWMWbi1g
	TCB6y9UVLndfIdHxwslpwktiVPyhcnaUCK8T+K0Aj7t9MXSIRN9VdpzoeXojFxglTVeT9HiEDM3
	Qx5/cIu2R7hmAnaBUp9YwL5+TByUyDk++Z0yA1jVfY6PCIZgHwWGBlsSUk/gcGylbrv8cNC7mZ7
	60eyLKbNCuLVZUKedXl2E=
X-Received: by 2002:a05:6a21:103:b0:3c3:8315:80b7 with SMTP id adf61e73a8af0-3c3ad677c0dmr5754303637.9.1784345472452;
        Fri, 17 Jul 2026 20:31:12 -0700 (PDT)
Received: from [192.168.86.23] ([136.25.189.61])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1e348bsm13253400eec.25.2026.07.17.20.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2026 20:31:11 -0700 (PDT)
Message-ID: <1fe328d1-edf9-4e72-a145-be74ede20e60@gmail.com>
Date: Fri, 17 Jul 2026 20:31:09 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] virtio-mem: validate device-reported block size
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Hari Mishal <harimishal1@gmail.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, elena.reshetova@intel.com
References: <20260717014134-mutt-send-email-mst@kernel.org>
 <3b32a38f-0964-45b9-9529-933abedbf69b@kernel.org>
 <20260717044019-mutt-send-email-mst@kernel.org>
 <2026071746-deviation-clad-1712@gregkh>
 <20260717060822-mutt-send-email-mst@kernel.org>
 <2026071757-grout-composer-165d@gregkh>
 <20260717061901-mutt-send-email-mst@kernel.org>
 <2026071724-asleep-pedigree-ea54@gregkh>
 <20260717065219-mutt-send-email-mst@kernel.org>
 <2026071759-thermal-synopsis-7568@gregkh>
 <20260717085838-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20260717085838-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey there,

On 7/17/26 06:08, Michael S. Tsirkin wrote:
> On Fri, Jul 17, 2026 at 02:07:50PM +0200, Greg Kroah-Hartman wrote:
>> On Fri, Jul 17, 2026 at 06:52:46AM -0400, Michael S. Tsirkin wrote:
>>> On Fri, Jul 17, 2026 at 12:46:52PM +0200, Greg Kroah-Hartman wrote:
>>>> On Fri, Jul 17, 2026 at 06:23:57AM -0400, Michael S. Tsirkin wrote:
>>>>> On Fri, Jul 17, 2026 at 12:15:09PM +0200, Greg Kroah-Hartman wrote:
>>>>>> On Fri, Jul 17, 2026 at 06:10:41AM -0400, Michael S. Tsirkin wrote:
>>>>>>> On Fri, Jul 17, 2026 at 11:14:23AM +0200, Greg Kroah-Hartman wrote:
>>>>>>>> On Fri, Jul 17, 2026 at 04:59:32AM -0400, Michael S. Tsirkin wrote:
>>>>>>>>> On Fri, Jul 17, 2026 at 10:39:40AM +0200, David Hildenbrand (Arm) wrote:
>>>>>>>>>> On 7/17/26 07:48, Michael S. Tsirkin wrote:
>>>>>>>>>>> On Thu, Jul 16, 2026 at 05:59:05PM +0200, David Hildenbrand (Arm) wrote:
>>>>>>>>>>>>> Or do we just always trust virtio mem devices explicitly?
>>>>>>>>>>>> It's hard for me to understand where we draw the line, really.
>>>>>>>>>>>>
>>>>>>>>>>>> But maybe MST can clarify what we care about in virtio world where the
>>>>>>>>>>>> hypervisor is fully in charge of the device,
>>>>>>>>>>> Generally:
>>>>>>>>>>> - The guest is expected to whitelist drivers (most drivers have not
>>>>>>>>>>>    been audited).
>>>>>>>>>> But even if you audited your driver, who makes sure that we consider all ways
>>>>>>>>>> where the device could mess with us?
>>>>>>>>> A lot of this is up to a correct setup. For example, make sure all
>>>>>>>>> filesystems are encrypted and refuse to mount unencrypted ones.
>>>>>>>>>
>>>>>>>>>> Something feels off here.
>>>>>>>>>>
>>>>>>>>>> Handling selected out-of-spec scenarios like this feels like a band-aid. Happy
>>>>>>>>>> to be corrected.
>>>>>>>>> Well Documentation/security/snp-tdx-threat-model.rst puts it like this:
>>>>>>>>> 	It is important to note
>>>>>>>>> 	that this doesn’t imply that the host or VMM are intentionally
>>>>>>>>> 	malicious, but that there exists a security value in having a small CoCo
>>>>>>>>> 	VM TCB.
>>>>>>>>>
>>>>>>>>> and
>>>>>>>>>
>>>>>>>>> 	While traditionally the host has unlimited access to guest data and can
>>>>>>>>> 	leverage this access to attack the guest, the CoCo systems mitigate such
>>>>>>>>> 	attacks by adding security features like guest data confidentiality and
>>>>>>>>> 	integrity protection.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> now, when we are talking about "mitigation" it is indeed becoming a bit
>>>>>>>>> murky.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> For me, a rule of thumb I came up with is that if the validation happens
>>>>>>>>> to also be helful for users e.g. to work around buggy devices,
>>>>>>>>> or maybe because we feel failing gracefully is nice because this
>>>>>>>>> will allow to later make use of this config and old drivers will
>>>>>>>>> fail but at least not panic, then it is good to include.
>>>>>>>> Why not do what USB does?  Don't trust the device until AFTER probe()
>>>>>>>> succeeds?  All of the needed checking should happen before then, as that
>>>>>>>> is a "slow path" so lots of validation and the like can happen at that
>>>>>>>> point.
>>>>>>>>
>>>>>>>> After that, during the normal data paths, after the driver is bound,
>>>>>>>> trust it all you want as attempting to validate every single packet is
>>>>>>>> just going to be impossible.
>>>>>>>>
>>>>>>>> thanks,
>>>>>>>>
>>>>>>>> greg k-h
>>>>>>> People do expect that data path validation at this point.
>>>>>> Ok, so you want this patch :)
>>>>>>
>>>>>> And more, as you need to treat everything from the host as "untrusted",
>>>>>> and it must be "verified".
>>>>> Well. First it's not me) Second it's only specific configurations -
>>>>> for example there's no short term plan to validate filesystem code, people
>>>>> are expected to rely on encryption. The reasons have more to do
>>>>> with the available manpower than anything else.
>>>> Sure, but again, for subsystems, you have to define your threat model as
>>>> the LLMs are churning against the code base and coming up with lots of
>>>> crazy ideas if a device should or should not be trusted and spitting out
>>>> patches and reports like the ones that are in the first few patches of
>>>> this series.
>>>>
>>>> So please, pick a model, let's document it, and go with that.  I am
>>>> getting directly conflicting responses here.
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>> Supposed to be this one:
>>> Documentation/security/snp-tdx-threat-model.rst
>>>
>>> what is missing?
>> A policy decision that needs to be made.  All that document does is
>> describe a bunch of different "threats" yet does not decide what to do
>> about them at all from what I can tell.
> That would be this section I think:
>
> 	The **Linux kernel CoCo VM security objectives** can be summarized as follows:
>
> it does, indeed, not go into detail about how to interact, safely,
> with untrusted entities. Does it really need to be spelled out?
>
>> And that's just for one subset of the CoC world, right?  Is that
>> something that all virtio drivers need/want to care about?
> What is missing, and what you seem to be asking for, is an opinionated
> stance on which drivers we care about in this world?
> True.
> coco guys tried to annotate drivers at some point to do exactly that.
> this was rejected upstream from the position that this is not
> different from handling buggy hardware, and just to fix all drivers.
> so it's up to users, and I guess for virtio the answer is yes
> with some exceptions because we don't have a better answer right now.
>
>> So I don't see a real answer to the "does Linux trust the host to give
>> you good data or not" question in that file, am I missing it?
>>
>> thanks,
>>
>> greg k-h
> This? Note the last sentence.
>
> The **Linux CoCo VM attack surface** is any interface exposed from a CoCo
> guest Linux kernel towards an untrusted host that is not covered by the
> CoCo technology SW/HW protection. This includes any possible
> side-channels, as well as transient execution side channels. Examples of
> explicit (not side-channel) interfaces include accesses to port I/O, MMIO
> and DMA interfaces, access to PCI configuration space, VMM-specific
> hypercalls (towards Host-side VMM), access to shared memory pages,
> interrupts allowed to be injected into the guest kernel by the host, as
> well as CoCo technology-specific hypercalls, if present. Additionally, the
> host in a CoCo system typically controls the process of creating a CoCo
> guest: it has a method to load into a guest the firmware and bootloader
> images, the kernel image together with the kernel command line. All of this
> data should also be considered untrusted until its integrity and
> authenticity is established via attestation.


I'm glad you're finding this document helpful, it took us massive
back-and-forth to get somewhere everyone was happy.

Here's my 2 cents on this debate, if I may. I think defensive programming
is always a positive, and we don't just say, "the spec disallows it".

Historically, one of the biggest criticisms of coco, especially around
device hardening, was that there were too many values that a
malicious/buggy device could misreport, making it a losing battle. That is
no longer the case with LLMs, and we have the advantage (and challenge) of
open-source dev, which allows us to receive many of these fixes "for free".
If others want to burn their tokens, let them :)

Thanks,

Carlos

>
>
>
