Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E83148BA
	for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 15:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231988; cv=none; b=Y71MpwbZe59l6kBwrjSV0O9z9YL0WxWxIyH7zos2d0aTHzFIfzGotJR48UYxDRJxcC1QeYZB+adTPExYZRMPnj1R6BVjzTND5a6flILHIhQZC+fc1+oypNy8yxx3nP79Gj9ZTFOktJF7oH/fTbyT/ZHtZ+vEzKA2X/0onJkfIl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231988; c=relaxed/simple;
	bh=MvqFL77ZOpbzsQ/1SAvP195IIaFnAZVIetxFNQjBOxo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QmOtJud1lIN3KTrUW1FdO9wxyMUXxj0vEtrpPA9LqDdK3zO6C+75ddGHUhQPxTi9BopHGq3cNSWeNpdybIg9dfUaCHzjztTfrLg3QDULQAvCp8i4tnu/KFus/by8dhcIcIiHArVZQMPsF5kdvsjmWqlxt0omub9F/lqFsDfXm0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yf96Mu5u; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf96Mu5u"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-782e93932ffso869858b3a.3
        for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 08:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231986; x=1761836786; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mvQKZArUDl984Y6+2a44gK2373aPFXu4OMsdAqeqhEE=;
        b=Yf96Mu5ubfZqioc+/rLNgcfUJQXdgWFWBFCaUEgNFHWsHm0c60ZEDzMWaDeEwcjdys
         I4sr1da9X8LWouco5i1yCjEXl9435Bu3jvrp3yDHgrbtV7Soyx8YWURzc9dGdW5TGu92
         hEmrTr5eLEgrKq22ZckCQzl4E9Iy30m9osBj4EN2pI0zX2BBIy28Op4RJ/Hg/cuPDi96
         3qwQbjs75a/0CDMbtBAoIa1EMo7jLIO0O9rhhjYh25OzYwa4ysGoOQgDdJx1NHZPwOy6
         +WkKMY48RyJYglg5+Kn4UWFRKszZ3SxTLTQtTzxFldooyhTtJAgBZGuJ0qRV48dobmuP
         GGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231986; x=1761836786;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mvQKZArUDl984Y6+2a44gK2373aPFXu4OMsdAqeqhEE=;
        b=WADoIHnYZ8osY+AWXvESg7t6GkO5hgvpQDhPKuQ5uCFpN50iQEtdYg9Pld2cVJyGiT
         bXocm2UiNDTMJ+THLB9WCCGIbOpKemLNlOsOTNbUtKxt+bK/j+RgR2sC2L+F0v4V+pk5
         mD6x1m3X4W9C4zTbqjP7CHh33GP9RUYNR2wS1imy1FtCUt5fhWmQH9BUAc3vCO+XPojJ
         xRkwLbCywCHwTND5dPLuLAyANSdp3aubIulfI/GID2sPzkc2JWLdWK2JHVm6RSbbmTw+
         ljaKxthU+avKcTTSy0BlIaT7gn1tDNzSFFv8J7Ref/sGL6wlOLVi6/D2VIrbbvIGeR71
         i0Gg==
X-Forwarded-Encrypted: i=1; AJvYcCXNkXUjdzjAQvuvWDEpZ5MqrY4B4eTP7OswuTJFJLvxBqidrti4ctQM9KgK/w90ZgnTs6AtRgt5uxQ9JrCE4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzznhpugiXWumSxzu1LextfKL9rmitbWXwVUCRcpWTi5eytzFzW
	vyiO9AT7+W5gcVGSPEviERfHzlq2jqh4YrgJRhSHMXocCHAYIxJ35YvK
X-Gm-Gg: ASbGncsX4P6+DPnFqoxFkGw4zBLVPHUQGLI6G+PDsepv7JpctxqIrLcc46e7qw+K1Cu
	cBR0hHiPsXnUpMLc9vqt2T0ARQq6YN9Kb8p39iCcoDfuytN/gbvQkWDrxQpv/IF+HxUIHDxf9ZR
	UOZl32ze+BhXf7b3G2bz1cAoeDm0adyMIeFegyxhDrvWbAQww1kr9eO+ssPkpOoWdyMQZ5X9iat
	eowiY6OfeUNOPvTNewWOhazpJOwwDYTUhjZLnuzloyqn4HNqM0Bwn9uowI3AlMEtVeV5z8dZKh5
	LSAG+XuWgbfRNmhg3dd0yID/rqTC7CSK2HW9DR/DiJ5a8RMENjvYpto5FYkQ7Z1qfcIrkAeYixc
	AjRNH9wsgL5CA6tKC85KmPaN8BwmG/wABGsoVeSR+2L84Mamh3JNJb4YM+iYktoh6fecU74ofM2
	aaIaGQ4W0kC1zisLhTH1bubrjUcjltCl5JVwZ1pOFibwhDsNCk7h4=
