Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7DE3090C9
	for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761575857; cv=none; b=Alq743EsT6VGBvim+E+I+zoRPTSAS4BjuWx/g3TJExDEl3DsByhTq0Rnf/Qm+u3gqIv9OE3o6PKygYuV1WIcB7wnusvjGe0Wcyta4CdTYkw0gaxHDVVlm6WRWJFAzaEnvpV3WfQ94K9C14QJ9XG6Yq9A8WI89J+89eJsnxNds0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761575857; c=relaxed/simple;
	bh=adn7NhSXM4F+uMTSsRmO9V9GvUSLky72zBSuV3U4ELM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4ccmeIFgmEg3S7oOODMYMBGqqcvVLFxxrk87vWNnlDZtLohBoHHL14/1A3kJINwZoZTKnWa9Xod2xNeoEwslrKc0rUq8h48dAoMprJr3LXcDvWhiSR930MoUnzoCEt34eYRyQ2GJO5uZgTZWBFYS35zEBlgJ36UObSG7m/eojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dyfzMcWJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dyfzMcWJ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a27bf4fbcbso3877176b3a.1
        for <virtualization@lists.linux.dev>; Mon, 27 Oct 2025 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761575854; x=1762180654; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4B2eLu4llGXCU4gdWSthJqBowpW96zatbh6aox0b+bY=;
        b=dyfzMcWJITa5euEF8DNT9v84jhUnJU189i9sl/H+H1dfFSOKBBlKnzX7jCw1Gm5U6P
         hj7rLJL9RxSxm5Gl7RzFkEYK1hTJzl+HTTg5j1VSgtgbdAfPCJ7OmXFRiDbFYorse4ld
         KSCC7MA5ejOYf8l1Xm31JAnlhUpWdlLAvVln/1fcC094IOtqVgqnOUUH6qSgN845cj8U
         sYYb90C7HE8eAQWYQZre0Q515rWYKR+cgBxmkv83PLcwcr1hYlhBpLBhl/urRSXovTL3
         a+vVd8zx6wCAx9doSafCNnc2wXqrnCdNum07CJLfXHUbCxD/N7RSkDm8c/NpnvRPr8ZP
         2jnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761575854; x=1762180654;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4B2eLu4llGXCU4gdWSthJqBowpW96zatbh6aox0b+bY=;
        b=vSznu7bXE36DsQNbqaoq57w+DhXcpxBwzpd5SOv8Sg1w5gi7kRVJlj7ztQ3TRADXiZ
         x/UGVokIJWMor0SDHs9WIBHZrEQ9xZr1nW0SnYx4Ryw0FXVS+1AiPXJBdhZqcrUMBP8w
         +MuwjHvBoxMci4WXxV7nOubWByOuueNv0zBgOqR6QunZj3GSHwLfl15okRYYMQLbqyVG
         zIsuaxvR8U5W4t+fkikIJ4uTT+cs5yXaaQV0eogMtQvKc8rOJtuUSgXeN5luRAL+ImI0
         Zn0nzj6gkepTL80ckxQBZDGs5pCwweKFLHFPldYSB6hA2Xj78D+/EKVh+PgtF3gImYmf
         xVxg==
X-Forwarded-Encrypted: i=1; AJvYcCUyOKlr8ATWxcO/l6zF1lR6eIasz4D9r6AyWASVhTZvVnQcMutScLiJIP9L9z5IL0bAl6bq4+S1AsRK88QvEA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxHt8G8AmkFZrxR03oozHIUiSvvCMzUjFdIyHMfb6ZP8o1/ZMgA
	tGG5EmJ9IiNjylfwoSxt0PBs3pqejKWdXc40+uzFZsRJHzStqTApLF6d
