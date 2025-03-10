Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074DA223324
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594610; cv=none; b=HLb81ObQyD1Sh8rEW9cVYg4f9/AlNYZt04hnLtgXyUnPwFqGUzu4Bg+47VS6hVYTHxJ8tz/gc9HI9XmKYQcvIuxrBKSYqAx2vWfDbAAy24evJFBz8mA/HEGD9H5ig17NbkM1uSIDCI1AVg+DlwzJf48iCy07u+Z3IlGcRLwbJ80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594610; c=relaxed/simple;
	bh=bYJgB5J1rWOwdnYTlKo6V+nCLjOSgt8m+waOje7Vwoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G46UrcOyUowO9pdXrDQmmbd92uxdWK0j4WijO4Ktk1zFqi0oFcTIsdABku59ARPdy5qJELBNwvQDFA9aCtC6MjnodprfZmXDd9Bdf02TgyV56kpmv2HSRpCswkKJKOPOPoI+2VD4pc2LFCniZu9a6/RTChZ90kN/mfGmQwfwPWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=pOQeL+lV; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="pOQeL+lV"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8FCB840DF6
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 08:16:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pcQW5CKKx3OT for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Mar 2025 08:16:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 28CFF40691
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 28CFF40691
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=pOQeL+lV
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 28CFF40691
	for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 08:16:47 +0000 (UTC)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2254e0b4b79so35374015ad.2
        for <virtualization@lists.linux-foundation.org>; Mon, 10 Mar 2025 01:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1741594606; x=1742199406; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZmMfWN/YjTztlUTbhbD2bh8ol9HLPI3qHdmgf2q4Pyk=;
        b=pOQeL+lVJhkDNTqYu0l+XM/NOF340ZpOXvMey7+PE+0zL4Y+7siN8dlP3V09erkByJ
         elMzwA4Izpn09NWAMIcxeqVlhtGjgm04KtuKy5LJEziJr7Vzi1wrOQaBw4YxSvZsCCZg
         4JFgNSavIu9QKEIRj0VfbPyS7N94KZZkqDZf4MnSqWYk8/KPVh2Pmf92uKj2AMFpUBf6
         97uNn9TDcx+1hlY+fG58mKZhHddW0wzPdDms4o0AFe13Z6f+B300aNWeVFByU+BeuW/V
         5KzpC+3eu0L3cB32elYUXeh9emQS0yivz7/+D3Ovyngm5Vc7AJlhBWVVDB46Wm3YqL7I
         UDbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741594606; x=1742199406;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmMfWN/YjTztlUTbhbD2bh8ol9HLPI3qHdmgf2q4Pyk=;
        b=V1rTbGDYjti/LyuUeWr1uQuORBvJr9c+ITdiYvSwjXbM1h+5hStVCLqMImVL1+GRLD
         U1Rbl9KrINpDaCjr8wjDOlRg8k9/4oTqDMGhvt4eZRUAVgGzVbIOmAsph/X6s4f5H8WY
         soiUGIenU5eNXdtJQp0ZAQ6IlIiVHXJGjSlvNLWZAl0QRQRTo6wJfW0vRTcHcxJXGglc
         p0dVQQvTDskxKwtGWL4+iBaDaNjezmAocIRlDa2wrwb12QlX8CUIn3/PpnE83eQ/NF2A
         uN+XNB/125VBO/HKNfi6AmyPv3SyiZWABiIMvSDSMsiCWQbjsAjRTDo1Poc92CDnwPGJ
         ZPXg==
X-Forwarded-Encrypted: i=1; AJvYcCXkR9pl6BKGukaGv2HcvedsPw8J4auhu922kRBbaMGBnkZmLCAjIzZ7cUMqiKVsnQPhTjMtGBbU3XVl8I6sbA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YxxjldmiXkYQVqdlfNwTPDW7Ja0keKt7LQTwVRhwL7+0QNW+h98
	74ggtbUqEqWvP9PrB1H9h+y2JkOqZCcOw3QHErltV4b2/YuMgjvTUKPLatC4MT8=
X-Gm-Gg: ASbGncvRK9oZLg0quvDQxrRlkdxFmQLYJabozN/mBnZhk73blN2UD5NQQzNuP9hCcje
	bpNCO06Ip6ClOlQhAXoIWyZXQJAS1GTYmGkL5hWxYWjYgMIz81XM/qT5oOqz4bOliclhgdcu7zv
	zVJnFh1Z1+KdMWynQ4IcjMUw6TFZRTVgLE9g0rTtk/PXqBPBxF/ICzxcH+cBoSX1eNojCDdcpkM
	vUv2hlWT4HkhAE4WRD+0AtnVmWOb0Du+Qq29dTigacZ0u9qMjNdxvQ8xZ8WI6K6ZNfZMw3lzGvn
	qlE/fea9r2X3aiyqipeu7I1ixtTPL6OzuC0B3ak3be7tTxo41FshpePu3A==
