Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC79613BC0E
	for <virtualization@lists.linux.dev>; Wed, 12 Mar 2025 01:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741741949; cv=none; b=mxQH5xGhwG4hWrNVkrNieT45Omxes1ctAd68yq0BZHoLQ9E8dBVRQUfb04a4C/ohmhdC1gzd2twIZGYeYjHZ//y1Ll26jKAA/YFmAOujBTdql47xk3zROWSS3uHYHu8GNyYZKN1dxAbyeKCztPmQJnN0ICcMu6ji8CRt5LOXrXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741741949; c=relaxed/simple;
	bh=b8YvkgQKYVv+zLA/vOzQnYgkvVS/E8Xw0N70YVJ357g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNRl2VJfs48aRepkkdYtZz5vYMiV2k9uIXeVGhhjKuyP+kNPIBl/CLuNrU8OEs79IgOYV5IrS2nFfrOWeRVLFiMJH9EsqbIoGwJ9CCj6kAnoOlNhYP+S0EaQOz1xcIeAtnkyRKTa/XMIIib3OooJpZXF537T+PgLFbMFQDwYOiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QuQUhWOw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuQUhWOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741741946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CnGRCv9ZSKqoVhTk7F0JHtO98tD/stwqbpbExfdFqNU=;
	b=QuQUhWOw57zhE1IrGGNC0z0tlCTHp8OnSF1eTEZXgBRAE73Rth2CdkXwjGW52cpFtY4qdH
	erZ+HgM3DFd3AbXFgmKTx78RNEzPYRKBSmLuj6q42iDqHziulSalWehpVPoppmH54ZBG/i
	1cPyad5Uxm6r2DS8gFEXf6YPIrGFOfU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-2IPMI7zZNlGE5x2Ah_2MxQ-1; Tue, 11 Mar 2025 21:12:25 -0400
X-MC-Unique: 2IPMI7zZNlGE5x2Ah_2MxQ-1
X-Mimecast-MFC-AGG-ID: 2IPMI7zZNlGE5x2Ah_2MxQ_1741741944
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3f9cbcfbb7aso358180b6e.1
        for <virtualization@lists.linux.dev>; Tue, 11 Mar 2025 18:12:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741741944; x=1742346744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnGRCv9ZSKqoVhTk7F0JHtO98tD/stwqbpbExfdFqNU=;
        b=uAnAsNorPnvSjFkzbAzwCfCTqpM6Cw6FNpt/4I8W0xjl7bAQR27fB9mQCFv/L2QFdO
         xQN5O6/H8MycvVK416tGBiMsPKvZXIZUAkXmT5Oj9qOLo8apFEMZGV5WcZEtuVh5GBHe
         /txAy0FfBt/wZHm/thccKpHf09g0O/xsGyc2c44TQmq1iez2cA2v3sVGlGozb2IQQc8D
         2zdCawhH/S2XbJhDF/QPSkLs6YN2WtP8kIDDb9mrHxTEK4wNGQwLYRXyQjgWJyBoj0vn
         4ledJtG7cBWHr+FZ/nLm/plAZpDKVrqIjJmRyCB7zlGg4qXwYV2zqZNWQJiF47pIZSvw
         z/1A==
X-Forwarded-Encrypted: i=1; AJvYcCU3ftmIuHLAC+oQEbLHuvIPLwsr62tUfVCaOpYdU6HA2jOkxGBYYk0dfmoNdsg9TdgRNp/eohYol96LctVX5g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzNOW+uxgk2/J05c54E8/DggJ5bDNdTVJVqnUX7BrjIZMGgjXsF
	ge6BIAc2gavtn+SWD/jzVJ9rTreRrorzW7WgGEkB+8EW83I9gNTBjE59+BCXZrrX4HYrz26m6j0
	/ok/Uu31bfLeFym7ybAvMogqEMlffXACsgJx0NJAauDMlNx9MisLmhQJxuMVP0/nYlQOJolNVkc
	AFZGW5OP377RynCLV8Cd9MT9L82eopZD8nSFnn3eJ8f6/mTXgzkQgg
X-Gm-Gg: ASbGnct/jI244CvMqJez3eu0KJurFKK2dtKrZSOK87koBCPv9VQD7quJN0Ph2VQfSOq
	e9XSZxfhUmUYaB3Y7F03sVjxYGNN4v4W88iDJBqL6jzT2IZvJRHWd66pJqDQvSAblY19ISg==
X-Received: by 2002:a05:6808:151f:b0:3f6:a851:fe56 with SMTP id 5614622812f47-3fa2cb75fa5mr3035114b6e.12.1741741943850;
        Tue, 11 Mar 2025 18:12:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3mKhM/9eEonh3FegBD10LQ8+pNQN7eeRuLw2+1ljK27jMzqq4OXLt3z/dyqYGa0+Ls1Odf3vt/DlfXnV4aKk=
X-Received: by 2002:a67:fe83:0:b0:4bd:379c:4037 with SMTP id
 ada2fe7eead31-4c34de502dcmr3195470137.9.1741741933287; Tue, 11 Mar 2025
 18:12:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <67c7761a.050a0220.15b4b9.0018.GAE@google.com> <20250311131735.3205493-1-quic_zhonhan@quicinc.com>
