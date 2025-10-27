Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6022D24A3
	for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576564; cv=none; b=cdiWNwytnIUdvSWu8lpuFy8Z6SvkTKmbapRlEgENyXktU5PwXAPK+4LthCcOnBSQfz8Yem+wiSA/wo+sla3PkSfoRLWPMuuCjxDrkv3zHvjhs5j2FEMEfD3CagQHIBGzSbK6/hcqFsmvvIIBh9ZkmCOm0fAMayILUH+NTuaDmgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576564; c=relaxed/simple;
	bh=CjrEwSgjiwD336OKAJb8KSdBV5+gSPyH1P76ISzvG+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JpyLioU9JGk0xUvr6fgBir4M5474aQ9tu7u1x3h5Qk8PeOd10sURlMmDmQec5F9IF8B7cliluz3Yr2LJWEQCTBli7SAqk097xsBa9dh4xj1HoP2mrOglpma+YXADZ6wIaZXz3q+LWIUGwM+vd7JVClXJk+CSDfHxqmgfU0/cIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcQEDKUi; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcQEDKUi"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7811a02316bso3402806b3a.3
        for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 07:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761576560; x=1762181360; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANPsngXgMHjdKcxNVoXIy4m28dyqI6/YbqpsmZo++8U=;
        b=UcQEDKUiqvf4JvjiONtQebzSRAe2HGB66pCo2jlmiBn1YXRAG46v2yPIm3VHQcy55+
         ry8gNAdfi/PFM07j9RENi3GiSNfkvnOcbz2SCYhHAYbhzaBNhRAJj+PPJkjMVduqIGaP
         zblDdKgXXN2MWOeAeU5F6vcAc528/3u/BxBTMB1Bgi5j9XhPvaInoqQHV9+4rBCzpmM5
         HlT/8Ke9wenevXOs2N+VnRKqOSBG0cCoySGv3wDaqlliDCgpE32os30PvkX8icJFNPcm
         sy7BulVZEJQAQLKbYP+zLgTPz8UM2LbypFxAyXpFESKXsvCPLTTi72pnX5n6hB1U4fRI
         s3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761576560; x=1762181360;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANPsngXgMHjdKcxNVoXIy4m28dyqI6/YbqpsmZo++8U=;
        b=wIaNZLE+VYlS833oyObe+9Zw5JVX9y0hv9jA0qJNNUeyj+wkrcajBf3h7xb5q/Cl42
         Sskarm5yYcGgeNB6RzoFaFu29YvXzwOo0SsFk5NqBfxrJB+lho6xhguDoNoMICcL+5Dr
         zP+TDc4dsFbLqZ/nXG+KVr4laVUUJMydQqBGHFIiPkNHaTa7WG8IxigJtQCdmtNOEzMu
         7ZgT9L0yz66eoJTbf+2QdNI7uFTZc6tRN20NExQ9YQlqTSmkUGsfPZ25AZwKUEqckOzE
         FR5jftj8tpNOD18PSYFMBUMaB1kIg1eW8RUt0KQvxgD9RSeLjzKTnLjyV34wqCAqi1yb
         DWfA==
X-Forwarded-Encrypted: i=1; AJvYcCWOts6r2ELBYZvrci/s6UWlzi91pa+PacxKMsGSEhcMfyx/clNdsES6xa024JYxH90iGU5MSKYwfY/UZTCwCQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzs8ubNKH4VuNrcytDkNsphnATYGWB+QlmEz7XZYP5Xxt2EDk3L
	D+Ar81oHex5Txc7yI+9m8OUoWLyR3z8SnPdPj+U6aMYrplD9iUkLcI77
X-Gm-Gg: ASbGncss+twccgJWeIZZOtAhAPA69MMcrr6+A713o6KL+jZlJDR3ITzmbegvUxbU+0m
	6MoZb26l23oU5JXyaB0bAFg2yaJmts/a6HBg6C6rTRAMEOFU0KU4Y2QVtE27Rb/v9IPo355gvV1
	qB0Ud+FK9FrJXud+SbAPszXV1mOKqrVggpRSN4QGtL9btJl3bLwJUijSWweNBia51Yh+6U/WlFc
	p5GTyU7Qt48H++ChLu6iEyCKpupSQO/F5n2whkqyP5BROxiGQydUTW8DDf9V1gX/IFGox/LzG/y
	zCQbzRGEjbYTIa6ncpyxyDdM//wcEddrzR0nlm27ea/cx7AO1d5JhLkaNN7z77qab/rm4QJsyYw
	MRykaURsT9T08Yfu568kXNmJiQNc4cYiVNG+nuKzz85JaJ6be4qsx4ywDY9iKG8jSC8Imwu36PI
	rBMFK0Ir6hUCRrTM3PGXAAcwmCa1sCSxfeQqzHl/JwC4phT/JdCoyZo8XnOfWkKQ==
