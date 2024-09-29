Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9839E135A69
	for <virtualization@lists.linux-foundation.org>; Sun, 29 Sep 2024 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727593856; cv=none; b=DAR6QsCwGuQ3ZUpE5DPv7YHmAGeblIfBEoII9z1Kt5pZXzPYB7t/cVUdgGHYzBI3/3zeXI0uB/yJXuf8EpLa8hw0CgLMURNtf66CHFWgnM7NliG1Cz8z6qaRV1ZwLrt6O+6qW9hsl3pSOKM/962kV0JPKstu4I+RtcaF0gawquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727593856; c=relaxed/simple;
	bh=n4Jy/g4Eh6+BSVVGvl01aw6en9RlnVRu3g0HXU8COnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tA7i01atGTwzY/kywYJTCwugj1Q/5a+rD07xlGsB3j2c8JcTmDokdDYVSEmE3Y4fyfmDX+jXDhD6LEKGI73NZ/KqcVNJx3kKDXLZWr013x9Ex0+1CPktEdm/f39Ou1grzafhN99HtJphoQVfxEL9oLEyhjBHd3SycNMw+UV2BMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=3TxBCJR2; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="3TxBCJR2"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4A0CB4027F
	for <virtualization@lists.linux-foundation.org>; Sun, 29 Sep 2024 07:10:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6gK1s4lGBm3r for <virtualization@lists.linux-foundation.org>;
 Sun, 29 Sep 2024 07:10:54 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D75B74011B
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D75B74011B
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=3TxBCJR2
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D75B74011B
	for <virtualization@lists.linux-foundation.org>; Sun, 29 Sep 2024 07:10:53 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2e053f42932so2539038a91.0
        for <virtualization@lists.linux-foundation.org>; Sun, 29 Sep 2024 00:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727593853; x=1728198653; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wupXfiTFRgbbCCMXc+w3GmGZhuh2PGEq/8NKT31sCcc=;
        b=3TxBCJR2JVYFbYtg+P1+DsPtwRuD/Dm8UtkhRcvVw6fK2JGVgZN+mRtixLaw/d5BD0
         ZIfhO9rOZ9X9pmAf5Vy0MVUSovUzPUFu1jDIASjaE94sni2gOZII7vAjhYhA0s3yl6fL
         dV3Gu52aGUNkH7doXWbxgPiLc9YThvTsrVi5oGmMJ5GfPCdRLRLkApEkZfAyRTLxxyvA
         vFDzLkZ2HYjsGUuzeJKjewfLxZluQOoYC+YEB5AOH2GF9Am1VRpBC7Qfnev4Iz3qtbEt
         CiKLRiIAudbjC0siOS2leOvQZlsa7sJLjiFk09uWE9/p3qBbNgstd3DtNGFBQKXjI6fU
         b5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727593853; x=1728198653;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wupXfiTFRgbbCCMXc+w3GmGZhuh2PGEq/8NKT31sCcc=;
        b=g9lZjvlJorETSnArGGvLMwrcQGVasP+LsS00s/bgWMjYUoo6ffhc0tfyKFi8yAc+NX
         3mlmzqxcWBvXDLpJ4lMEZxK+vop+BfNTXD8PcEDmfzwxJ3itMEog5AhXIZc8o/trwYEt
         klMSojTDcnPjrsYVQHoZH8XEyhlaK7zq09CQ0JqPPYIsHb3GkuSY0we6C3RK+WXO2uWI
         sImWNUySrCydOLS8kAftuhusjP3g3JIbMQEvNEWhz2uWpgTKC+qLvk2scPm0vDYgyHgs
         RUd5WiCg5BS7ARPsMPurX0bGSeyFnveMzCuG+rmkYTvHVisru6gkeonsBae/h9prUxQ3
         yv7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUha65NAlGiUc85WU/9zyN7gejmn90zJF/AuonxOtr75KPaMo1XM+akk82W6ZPwXamBLpL/WLrMaM6lCFOl6g==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywm9Jeo8lozx15JLtbzZp2CuPhOCS4evYm52QQQ5kgVNUr7rmfg
	xABfiA9QZvW7/wBWMjUshHzXjqTiGI3P8XxaVjcedv9+iP1MCktxVq3JLVBPNSY=
