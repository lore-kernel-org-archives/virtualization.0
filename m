Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CE8331A53
	for <virtualization@lists.linux.dev>; Sat, 28 Feb 2026 06:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772259922; cv=none; b=jYqF2CvOWHUdCrA7mJj7ul3uZKVnR7IrjqFL6+jLaUjlV/tStuM33r82gdUD4z6qo0IGpT++sqsFqld+yECii6z03P6sfi/MnPO/9zq007uwGKJEP4/jTdzJHzgfc9ebzmZhxnL/qDYZqUPNEDuH0uH82mqJ0ft08GsOyp2eGZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772259922; c=relaxed/simple;
	bh=yoLx06V8W3H0FphAVQaQvkl2uDNlge7+OLs+wk8pudE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nckoFmDXWp80CU7RmrAN+0ivCX1r/Q3B0ZGAch2W8U3GXGHRQ74YvYfUNu3hWVO01lj5eXZXTkPAENgTQ8M1tSdvHiLDeqYNDxIsI9nzObVzF18fw/AkK+NEJhJbwkwa6nikFMha6+ixUcw+nvuzMw24s4ixAFgfwkJZv4k9dj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9P1KD9t; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9P1KD9t"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c6e23cb81f4so1165983a12.2
        for <virtualization@lists.linux.dev>; Fri, 27 Feb 2026 22:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772259921; x=1772864721; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpmNa4LRDCDwDZn6prMKh0tlUtQh8okPWCFVVp33444=;
        b=L9P1KD9tJxFY1weYavrwYl2HCwayIKv1Gm1+NQ0g4n08fT+9pzEXXaQm6A57FjE5jx
         1DYEIoBM2+dAtou+CBJkv0TyN/SVU3kjTFMysEbK4Bsl8ms28ZgzSEIlUAgrKmBGJCvc
         UQyipsko23rw7P+O1CBcPjexCXZOwO1xfQ/iWPBabrlNw3GVeAay1pzHPDFbjo30FDFy
         9bumzytFdabPr3ydSVD5L0nGWPaTa+HFnxKgBMJ0L+fsoB4+13sxwHMhDhLqloL/9OFO
         eJL7PZ6nHOAMh3UIaxxZJNokLycXi0zr61VD/guC+hbBmghBINgojzjvdRVUol4/jtew
         jb8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772259921; x=1772864721;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpmNa4LRDCDwDZn6prMKh0tlUtQh8okPWCFVVp33444=;
        b=JRgCKiU4kII4KohZ9KOAW7FgQEF84l6aFYXjcyz/PMxYGYn8abPRCtdjDGy+PFMKd1
         x5LFfCeNBM49BTZS56/F24FgBGK9olz4/KMfA5zX7XWpMo4DypK+KbNjVkeBq4K4rbsC
         vlGxp4WO900EtRl5LqbyeRQIYCY079rBALHNMZqBGWN+HtqgV/yH8p51+m0pdWK1tmh+
         UyOKmGAgAsRZCffnXDY6IYDAinGlzuubjQQ4rjg0m6tJrARtconeDkahQ3j5AoW8c9KB
         UDfMiTgkthacAVh72UiuGwKjkrwj+AMYWWuH7h5Jq7Vj62ix/xeywfe14ZXbI8GOyc2B
         ehGA==
X-Forwarded-Encrypted: i=1; AJvYcCVfYO56dREY4bjRAF8JHCPeowBgRmi/HbBISFWP2uzTwoNvz/eTfQ9HIGqMWPPOctbnuUuOeXiQKmgRmXiq6g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZVEA65la8betP49mD6Bs14gHJOuTmTklYbIdHgMF152JGWHbj
	5Z0gzQtch5xWf+3fleg5hsZ01NJCDqE14VOQrzdevkkCsVM/ghhWOA02eIrgPR2n4vU=
X-Gm-Gg: ATEYQzwbeNRPdL6VE4mewcof+/ZbokR9S0rOuzuYqMhzYc5vCxpaXy2BfFrojYkvR46
	VT4hybND1jkR/Ty/S/SwY9NQwXQNRbCJh/7DZ+Cr+a6XhdDSyKVB/n8W9WDustdvMUxwWgQDqrg
	+iR2cFqLpHvTj+pzlZFyGpaU/IDoLhnXF3YLsVo34vkRAhdTdZ2aVWoP+FXNxPSaoFZsqDEE5fX
	TncDdJhlSPY77F6F0IDB5ma66z5YBsIM9xAlH8/ThzfZ3eqJFVRtY7T/oK2rXGxDRpE+qCv68Rx
	/H7qzsPBe1ca7g9ggaqTlhnyJGvUF82KPq2VAWXoD5FLtziuCuSXxWOifpuIT8VUYrnP0ZF7kV8
	LgL9hlhDQg/xxGLUfE0KlORIYmLe/Wm1W+pYNPPD6G96H0swSh+vtD5BZiesqvfnWkmSrXMfwj+
	T/bmE1tfaOWDNiPxHtCqDT7hl44b4NBXQALaCDwbE4fyHkpp3Cj+oPceDYx1dsh9LpV1SUGfrG7
	8FhNg==
