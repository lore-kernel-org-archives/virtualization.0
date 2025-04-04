Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5171ACED9
	for <virtualization@lists.linux.dev>; Fri,  4 Apr 2025 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743759834; cv=none; b=LT2GAyPCBXtc462xLZO6ziGlm+I/JPJArQV89T03cSEcP4FOwv0IgslO0SRzX1TjmypvKoif6L3nr9zVSXX2x+vY0/WDFWFzcPn992/vV/XkhIpwOJqiJ2G1KSQyKDPWzvQFdOadWsaI7SyMUzT7cRUv5sHa+moC0hVN+ZRPbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743759834; c=relaxed/simple;
	bh=Cy5R4h2CMeYfcKq3JmLBbPpLA/1mufrC04ciYKMxz8M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=TPIexoIaLPwg1Zt30h9PCyfIftxQVizuXHYreLgWjK5ncrzmtY2+/fjssEr3VnpbrEysxpH7ODTEPFMymQo1WTc/hl3Ntz62WDyHv9OxqcC1QIveDFAcUccmDa1W4OAxiCdme7bmLYHLVsx+utLEnkKiRoJKB29SHQHqsV59x9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SH02lXba; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH02lXba"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736b98acaadso1805272b3a.1
        for <virtualization@lists.linux.dev>; Fri, 04 Apr 2025 02:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743759832; x=1744364632; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2dp9HC2qkGWoowunW2raQA7ZBkf3B+GmnuL0MF1UqM0=;
        b=SH02lXbaJqBMkQIXvMxqsrjH+/uBI7rVRHchlR5AVpu/s36vwlESDwjvIFFNbSdnYX
         TKvTr6ZkQXbSpLmuZiDiufN0cevuzFwtyo/9daCFXyboSm/DWHh/dlxlDTd0Lqd4aUxp
         8J6DWclaB5VlV/mHJ7BcQl0SdzzG0KtivrAQ0w3ujLr0fp082/HWvA2LRAy+MWfFXQHQ
         KLfo1CvdE6nin05WY+sfdrCCISQhre7lhu1uTUstZpwz+lkaV4+UkCiTYLn9eeB54sZv
         2HTTSD1EskISPXitRSoDJjnFMxsdusBan8oFj3YFQ9mQ5A+CgX0SB0K46JcRgwxYmRHp
         3Q1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743759832; x=1744364632;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2dp9HC2qkGWoowunW2raQA7ZBkf3B+GmnuL0MF1UqM0=;
        b=ZqQvSYuju9Jebe8od88GnKpdgJKXFJNFuGFNwrsTMDTZK6v3n2mgiNuFS0WyksKgRd
         +XL1NvevHw0N7mfqnYz3vr77D57lOTUOjNaaIvFy1ymshEMiqKK9+OKacc8mo0nxveX7
         KeV/J6YqYs9ptaM4rT3atUa82rqFzZNAXmGMLj6h0DxTcDODtcrPZd8Yoq+DUFxxZBav
         Q7Sw516J/uctI/rxiWysxRoBC+brj8pOOSXm125pw9O5Ma2BfXe3Xg3EaDTckzoL3hOB
         F7z0HnEDPpX4n0oF90Xk3cS4flHmSB2t6vXTD/DaOC4oDn4BLqtV6I1obRKxefGBBEiZ
         x+Wg==
X-Gm-Message-State: AOJu0YyT+KM5CJJi7YwnWWoAKWphoBoRxV4H8xIdd3xJEIhJ5UGYtRYQ
	4QUfdoo/CWMWNwgxzaNN+YfTBEBOqyTnnXEu/tFGRPZX33fxMRD49avZUPmE
