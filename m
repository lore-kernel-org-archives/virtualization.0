Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA724169E
	for <virtualization@lists.linux.dev>; Thu,  3 Apr 2025 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743667866; cv=none; b=iUQa1zoocjnHvWsvgFPt/colWJWR8QKpmovMsJpxDOxbnHgAFOyEylVTu86pXcrbrFTEUrdTGzcThcudRGZkkOMXZYCaJvfxbvSBBL5ZzGqiBkamaV/0rje8mHBAuyx96kJEsb0xDixiNrZus5S6mcIW7AkoG+kiQAD9tSDDqO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743667866; c=relaxed/simple;
	bh=2R7xbK2zYAifCYk+bxYA2fYSAJkn/8z0fvehWJ4nvyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icC/9pnoy0DiZz0OFhiTR49VG/MkEWh3gs+tBkftEZbcFdnuY8MpirWNRNMe2pPKmqTZJJG9xbNF+qaqZFOO9Tg2xq2w78g2fgF0YfCoW4Uik4MtxvO5nqefaxjLdM5Jgyz279sCuWuXsBwUyJmcW+9y8zJKFvboYoYUcwyY/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZY54kcdY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZY54kcdY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-223f4c06e9fso5737185ad.1
        for <virtualization@lists.linux.dev>; Thu, 03 Apr 2025 01:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743667864; x=1744272664; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iUzFKSfu3nO5CAOYlZxLMd314d5zWCMqkdsMAHHXslE=;
        b=ZY54kcdY7kJK9k6p4EqPpy7+oOBnUc5mSzhpSu5onstmawrINlkvj2oUgdV0QUUqWN
         2AhvADWOGkrQMfa6iYclX6hoMxPBFdSr1IhGn4lMM8yBNn0HzlOeW6+PdViU/L/1SndX
         N2tqiuY4nz6sxt16SnZl6nzFvbVN/HuKT1F2XXq/qltbbRLtEoj0aK8Z1PvY+PfvqST/
         8fRZKLZ+ItfY6VQibI3SxnVP4Ni7Zb/11Y6lU3nLQNVAf+pNg5BCFz+9w/R6bXj6tojM
         +1pMB0N+460vfm2E1FlZ9Zd1fPWgdZ/5rt757OWZHhd0ptgNu7mSLrK6TVJdXKk2pD4i
         8f/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743667864; x=1744272664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUzFKSfu3nO5CAOYlZxLMd314d5zWCMqkdsMAHHXslE=;
        b=jH+0NGFFI+ckxalhnXHIRWdyaZtv2ORECqBQlu8SW0GqbM9WlmYAgsYpjxU5z9aC1Q
         ZRwGwlgS1KkU9qklegMmui1pXABbKyrnOoiuW1tyqykFRYp3vFIr44bhd72z7KnA2/Tq
         RFggRX2v3WEemG+RaLsLyCU48LMzJtwAwnUCoEp5sHN8JFOTgCkjovzue7MUMsXksQKE
         y1OkUgobl8P8/8zg+6hK+mvL4ec6HmHLD25tHM4RcmF24JQAzdLkUGM3sxeWYAN3s0td
         RC5n5pwjssmKgtg7f09OXHwhsWIWnVJWqdyBk3K8fIrVwIIff2wue2Zr2TwA3CxmsqRo
         5AOw==
X-Forwarded-Encrypted: i=1; AJvYcCXHTTh0fhp0EiGGjNy4kzeySKg+rZepCNdEM3pU3xcM7vRQaIAs8ft4m13pri9C93jGhgBCpk2MAtnGfeJMvA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq63qfsMQv4YpfPVaQ9dUo+6+YZbq31z6CNzonhe8Bm4EbkQ2R
	xwT15nZ22PUXft0JcjjSgNnKEJKpUihWizDt6fE6z5S3IPzSYfQMgTEXsFWf
X-Gm-Gg: ASbGncu7iurEk00HlVpnXXzb7SISKEicymGgoVhzu2N82PXirmWvqMoj6stJoF7nyVu
	haDsMDQmiUjSxFhe+lPGbSTe0cp3g444l7umxxyG68HbrgqfaSaTflHH2jPc55e5n5G+X5QMl//
	HFikmjReudn9FPH5JfQ+XyP63YHv0hjmU0dpN/2FfrWkdhAnDGCWJ1OAh3V60CPIO+C5oQxTQqW
	WdVgh4nxk6JI6nxifz8lPyqmnOBzFmGI4/KreVrUlvztd3s1iZzHG2HILXvsa/NHn9/gQ6xrbfO
	3arUO2hyao1Ug0X1eiQzD10Z0fm/XYryz1mPbA6eo7X/YPsXmciV0Sk6lW090ITPuArdoBv0vI0
	gN6CfyCz5Pfp9QcOoeUH5lik=
X-Google-Smtp-Source: AGHT+IF4eQzBfv+ODf73ZPw7KCMX4BruvGE2f4o7JP7Bv1oXNuTH3a7SodgEPjBCqKICofhoR7aC0A==
X-Received: by 2002:a17:902:820d:b0:21f:40de:ae4e with SMTP id d9443c01a7336-229765ce2bdmr28438375ad.9.1743667863970;
        Thu, 03 Apr 2025 01:11:03 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4e:bd30:1c8a:9f9b:3aa6:dc25? ([2001:ee0:4f4e:bd30:1c8a:9f9b:3aa6:dc25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad0d6sm8658415ad.22.2025.04.03.01.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 01:11:03 -0700 (PDT)
Message-ID: <653b71a4-99a5-49d4-b927-fe2bf5890896@gmail.com>
Date: Thu, 3 Apr 2025 15:10:57 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: disable delayed refill when setting up xdp
To: Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250402054210.67623-1-minhquangbui99@gmail.com>
 <4b3bea7c-110d-48eb-bcf6-58f4b2cd1999@redhat.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <4b3bea7c-110d-48eb-bcf6-58f4b2cd1999@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/25 14:24, Paolo Abeni wrote:
> On 4/2/25 7:42 AM, Bui Quang Minh wrote:
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
>>   drivers/net/virtio_net.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 7e4617216a4b..33406d59efe2 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -5956,6 +5956,15 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>>   	if (!prog && !old_prog)
>>   		return 0;
>>   
>> +	/*
>> +	 * Make sure refill_work does not run concurrently to
>> +	 * avoid napi_disable race which leads to deadlock.
>> +	 */
>> +	if (netif_running(dev)) {
>> +		disable_delayed_refill(vi);
>> +		cancel_delayed_work_sync(&vi->refill);
> AFAICS at this point refill_work() could still be running, why don't you
> need to call flush_delayed_work()?

AFAIK, the cancel_delayed_work_sync (this is a synchronous version) 
provides somewhat stronger guarantee than the flush_delayed_work. 
Internally, the cancel_delayed_work_sync will also call to __flush_work. 
The cancel_delayed_work_sync temporarily disables the work before 
calling __flush_work, so that even if refill_work tries to re-queue 
itself, that re-queue will fail. As the refill_work can actually 
re-queue itself, I think we must use cancel_delayed_work_sync here.

Thanks,
Quang Minh.

