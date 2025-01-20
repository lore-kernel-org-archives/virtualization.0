Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1669199BC
	for <virtualization@lists.linux.dev>; Mon, 20 Jan 2025 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737338313; cv=none; b=giwhx3biaqwZYSbWqKoH4YpCFp62ro6B2mmLAci/S60cC3EZq/i7DIo2AMJL1Gc4hD33jCvcHoQP80bwMF8h4pWZ4QkkDCIDARr8lPbmHUZbHh1GsNIihpe7+BkyCBbnqGFVTy4MeFg6zkdCMObWbWQ9me0S8woa+syyeQI9qC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737338313; c=relaxed/simple;
	bh=yuBc5+h/9lwzieCgUsFLqW7znh5vXegnrIKqqEjuQzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsZlk9VdUkQhpVNTPFoLtpOBEwsPTgGvyMc8WrA91iMmWu720iQ048H7cTX6gVt0VNmVb7xnrjSrupnFxFeZk/KP8pR3PWocNU5rcvXiqK6Y2pIjTrDgy4f5KQpJ5XS1PMl/SLJncd+kV6+EMisUpIpg5xLIMdZM4NVUACh+Huo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bwkqy579; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bwkqy579"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737338310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vs03IIGJhVXqCXgVeBmydwl5duKVva078mHRQk4T/Vo=;
	b=Bwkqy579ClzTSPWKoGeq+iyd4k+ME0Olb2DTXqWDwEabOBh2M+d7Tei3WlYFnLHY2gxP94
	fsH8HcMT49wMmto/Z8xh/y+jbq2+OkYlEJJ87gGy7Z9/mMxHv7FLST97KO80MOCSNMIMoe
	UXrWCOmVEwhJIuk/vWJdn87mjf9Se2A=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-z2_tsh9HPw6sUs6xudiPMA-1; Sun, 19 Jan 2025 20:58:27 -0500
X-MC-Unique: z2_tsh9HPw6sUs6xudiPMA-1
X-Mimecast-MFC-AGG-ID: z2_tsh9HPw6sUs6xudiPMA
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ef9864e006so11287737a91.2
        for <virtualization@lists.linux.dev>; Sun, 19 Jan 2025 17:58:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737338306; x=1737943106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vs03IIGJhVXqCXgVeBmydwl5duKVva078mHRQk4T/Vo=;
        b=AnRUMoFfNcXRqabX+kBJYlaUSpwkPmQklxyVX5FH/UDFle9CR7Cx4YI+eYoUA54WeU
         uelGeCOPYTuIauXaEKqi2Qb7H4YpKjpSq793oj+Un2clYmBIXqdjfhY6IyGjKsS+A4K4
         i/bfxgeq5r//q6gVJf7YdxtPEaL1WfbUj0JL150WZdzWt1mRLiTj+59bLrwGMbH1PWmv
         /rsLxTIeJhWTeUbi7EmOyyhKCOJGWK6KuCwJWeaY8GPJlhxkd7yeazkzxblwoIEptTdT
         Aj3K46pdAdVwKbckGxXotqXQDbkAf/L6Z3V8s+ax88UrJ9k34Aj59NbM/0XgQ/puHcGO
         9UYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8uGEHyHgQZek5pacWvEfpceIhUkJdHN0Yx2iQJg9NG8YwRuMtHlO0f3TOKw7dKiAZEcaW2NaxRn1W7glfZg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyi9c0zKnZX/tUYsncYJw+qBNMLtUMI7KvBqjZ7mxHQRMvB9Jl+
	rxAEkDQADyq9n0xyAfhNhlxQh2kmiokrNOKW58CKXT3/uKSHKjwCFnw+Abmo56r73cceGc9zEjp
	YASQ8JEc4pBMiqSVhbHUtvTMnSdH7Aimt6ztCwDcAuoUkXqh6OWMqFuoOijBIZmI/OsOB3Og8/T
	xp0LBh/+X9EkyV1I2H4FHVr86dzLmXBBQql+nqgRU=
X-Gm-Gg: ASbGncuMscc4JdClE2RCvPxApqXWhl/5iQ5GNzBo7Y+I3//pFF036z7jaLv0oC5qGHU
	Rc3qBxMtsS3sF/G1wqBv48XjiAGl3u9tgdoHWdOjYfEIzs+xU/WPB
X-Received: by 2002:a17:90b:2750:b0:2ee:aef4:2c5d with SMTP id 98e67ed59e1d1-2f782d32bdcmr14441679a91.26.1737338306237;
        Sun, 19 Jan 2025 17:58:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxcO+gcU6GGpItpVaST+mP+lotfH8ALDufTNkb6YlviJFAQ1S+ZPqhw8EXYw//ooixqAGk20ku9VsIkuS7U5A=
X-Received: by 2002:a17:90b:2750:b0:2ee:aef4:2c5d with SMTP id
 98e67ed59e1d1-2f782d32bdcmr14441654a91.26.1737338305832; Sun, 19 Jan 2025
 17:58:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250116055302.14308-1-jdamato@fastly.com> <20250116055302.14308-4-jdamato@fastly.com>
 <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1737013994.1861002-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 20 Jan 2025 09:58:13 +0800