X-Google-Smtp-Source: AGHT+IHmV7fyIld8QJGetoS158dw1CSCpgxRIKYp/OAxuCr3SCHqN63NNPoNTOeqZvoqcH0dXWwUhg==
X-Received: by 2002:a05:6a21:4613:b0:334:a9b0:1c87 with SMTP id adf61e73a8af0-334a9b01d07mr31195853637.1.1761231985521;
        Thu, 23 Oct 2025 08:06:25 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:5c6f:93f3:3b14:cac4? ([2001:ee0:4f4c:210:5c6f:93f3:3b14:cac4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c13ea9sm2360547a12.16.2025.10.23.08.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 08:06:25 -0700 (PDT)
Message-ID: <9598c7ae-fda5-4b7f-8e49-751ce7d5eafe@gmail.com>
Date: Thu, 23 Oct 2025 22:06:17 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] virtio-net: fix received length check in big
 packets
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
References: <20251022160623.51191-1-minhquangbui99@gmail.com>
 <1761206734.6182284-1-xuanzhuo@linux.alibaba.com>
 <cd963708-784a-4b1e-a44e-6fb799937707@gmail.com>
Content-Language: en-US
In-Reply-To: <cd963708-784a-4b1e-a44e-6fb799937707@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/25 21:39, Bui Quang Minh wrote:
> On 10/23/25 15:05, Xuan Zhuo wrote:
>> On Wed, 22 Oct 2025 23:06:23 +0700, Bui Quang Minh 
>> <minhquangbui99@gmail.com> wrote:
>>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>>> for big packets"), when guest gso is off, the allocated size for big
>>> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
>>> negotiated MTU. The number of allocated frags for big packets is stored
>>> in vi->big_packets_num_skbfrags.
>>>
>>> Because the host announced buffer length can be malicious (e.g. the 
>>> host
>>> vhost_net driver's get_rx_bufs is modified to announce incorrect
>>> length), we need a check in virtio_net receive path. Currently, the
>>> check is not adapted to the new change which can lead to NULL page
>>> pointer dereference in the below while loop when receiving length that
>>> is larger than the allocated one.
>>>
>>> This commit fixes the received length check corresponding to the new
>>> change.
>>>
>>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for 
>>> big packets")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>> ---
>>> Changes in v4:
>>> - Remove unrelated changes, add more comments
>>> Changes in v3:
>>> - Convert BUG_ON to WARN_ON_ONCE
>>> Changes in v2:
>>> - Remove incorrect give_pages call
>>> ---
>>>   drivers/net/virtio_net.c | 16 +++++++++++++---
>>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index a757cbcab87f..0ffe78b3fd8d 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -852,7 +852,7 @@ static struct sk_buff *page_to_skb(struct 
>>> virtnet_info *vi,
>>>   {
>>>       struct sk_buff *skb;
>>>       struct virtio_net_common_hdr *hdr;
>>> -    unsigned int copy, hdr_len, hdr_padded_len;
>>> +    unsigned int copy, hdr_len, hdr_padded_len, max_remaining_len;
>>>       struct page *page_to_free = NULL;
>>>       int tailroom, shinfo_size;
>>>       char *p, *hdr_p, *buf;
>>> @@ -915,13 +915,23 @@ static struct sk_buff *page_to_skb(struct 
>>> virtnet_info *vi,
>>>        * This is here to handle cases when the device erroneously
>>>        * tries to receive more than is possible. This is usually
>>>        * the case of a broken device.
>>> +     *
>>> +     * The number of allocated pages for big packet is
>>> +     * vi->big_packets_num_skbfrags + 1, the start of first page is
>>> +     * for virtio header, the remaining is for data. We need to ensure
>>> +     * the remaining len does not go out of the allocated pages.
>>> +     * Please refer to add_recvbuf_big for more details on big packet
>>> +     * buffer allocation.
>>>        */
>>> -    if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>>> +    BUG_ON(offset >= PAGE_SIZE);
>>> +    max_remaining_len = (unsigned int)PAGE_SIZE - offset;
>>> +    max_remaining_len += vi->big_packets_num_skbfrags * PAGE_SIZE;
>>
>> Could we perform this check inside `receive_big` to avoid computing
>> `max_remaining_len` altogether? Instead, we could directly compare 
>> `len` against
>> `(vi->big_packets_num_skbfrags + 1) * PAGE_SIZE`.
>
> That looks better, I'll do that in the next version.
>
>> And I’d like to know if this check is necessary for other modes as well.
>
> Other modes have this check as well. check_mergeable_len is used in 
> mergeable mode. In receive_small, there is a check
>
>     if (unlikely(len > GOOD_PACKET_LEN)) {
>         goto err; 

I forgot about XDP zerocopy (XSK) mode. In that mode, there is a check 
in buf_to_xdp.

     if (unlikely(len > bufsize)) {
         return NULL;

Thanks,
Quang Minh.

