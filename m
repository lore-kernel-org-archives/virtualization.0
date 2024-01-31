Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68852EAE4
	for <virtualization@lists.linux.dev>; Wed, 31 Jan 2024 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669714; cv=none; b=mwBTIVpKXJVKhZhFg49qVuIisGbJ7+5xAfPl0wV04jZLb9PZR5ApFBeaVhxu23q/hfeMsodjl2d2wwlEqdJM1ZBx1XegSBr9vgZX/xzEro93GfePcmw8iEy7QYVIYvTOUdKkiX3ZkY3d4d8EqTCc9neUU0CPRewW9mH3414RCJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669714; c=relaxed/simple;
	bh=ueg8SiSuCSYuyZCF3/aMcuEA+9KU38+Wlms7bN9L7mM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FCj6hCWQCFxvgBRXjWfPUQklWhxfALehujBpDJaawUjQfue2F3jbOeEeishEB6sQYk39dgPsYok7+pxmQ3jEIUB+6TZT4JrKQniq65fqEfZVXlQbB61KnH+bbtjD3TifXOBQ8p52oIXdNIKIBga8iQ1AaV2j5TV7zlsIARjqJ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fU/QHnDK; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fU/QHnDK"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so800899a12.1
        for <virtualization@lists.linux.dev>; Tue, 30 Jan 2024 18:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706669710; x=1707274510; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Y3IF71xPXZ7JrUTSUQ4Rez9vXqDvDdJ9xakf08XkoU=;
        b=fU/QHnDKnqMdxEBMdwhyOF7IHNeN/IXQgY/OvqjXqAIjv/jYk7bTBuoQxcN3ivo8a7
         QERp0zKEDaxxaWU6/bfp5eiGDmVZffOJnlfRvL8WeqYHVe3Zh9vzlV1ktMzVo37OhFug
         3wvWWnoJX1VO/RPrkEzPvM46E74m+LIAilF+n/Erse2eD3bpgJhpBJaDADtAptVPJztS
         UGbXuErR9Qdf3Ny6/5MzczMPb4TAaNuE3pniUI6e0Ftc7TNxr7bdbuq2b9r53GiYou+R
         +1yKtqPm4j4TvM+xk4TEYTXpy2+X58/k95C4BBjh7qiC/Jbl+4Q+1FNRQFx1q2ToH4S7
         w0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706669710; x=1707274510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Y3IF71xPXZ7JrUTSUQ4Rez9vXqDvDdJ9xakf08XkoU=;
        b=YPZ+3r2U2LGq1xPdC1UldqSSSy9pVtmeu+jT50o0BtiBCLzIPf7C1t6wEgeGLzXSM6
         rB4n4WuXdV5jpUziV7iGhUFThP7CsTH1hrGOrv4C2GU4hXQhYgQ8IVEjSzZHxdWTFnUw
         nUEoD6e5FGipz7SPWUnnuJNDo3g+IEKVCsSmFKmK/yoYhF8xWXci55/GMXqfXDXgLUrU
         qYTRyZW2RD4/DQIqGhbkm9VsZaC5dDvxOoxHuPXi1I3BrBMWfMJ6bxOw+WVyAcw4jXpr
         PxvK/qyTp1j9yBArvxpLBDo8z+s4kWqflrWf9Q/vAWGkcRzRIgt5o/bfNG5JeABpEuwV
         iW5g==
X-Gm-Message-State: AOJu0YzSP/ZyZL1WQj7WTJ6LTPVcVjCad1XowEdb+bpVJ7PlaZKwhbVB
	oJpkSqEjxGg1+hpT1ZzFLJtfeWCfy/LenwwEqROr60slNl4GWxBlvsveVNKmA0Yev6+da06tYYO
	Wz/wLboBd0xo1tGDOJYs+3xuGz9g=
X-Google-Smtp-Source: AGHT+IHdQzVXfxLzP4pOc1UmpBgOQJiiqgfXEVTUHxTcc1O1SR/c1GeAdEjE1xFa6Vc1x1GXWnHrReSzZB4c4xD3LRA=
X-Received: by 2002:aa7:c14c:0:b0:55c:c918:a076 with SMTP id
 r12-20020aa7c14c000000b0055cc918a076mr3175784edp.3.1706669710378; Tue, 30 Jan
 2024 18:55:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240130142521.18593-1-danielj@nvidia.com> <20240130095645-mutt-send-email-mst@kernel.org>
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org> <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org> <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 31 Jan 2024 10:54:33 +0800
Message-ID: <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
To: Daniel Jurgens <danielj@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, "abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 1:53=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com>=
 wrote:
>
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, January 30, 2024 9:53 AM
> > On Tue, Jan 30, 2024 at 03:50:29PM +0000, Daniel Jurgens wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, January 30, 2024 9:42 AM On Tue, Jan 30, 2024 at
> > > > 03:40:21PM +0000, Daniel Jurgens wrote:
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Tuesday, January 30, 2024 8:58 AM
> > > > > >
> > > > > > On Tue, Jan 30, 2024 at 08:25:21AM -0600, Daniel Jurgens wrote:
> > > > > > > Add a tx queue stop and wake counters, they are useful for
> > debugging.
> > > > > > >
> > > > > > >     $ ethtool -S ens5f2 | grep 'tx_stop\|tx_wake'
> > > > > > >     ...
> > > > > > >     tx_queue_1_tx_stop: 16726
> > > > > > >     tx_queue_1_tx_wake: 16726
> > > > > > >     ...
> > > > > > >     tx_queue_8_tx_stop: 1500110
> > > > > > >     tx_queue_8_tx_wake: 1500110
> > > > > > >
> > > > > > > Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> > > > > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > > >
> > > > > > Hmm isn't one always same as the other, except when queue is
> > stopped?
> > > > > > And when it is stopped you can see that in the status?
> > > > > > So how is having two useful?
> > > > >
> > > > > At idle the counters will be the same, unless a tx_timeout occurs=
.
> > > > > But
> > > > under load they can be monitored to see which queues are stopped an=
d
> > > > get an idea of how long they are stopped.
> > > >
> > > > how does it give you the idea of how long they are stopped?
> > >
> > > By serially monitoring the counter you can see stops that persist lon=
g
> > intervals that are less than the tx_timeout time.
> >
> > Why don't you monitor queue status directly?
>
> How? I don't know of any interface to check if a queue is stopped.
>
> >
> > > >
> > > > > Other net drivers (not all), also have the wake counter.
> > > >
> > > > Examples?
> > >
> > > [danielj@sw-mtx-051 upstream]$ ethtool -i ens2f1np1
> > > driver: mlx5_core
> > > version: 6.7.0+
> > > ...
> > > [danielj@sw-mtx-051 upstream]$ ethtool -S ens2f1np1 | grep wake
> > >      tx_queue_wake: 0
> > >      tx0_wake: 0
> >
[...]
> > Do they have a stop counter too?
>
> Yes:
> [danielj@sw-mtx-051 upstream]$ ethtool -S ens2f1np1 | grep 'stop\|wake'
>      tx_queue_stopped: 0
>      tx_queue_wake: 0
>      tx0_stopped: 0
>      tx0_wake: 0
>      ....

Yes, that's it! What I know is that only mlx drivers have those two
counters, but they are very useful when debugging some issues or
tracking some historical changes if we want to.

Thanks,
Jason

