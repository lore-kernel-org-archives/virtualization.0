Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB21DF987
	for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 08:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744272563; cv=none; b=an42/EwArpfmz9veDreACb+EYWZuspmXyONes0n3ch2RljO6tSPk75smr5x2jeGrVEszRUrN+T+PFp9c30wzWNlr/C2FX9aRptkpH0ARdDeaaCMrpWXEe8HwRqnJeCzq2PeOSroFd4OXO2LkjIqX2Ze3yuTkrJ8KEtVjcl5F3N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744272563; c=relaxed/simple;
	bh=Vyno924JZezqTnFi39JNlTWkIO0+AmDF/Z/qP+4RgJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqhA6P1ygwuytcrIHzc8hYed89nIe32zqK9HEuD4ZKvYK5jVMubYSk8E4qRtWoVsdDI5MyYffB5mRFi0i0H75ZnAYn4JUK7xVCwQ8KBaqIL++he0Qj/ZavvJAS5Y6h6Qcfc6LYZ803Vs3059It8c20LQ2chtG+rAEwKegbWQJGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2kJEy5O; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2kJEy5O"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af548cb1f83so541083a12.3
        for <virtualization@lists.linux.dev>; Thu, 10 Apr 2025 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744272561; x=1744877361; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AjG0X0ILsaEZt1vBf8MVQgDYPYTp29VUnEYLYjosri4=;
        b=l2kJEy5O5WIAeLD+fz0P/xnsH+uNCiKdHL0uTHTdkqe5VojtoPZjVjnQK91XDe+w70
         7QbjZk09Xy1ft+4PHcQ2JrKIDz2SQC1/NsqrY2Iyum7Jo5Z9b+tVmmBkrGPEzLsRHw9G
         z5AHkR634MaIJKoGcdar/qlSF1GiZZOxOoixAiV6kGzs6CAm1Sn9knDSNG8YlSAynZec
         wFXGowy9Yn8bdPckWmJHr2doeMvgDLqGtajWP18QhfFSUlyUFfymf/yhPb0FoKvS7D+R
         8e940S7Cjx8ZzhwJ/tlUJU9L6X65Tk71V/Ht8XxYYSpLbQfzyRWTw49tgaL1Bd74hoS7
         da6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744272561; x=1744877361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AjG0X0ILsaEZt1vBf8MVQgDYPYTp29VUnEYLYjosri4=;
        b=B03gxNUyomhHN6cyKNLXJzqvQQBMfre+WAEnzuA587gcD+EEbcm4F42ZNA54QjbJrX
         4Qj/XbANmqhGno9ce9nWiKRfvDt5qwYe2rw5p57+w0Z2w+x01iLaJSFbc54arEebmqr3
         Z7h7cGSl4NfY/JR3vpPIh7Wicxxn30742z0NQ0jEEznPJ2Bmj76+p3a9zz9Qq8f6TslJ
         2GDKBode3R279ZoEUVdhSRMCdjBftL6+y2QCVaEJ1mJ/DmTLUo/TAdljxUtpZAwoXLlj
         Kl1hLLuPinaH8fhUPIZntIn72BjY4ZSc/cg1hB+2eHmRIQhERN2jy7GpNHRlhPEFJG2G
         L2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYW9SOUtG2O0Pu/0xMwQ0aZeDe8KyQ42C2zpj5J03SF6Jkj6EczDFJyV8q/1aVJPCcPCcklqaQApjET+gGww==@lists.linux.dev
X-Gm-Message-State: AOJu0YwJ8KOs4MPsEU3S5Cgt67F2Luda2IcVqVFwDDmvLLeBTeackQIn
	PBXmjASxcDTVo9AgvGexdkwBSg6CAEEhsBoXiKIeRPmodU5g2Lcd
