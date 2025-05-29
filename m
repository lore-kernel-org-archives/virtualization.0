Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8B8247295
	for <virtualization@lists.linux.dev>; Thu, 29 May 2025 03:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748490158; cv=none; b=nwFmEyapc9xKk6M3oYAvxxWSn8jMx8NqkvyXroH08JcQdcgXtxVDqwiD/sB1LuopxU0SsY8sb13knf0Dam48E/soQ6m5jDAXRuXaZUwpHDl5S24kFqF9NCsf2q7U9ApHi/h7NuXX6U5+A6hEJgFnkOleVpsw3/I2JYkd7bydX+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748490158; c=relaxed/simple;
	bh=1oGqF+kLpE2T0HCkMCKtmAmdZ5GNX4oGFxPLWIQEJkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ub5TpxBsfdg2XKgIz1VeI5MrJesf/smI7A3X6vL0t61ELaNY6tTmzE4hnQX92rVvPdVGKnQqBLXnfrLUQbRTIHjEIrEIDGXdZ4qUzzXJ4PqAilg/rVOUib3ixPRSC4PWNkFzCAdHRHykDkLatjEij2B86pd9uqx/njSnIhMZZ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnnyktfc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnnyktfc"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2301ac32320so5252135ad.1
        for <virtualization@lists.linux.dev>; Wed, 28 May 2025 20:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748490156; x=1749094956; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGQ6gPvbs0cdDm4yHXwvrbROFKsQxn254OqSH+zgs90=;
        b=lnnyktfcRbTJerz8wyGYlBHE0YK56+zLrW6SvC2j3CaHE/CyBv4Vco3VFPt2BlAebz
         C6lH4WZyG6SFpTmfNx19wtCQm03jWQ+qPO+lTSGcyDC3WdN3bavlFtD+0rx0YBxcEATA
         TMdxjGig8b+Tk5GFUMSVCxGk7XYSHwGRsTEtpW2Mcx/c+aPyFQUoFaQuC2F0y2AwNjTl
         vrY398CMq/3z57rZoQwq/sYTgkw+yXsoOyBLO3ILCMMMfqDrWs1o7QFLz1iPu6awedhZ
         tB5zXtkRHeDP9EbUIEs8HpFYyRcqSFQJ8R5ZuUGsNKMhEfwkKwHsFc6hRTu+qupEj+Tk
         /NTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748490156; x=1749094956;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGQ6gPvbs0cdDm4yHXwvrbROFKsQxn254OqSH+zgs90=;
        b=Z0hkbFYEijt02gp1xuhn31nbNKqW2gVvx8z0Yz+939K8cK8xD4qyqqXlom/SIBEP5l
         e9w1L/RaEYDSNRgVyeF6hjUOXwkS7pOeZKC3lCq0MhUSki4bSLom9twGtAGd/vGqKz7L
         rg7XHNFkHJ89HWqNBXvACyOAU1aLr9D6GHxgotQOFPvo+EvT+MI3a/4wMdLolsiWFxLY
         kHHnUP8iwusgEHpNisOc5WtXDbum4UE5F9cfXtcMhZ7/nRewkxDkXtqOcJ/7hJK4HE8Q
         qPGT9beJK37M0V6AgbIxMRYNFYE0SXcn9af63ECZAYVxD8SSWZBgIjqfds+sZ8zQLKoh
         DYUw==
X-Forwarded-Encrypted: i=1; AJvYcCW6YmadrsKRIdbe/nE1eo4Y1lDm8OxeVKXyVkVfZGbEfSENbHRrMZw5+lloZN9EMFmw9BN4Uj2IZBDSti3EHw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFAqe4kOQSB11hTZioqUgMdcOjIZCHbqdMU0C4f+MKuQVUUXz3
	5WORGXi5J4CCWUp68DRzEt4juzhV4qE4U17aUW+sy8SFYX4YvabjhUeH
X-Gm-Gg: ASbGncvIhGuoQNJ0TxU3lK1h2KCthjmQK525S6jTjTEkGyXgzUOm9D1uUMVAC/xDebE
	xIP/GbhkE4SirmGmoxS0WgZqNua5piviwVpxSJT8Qb+cnPk1iPI0u0KBa8kQxUcBhQkrxm7PSno
	ZpdUXOjhxh+yPKwUxolfQgeDfIKeyq0PBRRxZkPPDB+bOvxsFtSQC6FO0/zTDFJyJnDYHjwDQuU
	AfEiNFu8GV7CXwNdUUyqBRpCiXSamthz4uRlMYHL2tWegp6hAQGHcIo7MCvQRo8/6NEF3v0IhZ7
	mkewK//5ct/UuGiOjLs2bkyv3TtsNm1FeKH7fq4nKoCgo8R35X+c6bF8iz+hx84yZdun4AVT89O
	xi+2bluXTpjcnkiDBBqRbSyjIrxI=