X-Gm-Features: AbW1kvarckGogeshrcvCGai-_wdzjzim8Cy3XTbYBj63sr-Fx1KKQaClUhGQeVc
Message-ID: <CACGkMEtaaScVM8iuHP7oGBhwCAvcjQstmNoedc5UTtkEMLRDow@mail.gmail.com>
Subject: Re: [PATCH net-next v2 3/4] virtio_net: Map NAPIs to queues
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Joe Damato <jdamato@fastly.com>, gerhard@engleder-embedded.com, leiyang@redhat.com, 
	mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>, 
	"open list:XDP (eXpress Data Path):Keyword:(?:b|_)xdp(?:b|_)" <bpf@vger.kernel.org>, netdev@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tiB_KW_GR-i4bO3FPTRd1BjEp13lrxsa2uXvCkX17E0_1737338306
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 3:57=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 16 Jan 2025 05:52:58 +0000, Joe Damato <jdamato@fastly.com> wrote=
:
> > Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> > can be accessed by user apps.
> >
> > $ ethtool -i ens4 | grep driver
> > driver: virtio_net
> >
> > $ sudo ethtool -L ens4 combined 4
> >
> > $ ./tools/net/ynl/pyynl/cli.py \
> >        --spec Documentation/netlink/specs/netdev.yaml \
> >        --dump queue-get --json=3D'{"ifindex": 2}'
> > [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
> >  {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
> >  {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
> >  {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
> >  {'id': 0, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 1, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 2, 'ifindex': 2, 'type': 'tx'},
> >  {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> >
> > Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> > the lack of 'napi-id' in the above output is expected.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  v2:
> >    - Eliminate RTNL code paths using the API Jakub introduced in patch =
1
> >      of this v2.
> >    - Added virtnet_napi_disable to reduce code duplication as
> >      suggested by Jason Wang.
> >
> >  drivers/net/virtio_net.c | 34 +++++++++++++++++++++++++++++-----
> >  1 file changed, 29 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index cff18c66b54a..c6fda756dd07 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -2803,9 +2803,18 @@ static void virtnet_napi_do_enable(struct virtqu=
eue *vq,
> >       local_bh_enable();
> >  }
> >
> > -static void virtnet_napi_enable(struct virtqueue *vq, struct napi_stru=
ct *napi)
> > +static void virtnet_napi_enable(struct virtqueue *vq,
> > +                             struct napi_struct *napi)
> >  {
> > +     struct virtnet_info *vi =3D vq->vdev->priv;
> > +     int q =3D vq2rxq(vq);
> > +     u16 curr_qs;
> > +
> >       virtnet_napi_do_enable(vq, napi);
> > +
> > +     curr_qs =3D vi->curr_queue_pairs - vi->xdp_queue_pairs;
> > +     if (!vi->xdp_enabled || q < curr_qs)
> > +             netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, na=
pi);
>
> So what case the check of xdp_enabled is for?

+1 and I think the XDP related checks should be done by the caller not here=
.

>
> And I think we should merge this to last commit.
>
> Thanks.
>

Thanks

> >  }
> >
> >  static void virtnet_napi_tx_enable(struct virtnet_info *vi,
> > @@ -2826,6 +2835,20 @@ static void virtnet_napi_tx_enable(struct virtne=
t_info *vi,
> >       virtnet_napi_do_enable(vq, napi);
> >  }
> >
> > +static void virtnet_napi_disable(struct virtqueue *vq,
> > +                              struct napi_struct *napi)
> > +{
> > +     struct virtnet_info *vi =3D vq->vdev->priv;
> > +     int q =3D vq2rxq(vq);
> > +     u16 curr_qs;
> > +
> > +     curr_qs =3D vi->curr_queue_pairs - vi->xdp_queue_pairs;
> > +     if (!vi->xdp_enabled || q < curr_qs)
> > +             netif_queue_set_napi(vi->dev, q, NETDEV_QUEUE_TYPE_RX, NU=
LL);
> > +
> > +     napi_disable(napi);
> > +}
> > +
> >  static void virtnet_napi_tx_disable(struct napi_struct *napi)
> >  {
> >       if (napi->weight)
> > @@ -2842,7 +2865,8 @@ static void refill_work(struct work_struct *work)
> >       for (i =3D 0; i < vi->curr_queue_pairs; i++) {
> >               struct receive_queue *rq =3D &vi->rq[i];
> >
> > -             napi_disable(&rq->napi);
> > +             virtnet_napi_disable(rq->vq, &rq->napi);
> > +
> >               still_empty =3D !try_fill_recv(vi, rq, GFP_KERNEL);
> >               virtnet_napi_enable(rq->vq, &rq->napi);
> >
> > @@ -3042,7 +3066,7 @@ static int virtnet_poll(struct napi_struct *napi,=
 int budget)
> >  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp=
_index)
> >  {
> >       virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
> > -     napi_disable(&vi->rq[qp_index].napi);
> > +     virtnet_napi_disable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi)=
;
> >       xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
> >  }
> >
> > @@ -3313,7 +3337,7 @@ static void virtnet_rx_pause(struct virtnet_info =
*vi, struct receive_queue *rq)
> >       bool running =3D netif_running(vi->dev);
> >
> >       if (running) {
> > -             napi_disable(&rq->napi);
> > +             virtnet_napi_disable(rq->vq, &rq->napi);
> >               virtnet_cancel_dim(vi, &rq->dim);
> >       }
> >  }
> > @@ -5932,7 +5956,7 @@ static int virtnet_xdp_set(struct net_device *dev=
, struct bpf_prog *prog,
> >       /* Make sure NAPI is not using any XDP TX queues for RX. */
> >       if (netif_running(dev)) {
> >               for (i =3D 0; i < vi->max_queue_pairs; i++) {
> > -                     napi_disable(&vi->rq[i].napi);
> > +                     virtnet_napi_disable(vi->rq[i].vq, &vi->rq[i].nap=
i);
> >                       virtnet_napi_tx_disable(&vi->sq[i].napi);
> >               }
> >       }
> > --
> > 2.25.1
> >
>

