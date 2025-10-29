Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9520A33B6C0
	for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752944; cv=none; b=W16hFUmbeAu7GjVlOkhlvpigzMw9XZXLXQznNJ/jpU+sWc1D+qpKCTDLxmf+LkunS8Ii7zHffak4aiMADd+2jFspp+jxIPUhvBQY0HKyJ+x08fE5uYutblLENiqYSRA2gkpb4xCSStbyZVa8HjHqrVWyUe/B8a9p57kvRWhz89w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752944; c=relaxed/simple;
	bh=XZ/WZ9rOoWMMtJ/bPO8rxjjiFAaTwX+96Lqtx/dBKuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpWczWxz+z0Rj2Q8Oc848w7Os1L4XIVbubjKo6r58pZUqLI97vOkxPi00QbWj0fY74sy6toc9uOy0mw3DCLndLI8lUm+jAfdvw68pBjjm0xEkUXzJ8S8nLwklhXhMrTTNY72TVzOa4cl2r7GmOX46S5zUv1sMO6VPgDVpRxgRJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eb8m4KvO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eb8m4KvO"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso58114b3a.2
        for <virtualization@lists.linux.dev>; Wed, 29 Oct 2025 08:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761752941; x=1762357741; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xahGF8Qhu9liQEvN8Aw5ydRO2CUSEDKXLGDLGd1XDbA=;
        b=Eb8m4KvOdIZSipgTYxs3nvowaAC6avI7VQF3v2RBrs2tQGJwPB/F75fZpnsJtKW66B
         NIM34sXvPCS6Z2kTbtN8C2JEJRCVatwysuAt3fklpUBAh4+bwc+Lmj2re8a0aZ6JfaoH
         0zEja/KOK+2a02yRQUy8GOgJbyIs9lvoduQEU4iebr31260OcBNTmycEvgaqQoqmDzXX
         IxZF68AC/KShyNtPAIJn/Mu9tY57GC99TuSEN/wiF3jPdREb7jeDgxf3vDujRa0kQp6B
         mrRc4TaRSdmVl+PmPgpZhLyCV/zGIoaDpiacZoJkpd1lP5ewsal7T/gTyrcC5XFFH99S
         V4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752941; x=1762357741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xahGF8Qhu9liQEvN8Aw5ydRO2CUSEDKXLGDLGd1XDbA=;
        b=cRb61VIx9NDLV73C8yR34u6/SWIcvNgJ8HUu4v0cLU7SbhZX7aWH6+0B+CuFu+rHF4
         bjNyXB3RlnUSngOKxRYQypo9MeCMblKVcTzMIVzsuGLIirZhwIpWFpSQHEgJYL3zkh6L
         5fYCbrfu82gqx3s5ckmuah/BuP6QOm/9MqjMfmmYRUbVH+ztkllXIhyaH8z2JzrchH+6
         BvtrLqJCL+yyf8h7ZsOBphRVe5wa4gqeWUpmWD3chiOXR1wS0XOfhbJOdkA2IGl4f2xJ
         isjh2qqXccRse00jeOyGZYZ/wE9OmlsMKn8q/33q4OJ1dA+OxgobimJKS3jBN1/MgOAS
         3azA==
X-Forwarded-Encrypted: i=1; AJvYcCV106J20lk+fxOlm6mlVNN+JRxnB/Nn0v00hFsUIUlVoOYQ0fDeMbrD8nmABEN6iBFZ7ujP4YejR6HqiIlp1w==@lists.linux.dev
X-Gm-Message-State: AOJu0YxzTh4gtNVFo1qDBXcF4TbUcvduBQlZVvP8/ONJHOTPweqj0oBT
	caV9t6DnJ8PZZINDBOB6gEQ7S2OmfxuoYC0VyRySYvkZKa6QnizA38mP
X-Gm-Gg: ASbGncvCIcro4v8K+pMxlzzUs2gbb17Jpg5sheLogzIvmO1hgoEbNdrgWZ3SYcsNFH3
	XKjNkVssYF0gjYxxhTKrpTdMVTANXq60fRY3vVykA0t/rrUNiM2rSooUdgKQ/NaQIkJc4D+G8v2
	z/KwnR6skYHN/FegrRyK270P+Gps2UQKiLWEoAauSorJaH1SfHiHIkipxCVKIKCq7eEwDPZn+bG
	yShtctIXNOMvBXcn4DSyLwEUHHJyNaOtCBDtZOB674AKEw/lyahAHLQ+rHF/O6AyleXPNHZ0lDE
	Et9xZ6GBrE/Kon3eYHV+A8EDnDKoy/9mTY5EX7AYXr9aacZnxO4+/mR/G8LfT/rrDH00/S8Ax7t
	CwlQS4N7jcTz6fjfMWsZ1mLUnglKqx73bxKyA24s+j5XoCVvSF39Y4tVABjFHknMs8Sl6z1Onqv
	nB5rBiH8LV+iZAI2MlX7AXJIoIJKJHHjjRD1WAMcIr+GZtc+ukZjwVQrgoV9H6LA==
X-Google-Smtp-Source: AGHT+IGnsqJ5B0aHdVMgMj8dRtDF3qsvm6zVbKD5CbjQ8u4utwV9uD5rLJD9GDDUfRzpmwKxrHtGAQ==
X-Received: by 2002:a05:6a00:2345:b0:781:556:f33 with SMTP id d2e1a72fcca58-7a4e2722946mr4181047b3a.5.1761752941460;
        Wed, 29 Oct 2025 08:49:01 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:2e86:dcd2:19c2:4a7e? ([2001:ee0:4f4c:210:2e86:dcd2:19c2:4a7e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409c703sm15596353b3a.70.2025.10.29.08.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 08:49:00 -0700 (PDT)
Message-ID: <a4081f8d-7d12-46f2-b7d8-4145003a0dac@gmail.com>
Date: Wed, 29 Oct 2025 22:48:53 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v6] virtio-net: fix received length check in big
 packets
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Gavin Li <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20251028143116.4532-1-minhquangbui99@gmail.com>
 <20251028104041-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20251028104041-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/25 21:41, Michael S. Tsirkin wrote:
> On Tue, Oct 28, 2025 at 09:31:16PM +0700, Bui Quang Minh wrote:
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
>> Changes in v6:
>> - Fix the length check
>> - Link to v5: https://lore.kernel.org/netdev/20251024150649.22906-1-minhquangbui99@gmail.com/
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
>> index a757cbcab87f..461ad1019c37 100644
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
> you mean "the size allocated in add_recvbuf_big"

Sorry, but they feels the same to me. But I'll fix it if it is clearer.

>
>> +	 */
>> +	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
>> +		pr_debug("%s: rx error: len %u exceeds allocate size %lu\n",
>
> allocated?

I'll fix it.

Thanks,
Quang Minh.

>
>> +			 dev->name, len,
>> +			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
>> +		goto err;
>> +	}
>>   
>> +	skb = page_to_skb(vi, rq, page, 0, len, PAGE_SIZE, 0);
>>   	u64_stats_add(&stats->bytes, len - vi->hdr_len);
>>   	if (unlikely(!skb))
>>   		goto err;
>> -- 
>> 2.43.0

