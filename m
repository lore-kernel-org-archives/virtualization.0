Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF3F223DD1
	for <virtualization@lists.linux.dev>; Tue,  3 Jun 2025 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748960343; cv=none; b=tyCyZvXLjNprvbwSzHDwt3QbLtLQ+HPNfBqo8J4YvFgF9mBuGSho+n6DYGtROowpZ/OWlB4K7He3yzOdlALRjHRq4CbwEtzZmYNeT6iRwNfsP3loUvBehiuwBY5+QD5QeMVscDnbyvL4UbJNTtUb3yidCOaqyPbEggI8r/wpWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748960343; c=relaxed/simple;
	bh=YTMw6hVIJ4tac7hSIaKesh8CBYHWVGFRHULIjD0JYGg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ms3yf3e7nZo4WG0WNhdZb/0daXWuAgOe4EA4AIjwqZz6vYXxN5swGelD0jt1+2BvN/YU/UvPIN85hb45nzO7up4No8QTz1msDxs3vY0zSBl8EeBQPd2BNOjkXESRm7U8QkbNWXiCkoJ/qDjzf8a5EDEW4bBT/iNXn71Iy7+QzCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH/8cSbN; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH/8cSbN"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b13e0471a2dso3611555a12.2
        for <virtualization@lists.linux.dev>; Tue, 03 Jun 2025 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748960341; x=1749565141; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GiI1DpFumaOXkG4kd/ldNkXDNVlluff0coHT3pCkZ4=;
        b=mH/8cSbNqmE81ZE7v3jW7kt/NALtrrvJq8e8RT6uefVF5KbKLXXc+20LqmNsrOLDGl
         eO0ArokD9BTRc82mF21urE97mnsT4P4VW4c5fEUOOnJ7h7wYp6aTmm+fs8WRD0NECFPc
         2xgWGD/YKzcOO6m3AEtyW2lxM/l5PeBRNmcIzKZ6P0frr3MI+QJOWgkZ9HZvgzO/yOnb
         rxbF4Dle0kK1TpQ/Ls7dFVJFeJYjW3q54iMif6xYfpHHEVszMmy4GdC81gYl9mdjronx
         KBSF5O9yRvFH3SnoHWqwup5y0qvIxn1aHfMghw5Z56YVTcV5H6yxNlJ4R3aOS7EOYWBT
         GN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748960341; x=1749565141;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GiI1DpFumaOXkG4kd/ldNkXDNVlluff0coHT3pCkZ4=;
        b=TkOYCiwKMxF5VC326IEaOkQdjdyr1mK1TJ/u6Z2xploxN9EH148iSc/uzXKy8JSRpC
         IqFRd6avmPuhcU7p/V2/N30+5HsXSW7+UudmRbvXnVwpNMJCGUWxUCQEG1P3qGifa5Yl
         Krwc3y4PBiUqcKPhJc9hx3BsvqlRGSWs/f5SAuVBTgJ63fe+Q9qHcNYvZt7i0JH6LwmZ
         5f1x7UisKp+xjoIMvmiYFWJfOWEW6ZEz1l4stk4QH28/U0vM2I88cuYhMwI/kfjgmbfC
         xsh+Yvy6ibM5XS2qiuv9kUCsAaViJwLxskBpSp6dkFoRyOudAcLzUVoBfNrFpliJyZP4
         mPgg==
X-Forwarded-Encrypted: i=1; AJvYcCXpxa5OEKbpGzaby9rmxlRmyYeS4m6cnSyA9joUAPHob4A3WxUyoPdLTxc1wU7P71Tps0lRYRzsMAMJfH58Yw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzu4uVMq/Sh4VJhi9rRxsuFtXrF7tjWA7wZSD797wcMBpSLijC1
	g+fjrVHp/nh8iRqiS8t6pKFDQ5h6KYD7hCw6YJmVZCpsP27T2+oWDic0
