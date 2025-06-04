Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7E823BF9C
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Jun 2025 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749021891; cv=none; b=V5x2eXGcb4uqgr6LzzWTnkPYEiWFdsXp2r7NKhXD1ZroBZf9PR/ohftpwIlhIqHskqu3ZLSp1bvUyO6jBga4OoavLljO1ZOTEbZ0FUItkKlRKCDf2jSuw6kK6kWKRub/KpgAq6fP7qMFtzADwErLDh1wtH4QYDC9qFmAs6dBncY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749021891; c=relaxed/simple;
	bh=eJaM9PF91eHJBG8Hc+d7PGAX8a/KIWNyoS3YQxQ6GVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iLCH9huAO0V0wHLb5VfhyMuM5d2JN5GbCulLq8F1KbeHjUs52OVZ96yXFkJE/ZZMcye7Ie8dEqJ4rMZGOS6fc8CvuCsQXaioD1+cXivJ5QiKWfGRVSxIoXBI/4xenZQNJ9/caesD6xFMYI1Ds0cv6wjBu4MxO1Laqg1n9Nfsltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=LneK+MNW; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="LneK+MNW"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 570ED40D00
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Jun 2025 07:24:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wFqQM4c2DABO for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Jun 2025 07:24:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=akihiko.odaki@daynix.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 9D9D541BC8
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none) header.from=daynix.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D9D541BC8
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=LneK+MNW
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9D9D541BC8
	for <virtualization@lists.linux-foundation.org>; Wed,  4 Jun 2025 07:24:48 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-b13e0471a2dso4080145a12.2
        for <virtualization@lists.linux-foundation.org>; Wed, 04 Jun 2025 00:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749021888; x=1749626688; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtGbzLUDxU2IB9qPjKURq38VfX8ZCpDlPYi0PWx3MpY=;
        b=LneK+MNWRetbofX5T4MF10nusqo0OdIWw81MSCvDncmjcvJ6tNASjpWVrfm+vrXDuc
         I5p/9YkSctdAxW4Zov7rGaApUQexSWCHOH504WGWzsOFk5Jn8JByvdIwSPsUS121CuVo
         jkZ+WqiTq8a1zNnp44DFvIuKKVKd5sxDYJm5ZjgnaFv6uHdFvzxBHHsO+U4+sBIshRWo
         M1FcebWi0BJVoFocWzbt08qScZ3QbBrylxvxOaBcwD50jcV5HOeoW2AP+d4yj8zhOL8d
         Qvwit/EzRN69ovI5LWhQszp0OvPicDgmKS7pw5DuIBTf1iEFqi+rGajcHCfOapM/Xixj
         jV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749021888; x=1749626688;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtGbzLUDxU2IB9qPjKURq38VfX8ZCpDlPYi0PWx3MpY=;
        b=AfWxmsqkfV1c9IYq8o9NU3XEofTzuCau3nuMLW696wrj3UqAterNo/RFNSoSCV2feq
         uJOXCq2cVrQC4GymRY2YgAiB7hqf+kZY8gO1iROKg0QIwzbiGASN4HoS2wQQq3gl+CaS
         eL5opxBPMdKastnlXrno7DQgyFtDskF1/XjKpPk2e8Zo1aXKCoqRsDP5RXazULjl8Gv5
         of1fKAoNm/1ShMrLR3MU4qb7KJVbzCJSt31r3mzX3cmf3AXmAiv5PGJCnmhxnQ2lVC7Q
         mncZCT39pQjIy28lDGBFFheMLjAUv91t+OmxptNorm8Y4nEGgboi99FQzFZlOIQLQPfg
         rsJA==
X-Forwarded-Encrypted: i=1; AJvYcCU0UV4d8u7vLubWnzBdlXWNOvhoHwtc2C7d14mN4amdUlGn+V3SFaDW/hZV6uXwVdKtlsZQMq6D1AQAH56scQ==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwVBXwqYUSIGRaOEKIjNQMyTVUF2/0z393iXug2sh/nZ/xXSZSc
	WgreSHfx+mABa7RPij5kw03AtsifjAD4tr5cne2KMmnKT0YKtCd7sWRjF6Fta5mUOb4=
X-Gm-Gg: ASbGncuarMEm1/0b21ei/EnKCk5M8w4bnhju0dszI3mcw60mtydOpLjcJPdt2qhlbiT
	Ctkvr/xY8NZo+/zcVZNSvoA1hvkqpgtctBfd0c4e3ibzETSndgeJXM07y3DNDFZAPEJZyo9wTOM
	ZMg1maTFVxLJfoNMg+VU2HMIpyO34w9IcLH38P0To1JO6N7aBJo8GHS0EOT3h3e+6w9MlDOM37u
	9WT0n8OHImS0aDfpLG/T9isVw5eg2zcOEjiLltghb2J3/hasztKqL5JqzfysOA7+bAAQ4tQG/7W
	w8312I/goyOHRRC9tNkmhsBFZkT/ZX/7oxWJjE/AE2e+YeFrq40V5cAnS5MyJ5az
