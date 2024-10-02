Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C932780038
	for <virtualization@lists.linux-foundation.org>; Wed,  2 Oct 2024 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727846829; cv=none; b=ujQWeHJ0h4VJuxQ3J6WGSeO376Z24UUsS/VHUJjffJseU6YKL8FU0q7AHkO6OArB2mjt+06SwT6VqpBZiv62FkQZpA1BPRxy6kP67dHNHN3HQa+NII/NVkRkGMrZXiKRISpdzqkwAbQU7OAhVCSoWoDQYrXNk5tllwnlaDQ+FgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727846829; c=relaxed/simple;
	bh=9fxwXFLn5GhRqZDoUHaTplseUCYkdcTYDVZR4cW105g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1ysKzsuvyMANpsvIV2V+tfU1ftL/NcdFxSbw166IaSRMjw1pW4W29X2+1cl8/ofYmcQkL9eBS9DukVXGuBYIRHOlv50ChsZ+EnGBDPbylI+MqXtjFIZySbA+DiZkIftW/KQkGXOeiZJJOnfZg8FkhmkwGezmo0VCy6Rk4CxWHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=d4DbCq3a; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="d4DbCq3a"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E708403F1
	for <virtualization@lists.linux-foundation.org>; Wed,  2 Oct 2024 05:27:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id de1ktB6-Lz8B for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Oct 2024 05:27:05 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 27FEC403E3
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27FEC403E3
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=d4DbCq3a
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 27FEC403E3
	for <virtualization@lists.linux-foundation.org>; Wed,  2 Oct 2024 05:27:04 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-20b6c311f62so32920495ad.0
        for <virtualization@lists.linux-foundation.org>; Tue, 01 Oct 2024 22:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727846824; x=1728451624; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVKUJa0N9Bv7FRPSWL41/VbRzViB8OY98BcxK2GdZLk=;
        b=d4DbCq3aux/dlaGxOxygmROqWxPJ8qzOCt4DXUWiImm1qHmd3GD9LgaSIskycqchN7
         DcduoFg4pEUiQmV64j+pLqngmQya+K8YgCb3CWq6aqJjF7k51bNXyNZQHhZ4WfKni8nT
         M5PNPAka1UDBGLwXdE4HIGCi9jTFzpWNYB7JT9YkXaSPsu707EoYnbq826PKueu45gvS
         0uxYXx+ArCCO79kv2O7tdR9cDupuJGwNqfYvWO1zoa+ET6gAA7fK3V4XTkiv/4mvsBkb
         dtYaKUOmnmQdnyMp+xfEbxLTIEBLC4BgJk9VlGkvrxjbMdgIUDmFLrN+FheQEq8bzQtc
         oieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727846824; x=1728451624;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVKUJa0N9Bv7FRPSWL41/VbRzViB8OY98BcxK2GdZLk=;
        b=cAEPYKeAki0+z2prblgA6VpTXEyJ+ul9qKFNTzK58GBZCTDLLdtXtqgWu7KAT/1Qkj
         jZH6uOCLNMLS5/gXrG9T3NftJbtlHGJNSCDTwdpPQf5MnMv9e4ukChvyAz3uTwEBGXTV
         ud4S2/vWcBNVHByHZZ3pVK2+7VvyTQOrHVbNThEamzptFoRPTHV4CqNateQ5x/bY2gpj
         /t/EF21cvJ+6nYqp8vYGbCT+KRvKnPwhLqC/H/2fW0M7ul7zorJPB03wzmvA2ng0i1QF
         2mWgeIBjlC2ypgD5WZNxUEaJIcsrBXetfMPc5+YKFYSv7upPWoJECVGGkj6vx/QZzsd0
         mmXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKqXx5R8Nm2GMsMJlo2yMifMcWgPM1hxitcSyzSwbweZasdKFa7sAc5+5fcXigS0ahq5zY3ndAunOwyYs7hg==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Yz7y6xK/R7dW+YYapbnxgnjAjpWz9Y6TgpVZurIIwPmYxWfPwa9
	e9nQlYOVWJ7645vySxk7jz+/0SAPaBlfcnBVhi7Yu6V3I/Fo1l25kVmBa1XWTMQ=
