Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAC36C9F0
	for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621036; cv=none; b=I7NYRBP+O0RWNu5l8hzxm+RGAowxD0H+CWNmKeKe/z0BjgVvKZUQJqDj5NREJGOOqIUQG4vRhgvMjbHg52xzIqKqI5ghEd2yMdZaanpPaqqqusD2VykvGTmyjflgPoqmsFTGjzKq3VYDQaNPXTOlTx7q83ZoNrNtTW/ZU/BFtiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621036; c=relaxed/simple;
	bh=1lvL5cDlAGzUVesMPoNtNmQEcI6fyKiPZjT5VrpViug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iUSBDK1tqigYNmOsGPCwc6aGuDnztSioPoHDrxRbEAztrxc3VS4WAcegzl2C1SpAGIdot5AfBvO1m91FA4jLb4i5+ESbabNff9J8l8KtOLLWNPbqNO6hh6GolTYkxJJVZcGqan6NeTcZEEZQVp+KZUmcceHxaNQHbIzYNHBxxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WLyqx6Q1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLyqx6Q1"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8434840cea8so2823616b3a.3
        for <virtualization@lists.linux.dev>; Tue, 16 Jun 2026 07:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781621034; x=1782225834; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkd9lKRyopVrugwMVot3B/HiKXmkebEFxISTfLV9UhQ=;
        b=WLyqx6Q172Uask2sDgHiIIs0bfzmvsTP8+H/kjQyBgOJDhAPRD+kaXnL0iiaQ7EtZS
         flYHa4vjmJwNMSU7rY+oeVCqKnSBtz/17hOmpIc13w1cZ4P4bx6g2BkgbmGOsGMmbylp
         kxPO1M+5IRKMeJTgS4VbmncGczluJA5q1hemdoQVMjSf9n73PbVlA7MrHiJxymNrOkbe
         q1qYgqOnQYpk+3WZdTGjvtKRO9LkXMxWLJc7Wnuup1WEEcCdx9e+H3s0jjo+xDLH9SLA
         vaJmlfVxDsy8KmAD6HSQioXX+qnFFJwawFKBISGmIg+chWUtm8rHdsAkorjvuLwp4IjC
         xs/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781621034; x=1782225834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkd9lKRyopVrugwMVot3B/HiKXmkebEFxISTfLV9UhQ=;
        b=lcWHmqB2BHJZ4ejpQgjM8iL3ES8K6eAZMAEArmw3I3aArDosjBczpL+JHo3JGzT+f3
         oO2YUGeMC8EOKPzVUgg8sd3YrL9+VcHFZxSXC5G/xc/UvnxznYipui1XjxhD6wIBdT2R
         XhGNaB7dTtFUZpX4wIqH0Zkm2Mga7h9domNreTL/ZJ+DtzJZcrqnyrqAIDhpu9gLKm7c
         gCQhmgjw+EIrqmfYi1Uk1OMzKYMTh4mvhOFBrBvUaoYzdOtWIOGnbYZq7jv85JgKoM+F
         fV+TZQD5nBwsW3EhtzABEMPH+fBOWnK0InvN7HPbF43i/yTzr6IwY/KxSmrmzuybVJxy
         Hx7A==
X-Forwarded-Encrypted: i=1; AFNElJ/O65wqHoe0N9YUIXRkRqayHAhH3Sr9tsSEakVbG9lbXVZCaW/On9Ylzuvr3zVr4NGOXurpR5OGsfl4N9xFGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyAbo4v5kc+34d3+ykhLbXVGjUjJwt4vkJDS7j4prjj94y5MHdI
	VAn0B5Ryf9qobesWadTYD6nCsuuueKJSv5l+4p0xu1RPogqt3X4YoSKe
X-Gm-Gg: Acq92OF0q8adhPBFMxuNEDFujewNtmAVY7fTn/qx1ao0ni+EDZwW0vNT1VPiBc3TS66
	CsdtdrgOjt7ksDmzka5u6R0cIS1IgJCBzoFQE3YtFO3WK0/04/opy2v4wSslPBzb0wC69bgQ3eQ
	j4AuRyhWWUSNOEIHLbx9q+3tFgktvEFsuB538jAEuXsv95RIUYAo/WrfxJeUvEKwKEYUcYfXa/4
	Jbce+5jpWwzIhc1uvEAmxUGuI1JldPC3TJkUmnjul6Ayf/8eC0OjoN6xoQNXOXKd82XF6Pw5tcH
	PGh3/eJ2qLlsP60giiNwaExqUYcH7yPlkKIp1tS8HC6MuxD0dW6hnGfFQlFau0qfyz3uHmugOQ/
	uaEgO/kh5M9gpCK1WkRZlPsTpaVz08ZLx7nvc/vpWnWIVKZ1Y9mo006EU5bZSmpt1v+g/4FQynk
	4RnhGo6/ibMaQBEPNHwPT5l9LBJCBw2HwtAj2lwej50JVOnLXc7tZmXk6nRWtyrVJPuKxxKQHdW
	re9Og==
X-Received: by 2002:a05:6a00:23cc:b0:835:3f51:730e with SMTP id d2e1a72fcca58-845153054c0mr4211420b3a.13.1781621034323;
        Tue, 16 Jun 2026 07:43:54 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0c:3090:6fa0:dfe4:1cab:bb2a? ([2001:ee0:4f0c:3090:6fa0:dfe4:1cab:bb2a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b00d4c7sm13288270b3a.40.2026.06.16.07.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 07:43:53 -0700 (PDT)
Message-ID: <01d04d25-9f6c-4a3e-9292-4f6e26ab2031@gmail.com>
Date: Tue, 16 Jun 2026 21:43:46 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] virtio-net: fix len check in receive_big()
To: Xiang Mei <xmei5@asu.edu>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 bestswngs@gmail.com, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, eperezma@redhat.com
References: <20260616042837.2249468-1-xmei5@asu.edu>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20260616042837.2249468-1-xmei5@asu.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/16/26 11:28, Xiang Mei wrote:
> receive_big() bounds the device-announced length by
> (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> add_recvbuf_big() sets sg[1] to start at offset
> sizeof(struct padded_vnet_hdr) into the first page, so the chain
> actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> check allows for the common hdr_len == 12 case.
>
> A malicious virtio backend can announce a len in that gap.  page_to_skb()
> then walks one frag past the page chain, storing a NULL page->private
> into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> write past the static frag array and a NULL frag handed up the rx path.
>
> Bound len by the size add_recvbuf_big() actually advertised.
>
> Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")

I think we should Cc: stable@vger.kernel.org

> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> v4: use easy to understand math to compute the max_len
> v3: revoke 2/2 and add Xuan Zhuo's Reviewed-by tag
> v2: add additiona check as 2/2
>
>   drivers/net/virtio_net.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..8f4562316aaa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1999,15 +1999,16 @@ static struct sk_buff *receive_big(struct net_device *dev,
>   				   struct virtnet_rq_stats *stats)
>   {
>   	struct page *page = buf;
> +	unsigned long max_len = (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE -
> +				sizeof(struct padded_vnet_hdr) + vi->hdr_len;
>   	struct sk_buff *skb;
>   
>   	/* Make sure that len does not exceed the size allocated in
>   	 * add_recvbuf_big.
>   	 */
> -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +	if (unlikely(len > max_len)) {
>   		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> -			 dev->name, len,
> -			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +			 dev->name, len, max_len);
>   		goto err;
>   	}
>   

Reviewed-by: Bui Quang Minh <minhquangbui99@gmail.com>

Thanks,
Quang Minh.