X-Gm-Gg: ASbGncthbuKMBEyfmGvxI5SflBrOSRxke2mmcKq8Tls6nnNCrTMztCR19mN/7YCQ15J
	/Ib342KowAi2jrlzeL0j0pfV9k716X50Xt2K3kTdVcknaJ57KdonnX/H7fvtdaX3b7u1t/HMUn0
	5agK3iLXWje8n0QYByTOszDbpWX7/CgmaqnPG1YGgMr1tmDhCCyReTSG5h/ZUAdYPz6jIdaxjAI
	vOA/QH52qR9kZ75pu7LcCnvfv8rHI5R5lX3zEmkU8PghxSkx8koCFQCukeGgbpDTw4P1NVErWIp
	qZ3ppBto9eT1gMW4SpSPH2dtgXlJEktsS6Wyvk3SlSPcPU5RpG9rsS1YncBCipwgx+8mN6ysMVm
	U/RSu2WhS+92uWuOy4H8=
X-Google-Smtp-Source: AGHT+IGlFaX35JSmF5xXiiSbldTiaLvL6d+ktyX+51i5YLyTONObh2bMZLgvRVqMK1AZZfqqaQtgRg==
X-Received: by 2002:a17:90a:d64b:b0:2ee:f687:6acb with SMTP id 98e67ed59e1d1-30718b76a8emr2884244a91.13.1744272560461;
        Thu, 10 Apr 2025 01:09:20 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:959f:bd4a:33b6:cab1? ([2001:ee0:4f0e:fb30:959f:bd4a:33b6:cab1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b8b2absm24625785ad.83.2025.04.10.01.09.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 01:09:20 -0700 (PDT)
Message-ID: <84adec63-0ccd-449c-babf-994d579f3677@gmail.com>
Date: Thu, 10 Apr 2025 15:09:13 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-net: hold netdev_lock when pausing rx
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20250404093903.37416-1-minhquangbui99@gmail.com>
 <1743987836.9938157-1-xuanzhuo@linux.alibaba.com>
 <30419bd6-13b1-4426-9f93-b38b66ef7c3a@gmail.com>
 <CACGkMEs7O7D5sztwJVn45c+1pap20Oi5f=02Sy_qxFjbeHuYiQ@mail.gmail.com>
 <4195db62-db43-4d61-88c3-7a7fbb164726@gmail.com>
 <b7b1f5de-7003-4960-a9d1-883bf2f1aa77@gmail.com>
 <4d3a1478-b6fc-47a3-8d77-7eca6a973a06@gmail.com>
 <20250410035158-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20250410035158-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/10/25 14:58, Michael S. Tsirkin wrote:
> On Thu, Apr 10, 2025 at 02:05:57PM +0700, Bui Quang Minh wrote:
>> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
>> napi_disable() on the receive queue's napi. In delayed refill_work, it
>> also calls napi_disable() on the receive queue's napi. When
>> napi_disable() is called on an already disabled napi, it will sleep in
>> napi_disable_locked while still holding the netdev_lock. As a result,
>> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
>> This leads to refill_work and the pause-then-resume tx are stuck
>> altogether.
>>
>> This scenario can be reproducible by binding a XDP socket to virtio-net
>> interface without setting up the fill ring. As a result, try_fill_recv
>> will fail until the fill ring is set up and refill_work is scheduled.
>>
>> This commit makes the pausing rx path hold the netdev_lock until
>> resuming, prevent any napi_disable() to be called on a temporarily
>> disabled napi.
>>
>> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>>   drivers/net/virtio_net.c | 74 +++++++++++++++++++++++++---------------
>>   1 file changed, 47 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 7e4617216a4b..74bd1065c586 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2786,9 +2786,13 @@ static void skb_recv_done(struct virtqueue *rvq)
>>   }
>>
>>   static void virtnet_napi_do_enable(struct virtqueue *vq,
>> -                   struct napi_struct *napi)
>> +                   struct napi_struct *napi,
>> +                   bool netdev_locked)
>>   {
>> -    napi_enable(napi);
>> +    if (netdev_locked)
>> +        napi_enable_locked(napi);
>> +    else
>> +        napi_enable(napi);
>>
>>       /* If all buffers were filled by other side before we napi_enabled, we
>>        * won't get another interrupt, so process any outstanding packets now.
>> @@ -2799,16 +2803,16 @@ static void virtnet_napi_do_enable(struct virtqueue
>> *vq,
>
>
>
> Your patch is line-wrapped, unfortunately. Here and elsewhere.
>
>
>
>
>>       local_bh_enable();
>>   }
>>
>> -static void virtnet_napi_enable(struct receive_queue *rq)
>> +static void virtnet_napi_enable(struct receive_queue *rq, bool
>> netdev_locked)
>>   {
>>       struct virtnet_info *vi = rq->vq->vdev->priv;
>>       int qidx = vq2rxq(rq->vq);
>>
>> -    virtnet_napi_do_enable(rq->vq, &rq->napi);
>> +    virtnet_napi_do_enable(rq->vq, &rq->napi, netdev_locked);
>>       netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, &rq->napi);
>>   }
>>
>> -static void virtnet_napi_tx_enable(struct send_queue *sq)
>> +static void virtnet_napi_tx_enable(struct send_queue *sq, bool
>> netdev_locked)
>>   {
>>       struct virtnet_info *vi = sq->vq->vdev->priv;
>>       struct napi_struct *napi = &sq->napi;
>> @@ -2825,11 +2829,11 @@ static void virtnet_napi_tx_enable(struct send_queue
>> *sq)
>>           return;
>>       }
>>
>> -    virtnet_napi_do_enable(sq->vq, napi);
>> +    virtnet_napi_do_enable(sq->vq, napi, netdev_locked);
>>       netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, napi);
>>   }
>>
>> -static void virtnet_napi_tx_disable(struct send_queue *sq)
>> +static void virtnet_napi_tx_disable(struct send_queue *sq, bool
>> netdev_locked)
>>   {
>>       struct virtnet_info *vi = sq->vq->vdev->priv;
>>       struct napi_struct *napi = &sq->napi;
>> @@ -2837,18 +2841,24 @@ static void virtnet_napi_tx_disable(struct
>> send_queue *sq)
>>
>>       if (napi->weight) {
>>           netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_TX, NULL);
>> -        napi_disable(napi);
>> +        if (netdev_locked)
>> +            napi_disable_locked(napi);
>> +        else
>> +            napi_disable(napi);
>>       }
>>   }
>>
>> -static void virtnet_napi_disable(struct receive_queue *rq)
>> +static void virtnet_napi_disable(struct receive_queue *rq, bool
>> netdev_locked)
>>   {
>>       struct virtnet_info *vi = rq->vq->vdev->priv;
>>       struct napi_struct *napi = &rq->napi;
>>       int qidx = vq2rxq(rq->vq);
>>
>>       netif_queue_set_napi(vi->dev, qidx, NETDEV_QUEUE_TYPE_RX, NULL);
>> -    napi_disable(napi);
>> +    if (netdev_locked)
>> +        napi_disable_locked(napi);
>> +    else
>> +        napi_disable(napi);
>>   }
>>
>>   static void refill_work(struct work_struct *work)
>> @@ -2875,9 +2885,11 @@ static void refill_work(struct work_struct *work)
>>            *     instance lock)
>>            *   - check netif_running() and return early to avoid a race
>>            */
>> -        napi_disable(&rq->napi);
>> +        netdev_lock(vi->dev);
>> +        napi_disable_locked(&rq->napi);
>>           still_empty = !try_fill_recv(vi, rq, GFP_KERNEL);
>
> This does mean netdev_lock is held potentially for a long while,
> while try_fill_recv and processing inside virtnet_napi_do_enable
> finish. Better ideas?
I prefer the first patch in this thread where we disable delayed refill 
and cancel all inflight refill_work before pausing rx.

Thanks,
Quang Minh.