X-Google-Smtp-Source: AGHT+IGeJBpGKs8MTyCqIF7KiEXWtVJVhEgmHCJGR2AwCEysIcKML8h49AWwZtiK+qYj1P1TkFjW1g==
X-Received: by 2002:a17:903:32c7:b0:234:f580:9f8 with SMTP id d9443c01a7336-23507fda8edmr8895975ad.3.1748490156212;
        Wed, 28 May 2025 20:42:36 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:76aa:9d32:607:b042? ([2001:ee0:4f0e:fb30:76aa:9d32:607:b042])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-235069fa2c7sm3485485ad.0.2025.05.28.20.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 May 2025 20:42:35 -0700 (PDT)
Message-ID: <c75005c0-7e1a-48f0-b39b-b6310642ad4a@gmail.com>
Date: Thu, 29 May 2025 10:42:27 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v2 1/2] virtio-net: support zerocopy multi
 buffer XDP in mergeable
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-2-minhquangbui99@gmail.com>
 <d855c95e-06db-4c68-af01-8997ce9b9257@oracle.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <d855c95e-06db-4c68-af01-8997ce9b9257@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/28/25 23:44, ALOK TIWARI wrote:
>
>
> On 27-05-2025 21:49, Bui Quang Minh wrote:
>> Currently, in zerocopy mode with mergeable receive buffer, virtio-net
>> does not support multi buffer but a single buffer only. This commit adds
>> support for multi mergeable receive buffer in the zerocopy XDP path by
>> utilizing XDP buffer with frags.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 123 +++++++++++++++++++++------------------
>>   1 file changed, 66 insertions(+), 57 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e53ba600605a..a9558650f205 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -45,6 +45,8 @@ module_param(napi_tx, bool, 0644);
>>   #define VIRTIO_XDP_TX        BIT(0)
>>   #define VIRTIO_XDP_REDIR    BIT(1)
>>   +#define VIRTNET_MAX_ZC_SEGS    8
>> +
>>   /* RX packet size EWMA. The average packet size is used to 
>> determine the packet
>>    * buffer size when refilling RX rings. As the entire RX ring may 
>> be refilled
>>    * at once, the weight is chosen so that the EWMA will be 
>> insensitive to short-
>> @@ -1232,65 +1234,53 @@ static void xsk_drop_follow_bufs(struct 
>> net_device *dev,
>>       }
>>   }
>>   -static int xsk_append_merge_buffer(struct virtnet_info *vi,
>> -                   struct receive_queue *rq,
>> -                   struct sk_buff *head_skb,
>> -                   u32 num_buf,
>> -                   struct virtio_net_hdr_mrg_rxbuf *hdr,
>> -                   struct virtnet_rq_stats *stats)
>> +static int virtnet_build_xsk_buff_mrg(struct virtnet_info *vi,
>> +                      struct receive_queue *rq,
>> +                      u32 num_buf,
>> +                      struct xdp_buff *xdp,
>> +                      struct virtnet_rq_stats *stats)
>>   {
>> -    struct sk_buff *curr_skb;
>> -    struct xdp_buff *xdp;
>> -    u32 len, truesize;
>> -    struct page *page;
>> +    unsigned int len;
>>       void *buf;
>>   -    curr_skb = head_skb;
>> +    if (num_buf < 2)
>> +        return 0;
>> +
>> +    while (num_buf > 1) {
>> +        struct xdp_buff *new_xdp;
>>   -    while (--num_buf) {
>>           buf = virtqueue_get_buf(rq->vq, &len);
>> -        if (unlikely(!buf)) {
>> -            pr_debug("%s: rx error: %d buffers out of %d missing\n",
>> -                 vi->dev->name, num_buf,
>> -                 virtio16_to_cpu(vi->vdev,
>> -                         hdr->num_buffers));
>> +        if (!unlikely(buf)) {
>
> if (unlikely(!buf)) { ?

Thanks, I'll fix this in the next version.

>
>> +            pr_debug("%s: rx error: %d buffers missing\n",
>> +                 vi->dev->name, num_buf);
>>               DEV_STATS_INC(vi->dev, rx_length_errors);
>
> Thanks,
> Alok

