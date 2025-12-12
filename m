Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0534613DDAA
	for <virtualization@lists.linux.dev>; Fri, 12 Dec 2025 06:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765522143; cv=none; b=nDWmCghWKSdsn+Khhkkoj7AD8WiKC4X0rSPvLO0WlaaxwsmIIPn8ip0p+/i+dzoGEcEFny8eIPUBDYLlCuaB+7W4QSqvnRlHTAws8ooyKwxhbz58JcLO0XPeKvDp7Fji7bp7HDBA8WjPEiMkZaWWtDpI9hSIjrkdBG/W4uIajY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765522143; c=relaxed/simple;
	bh=yMMJzrx/CLeDl8CnB68WU8xwAqbKwNNDoi3GRfb5jRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PF1ddHt+Hfw9Z6E5mExAcme20bqoaGnLmFVQjT2alVrvk7xmHTbcYlGrbgrDvB9eXh6q2cvu6RleHw5MyQF+oHeNG9LdtbL2m3F8R8Szu4XTLv/iIijE+A2OOX+oPfxMe6RJMOxCZCvso8SmzPJ5pp6O4ySY12tPeVjAhGcezDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hj0CtG2n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hj0CtG2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765522141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0sUk3BDjilnvGHq4HGNbSRfLzgBvHyDLLs4qoxsjBjI=;
	b=hj0CtG2nNV3HTNM5CjbsUE26NyqTyYs9iG7Nn4JvbFoLm3hm1hyCraYOYcM8sv6uBLc/WM
	tY4sUt/KRYzqTuKtowUGC6OY3sPhJhaAdc6UBFPv2p7qWoXtTOwr3CeOyRROQrkR+AjWyD
	RaoTyaXB2v3ZYWimusS9JiKYqXykiLs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-pV3ogLWtPwegBkgV-LmHKg-1; Fri, 12 Dec 2025 01:48:57 -0500
X-MC-Unique: pV3ogLWtPwegBkgV-LmHKg-1
X-Mimecast-MFC-AGG-ID: pV3ogLWtPwegBkgV-LmHKg_1765522137
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-343823be748so928241a91.0
        for <virtualization@lists.linux.dev>; Thu, 11 Dec 2025 22:48:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765522136; x=1766126936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0sUk3BDjilnvGHq4HGNbSRfLzgBvHyDLLs4qoxsjBjI=;
        b=oNNEVTdPu4jPW1iTqmff5r5QWuQLq7oa+mNq73eWgD68Kk8tuXccwaVApE/9+3hwXl
         GXJuDwJ9BtXnBkH9hTUSUL+ibKXiDdD0qcYm6hHcVnu3KwcSpTNvhBjSD6ExEC+SHncg
         H5VzFXzEMTp0CFXz4db5hFkPCwIWP++eZSUY9OrqFKaM1RbY1dzrl4WpXQSPs/jTpLnE
         L5Ud2QgL2AmT1thk4f8fC+APFmRK+xDHcKH7ySLYvevzVNJ43DIw2tyJmGlfnVObTfPX
         SNIoHbJJobPfcrtkIZ3d9pN+nl7/7JVNXI0BySwBkFfoj/OD/1AAoLiqUFETW5DedVLM
         bSuw==
X-Forwarded-Encrypted: i=1; AJvYcCWLQDthpjfMDK2t13M5U28FoyXdFzdi8/nncGVtAPgotqxuAADgweV2qyeTfzLrJPnu1fJ4zBzgNBIx4oz5ow==@lists.linux.dev
X-Gm-Message-State: AOJu0YxAimBwOU0TI8fmsUb1hJ9mTfp71Ko4iU2hYV7aP9ula2i96Nfo
	WhCAOeNbk7RQTQxx9zD5l2Mlqsw+ZTX4EGtSSZo83eQ0W6yvnM+I0Kh0biNhr4Mhj9HMGq6Q49B
	uwlysr9jN34Ma2VDSJh+9K7UYwDgPOQX0dseVLnW5aeMPbHuNBZlAmeqqm+PUjTIn8j08WVVTzm
	awtKOAnChEkbunJql0ZvcLZ0ympxcfhPYl4nr/jkKBG84=
X-Gm-Gg: AY/fxX6JTCr/Bi8dTWuCeUx2qPGf47goNskba1Hj8EOrR+KWdBzGyG8TuVNP5OPce5L
	9AdKLhnu1izOBu7NH5R/L8zkUklth6Inoj7yWVc6EaNMbKoKLzjrOQz7kQaahCEB1lhU9DOuBoY
	QtP/YYOhw79yNz1+SqNFklWgcWh2gzHu2y4Z9lNHfP/Nn/DsKYfk3WUea+AYkQ+TWSYFcS