X-Google-Smtp-Source: AGHT+IGRvF+0dzA6+8tjn7CaXbw8Jq4zdHPAfGu0aIngCPiMB0nvWY2fY2CjWXjr6Jtlt0AZyPw/Jg==
X-Received: by 2002:a17:902:f14b:b0:205:83a3:b08 with SMTP id d9443c01a7336-20bc5a13e3fmr21525075ad.32.1727846823680;
        Tue, 01 Oct 2024 22:27:03 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e4ee7bsm77740535ad.234.2024.10.01.22.26.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2024 22:27:03 -0700 (PDT)
Message-ID: <202d7486-7fbb-43bd-9002-2cc0013483ff@daynix.com>
Date: Wed, 2 Oct 2024 14:26:57 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jason Wang <jasowang@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, gur.stavi@huawei.com
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
 <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
 <c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com>
 <CACGkMEu3u=_=PWW-=XavJRduiHJuZwv11OrMZbnBNVn1fptRUw@mail.gmail.com>
 <6c101c08-4364-4211-a883-cb206d57303d@daynix.com>
 <CACGkMEtscr17UOufUtyPp1OvALL8LcycpbRp6CyVMF=jYzAjAA@mail.gmail.com>
 <447dca19-58c5-4c01-b60e-cfe5e601961a@daynix.com>
 <20240929083314.02d47d69@hermes.local>
 <f437d2d6-e4a2-4539-bd30-f312bbf0eac8@daynix.com>
 <20241001093105.126dacd6@hermes.local>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241001093105.126dacd6@hermes.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/10/02 1:31, Stephen Hemminger wrote:
