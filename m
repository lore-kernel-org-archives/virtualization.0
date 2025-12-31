Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BAD253359
	for <virtualization@lists.linux.dev>; Wed, 31 Dec 2025 07:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767166225; cv=none; b=Eu5zHywG6Q445jhgGNA+egwocWqm+NIUa2yqFor/C2qwcaSdJO0fDKBuxi/AHZJRDlylzgy35dg6fMpSIHPPPUxFpIh+JXl+SwavGGmXCgX90uBL/ORMxR+DcJgH/U1kEXEerZIYJOlh0bSBOiJyHvtB/ZAXvxyfTyz3YaUYydU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767166225; c=relaxed/simple;
	bh=qW79kgXnhk4c+mAfiPXpb+zTW1t7cFuRjVk2APvshTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DICXpZeGpy/CjifFDRUilTzPgQI5kXCwwTOgpdPQOglJdZwVMFITT/p7ypNHVQPCTgvp85HM33WfuiQFYufV5zdrTuilPuNvTicL3l8EI0Q7iiOTK8MxsKoWYWjFRo3zdAiD3IriRQiLKYVqNaFuSNX7PE3QMWw0PPS39yU2+Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JP9wcxyO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JP9wcxyO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767166222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GPhnCFWyEhtT0+eaCZ18ZHnLuuXgUK8BIqFWn/71XHI=;
	b=JP9wcxyO3DDPgBOzRTuh9DhdptrylfdjyYA64FP6jfmH8ItOCQHT//TeBVJ27NFFZ3KR1o
	a9IkqwkIi3lXOnZBhiLO5t1dXh09g/CK3cmY/F8zW4PgPTEe/pRFsoULSCUH6r5s9QheOV
	a+kfcCLc6XITI/nea90GcZ0pgKZsz6k=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-OPln9IIPMLWC594EjbJZMQ-1; Wed, 31 Dec 2025 02:30:19 -0500
X-MC-Unique: OPln9IIPMLWC594EjbJZMQ-1
X-Mimecast-MFC-AGG-ID: OPln9IIPMLWC594EjbJZMQ_1767166218
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-29f1450189eso95408065ad.1
        for <virtualization@lists.linux.dev>; Tue, 30 Dec 2025 23:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767166218; x=1767771018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GPhnCFWyEhtT0+eaCZ18ZHnLuuXgUK8BIqFWn/71XHI=;
        b=u1f8c956kMYQYzuUWLP5zjdkOS8k96Z8vglOzNev8lWe3+oGnKeyLMqauF8zleGKs1
         Ywc/8W6fmMO/nuXLGDoZvxXnxaIEVjGZ/o2wuAiia28ALh2n4K9zkzumoi2ss3MZjhMY
         Ls+biM4vPWsyuEpN6TdgyfMxgIKy635U17V8Jm/lF0x+DE32sw9Pgfl5+2aMjJgeuYQP
         2KIHT3hw8PGrZ4SvIVVVI7HlGCGhWbE4Js0WqMe6U1ErZFvIHsodPe4QWCrkNJyjI1sy
         ZDec3Rv3cgpSjLo10UgIyNluqpZhfoU3iNLTBQ1Sjvftg9j80KUzu+57pPEh0bPz6/AB
         Mg4g==
X-Forwarded-Encrypted: i=1; AJvYcCVfhp9PXARNmPGP1KLGuXrPIjcs1HKM0E+6jqbPtSrUFw/Z1J3gm9N3FmNn5BZI1dKM5OwxZYDia/FkyPCc9g==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyCleNglLuE5FL8P5CNLGnKbklL0h8sbd5e9gufOuML5MFr5ts
	C7pCVGaj6ahsk6WMjr+qTkeWNH2qSnlKbLKesrATwEafXs4PKNmBHjthjjt2cBWWbbapJtVjpzb
	oUGJLZeHUZqIS5lsmWiSPtfiTSBLGi9d9lW76zYX3dkhrO3GE17vgaD8Q0yakqZ4q5Fu4FLW594
	lPWWrU7p7Cxnh2pNiagdQ9AN+1lCnU4isriDfdq4JlFQs=
X-Gm-Gg: AY/fxX7+t/Q070xYrYqpKblGQBNR5gep/or4JndkB0wCr5Fwkj3+ofHCm/8f74wNt1v
	OPw70z044Qa6z95upfofm+ZN1XQZ5P7FzBx0Tupe8Yjqsso1boYXqirm4UK6U9F+LjlMNRFs0SC
	mdmVWc4REA2nxH0gLzl2Zevj+bnixhmU5dWQXJMq92rJcHBb+JM8d76wlQS7YkGfkI0+0=