X-Google-Smtp-Source: AGHT+IHXDTL1GYPRjqoXaAf0lXb/mQXNX5irqPQDyrCtJl+J8aEBhNquD8+cbiWqUJBWAylgDPuoqQ==
X-Received: by 2002:a05:6a20:6a03:b0:216:1c88:df46 with SMTP id adf61e73a8af0-21d22909953mr3036667637.0.1749021887895;
        Wed, 04 Jun 2025 00:24:47 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747affd478bsm10590024b3a.155.2025.06.04.00.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 00:24:47 -0700 (PDT)
Message-ID: <517d5838-3313-4b31-b96d-d471b062cd1a@daynix.com>
Date: Wed, 4 Jun 2025 16:24:42 +0900
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 03/10] tun: Allow steering eBPF program to
 fall back
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
References: <20250530-rss-v12-0-95d8b348de91@daynix.com>
 <20250530-rss-v12-3-95d8b348de91@daynix.com>
 <CACGkMEvVf0LrquZcWSv3vp-r44sTj0ZDnjwbwB20N0aU35+vxw@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvVf0LrquZcWSv3vp-r44sTj0ZDnjwbwB20N0aU35+vxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/06/04 10:27, Jason Wang wrote:
> On Fri, May 30, 2025 at 12:50 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> This clarifies a steering eBPF program takes precedence over the other
>> steering algorithms.
> 
> Let's give an example on the use case for this.
> 
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> ---
>>   Documentation/networking/tuntap.rst |  7 +++++++
>>   drivers/net/tun.c                   | 28 +++++++++++++++++-----------
>>   include/uapi/linux/if_tun.h         |  9 +++++++++
>>   3 files changed, 33 insertions(+), 11 deletions(-)
>>
>> diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
>> index 4d7087f727be..86b4ae8caa8a 100644
>> --- a/Documentation/networking/tuntap.rst
>> +++ b/Documentation/networking/tuntap.rst
>> @@ -206,6 +206,13 @@ enable is true we enable it, otherwise we disable it::
>>         return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
>>     }
>>
>> +3.4 Reference
>> +-------------
>> +
>> +``linux/if_tun.h`` defines the interface described below:
>> +
>> +.. kernel-doc:: include/uapi/linux/if_tun.h
>> +
>>   Universal TUN/TAP device driver Frequently Asked Question
>>   =========================================================
>>
>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>> index d8f4d3e996a7..9133ab9ed3f5 100644
>> --- a/drivers/net/tun.c
>> +++ b/drivers/net/tun.c
>> @@ -476,21 +476,29 @@ static u16 tun_automq_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>>          return txq;
>>   }
>>
>> -static u16 tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb)
>> +static bool tun_ebpf_select_queue(struct tun_struct *tun, struct sk_buff *skb,
>> +                                 u16 *ret)
>>   {
>>          struct tun_prog *prog;
>>          u32 numqueues;
>> -       u16 ret = 0;
>> +       u32 prog_ret;
>> +
>> +       prog = rcu_dereference(tun->steering_prog);
>> +       if (!prog)
>> +               return false;
>>
>>          numqueues = READ_ONCE(tun->numqueues);
>> -       if (!numqueues)
>> -               return 0;
>> +       if (!numqueues) {
>> +               *ret = 0;
>> +               return true;
>> +       }
>>
>> -       prog = rcu_dereference(tun->steering_prog);
>> -       if (prog)
>> -               ret = bpf_prog_run_clear_cb(prog->prog, skb);
>> +       prog_ret = bpf_prog_run_clear_cb(prog->prog, skb);
>> +       if (prog_ret == TUN_STEERINGEBPF_FALLBACK)
>> +               return false;
> 
> This seems to break the uAPI. So I think we need a new ioctl to enable
> the behaviour

I assumed it is fine to repurpose one of the 32-bit integer values since 
32-bit integer is too big to specify the queue number, but it may not be 
fine. I don't have a concrete use case either.

Perhaps it is safer to note that TUNSETSTEERINGEBPF takes precedence 
over TUNSETVNETRSS to allow such an extension in the future (but without 
implementing one now).

> 
>>
>> -       return ret % numqueues;
>> +       *ret = (u16)prog_ret % numqueues;
>> +       return true;
>>   }
>>
>>   static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
>> @@ -500,9 +508,7 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
>>          u16 ret;
>>
>>          rcu_read_lock();
>> -       if (rcu_dereference(tun->steering_prog))
>> -               ret = tun_ebpf_select_queue(tun, skb);
>> -       else
>> +       if (!tun_ebpf_select_queue(tun, skb, &ret))
>>                  ret = tun_automq_select_queue(tun, skb);
>>          rcu_read_unlock();
>>
>> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
>> index 287cdc81c939..980de74724fc 100644
>> --- a/include/uapi/linux/if_tun.h
>> +++ b/include/uapi/linux/if_tun.h
>> @@ -115,4 +115,13 @@ struct tun_filter {
>>          __u8   addr[][ETH_ALEN];
>>   };
>>
>> +/**
>> + * define TUN_STEERINGEBPF_FALLBACK - A steering eBPF return value to fall back
>> + *
>> + * A steering eBPF program may return this value to fall back to the steering
>> + * algorithm that should have been used if the program was not set. This allows
>> + * selectively overriding the steering decision.
>> + */
>> +#define TUN_STEERINGEBPF_FALLBACK -1
> 
> Not a native speaker, consider it works more like XDP_PASS, would it
> be better to use "TUN_STERRING_PASS"?

That sounds indeed better to me.

Regards,
Akihiko Odaki
