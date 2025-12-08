Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494FD770FE
	for <virtualization@lists.linux.dev>; Mon,  8 Dec 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765208918; cv=none; b=qBdOK2XrRoq3KMyamzb2BU+UOgp1/50Gx18W+xwC4nLVt047dW6KNssdr6hMQ6rHZG5TdzFYFzs5AeAgiSuq1x0U2gwA2wcKmEgCmqxvmaBa3IfG52MYcfjZ4kLS2i4t49s0UpSeRPoqSJ4qwrFc19qQ4nE4fuZNZa67A99a2ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765208918; c=relaxed/simple;
	bh=GIe51SBbOV61i2OkQiV+hl9lrmVGOhg2GykPvA68RG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pFRFjpeJ46QFBkziBQXcDpBc94JmVAEJP9vi6N+EcrsmsUl+787CGG4UBNfXkC4z2w8oSNCbrA/1dgOkHyWK11VVDlCSbNjU4B82EhArA1ufDGzIEKRsMFIRJGmjaQotXcif6iueNYreJ/D2rSe+XYtDXFgsMo4kt9LV/zJ8/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9BxssQo; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9BxssQo"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29555b384acso47163095ad.1
        for <virtualization@lists.linux.dev>; Mon, 08 Dec 2025 07:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765208915; x=1765813715; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGv9aN7BEkdqP9E26uFmq1NkbKlMnXUqNJ54IveYt7c=;
        b=P9BxssQoA/k25xsf281vx2s6b1yzyjW42jb9n3/+xJP5fhPIew5f2wfBa89s4CyNPJ
         +v0Okim62eDrv1BdqOJeSAYibTSUF0AsWWlO9jVuI1wlbqTHlzJNSVX1n+vJumR0Z8mn
         C4vTAjDINDpxPBhduYA8M0vndEzxdXCUwPbOwqIO9v9byQFO20XUB8mUUglusD20l5c4
         /Kq5Ra8RiigSk65odLqErPr+FUuyjUHIy16Ep6oZUrK940U9ccP4/76bM8z5C1inzLzQ
         WaUF2c/ZE38sxQkETb3xH8zrVg+OjN7GRuFEt52q5fT+Zz6/L5KDxPEvnCV2lebB/MQn
         hLng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765208915; x=1765813715;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGv9aN7BEkdqP9E26uFmq1NkbKlMnXUqNJ54IveYt7c=;
        b=XzG30BTYwl3l2klnz0oJm5mgBMcFvWO/X4Ec/FnmUtkq+oox8KtRys0vvewtszs1w3
         VzhnJDk2deVxnnwJmBn12p8u1nPyqEYmw2wUV8cZbLvuY2i/dAqza0AqNLSWw9oJKxpb
         Z2CgefQ94qIf1nV1xJngejghrC5swuNuHFpjLVfv6bPy8IxutawzfAX000b8CO3ipXoE
         c7woJV7POt6N62TbQ23Goqk/5Ex8aQAhuIkgJgGUk0MUZ6kqSYZSOCXHyOPRYzp0inh2
         xuj42t0cUynQf6pUfRICaMdztUY/xSesfihBUgybiIp1FXkP3SQOgdCXixXLwz4YtNkK
         WTZw==
X-Forwarded-Encrypted: i=1; AJvYcCW3GVc5nLiiTkFsDmGxIQt+uPHdR7sek4wWCgaZbio1WEizbgGtdmOgzgzaq3nr1OcoTNquK00f2dxCCU23GA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxbVuUCxLsBNeQCA8ZBjbZ5pVWoLdzAAH/oeiiwBjGwdV+khjOJ
	DO5RZ1F4O72xXp+Mk2asI0D0P1chUTjSoVa5ytlaxnczDp3SSIAiejkd
X-Gm-Gg: ASbGncvj2BtuVPPTAOH4jwWRzgJUx6b4AvmnHpBVkZHNtInBnCx8xq6LoK+iKg0VUtG
	wX3lYftlfEaBCmPRYaj80TJYLLl9yMwmV2iZZ3GeqpcfrMBKNJKnhSPwJAa0Q9h28C4sXZ3JEs4
	gIeykI+h2+zAOP/bOFqmYy0Z1h9XVZdfcafixbmHKwKTY2huBoPaFRuDak71Y/zkvuy9ylHQgw+
	ZUlWHzNQAGvUlb1QN+AiueypXQAQ7oeSUQC39vRnBeWzj1xMSE/BQzGrz0yUWcytc1s7ExqNgLU
	FjLQKzGQhLHHEWoTojk7iGtvZS6M7WU/oyNUnZxI+FnkwV57A4okAvRGkCY8cdm75MMatttZmGN
	YcaQCrdmHxhSS3IMK7WpxFfKTJx9ko1OC9pcleG+KLBF1mliqt4DUuTkLYiepSS/mrAwSrtsfiX
	pZKVnGRfGKT5OGJzel9h6vD9mjlR6h/6IcEI3yfxnCkroLVdthslkixSoxca2GYQ==