X-Received: by 2002:a17:903:1ae3:b0:2a0:c0cc:30b with SMTP id d9443c01a7336-2a2caa9b3d6mr437444395ad.3.1767166218213;
        Tue, 30 Dec 2025 23:30:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZeZmm01OPAuC7L3q+SVriXrZwU4mbP2V2pzZu5BBW8+ISShq+aJk2RNS0IGVs/HU1Y/6tRmzmE681fCrJVcY=
X-Received: by 2002:a17:903:1ae3:b0:2a0:c0cc:30b with SMTP id
 d9443c01a7336-2a2caa9b3d6mr437444175ad.3.1767166217706; Tue, 30 Dec 2025
 23:30:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com> <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com> <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
 <20251225112729-mutt-send-email-mst@kernel.org> <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
 <20251226022727-mutt-send-email-mst@kernel.org> <7143657a-a52f-4cff-acbc-e89f4c713cc4@gmail.com>
In-Reply-To: <7143657a-a52f-4cff-acbc-e89f4c713cc4@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Dec 2025 15:30:06 +0800
X-Gm-Features: AQt7F2rQX-PivS77SwzPvLVG0RtPt7RZFLVBzTZg9DAVBYBssUXbKl6MRGZkge0
Message-ID: <CACGkMEuasGDh=wT0n5b5QFDSNNBK7muipBKHb2v5eoKCU0NWDw@mail.gmail.com>
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue work
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oF_3kVTqZI0O15VTQA6Lfir6aMRQMySJmdH5sl0aqEs_1767166218
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 12:29=E2=80=AFAM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> On 12/26/25 14:37, Michael S. Tsirkin wrote:
> > On Fri, Dec 26, 2025 at 09:31:26AM +0800, Jason Wang wrote:
> >> On Fri, Dec 26, 2025 at 12:27=E2=80=AFAM Michael S. Tsirkin <mst@redha=
t.com> wrote:
> >>> On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> >>>> On Wed, Dec 24, 2025 at 9:48=E2=80=AFAM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> >>>>> On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> >>>>>> Hi Jason,
> >>>>>>
> >>>>>> I'm wondering why we even need this refill work. Why not simply le=
t NAPI retry
> >>>>>> the refill on its next run if the refill fails? That would seem mu=
ch simpler.
> >>>>>> This refill work complicates maintenance and often introduces a lo=
t of
> >>>>>> concurrency issues and races.
> >>>>>>
> >>>>>> Thanks.
> >>>>> refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> >>>>>
> >>>>> And if GFP_ATOMIC failed, aggressively retrying might not be a grea=
t idea.
> >>>> Btw, I see some drivers are doing things as Xuan said. E.g
> >>>> mlx5e_napi_poll() did:
> >>>>
> >>>> busy |=3D INDIRECT_CALL_2(rq->post_wqes,
> >>>>                                  mlx5e_post_rx_mpwqes,
> >>>>                                  mlx5e_post_rx_wqes,
> >>>>
> >>>> ...
> >>>>
> >>>> if (busy) {
> >>>>           if (likely(mlx5e_channel_no_affinity_change(c))) {
> >>>>                  work_done =3D budget;
> >>>>                  goto out;
> >>>> ...
> >>>
> >>> is busy a GFP_ATOMIC allocation failure?
> >> Yes, and I think the logic here is to fallback to ksoftirqd if the
> >> allocation fails too much.
> >>
> >> Thanks
> >
> > True. I just don't know if this works better or worse than the
> > current design, but it is certainly simpler and we never actually
> > worried about the performance of the current one.
> >
> >
> > So you know, let's roll with this approach.
> >
> > I do however ask that some testing is done on the patch forcing these O=
OM
> > situations just to see if we are missing something obvious.
> >
> >
> > the beauty is the patch can be very small:
> > 1. patch 1 do not schedule refill ever, just retrigger napi
> > 2. remove all the now dead code
> >
> > this way patch 1 will be small and backportable to stable.
>
> I've tried 1. with this patch
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..9e890aff2d95 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_i=
nfo *vi,
>   }
>
>   static int virtnet_receive(struct receive_queue *rq, int budget,
> -               unsigned int *xdp_xmit)
> +               unsigned int *xdp_xmit, bool *retry_refill)
>   {
>       struct virtnet_info *vi =3D rq->vq->vdev->priv;
>       struct virtnet_rq_stats stats =3D {};
> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *r=
q, int budget,
>           packets =3D virtnet_receive_packets(vi, rq, budget, xdp_xmit, &=
stats);
>
>       if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vrin=
g_size(rq->vq)) / 2) {
> -        if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> -            spin_lock(&vi->refill_lock);
> -            if (vi->refill_enabled)
> -                schedule_delayed_work(&vi->refill, 0);
> -            spin_unlock(&vi->refill_lock);
> -        }
> +        if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> +            *retry_refill =3D true;
>       }
>
>       u64_stats_set(&stats.packets, packets);
> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi,=
 int budget)
