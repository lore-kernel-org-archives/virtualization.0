Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB17221F12
	for <virtualization@lists.linux.dev>; Fri, 28 Nov 2025 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764296438; cv=none; b=hyPyvrawqxP+se6h/C7IcE98sDgGu1YiTJet520Gu8ewNmoX+EpNXJ4smZ9HC9twLJvZWm1RZvDJR8BpPSIAiaY7b5Hc8KG2uVY9nv4fX7K2gTIv1/U7I6qD5W9mMPkjX6/CgsmgydwhS0sKKS2Vjsnhrq0nb6bRbUlZBz4G+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764296438; c=relaxed/simple;
	bh=juuT2szlDhnZah03azTXrfo8JNzsr8IYomevmrOodCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mE16ENRFayLnL3BvaiJ0Fr/T/WC0s1GFGHOuW76zZdCI0jwLOQlV/+kWVxw5iEovsuBhiAbdtldDoAn52XJEXw+rd80BYpibqgec3QTyyIQFwgFP0PYCr1b1FJmmQRjtYjMeKypKLoQsfjTQuf+DS+fX8p1LJbhBVWJKWi85Jj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FuPEg6pr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FuPEg6pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764296435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gYccDo2j+1D3EXgLNM4B1dXCh8l3NXcIw8nBRY7Khlg=;
	b=FuPEg6prKofXB3JC7TtVrIYMN21a95NZkMktrokAmpUhRHqYnzExZ+P+uP3G5ibH6d1dLQ
	NdgletxFWZzEcX+7D92pm8UXTc9u6tlftK2RDaLS8yDQJrZWD0964/M2zYkqilTB1znqbN
	fWcFM8f8sH/zaWrJF8Kt94D6tgOXpTY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-XvR3YwxsMUGCb-zrec8sUw-1; Thu, 27 Nov 2025 21:20:34 -0500
X-MC-Unique: XvR3YwxsMUGCb-zrec8sUw-1
X-Mimecast-MFC-AGG-ID: XvR3YwxsMUGCb-zrec8sUw_1764296433
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-343bf6ded5cso2011020a91.0
        for <virtualization@lists.linux.dev>; Thu, 27 Nov 2025 18:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764296433; x=1764901233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gYccDo2j+1D3EXgLNM4B1dXCh8l3NXcIw8nBRY7Khlg=;
        b=aLZFowlweY2pXTliM43bdTCRDeamnbiBklVMMyDmkmyEislfKEMi7nM8eCs3htJQIX
         G4erfUyOd/fuaIGpt/mm3Z6BTl3A6tBiHlPItSWYkABu4kyELNt6hQu7XgmWM74NiJKY
         o4upIO3KaRzXnrs+JbNY2J70gadd889YPB9gqhShcv/1SzQmra2hdo2pcrTeX4dvk56f
         PV1IgOLRIvHER9wfADbb41idloaJOuUzigQvkJgWG7J1HArJPPzJbyUIftHZPlkYr3Ew
         enmaymkZ/h4dTOhqddGGn+aOO+TcxBIgqDYsX97m3kPMtxmYQlDu9+i0femh5th8UbAB
         IICw==
X-Forwarded-Encrypted: i=1; AJvYcCWXBh5qA9jrdehkkZatTpOfuweGMNA2b8mER5g96ASbWEhwMdqb1c0N1aRuRmMHCOm1C5ecBkjIlfaErxeUQg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFe8DSm6RajmSSL/RfAYZfGoxuRMBEyPQipqdMaiHE/vDFeoTG
	4volY3iGBOsWePGRO2vwJh/OnoPGf3XTT57+J3bZFWrXdMhXLbEvaGUoayvUH8xDXw9Lc2OcpD7
	ZuQfWZdMbzRlEE40+X7Z4K/oELSVOgj6o3Hv+pR657hKhRDEPRQJS7bkUBlIkU3GrhQJcwDS0Dn
	45WXaT9DoSkq4XXISXGsoFH6wVoxivIv6sfDz+o7w4+Gs=
X-Gm-Gg: ASbGncvrsczOjPT3hsmwXjgL5HJuY91IW0q2CEnR6RoAlO5uDDoEMaWwuwyWaPd4gAd
	Z0xHKLQQieDhWynq0hZKbI19C5i7oVDOuj6j/IkRwcUIzZPQfCUKWqKaKFiVAYMlMBs1pDVr3RJ
	wfjf5UePtTp85aLJb8qgPBnTwiacLrrbJBGtqIATWvVysPDLcKpcosdwXYHF+Dvenk
