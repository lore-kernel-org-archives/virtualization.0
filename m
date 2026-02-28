Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB9E824A3
	for <virtualization@lists.linux.dev>; Sat, 28 Feb 2026 05:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772255024; cv=none; b=WzEkOwlm9zQJQx2Upqf44Tivvd5aK27aMQLH2ZwXr1jcalQU60hC5Fhox8rYzpROXueBRgOfLiX09r7rI8IYzrkZwx+Sbe7ZutQb14DFDtDU9ZDOwWtZky9PrKqqXaplOtaeIeDxvNFvQHE5hw+tZJlgx13/dCywNB29TbHV4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772255024; c=relaxed/simple;
	bh=WZGn9t6Nnd4BlPrgobIshCbzAK0yZTeNkprJ1mTTlpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCt0Qk0KAV8rZO/AEDUWROHRMT/NJR0dV3TJgpD7RMHNAj0nWZjCS1yEyW5JHxC5Pk26Vsw1WWtwREYUItWZBqWaaCp2Yuk30GauGbKfEn40aEhW4Igtmsvjb01sZZj66IiUowngSjEwt5j/ws7aBAh+uh9+6NCqqMSskN6O0m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5/wU54d; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5/wU54d"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aaecf9c325so18369125ad.1
        for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 21:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772255023; x=1772859823; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riNYAikMZikDJOkTEd8N59a4JFCUVwaQB1blSZtd5Jg=;
        b=G5/wU54dCENmehH4JfU0j8wMNFSyvyJPGi5w0f+xjEo8s3UAbiKtugDbjR4GCqwETw
         +JGPmFyVqN/7iogkX8g11lxGF7crW9cehvuRlUN7ey2J8nQhBLYxD7rXQlIIUxm8TX5H
         X/v3II6Mns+CEwPx9Jr0LwPxQIhOMCTS134uE1SY4myMQX1wfmvgSeRjZJBXvolMp0aO
         DzaRneiLfsPfqzkXeNHS70nWsugYLTOBYnaqv6Fv92d4FVN4c38J8s7hCa7fnsf0MvaR
         dGGr8zdJmwbOp2JoaU8W6egmmNxggeNEtogkEEzjJ6iS4boXGAG2y4RJBqrNTaDKrD6m
         Cv+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772255023; x=1772859823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riNYAikMZikDJOkTEd8N59a4JFCUVwaQB1blSZtd5Jg=;
        b=fjxzKkd239M/GqCzIYnxyGq+7Em76qGS8dNB2tVGjtHDKjIb8O3t5VQCntlUF/1uGu
         bPBzjqQozPyB/wPxGuqcXYdv1LwdqGRoBhg2TQ5/NAvej4v9yk27n6jryMxO0KGYGFRT
         ihY1WfZLvMapDVpZi6gBtyH82olrFrJtpvXyzrlE4Te4QNbAi+GFxJukpU35oxNxu3Mf
         TuPUZhSIxHUWf0VeLW07usEKexFItTY476BhvKkgQ8kR/b9AFvtnPTkymlxSCfvhX/gi
         ow9n1MAEDkuEF4URQ82zGS41V+n4fGtUYgQxxXbesVfeM18UFC8gfuydeKR4GZjfhYNq
         C8Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWCze4t1wVxNYGxQSOJMjE+1QyZ2ptUFjlJbJGcqpJ9RYHsMKhHWZ8tjN3uoKvKvktbz4/eXpfk+RJiksS5bQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwaLxkkUfBUFUDnh8ZWGvfaCVf19nM0LvRjGlOji93UOrkJtFfk
	VHoUV0Yzh+rkqFsWxCNZJ47CmhXwa4ejVUIJUqI2OUWOojabAzUMXolz