X-Google-Smtp-Source: AGHT+IHXpWgQsZZVkYiBPmILc7RuvE2kIhv57m1OcBr+zSddLJY/KSgXIs3QQTHErJ1IF0Y6gXvhwg==
X-Received: by 2002:a17:902:f64e:b0:297:dde4:8024 with SMTP id d9443c01a7336-29df55763efmr81526195ad.23.1765208914432;
        Mon, 08 Dec 2025 07:48:34 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:2998:e0cd:90d5:9648? ([2001:ee0:4f4c:210:2998:e0cd:90d5:9648])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29dae49ca50sm128075925ad.20.2025.12.08.07.48.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 07:48:33 -0800 (PST)
Message-ID: <39958cd6-3ab1-433a-8eed-129304bc059e@gmail.com>
Date: Mon, 8 Dec 2025 22:48:26 +0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill
 work
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <20251208153419.18196-1-minhquangbui99@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/8/25 22:34, Bui Quang Minh wrote:
> Calling napi_disable() on an already disabled napi can cause the
> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
> when pausing rx"), to avoid the deadlock, when pausing the RX in
> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
> However, in the virtnet_rx_resume_all(), we enable the delayed refill
> work too early before enabling all the receive queue napis.
>
> The deadlock can be reproduced by running
> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
> device and inserting a cond_resched() inside the for loop in
> virtnet_rx_resume_all() to increase the success rate. Because the worker
> processing the delayed refilled work runs on the same CPU as
> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
> In real scenario, the contention on netdev_lock can cause the
> reschedule.
>
> This fixes the deadlock by ensuring all receive queue's napis are
> enabled before we enable the delayed refill work in
> virtnet_rx_resume_all() and virtnet_open().
>
> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

I forgot to add Cc:stable@vger.kernel.org. I will add in next version.

Thanks,
Quang Minh.

> ---
>   drivers/net/virtio_net.c | 59 +++++++++++++++++++---------------------
>   1 file changed, 28 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e04adb57f52..f2b1ea65767d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_info *vi, struct receive_queue *rq,
>   	return err != -ENOMEM;
>   }
>   
> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
> +{
> +	bool schedule_refill = false;
> +	int i;
> +
> +	enable_delayed_refill(vi);
> +	for (i = 0; i < vi->curr_queue_pairs; i++)
> +		if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> +			schedule_refill = true;
> +
> +	if (schedule_refill)
> +		schedule_delayed_work(&vi->refill, 0);
> +}
> +
>   static void skb_recv_done(struct virtqueue *rvq)
>   {
>   	struct virtnet_info *vi = rvq->vdev->priv;
> @@ -3216,19 +3230,14 @@ static int virtnet_open(struct net_device *dev)
>   	struct virtnet_info *vi = netdev_priv(dev);
>   	int i, err;
>   
> -	enable_delayed_refill(vi);
> -
>   	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (i < vi->curr_queue_pairs)
> -			/* Make sure we have some buffers: if oom use wq. */
> -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->refill, 0);
> -
>   		err = virtnet_enable_queue_pair(vi, i);
>   		if (err < 0)
>   			goto err_enable_qp;
>   	}
>   
> +	virtnet_rx_refill_all(vi);
> +
>   	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
>   		if (vi->status & VIRTIO_NET_S_LINK_UP)
>   			netif_carrier_on(vi->dev);
> @@ -3463,39 +3472,27 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>   	__virtnet_rx_pause(vi, rq);
>   }
>   
> -static void __virtnet_rx_resume(struct virtnet_info *vi,
> -				struct receive_queue *rq,
> -				bool refill)
> -{
> -	bool running = netif_running(vi->dev);
> -	bool schedule_refill = false;
> -
> -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -		schedule_refill = true;
> -	if (running)
> -		virtnet_napi_enable(rq);
> -
> -	if (schedule_refill)
> -		schedule_delayed_work(&vi->refill, 0);
> -}
> -
>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
>   {
>   	int i;
>   
> -	enable_delayed_refill(vi);
> -	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (i < vi->curr_queue_pairs)
> -			__virtnet_rx_resume(vi, &vi->rq[i], true);
> -		else
> -			__virtnet_rx_resume(vi, &vi->rq[i], false);
> +	if (netif_running(vi->dev)) {
> +		for (i = 0; i < vi->max_queue_pairs; i++)
> +			virtnet_napi_enable(&vi->rq[i]);
> +
> +		virtnet_rx_refill_all(vi);
>   	}
>   }
>   
>   static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>   {
> -	enable_delayed_refill(vi);
> -	__virtnet_rx_resume(vi, rq, true);
> +	if (netif_running(vi->dev)) {
> +		virtnet_napi_enable(rq);
> +
> +		enable_delayed_refill(vi);
> +		if (!try_fill_recv(vi, rq, GFP_KERNEL))
> +			schedule_delayed_work(&vi->refill, 0);
> +	}
>   }
>   
>   static int virtnet_rx_resize(struct virtnet_info *vi,