X-Google-Smtp-Source: AGHT+IGrcYY05To+/yLZrdZKHUuaT4lGmCtj4wsgyrCWwclUUaolM2+fnTgp4t6z/cgOYbzvWvn9bg==
X-Received: by 2002:a17:90a:ad91:b0:2d4:924:8891 with SMTP id 98e67ed59e1d1-2e0b8ede168mr9323964a91.38.1727593852980;
        Sun, 29 Sep 2024 00:10:52 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c7942csm5324497a91.16.2024.09.29.00.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Sep 2024 00:10:52 -0700 (PDT)
Message-ID: <447dca19-58c5-4c01-b60e-cfe5e601961a@daynix.com>
Date: Sun, 29 Sep 2024 16:10:47 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 0/9] tun: Introduce virtio-net hashing feature
To: Jason Wang <jasowang@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
References: <20240924-rss-v4-0-84e932ec0e6c@daynix.com>
 <CACGkMEvMuBe5=wQxZMns4R-oJtVOWGhKM3sXy8U6wSQX7c=iWQ@mail.gmail.com>
 <c3bc8d58-1f0e-4633-bb01-d646fcd03f54@daynix.com>
 <CACGkMEu3u=_=PWW-=XavJRduiHJuZwv11OrMZbnBNVn1fptRUw@mail.gmail.com>
 <6c101c08-4364-4211-a883-cb206d57303d@daynix.com>
 <CACGkMEtscr17UOufUtyPp1OvALL8LcycpbRp6CyVMF=jYzAjAA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEtscr17UOufUtyPp1OvALL8LcycpbRp6CyVMF=jYzAjAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/09/29 11:07, Jason Wang wrote:
> On Fri, Sep 27, 2024 at 3:51 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/09/27 13:31, Jason Wang wrote:
>>> On Fri, Sep 27, 2024 at 10:11 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2024/09/25 12:30, Jason Wang wrote:
>>>>> On Tue, Sep 24, 2024 at 5:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> virtio-net have two usage of hashes: one is RSS and another is hash
>>>>>> reporting. Conventionally the hash calculation was done by the VMM.
>>>>>> However, computing the hash after the queue was chosen defeats the
>>>>>> purpose of RSS.
>>>>>>
>>>>>> Another approach is to use eBPF steering program. This approach has
>>>>>> another downside: it cannot report the calculated hash due to the
>>>>>> restrictive nature of eBPF.
>>>>>>
>>>>>> Introduce the code to compute hashes to the kernel in order to overcome
>>>>>> thse challenges.
>>>>>>
>>>>>> An alternative solution is to extend the eBPF steering program so that it
>>>>>> will be able to report to the userspace, but it is based on context
>>>>>> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
>>>>>> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
>>>>>> and vhost_net).
>>>>>>
>>>>>
>>>>> I wonder if we could clone the skb and reuse some to store the hash,
>>>>> then the steering eBPF program can access these fields without
>>>>> introducing full RSS in the kernel?
>>>>
>>>> I don't get how cloning the skb can solve the issue.
>>>>
>>>> We can certainly implement Toeplitz function in the kernel or even with
>>>> tc-bpf to store a hash value that can be used for eBPF steering program
>>>> and virtio hash reporting. However we don't have a means of storing a
>>>> hash type, which is specific to virtio hash reporting and lacks a
>>>> corresponding skb field.
>>>
>>> I may miss something but looking at sk_filter_is_valid_access(). It
>>> looks to me we can make use of skb->cb[0..4]?
>>
>> I didn't opt to using cb. Below is the rationale:
>>
>> cb is for tail call so it means we reuse the field for a different
>> purpose. The context rewrite allows adding a field without increasing
>> the size of the underlying storage (the real sk_buff) so we should add a
>> new field instead of reusing an existing field to avoid confusion.
>>
>> We are however no longer allowed to add a new field. In my
>> understanding, this is because it is an UAPI, and eBPF maintainers found
>> it is difficult to maintain its stability.
>>
>> Reusing cb for hash reporting is a workaround to avoid having a new
>> field, but it does not solve the underlying problem (i.e., keeping eBPF
>> as stable as UAPI is unreasonably hard). In my opinion, adding an ioctl
>> is a reasonable option to keep the API as stable as other virtualization
>> UAPIs while respecting the underlying intention of the context rewrite
>> feature freeze.
> 
> Fair enough.
> 
> Btw, I remember DPDK implements tuntap RSS via eBPF as well (probably
> via cls or other). It might worth to see if anything we miss here.

Thanks for the information. I wonder why they used cls instead of 
steering program. Perhaps it may be due to compatibility with macvtap 
and ipvtap, which don't steering program.

Their RSS implementation looks cleaner so I will improve my RSS 
implementation accordingly.

Regards,
Akihiko Odaki