X-Received: by 2002:a17:90b:544b:b0:338:3d07:5174 with SMTP id 98e67ed59e1d1-34733e4cd33mr24799058a91.5.1764296433350;
        Thu, 27 Nov 2025 18:20:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHv94V6EgbFiEIs81QepFX0mRMFn3g2NyGux1CLfN5JgtlXv14IqI7OOH8tWGprrDA/aklgfN72ym5w+o80QPw=
X-Received: by 2002:a17:90b:544b:b0:338:3d07:5174 with SMTP id
 98e67ed59e1d1-34733e4cd33mr24799030a91.5.1764296432936; Thu, 27 Nov 2025
 18:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <40af2b73239850e7bf1a81abb71ee99f1b563b9c.1764226734.git.mst@redhat.com>
 <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
In-Reply-To: <a61dc7ee-d00b-41b4-b6fd-8a5152c3eae3@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 28 Nov 2025 10:20:21 +0800
X-Gm-Features: AWmQ_bkpiNIqEJYMSebVvAaf2aLCflDbTnLMVmn819Q7sJ2u-A2teXvBbKmJ7ag
Message-ID: <CACGkMEuJFVUDQ7SKt93mCVkbDHxK+A74Bs9URpdGR+0mtjxmAg@mail.gmail.com>
Subject: Re: [PATCH RFC] virtio_net: gate delayed refill scheduling
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xr8i0KBzwf_2E6zyKgyiFCSAYd8seXXj0mEfdbujuVs_1764296433
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 28, 2025 at 1:47=E2=80=AFAM Bui Quang Minh <minhquangbui99@gmai=
l.com> wrote:
>
> I think the the requeue in refill_work is not the problem here. In
> virtnet_rx_pause[_all](), we use cancel_work_sync() which is safe to
> use "even if the work re-queues itself". AFAICS, cancel_work_sync()
> will disable work -> flush work -> enable again. So if the work requeue
> itself in flush work, the requeue will fail because the work is already
> disabled.

Right.

>
> I think what triggers the deadlock here is a bug in
> virtnet_rx_resume_all(). virtnet_rx_resume_all() calls to
> __virtnet_rx_resume() which calls napi_enable() and may schedule
> refill. It schedules the refill work right after napi_enable the first
> receive queue. The correct way must be napi_enable all receive queues
> before scheduling refill work.

So what you meant is that the napi_disable() is called for a queue
whose NAPI has been disabled?

cpu0] enable_delayed_refill()
cpu0] napi_enable(queue0)
cpu0] schedule_delayed_work(&vi->refill)
cpu1] napi_disable(queue0)
cpu1] napi_enable(queue0)
cpu1] napi_disable(queue1)

In this case cpu1 waits forever while holding the netdev lock. This
looks like a bug since the netdev_lock 413f0271f3966 ("net: protect
NAPI enablement with netdev_lock()")?

>
> The fix is like this (there are quite duplicated code, I will clean up
> and send patches later if it is correct)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 8e04adb57f52..892aa0805d1b 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3482,20 +3482,25 @@ static void __virtnet_rx_resume(struct virtnet_in=
fo *vi,
>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
>   {
>       int i;
> +    bool schedule_refill =3D false;
> +
> +    for (i =3D 0; i < vi->max_queue_pairs; i++)
> +        __virtnet_rx_resume(vi, &vi->rq[i], false);
>
>       enable_delayed_refill(vi);
> -    for (i =3D 0; i < vi->max_queue_pairs; i++) {
> -        if (i < vi->curr_queue_pairs)
> -            __virtnet_rx_resume(vi, &vi->rq[i], true);
> -        else
> -            __virtnet_rx_resume(vi, &vi->rq[i], false);
> -    }
> +
> +    for (i =3D 0; i < vi->curr_queue_pairs; i++)
> +        if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> +            schedule_refill =3D true;
> +
> +    if (schedule_refill)
> +        schedule_delayed_work(&vi->refill, 0);
>   }
>
>   static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_q=
ueue *rq)
>   {
> -    enable_delayed_refill(vi);
>       __virtnet_rx_resume(vi, rq, true);
> +    enable_delayed_refill(vi);

This seems to be odd. I think at least we need to move this before:

> +    if (schedule_refill)
> +        schedule_delayed_work(&vi->refill, 0);

?

>   }
>
>   static int virtnet_rx_resize(struct virtnet_info *vi,
>
> I also move the enable_delayed_refill() after we __virtnet_rx_resume()
> to ensure no refill is scheduled before napi_enable().
>
> What do you think?

This has been implemented in your patch or I may miss something.

Thanks

>
> Thanks,
> Quang Minh
>

