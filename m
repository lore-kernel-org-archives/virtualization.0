Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A937F2EB5CC
	for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 15:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750952087; cv=none; b=eI/3fl7LslJ/HJp71kgHUY4HxQWgeL5MqmMslaOqSIIrYf2rpymNfL5UoDJF2gOhA1pps5NrXiixD/NFSei746VGSFdr4grZJt2kzsjh0JdkjJ7+ev1g4nAdjPO2DUi1Bd3FPnOHQrhOaADPf5M2WP+hI5tCQSmv5WhMb3qlrzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750952087; c=relaxed/simple;
	bh=z64R6tLwT/igY0srnTmDc4NO29MbjXUBGb8NdSHwt+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpyKZ4m9kCCQjW9QNEai78niOwjhDBT6PpeUk1IGkO81IVoTqN7NrsLFcnDIjdyXy1kO1J2ZKNVxbjp147gd3WsGWPoYbtBvObTrEz9yrDeGE7/OT3mbC1SN1OOxVhT35ITeRQB4awzYfjRtM1XvpadlI7R5BbrHcKDwNdeG6gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GX2ULZTE; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GX2ULZTE"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23602481460so13886425ad.0
        for <virtualization@lists.linux.dev>; Thu, 26 Jun 2025 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750952085; x=1751556885; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kmmnms/Q/5n/J94E9RpKr+/e7+IT4/vH9W0izU+rtE0=;
        b=GX2ULZTEIbD1in+GT6L9Tew5QgB+hb9aslC/L+HTFwb4YAiA5/tJhQEndsm0kUtfkA
         mJFVmrxblDacws/aZmsZ9DDxSPaD8fHHqKQK0dYd7bcJHhMsJZUo52sjNcbcEsNsQec2
         sjBfFYPA8eW+51tqNPwMIoEmvJt5mCaBs8Wh+clH0zGg8V+VHrmkfozEi0qxt8dQe2aV
         Hm34FXVn7pK+EaPkEriS7odgzGjpFr653oQMoDgxysY9HzLPlIocN6wJwlp6egW25r5O
         hsIYHMuyo5TpMwtV6XkuC9R7ucx8O4JpFTqZcr842ooW7+loUg7KEcE3twM4albTPS0/
         bVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750952085; x=1751556885;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kmmnms/Q/5n/J94E9RpKr+/e7+IT4/vH9W0izU+rtE0=;
        b=f+CRF3Tu19NtmzJZQhgzbmTcXkjJANoknEJjTe6bcbnXIVw5Ryu885BgtpGCvlMCAA
         mrkKtAHkfn+TeVRiOqn9IunKrvJv4l/uLFVGv/TJX9AYNz+7R0/YroOwkl0V4IIGXgzJ
         9cuXZxTTTci0SQhZH2dKMcLaMuwoaBeyd9puknBw61iDrU27hszOHD/D5OYJ1U9Htpsw
         WQO7/HPxMC4apCkHQNFz2mw/SLdqPCHw3NQUD9qawcFX8a44hauHV/cWJFbG0EPvksNq
         iymLqywTKexk+zpidDmh+R0af4qDdPsm0FqM/lkDTZ52JueqAmlihxMbgDEhi/4i2Ygp
         qSqg==
X-Forwarded-Encrypted: i=1; AJvYcCXAYiYKXopG7x8uWngJg957dITPyZPKEr/TuRBmgRM4ESntxDJO4dG0Cl3YF9lr04IontFjERTyRzLsH6CSEA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw4n4lI+8NSFUAKsoby6bVOuDB3h6NRKuPfgMOUgJih/ke1KpG5
	txsvYnmkWACGA5TQR/8YsPNlE40M0V1F8+Q6s407aLXuIhER9SvGi2qy
X-Gm-Gg: ASbGncvGSjLlMr9J4B77PWNLOe+woufkccIrSMEtwaf0TleHU4onEXvnWtHUb8AYU+J
	ES0vNO/6AytyykqE0kQKMLwLO6qh04Q9CBboW/Hg+d3Zw1FMnDXJa+FryWUif0IHg2hhIRrM6TJ
	cPlZWrEr1bsbQDIPQKZ6UG35MDzFEaA+J32X/w4B2aYxvu8x1sjEueNL/aRxBbj3fMlKpDNko4G
	a/zvTUn/d/h8EGSqH9jAE5t5vfgdmDW+gm3uvZHF2LgX0kNZJGjrJsGmVtGNsmMiZ+XoVuSwlW8
	apNNzAI7vxVWkn+xhh/qyLJS7a549qS8M+Ge648uV+OSnKN/PAS4jI7nYz+TBjY8M95VfsMV67Z
	sG7gygOzlMfI8yJJUgzCA8dXLk3EVixHSTOJojOrW