X-Gm-Gg: ATEYQzzdHHTPhGutAFh3jHA/R0UtIa/exMWagdR3Nu8oHlRyt9mJD5w4n38oulTGgv/
	/f1xxIOV5Ge/06do0LT9pA5p06QxRtNFlluPy6cwdGDIs3V/l4XLzjXDDumVqWQA1T2yaJjUImk
	v5Xq0wn2u/ElJ/x7p8dk+d2lVjT43Vqfu4zmIX8es6PyAwtnKh7U4kppc9yfQihKyQMEptEKkN4
	J3FFKVwocTKByLTmIlimBhSKqMCUcuXa84O6+wTm+vlEvPQQfQO0A8sFLhOdAEfiEC8DEoE5spH
	k75Ts1kS//nNHJ8Nsbstb9C1RF2acj3CrfiV+3ubSmP9qdlqrVL66iafNK555EZqay6ad9W9G6g
	djObXWFSuRKouhda8itVOLjbwECNp5q95rCCyPcmWAPu+ZJFC5gK+xT8KHzaebyGrMtCflAWH8A
	dWqAnDAve099Bm813PXNOh1CgZj5g6h9xbEBCokokJ5Am8aM54bUwBfjdvV2eMaRKYTXsRfcbVL
	z82rg==
X-Received: by 2002:a17:903:1a03:b0:2aa:e3d1:1430 with SMTP id d9443c01a7336-2ae2bbd72fbmr53761865ad.23.1772255022668;
        Fri, 27 Feb 2026 21:03:42 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f0f:b1d0:aab1:76d6:d5d9:2ab0? ([2001:ee0:4f0f:b1d0:aab1:76d6:d5d9:2ab0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1b2c51sm4794775ad.19.2026.02.27.21.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 21:03:42 -0800 (PST)
Message-ID: <43b3b8dc-bc99-497a-a845-a9697c126d3f@gmail.com>
Date: Sat, 28 Feb 2026 12:03:31 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] virtio-net: xsk: Support wakeup on RX side
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260227150949.13089-1-minhquangbui99@gmail.com>
 <CAL+tcoBdEQ0jhRCqpC8zoc+yLBYdYvLgBzF5Ov2284a87UM-UQ@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CAL+tcoBdEQ0jhRCqpC8zoc+yLBYdYvLgBzF5Ov2284a87UM-UQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jason,

On 2/28/26 10:49, Jason Xing wrote:
> Hi Bui,
>
> On Fri, Feb 27, 2026 at 11:20 PM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
>> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
>> wasting CPU cycles on polling. Users will be notified and they need to
>> make a wakeup call after refilling the ring.
>>
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++--------
>>   1 file changed, 30 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index db88dcaefb20..494acc904b2c 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>>          xsk_buffs = rq->xsk_buffs;
>>
>>          num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
>> -       if (!num)
>> +       if (!num) {
>> +               if (xsk_uses_need_wakeup(pool)) {
>> +                       xsk_set_rx_need_wakeup(pool);
>> +                       /* Return 0 instead of -ENOMEM so that NAPI is
>> +                        * descheduled.
>> +                        */
>> +                       return 0;
>> +               }
>> +
>>                  return -ENOMEM;
>> +       } else {
>> +               xsk_clear_rx_need_wakeup(pool);
>> +       }
>>
>>          len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
>>
>> @@ -1588,20 +1599,21 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>>          return sent;
>>   }
>>
>> -static void xsk_wakeup(struct send_queue *sq)
>> +static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
>>   {
>> -       if (napi_if_scheduled_mark_missed(&sq->napi))
>> +       if (napi_if_scheduled_mark_missed(napi))
>>                  return;
>>
>>          local_bh_disable();
>> -       virtqueue_napi_schedule(&sq->napi, sq->vq);
>> +       virtqueue_napi_schedule(napi, vq);
>>          local_bh_enable();
>>   }
>>
>>   static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>   {
>>          struct virtnet_info *vi = netdev_priv(dev);
>> -       struct send_queue *sq;
>> +       struct napi_struct *napi;
>> +       struct virtqueue *vq;
>>
>>          if (!netif_running(dev))
>>                  return -ENETDOWN;
>> @@ -1609,9 +1621,19 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>          if (qid >= vi->curr_queue_pairs)
>>                  return -EINVAL;
>>
>> -       sq = &vi->sq[qid];
>> +       if (flag == XDP_WAKEUP_TX) {
> Better use &?

Sorry, I don't get your point. Can you elaborate more?

Thanks,
Quang Minh.