X-Received: by 2002:a17:90b:240e:b0:359:7b9a:2cec with SMTP id 98e67ed59e1d1-3597b9a2d7emr624977a91.0.1772259920683;
        Fri, 27 Feb 2026 22:25:20 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f0f:b1d0:7a59:6e8f:1a0b:107a? ([2001:ee0:4f0f:b1d0:7a59:6e8f:1a0b:107a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3593dcc9c37sm6888309a91.8.2026.02.27.22.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 22:25:20 -0800 (PST)
Message-ID: <829f4263-dfd2-4664-b66c-0a65f35aa57a@gmail.com>
Date: Sat, 28 Feb 2026 13:25:13 +0700
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
 <43b3b8dc-bc99-497a-a845-a9697c126d3f@gmail.com>
 <CAL+tcoAy7YjkODWp=nCagEJwOzhqt_BL4kcfxpj=FSiAXP_+qg@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CAL+tcoAy7YjkODWp=nCagEJwOzhqt_BL4kcfxpj=FSiAXP_+qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/28/26 13:16, Jason Xing wrote:
> On Sat, Feb 28, 2026 at 1:03 PM Bui Quang Minh <minhquangbui99@gmail.com> wrote:
>> Hi Jason,
>>
>> On 2/28/26 10:49, Jason Xing wrote:
>>> Hi Bui,
>>>
>>> On Fri, Feb 27, 2026 at 11:20 PM Bui Quang Minh
>>> <minhquangbui99@gmail.com> wrote:
>>>> When XDP_USE_NEED_WAKEUP is used and the fill ring is empty so no buffer
>>>> is allocated on RX side, allow RX NAPI to be descheduled. This avoids
>>>> wasting CPU cycles on polling. Users will be notified and they need to
>>>> make a wakeup call after refilling the ring.
>>>>
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>> ---
>>>>    drivers/net/virtio_net.c | 38 ++++++++++++++++++++++++++++++--------
>>>>    1 file changed, 30 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index db88dcaefb20..494acc904b2c 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -1454,8 +1454,19 @@ static int virtnet_add_recvbuf_xsk(struct virtnet_info *vi, struct receive_queue
>>>>           xsk_buffs = rq->xsk_buffs;
>>>>
>>>>           num = xsk_buff_alloc_batch(pool, xsk_buffs, rq->vq->num_free);
>>>> -       if (!num)
>>>> +       if (!num) {
>>>> +               if (xsk_uses_need_wakeup(pool)) {
>>>> +                       xsk_set_rx_need_wakeup(pool);
>>>> +                       /* Return 0 instead of -ENOMEM so that NAPI is
>>>> +                        * descheduled.
>>>> +                        */
>>>> +                       return 0;
>>>> +               }
>>>> +
>>>>                   return -ENOMEM;
>>>> +       } else {
>>>> +               xsk_clear_rx_need_wakeup(pool);
>>>> +       }
>>>>
>>>>           len = xsk_pool_get_rx_frame_size(pool) + vi->hdr_len;
>>>>
>>>> @@ -1588,20 +1599,21 @@ static bool virtnet_xsk_xmit(struct send_queue *sq, struct xsk_buff_pool *pool,
>>>>           return sent;
>>>>    }
>>>>
>>>> -static void xsk_wakeup(struct send_queue *sq)
>>>> +static void xsk_wakeup(struct napi_struct *napi, struct virtqueue *vq)
>>>>    {
>>>> -       if (napi_if_scheduled_mark_missed(&sq->napi))
>>>> +       if (napi_if_scheduled_mark_missed(napi))
>>>>                   return;
>>>>
>>>>           local_bh_disable();
>>>> -       virtqueue_napi_schedule(&sq->napi, sq->vq);
>>>> +       virtqueue_napi_schedule(napi, vq);
>>>>           local_bh_enable();
>>>>    }
>>>>
>>>>    static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>>>    {
>>>>           struct virtnet_info *vi = netdev_priv(dev);
>>>> -       struct send_queue *sq;
>>>> +       struct napi_struct *napi;
>>>> +       struct virtqueue *vq;
>>>>
>>>>           if (!netif_running(dev))
>>>>                   return -ENETDOWN;
>>>> @@ -1609,9 +1621,19 @@ static int virtnet_xsk_wakeup(struct net_device *dev, u32 qid, u32 flag)
>>>>           if (qid >= vi->curr_queue_pairs)
>>>>                   return -EINVAL;
>>>>
>>>> -       sq = &vi->sq[qid];
>>>> +       if (flag == XDP_WAKEUP_TX) {
>>> Better use &?
>> Sorry, I don't get your point. Can you elaborate more?
> Oh, I meant using 'flag & XDP_WAKEUP_TX' is preferrable. IIUC, since
> this patch provides a way to enable the RX flag, for virtio_net, this
> flag can be set by TX and RX altogether? Please see this call trace:
> xsk_poll()->xsk_wakeup(xs, pool->cached_need_wakeup).

Oh, you're right. I'll fix it in the next version.

Thanks,
Quang Minh.

