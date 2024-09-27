Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33BA1649CC
	for <virtualization@lists.linux-foundation.org>; Fri, 27 Sep 2024 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423462; cv=none; b=O5uxoJqbIi9H4cSyamEFPC78uDmIJzNY3M0Qqe4Pg4Sl6Z3cqMhll7Q86YzTRyVeAroVaFUCMDJ2Ds27f88f7HkEmkf6vPnUiRsfCMUBVrp3AkvBcXYvXg9NJ6Y/P3z3+cxoDTDFFE4E00ln1i9ZTv7ZVmnTdNfkvAuJKLtcPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423462; c=relaxed/simple;
	bh=1XWbA421ewP3G2P/HXsU+35TLSJuYb8F5115d2JuIes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gIuIky1FQo5DIlWYIuRX6r5CK7jamDtXqxaNoF3RhEUGdQhrwM9JArGO7xWOu9jDcnQhNPcT9l+EtMPJ/OY4Qnfs21IT/iCZIgrehQAUJA/JiGsxO7ARvsXUFd9URg+kwg+Jt2vF0fImv2zN7OtlUMHAUKjvXVvc0AjVI1KRuiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=S19VutWb; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="S19VutWb"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 338A88450E
	for <virtualization@lists.linux-foundation.org>; Fri, 27 Sep 2024 07:51:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.898
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id d6aSoeKTHjPc for <virtualization@lists.linux-foundation.org>;
 Fri, 27 Sep 2024 07:51:00 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 14ACB8450D
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 14ACB8450D
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=S19VutWb
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 14ACB8450D
	for <virtualization@lists.linux-foundation.org>; Fri, 27 Sep 2024 07:50:59 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-719b17b2da1so1406936b3a.0
        for <virtualization@lists.linux-foundation.org>; Fri, 27 Sep 2024 00:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727423459; x=1728028259; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mrBjCEzDghLMu7q7zU/heNlCn+vyTex908H4IY9f3o=;
        b=S19VutWbOmjbb0hN6e8odrrsP4iCpYPlgg3oIh3OKire9NBaWl9ET8G9zfFKGeEAbY
         F+RpCOxVVA24CU32u/gUWZQWicMUYQ+84vlkPbs72WHcVJn6U/59bMouuS8Lg+0wEMY9
         IRLkp33j7vXyypCQbW1I7N/pViP4EHVNUNhi+anqE28QXGTiUTGIHDEGC/cxcmGmffLW
         VafzUK9zctiDzsEEHrY52mmn571CYoRbThS0yzCgny7hQ9YUe+geLIDoyNY1gnyH1+nO
         IVl6rHHayIAXTz4O+0Iiqcw2LUh+/gnJ28aeYRyR5AOpfOr84AsHTeiQcIQlmXSqT12G
         zJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727423459; x=1728028259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mrBjCEzDghLMu7q7zU/heNlCn+vyTex908H4IY9f3o=;
        b=VbuA8rGIBTtTy1tB0pMn6dOV7/wcW9LJyphnHqrbDi3R5X9BmAonFhpUu+bdiUV41I
         DuhbmHCFxGHC+rtgkF1Nd4QPlZ3QFf0gGjNel1BeDBDjRStbBfMQ7ojP4TOPrUbgLFMT
         ZXsr/juPT5X4Q5lPe5iHY2u6QO6uceUcaJT32Qs1yn22EQTfnoZmPtK9sLbzzPplkMgq
         9B01JSsW9W5mUTe72iy25zPxhCnkoNE+8qbVzeiWlLVGuo77r0Wv75e0WCf+J+ilr8P8
         XZFnAJGTlu5fZfgbZ+HbtR0bNKUJLRVZX/PkyOnlSBCZirgSoN+O3Rl2ncg4RT9TSoqd
         MwAA==
X-Forwarded-Encrypted: i=1; AJvYcCXD7BEGozHDPuDWUedzAcHVARR7ka5rmmB/zGxzVeIi2QsLIxX4NxWBoz/8uAfZM8PbpP++9dSCIvucx4vYew==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YyqxwEUmy2VDxsIBXI87L+D1oilr2zIwI24TYGSGjnNv7fmUUfK
	UMZ6KP59D/HwxvB9a69jwlwxUMYH4AW4U5AEeLekmzdKS19ySN/Ba8SOvgmc5wc=
X-Google-Smtp-Source: AGHT+IHo6DRnQxWatrhP0ZF10f+nLGL64WMuTqlvD8bPjr4v7ZsMqd6qebmeuqkhoZIrakB8io6gqA==
X-Received: by 2002:a05:6a00:1806:b0:714:1a7c:b727 with SMTP id d2e1a72fcca58-71b25f36725mr3632502b3a.8.1727423459264;
        Fri, 27 Sep 2024 00:50:59 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b2652bb69sm1009571b3a.150.2024.09.27.00.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 00:50:58 -0700 (PDT)
Message-ID: <6c101c08-4364-4211-a883-cb206d57303d@daynix.com>
Date: Fri, 27 Sep 2024 16:50:54 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEu3u=_=PWW-=XavJRduiHJuZwv11OrMZbnBNVn1fptRUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/09/27 13:31, Jason Wang wrote:
> On Fri, Sep 27, 2024 at 10:11 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/09/25 12:30, Jason Wang wrote:
>>> On Tue, Sep 24, 2024 at 5:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> virtio-net have two usage of hashes: one is RSS and another is hash
>>>> reporting. Conventionally the hash calculation was done by the VMM.
>>>> However, computing the hash after the queue was chosen defeats the
>>>> purpose of RSS.
>>>>
>>>> Another approach is to use eBPF steering program. This approach has
>>>> another downside: it cannot report the calculated hash due to the
>>>> restrictive nature of eBPF.
>>>>
>>>> Introduce the code to compute hashes to the kernel in order to overcome
>>>> thse challenges.
>>>>
>>>> An alternative solution is to extend the eBPF steering program so that it
>>>> will be able to report to the userspace, but it is based on context
>>>> rewrites, which is in feature freeze. We can adopt kfuncs, but they will
>>>> not be UAPIs. We opt to ioctl to align with other relevant UAPIs (KVM
>>>> and vhost_net).
>>>>
>>>
>>> I wonder if we could clone the skb and reuse some to store the hash,
>>> then the steering eBPF program can access these fields without
>>> introducing full RSS in the kernel?
>>
>> I don't get how cloning the skb can solve the issue.
>>
>> We can certainly implement Toeplitz function in the kernel or even with
>> tc-bpf to store a hash value that can be used for eBPF steering program
>> and virtio hash reporting. However we don't have a means of storing a
>> hash type, which is specific to virtio hash reporting and lacks a
>> corresponding skb field.
> 
> I may miss something but looking at sk_filter_is_valid_access(). It
> looks to me we can make use of skb->cb[0..4]?

I didn't opt to using cb. Below is the rationale:

cb is for tail call so it means we reuse the field for a different 
purpose. The context rewrite allows adding a field without increasing 
the size of the underlying storage (the real sk_buff) so we should add a 
new field instead of reusing an existing field to avoid confusion.

We are however no longer allowed to add a new field. In my 
understanding, this is because it is an UAPI, and eBPF maintainers found 
it is difficult to maintain its stability.

Reusing cb for hash reporting is a workaround to avoid having a new 
field, but it does not solve the underlying problem (i.e., keeping eBPF 
as stable as UAPI is unreasonably hard). In my opinion, adding an ioctl 
is a reasonable option to keep the API as stable as other virtualization 
UAPIs while respecting the underlying intention of the context rewrite 
feature freeze.

Regards,
Akihiko Odaki