X-Google-Smtp-Source: AGHT+IF0rPYRbicP0/CqimCD18L/ZR4wVPSR4hAOvttkF0NCrjknQOFhZJD3NGgEaMlKRFPN5jMntA==
X-Received: by 2002:a05:6a00:4f90:b0:736:3d6c:aa64 with SMTP id d2e1a72fcca58-736aab13b03mr19832278b3a.21.1741594606209;
        Mon, 10 Mar 2025 01:16:46 -0700 (PDT)
Received: from [157.82.205.237] ([157.82.205.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736e085c030sm819390b3a.14.2025.03.10.01.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 01:16:45 -0700 (PDT)
Message-ID: <5cfedd24-de7c-484b-afa7-ddb4828fb9e8@daynix.com>
Date: Mon, 10 Mar 2025 17:16:41 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/6] tun: Introduce virtio-net hash feature
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
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250307-rss-v9-0-df76624025eb@daynix.com>
 <20250307-rss-v9-3-df76624025eb@daynix.com>
 <CACGkMEsNHba=PY5UQoH1zdGQRiHC8FugMG1nkXqOj1TBdOQrww@mail.gmail.com>
 <CACGkMEtCEwSB7XvCg7_8ebkcM8o2s8JB2Err2f153L-_i2KtxA@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEtCEwSB7XvCg7_8ebkcM8o2s8JB2Err2f153L-_i2KtxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/03/10 13:01, Jason Wang wrote:
> On Mon, Mar 10, 2025 at 11:55 AM Jason Wang <jasowang@redhat.com> wrote:
>>
>> On Fri, Mar 7, 2025 at 7:01 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> Hash reporting
>>> ==============
>>>
>>> Allow the guest to reuse the hash value to make receive steering
>>> consistent between the host and guest, and to save hash computation.
>>>
>>> RSS
>>> ===
>>>
>>> RSS is a receive steering algorithm that can be negotiated to use with
>>> virtio_net. Conventionally the hash calculation was done by the VMM.
>>> However, computing the hash after the queue was chosen defeats the
>>> purpose of RSS.
>>>
>>> Another approach is to use eBPF steering program. This approach has
>>> another downside: it cannot report the calculated hash due to the
>>> restrictive nature of eBPF steering program.
>>>
>>> Introduce the code to perform RSS to the kernel in order to overcome
>>> thse challenges. An alternative solution is to extend the eBPF steering
>>> program so that it will be able to report to the userspace, but I didn't
>>> opt for it because extending the current mechanism of eBPF steering
>>> program as is because it relies on legacy context rewriting, and
>>> introducing kfunc-based eBPF will result in non-UAPI dependency while
>>> the other relevant virtualization APIs such as KVM and vhost_net are
>>> UAPIs.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Tested-by: Lei Yang <leiyang@redhat.com>
>>> ---
>>>   Documentation/networking/tuntap.rst |   7 ++
>>>   drivers/net/Kconfig                 |   1 +
>>>   drivers/net/tap.c                   |  68 ++++++++++++++-
>>>   drivers/net/tun.c                   |  98 +++++++++++++++++-----
>>>   drivers/net/tun_vnet.h              | 159 ++++++++++++++++++++++++++++++++++--
>>>   include/linux/if_tap.h              |   2 +
>>>   include/linux/skbuff.h              |   3 +
>>>   include/uapi/linux/if_tun.h         |  75 +++++++++++++++++
>>>   net/core/skbuff.c                   |   4 +
>>>   9 files changed, 386 insertions(+), 31 deletions(-)
> 
> [...]
> 
>>> + *
>>> + * The %TUN_VNET_HASH_REPORT flag set with this ioctl will be effective only
>>> + * after calling the %TUNSETVNETHDRSZ ioctl with a number greater than or equal
>>> + * to the size of &struct virtio_net_hdr_v1_hash.
>>
>> So you had a dependency check already for vnet hdr len. I'd still
>> suggest to split this into rss and hash as they are separated
>> features. Then we can use separate data structure for them instead of
>> a container struct.
>>
> 
> Besides this, I think we still need to add new bits to TUNGETIFF to
> let userspace know about the new ability.

The userspace can peform TUNGETVNETHASHCAP and see if it results in EINVAL.

Regards,
Akihiko Odaki

> 
> Thanks
> 