X-Gm-Gg: ASbGncsrt/jHMD3Wq1WSQnfqYFQkSHTDEPXiLSd7DszvYcnLv+JuBhi8qJ2wXkJ1gIO
	Z+GL8+ApA0wi5aXS60LrtJxT/5MipXBB3Zju+BZ3JZ9Jmukl9q4kxOqo72OB8JQKgnFUMyFc2w0
	FsqDKVHi3tUq0HrCRR2W9qfFu46rp7gbvZC7nlBrAbppzrQn64j+bNetServTxiKcO1zlgHX6ay
	AAbT3/yrTJtoUmoBlt3f3Snp9CBdFxwpYjzmsD2K1uO5I0s01Yr6bC8QacWklalU7V9QmhDYpWx
	01n+HDWvIE8U2bDw5GMQiSvCVvgws5hpHURSkQMWrciiFr2QFMSGr6tq1cGA53PlLDQ3kORVFTH
	YtNqK52jf7mdY3zyZy5RVcrdleAbE9DKGdsHAcGOLlQ/XiIgiBB5LUci0EeUTwCUCcLcilI5xY9
	WZhQEWsOZmI7lUAHZxMnr4SF6c33NNlRmYvU6uFtLr0WVgWMIcszf7qlucVGiy8zAW77Lakbz+
X-Google-Smtp-Source: AGHT+IGTA/k5UQ2FNEr9mRS1Wz3fIDbx1lAqcpQR27aZ9cZE/UvwNhDm/mbd//iNK1nFji1/GqjjHQ==
X-Received: by 2002:a05:6a20:72a3:b0:334:79cd:fb13 with SMTP id adf61e73a8af0-334a85047abmr48082035637.4.1761575853948;
        Mon, 27 Oct 2025 07:37:33 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318? ([2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414087cdbsm8438806b3a.64.2025.10.27.07.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:37:33 -0700 (PDT)
Message-ID: <b74b46e7-63e9-4330-b330-09d14d45fe9b@gmail.com>
Date: Mon, 27 Oct 2025 21:37:24 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] virtio-net: fix received length check in big
 packets
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org
References: <20251024150649.22906-1-minhquangbui99@gmail.com>
 <1761527437.6478114-1-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <1761527437.6478114-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/25 08:10, Xuan Zhuo wrote:
> On Fri, 24 Oct 2025 22:06:49 +0700, Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>> for big packets"), when guest gso is off, the allocated size for big
>> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
>> negotiated MTU. The number of allocated frags for big packets is stored
>> in vi->big_packets_num_skbfrags.
>>
>> Because the host announced buffer length can be malicious (e.g. the host
>> vhost_net driver's get_rx_bufs is modified to announce incorrect
>> length), we need a check in virtio_net receive path. Currently, the
>> check is not adapted to the new change which can lead to NULL page
>> pointer dereference in the below while loop when receiving length that
>> is larger than the allocated one.
>>
>> This commit fixes the received length check corresponding to the new
>> change.
>>
>> Fixes: 4959aebba8c0 ("virtio-net: use mtu size as buffer length for big packets")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v5:
>> - Move the length check to receive_big
>> - Link to v4: https://lore.kernel.org/netdev/20251022160623.51191-1-minhquangbui99@gmail.com/
>> Changes in v4:
>> - Remove unrelated changes, add more comments
>> - Link to v3: https://lore.kernel.org/netdev/20251021154534.53045-1-minhquangbui99@gmail.com/
>> Changes in v3:
>> - Convert BUG_ON to WARN_ON_ONCE
>> - Link to v2: https://lore.kernel.org/netdev/20250708144206.95091-1-minhquangbui99@gmail.com/
>> Changes in v2:
>> - Remove incorrect give_pages call
>> - Link to v1: https://lore.kernel.org/netdev/20250706141150.25344-1-minhquangbui99@gmail.com/
>> ---
>>   drivers/net/virtio_net.c | 25 ++++++++++++-------------
>>   1 file changed, 12 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index a757cbcab87f..2c3f544add5e 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -910,17 +910,6 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
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
>> -		net_dbg_ratelimited("%s: too much data\n", skb->dev->name);
>> -		dev_kfree_skb(skb);
>> -		return NULL;
>> -	}
>>   	BUG_ON(offset >= PAGE_SIZE);
>>   	while (len) {
>>   		unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
>> @@ -2107,9 +2096,19 @@ static struct sk_buff *receive_big(struct net_device *dev,
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
>
> I think should be:
>
> 	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
>
> Thanks

Sorry, my mistake. I'll fix it.

Thanks,
Quang Minh.

>
>
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
>>