X-Gm-Gg: ASbGncuF5IqR02tHUYZCuYrkynrAO8NRqZjCHSv6ZJDrx1s0V14zp4R/k8oKsoto99j
	wMu3ueRcKao3a0dujMC/s/RnOi9LbJsdqWopFRKPlmASoarqrMoPRC9CFWnER08TMWbF6U3DnlK
	isMmEaQ30x0xtmgij7u9U9zXgcE2531+dHYk+PH3ipgH+mO4+NUtB295kUvZIMmAhlnoDxN29N5
	EOwn3P28JiqSL2+TbY8tn8w/EcMC2izy/Tarr/OSWLYIn+owsH3x6dqhp0Z+i2juE+DjSRnh7+G
	SCLUigp6KjgsTNyD1v3FVXb02VJGKRsfdEegipsbbZPuJCbZykwdeY3cxFxBvAXD6Zmgtd6EYqG
	AysyhTDsu4E8lDAo79evbkFneYdCwfGIGquxBvnIf
X-Google-Smtp-Source: AGHT+IHYn7hiu2Jk3QqyG7TaSkPhOS5JI0kLYniE4Gj2hpCCxy1DnFsfHd9qOhBb9winlm+9+7HBEw==
X-Received: by 2002:a17:90b:2251:b0:311:d05c:947 with SMTP id 98e67ed59e1d1-3125044928bmr25109627a91.24.1748960340534;
        Tue, 03 Jun 2025 07:19:00 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:c672:ef11:a97b:5717? ([2001:ee0:4f0e:fb30:c672:ef11:a97b:5717])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-312db8eb19asm2158390a91.44.2025.06.03.07.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 07:19:00 -0700 (PDT)
Message-ID: <5c6323fc-e147-457a-98ae-df1d1fa7cd7e@gmail.com>
Date: Tue, 3 Jun 2025 21:18:51 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 2/2] selftests: net: add XDP socket tests
 for virtio-net
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-3-minhquangbui99@gmail.com> <aDhCfxHo3M5dxlpH@boxer>
 <fe162eed-fd44-4c18-a541-8243ccfc4252@gmail.com> <aDmaT1cmoRa6PaqK@boxer>
 <ef4ac528-3f91-4004-b47b-e758a5712d28@gmail.com> <aD3JjgW2oxdal5lE@boxer>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <aD3JjgW2oxdal5lE@boxer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 22:55, Maciej Fijalkowski wrote:
> On Sat, May 31, 2025 at 03:51:57PM +0700, Bui Quang Minh wrote:
>> On 5/30/25 18:45, Maciej Fijalkowski wrote:
>>> On Thu, May 29, 2025 at 09:29:14PM +0700, Bui Quang Minh wrote:
>>>> On 5/29/25 18:18, Maciej Fijalkowski wrote:
>>>>> On Tue, May 27, 2025 at 11:19:04PM +0700, Bui Quang Minh wrote:
>>>>>> This adds a test to test the virtio-net rx when there is a XDP socket
>>>>>> bound to it. There are tests for both copy mode and zerocopy mode, both
>>>>>> cases when XDP program returns XDP_PASS and XDP_REDIRECT to a XDP socket.
>>>>>>
>>>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>>> Hi Bui,
>>>>>
>>>>> have you considered adjusting xskxceiver for your needs? If yes and you
>>>>> decided to go with another test app then what were the issues around it?
>>>>>
>>>>> This is yet another approach for xsk testing where we already have a
>>>>> test framework.
>>>> Hi,
>>>>
>>>> I haven't tried much hard to adapt xskxceiver. I did have a look at
>>>> xskxceiver but I felt the supported topology is not suitable for my need. To
>>>> test the receiving side in virtio-net, I use Qemu to set up virtio-net in
>>>> the guest and vhost-net in the host side. The sending side is in the host
>>>> and the receiving is in the guest so I can't figure out how to do that with
>>>> xskxceiver.
>>> I see - couldn't the python side be executing xdpsock then instead of your
>>> own app?
>> I'm not aware of xdpsock. Could you give the path to that file?
> https://github.com/xdp-project/bpf-examples/tree/main/AF_XDP-example
>
> this is our go-to app side of AF_XDP.

Thanks, I'll take a look at it and try to use it for selftest if 
possible in next version.

Quang Minh.