> On Tue, 1 Oct 2024 14:54:29 +0900
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
>> On 2024/09/30 0:33, Stephen Hemminger wrote:
>>> On Sun, 29 Sep 2024 16:10:47 +0900
>>> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>    
>>>> On 2024/09/29 11:07, Jason Wang wrote:
>>>>> On Fri, Sep 27, 2024 at 3:51 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2024/09/27 13:31, Jason Wang wrote:
>>>>>>> On Fri, Sep 27, 2024 at 10:11 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> On 2024/09/25 12:30, Jason Wang wrote:
>>>>>>>>> On Tue, Sep 24, 2024 at 5:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>>>
>>>>>>>>>> virtio-net have two usage of hashes: one is RSS and another is hash
>>>>>>>>>> reporting. Conventionally the hash calculation was done by the VMM.
>>>>>>>>>> However, computing the hash after the queue was chosen defeats the
>>>>>>>>>> purpose of RSS.
>>>>>>>>>>
>>>>>>>>>> Another approach is to use eBPF steering program. This approach has
>>>>>>>>>> another downside: it cannot report the calculated hash due to the
>>>>>>>>>> restrictive nature of eBPF.
>>>>>>>>>>
>>>>>>>>>> Introduce the code to compute hashes to the kernel in order to overcome
>>>>>>>>>> thse challenges.
>>>>>>>>>>
>>>>>>>>>> An alternative solution is to extend the eBPF steering program so that it
>>>>>>>>>> will be able to report to the userspace, but it is based on context
>>>>>>>>>> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
>>>>>>>>>> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
>>>>>>>>>> and vhost_net).
>>>>>>>>>>      
>>>>>>>>>
>>>>>>>>> I wonder if we could clone the skb and reuse some to store the hash,
>>>>>>>>> then the steering eBPF program can access these fields without
>>>>>>>>> introducing full RSS in the kernel?
>>>>>>>>
>>>>>>>> I don't get how cloning the skb can solve the issue.
>>>>>>>>
>>>>>>>> We can certainly implement Toeplitz function in the kernel or even with
>>>>>>>> tc-bpf to store a hash value that can be used for eBPF steering program
>>>>>>>> and virtio hash reporting. However we don't have a means of storing a
>>>>>>>> hash type, which is specific to virtio hash reporting and lacks a
>>>>>>>> corresponding skb field.
>>>>>>>
>>>>>>> I may miss something but looking at sk_filter_is_valid_access(). It
>>>>>>> looks to me we can make use of skb->cb[0..4]?
>>>>>>
>>>>>> I didn't opt to using cb. Below is the rationale:
>>>>>>
>>>>>> cb is for tail call so it means we reuse the field for a different
>>>>>> purpose. The context rewrite allows adding a field without increasing
>>>>>> the size of the underlying storage (the real sk_buff) so we should add a
>>>>>> new field instead of reusing an existing field to avoid confusion.
>>>>>>
>>>>>> We are however no longer allowed to add a new field. In my
>>>>>> understanding, this is because it is an UAPI, and eBPF maintainers found
>>>>>> it is difficult to maintain its stability.
>>>>>>
>>>>>> Reusing cb for hash reporting is a workaround to avoid having a new
>>>>>> field, but it does not solve the underlying problem (i.e., keeping eBPF
>>>>>> as stable as UAPI is unreasonably hard). In my opinion, adding an ioctl
>>>>>> is a reasonable option to keep the API as stable as other virtualization
>>>>>> UAPIs while respecting the underlying intention of the context rewrite
>>>>>> feature freeze.
>>>>>
>>>>> Fair enough.
>>>>>
>>>>> Btw, I remember DPDK implements tuntap RSS via eBPF as well (probably
>>>>> via cls or other). It might worth to see if anything we miss here.
>>>>
>>>> Thanks for the information. I wonder why they used cls instead of
>>>> steering program. Perhaps it may be due to compatibility with macvtap
>>>> and ipvtap, which don't steering program.
>>>>
>>>> Their RSS implementation looks cleaner so I will improve my RSS
>>>> implementation accordingly.
>>>>   
>>>
>>> DPDK needs to support flow rules. The specific case is where packets
>>> are classified by a flow, then RSS is done across a subset of the queues.
>>> The support for flow in TUN driver is more academic than useful,
>>> I fixed it for current BPF, but doubt anyone is using it really.
>>>
>>> A full steering program would be good, but would require much more
>>> complexity to take a general set of flow rules then communicate that
>>> to the steering program.
>>>    
>>
>> It reminded me of RSS context and flow filter. Some physical NICs
>> support to use a dedicated RSS context for packets matched with flow
>> filter, and virtio is also gaining corresponding features.
>>
>> RSS context: https://github.com/oasis-tcs/virtio-spec/issues/178
>> Flow filter: https://github.com/oasis-tcs/virtio-spec/issues/179
>>
>> I considered about the possibility of supporting these features with tc
>> instead of adding ioctls to tuntap, but it seems not appropriate for
>> virtualization use case.
>>
>> In a virtualization use case, tuntap is configured according to requests
>> of guests, and the code processing these requests need to have minimal
>> permissions for security. This goal is achieved by passing a file
>> descriptor that represents a tuntap from a privileged process (e.g.,
>> libvirt) to the process handling guest requests (e.g., QEMU).
>>
>> However, tc is configured with rtnetlink, which does not seem to have an
>> interface to delegate a permission for one particular device to another
>> process.
>>
>> For now I'll continue working on the current approach that is based on
>> ioctl and lacks RSS context and flow filter features. Eventually they
>> are also likely to require new ioctls if they are to be supported with
>> vhost_net.
> 
> The DPDK flow handling (rte_flow) was started by Mellanox and many of
> the features are to support what that NIC can do. Would be good to have
> a tc way to configure that (or devlink).

Yes, but I would rather only implement the ioctl without flow handling 
for now. My purpose of implementing RSS in the kernel is to report hash 
values to the guest that has its own network stack in the virtualization 
context. tc-bpf would be suffice for DPDK, which does not have such a 
requirement.

Having an access to the in-kernel RSS implementation also saves the 
trouble of implementing an eBPF program for RSS, but DPDK already does 
have such a program so it makes little difference. There may be also 
performance improvement because I'm optimizing the in-kernel RSS 
implementation with ffs(), which is currently not available to eBPF, but 
there is also a proposal to expose ffs() to eBPF*.

For now, I will keep the patch series small by having only the ioctl 
interface. Anyone who finds the feature useful for tc can take it and 
add a tc interface in the future.

Regards,
Akihiko Odaki

* https://lore.kernel.org/bpf/20240131155607.51157-1-hffilwlqm@gmail.com/#t