X-Gm-Gg: ASbGncvjYPJLdafK0aW8k+T74JAyRbF3sMDMRlmXkYiM9Avad1Ky7BIPBwRenK2PptL
	Y/UOra7nDnWCOW6VT1gf7zOCj199KGGsypzlwIHX2lIGwk1EJF/80CK8TN7ePGXylSBEay0mgdN
	s/akcY4vlNtSS/OtX1jJP5DulR68oI/NOcwbDEeKKDy4WdQVyBCA5suR1aHzruWED7yxQuPQ+yW
	YC6AtOrGfojyEwH+bLxcr7F+WmItgKXaP8yvRJISVHYZ4LikGVpK+3Rwh/NBcyBkXMKSkPdxwU0
	zvm30XQ9WgtGgq3zp7kfhFGhIOVdbTvZ1Iq/0Nf7P5Jd4D6284dGa2hAOLPYCwHgaVkrjCP2+cR
	+8feXhpkAdq1vWV7bzpBzgnI=
X-Google-Smtp-Source: AGHT+IHla/lWi8LDRu2Y+SJC0LCiuXNaD4R1egj1fCZ39xp2lt9qKISE1OlySN6DP6Qk24H6tK11sw==
X-Received: by 2002:a17:90b:6ce:b0:2ff:6e72:b8e2 with SMTP id 98e67ed59e1d1-306a48f3923mr3567005a91.31.1743759832307;
        Fri, 04 Apr 2025 02:43:52 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4e:bd30:f724:d4da:7a88:b9d5? ([2001:ee0:4f4e:bd30:f724:d4da:7a88:b9d5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3057ca47ec7sm3553256a91.15.2025.04.04.02.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 02:43:51 -0700 (PDT)
Message-ID: <53b94412-c550-4d90-9275-5b087609b8e3@gmail.com>
Date: Fri, 4 Apr 2025 16:43:44 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when setting up xdp
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250402054210.67623-1-minhquangbui99@gmail.com>
 <8aad5ff9-6eab-411d-9569-9a2303561ac0@gmail.com>
Content-Language: en-US
In-Reply-To: <8aad5ff9-6eab-411d-9569-9a2303561ac0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/3/25 17:43, Bui Quang Minh wrote:
> On 4/2/25 12:42, Bui Quang Minh wrote:
>> When setting up XDP for a running interface, we call napi_disable() on
>> the receive queue's napi. In delayed refill_work, it also calls
>> napi_disable() on the receive queue's napi. This can leads to deadlock
>> when napi_disable() is called on an already disabled napi. This commit
>> fixes this by disabling future and cancelling all inflight delayed
>> refill works before calling napi_disabled() in virtnet_xdp_set.
>>
>> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 7e4617216a4b..33406d59efe2 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -5956,6 +5956,15 @@ static int virtnet_xdp_set(struct net_device 
>> *dev, struct bpf_prog *prog,
>>       if (!prog && !old_prog)
>>           return 0;
>>   +    /*
>> +     * Make sure refill_work does not run concurrently to
>> +     * avoid napi_disable race which leads to deadlock.
>> +     */
>> +    if (netif_running(dev)) {
>> +        disable_delayed_refill(vi);
>> +        cancel_delayed_work_sync(&vi->refill);
>> +    }
>> +
>>       if (prog)
>>           bpf_prog_add(prog, vi->max_queue_pairs - 1);
>>   @@ -6004,6 +6013,8 @@ static int virtnet_xdp_set(struct net_device 
>> *dev, struct bpf_prog *prog,
>>               virtnet_napi_tx_enable(&vi->sq[i]);
>>           }
>>       }
>> +    if (netif_running(dev))
>> +        enable_delayed_refill(vi);
> While doing some testing, it look likes that we must call 
> try_fill_recv to resume the rx path. I'll do more testing and send a 
> new v2 patch.

I've sent a new patch here: 
https://lore.kernel.org/virtualization/20250404093903.37416-1-minhquangbui99@gmail.com/T/#u. 
As the commit title has changed a little bit, I don't use v2 tag.

Thank you,
Quang Minh.