X-Received: by 2002:a17:90b:2fc7:b0:34a:b8fc:f1d1 with SMTP id 98e67ed59e1d1-34abd7615d9mr1147411a91.24.1765522136378;
        Thu, 11 Dec 2025 22:48:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjwBUsLPmppv2lCFh0MESIdRRbAVpkrizJWE6D5VbwH4ifoB+I83RqpCwIDr/JtzIx2D1rRAnnvzCL2YESxBk=
X-Received: by 2002:a17:90b:2fc7:b0:34a:b8fc:f1d1 with SMTP id
 98e67ed59e1d1-34abd7615d9mr1147382a91.24.1765522135861; Thu, 11 Dec 2025
 22:48:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251208153419.18196-1-minhquangbui99@gmail.com>
 <CACGkMEvtKVeoTMrGG0gZOrNKY=m-DGChVcM0TYcqx6-Ap+FY8w@mail.gmail.com>
 <66d9f44c-295e-4b62-86ae-a0aff5f062bb@gmail.com> <CACGkMEuF0rNYcSSUCdAgsW2Xfen9NGZHNxXpkO2Mt0a4zQJDqQ@mail.gmail.com>
 <c83c386e-96a6-4f9f-8047-23ce866ed320@gmail.com> <CACGkMEv7XpKsfN3soR9GijY-DLqwuOdYp+48ye5jweNpho8vow@mail.gmail.com>
 <6281cd92-10aa-4182-a456-81538cff822a@gmail.com>
In-Reply-To: <6281cd92-10aa-4182-a456-81538cff822a@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 12 Dec 2025 14:48:44 +0800
X-Gm-Features: AQt7F2pyGCXCSW9_t28SDJCHinthQ4jR902GaH6zJFj_MCKjJBJ5Wq9Ts5kAumo
Message-ID: <CACGkMEvt2Fc274kysuPx4865RzBgu=TMNr1TwMQjRNeDp7D8VA@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: enable all napis before scheduling refill work
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: q455BZLSxfcFukBRTXGxG3Gm0wFjaKvK8rVrG6hujCA_1765522137
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 11:04=E2=80=AFPM Bui Quang Minh
<minhquangbui99@gmail.com> wrote:
>
> On 12/11/25 14:27, Jason Wang wrote:
> > On Wed, Dec 10, 2025 at 11:33=E2=80=AFPM Bui Quang Minh
> > <minhquangbui99@gmail.com> wrote:
> >> On 12/10/25 12:45, Jason Wang wrote:
> >>> On Tue, Dec 9, 2025 at 11:23=E2=80=AFPM Bui Quang Minh <minhquangbui9=
9@gmail.com> wrote:
> >>>> On 12/9/25 11:30, Jason Wang wrote:
> >>>>> On Mon, Dec 8, 2025 at 11:35=E2=80=AFPM Bui Quang Minh <minhquangbu=
i99@gmail.com> wrote:
> >>>>>> Calling napi_disable() on an already disabled napi can cause the
> >>>>>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed ref=
ill
> >>>>>> when pausing rx"), to avoid the deadlock, when pausing the RX in
> >>>>>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill=
 work.