In-Reply-To: <20250311131735.3205493-1-quic_zhonhan@quicinc.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Mar 2025 09:11:59 +0800
X-Gm-Features: AQ5f1JqQ5BnESGxfl6--tmcJtmtJPjIXrmidjQzfdxxMN_7gILNNc9hyAqgz1Ao
Message-ID: <CACGkMEvK6adr6m-LpWxFxAz+pTPYpnA3gO4sLhs0Gc52nrbYLw@mail.gmail.com>
Subject: Re: [PATCH] virtio_ring: Fix data race when accessing the
 event_triggered field of vring_virtqueue
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: K5aA6bd_pDEP4NvCe24mOZsS7HrXxb7dToUtGSLbk28_1741741944
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 9:18=E2=80=AFPM Zhongqiu Han <quic_zhonhan@quicinc.=
com> wrote:
>
> Syzkaller reports a data-race when accessing the event_triggered field of
> vring_virtqueue in virtqueue_disable_cb / virtqueue_enable_cb_delayed.
> Here is the simplified stack when the issue occurred:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KCSAN: data-race in virtqueue_disable_cb / virtqueue_enable_cb_delay=
ed
>
> write to 0xffff8881025bc452 of 1 bytes by task 3288 on cpu 0:
>  virtqueue_enable_cb_delayed+0x42/0x3c0 drivers/virtio/virtio_ring.c:2653
>  start_xmit+0x230/0x1310 drivers/net/virtio_net.c:3264
>  __netdev_start_xmit include/linux/netdevice.h:5151 [inline]
>  netdev_start_xmit include/linux/netdevice.h:5160 [inline]
>  xmit_one net/core/dev.c:3800 [inline]
>  dev_hard_start_xmit+0x119/0x3f0 net/core/dev.c:3816
>  sch_direct_xmit+0x1a9/0x580 net/sched/sch_generic.c:343
>  __dev_xmit_skb net/core/dev.c:4039 [inline]
>  __dev_queue_xmit+0xf6a/0x2090 net/core/dev.c:4615
>
> read to 0xffff8881025bc452 of 1 bytes by interrupt on cpu 1:
>  virtqueue_disable_cb_split drivers/virtio/virtio_ring.c:880 [inline]
>  virtqueue_disable_cb+0x92/0x180 drivers/virtio/virtio_ring.c:2566
>  skb_xmit_done+0x5f/0x140 drivers/net/virtio_net.c:777
>  vring_interrupt+0x161/0x190 drivers/virtio/virtio_ring.c:2715
>  __handle_irq_event_percpu+0x95/0x490 kernel/irq/handle.c:158
>  handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
>  handle_irq_event+0x64/0xf0 kernel/irq/handle.c:210
>  handle_edge_irq+0x16d/0x5b0 kernel/irq/chip.c:831
>  generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
>  handle_irq arch/x86/kernel/irq.c:249 [inline]
>
> value changed: 0x01 -> 0x00
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> After an interrupt is triggered, event_triggered can be set to true in th=
e
> func vring_interrupt(). Then virtqueue_disable_cb_split() will read it as
> true and stop further work of disabling cbs. During this time, if another
> virtqueue processing sets same event_triggered to false in func
> virtqueue_enable_cb_delayed(), a race condition will occur, potentially
> leading to further vq data inconsistency because both
> virtqueue_disable_cb_split() and virtqueue_enable_cb_delayed() can
> continue read/write multiple field members of vring_virtqueue.
>
> Fix this by using smp_load_acquire() and smp_store_release().
>
> Additionally, virtqueue_disable_cb_packed() may be called in the same
> stack as virtqueue_disable_cb_split() while vq->packed_ring is true in
> func virtqueue_disable_cb(), so event_triggered should also be protected
> in it.
>
> Reported-by: syzbot+efe683d57990864b8c8e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67c7761a.050a0220.15b4b9.0018.GAE@goo=
gle.com/
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>

Do we have performance numbers for this change?

Btw event_triggered is just a hint, using barriers seems to be an overkill.

What's more the current implementation is buggy:

1) event_triggered should be only called when event idx is used
2) the assumption of device won't raise the interrupt is not ture,
this is especially obvious in the case of packed ring, when the
wrap_counter warps twice, we could still get an interrupt from the
device. This means when the virtqueue size is 256 we will get 1
unnecessary notification every 512 packets etc.

So I wonder just a data_race() hint would be more than sufficient.

Thanks

> ---
>  drivers/virtio/virtio_ring.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index fdd2d2b07b5a..b8ff82730618 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -875,9 +875,10 @@ static void virtqueue_disable_cb_split(struct virtqu=
eue *_vq)
>
>                 /*
>                  * If device triggered an event already it won't trigger =
one again:
> -                * no need to disable.
> +                * no need to disable. smp_load_acquire pairs with smp_st=
ore_release()
> +                * in virtqueue_enable_cb_delayed()
>                  */
> -               if (vq->event_triggered)
> +               if (smp_load_acquire(&vq->event_triggered))
>                         return;
>
>                 if (vq->event)
> @@ -1802,9 +1803,10 @@ static void virtqueue_disable_cb_packed(struct vir=
tqueue *_vq)
>
>                 /*
>                  * If device triggered an event already it won't trigger =
one again:
> -                * no need to disable.
> +                * no need to disable. smp_load_acquire pairs with smp_st=
ore_release()
> +                * in virtqueue_enable_cb_delayed()
>                  */
> -               if (vq->event_triggered)
> +               if (smp_load_acquire(&vq->event_triggered))
>                         return;
>
>                 vq->packed.vring.driver->flags =3D
> @@ -2650,7 +2652,8 @@ bool virtqueue_enable_cb_delayed(struct virtqueue *=
_vq)
>         struct vring_virtqueue *vq =3D to_vvq(_vq);
>
>         if (vq->event_triggered)
> -               vq->event_triggered =3D false;
> +               /* Pairs with smp_load_acquire in virtqueue_disable_cb_sp=
lit/packed() */
> +               smp_store_release(&vq->event_triggered, false);
>
>         return vq->packed_ring ? virtqueue_enable_cb_delayed_packed(_vq) =
:
>                                  virtqueue_enable_cb_delayed_split(_vq);
> --
> 2.25.1
>