>
> >
> > > >
> > > > > In my opinion it makes the stop counter more useful, at little co=
st.
> > > > >
> > > > > >
> > > > > >
> > > > > > > ---
> > > > > > >  drivers/net/virtio_net.c | 26 ++++++++++++++++++++++++--
> > > > > > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/net/virtio_net.c
> > > > > > > b/drivers/net/virtio_net.c index 3cb8aa193884..7e3c31ceaf7e
> > > > > > > 100644
> > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > @@ -88,6 +88,8 @@ struct virtnet_sq_stats {
> > > > > > >     u64_stats_t xdp_tx_drops;
> > > > > > >     u64_stats_t kicks;
> > > > > > >     u64_stats_t tx_timeouts;
> > > > > > > +   u64_stats_t tx_stop;
> > > > > > > +   u64_stats_t tx_wake;
> > > > > > >  };
> > > > > > >
> > > > > > >  struct virtnet_rq_stats {
> > > > > > > @@ -112,6 +114,8 @@ static const struct virtnet_stat_desc
> > > > > > virtnet_sq_stats_desc[] =3D {
> > > > > > >     { "xdp_tx_drops",       VIRTNET_SQ_STAT(xdp_tx_drops) },
> > > > > > >     { "kicks",              VIRTNET_SQ_STAT(kicks) },
> > > > > > >     { "tx_timeouts",        VIRTNET_SQ_STAT(tx_timeouts) },
> > > > > > > +   { "tx_stop",            VIRTNET_SQ_STAT(tx_stop) },
> > > > > > > +   { "tx_wake",            VIRTNET_SQ_STAT(tx_wake) },
> > > > > > >  };
> > > > > > >
> > > > > > >  static const struct virtnet_stat_desc virtnet_rq_stats_desc[=
]
> > > > > > > =3D { @@
> > > > > > > -843,6 +847,9 @@ static void check_sq_full_and_disable(struct
> > > > > > > virtnet_info
> > > > > > *vi,
> > > > > > >      */
> > > > > > >     if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> > > > > > >             netif_stop_subqueue(dev, qnum);
> > > > > > > +           u64_stats_update_begin(&sq->stats.syncp);
> > > > > > > +           u64_stats_inc(&sq->stats.tx_stop);
> > > > > > > +           u64_stats_update_end(&sq->stats.syncp);
> > > > > > >             if (use_napi) {
> > > > > > >                     if
> > (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> > > > > > >                             virtqueue_napi_schedule(&sq->napi=
,
> > sq- vq);
> > > > @@ -851,6 +858,9
> > > > > > >@@  static void check_sq_full_and_disable(struct virtnet_info =
*vi,
> > > > > > >                     free_old_xmit_skbs(sq, false);
> > > > > > >                     if (sq->vq->num_free >=3D
> > 2+MAX_SKB_FRAGS) {
> > > > > > >                             netif_start_subqueue(dev, qnum);
> > > > > > > +                           u64_stats_update_begin(&sq-
> > >stats.syncp);
> > > > > > > +                           u64_stats_inc(&sq->stats.tx_wake)=
;
> > > > > > > +                           u64_stats_update_end(&sq-
> > >stats.syncp);
> > > > > > >                             virtqueue_disable_cb(sq->vq);
> > > > > > >                     }
> > > > > > >             }
> > > > > > > @@ -2163,8 +2173,14 @@ static void virtnet_poll_cleantx(struc=
t
> > > > > > receive_queue *rq)
> > > > > > >                     free_old_xmit_skbs(sq, true);
> > > > > > >             } while (unlikely(!virtqueue_enable_cb_delayed(sq=
-
> > >vq)));
> > > > > > >
> > > > > > > -           if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > > > > > > +           if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > > > > > > +                   if (netif_tx_queue_stopped(txq)) {
> > > > > > > +                           u64_stats_update_begin(&sq-
> > >stats.syncp);
> > > > > > > +                           u64_stats_inc(&sq->stats.tx_wake)=
;
> > > > > > > +                           u64_stats_update_end(&sq-
> > >stats.syncp);
> > > > > > > +                   }
> > > > > > >                     netif_tx_wake_queue(txq);
> > > > > > > +           }
> > > > > > >
> > > > > > >             __netif_tx_unlock(txq);
> > > > > > >     }
> > > > > > > @@ -2310,8 +2326,14 @@ static int virtnet_poll_tx(struct
> > > > > > > napi_struct
> > > > > > *napi, int budget)
> > > > > > >     virtqueue_disable_cb(sq->vq);
> > > > > > >     free_old_xmit_skbs(sq, true);
> > > > > > >
> > > > > > > -   if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS)
> > > > > > > +   if (sq->vq->num_free >=3D 2 + MAX_SKB_FRAGS) {
> > > > > > > +           if (netif_tx_queue_stopped(txq)) {
> > > > > > > +                   u64_stats_update_begin(&sq->stats.syncp);
> > > > > > > +                   u64_stats_inc(&sq->stats.tx_wake);
> > > > > > > +                   u64_stats_update_end(&sq->stats.syncp);
> > > > > > > +           }
> > > > > > >             netif_tx_wake_queue(txq);
> > > > > > > +   }
> > > > > > >
> > > > > > >     opaque =3D virtqueue_enable_cb_prepare(sq->vq);
> > > > > > >
> > > > > > > --
> > > > > > > 2.42.0
>
>