> >>>>>> However, in the virtnet_rx_resume_all(), we enable the delayed ref=
ill
> >>>>>> work too early before enabling all the receive queue napis.
> >>>>>>
> >>>>>> The deadlock can be reproduced by running
> >>>>>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-ne=
t
> >>>>>> device and inserting a cond_resched() inside the for loop in
> >>>>>> virtnet_rx_resume_all() to increase the success rate. Because the =
worker
> >>>>>> processing the delayed refilled work runs on the same CPU as
> >>>>>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadl=
ock.
> >>>>>> In real scenario, the contention on netdev_lock can cause the
> >>>>>> reschedule.
> >>>>>>
> >>>>>> This fixes the deadlock by ensuring all receive queue's napis are
> >>>>>> enabled before we enable the delayed refill work in
> >>>>>> virtnet_rx_resume_all() and virtnet_open().
> >>>>>>
> >>>>>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when paus=
ing rx")
> >>>>>> Reported-by: Paolo Abeni <pabeni@redhat.com>
> >>>>>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/=
results/400961/3-xdp-py/stderr
> >>>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> >>>>>> ---
> >>>>>>     drivers/net/virtio_net.c | 59 +++++++++++++++++++-------------=
--------
> >>>>>>     1 file changed, 28 insertions(+), 31 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>>>>> index 8e04adb57f52..f2b1ea65767d 100644
> >>>>>> --- a/drivers/net/virtio_net.c
> >>>>>> +++ b/drivers/net/virtio_net.c
> >>>>>> @@ -2858,6 +2858,20 @@ static bool try_fill_recv(struct virtnet_in=
fo *vi, struct receive_queue *rq,
> >>>>>>            return err !=3D -ENOMEM;
> >>>>>>     }
> >>>>>>
> >>>>>> +static void virtnet_rx_refill_all(struct virtnet_info *vi)
> >>>>>> +{
> >>>>>> +       bool schedule_refill =3D false;
> >>>>>> +       int i;
> >>>>>> +
> >>>>>> +       enable_delayed_refill(vi);
> >>>>> This seems to be still racy?
> >>>>>
> >>>>> For example, in virtnet_open() we had:
> >>>>>
> >>>>> static int virtnet_open(struct net_device *dev)
> >>>>> {
> >>>>>            struct virtnet_info *vi =3D netdev_priv(dev);
> >>>>>            int i, err;
> >>>>>
> >>>>>            for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >>>>>                    err =3D virtnet_enable_queue_pair(vi, i);
> >>>>>                    if (err < 0)
> >>>>>                            goto err_enable_qp;
> >>>>>            }
> >>>>>
> >>>>>            virtnet_rx_refill_all(vi);
> >>>>>
> >>>>> So NAPI and refill work is enabled in this case, so the refill work
> >>>>> could be scheduled and run at the same time?
> >>>> Yes, that's what we expect. We must ensure that refill work is sched=
uled
> >>>> only when all NAPIs are enabled. The deadlock happens when refill wo=
rk
> >>>> is scheduled but there are still disabled RX NAPIs.
> >>> Just to make sure we are on the same page, I meant, after refill work
> >>> is enabled, rq0 is NAPI is enabled, in this case the refill work coul=
d
> >>> be triggered by the rq0's NAPI so we may end up in the refill work
> >>> that it tries to disable rq1's NAPI while holding the netdev lock.
> >> I don't quite get your point. The current deadlock scenario is this
> >>
> >> virtnet_rx_resume_all
> >> napi_enable(rq0) (the rq1 napi is still disabled)
> >> enable_refill_work
> >>
> >> refill_work
> >> napi_disable(rq0) -> still okay
> >> napi_enable(rq0) -> still okay
> >> napi_disable(rq1)
> >> -> hold netdev_lock
> >>       -> stuck inside the while loop in napi_disable_locked
> >>               while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
> >>                   usleep_range(20, 200);
> >>                   val =3D READ_ONCE(n->state);
> >>               }
> >>
> >>
> >> napi_enable(rq1)
> >> -> stuck while trying to acquire the netdev_lock
> >>
> >> The problem is that we must not call napi_disable() on an already
> >> disabled NAPI (rq1's NAPI in the example).
> >>
> >> In the new virtnet_open
> >>
> >> static int virtnet_open(struct net_device *dev)
> >> {
> >>            struct virtnet_info *vi =3D netdev_priv(dev);
> >>            int i, err;
> >>
> >>            // Note that at this point, refill work is still disabled, =
vi->refill_enabled =3D=3D false,
> >>            // so even if virtnet_receive is called, the refill_work wi=
ll not be scheduled.
> >>            for (i =3D 0; i < vi->max_queue_pairs; i++) {
> >>                    err =3D virtnet_enable_queue_pair(vi, i);
> >>                    if (err < 0)
> >>                            goto err_enable_qp;
> >>            }
> >>
> >>            // Here all RX NAPIs are enabled so it's safe to enable ref=
ill work again
> >>            virtnet_rx_refill_all(vi);
> >>
> > I meant this part:
> >
> > +static void virtnet_rx_refill_all(struct virtnet_info *vi)
> > +{
> > +       bool schedule_refill =3D false;
> > +       int i;
> > +
> > +       enable_delayed_refill(vi);
> >
> > refill_work could run here.
>
> I don't see how this can trigger the current deadlock race. However, I
> see that this code is racy, the try_fill_recv function is not safe to
> concurrently executed on the same receive queue. So there is a
> requirement that we need to call try_fill_recv before enabling napi. Is
> it what you mean?

Exactly, I meant it's racy.

>
> >
> > +       for (i =3D 0; i < vi->curr_queue_pairs; i++)
> > +               if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > +                       schedule_refill =3D true;
> > +
> >
> > I think it can be fixed by moving enable_delayed_refill() here.
> >
> > +       if (schedule_refill)
> > +               schedule_delayed_work(&vi->refill, 0);
> > +}
>
> Thanks,
> Quang Minh.
>

Thanks

>