>       struct send_queue *sq;
>       unsigned int received;
>       unsigned int xdp_xmit =3D 0;
> -    bool napi_complete;
> +    bool napi_complete, retry_refill =3D false;
>
>       virtnet_poll_cleantx(rq, budget);
>
> -    received =3D virtnet_receive(rq, budget, &xdp_xmit);
> +    received =3D virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
>       rq->packets_in_napi +=3D received;
>
>       if (xdp_xmit & VIRTIO_XDP_REDIR)
>           xdp_do_flush();
>
>       /* Out of packets? */
> -    if (received < budget) {
> +    if (received < budget && !retry_refill) {

But you didn't return the budget when we need to retry here?

>           napi_complete =3D virtqueue_napi_complete(napi, rq->vq, receive=
d);
>           /* Intentionally not taking dim_lock here. This may result in a
>            * spurious net_dim call. But if that happens virtnet_rx_dim_wo=
rk
> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
>
>       for (i =3D 0; i < vi->max_queue_pairs; i++) {
>           if (i < vi->curr_queue_pairs)
> -            /* Make sure we have some buffers: if oom use wq. */
> -            if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -                schedule_delayed_work(&vi->refill, 0);
> +            /* If this fails, we will retry later in
> +             * NAPI poll, which is scheduled in the below
> +             * virtnet_enable_queue_pair
> +             */
> +            try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>
>           err =3D virtnet_enable_queue_pair(vi, i);
>           if (err < 0)
> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_in=
fo *vi,
>                   bool refill)
>   {
>       bool running =3D netif_running(vi->dev);
> -    bool schedule_refill =3D false;
>
> -    if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -        schedule_refill =3D true;
> +    if (refill)
> +        /* If this fails, we will retry later in NAPI poll, which is
> +         * scheduled in the below virtnet_napi_enable
> +         */
> +        try_fill_recv(vi, rq, GFP_KERNEL);
> +
>       if (running)
>           virtnet_napi_enable(rq);
> -
> -    if (schedule_refill)
> -        schedule_delayed_work(&vi->refill, 0);
>   }
>
>   static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *=
vi, u16 queue_pairs)
>       struct virtio_net_rss_config_trailer old_rss_trailer;
>       struct net_device *dev =3D vi->dev;
>       struct scatterlist sg;
> +    int i;
>
>       if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>           return 0;
> @@ -3829,11 +3828,8 @@ static int virtnet_set_queues(struct virtnet_info =
*vi, u16 queue_pairs)
>       }
>   succ:
>       vi->curr_queue_pairs =3D queue_pairs;
> -    /* virtnet_open() will refill when device is going to up. */
> -    spin_lock_bh(&vi->refill_lock);
> -    if (dev->flags & IFF_UP && vi->refill_enabled)
> -        schedule_delayed_work(&vi->refill, 0);
> -    spin_unlock_bh(&vi->refill_lock);
> +    for (i =3D 0; i < vi->curr_queue_pairs; i++)
> +        try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>
>       return 0;
>   }
>
>
> But I got an issue with selftests/drivers/net/hw/xsk_reconfig.py. This
> test sets up XDP zerocopy (Xsk) but does not provide any descriptors to
> the fill ring. So xsk_pool does not have any descriptors and
> try_fill_recv will always fail. The RX NAPI keeps polling. Later, when
> we want to disable the xsk_pool, in virtnet_xsk_pool_disable path,
>
> virtnet_xsk_pool_disable
> -> virtnet_rq_bind_xsk_pool
>    -> virtnet_rx_pause
>      -> __virtnet_rx_pause
>        -> virtnet_napi_disable
>          -> napi_disable
>
> We get stuck in napi_disable because the RX NAPI is still polling.

napi_disable will set NAPI_DISABLE bit, no?

>
> In drivers/net/ethernet/mellanox/mlx5, AFAICS, it uses state bit for
> synchronization between xsk setup (mlx5e_xsk_setup_pool) with RX NAPI
> (mlx5e_napi_poll) without using napi_disable/enable. However, in
> drivers/net/ethernet/intel/ice,
>
> ice_xsk_pool_setup
> -> ice_qp_dis
>    -> ice_qvec_toggle_napi
>      -> napi_disable
>
> it still uses napi_disable. Did I miss something in the above patch?
> I'll try to look into using another synchronization instead of
> napi_disable/enable in xsk_pool setup path too.
>
> Thanks,
> Quang Minh.
>

Thanks