X-Google-Smtp-Source: AGHT+IEBro7NaKKN1SAi+5I/Ua/Xx0H51iguRiKyeGlRJfzrEBuaCq+4+1hrclw+rac7IKJnr/e9og==
X-Received: by 2002:a17:903:1986:b0:235:f49f:479d with SMTP id d9443c01a7336-238c86ee14amr53330745ad.3.1750952084612;
        Thu, 26 Jun 2025 08:34:44 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:2b9f:aa14:497d:25f1? ([2001:ee0:4f0e:fb30:2b9f:aa14:497d:25f1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23abe440a69sm799565ad.242.2025.06.26.08.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 08:34:44 -0700 (PDT)
Message-ID: <0bf0811e-cdb8-4410-9b69-1c38b06bbadf@gmail.com>
Date: Thu, 26 Jun 2025 22:34:35 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] virtio-net: ensure the received length does not
 exceed allocated size
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20250625160849.61344-1-minhquangbui99@gmail.com>
 <20250625160849.61344-2-minhquangbui99@gmail.com>
 <CACGkMEvioXkt3_zB-KijwhoUx5NS5xa0Jvd=w2fhBZFf3un1Ww@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEvioXkt3_zB-KijwhoUx5NS5xa0Jvd=w2fhBZFf3un1Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/26/25 09:34, Jason Wang wrote:
> On Thu, Jun 26, 2025 at 12:10 AM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> In xdp_linearize_page, when reading the following buffers from the ring,
>> we forget to check the received length with the true allocate size. This
>> can lead to an out-of-bound read. This commit adds that missing check.
>>
>> Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
> I think we should cc stable.

Okay, I'll do that in next version.

>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 27 ++++++++++++++++++++++-----
>>   1 file changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e53ba600605a..2a130a3e50ac 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1797,7 +1797,8 @@ static unsigned int virtnet_get_headroom(struct virtnet_info *vi)
>>    * across multiple buffers (num_buf > 1), and we make sure buffers
>>    * have enough headroom.
>>    */
>> -static struct page *xdp_linearize_page(struct receive_queue *rq,
>> +static struct page *xdp_linearize_page(struct net_device *dev,
>> +                                      struct receive_queue *rq,
>>                                         int *num_buf,
>>                                         struct page *p,
>>                                         int offset,
>> @@ -1818,17 +1819,33 @@ static struct page *xdp_linearize_page(struct receive_queue *rq,
>>          page_off += *len;
>>
>>          while (--*num_buf) {
>> -               unsigned int buflen;
>> +               unsigned int headroom, tailroom, room;
>> +               unsigned int truesize, buflen;
>>                  void *buf;
>> +               void *ctx;
>>                  int off;
>>
>> -               buf = virtnet_rq_get_buf(rq, &buflen, NULL);
>> +               buf = virtnet_rq_get_buf(rq, &buflen, &ctx);
>>                  if (unlikely(!buf))
>>                          goto err_buf;
>>
>>                  p = virt_to_head_page(buf);
>>                  off = buf - page_address(p);
>>
>> +               truesize = mergeable_ctx_to_truesize(ctx);
> This won't work for receive_small_xdp().

If it is small mode, the num_buf == 1 and we don't get into the while loop.

>
>> +               headroom = mergeable_ctx_to_headroom(ctx);
>> +               tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
>> +               room = SKB_DATA_ALIGN(headroom + tailroom);
>> +
>> +               if (unlikely(buflen > truesize - room)) {
>> +                       put_page(p);
>> +                       pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
>> +                                dev->name, buflen,
>> +                                (unsigned long)(truesize - room));
>> +                       DEV_STATS_INC(dev, rx_length_errors);
>> +                       goto err_buf;
>> +               }
> I wonder if this issue only affect XDP should we check other places?

In small mode, we check the len with GOOD_PACKET_LEN in receive_small. 
In mergeable mode, we have some checks over the place and this is the 
only one I see we miss. In xsk, we check inside buf_to_xdp. However, in 
the big mode, I feel like there is a bug.

In add_recvbuf_big, 1 first page + vi->big_packets_num_skbfrags pages. 
The pages are managed by a linked list. The vi->big_packets_num_skbfrags 
is set in virtnet_set_big_packets

     vi->big_packets_num_skbfrags = guest_gso ? MAX_SKB_FRAGS : 
DIV_ROUND_UP(mtu, PAGE_SIZE);

So the vi->big_packets_num_skbfrags can be fewer than MAX_SKB_FRAGS.

In receive_big, we call to page_to_skb, there is a check

     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE)) {
         /* error case */
     }

But because the number of allocated buffer is 
vi->big_packets_num_skbfrags + 1 and vi->big_packets_num_skbfrags can be 
fewer than MAX_SKB_FRAGS, the check seems not enough

     while (len) {
         unsigned int frag_size = min((unsigned)PAGE_SIZE - offset, len);
         skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags, page, offset,
                 frag_size, truesize);
         len -= frag_size;
         page = (struct page *)page->private;
         offset = 0;
     }

In the following while loop, we keep running based on len without NULL 
check the pages linked list, so it may result into NULL pointer dereference.

What do you think?

Thanks,
Quang Minh.

>
>> +
>>                  /* guard against a misconfigured or uncooperative backend that
>>                   * is sending packet larger than the MTU.
>>                   */
>> @@ -1917,7 +1934,7 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
>>                  headroom = vi->hdr_len + header_offset;
>>                  buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
>>                          SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>> -               xdp_page = xdp_linearize_page(rq, &num_buf, page,
>> +               xdp_page = xdp_linearize_page(dev, rq, &num_buf, page,
>>                                                offset, header_offset,
>>                                                &tlen);
>>                  if (!xdp_page)
>> @@ -2252,7 +2269,7 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
>>           */
>>          if (!xdp_prog->aux->xdp_has_frags) {
>>                  /* linearize data for XDP */
>> -               xdp_page = xdp_linearize_page(rq, num_buf,
>> +               xdp_page = xdp_linearize_page(vi->dev, rq, num_buf,
>>                                                *page, offset,
>>                                                XDP_PACKET_HEADROOM,
>>                                                len);
>> --
>> 2.43.0
>>