X-Google-Smtp-Source: AGHT+IEok/bzITDTCab03QqNwX8lBfkK7cWFMLgw94U0uFNw9rZow3hQZEVr+kA8L+xnK5EFRYIn1Q==
X-Received: by 2002:a05:6a00:188b:b0:7a2:8343:1b1 with SMTP id d2e1a72fcca58-7a441c2edefmr272995b3a.17.1761576560215;
        Mon, 27 Oct 2025 07:49:20 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318? ([2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41404987esm8217502b3a.36.2025.10.27.07.49.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:49:19 -0700 (PDT)
Message-ID: <8e2b6a66-787b-4a03-aa74-a00430b85236@gmail.com>
Date: Mon, 27 Oct 2025 21:49:12 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] virtio-net: fix received length check in big
 packets
To: Parav Pandit <parav@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Minggang(Gavin) Li" <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20251024150649.22906-1-minhquangbui99@gmail.com>
 <CY8PR12MB71951A2ADD74508A9FC60956DCFEA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CY8PR12MB71951A2ADD74508A9FC60956DCFEA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/25 14:11, Parav Pandit wrote:
>> From: Bui Quang Minh <minhquangbui99@gmail.com>
>> Sent: 24 October 2025 08:37 PM
>>
>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big
>> packets"), when guest gso is off, the allocated size for big packets is not
>> MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on negotiated MTU. The
>> number of allocated frags for big packets is stored in vi-
>>> big_packets_num_skbfrags.
>> Because the host announced buffer length can be malicious (e.g. the host
>> vhost_net driver's get_rx_bufs is modified to announce incorrect length), we
>> need a check in virtio_net receive path. Currently, the check is not adapted to
>> the new change which can lead to NULL page pointer dereference in the below
>> while loop when receiving length that is larger than the allocated one.
>>
> This looks wrong.
> A device DMAed N bytes, and it reports N + M bytes in the completion?
> Such devices should be fixed.
>
> If driver allocated X bytes, and device copied X + Y bytes on receive packet, it will crash the driver host anyway.
>
> The fixes tag in this patch is incorrect because this is not a driver bug.
> It is just adding resiliency in driver for broken device. So driver cannot have fixes tag here.

Yes, I agree that the check is a protection against broken device.

The check is already there before this commit, but it is not correct 
since the changes in commit 4959aebba8c0 ("virtio-net: use mtu size as 
buffer length for big packets"). So this patch fixes the check 
corresponding to the new change. I think this is a valid use of Fixes tag.

Thanks,
Quang Minh.

>
>> This commit fixes the received length check corresponding to the new change.
>>
>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big
>> packets")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v5:
>> - Move the length check to receive_big
>> - Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-
>> minhquangbui99@gmail.com/
>> Changes in v4:
>> - Remove unrelated changes, add more comments
>> - Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-
>> minhquangbui99@gmail.com/
>> Changes in v3:
>> - Convert BUG_ON to WARN_ON_ONCE
>> - Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-
>> minhquangbui99@gmail.com/
>> Changes in v2:
>> - Remove incorrect give_pages call
>> - Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-
>> minhquangbui99@gmail.com/
>> ---
>>   drivers/net/virtio_net.c | 25 ++++++++++++-------------
>>   1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
>> a757cbcab87f..2c3f544add5e 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct
>> virtnet_info *vi,
>>   		goto ok;
>>   	}
>>
>> -	/*
>> -	 * Verify that we can indeed put this data into a skb.
>> -	 * This is here to handle cases when the device erroneously
>> -	 * tries to receive more than is possible. This is usually
>> -	 * the case of a broken device.
>> -	 */
>> -	if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
>> -		net_dbg_ratelimited("%s: too much data\n", skb->dev-
>>> name);
>> -		dev_kfree_skb(skb);
>> -		return NULL;
>> -	}
>>   	BUG_ON(offset >= PAGE_SIZE);
>>   	while (len) {
>>   		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset,
>> len); @@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct
>> net_device *dev,
>>   				   struct virtnet_rq_stats *stats)
>>   {
>>   	struct page *page = buf;
>> -	struct sk_buff *skb =
>> -		page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>> +	struct sk_buff *skb;
>> +
>> +	/* Make sure that len does not exceed the allocated size in
>> +	 * add_recvbuf_big.
>> +	 */
>> +	if (unlikely(len > vi->big_packets_num_skbfrags * PAGE_SIZE)) {
>> +		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",
>> +			 dev->name, len,
>> +			 vi->big_packets_num_skbfrags * PAGE_SIZE);
>> +		goto err;
>> +	}
>>
>> +	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>>   	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>>   	if (unlikely(!skb))
>>   		goto err;
>> --
>> 2.43.0

